Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CFF3FE40D
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Sep 2021 22:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242123AbhIAUbz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Sep 2021 16:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbhIAUbl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Sep 2021 16:31:41 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9407C061796
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Sep 2021 13:30:43 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id e6-20020ac84e46000000b0029baad9aaa0so829293qtw.11
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Sep 2021 13:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ldLSFjRoxMWlt0z49+aeceHGSPi4XGtx99N0OsyVmLE=;
        b=BuHas1hm2XV6S0WdY0vNJtMNKqcbhhJlqEs2KKd8pR2ZtVSZyXdrExnzC9yAzti+6M
         zsB0cZ6yGgy/LCmNQnoE9irvXv0l/kef17MuyVLZuyUIXQLsQAVBMnkjctlzTiQS2gFl
         nNVPpGt/BljIuuR8Np2F3JcMLpOT4q13le7u3t9xGN/31GLNQRRtmxFcq3gYSrgx4SpD
         JLqZCUeYueQLMr1QYaYrnsCaSoHnKr/g+VU1g+qoQeBj0TaKLOTWsdjiTXJZ47hEuUNE
         YXZcuSxN1X/sa6HR56VO6THXVndPm08u7aBj1ZanEP006m9Dcu8OtsWgR2jBGDkZu34R
         vcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ldLSFjRoxMWlt0z49+aeceHGSPi4XGtx99N0OsyVmLE=;
        b=V8vjYrh/LenrvN7lrqdyRPUWKgeIuhaRWVDNexp9DaLaECQPyk9M5z+A67TM3R2gBJ
         TnvyXCPavshFPsH+PCu+54EQTeRm7noPE/X/vBUwkViBt0HRgaMjkAZn4Lf0b5UhAays
         EeMgVyhJyOEXckmg3LmkPdK2/q+t/8u8miTvilUeXh26M4StW4wv9fulretB0fUc5hgR
         Tg3I2kscWA4K+josfA3Y/9PAhOJQRO5WL3OlXiEKhaKcIpxQkSDYRZLTA6Jr7xPQ9J4t
         oUtd6PdC4kLW6EAke9uBtv5nZqJ6XC9P2DL+edjBGnNKIseKAFeoxtZKlMxw8lBUV/jZ
         DnvA==
X-Gm-Message-State: AOAM531o3ExdXozf+eVfKrNIDGUm58nDj2T+n53n7h6lb9/uB9DakwfK
        c+JgzKAzWmg7wI87MqF709/fZZJj84M=
X-Google-Smtp-Source: ABdhPJzwgN7oneIBzjWgEYG1ij6WsGK4rMhOwP5dDZ6ynvgYB+9os0mc0YRgyTvPGpS3N44mYcHSnTxodu4=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:9935:5a5e:c7b6:e649])
 (user=seanjc job=sendgmr) by 2002:a05:6214:92b:: with SMTP id
 dk11mr1719346qvb.46.1630528242737; Wed, 01 Sep 2021 13:30:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  1 Sep 2021 13:30:28 -0700
In-Reply-To: <20210901203030.1292304-1-seanjc@google.com>
Message-Id: <20210901203030.1292304-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210901203030.1292304-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v3 3/5] tools: Move x86 syscall number fallbacks to .../uapi/
From:   Sean Christopherson <seanjc@google.com>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
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
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Peter Foley <pefoley@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Move unistd_{32,64}.h from x86/include/asm to x86/include/uapi/asm so
that tools/selftests that install kernel headers, e.g. KVM selftests, can
include non-uapi tools headers, e.g. to get 'struct list_head', without
effectively overriding the installed non-tool uapi headers.

Swapping KVM's search order, e.g. to search the kernel headers before
tool headers, is not a viable option as doing results in linux/type.h and
other core headers getting pulled from the kernel headers, which do not
have the kernel-internal typedefs that are used through tools, including
many files outside of selftests/kvm's control.

Prior to commit cec07f53c398 ("perf tools: Move syscall number fallbacks
from perf-sys.h to tools/arch/x86/include/asm/"), the handcoded numbers
were actual fallbacks, i.e. overriding unistd_{32,64}.h from the kernel
headers was unintentional.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/arch/x86/include/{ => uapi}/asm/unistd_32.h | 0
 tools/arch/x86/include/{ => uapi}/asm/unistd_64.h | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename tools/arch/x86/include/{ => uapi}/asm/unistd_32.h (100%)
 rename tools/arch/x86/include/{ => uapi}/asm/unistd_64.h (100%)

diff --git a/tools/arch/x86/include/asm/unistd_32.h b/tools/arch/x86/include/uapi/asm/unistd_32.h
similarity index 100%
rename from tools/arch/x86/include/asm/unistd_32.h
rename to tools/arch/x86/include/uapi/asm/unistd_32.h
diff --git a/tools/arch/x86/include/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
similarity index 100%
rename from tools/arch/x86/include/asm/unistd_64.h
rename to tools/arch/x86/include/uapi/asm/unistd_64.h
-- 
2.33.0.153.gba50c8fa24-goog

