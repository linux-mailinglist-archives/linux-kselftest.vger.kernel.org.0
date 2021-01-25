Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C1130360E
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Jan 2021 06:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbhAZF61 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Jan 2021 00:58:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728292AbhAYMr1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Jan 2021 07:47:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8EB622D04;
        Mon, 25 Jan 2021 12:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611578806;
        bh=kXFZkQ9+v70aH3YVPuA5/lu+eenOiEeGF4vdN+dLFXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DXTCMseCI/Zpe+8B3NRpfNUmZER45GKnjtDKktN9SOa5UxRqf7GzeMm26nh7vHuzB
         a1vxPTVpUEG3IS8mGE/i695PZBWod8q4jJKIcWH5d5wgIPBxbpGTJV/c8Gxh8k9oJR
         lZGpFG2I1enjOqDI7LYKBuArgdxcJcuN/jhMLEN0qt6b3GVquUJEDWlwQhWxNwIvis
         bubRTpFAdqO4LuM8OB2fmrZHyuOs4XhU4zCVbDYasw46qtiSq+2SEg3bMvH/5iCX8R
         ReLQ+Li7judC1UxCNTvdGb97OGiO+bLO1RK4szwMpzgfJULqIM5mYRMY+wUy4YNLgG
         EoeAvpQdDw+JA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com,
        Andreas Noever <andreas.noever@gmail.com>,
        linux-usb@vger.kernel.org
Subject: [RFC 3/3] thunderbolt: build kunit tests without structleak plugin
Date:   Mon, 25 Jan 2021 13:45:28 +0100
Message-Id: <20210125124533.101339-4-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210125124533.101339-1-arnd@kernel.org>
References: <20210125124533.101339-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The structleak plugin causes the stack frame size to grow immensely:

drivers/thunderbolt/test.c:1529:1: error: the frame size of 1176 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

Turn it off in this file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/thunderbolt/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thunderbolt/Makefile b/drivers/thunderbolt/Makefile
index 7aa48f6c41d9..e571c0495a84 100644
--- a/drivers/thunderbolt/Makefile
+++ b/drivers/thunderbolt/Makefile
@@ -7,6 +7,7 @@ thunderbolt-objs += nvm.o retimer.o quirks.o
 thunderbolt-${CONFIG_ACPI} += acpi.o
 thunderbolt-$(CONFIG_DEBUG_FS) += debugfs.o
 thunderbolt-${CONFIG_USB4_KUNIT_TEST} += test.o
+CFLAGS_REMOVE_test.o += -fplugin-arg-structleak_plugin-byref -fplugin-arg-structleak_plugin-byref-all
 
 thunderbolt_dma_test-${CONFIG_USB4_DMA_TEST} += dma_test.o
 obj-$(CONFIG_USB4_DMA_TEST) += thunderbolt_dma_test.o
-- 
2.29.2

