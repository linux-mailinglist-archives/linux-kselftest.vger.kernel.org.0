Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27051706908
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 15:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjEQNMC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 09:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjEQNL7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 09:11:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256615264;
        Wed, 17 May 2023 06:11:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99AA764712;
        Wed, 17 May 2023 13:11:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB3FC433A0;
        Wed, 17 May 2023 13:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684329114;
        bh=9B5dm6uPcP99pu9DbgwVzUA/R+xqpwJ+x8zkV0/Vqc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KeFwGIi38GKw31XBFip9DpSNaAPrSt+ly1tSHZlHJrUQWVYjO1Fj/sEgW+9BoVS0P
         1CrH3z3kj7gZ+Vr3uvhUt8V+7wc31EPrn9XE0ouppLIc4CVNNyDqrxV3hSyS0OYCcT
         l6bP27FiyG5vaBbcs1CEMoLgy4FK3NoP8/k/lHQ4NbbcS554m3wfxgTcIxR8LnL/1k
         w4FDAsAOVUKikEub9HmaUUnNVrFTBKOFClJ6tqzPc8F5THSvUHsl1wW7KSrODpL1Hc
         vIHWM9fXWcirhdtfcUUfuWVrVUe5drsdLKZft1YCHcGKupFyIGgZk3oWSTFEILf4s7
         1sLZ52Eo3Zk7g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        audit@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [PATCH 02/14] mm: page_poison: always declare __kernel_map_pages() function
Date:   Wed, 17 May 2023 15:10:50 +0200
Message-Id: <20230517131102.934196-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230517131102.934196-1-arnd@kernel.org>
References: <20230517131102.934196-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The __kernel_map_pages() function is mainly used for
CONFIG_DEBUG_PAGEALLOC, but has a number of architecture specific
definitions that may also be used in other configurations, as well
as a global fallback definition for architectures that do not support
DEBUG_PAGEALLOC.

When the option is disabled, any definitions without the prototype
cause a warning:

mm/page_poison.c:102:6: error: no previous prototype for '__kernel_map_pages' [-Werror=missing-prototypes]

The function is a trivial nop here, so just declare it anyway
to avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/mm.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 27ce77080c79..e95d7c575ea6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3453,13 +3453,12 @@ static inline bool debug_pagealloc_enabled_static(void)
 	return static_branch_unlikely(&_debug_pagealloc_enabled);
 }
 
-#ifdef CONFIG_DEBUG_PAGEALLOC
 /*
  * To support DEBUG_PAGEALLOC architecture must ensure that
  * __kernel_map_pages() never fails
  */
 extern void __kernel_map_pages(struct page *page, int numpages, int enable);
-
+#ifdef CONFIG_DEBUG_PAGEALLOC
 static inline void debug_pagealloc_map_pages(struct page *page, int numpages)
 {
 	if (debug_pagealloc_enabled_static())
-- 
2.39.2

