Return-Path: <linux-kselftest+bounces-26751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B10A37924
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 01:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567D5166C39
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 00:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5B0610B;
	Mon, 17 Feb 2025 00:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T06On/O1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738A77E1;
	Mon, 17 Feb 2025 00:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739751311; cv=none; b=pITc2OZSeeJ6HrEVCHa93stQbqF881osj8M/4sHKSpdTd6sVwrsW4nGnFr4wdl2KLacuezY8RpcnpzxGSQ80Liah+WofJzBZLORkMxefutcoYEHh9jKYQLWWblkIDLUTeooODiXzWy8dgNRf2RD3osmZxhRHodvDIQRLI+wZiFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739751311; c=relaxed/simple;
	bh=qYMV2ZvPOOQ1i4HZ7Hj50NCQSQmHDQ0fRzzPgQ7dF4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T6GkfFzWGlnRTQd2+Dqr1ddgJXtYJc+YzQtehb1qVDArxHKz60B7tx+LbMICHEaA61UU01br61vLMcC5I/8SDMsKNUcuEUxb93y7TRTm3ZCnJ1hStlHVLqwOCyzP2n9BmN0hSZb5muGyXTr/N7QCRO3LzfKNXhgn5F51Wi/nRWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T06On/O1; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ef9b8b4f13so32618267b3.2;
        Sun, 16 Feb 2025 16:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739751309; x=1740356109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KliuYWTy5fHmrSLbuJtksd9qAx3y57Psdagf2PMtLNY=;
        b=T06On/O19J5rO/MbH9JXHiTfYOPXelfPNVk4ImGWKOaPTJJHDNBXWetJzZq0qF2xSb
         6RIKwvX5FwHVVuRVs4oUBQW7NfpH/u7fIChI5PCedo1YIdgY5b1qrHNxpd+upl84laYA
         zi9GKBSPX85nig50PETpZViLuJQ6zYWcPbzbcmASwCSBlBOdCbFtKBfd0QXLOI61+OmT
         7h1BcJTiGXYKlXp4HvnvEpbdqodtaIB+UxU5+jLjl9PkiOOq2tmy4FJeKPZsPpHrX95O
         AnKvzbEzzRF47Bnudf26bK0iRuxp2o5NtWEsWj6zHzB2bJRtnCz2HNVat7B4AnmqS4FR
         J9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739751309; x=1740356109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KliuYWTy5fHmrSLbuJtksd9qAx3y57Psdagf2PMtLNY=;
        b=ATB9HqMXWSOGmm3iXXdXdWXeXl0npR34lvnJgW9/6zvfW21zV4T2EgGsRKAxTth3wR
         VatTU1m6pj623kXeorZw21dAFkKPvsl4mAX+BZJPahpAyDitjwU5oosvIJrgdDLuIgJM
         r4tJkhD1UWHjB+ID+CBxsTHmWev4hlMtdvMGe4jXdJKZc9t3O9afAfz0r48OMP/jPPH2
         7BNAwOJzryX1oBP7S3OGdufCytHlhPz5HXhA9caLRLXxW6xCY5cW8sybaDkVEWFQvmfa
         YoRcKJplxkPLh6usieJSO+OSOhI5pSdjDMqN7E+tasrHmbushm0HXxK84jH1XbMMtoz6
         ouMA==
X-Forwarded-Encrypted: i=1; AJvYcCUek8Cq1rSai/1W3LHN6YyPY8dvFsOrLzcLTi5jhYALeFMEw2SC6PTWagkBgZcghTCpHoHb0enoGMHjBwcTxX0b@vger.kernel.org, AJvYcCVk9fxUVlX3T9KQljNR86QkAr8ockFnHwBQTDpHLryHjcDBE+fsOPLNRkubCHonn3OmaXZQFXl5OnC/KvJO0Uw=@vger.kernel.org, AJvYcCXY+eDnI39T8vbiE4L9DoZYR2/iCxoFYXYtH9zXVI5Oqa4t+sI0JfuLtNoQunmePXbN4KjWbnaI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4+EOxtwaDh3mYg8cAd3Z2d19n/XYC8ekzEwV8NYtN/LySWrQG
	lN+vuj2FLLWCmROsHT+MkQE/qWMvcLrnWBKC51R/jzATX3tEhj3D
X-Gm-Gg: ASbGncus/CzP/TbhNGrHVhPqSujwRaI9En9oZYfaUWBnN+VkDRhwn3CJSsjCSvQmcnK
	3Kurvn04sAl5aGZPwprWic57D62kOBLTl1gONTlVTR6Kr5hz4fQEJlb58teXzfAEyKTWSRjh6Ud
	TSxdDY4EcezRfNlsRt+Ty+Wx2G6Ro+ywP/xRTnTU8I6MwnmSfi92kx5KDdztrLjaOxjz0mHazZp
	K2kHMk/Yv/8IWw5Db5nkSCv9RKIQBvD1ShXat3T9tTh9QGBDn2tRjkheqvY6o0i5L5YU52cjGMe
	MHm0N2F6o9MdS/1A
X-Google-Smtp-Source: AGHT+IHbQZVUG3MMQr8+UQELHnaR0LEb5NGnJI/JDwskOCdeJ1/A9SAvdthvgTeCrHkzvYOlYs/tOA==
X-Received: by 2002:a05:690c:74c2:b0:6f9:ad48:a3c7 with SMTP id 00721157ae682-6fb582bb260mr60893877b3.21.1739751309357;
        Sun, 16 Feb 2025 16:15:09 -0800 (PST)
Received: from velo.. ([152.203.197.137])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb3619cabcsm18413577b3.74.2025.02.16.16.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 16:15:09 -0800 (PST)
From: Andres Urian Florez <andres.emb.sys@gmail.com>
To: pablo@netfilter.org,
	kadlec@netfilter.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	skhan@linuxfoundation.org
Cc: Andres Urian Florez <andres.emb.sys@gmail.com>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH net-next] selftest:net: fixed spelling mistakes
Date: Sun, 16 Feb 2025 19:14:50 -0500
Message-ID: <20250217001452.29578-1-andres.emb.sys@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed spelling errors in test_redirect6() error message and
test_port_shadowing() comments

Signed-off-by: Andres Urian Florez <andres.emb.sys@gmail.com>
---
 tools/testing/selftests/net/netfilter/nft_nat.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/nft_nat.sh b/tools/testing/selftests/net/netfilter/nft_nat.sh
index 9e39de26455f..8143b877ae7d 100755
--- a/tools/testing/selftests/net/netfilter/nft_nat.sh
+++ b/tools/testing/selftests/net/netfilter/nft_nat.sh
@@ -569,7 +569,7 @@ test_redirect6()
 	ip netns exec "$ns0" sysctl net.ipv6.conf.all.forwarding=1 > /dev/null
 
 	if ! ip netns exec "$ns2" ping -q -c 1 dead:1::99 > /dev/null;then
-		echo "ERROR: cannnot ping $ns1 from $ns2 via ipv6"
+		echo "ERROR: cannot ping $ns1 from $ns2 via ipv6"
 		lret=1
 	fi
 
@@ -859,7 +859,7 @@ EOF
 	# from router:service bypass connection tracking.
 	test_port_shadow_notrack "$family"
 
-	# test nat based mitigation: fowarded packets coming from service port
+	# test nat based mitigation: forwarded packets coming from service port
 	# are masqueraded with random highport.
 	test_port_shadow_pat "$family"
 
-- 
2.43.0


