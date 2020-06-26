Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615C920BB23
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jun 2020 23:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgFZVKV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Jun 2020 17:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgFZVJa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Jun 2020 17:09:30 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD93C03E97E
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jun 2020 14:09:30 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id a9so6636900plp.5
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jun 2020 14:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hiFp+uoptqOZ2rqi90LxI+MqGbDbXrg3yHQVzKDmQQ4=;
        b=jebeIARZ4MbpC/qohszlae0SxIiUjfS+aHdsgRsyl+nDoZ13dCApmFMyUJeVDOsHAY
         KIcGcHJ+1BS4bpjJljRbXhZa/cLiJQCxIz3INsZbN4Us+V8lP8TK5psKf814t/EGk6wE
         pXdYgr4IlD1bc5vMRTxWpR8bW/X9rqzObf6oG1rnxRKPcgwcVlXdkP64PXWb7NSXT5a6
         NEtpZlVx+hSr8lknL1TKy8c7BgSEPoFVGkkI3sTvx7LhXrKgu9GToCMGaLH+nZo8xo8H
         YHmDwLXC56KXjbSBDnypaQ9i4502TKmtFeLoqT6X6hTKa14dhV4gfc4ThT1/79Jdq8SS
         8zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hiFp+uoptqOZ2rqi90LxI+MqGbDbXrg3yHQVzKDmQQ4=;
        b=tBGrNpCyYwp2xgtA9ja9u85nRv0v63Ltjeiqcl6cBZO5LbVw8RdoDZYH5QbgxXfBzf
         OXNJK0SInq46dScLX//tAJnTKA2FQbU086NW44f1CdE3c5Rm8W0lfQ0y2/XEv255l+NB
         tu5tPY9kJa/BgJbQflGeKC90br23kucw984BNautS7xO/NbQkt0Ww1jSCQ5RKCjcsWw4
         ncnbJZolR86C02T7szAKRKuh8JzshxdzDtqmYIiuhCVi9zmO+xw8Z80hmOAzda4arBcc
         DH08oqRHJNvTvF1tYyj6gzBLyWrVdkgADYcsRdF1cGPDURMyLWtKAnFCGBA6wiG6bA7p
         9mUA==
X-Gm-Message-State: AOAM533WK5oYZvHMo/DUWfc4vuvr9VFtb6szj9g2IC8syDw+46TuTgpg
        PX9oSRwhDzg8lbbm+nAqddvgpVZOju6SMgefIDquAg==
X-Google-Smtp-Source: ABdhPJxSwQ68iEnNXkgolra98q2cg2bDfdpdwE62xg8GhSSGsb9iaN0w7iVXuEbw7sVWlA1D/tARVHhauyHs3D3fWH+8JQ==
X-Received: by 2002:a17:90a:f206:: with SMTP id bs6mr5554851pjb.48.1593205769580;
 Fri, 26 Jun 2020 14:09:29 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:09:08 -0700
In-Reply-To: <20200626210917.358969-1-brendanhiggins@google.com>
Message-Id: <20200626210917.358969-4-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v5 03/12] arch: microblaze: add linker section for KUnit test suites
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

Add a linker section to microblaze where KUnit can put references to its
test suites. This patch is an early step in transitioning to dispatching
all KUnit tests from a centralized executor rather than having each as
its own separate late_initcall.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 arch/microblaze/kernel/vmlinux.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
index df07b3d06cd6b..4fc32f8979a60 100644
--- a/arch/microblaze/kernel/vmlinux.lds.S
+++ b/arch/microblaze/kernel/vmlinux.lds.S
@@ -128,6 +128,10 @@ SECTIONS {
 
 	__init_end = .;
 
+	.kunit_test_suites : {
+		KUNIT_TEST_SUITES
+	}
+
 	.bss ALIGN (PAGE_SIZE) : AT(ADDR(.bss) - LOAD_OFFSET) {
 		/* page aligned when MMU used */
 		__bss_start = . ;
-- 
2.27.0.212.ge8ba1cc988-goog

