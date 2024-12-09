Return-Path: <linux-kselftest+bounces-23071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503A59E9EE0
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 20:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129FC161205
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 19:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4E31A08B6;
	Mon,  9 Dec 2024 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="c1T75YrA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3E019F487;
	Mon,  9 Dec 2024 18:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770783; cv=none; b=BvTEFaBHZWeamccJxdPSx/zEP1b2WD6Ak0x5INfG1xuoYY8aCPm7wzcy4iHY1VLoGPu25migR70YO2EQs9PztDUEGY5rwmy/fsaQsRGwUb8csz3fU45N3Zz/AHqui9HYW+/o6qoDGpltOvM66uGi59u4GqxEJiLHkGBQinj8vWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770783; c=relaxed/simple;
	bh=OJvM6op5wYx37WguuHJVy5B8DCwQrTuTTPhePbmCAcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTOC3EP3yGed/HxaN87ACdcyS/DCo0Fui7OOLl1OD4HA1XBWzkMJAhEZHwfEYqAmemt4nZuu2N0JafolPicOqITZrqUJDpqfMZVy/Xp0ECKurC/aU0HZAq2ykfPJXDbZVlx71MP6kiabSCALwdkmeuNFSVsCE0k0xShhRyPRHGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=c1T75YrA; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0P2C43dx5tRTctB9mu2F7UXtDC2Bs0A7lV36tqxIGe4=; b=c1T75YrA/L1v8+syaiQ4OKQh54
	oJbSeRMf1dguNcP6sqUy4+L4InsJpRrz4aUSEs4lVzRl7RZU1LR6nwFw+BNbd2aQYedfYg+DFUZc4
	+BWDJf7+QeL2y2B4kWPHFBHKS729r213XWt/PQpB98UtpNBRnI+9NAP0y5VaBfrxvxaSb1/B5ryP6
	ofCP+sp1e4Lqh+FMfuXiefhzCGEo1l3LHtGrN2+LNiF//ahOFNQsLxvR9HcFoDVI6ffuv3Qf3QHl7
	reAdViCAZ/lFp7zP9nhmEOM2276KCN4tNfCcWBLH32yzeg7OZaWSaKLDH2teWTQBHOQbBDRUFKcOf
	/7YLc/ew==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tKiyn-001Gd5-39;
	Mon, 09 Dec 2024 12:59:38 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	wine-devel@winehq.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [PATCH v6 26/28] maintainers: Add an entry for ntsync.
Date: Mon,  9 Dec 2024 12:59:02 -0600
Message-ID: <20241209185904.507350-27-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241209185904.507350-1-zfigura@codeweavers.com>
References: <20241209185904.507350-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as maintainer, supported by CodeWeavers.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..8c3dd9077fc2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16708,6 +16708,15 @@ T:	git https://github.com/Paragon-Software-Group/linux-ntfs3.git
 F:	Documentation/filesystems/ntfs3.rst
 F:	fs/ntfs3/
 
+NTSYNC SYNCHRONIZATION PRIMITIVE DRIVER
+M:	Elizabeth Figura <zfigura@codeweavers.com>
+L:	wine-devel@winehq.org
+S:	Supported
+F:	Documentation/userspace-api/ntsync.rst
+F:	drivers/misc/ntsync.c
+F:	include/uapi/linux/ntsync.h
+F:	tools/testing/selftests/drivers/ntsync/
+
 NUBUS SUBSYSTEM
 M:	Finn Thain <fthain@linux-m68k.org>
 L:	linux-m68k@lists.linux-m68k.org
-- 
2.45.2


