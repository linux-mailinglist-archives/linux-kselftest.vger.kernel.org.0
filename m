Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CAD48AFA8
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jan 2022 15:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242168AbiAKOgh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jan 2022 09:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240845AbiAKOgh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jan 2022 09:36:37 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD09C06173F;
        Tue, 11 Jan 2022 06:36:36 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 3D8661F44642
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641911794;
        bh=WoCSfvWZ0RM1u1nDrNK6amswglzkJ65ayw9iZSom+UI=;
        h=From:To:Cc:Subject:Date:From;
        b=J4zrWziFsqvl8KXsnoBV6LHs6IhDf2sdQkFD5qfCiGZcEvjktFI1em79VvJ3mbZk2
         D9NXIMXeaSmTbjNVBYRrxWZf17/77NQlKyWIxMb4ahMoFscUn2/UPEPl62h+zCDfOx
         tDG+ph9eROPaNmRTQSWpyMN8o9Z3S7atpH9HbJwrt4dty740OdV2vfkxicTKnf0QLw
         u8ZV1xdREf7okKEA5bRtC2zW5QJPEygX1uNwyPYG5Nf+G5Bj7HPihBRnu5S4v4cSEa
         gv/H/c4DsTKxLOowC4Lc4LN5QmLj521/lA6/PLSgxROeZAKgS6RTxUFY1OUUESqJ0H
         2H4QCpK1MMMzQ==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 1/2] selftests/lkdtm: Remove dead config option
Date:   Tue, 11 Jan 2022 19:36:13 +0500
Message-Id: <20220111143614.629452-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

CONFIG_HARDENED_USERCOPY_FALLBACK config option has been removed in
commit 53944f171a89 ("mm: remove HARDENED_USERCOPY_FALLBACK"). Remove it
from the lkdtm selftest config.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/lkdtm/config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/lkdtm/config b/tools/testing/selftests/lkdtm/config
index a26a3fa9e925..a7a58f885f52 100644
--- a/tools/testing/selftests/lkdtm/config
+++ b/tools/testing/selftests/lkdtm/config
@@ -3,7 +3,6 @@ CONFIG_DEBUG_LIST=y
 CONFIG_SLAB_FREELIST_HARDENED=y
 CONFIG_FORTIFY_SOURCE=y
 CONFIG_HARDENED_USERCOPY=y
-# CONFIG_HARDENED_USERCOPY_FALLBACK is not set
 CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
 CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
 CONFIG_UBSAN_BOUNDS=y
-- 
2.30.2

