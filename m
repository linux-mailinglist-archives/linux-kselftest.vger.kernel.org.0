Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810DC706900
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 15:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjEQNLv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 09:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjEQNLt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 09:11:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736C235A5;
        Wed, 17 May 2023 06:11:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1A416125C;
        Wed, 17 May 2023 13:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C17AC433A1;
        Wed, 17 May 2023 13:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684329106;
        bh=3mI163DMR4d+cuXu5u65rsW45kyqp2CKp+3eSlb6arE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fc6SUEmSZTQUkEUQjfQXj6txmruIJCzCuO4Ae3j0P53kfZPDs/OWZkdHVUzrtWv5M
         0rPrYmGV3lkc2LdVoiXnN0tesbaj+I+HdnU+5OYNZ19tKdQSCcQFdCfF7CIjRf43g3
         HHrOqIEp3ibRRhUsGRDH+Iul9ef7vI7xGy9SOg7wZXkSxKf5Bbrmmph902wZT+4dAO
         hkBdrDx6I/lx0He0nfCXC9E/60W8qZMraYv4eYeOaM6lvyD6ZDXWH5H+onPY0eEF1E
         Z4hxRtdg3qOggQ4VULZzLpo6PInRLslC9REuvbQ434IZjCDyjjo139W2Et9i6tb9pM
         t75TKQPb0GvKQ==
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
Subject: [PATCH 01/14] mm: percpu: unhide pcpu_embed_first_chunk prototype
Date:   Wed, 17 May 2023 15:10:49 +0200
Message-Id: <20230517131102.934196-2-arnd@kernel.org>
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

This function is called whenever CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK
or CONFIG_HAVE_SETUP_PER_CPU_AREA, but only declared when the
former is set:

mm/percpu.c:3055:12: error: no previous prototype for 'pcpu_embed_first_chunk' [-Werror=missing-prototypes]

There is no real point in hiding declarations, so just remove
the #ifdef here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/percpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 1338ea2aa720..42125cf9c506 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -103,12 +103,10 @@ extern void __init pcpu_free_alloc_info(struct pcpu_alloc_info *ai);
 extern void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
 					 void *base_addr);
 
-#ifdef CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK
 extern int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
 				size_t atom_size,
 				pcpu_fc_cpu_distance_fn_t cpu_distance_fn,
 				pcpu_fc_cpu_to_node_fn_t cpu_to_nd_fn);
-#endif
 
 #ifdef CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK
 void __init pcpu_populate_pte(unsigned long addr);
-- 
2.39.2

