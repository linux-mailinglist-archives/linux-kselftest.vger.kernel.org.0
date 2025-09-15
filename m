Return-Path: <linux-kselftest+bounces-41452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF57FB5712C
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 09:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C53167F5E
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 07:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452462D5950;
	Mon, 15 Sep 2025 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Od3S6pPW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9900F2D4B61;
	Mon, 15 Sep 2025 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920926; cv=none; b=Dy/F3/Qv9DAMws7XcDaBP/Gy1PqnzbI3cBhHZWGGA9n4noEn2Sg0TqgsSJ32VY8s/WkUlwNmHmT6PwiTnBm/yRP7JlW0QTjqj3yO1ydWOqAEUJtiWE9+iXWQuslkxSP9ruGQ2J+L73T+OY7eswUCl2517lOSi/bVkGYCYyoJBok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920926; c=relaxed/simple;
	bh=u9SFP3WT446LSElIPfH5LXgn1v0GZNblanHXr/hl09A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iReWQTwVM4VdVOLxY048H71dr6uk3Hnj9BHrEaT/pWKhH5Axec7QwYRneULN+3cRIj8A5M3cJTtbsLIfCg00XPVHX9QaDnKl1bzmVzACqhmFAplKBFLJCljshpmiv9ENrQb1kDSYAlY/+OzyGdU54xZVDWojJYsycgxa84C57mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Od3S6pPW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JY7XXxDvbM6ze0ff4yyO/d8yJdh8zCwsbDmZYeFp3+Y=;
	t=1757920924; x=1759130524; b=Od3S6pPW9cppUBgU/LqXHsuXqWb47P/Gui/8N0w4JUSfq29
	7KktVuZ8V09NZ/RGgi2Um/txd68xHI8odZJ6tHxNAa6WxY3KN6jmD4gSOtB+I834XjUouVrPAPlvi
	kmGKqbMlK8Bq4f1AYLOSV7SDMQw1S4TEMSKuFMnF/+PT4nzZZW/VC4uMHg0/vLc/aKXPyauEyfUmD
	cEZfWChDfLls2rtzB42lRsNVdLG8qIRFxgu92Rfsil4LskhcGKoTg0evRJYdy9UIpDO2OP9n1lWY9
	jh7tQDU1h5Dnf9z5gATpirvPBGRfp0wltmCJZtOf1WHKg1/oghAy9QyDO9tWQtOg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uy3XE-00000005w6o-06Px;
	Mon, 15 Sep 2025 09:22:00 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 1/9] tools compiler.h: fix __used definition
Date: Mon, 15 Sep 2025 09:11:07 +0200
Message-ID: <20250915071115.1429196-2-benjamin@sipsolutions.net>
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

The define mapped to __attribute__((__unused__)) instead of using
__used__.

Fixes: e58e871becec ("tools/lib/lockdep: Remove private kernel headers")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 tools/include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 33411ca0cc90..b2c40621d441 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -127,7 +127,7 @@
 #endif
 
 #ifndef __used
-# define __used		__attribute__((__unused__))
+# define __used		__attribute__((__used__))
 #endif
 
 #ifndef __packed
-- 
2.51.0


