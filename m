Return-Path: <linux-kselftest+bounces-41460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C015BB57146
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 09:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D17E179206
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 07:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1F62D46AF;
	Mon, 15 Sep 2025 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oGOcKTs7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386DC2D7DD1;
	Mon, 15 Sep 2025 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920934; cv=none; b=YvFM2Txq3c7PT0u9i8DCiBmxOSHt+/mRyWrza8GbTTnxFeCdXXHChfcVArS0EGwrv6upAoz723pW3oyaQ14JX0rn/DdOG1nv06znVlDlRvsLIFYB65XJDweWJX3oaGwzcvpccvhyueuY84XKHv9F2cj6v5xRiLk+0lbVqWwLNzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920934; c=relaxed/simple;
	bh=+1XbHYWO44eiLyr3lQME0rhVVOh0E9r61o4FckS2Ch8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsYdvacUGle15c8YutIaczZYVbJX+6JNOVRr/ZilTeY5/8RCn2EcXcMjsoguUjkQIve/zz+1VRJNMWxdXXi0cnOxWw8yhTgeCNvT8o8EIK1MFnRla3zIPG5z0QihGB6QqhXHyXq4NfNy7T65y1qxyDaLiJNz6xC5nzedNSCsxPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oGOcKTs7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UVHwzh9sHs6Xo02VEWpZXjxZy4cbskfDXgmFGFBhsbs=;
	t=1757920933; x=1759130533; b=oGOcKTs77mBBOsOPVUAqH8rl9BNGCh00ZK3Mto8rgxoELDX
	GNCuFhrRJUp+mCuL0z4vmnvETt3k/LifrZvcekkk/U4lUNqEALkbfSwUkFTfkpCYvKGUpx9UfsMD+
	BMxbfOT4gfyOkLn33N3hbbxVzaF0FLsojY6I19EYHeZXU24BtfzxPc0EloHXlUNaaniymzX7AlStt
	prZdzHXI583fO0Xjm/bL6VB84yj5RbtvBGu8tlrO8rDEz4beaIeJL12OSv+6727uTOKx7b0DVOYlq
	9+BiJF+vreo6Njlu9oz/aVah3pgfhDyayUDIVbvS2ZQOV6nC/rp1q8SeaPex6Itw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uy3XN-00000005w6o-0J1R;
	Mon, 15 Sep 2025 09:22:09 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 8/9] um: use nolibc for the --showconfig implementation
Date: Mon, 15 Sep 2025 09:11:14 +0200
Message-ID: <20250915071115.1429196-9-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915071115.1429196-1-benjamin@sipsolutions.net>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

This is one of the simplest files and it can be switched over to use
nolibc without any modifications.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/kernel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index b8f4e9281599..4b206a40b611 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -26,7 +26,7 @@ obj-$(CONFIG_OF) += dtb.o
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
 
-USER_OBJS := config.o
+NOLIBC_OBJS := config.o
 
 include $(srctree)/arch/um/scripts/Makefile.rules
 
-- 
2.51.0


