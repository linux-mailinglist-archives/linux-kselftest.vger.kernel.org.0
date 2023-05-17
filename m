Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3993F70692E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 15:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjEQNND (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 09:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjEQNMz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 09:12:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F295365AA;
        Wed, 17 May 2023 06:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5FDA64714;
        Wed, 17 May 2023 13:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335BEC433EF;
        Wed, 17 May 2023 13:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684329152;
        bh=wIpq6dQ3SrZ+OFpGPswN9m0xaTqULZnHSrUinkSrQZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sXIvKHQgTrqznMJvGuTDhX84E9WFuYptr8V3Ek7xw2qzSKUVOylJd5AIRFHWD43cs
         rY9FXAfbijzhcRJ7xB3TlUNAPXZltMOT2Gu4HfBs6rSenBQe9xDB/DkigljyzJ5y0q
         NqniEOZEjINgmXRhB2DOJQVMCw6aB5m5fkNbmxq0hQ2kjVyy2Rz5uAkz1lxR6GK/pc
         kmDhZQgZnArP9xfDPRLQii+MbSH3WYm82+2YK1Gsm9qH0+4zeAr7ziGBnxhAtpe3t7
         S5c12dcl36AQVcUIP/lTS5gtzL2FAYQNXRSkp6OFpQMsIrlhIqSx17r+jWyW/eaEgJ
         v4/2vi76yp1wQ==
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
Subject: [PATCH 07/14] panic: hide unused global functions
Date:   Wed, 17 May 2023 15:10:55 +0200
Message-Id: <20230517131102.934196-8-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230517131102.934196-1-arnd@kernel.org>
References: <20230517131102.934196-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Building with W=1 shows warnings about two functions that have
no declaration or caller in certain configurations:

kernel/panic.c:688:6: error: no previous prototype for 'warn_slowpath_fmt' [-Werror=missing-prototypes]
kernel/panic.c:710:6: error: no previous prototype for '__warn_printk' [-Werror=missing-prototypes]

Enclose the definition in the same #ifdef check as the declaration.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/panic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 886d2ebd0a0d..10effe40a3fa 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -684,6 +684,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 	add_taint(taint, LOCKDEP_STILL_OK);
 }
 
+#ifdef CONFIG_BUG
 #ifndef __WARN_FLAGS
 void warn_slowpath_fmt(const char *file, int line, unsigned taint,
 		       const char *fmt, ...)
@@ -722,8 +723,6 @@ void __warn_printk(const char *fmt, ...)
 EXPORT_SYMBOL(__warn_printk);
 #endif
 
-#ifdef CONFIG_BUG
-
 /* Support resetting WARN*_ONCE state */
 
 static int clear_warn_once_set(void *data, u64 val)
-- 
2.39.2

