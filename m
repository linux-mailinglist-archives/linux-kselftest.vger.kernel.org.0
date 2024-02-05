Return-Path: <linux-kselftest+bounces-4139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C428E849A3A
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 13:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029D21C22A40
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 12:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255CA1CABA;
	Mon,  5 Feb 2024 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cneQkTkz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7601C2B2;
	Mon,  5 Feb 2024 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136180; cv=none; b=U1gOP2nvb8jVURPr/rcEGFrTaKIzvfy31EQamHnMuX4jNVaFeRMnkerS5ZjCocRKWKnDJK7AbJlVmxeNcnfzE1UGa4ceKfaYsiIoUdEP7gFW4ot5oscp463f96o6+TBxnp++uvqpUm/WiWeslyI0HDmC/bZBiiZEjOiGyFj8oy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136180; c=relaxed/simple;
	bh=zjQbb33QAX1T1JAhEwYPnm/SGkqzEpXW1ZbAKpPauBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DYTgxjt0y6rP0uqb+gZ6Tothta56UR7/RmXEOXwV//vx3aKskyvn+XhjwJLXzMvG5JKEdsYrg0fU21s74gsmN1ZFtSyQqY0vxSOMN4T73nMeC1Lgc0Dzh4+V47vOX5q90v7JV1jrFW7cEpoQaw1VJ8uX0ww8BmLca+yh2G0jb5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cneQkTkz; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707136170; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=0Ich9Lv7jUlR8bH4jRV52p8JlrleP6AcmyrMMLywpAs=;
	b=cneQkTkzxeFpVP74/kCjY32D8vDbzjo2nOSyx3sc9dsNN7xCembIzc+wQ5IPRV3oJbsieo2pdx13+xEfG0GpM4Ld05476cZudvXVXh/477dpc7i0ECKQuHgViXRJIDa1dyrw2KBQZugDFWCIHdX6VPcu7t2VmOqCUxqx8C6W3OA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W0AVhQO_1707136168;
Received: from localhost.localdomain(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0W0AVhQO_1707136168)
          by smtp.aliyun-inc.com;
          Mon, 05 Feb 2024 20:29:29 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: keescook@chromium.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	shuah@kernel.org,
	corbet@lwn.net
Cc: xlpang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yuanhe Shu <xiangzao@linux.alibaba.com>
Subject: [PATCH 2/3] Documentation: adjust pstore backend related document
Date: Mon,  5 Feb 2024 20:28:51 +0800
Message-Id: <20240205122852.7069-3-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240205122852.7069-1-xiangzao@linux.alibaba.com>
References: <20240205122852.7069-1-xiangzao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pstore now supports multiple backends, adjust related document.

Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
---
 Documentation/ABI/testing/pstore                | 8 ++++----
 Documentation/admin-guide/kernel-parameters.txt | 4 +++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/pstore b/Documentation/ABI/testing/pstore
index d3cff4a7ee10..2cd67b502f11 100644
--- a/Documentation/ABI/testing/pstore
+++ b/Documentation/ABI/testing/pstore
@@ -41,7 +41,7 @@ Description:	Generic interface to platform dependent persistent storage.
 		persistent storage until at least this amount is reached.
 		Default is 10 Kbytes.
 
-		Pstore only supports one backend at a time. If multiple
-		backends are available, the preferred backend may be
-		set by passing the pstore.backend= argument to the kernel at
-		boot time.
+		Pstore now supports multiple backends at a time. If multiple
+		backends are available, the registrable backends may be
+		set by passing the pstore.backend= argument1, argument2...
+		or pstore.backend= all to the kernel at boot time.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31b3a25680d0..a8a109b822a9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4748,7 +4748,9 @@
 			[HW,MOUSE] Controls Logitech smartscroll autorepeat.
 			0 = disabled, 1 = enabled (default).
 
-	pstore.backend=	Specify the name of the pstore backend to use
+	pstore.backend=backend1,...,backendN
+			Specify the names of the pstore backends to use
+			or =all for all available backends
 
 	pti=		[X86-64] Control Page Table Isolation of user and
 			kernel address spaces.  Disabling this feature
-- 
2.39.3


