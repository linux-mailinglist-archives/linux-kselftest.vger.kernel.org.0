Return-Path: <linux-kselftest+bounces-41457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C74BB57139
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 09:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0DDE3B056A
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 07:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E072D738F;
	Mon, 15 Sep 2025 07:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="v1QVZUfg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CD92D6638;
	Mon, 15 Sep 2025 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920930; cv=none; b=ielL+LrZjbL08KkLj52yyWVC/2KVh2iZ1zoeOJNTz1Twalm3//s0MJ/ueXZc/ZJmDp7OMJayWVtwYgEbG/BhLll/RFHIB3n+S+pm4NEPQC9vzVCie+wr9KLgAlaV0jgWKtJt/HrcoB0d0K3QhKXo2RKh21Z/nxbm0D6NAxIcIy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920930; c=relaxed/simple;
	bh=704uJj0Ip1OexW9zT7NZ1IplH08kL+cIIvWsiux3+es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZ2yHHy3Xhe4RV/H7MN24cyAwhNnvq/M4V8l+Io+f1MskaC7kvTysVHv3REtq4FK2hxg/+xwpEOL520WSJxcv6SLaD5sDJBJEucShecTxRpdu+kEiFyCuBg/kBxEOo3Pv56b1cmvIHV4u6ben9Vkag2/uYdmEIg2M7mQjSKTsIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=v1QVZUfg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=uB+ZeSs+X9NMubgvNrYfiWUR+gb4lauP6HMzVhv7NVY=;
	t=1757920929; x=1759130529; b=v1QVZUfgYGIQtYPFw+F+y1wGh8/UfL6Ke30lbylSCk8ow0a
	zmtKAW5/AbUnA3OzNE9mASoKbvqS1pXsjNh2vcZ2jk2Ubds4bw+IwHl99XryeKsVAE6/WoApkupZE
	4U7dtjYyNp2HFxnelg8Y+0affUNOeT54zKukm5fwAxFEQSq3qXgJDYRKqrPwgprziLsUjVeof+oaD
	BWfgfAEwtvFEsgR9uBhejsueflEnq+cQfd3ahhk3C0S5IH3hi8hxVc9e3WzVZlLvqsdJfFrQTDhSz
	FZ25qGZ/6SPhIJ4+jgOOGGBuClfU39c+CIGYk4QhOiRiOkf4KekH32TsWW0uhmqw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uy3XJ-00000005w6o-2p6w;
	Mon, 15 Sep 2025 09:22:05 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 5/9] tools/nolibc: use __fallthrough__ rather than fallthrough
Date: Mon, 15 Sep 2025 09:11:11 +0200
Message-ID: <20250915071115.1429196-6-benjamin@sipsolutions.net>
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

Use the version of the attribute with underscores to avoid issues if
fallthrough has been defined by another header file already.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 tools/include/nolibc/compiler.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
index 369cfb5a0e78..87090bbc53e0 100644
--- a/tools/include/nolibc/compiler.h
+++ b/tools/include/nolibc/compiler.h
@@ -41,8 +41,8 @@
 #  define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
 #endif /* __nolibc_has_attribute(no_stack_protector) */
 
-#if __nolibc_has_attribute(fallthrough)
-#  define __nolibc_fallthrough do { } while (0); __attribute__((fallthrough))
+#if __nolibc_has_attribute(__fallthrough__)
+#  define __nolibc_fallthrough do { } while (0); __attribute__((__fallthrough__))
 #else
 #  define __nolibc_fallthrough do { } while (0)
 #endif /* __nolibc_has_attribute(fallthrough) */
-- 
2.51.0


