Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E38706928
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 15:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjEQNMz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 09:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjEQNMq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 09:12:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26F57AB8;
        Wed, 17 May 2023 06:12:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AAAC6470F;
        Wed, 17 May 2023 13:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF66C4339C;
        Wed, 17 May 2023 13:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684329144;
        bh=gekqQcdwspAqcYmV4wkiul0gbNa5okADC3lRsox7SxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hhmQcB6Wb+ZcCRzLdjmx7/zFED4SNzs0NBaokc4G4Ef+SjGqplVRCUUlj8VOql7xc
         tVzUvC/YohY4HXanpHjF8gzBHtwkxcmoYXP+MIQ4qBiVNrFkbviwAVNhlQFEM5aG9z
         u0KG2wrGCIiO4fxkS7CsDg7SKssZvao8JQ1WexuQEtCpz47qaTuW3Z1bOQL/MmRcVt
         J43Gz9r687q17jYwvjwLN9fs0kn3xObEo5/anSq7dT5iAh0lVVtxnk6xLq54trRwvy
         bwp4gagapMiXtQeSik0KOYf0nVPAhKydrIyt2a5DIE7rfoyB8tfvUPUW3O+QL/VQu3
         AKt6l4x3F+ppA==
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
Subject: [PATCH 06/14] locking: add lockevent_read() prototype
Date:   Wed, 17 May 2023 15:10:54 +0200
Message-Id: <20230517131102.934196-7-arnd@kernel.org>
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

lockevent_read() has a __weak definition and the only caller in
kernel/locking/lock_events.c, plus a strong definition in qspinlock_stat.h
that overrides it, but no other declaration. This causes a W=1
warning:

kernel/locking/lock_events.c:61:16: error: no previous prototype for 'lockevent_read' [-Werror=missing-prototypes]

Add shared prototype to avoid the warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/locking/lock_events.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/locking/lock_events.h b/kernel/locking/lock_events.h
index 8c7e7d25f09c..a6016b91803d 100644
--- a/kernel/locking/lock_events.h
+++ b/kernel/locking/lock_events.h
@@ -57,4 +57,8 @@ static inline void __lockevent_add(enum lock_events event, int inc)
 #define lockevent_cond_inc(ev, c)
 
 #endif /* CONFIG_LOCK_EVENT_COUNTS */
+
+ssize_t lockevent_read(struct file *file, char __user *user_buf,
+		       size_t count, loff_t *ppos);
+
 #endif /* __LOCKING_LOCK_EVENTS_H */
-- 
2.39.2

