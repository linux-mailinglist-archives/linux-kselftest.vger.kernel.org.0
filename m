Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC513F365B
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Aug 2021 00:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhHTWZ5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Aug 2021 18:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhHTWZ5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Aug 2021 18:25:57 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CCCC061756
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Aug 2021 15:25:18 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id m26so9835915pff.3
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Aug 2021 15:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YqTJx2d+rK7r/727Mx+pw0RMm85LxTM+dupa4DkkVUg=;
        b=XMJxhivK8HayiVyEBDemyRelIu51Uql4arICrgl1Xtu+OpldaIQuiN92D0dB+2PvY2
         AoWaNBB7KO7F5FKoudHlgDL/hNd8A+FowUsdw3wL6BDm/iTL4Cc6YiTOferscwepyuQG
         9XzUtw99s5/KFwywXDFpqMheslrF3wDRzL/P2DgSQRR0RtQLiklqmvKdqBE5L3ZAbbaZ
         dmEsmdra+vDsgdRhVivluTSEwsP4y90ta1vlg9CE5AvtSTW6wIrc35O7x62Y6nnvox8U
         jQS6/7VhaJmZu5wZ3xMtHYlcMetnl4hW/FqOnidhXXsmNwQLT3BkojygGTev8rmNq1ca
         Ezdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YqTJx2d+rK7r/727Mx+pw0RMm85LxTM+dupa4DkkVUg=;
        b=YapO19reTHxw7UmRRWQemfo0TYityt3AifCE4NmrEQnWeuCCzFN481I78VJzgS1rM/
         SKYohT0GQ6de97Db4/mA5EXeD0hT/chRlcjYsTtj+5ylPohmm+epIWFhK8U676O8rXTi
         LH0rJVcc23k02iqp+07KQT9uANT8aCPRgt339SIMhn26QTcnk1Xp79ZxEmm9c2mvwnx+
         iwh9qiEvUFomOHIW3mpqeaMc/vHD5ZAnvaPXSOQak+eN15ZCmg/N4Ey2LvQUKQ84jm9S
         kSRulwLBFH7XhxKOlqEVYooyZPQOkPhjkcsKEKfgnInoRp85YW1zl6MhOyauqhCUTrap
         EvVA==
X-Gm-Message-State: AOAM533OwsWsDJu5SMN7yj/9CDsP9WZKh71XrQkovAvFoA0avzzAIByi
        vad0N4637fC1PkaASdBYMXnGeg==
X-Google-Smtp-Source: ABdhPJyV4IjFC28xX7oRVRErRr3HUFYCEi0w5LU0UmTHa8mL37R5Jfy+NpSbOUll/e+Fp+fYUTcY5g==
X-Received: by 2002:aa7:864e:0:b0:3e3:439b:c3fc with SMTP id a14-20020aa7864e000000b003e3439bc3fcmr9023525pfo.64.1629498318096;
        Fri, 20 Aug 2021 15:25:18 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id o14sm9367987pgl.85.2021.08.20.15.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 15:25:17 -0700 (PDT)
Date:   Fri, 20 Aug 2021 22:25:11 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>, gor <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>, rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>, shuah <shuah@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-csky <linux-csky@vger.kernel.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Peter Foley <pefoley@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH 4/5] KVM: selftests: Add a test for KVM_RUN+rseq to
 detect task migration bugs
Message-ID: <YSArx+ppjIH+6/uK@google.com>
References: <20210818001210.4073390-1-seanjc@google.com>
 <20210818001210.4073390-5-seanjc@google.com>
 <1540548616.19739.1629409956315.JavaMail.zimbra@efficios.com>
 <YR7qXvnI/AQM10gU@google.com>
 <407716135.20250.1629484298288.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407716135.20250.1629484298288.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 20, 2021, Mathieu Desnoyers wrote:
> I still really hate flakiness in tests, because then people stop caring when they
> fail once in a while. And with the nature of rseq, a once-in-a-while failure is a
> big deal. Let's see if we can use other tricks to ensure stability of the cpu id
> without changing timings too much.

Yeah, zero agrument regarding flaky tests.

> One idea would be to use a seqcount lock.

A sequence counter did the trick!  Thanks much!

> But even if we use that, I'm concerned that the very long writer critical
> section calling sched_setaffinity would need to be alternated with a sleep to
> ensure the read-side progresses. The sleep delay could be relatively small
> compared to the duration of the sched_setaffinity call, e.g. ratio 1:10.

I already had an arbitrary usleep(10) to let the reader make progress between
sched_setaffinity() calls.  Dropping it down to 1us didn't affect reproducibility,
so I went with that to shave those precious cycles :-)  Eliminating the delay
entirely did result in no repro, which was a nice confirmation that it's needed
to let the reader get back into KVM_RUN.

Thanks again!
