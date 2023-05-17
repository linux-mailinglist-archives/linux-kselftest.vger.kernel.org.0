Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CAD706920
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 15:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjEQNMg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 09:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjEQNMd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 09:12:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA2583D0;
        Wed, 17 May 2023 06:12:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F93E64703;
        Wed, 17 May 2023 13:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81DCC433A7;
        Wed, 17 May 2023 13:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684329137;
        bh=7NFY4e1GRdJpBgrCbtxoc1LfzebP5DErPZUbazdtedA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tyU1+/JQyb06JHCoISP/aGPwtCQn0y+G2NG5LZRAoqMZ2rrQjRXynp/TD2rSNP+yu
         1MAgn39GOwDx0XjC/LCCoz8eWqzWrh1MPxapDvHcn+PH1s06DifD+01A3XTAew1Xad
         7kiU/kNm6uC/vwrOUnFMNzz/s1aP2ZTB5AZ44+nRwW23Ewv7Oudccx2C7eFBMHX70o
         bRraU85jXL9lIeSgOiof8kzLy3rFvqHD/NGDlZjQWIMKbB80Ds7TOcR89bmpDrx2M6
         DjfDS8BLtKEoQUWgQ9ZjdRzMuh416rmJ35iErYbPeR1Cy3wac2W8wJ0tUTeKW2RkF7
         Kn4dcDyi8DEBA==
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
Subject: [PATCH 05/14] lib: devmem_is_allowed: include linux/io.h
Date:   Wed, 17 May 2023 15:10:53 +0200
Message-Id: <20230517131102.934196-6-arnd@kernel.org>
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

The devmem_is_allowed() function is defined in a file of the same name,
but the declaration is in asm/io.h, which is not included there, causing
a W=1 warning:

lib/devmem_is_allowed.c:20:5: error: no previous prototype for 'devmem_is_allowed' [-Werror=missing-prototypes]

Include the appropriate header to avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/devmem_is_allowed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/devmem_is_allowed.c b/lib/devmem_is_allowed.c
index 60be9e24bd57..9c060c69f134 100644
--- a/lib/devmem_is_allowed.c
+++ b/lib/devmem_is_allowed.c
@@ -10,6 +10,7 @@
 
 #include <linux/mm.h>
 #include <linux/ioport.h>
+#include <linux/io.h>
 
 /*
  * devmem_is_allowed() checks to see if /dev/mem access to a certain address
-- 
2.39.2

