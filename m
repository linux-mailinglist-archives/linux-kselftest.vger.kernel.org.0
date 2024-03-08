Return-Path: <linux-kselftest+bounces-6086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF47875CA8
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 04:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA83B2826FF
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 03:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E4F2D634;
	Fri,  8 Mar 2024 03:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xzdx7yyo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C699D2C191;
	Fri,  8 Mar 2024 03:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709867861; cv=none; b=UsXHGTdLo2KNss4EaWp0mAsXSGLOXsz0QmNAzwC1/k4Ii1wvStfxlUvKShClT02zibyMbjXMVoo3HNzw3FDTq1f0DZibFN8NwrNdYigqdxB792bLhUq1Ut1jM3wxbV3CseOLlwJePBFKuZWLOxbg3JdEpeGhEr3MWShThSrm2rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709867861; c=relaxed/simple;
	bh=1jsd9mGoVQHm1V4yFrSLqNS37CUX4LscqCguLRjOB7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cdFyFDuryWwdPxvFzrNmwrcCo5Nlczzho3WudpsIV/V1XufXG77Lbaq6beYRsYAilX7dc7DUfgvL/iG5AoYiwbNM6yHVtwhxDwZ56uR836jqo+i3r7Mi89XXVQHgUGS7Fi9hvH0SAgEwGDJPFYWDIaOHVZMrAhS79WXHi9Fn5ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xzdx7yyo; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709867851; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=W6AVrYSVWdqb6Kluzfu3kNRq+OeMXNs1TA/BAWxyQNA=;
	b=xzdx7yyoLb+7olzAUrGko8fhCmOpvSErKjAAElihJLwbvhkH3iwevCz1GGovFUvm688HvfeVTSjoX3X0Qk1wOjovl/4zVLFeIUYgMf1Ef9opBHgVDS6nqqkhiNcO7DKYI0gE1hel7Xd715Y1ps9ZNfn0mAeh6aTMdh4ODvpivGg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W21N1NW_1709867849;
Received: from localhost.localdomain(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0W21N1NW_1709867849)
          by smtp.aliyun-inc.com;
          Fri, 08 Mar 2024 11:17:30 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: keescook@chromium.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	shuah@kernel.org,
	corbet@lwn.net
Cc: xlpang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	xiangzao@linux.alibaba.com,
	yixingrui@linux.alibaba.com,
	linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 3/4] Documentation: adjust pstore backend related document
Date: Fri,  8 Mar 2024 11:16:55 +0800
Message-Id: <20240308031656.9672-4-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240308031656.9672-1-xiangzao@linux.alibaba.com>
References: <20240308031656.9672-1-xiangzao@linux.alibaba.com>
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
index d3cff4a7ee10..b3ae01237b54 100644
--- a/Documentation/ABI/testing/pstore
+++ b/Documentation/ABI/testing/pstore
@@ -41,7 +41,7 @@ Description:	Generic interface to platform dependent persistent storage.
 		persistent storage until at least this amount is reached.
 		Default is 10 Kbytes.
 
-		Pstore only supports one backend at a time. If multiple
-		backends are available, the preferred backend may be
-		set by passing the pstore.backend= argument to the kernel at
-		boot time.
+		Pstore supports multiple backends at a time. If multiple
+		backends are available, the registrable backends may be
+		set by passing the pstore.backend=argument1,argument2...
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


