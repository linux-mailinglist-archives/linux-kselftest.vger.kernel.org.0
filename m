Return-Path: <linux-kselftest+bounces-27051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED613A3D3C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 09:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBBC3B041D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 08:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C591EB9ED;
	Thu, 20 Feb 2025 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7miysCn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA72B1B3927;
	Thu, 20 Feb 2025 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041618; cv=none; b=Gph3BpV4Hp2XsZEd8cgTFOUkA7ECOKyI17jXhp6C3JMLe1y4QIpJudKzeLozHo4axHELNc/aaYVMKYOROig8BsfV2gUusIIMxWK2CBr3WIHgbAcDFN0kUmzjjuP+KKEQecvrA66W9YbHxAj81H66ZaAGH7UvT1i2mCKkxo5C3bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041618; c=relaxed/simple;
	bh=CKd1RSPFZQkAKMI3dxLP51Ya2IgDoPItjtdtFpPmU5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rL4NfSy74xOVSUCSXpSWTJWYc72tTEHIRlLMP6qigQzXvxmiLk4H/WfvyiIYA3aofizQUmL6XQrjLKhg5Kuw9VY806cjJm9AVBmCLLXY2kqbyadhqnOoPPqyzKg7eb9YvhICSzdWG66DklQ+bq+2Ylc02yztyrloLeHGsFEgojk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7miysCn; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fc737aeeb1so1078209a91.3;
        Thu, 20 Feb 2025 00:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740041616; x=1740646416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VUznGfWSGSnKMqCcufhDDY3auUVHhy1SyQHVAn9T6dg=;
        b=l7miysCnE6aiRmVHPgSiD6TCJWxe8F0c645otmb0iE4tZrsFiHamHHjhbhFGRzZq4U
         gHMGdt5Htvl/abpUhZLTj3RRXSaZylHyNl78DfJgM30OJCDKx/sbsdU2feJb3t5GQDJW
         alWxxoqEGJVgmqOTPv+UwydDMMiAslOb7G0p8We2vyfrgwXGIr7lLE1wfRjtS5C6vubh
         8h0A/LG3PQe8oin4eShtJbepDkTGTj1RBOzlru2NNPLOqNxxm4IDNOIrvrCydE4lR+DQ
         0Mf8gA/lCFcuo6SR0/Pz2gL0YpSK3xGbqOo7WElDBFrbjt8dpyYCgfyeleLZfOcxqSLu
         5xDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740041616; x=1740646416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUznGfWSGSnKMqCcufhDDY3auUVHhy1SyQHVAn9T6dg=;
        b=L7+EKYzJ56xaqlZEt7lJ6w5nBXEykw0VNdiHTlGFANd+thmxKQJj1cEmPlviPFrMR4
         ftmFU6c6rPyCeAAU8Wbol/KmaMqQo82Rj2IUoMYbD5S+/3WYgIYerwK11OdSbAgk4VPq
         KAlCFrsvp2WC9x/RvJ30qEyK52vmx28kZbXJYk9EV8C37ynHQQVgmG/cMezCEo3M3rVG
         nudQv40XdGhKFuTm6IUap/JdDlePp5SwtAFB1Boc3tzC7u6DSHcXSloYRQKPGCKGSb2A
         iRtomH32lzNU0ykZAlwy3GU4nIBYC9ImJQRbgBJIqdfpdsf3EwiWeV1vVglkYw1/Kxhk
         NL+A==
X-Forwarded-Encrypted: i=1; AJvYcCUhVAw9qnjbNXjN66x5GrpFC4HtuK2uU71+VsR/LwlQHk0dytdAHBcWcO5+LC6azBwGIkomQFcHCUGIDgw=@vger.kernel.org, AJvYcCWXshNUAW9Pv3+I+y7qcPe5b5aMoAhn3CwavK9HhKyX+d8BjindgXGHQBCIzoVeSqkDf/HftQleozBDkTZDsMJf@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+tEaI3AmEfm1IKSzfKJLIL0g1/5gRQVrANPFrBV/In4UEavlZ
	sqDDrzPIh5LaoWofYLUtIsL8zSbob6T4cP6TeJzrLfMoXQ0qu6A35BvROTwwSdimAA==
X-Gm-Gg: ASbGncvYjrmfSsAk7p4OXUZR9SlVMafUVsMGcFoJgQscABRiqCGo+Vb4g+eOdVzNqmm
	NJn6oKbNBCv356BfRSLF05+ZEMGCyXc8EsIZQNOZQ3qUZRDJ4B5dwpCZBE8Qbj9mhLLkXLKOza3
	GFjOdTwguy+8Q0CiPxsVlmzftxSmGMVEk059yh76APJ7mQkoWnv6UvEp0lSwDxwJBXthBJ4aAQd
	lq47ouq7OXt+KIxT3qCR5gwZe66vpvXrrVP9N60CNsGllPnrlWV2aqZI1qzHbAtz/dCKjXF0hXg
	Z661xCxoOg4gQD4BTiFQSV+LNhXmvzaSyI8=
X-Google-Smtp-Source: AGHT+IGhTe6ANbx8CHLp684LDpEjGaQNlD0Vkp4hgf5ImLj96gHc3v0iCa0OrPaQErPoJ8+2GCfk1w==
X-Received: by 2002:a17:90b:1b06:b0:2ea:2a8d:dd2a with SMTP id 98e67ed59e1d1-2fcb5a996cdmr10592092a91.27.1740041615709;
        Thu, 20 Feb 2025 00:53:35 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ac0a84sm13414908a91.16.2025.02.20.00.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:53:35 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next] selftests: fib_nexthops: do not mark skipped tests as failed
Date: Thu, 20 Feb 2025 08:53:26 +0000
Message-ID: <20250220085326.1512814-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current test marks all unexpected return values as failed and sets ret
to 1. If a test is skipped, the entire test also returns 1, incorrectly
indicating failure.

To fix this, add a skipped variable and set ret to 4 if it was previously
0. Otherwise, keep ret set to 1.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/fib_nexthops.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index 77c83d9508d3..6a58e23e1588 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -76,11 +76,13 @@ log_test()
 		printf "TEST: %-60s  [ OK ]\n" "${msg}"
 		nsuccess=$((nsuccess+1))
 	else
-		ret=1
-		nfail=$((nfail+1))
 		if [[ $rc -eq $ksft_skip ]]; then
+			[[ $ret -eq 0 ]] && ret=$ksft_skip
+			nskip=$((nskip+1))
 			printf "TEST: %-60s  [SKIP]\n" "${msg}"
 		else
+			ret=1
+			nfail=$((nfail+1))
 			printf "TEST: %-60s  [FAIL]\n" "${msg}"
 		fi
 
@@ -2528,6 +2530,7 @@ done
 if [ "$TESTS" != "none" ]; then
 	printf "\nTests passed: %3d\n" ${nsuccess}
 	printf "Tests failed: %3d\n"   ${nfail}
+	printf "Tests skipped: %2d\n"  ${nskip}
 fi
 
 exit $ret
-- 
2.46.0


