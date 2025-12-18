Return-Path: <linux-kselftest+bounces-47706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8BFCCBC58
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 13:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72E8B305885C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 12:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461CD32ED33;
	Thu, 18 Dec 2025 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GEOah9fQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573E332E694
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Dec 2025 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766060451; cv=none; b=Uk+Kc28c9tCmL3RJBLF8lfp1EAvf707Ohb5bF26cnRxHyy8E6URKQa23/8AhaDygDAfTJNjI57MclNxoj0+ykEE5knGg0nekN1ryX+NYinx7ZZFtPYs/tQnoWP97rglL6TKel7C8YTPmTxhaS0g1zyOyjpJ7aBGv/VaQPm1/wxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766060451; c=relaxed/simple;
	bh=eqWfnJs5Nkyp4m7IyP9pYSN9uMnPtwxT8RsY0+GP4VY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E1nOaqjnrUyqinZ/GPdv23Rr5jjfU09hIpfUykM8lsKLdg46oDpbUFe1VPPVAHFYpZ0Msb6Pvq3bnu4Zi28AQ8CCB4eHlo32n6OU+kPsGtHkhnXb9lXcovAGuOv8oPhYF7QJ43KuCyUKFiiqLZ2UdOtfMGY5ZrKS2JIFMIwmqi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GEOah9fQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so5753175e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Dec 2025 04:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766060447; x=1766665247; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wuu/9levDPlYSlKVd9Fur7NXuw0gR2L70X+lgum0qic=;
        b=GEOah9fQx6tCczsjmnsRvH6Sq1zevyhdQHPIoQe+H8kMRlbcY4y55Xcm4vvn52vBGJ
         gP74aoZWWtqVtUOTNZa+qzhzWguRX0AuvVy1g4gr9lioyU7sgfmLUT3kVdKEHgI8NfM0
         fCk41sm5nK3XTn734u9Xv3EzQhLVX0YUh702ftfx1h5iF+tPRM1NxG2cd1UmN46oJ/nv
         TAiYRFeoqrD81IRNNpAz8JI3rO9tJjBImLtlaIBQu8vXi8vKVLKgdt7rrzoGlJ7xK95C
         laf3vCVN3HyVhmI4AAAPjxGJ4r9h3orVi+i77x3oqJFq2CQSwmCCrt+ZWQYefIefBJLW
         vB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766060447; x=1766665247;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuu/9levDPlYSlKVd9Fur7NXuw0gR2L70X+lgum0qic=;
        b=DpxwwiWxlznoA+2s1nYQljKW50J0b2fOjo31qXcvNUgf+tjjEeCtUvNIP2HnAAQpJU
         mh8B3Gzyl6h8Cyb2i+YNMkgx8CeOxAF2iRyzWZbNLnIgHVFIL72K48TTL43K20NVQJqW
         TN/OMdSz2S1x+nrWQ+UDNJNoEGUaYMAGjr7JnQUOeiJNd71oQVW/0uk+H7CIRLq/wFne
         dtW1q7Ya2uR6TtJucM2w/7mcOUKVb/mvADoUhUUuR0F0sYGJeiR4u6uN3CywTxHSZ1fe
         +suOBl1GrVejqU6yME/PGyI75zGw2FljrNBK6Dnn52a/Bnm2rH5KkLd8+4CjqiE3IaMG
         sqSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyRgFY3s9I+TcD6KrJ5Ns4nfncf3apvHXr7aZYrurkqGX06rbKqPWX0rm3CaQoCz+MpUjG7in5q3m1IUJ6RYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUbVq7L0z9kuto93b0FJ+8Qwi3xaU7049VSbVTb6wE1Lz47ZVl
	u2lWrjTB0ttGfN9DaYt1Fzczq6CPqsOBw9AypRgfqta6t8XRV/Hq9jAWIkeblEot6Eg=
