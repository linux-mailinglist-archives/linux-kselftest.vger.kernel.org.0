Return-Path: <linux-kselftest+bounces-4209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 474FD84C26D
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 03:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0335D286E7B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 02:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF42BDDD4;
	Wed,  7 Feb 2024 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bXe63CSp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F3E10A0D;
	Wed,  7 Feb 2024 02:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707272404; cv=none; b=opWfevqQCjFBuys6g+TVwWjdguJ37uW0dGoQx+6UPp/PdJDkbs2Q5/bk/QZlvBalhMPZm3718+OaYgnmudcbCcXRqLxj/Whlh/0DeoCsI/TmMFFoynY86hXlNvs3LKW7jAPSGrWtSOf/dlKQRz/SnWhqxmOr0kaDUa1a91rRJ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707272404; c=relaxed/simple;
	bh=zjQbb33QAX1T1JAhEwYPnm/SGkqzEpXW1ZbAKpPauBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z3rzfjio2HnhskfjvTk/Wh0VxHOGHCbcpzzEgHoCM9r/t8KxxJaZ0dZ3hn1SzILKt28MX5WBDr6DGFTjDpBiscgun0vblNe6UZGrBIhdUmennBRzDG7l31nw6LHnMHw//wR7mnGhK3yyyCHuW91HUehkz2uZnH4r63cZuSJZo4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bXe63CSp; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707272393; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=0Ich9Lv7jUlR8bH4jRV52p8JlrleP6AcmyrMMLywpAs=;
	b=bXe63CSpzVd6eYfyOfftXBOU4lciWYSlJbD01XjzMMevRcBoK7PxoN8sazkvu2RDPeIG4EG6cIlKZ6MGLjaAMX6lcFTb+QjbO03zMYurM7Oms4ufzz4FaV9x7pmhTp2V078L40B9xWoBkv35L360NtbHSZN/N6yaiyBY6J8hwlg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W0F5hXj_1707272391;
Received: from localhost.localdomain(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0W0F5hXj_1707272391)
          by smtp.aliyun-inc.com;
          Wed, 07 Feb 2024 10:19:53 +0800
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
Date: Wed,  7 Feb 2024 10:19:20 +0800
Message-Id: <20240207021921.206425-3-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240207021921.206425-1-xiangzao@linux.alibaba.com>
References: <20240207021921.206425-1-xiangzao@linux.alibaba.com>
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


