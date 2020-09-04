Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD7325E2D3
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Sep 2020 22:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgIDUcY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Sep 2020 16:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgIDUcV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Sep 2020 16:32:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73352C061244;
        Fri,  4 Sep 2020 13:32:20 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 204DB29B035
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v6 7/9] x86: Enable Syscall User Dispatch
Date:   Fri,  4 Sep 2020 16:31:45 -0400
Message-Id: <20200904203147.2908430-8-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904203147.2908430-1-krisman@collabora.com>
References: <20200904203147.2908430-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Syscall User Dispatch requirements are fully supported in x86. This
patch flips the switch, marking it as supported.  This was tested
against Syscall User Dispatch selftest.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7101ac64bb20..56ac8de99021 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -150,6 +150,7 @@ config X86
 	select HAVE_ARCH_COMPAT_MMAP_BASES	if MMU && COMPAT
 	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ARCH_SYSCALL_USER_DISPATCH
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_TRACEHOOK
-- 
2.28.0

