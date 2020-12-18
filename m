Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0359A2DEB54
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Dec 2020 22:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgLRV7D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Dec 2020 16:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgLRV7C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Dec 2020 16:59:02 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CEEC0617A7
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Dec 2020 13:58:21 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id 6so5339032ejz.5
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Dec 2020 13:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=awSkLxPxfKKMYWXrPvJO5HFC6rX6G+L4B8C1Llf9W6k=;
        b=hLBV/ED7BfeJwzOqpNCmMYChlwoFiY2KhYRYAh9YAvNmhTCp5Rl5vOtjXE5lcygy6P
         xGW8sekB6mt/nykunGGg68jfMt3kl8nI0XjHiLHAw/Jl44bdjco/2PBUvN8fBn5kDwON
         gE1GN8Dxfx9SDSEZCsA/rAzWdaPWuRJucgTnKWiNxbhGi9kV9JTK9FfS9yflDIleezEV
         bNojTL0m3+dL9+Bw8KoCwccFevhvpilw/9ImOHE0xnU4wNOK7nlI50q9eVjVevAIbBH7
         jimQcsulIbzCWqGNVfNFRrbVZ+LrmM/3NVINZEg9b1lVwrhdpKkWdJLhFQIZGVrqeCxa
         DBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=awSkLxPxfKKMYWXrPvJO5HFC6rX6G+L4B8C1Llf9W6k=;
        b=IuAze9xRHCj4aDpQNDvrUXZpzEIrBsKk3PuzoV3MebVF8ZxugDObL6UTWp/WT/geoS
         RL2InO7EYZc6uzddCUbYsQzF+JAjvpC0Ecw5ly3csKp6pONII/ZmM435wOTp0AGFi9HQ
         /tgOX24daFviBk9NQPbL+AV1oWwrhYUZ0Llowiry2rhYrax33PsaaIaD4Bv92EtLjOLh
         0ZiJ+rbH/yS/26flb7YvTiOegXQBOe2zfIgj4RnMzRlxRriTciuwMD1N8iAwppv2NxV+
         V2rWy0YiCFAMp9gr7/DbUjT56OH6GACYuKRsB9QjGBLhccEjSmj7PETwzh1BruPQkLWG
         6KXA==
X-Gm-Message-State: AOAM533eCHz+LWvkJG8Yg4eFD79VeXlpFmHm5mSLF6JhPgO0GKUJcj+5
        bxmHf4uneqc2l71J1CJy2LA6NRbx2FcwyD4uyGe3AQ==
X-Google-Smtp-Source: ABdhPJw+WBaQpu6K/EP/XCCpxET87+bULI/RU+iA1GSA2CpDe3vqce08alBcHTx2GShwo2pEUBLYdR2k0/3Rq4IDZN0=
X-Received: by 2002:a17:906:edb2:: with SMTP id sa18mr5756613ejb.264.1608328700420;
 Fri, 18 Dec 2020 13:58:20 -0800 (PST)
MIME-Version: 1.0
References: <20201106232908.364581-1-ira.weiny@intel.com> <20201106232908.364581-5-ira.weiny@intel.com>
 <871rfoscz4.fsf@nanos.tec.linutronix.de> <87mtycqcjf.fsf@nanos.tec.linutronix.de>
 <878s9vqkrk.fsf@nanos.tec.linutronix.de> <CAPcyv4h2MvybBi==3uzAjGeW0R7azHYSKwmvzMXq9eM8NzMLEg@mail.gmail.com>
 <875z4yrfhr.fsf@nanos.tec.linutronix.de>
In-Reply-To: <875z4yrfhr.fsf@nanos.tec.linutronix.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Dec 2020 13:58:09 -0800
Message-ID: <CAPcyv4gqm5p+pVmX4JL0fT2LY0dfoT+UXAfsGLA9LMr42vp33A@mail.gmail.com>
Subject: Re: [PATCH V3 04/10] x86/pks: Preserve the PKRS MSR on context switch
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Weiny, Ira" <ira.weiny@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 18, 2020 at 1:06 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, Dec 18 2020 at 11:20, Dan Williams wrote:
> > On Fri, Dec 18, 2020 at 5:58 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > [..]
> >>   5) The DAX case which you made "work" with dev_access_enable() and
> >>      dev_access_disable(), i.e. with yet another lazy approach of
> >>      avoiding to change a handful of usage sites.
> >>
> >>      The use cases are strictly context local which means the global
> >>      magic is not used at all. Why does it exist in the first place?
> >>
> >>      Aside of that this global thing would never work at all because the
> >>      refcounting is per thread and not global.
> >>
> >>      So that DAX use case is just a matter of:
> >>
> >>         grant/revoke_access(DEV_PKS_KEY, READ/WRITE)
> >>
> >>      which is effective for the current execution context and really
> >>      wants to be a distinct READ/WRITE protection and not the magic
> >>      global thing which just has on/off. All usage sites know whether
> >>      they want to read or write.
> >
> > I was tracking and nodding until this point. Yes, kill the global /
> > kmap() support, but if grant/revoke_access is not integrated behind
> > kmap_{local,atomic}() then it's not a "handful" of sites that need to
> > be instrumented it's 100s. Are you suggesting that "relaxed" mode
> > enforcement is a way to distribute the work of teaching driver writers
> > that they need to incorporate explicit grant/revoke-read/write in
> > addition to kmap? The entire reason PTE_DEVMAP exists was to allow
> > get_user_pages() for PMEM and not require every downstream-GUP code
> > path to specifically consider whether it was talking to PMEM or RAM
> > pages, and certainly not whether they were reading or writing to it.
>
> kmap_local() is fine. That can work automatically because it's strict
> local to the context which does the mapping.
>
> kmap() is dubious because it's a 'global' mapping as dictated per
> HIGHMEM. So doing the RELAXED mode for kmap() is sensible I think to
> identify cases where the mapped address is really handed to a different
> execution context. We want to see those cases and analyse whether this
> can't be solved in a different way. That's why I suggested to do a
> warning in that case.
>
> Also vs. the DAX use case I really meant the code in fs/dax and
> drivers/dax/ itself which is handling this via dax_read_[un]lock.
>
> Does that make more sense?

Yup, got it. The dax code can be precise wrt to PKS in a way that
kmap_local() cannot.
