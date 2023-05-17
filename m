Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13208706946
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 15:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjEQNNb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 09:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjEQNN2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 09:13:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540ED30C8;
        Wed, 17 May 2023 06:13:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD1146470B;
        Wed, 17 May 2023 13:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC7AC433A1;
        Wed, 17 May 2023 13:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684329175;
        bh=jyfIU4kb2iohIZExECeJDgccrpywO2d4N5RO4/Lz9/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a5AKMGQ6H8c4SmWJA9acjTbaFCzZ0AA2wm05BPlzt7RdfOUiogdQAYWE+G+NGcZdX
         yDjsODiNdpDTqKlvtQXPCuaGA3VC6/f234nMehw9xGV/czmg096DJmqiZsDf12qqFe
         ej546ikNtCrc67wnEUFw1c3f59H4n265vxwBWYFw7f1ACFpU/dNvgnfSCj3KARvmhc
         okU5JO6mfHibgPJap1ViK2c3byQdkDKbjHgzIgRlSYBev2T0JJyKlGkP2OUNIdoni8
         hQe43lij086yvsSwf3Lz908iMLuTejdjlTVVg35FM3ecRVrHkCom9/KKxw7ZIB2uTs
         DJJKGGvs0X6mw==
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
Subject: [PATCH 10/14] suspend: add a arch_resume_nosmt() prototype
Date:   Wed, 17 May 2023 15:10:58 +0200
Message-Id: <20230517131102.934196-11-arnd@kernel.org>
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

The arch_resume_nosmt() has a __weak definition, plus an x86
specific override, but no prototype that ensures the two have
the same arguments. This causes a W=1 warning:

arch/x86/power/hibernate.c:189:5: error: no previous prototype for 'arch_resume_nosmt' [-Werror=missing-prototypes]

Add the prototype in linux/suspend.h, which is included in
both places.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/suspend.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index f16653f7be32..bc911fecb8e8 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -472,6 +472,8 @@ static inline int hibernate_quiet_exec(int (*func)(void *data), void *data) {
 }
 #endif /* CONFIG_HIBERNATION */
 
+int arch_resume_nosmt(void);
+
 #ifdef CONFIG_HIBERNATION_SNAPSHOT_DEV
 int is_hibernate_resume_dev(dev_t dev);
 #else
-- 
2.39.2

