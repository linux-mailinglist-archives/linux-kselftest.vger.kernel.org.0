Return-Path: <linux-kselftest+bounces-38981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6723EB26A48
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 17:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2FC4AA22E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 14:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D078202C48;
	Thu, 14 Aug 2025 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7VBe2Eu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933521F9F7A;
	Thu, 14 Aug 2025 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183004; cv=none; b=LiiPeIMZNYBC3a29okjXc4L2NoSOUugVJK26R1UJUjQCkIpOHWtHDd8MSbudBGG4JDr7AZlPuGDSJpTwTwXPvg4Dz7mu4ZHf1C1PErDD4wzNYW0vq3Mq2o3atqrMH6A1WtkRH8Ii6D3sxNakWN+70gEyNgsoZEeywmAWCS3sMqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183004; c=relaxed/simple;
	bh=/axWMk9uhm1ZdfUfbj/8KGnGVoYfA5qdAmKGDGQr6gM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YvyqTB3de4a7/uZkBNQ5tvVX4UHqE+IMYro6HX0bU3mo9CWiU7k2fCeFzUZSXMGmxh2v2QizDD68lFB5mjxTdwEp9DBMKGmt802ewS85gfGOb5s+WeZA26v6njXtyEmheZ0yU3PJ8CF7DG2PZiYUG/I7vsBB9gmEH0aQ+CJi0+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7VBe2Eu; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2eb6d07bso1097074b3a.3;
        Thu, 14 Aug 2025 07:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755183003; x=1755787803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EiGNQqMO9h967QGrm5aTrwhMppzluhyJ6Y8QYxAY+/s=;
        b=C7VBe2EuoJmTIdhOsBmHiNhh8NnofuJujfHOjakCeY+k4WrdkEPA/0GQ4a3UlBSeg6
         dgUVzSyjMVmW2nCUDCHcVrf+N6UV4ENVCX/uLvkJK009zIMShNrpwz4C1CJn1oaivRkV
         GET+I7iDquQUE30U6quNEJ68zXHpSFyx/ZZYrDYqWpzx/9V78kusBiXFzuIHGdY5P8Ok
         V1dSh5oJ//9oyvDQKCvuv/G3fPHa0mrhKS/OQiwe8P6P6azAWwxkhQMlWgZR6qZmGgHp
         wpeCU5hYvn26rAmrtGJQWJg8+eWOheTb2ujQjaQSa1CeGD+iqLxo9bZSsc7Qqu7pGh0D
         99pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755183003; x=1755787803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EiGNQqMO9h967QGrm5aTrwhMppzluhyJ6Y8QYxAY+/s=;
        b=jIQq2bBnNhkY6JNe5tgY9vzcum2VhAdOJNxsd77xfO9jHV7KukBh1EaG1tgbrkh3px
         DMRIKs+WeHcr2bHqOGcwwwtAHHwX24qMMihMj0pVH9CbnVR4aXe1/lfm3eINLzlR7spm
         kDGoSNZjKqR3xW15/m5r6T3YewSwsmjN9bue+s1aB+uC4U0b56ztwt5sfrV5MlD2EUAl
         katt0OpdzyMtPtYXCPT+pJQbcRrVXThfVv3EQZEg5hSroZ71L4UHbfbQ1q+8MdxlxVVe
         GMtbmrsj7D/DkD7uGI5fg6H020QgeV6NIwJElNHOwPtGsP+3Gpd0p1Q0n7STRFmj/tBj
         8LPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNRFkPTpjJVukXAdF1dzzzHaKU0d9xsOqu4i82zT+qQxOLMjMcxK/H4Dfp2nugdiR+5dQrt9PG@vger.kernel.org, AJvYcCWfj3ljTLjIxlWgMnpOfTX/e7fhbQrMysGllrz0qTsC3dWc9mjF45Qbl8AIj8mQlx6Sf/UzDcEgoe85MlU=@vger.kernel.org, AJvYcCWuPNHu4kyTOas1O0UJFVWq2MOwuME/kDtZIJi7DoCoCv59LVOXgZXddRgtm1TV2YhNwpclKuBZv+4yh9lyOMVC@vger.kernel.org
X-Gm-Message-State: AOJu0YyTVABbu1moI42eKaz3FyUcaYw3vcGXkVlQC+oa/DL/RQyFdY/b
	TvedrSK01VZPDNXiTVsQlwyAiPIhirrX6fRuDIYkWg7vea0cHKYNjBDk
X-Gm-Gg: ASbGnctb4Vd4Ic56Go0z3q8QT9iEQLqeyaJgDcoWWLMlNLIRo1LtrHitl4GQsPtFQaw
	m+PoXQrYRGNinj1DQkT4trVYOlEFuTW8vt7M/tlyK6NAMAOi4xsTd6Wdicz1Iz9gGnB1zAhmow/
	4Je9e1gCI+TYeUzU3I04SEJdfmODEOFuVP6sOZyBvmN8/KsIAc3lIqFbuiEKZUKyoeWVOtr4SOu
	Y0GBo17+D4YxxA1MCvuxQ7cpV9Xiy+E+YJPq+t9g7vY9dP+D48KHW9Xk4UrlhMlG4un6Yoopt60
	n7+Mk7pSj8Osf7TMMDYd896dxS9q3MwEayau9qFCQ70KmOtfmfo0epYJiwwIjyjCVDkIMEDV1HI
	/s3UvDtp9gTcdgcOXfKCPoLn8xy26pvdtAA==
X-Google-Smtp-Source: AGHT+IEdzkV+CLZH6cOjPdRoNZpBVJROikuNEjsteCsJY+iEdrQMZCNWUmg6yND82tvTwvCnt7A8Yw==
X-Received: by 2002:a05:6a00:6f03:b0:76e:3a11:d24f with SMTP id d2e1a72fcca58-76e3a11d959mr1757940b3a.15.1755183002365;
        Thu, 14 Aug 2025 07:50:02 -0700 (PDT)
Received: from archlinux ([36.255.84.59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8fa33sm35117359b3a.43.2025.08.14.07.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 07:50:01 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	shuah@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH] print: fix spelling error in message
Date: Thu, 14 Aug 2025 20:19:16 +0530
Message-ID: <20250814144916.338054-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---
 tools/testing/selftests/net/openvswitch/ovs-dpctl.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 8a0396bfa..b521e0dea 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -1877,7 +1877,7 @@ class OvsPacket(GenericNetlinkSocket):
                     elif msg["cmd"] == OvsPacket.OVS_PACKET_CMD_EXECUTE:
                         up.execute(msg)
                     else:
-                        print("Unkonwn cmd: %d" % msg["cmd"])
+                        print("Unknown cmd: %d" % msg["cmd"])
             except NetlinkError as ne:
                 raise ne
 
-- 
2.50.1