X-Gm-Gg: AY/fxX5TDSqOwrGuyD9AyvIXDf92ays/PF8S3dWsBUkb0R6kzQkea19GZ2GMt4pSrI0
	ipZhHwpDOd9xcHZ0IxQ9P1GtdsAPv3ZEOvb8NBTsSY0Zfs2vqPC5I/9j92GAE/dGoDslLUpL+AU
	r/jKPxZpPQ2JHZ63wGboxgPhVyI8LZnScE2H6uVCnUY4e2DvtArLyInS5s/ND+QybvGkr5QdziA
	F2Y0M40qb6saqWaZywumq/Jsq4vGuzLIaqtPfhs3Q0/vDrRSAbfgT6pKB6HHw6suppMvmGh7X4O
	CUUGl0yK0OxZacJ+QHaegra0WR1wnvtG9fKjb6IL53AmOoh+dMrw3X48HrjIN60Caa2OYKMyxO+
	V3VDwvqnfzRlxR7a3SPeNoFahBGbG807sCJwYXmIY5bKEvx4p+Btq7RqDNJEGhG2RPcNP4EvjvI
	PUAnJ4O48I
X-Google-Smtp-Source: AGHT+IEr/bRmp5KcFfglYPWmyPlODyDNlJSQrqglf/bIH/Z29sdsWPV0Yl2SsVXM067fiAB8ptvMVw==
X-Received: by 2002:a05:600c:8119:b0:477:98f7:2aec with SMTP id 5b1f17b1804b1-47a8f8a7170mr204341295e9.3.1766060446631;
        Thu, 18 Dec 2025 04:20:46 -0800 (PST)
Received: from localhost ([177.94.145.206])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d1926bbbsm23985425ad.84.2025.12.18.04.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 04:20:46 -0800 (PST)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Date: Thu, 18 Dec 2025 09:20:38 -0300
Subject: [PATCH] selftests: net: fib-onlink-tests: Set high metric for
 default IPv6 route
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251218-rbm-selftests-net-fib-onlink-v1-1-96302a5555c3@suse.com>
X-B4-Tracking: v=1; b=H4sIAJXxQ2kC/x3MwQ6CMAwA0F8hPduETdTFXzEcNuikEYppF2NC+
 HeHx3d5Gxgpk8G92UDpw8arVLhTA8MU5UnIYzX41l+cdwE1LWg050JWDIUKZk64yszywnA7x7F
 1dA2hg1q8lTJ///2jr07RCJNGGaYjXaIVUtj3H7stk+GHAAAA
X-Change-ID: 20251218-rbm-selftests-net-fib-onlink-873ad01e6884
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1766060438; l=1249;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=eqWfnJs5Nkyp4m7IyP9pYSN9uMnPtwxT8RsY0+GP4VY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPIVTvi1oLN0+E1MRxeTxkrwrHq7Xr8Kao+vd5IEiitItPC9ZFQi3BWwYS3/2bE+X96wdK8Hgvj
 RdKAgndcd3w4=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Currently, the test breaks if the SUT already has a default route
configured for IPv6. Fix by adding "metric 9999" to the `ip -6 ro add`
command, so that multiple default routes can coexist.

Fixes: 4ed591c8ab44 ("net/ipv6: Allow onlink routes to have a device mismatch if it is the default route")
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/net/fib-onlink-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib-onlink-tests.sh b/tools/testing/selftests/net/fib-onlink-tests.sh
index ec2d6ceb1f08..acf6b0617373 100755
--- a/tools/testing/selftests/net/fib-onlink-tests.sh
+++ b/tools/testing/selftests/net/fib-onlink-tests.sh
@@ -207,7 +207,7 @@ setup()
 		ip -netns ${PEER_NS} addr add ${V6ADDRS[p${n}]}/64 dev ${NETIFS[p${n}]} nodad
 	done
 
-	ip -6 ro add default via ${V6ADDRS[p3]/::[0-9]/::64}
+	ip -6 ro add default via ${V6ADDRS[p3]/::[0-9]/::64} metric 9999
 	ip -6 ro add table ${VRF_TABLE} default via ${V6ADDRS[p7]/::[0-9]/::64}
 
 	set +e

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251218-rbm-selftests-net-fib-onlink-873ad01e6884

Best regards,
-- 
Ricardo B. Marlière <rbm@suse.com>


