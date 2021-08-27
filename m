Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B163FA1C3
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Aug 2021 01:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhH0XY0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Aug 2021 19:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhH0XYY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Aug 2021 19:24:24 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8336CC0617A8
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Aug 2021 16:23:35 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so5908998pjt.0
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Aug 2021 16:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TQth0zKaZ1g898XhTaLjgqI+BqtTYpmEnIJq3AsLCJk=;
        b=BAuX2ol8F6dvdcYTLPau4K0GBYzUoQCSuqStZCATywk1xJsRcTN/zbnvR40BRHvYRj
         p2MT9UNw+pSe1w4FqYAzJww2vX26GF4Etd+uOuVWgHJFd4agO5hpaKs4rD3Z8IuIiQ64
         bceibC9z39TyoUF5r/ZBJugD41m33rR/4wmX0JjHH4Ox3VO0sQvCLcKc4rCPjZl3kpp/
         z2ewywcdb4obgJrlPAWwwSgAREPIfSw6ixPLrZU+orCqHvOzAJIbsJDGYnOKI/KJzI5+
         MS27DWV8OUcVAL9tLPc5IpbSctooG5g35qhato+7vW1AY9AOSyjT1rpopwB7U0ojjXOG
         jR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TQth0zKaZ1g898XhTaLjgqI+BqtTYpmEnIJq3AsLCJk=;
        b=XZFSY9Cq7mAh1L5+JUt1RGCkMElz82T7lf1SWd+fP0SGp+LCDzGOshKRgEOU5HW8Vi
         saJ3Rmbl/f3RmSd54BMP4tX0LQBICftGTA5doiMF3OQoLsHU7LY2A71dsSvN1hdXJzTg
         Xq0Rlew6v3e5ShoN3bURtuVAL7Nxn+NbjSiBwtoeBCAoGMXivcT/50ZzGH4kE3x0iRcn
         x2pa5c156nFWYC4W0S/fUFPnYLbuVL52tNgwMtGamC7ziAhMUcnrKv331flqIlhU/B71
         janu3o6XhGLkLuFrE81Bh6TYN2sO9mpsLSJvTx7Y9jPozOO1zuYTCLk0jBIaPNdaMfFB
         imgA==
X-Gm-Message-State: AOAM531EOf1QZDTpnSRRJRqgnDInPapfs/LNboKQKOIEa+iiqR/zulXD
        4DOGuAZ0MNumG3bDBj2Fi7AYlw==
X-Google-Smtp-Source: ABdhPJwmCb6NSZOc/5AwINtm/0AHRKcukC2PPcNvrpcQ6DjdUz8MDW9KTFWzGmyEhc2uaUezQAIkrA==
X-Received: by 2002:a17:90a:fe8e:: with SMTP id co14mr10854117pjb.200.1630106614660;
        Fri, 27 Aug 2021 16:23:34 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h13sm7335943pgh.93.2021.08.27.16.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 16:23:33 -0700 (PDT)
Date:   Fri, 27 Aug 2021 23:23:30 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     dvhart <dvhart@infradead.org>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>, gor <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
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
Subject: Re: [PATCH v2 4/5] KVM: selftests: Add a test for KVM_RUN+rseq to
 detect task migration bugs
Message-ID: <YSlz8h9SWgeuicak@google.com>
References: <20210820225002.310652-1-seanjc@google.com>
 <20210820225002.310652-5-seanjc@google.com>
 <766990430.21713.1629731934069.JavaMail.zimbra@efficios.com>
 <282257549.21721.1629732017655.JavaMail.zimbra@efficios.com>
 <YSblqrrpKcORzilX@google.com>
 <1700758714.29394.1630003332081.JavaMail.zimbra@efficios.com>
 <YSgpy8iXXXUQ+b/k@google.com>
 <339641531.29941.1630091374065.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <339641531.29941.1630091374065.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 27, 2021, Mathieu Desnoyers wrote:
> > So there are effectively three reasons we want a delay:
> > 
> >  1. To allow sched_setaffinity() to coincide with ioctl(KVM_RUN) before KVM can
> >     enter the guest so that the guest doesn't need an arch-specific VM-Exit source.
> > 
> >  2. To let ioctl(KVM_RUN) make its way back to the test before the next round
> >     of migration.
> > 
> >  3. To ensure the read-side can make forward progress, e.g. if sched_getcpu()
> >     involves a syscall.
> > 
> > 
> > After looking at KVM for arm64 and s390, #1 is a bit tenuous because x86 is the
> > only arch that currently uses xfer_to_guest_mode_work(), i.e. the test could be
> > tweaked to be overtly x86-specific.  But since a delay is needed for #2 and #3,
> > I'd prefer to rely on it for #1 as well in the hopes that this test provides
> > coverage for arm64 and/or s390 if they're ever converted to use the common
> > xfer_to_guest_mode_work().
> 
> Now that we have this understanding of why we need the delay, it would be good to
> write this down in a comment within the test.

Ya, I'll get a new version out next week.

> Does it reproduce if we randomize the delay to have it picked randomly from 0us
> to 100us (with 1us step) ? It would remove a lot of the needs for arch-specific
> magic delay value.

My less-than-scientific testing shows that it can reproduce at delays up to ~500us,
but above ~10us the reproducibility starts to drop.  The bug still reproduces
reliably, it just takes more iterations, and obviously the test runs a bit slower.

Any objection to using a 1-10us delay, e.g. a simple usleep((i % 10) + 1)?
