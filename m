Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1904420BB1E
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jun 2020 23:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgFZVKN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Jun 2020 17:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgFZVJf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Jun 2020 17:09:35 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46552C08C5DE
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jun 2020 14:09:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s7so11100716ybg.10
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jun 2020 14:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0vYZtvNiMw5LFIFKa+iHi1yqO9mFLTJ7LRF4fjft6YQ=;
        b=u6J8VuAHahXAYfZui4sfoaT0dsrVB0g/njRZ5MIakf/7bSZWFoZur8+vHZjZIgvkyd
         rsiis3HuL4AzSgVfpTFGOsNv9/7tHGdL61VbY11KBuBRNquuaThfognGBSG6XDHhjVrh
         liuTo+mvfU3D58KkhDomQtYXookl7U6ajEKfETHE1nWaRN0/gzOUI4z4bMwjPWQ6R2G4
         zVR7MS6jsimbRTLQK965Ww+Cp//ng+4aqqoiGzs9geOb61x+qHK6AUxwcP2HuU1S8dLP
         OEv3lAQzqQIPWit38K3OJmKJ+ONf/s2+d2jSKX83GtbI8ZYL+/awT6qOEcyz2uNC8LpH
         kbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0vYZtvNiMw5LFIFKa+iHi1yqO9mFLTJ7LRF4fjft6YQ=;
        b=DE/miHTLXCcZt/ipt4VK2xMfO7hnesDWGXMk1FgVuVCuXQxnHJIWooFIjQdPsrjmtm
         Efz8fOC+bJapPK+55cmVnSazV+IFaKF4C/OpgDC6JldOD1IbiuX6M2E2HQO47+aW+Toq
         r+8NHsoSgB3SKnqKecFEOmdLZkid5RcKJ6XtSAiKcoA5doHQ3HvnRFTLkJP4PeY0kZFv
         /5Qp/ybbh6YP3G5bJYuId3gJcz/3NG53guqLq8Ipnl+WsgB3uMSR7V3mjRWk7F3nfTA3
         +3ZbETGqukHZER5fSB1qqnjkWYC4nigaIavDIh+O+1ysbBOjE/bAhCfGlncK+5jhO+uu
         hUQQ==
X-Gm-Message-State: AOAM533317MueA3a0GZ43IT1C3r4+drYHN+1O3M+cHOy/6+jON9NNCBt
        q43bI+DJE1r2nfD27ADVSnJoVHmyhe/tWER3gy2YfQ==
X-Google-Smtp-Source: ABdhPJx4P+f9DA00o4x+xqsn5YNYZSrsnifEZc+MXGWM1Q+GQ6+KAVyhHfpoUwDaYub8VfOW5n9UfKxOSH6ZQNhne0KQ9w==
X-Received: by 2002:a25:99c8:: with SMTP id q8mr7798153ybo.3.1593205771432;
 Fri, 26 Jun 2020 14:09:31 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:09:09 -0700
In-Reply-To: <20200626210917.358969-1-brendanhiggins@google.com>
Message-Id: <20200626210917.358969-5-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v5 04/12] arch: powerpc: add linker section for KUnit test suites
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

