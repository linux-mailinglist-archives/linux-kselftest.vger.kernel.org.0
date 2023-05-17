Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4222270695F
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 15:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjEQNN4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 09:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjEQNNo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 09:13:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947EE7D86;
        Wed, 17 May 2023 06:13:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8129642AE;
        Wed, 17 May 2023 13:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19EFC433A0;
        Wed, 17 May 2023 13:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684329206;
        bh=JGGRsTfqJlmibWTBDdmhkqjrT8ru+5vGeLr90vAqN7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sUL++CNilYTKBfXlj2dPw8lmLxduHSA+47PUjO45sLxz4n2hEzFLajiqXD05oRvI8
         26qxQpUDKHthdA9YwLEN/YHntIwAjq5IVk/J7nX75CJFm0yAiW/fp8Unf6Rbj8LRNG
         UuAyk54JKmTtRzRbemmz9tzUGfiyIgAB+TQe5EXHbuj+wPEfM/oRJtkiWyMRQrpic3
         qOjN6jBo+fGjO/IUX/iF6ln8D5N66od5Gncx4RdpQj8+TWomVhhGXJRHHJK3AEjfup
         2fvc0cvn3xNc2dtggIu38wLBvRDjizWLgiEZ0mpy6+j/cgELWKA2rntPrjWLUxoYaK
         TbULgVLN3CPyA==
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
Subject: [PATCH 14/14] time_namespace: always provide arch_get_vdso_data() prototype for vdso
Date:   Wed, 17 May 2023 15:11:02 +0200
Message-Id: <20230517131102.934196-15-arnd@kernel.org>
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

The arch_get_vdso_data() function is defined separately on each architecture,
but only called when CONFIG_TIME_NS is set. If the definition is a global
function, this causes a W=1 warning without TIME_NS:

arch/x86/entry/vdso/vma.c:35:19: error: no previous prototype for 'arch_get_vdso_data' [-Werror=missing-prototypes]

Move the prototype out of the #ifdef block to reliably turn off that
warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/time_namespace.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index bb9d3f5542f8..03d9c5ac01d1 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -44,7 +44,6 @@ struct time_namespace *copy_time_ns(unsigned long flags,
 				    struct time_namespace *old_ns);
 void free_time_ns(struct time_namespace *ns);
 void timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk);
-struct vdso_data *arch_get_vdso_data(void *vvar_page);
 struct page *find_timens_vvar_page(struct vm_area_struct *vma);
 
 static inline void put_time_ns(struct time_namespace *ns)
@@ -163,4 +162,6 @@ static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
 }
 #endif
 
+struct vdso_data *arch_get_vdso_data(void *vvar_page);
+
 #endif /* _LINUX_TIMENS_H */
-- 
2.39.2

