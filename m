Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2900C20BB17
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jun 2020 23:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgFZVKH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Jun 2020 17:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgFZVJh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Jun 2020 17:09:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E3BC03E97A
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jun 2020 14:09:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w9so11267372ybt.2
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jun 2020 14:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Nq9F0z4123tt4UqM776+npgcQr2vACSfzkMX0VOkyz8=;
        b=ZTCAFApecEGx44TdgImNQ12qAsrhIjFlqnA7X8OIrt50WQJMdqROa5BvnuDYaE3Lok
         k0Yftw/cS9ECxUbfwTAX99Lpd9yz7y6jnHtBB0aDOCqWldoDru/97LnHSGKESDDgKxlk
         9xdLNvFvVxCLM1TZWYvCMNyDrmmPXKtFf4vogUSxmfH675+a1vyIMc1FOubVKERDE7qT
         9kdv/gVdn6BKAnCWx2ayZphzK6Ug5Ymkk1L+8/qvIJjqaoLD5p3qcuo0W8wff6J2k6XD
         T0qgDLjqpzi8pMoH30nARMyW0khccHFiU17SgAB+7PpX1UNDWCXFmmJy2a9NaPgHv9Wv
         1cDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Nq9F0z4123tt4UqM776+npgcQr2vACSfzkMX0VOkyz8=;
        b=osT18suWqSObZmJRdFEYM7+p88F3fZ9rRpC3Q2HwT7s99YnGTQD+m2aLmAfNjx0TGV
         YrShhE5xeS60t9CcmzQN7e6CRShdVP/MLBB4U/ehLzU76shVJqsBm+g9X0faCVj0FTQy
         6Ksp0EtdoSnjY14e8uE5LeWevPKx2T5CgWEMmW6sHwrTbgA7C2DZD2OMXr8X9MOIF+SH
         GSK9mPO9wE5ejyO1PV8e1x8oxO42e0uXuwMBa5N22VS5xpPQSWJ3tJrnTf+up8yT1fTA
         uYW6GnnOgRIFUUL50FbyK6GQNEIkSBCtdkADMzS6BTIlEiiWfNU7z1raAgyiyFydYHiM
         4Wjw==
X-Gm-Message-State: AOAM530RZ6lfhGliUnxAFNqXTxj5T9C/dtIz1BhRlTdpIHxuT5vueWnW
        oyH6nasYSJbih/SJbJdTkQ/iOt90rhFD0JjSti7eCA==
X-Google-Smtp-Source: ABdhPJyKnnV47wg6p1lAvgLAC5x+iqxuxiQuXvbI9BMlMWyGeJgFmODnuKaIGhblbFF3wtpirvJDFFjiadtzPLSBo+FHIA==
X-Received: by 2002:a25:dfd6:: with SMTP id w205mr7760830ybg.216.1593205774990;
 Fri, 26 Jun 2020 14:09:34 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:09:11 -0700
In-Reply-To: <20200626210917.358969-1-brendanhiggins@google.com>
Message-Id: <20200626210917.358969-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v5 06/12] arch: xtensa: add linker section for KUnit test suites
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

Add a linker section to xtensa where KUnit can put references to its
test suites. This patch is an early step in transitioning to dispatching
all KUnit tests from a centralized executor rather than having each as
its own separate late_initcall.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/xtensa/kernel/vmlinux.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/xtensa/kernel/vmlinux.lds.S b/arch/xtensa/kernel/vmlinux.lds.S
index d23a6e38f0625..9aec4ef67d0b0 100644
--- a/arch/xtensa/kernel/vmlinux.lds.S
+++ b/arch/xtensa/kernel/vmlinux.lds.S
@@ -216,6 +216,10 @@ SECTIONS
     INIT_RAM_FS
   }
 
+  .kunit_test_suites : {
+  	KUNIT_TEST_SUITES
+  }
+
   PERCPU_SECTION(XCHAL_ICACHE_LINESIZE)
 
   /* We need this dummy segment here */
-- 
2.27.0.212.ge8ba1cc988-goog

