Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7CD48AFAA
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jan 2022 15:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240845AbiAKOgj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jan 2022 09:36:39 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50992 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242179AbiAKOgi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jan 2022 09:36:38 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 466931F44645
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641911796;
        bh=dewZi1oCBM3pJh97E1Dyib+o1ce0sI8WMZt2GX/YFVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vs9AwJwY3Dgc528+vc74CGjIyYO5WocgFvc3qu+AxRZf031L0MBB7Wy7GaSWzHfjS
         z6+daa9G6CU/aDPJNbDxMv5k2Pt0t2yu+FquhoV6xr76gTai7rX00K+vE7FmMT2bAk
         OIo7zdZ5lctF9Auy5zJTUB3JZRvzbqMSHp8s10qEky1o2wkszE55ahpzegLDRYRukQ
         0qfV1wn50bdkazAHbjvKpG3Iw0ZiN9sDlRLzuicS3I5tP6AovozuFFOHuLXyuv8Aj4
         xA8SXDBTET+iOBZBBtB3vsJwxeaHnuuUp2DjeN7/WrFAogSXtrR7YWdt3+agu9lFbA
         UOZS/36MjdW+Q==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 2/2] selftests/lkdtm: Add UBSAN config
Date:   Tue, 11 Jan 2022 19:36:14 +0500
Message-Id: <20220111143614.629452-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220111143614.629452-1-usama.anjum@collabora.com>
References: <20220111143614.629452-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

UBSAN_BOUNDS and UBSAN_TRAP depend on UBSAN config option.
merge_config.sh script generates following warnings if parent config
doesn't have UBSAN config already enabled and UBSAN_BOUNDS/UBSAN_TRAP
config options don't get added to the parent config.

Value requested for CONFIG_UBSAN_BOUNDS not in final .config
Requested value:  CONFIG_UBSAN_BOUNDS=y
Actual value:

Value requested for CONFIG_UBSAN_TRAP not in final .config
Requested value:  CONFIG_UBSAN_TRAP=y
Actual value:

Fix this by including UBSAN config.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/lkdtm/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/lkdtm/config b/tools/testing/selftests/lkdtm/config
index a7a58f885f52..46f39ee76208 100644
--- a/tools/testing/selftests/lkdtm/config
+++ b/tools/testing/selftests/lkdtm/config
@@ -5,6 +5,7 @@ CONFIG_FORTIFY_SOURCE=y
 CONFIG_HARDENED_USERCOPY=y
 CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
 CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
+CONFIG_UBSAN=y
 CONFIG_UBSAN_BOUNDS=y
 CONFIG_UBSAN_TRAP=y
 CONFIG_STACKPROTECTOR_STRONG=y
-- 
2.30.2

