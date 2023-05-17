Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB5970693D
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 15:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjEQNNS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 09:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjEQNNP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 09:13:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BF283C2;
        Wed, 17 May 2023 06:12:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31D0864703;
        Wed, 17 May 2023 13:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7145AC4331F;
        Wed, 17 May 2023 13:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684329167;
        bh=GzyYzd/7tEPxQhzzg+PJ/PWcyEzzBXzJLcduAakWhaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=niHVPUaD0YGdt5iRkDpEydf7mr631oogoVQvkL81qpJ5TW0/YDUHFkUu/ZKWJdSyH
         WVXjhzTUAGxnOs0Vegl0ZmfHCdPZuJ7YUjlFkitUTUNbJVo7lI5FO1LgLzd52JuqCx
         Wr1JJezEgRxZbp9NdZwExiCGViAREtrVIVavopDauE3wvvOAYNu+BznmFcHd0fJK4u
         wZIaM4wBxCe+a/H0IRCT0p9ml11d7gsP+vlmdEZuhfHUfwxnHCQLwlRz2WmfAlqtqM
         +0195gf2dqreO3HDtP8xhqKkWgE47ff7qay5jg24K0FITidNlAbdN4XuegelYOnMhE
         eS4jr0xmyomCA==
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
Subject: [PATCH 09/14] kunit: include debugfs header file
Date:   Wed, 17 May 2023 15:10:57 +0200
Message-Id: <20230517131102.934196-10-arnd@kernel.org>
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

An extra #include statement is needed to ensure the prototypes
for debugfs interfaces are visible, avoiding this warning:

lib/kunit/debugfs.c:28:6: error: no previous prototype for 'kunit_debugfs_cleanup' [-Werror=missing-prototypes]
lib/kunit/debugfs.c:33:6: error: no previous prototype for 'kunit_debugfs_init' [-Werror=missing-prototypes]
lib/kunit/debugfs.c:102:6: error: no previous prototype for 'kunit_debugfs_create_suite' [-Werror=missing-prototypes]
lib/kunit/debugfs.c:118:6: error: no previous prototype for 'kunit_debugfs_destroy_suite' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/kunit/debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index b08bb1fba106..22c5c496a68f 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -10,6 +10,7 @@
 #include <kunit/test.h>
 
 #include "string-stream.h"
+#include "debugfs.h"
 
 #define KUNIT_DEBUGFS_ROOT             "kunit"
 #define KUNIT_DEBUGFS_RESULTS          "results"
-- 
2.39.2

