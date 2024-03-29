Return-Path: <linux-kselftest+bounces-6785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C50C890EE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 01:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DD861C2301E
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 00:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B7C846F;
	Fri, 29 Mar 2024 00:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="NYWgcAaR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2811846C;
	Fri, 29 Mar 2024 00:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711670802; cv=none; b=e2yOCb0yy8vW9HSmZT6rhP08Oin+iiEGkyYkVA62WmnBdt8k6+RPYwJy2CwqIHmoIPwgNGPeN6bzpR/OjlX9hZ0yd5cYbZruJFnCCk1ZOARJN3Bjofx10XrArC8VckKC80AxyOjv3H2mMnzF1DrvlJjQ0fG8T3hKusCqaIbbqp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711670802; c=relaxed/simple;
	bh=16TTnDO8QFgSGxh5yy4L88sASL3fulc6U1OQS20VgwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3NlzNfnhnDorG94/777EEQkkGuNXGaofkkHuCLESg64Jyi8NW9Xa4fwnaV8gExB4veBwUCElnrlPTv3NBnKCl9u/1PyYjeZgLxs3yHGLaOJQSIs3vPB3qWUY7Fv/FSD3opFYYi8cWLTN6ft/hJs3ChBvR/sxmV397IYvpk5iwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=NYWgcAaR; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=wUKxA0MlTaO3MO0CDH97kDrJjYjR5N/pR68ax8VZgYY=; b=NYWgcAaRaXZJxAtPMdfAVVThKv
	DzgTElbAi0UB5yC414IljqvaU6TXCVFEomZ8QkQknNFxFi2JMq2JylA+ydsB7RLgmRha/eW5+fKfv
	jlH4cd+MwWw5JmYmw/57RtL98nRMmWIJreSudebzt6dYMMWgvbju/lYvcck0ZbJhGFhqsMthXkKJ6
	8opWnOaeBENo00Ygpm3dar3WO4fr2tjKDWIBO2HOnZuabSPlErRb/o1NV20gNxOm6wZQE1EHEf8cY
	z60J/l6fRg3+lplAnPB5FxRbhPq57ImzT4XBUWdj2iKNw+GUxfRrxKL6B3Tefm5KgJijKSELtrI+S
	Z6G7Qbrg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rpzlW-000iik-1t;
	Thu, 28 Mar 2024 19:06:38 -0500
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
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [PATCH v3 29/30] maintainers: Add an entry for ntsync.
Date: Thu, 28 Mar 2024 19:06:20 -0500
Message-ID: <20240329000621.148791-30-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329000621.148791-1-zfigura@codeweavers.com>
References: <20240329000621.148791-1-zfigura@codeweavers.com>
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
index aa3b947fb080..84d03d95f44b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15720,6 +15720,15 @@ T:	git https://github.com/Paragon-Software-Group/linux-ntfs3.git
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
2.43.0


