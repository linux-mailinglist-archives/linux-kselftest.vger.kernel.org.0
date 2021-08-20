Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121A23F36CC
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Aug 2021 00:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240876AbhHTWvU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Aug 2021 18:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240900AbhHTWvQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Aug 2021 18:51:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6609EC0617AF
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Aug 2021 15:50:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c63-20020a25e5420000b0290580b26e708aso11023906ybh.12
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Aug 2021 15:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Ut0lClAqKM9RGqTS5MESEM+F5WoPZRTQUckNTBRjTyg=;
        b=TA/KEkzCm9eGIgSQhw9KNiaLFa6mERWpjzl8Sm2LP0D8MHshBELhR9PNTUHRE29ifz
         mo90lRoRaNLAOUKwpDqprlo0/pMwtc5l0/AtaGDQuwQPp72yFVvsNL3ynlMO5kSBRj5m
         LzAltW2EylkOxsEkvhRVhVSBOVOdYc11dmbjDqZ/XhKiygxbSFOOyUayIR4kGClbFLgR
         /kFKufJdXalO6BD5koMO2tBk/9JBu0VO4U4stsueIYQrrElmsEUFhO7RIz6hEZLybaDq
         KKumExIW2OSfE2RbrTkormhrvk3570q+R6kLizKIzC3ltGy9bDIK5NfDidM6k/fKRiu/
         zAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Ut0lClAqKM9RGqTS5MESEM+F5WoPZRTQUckNTBRjTyg=;
        b=s5MQIR5QEYVbk3/RvL5cixiIZzg45RYo4a/zSFezx5oW6m2MQPBREQt2EWlw1N11p2
         6jxE9EzzNwyjKC9gpsp+E71t6jFq0ixo2Za7/ApjTXkCe+oamFx6WcoXKR0cgStnIiWR
         jfO5mKuUNz2RheNp3qklw8OABjhLUWikG7Fnr1Ns2O8CdZOvenlzrcHOXdSMIKMCUOql
         EUDK0X8vzRpqTXVH1NT4wogdhtYBTm9RgYcibRZU8juXp2CJHGYiczJAYsTHXp+cshA5
         XuF29fJODIirsp0/N4sxZj2Wc5xkodtH44shSY5HLYczkhqOfCNiA+KLxAORTHjeWruF
         cPfw==
X-Gm-Message-State: AOAM530SibD65gZjL/K/naf/jEC7/Sc0ejcAThAl3OgjuvDKTTXgZEEm
        lygVPcMKh2WpmtYOwExhFGi1n8ursJY=
X-Google-Smtp-Source: ABdhPJx3Gy465odAHrKuwh+xxU3EOcrY9EoPkXADk8KHQbivIS4NsZANbgwhJ1nQlBB3M+0Hs3NCAAyvqg4=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:f11d:a281:af9b:5de6])
 (user=seanjc job=sendgmr) by 2002:a25:acc4:: with SMTP id x4mr8790476ybd.376.1629499835531;
 Fri, 20 Aug 2021 15:50:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 20 Aug 2021 15:50:02 -0700
In-Reply-To: <20210820225002.310652-1-seanjc@google.com>
Message-Id: <20210820225002.310652-6-seanjc@google.com>
Mime-Version: 1.0
References: <20210820225002.310652-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 5/5] KVM: selftests: Remove __NR_userfaultfd syscall fallback
From:   Sean Christopherson <seanjc@google.com>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Foley <pefoley@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Revert the __NR_userfaultfd syscall fallback added for KVM selftests now
that x86's unistd_{32,63}.h overrides are under uapi/ and thus not in
KVM sefltests' search path, i.e. now that KVM gets x86 syscall numbers
from the installed kernel headers.

No functional change intended.

Cc: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/arch/x86/include/uapi/asm/unistd_64.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
index 4205ed4158bf..cb52a3a8b8fc 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_64.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_64.h
@@ -1,7 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __NR_userfaultfd
-#define __NR_userfaultfd 282
-#endif
 #ifndef __NR_perf_event_open
 # define __NR_perf_event_open 298
 #endif
-- 
2.33.0.rc2.250.ged5fa647cd-goog

