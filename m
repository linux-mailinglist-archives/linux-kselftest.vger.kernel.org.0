Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE574207DF1
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jun 2020 22:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391608AbgFXU7I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jun 2020 16:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389697AbgFXU6S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jun 2020 16:58:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C006FC061799
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jun 2020 13:58:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 186so3517710yby.19
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jun 2020 13:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0vYZtvNiMw5LFIFKa+iHi1yqO9mFLTJ7LRF4fjft6YQ=;
        b=Ht//4dFCRi5Ycs+UMuxNJ7MV/84NLNKbMMrbLHuEjXQGLBEQPIpFzadQ2ao7vcuRer
         GOsbiPE75wfUufWuNvRORj1w7XTppFNHZFb/w9vysRIKLTiJA+xHpDaE+N3XmZZUH7MH
         7lhF9i0xb8VvBZ80IiWVYGeXmeCW1iu7iamWPbdRq557jmWCZkqp+qV8y6jB2OCJy6VA
         GRc001gVOpxxqc8MYG1JaA8vAVmiGkBrQE6r3W6gpRO7/UpoQZRQV1myeC7/+NUvoKC7
         jr4U5f2PnAS3X2qv6X8g99vU6G58oTPXti+dwKaI8fPvVdUIML6AitHtRQ3va9rivd/F
         VRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0vYZtvNiMw5LFIFKa+iHi1yqO9mFLTJ7LRF4fjft6YQ=;
        b=DOB1zERqst2GEngoWUyazZJivgXksB6HIbPedCi3MgrYHaUkV9S52AJKILwRTJvqQs
         qmq7sEyk4DHP/pxiUfTXsldwg6tbOYIKDXZgahN764OeYMwo5eN1wijqAzejVrI8vOlg
         wwG351Gri9Nk5IPH4in+Z16wIkg9EPvWGZtqJKW3Oxc+vOhkzgGRoA7fSuI8BaTTGIN3
         vg5Mob1FayvZfLnulsf1Eo1HPAGEQwHTd+9u9dBQeOxt9a1au8nkKC36ZjeDMsHxCS4b
         f0oPeocT4hcESjqHgI353Iar5z0jve9yj4vyjh0jUNTqC0qSIs+0uor9vYjxeWwnkuHr
         mxAw==
X-Gm-Message-State: AOAM530A6Ek7/yZhdof42POYlAUXzbBCdkTFsbOFvP7g5c1IjiPlGFYn
        iibynbj+pWaaXjtcZpD1nF+LEf/geM/i++LWzHO7KA==
X-Google-Smtp-Source: ABdhPJwOWDerhRlyEc+SD7GJHD/aFxbe2dcsXrDdYmbTX35zuFg+yS8T/ZZb/3aA+5pG2lFXNE77oD59Izt1xQSc+67yag==
X-Received: by 2002:a25:8403:: with SMTP id u3mr47227886ybk.276.1593032295892;
 Wed, 24 Jun 2020 13:58:15 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:55:43 -0700
In-Reply-To: <20200624205550.215599-1-brendanhiggins@google.com>
Message-Id: <20200624205550.215599-5-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200624205550.215599-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v4 04/11] arch: powerpc: add linker section for KUnit test suites
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        monstr@monstr.eu, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a linker section to powerpc where KUnit can put references to its test
suites. This patch is an early step in transitioning to dispatching all
KUnit tests from a centralized executor rather than having each as its
own separate late_initcall.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/powerpc/kernel/vmlinux.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 326e113d2e456..0cc97dbfde0ad 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -202,6 +202,10 @@ SECTIONS
 		CON_INITCALL
 	}
 
+	.kunit_test_suites : {
+		KUNIT_TEST_SUITES
+	}
+
 	. = ALIGN(8);
 	__ftr_fixup : AT(ADDR(__ftr_fixup) - LOAD_OFFSET) {
 		__start___ftr_fixup = .;
-- 
2.27.0.212.ge8ba1cc988-goog

