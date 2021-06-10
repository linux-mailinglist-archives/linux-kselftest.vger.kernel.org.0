Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8475A3A3202
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jun 2021 19:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhFJR2a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Jun 2021 13:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbhFJR22 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Jun 2021 13:28:28 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC19C0617A8
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Jun 2021 10:26:15 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id r198so4428741lff.11
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Jun 2021 10:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=onW47ZbFH5e5HdlUoVPNuscSOQqX/2SrpfD9q95JllY=;
        b=b6hzP0YccRsWRRzU9ACpHmsFQnmYuaVTbX3pLJrVClZpmJ8BdQEY4NyzcB+e9HkDWy
         NC09VOvmFwa0/XSiTVEsk5yJuCNs+bQIW3AIZ02R9sahMKur9D08Bgr3lJ/OhJRtLD1o
         BlYEX0xLTOySTV9lBOztJD3qJAdsp/6IHVAqlgN264WrwRKJy5jiyfY2YODTbTv50eZm
         HagnQMsvfTQIbob7ncuANB6LsQf7XAFdg0eqOnkqhq7Zz2bDCxMdB+xv1sthskhngNbZ
         UBLuUJ4UMHWPJP6okHwkretFYjIcBoI+l5AuDgK1Gl+KtZaAOhvO85V10T2j4GFhFYmw
         bEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=onW47ZbFH5e5HdlUoVPNuscSOQqX/2SrpfD9q95JllY=;
        b=OdFWHjO0Fgy+YPQe7E0gbNZrTV/vzgh/mBOD55Y/qFU+Rn+r+YMhI2Gjq2tbVJmyWB
         hW/9UxATlGijdYpHvBq2mv1p37K7UmxTAAO0uf3McoQgvyTs5HfwcBwNQjPLI//dRLZH
         JXSQeHKyN6rrnoIgfwVw1SRd8nlEAk3EWt3He2PGzzT79QlkrUv0ae8WwHbtO+ZeXa/C
         dnmbUaxFbPBxPmf6sEA+oFjz8Eqn6NWSF/s1LYWLmhES7G4XP+3YjF7cJh9T7HlkYeK6
         oBPCMraU2nXd4xk4zp15OilyyCWZkz5sRnrT5V+WW1uc6laZBi64bJS5d1GLA0s8K+br
         XH/A==
X-Gm-Message-State: AOAM532wL55pf8RZK0ICRebssh4jkdYFX9VkaGlg8L36CmKUVmMD5y6M
        bzAN5XemSRQnOxewVvwMFikf/gvFdO1E3CdiCzY05A==
X-Google-Smtp-Source: ABdhPJz8EC2IEZhB34cW1A4E6Lqer1JPVsXnD5iNMnq9sh79Ry5VJrolXUt5s8cOLAUMW6xiM1HrMzx1A5MFg25P0eQ=
X-Received: by 2002:a05:6512:3ea:: with SMTP id n10mr2582051lfq.178.1623345973683;
 Thu, 10 Jun 2021 10:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210603211426.790093-1-jingzhangos@google.com>
 <20210603211426.790093-3-jingzhangos@google.com> <e3b2b3ab-88a2-827c-7775-10be63158ff3@redhat.com>
In-Reply-To: <e3b2b3ab-88a2-827c-7775-10be63158ff3@redhat.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Thu, 10 Jun 2021 12:26:01 -0500
Message-ID: <CAAdAUtg638Fk9QVAdZ0Xt96YS311KCfeJqNiP5FycCMafZ3R0A@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] KVM: stats: Add fd-based API to read binary stats data
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Paolo,

On Thu, Jun 10, 2021 at 11:23 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 03/06/21 23:14, Jing Zhang wrote:
> > +#define DEFINE_VM_STATS_DESC(...) {                                         \
> > +     STATS_DESC_COUNTER("remote_tlb_flush"),                                \
> > +     ## __VA_ARGS__                                                         \
> > +}
> > +
> > +#define DEFINE_VCPU_STATS_DESC(...) {                                               \
> > +     STATS_DESC_COUNTER("halt_successful_poll"),                            \
> > +     STATS_DESC_COUNTER("halt_attempted_poll"),                             \
> > +     STATS_DESC_COUNTER("halt_poll_invalid"),                               \
> > +     STATS_DESC_COUNTER("halt_wakeup"),                                     \
> > +     STATS_DESC_TIME_NSEC("halt_poll_success_ns"),                          \
> > +     STATS_DESC_TIME_NSEC("halt_poll_fail_ns"),                             \
> > +     ## __VA_ARGS__                                                         \
>
> Let's instead put this (note it's without braces) in macros like these
>
> #define KVM_GENERIC_VM_STATS()                                                  \
>         STATS_DESC_COUNTER("remote_tlb_flush"),
>
> #define KVM_GENERIC_VCPU_STATS(...)                                             \
>         STATS_DESC_COUNTER("halt_successful_poll"),                             \
>         STATS_DESC_COUNTER("halt_attempted_poll"),                              \
>         STATS_DESC_COUNTER("halt_poll_invalid"),                                \
>         STATS_DESC_COUNTER("halt_wakeup"),                                      \
>         STATS_DESC_TIME_NSEC("halt_poll_success_ns"),                           \
>         STATS_DESC_TIME_NSEC("halt_poll_fail_ns"),
>
> and it can be used in the arch files.  In fact it can even be added in patch 1 and
> switched to STATS_DESC_* here.
>
> Paolo
>
Sure, will do.

Thank,s
Jing
