Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF5249618E
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jan 2022 15:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351303AbiAUOw3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jan 2022 09:52:29 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47554 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351086AbiAUOw2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jan 2022 09:52:28 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 2EE241F462E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642776747;
        bh=Zf0MQnAC5ex4gwL5rurXGHPQ9n9H06PmzESD6tnHhp8=;
        h=From:To:Cc:Subject:Date:From;
        b=Jdq7G3MBSKB6N+YYEy3iuhVIpfhmCIqvVIDOozU6/6NdBri+93qGoqLEha9V13kJO
         8aqC2xzdHy9ThWkZznM2wo4y9e8ekUBr1eidXJrUh7VXMIcUm9rXZgmj5E5+LVHzp/
         rWCWyKM7gWHFzsvFrcfdjKrRloYX4RBNrEaHy72XyUpsQhCwvspKMTJxpKzrX6Q0wT
         cCxfihJ5FVpkIwBtc/I03M3gyFJ1IQJtCyxUxEkyxi4dE0/KUGSOrEwsHnwDudlgH4
         X3tBoZ/mdoFVs5mxXvYv2y5w8gl18YOrBMkh+vdEY1DHPtiPmmiZk0yaVz3jzIeRfO
         zx2ZV8Tgy+Hvw==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] selftests/lkdtm: Remove dead config option
Date:   Fri, 21 Jan 2022 19:51:52 +0500
Message-Id: <20220121145154.1795447-1-usama.anjum@collabora.com>
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
index a26a3fa9e9255..a7a58f885f52a 100644
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

