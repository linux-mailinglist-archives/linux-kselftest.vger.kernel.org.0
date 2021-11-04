Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27340444E56
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Nov 2021 06:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhKDF1x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Nov 2021 01:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhKDF1w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Nov 2021 01:27:52 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F77C061203
        for <linux-kselftest@vger.kernel.org>; Wed,  3 Nov 2021 22:25:14 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id s186so11758991yba.12
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Nov 2021 22:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OtBceSJb428ILPrgAIwLW6HZ5uojQDi2g0yPmI7b2cQ=;
        b=Eiqy/Mt0qrguQhqd0jsEW9qkY8Q25PX+ioLaqmK/8C29vQ+LJza+En5XMIJ7bDoVyY
         8NMnIRI5x22mBTsLnbzkztCtAXHu+iZdfyZOwpY3p5D3XuynIc06r4BAkyl974AdBiF3
         U0B9M3ryrOWnB8LBMvHx/jPsqmvFqW2jiBxkqXLJyonR4aR+SLkrzXL4spfXm5Gb7B1s
         aV29j9wgXVbQX1pYaXpB8NTedUqDsM/fTNJvpLB5PhREhttxKffuERtfHXaIRnI8jh94
         3xSvbfoirN1QLkcQzvBNLdQriNiN1JYDjHAE9j7GbsDv/xsot4wBC7SyE5Abrqmpy/73
         +oNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OtBceSJb428ILPrgAIwLW6HZ5uojQDi2g0yPmI7b2cQ=;
        b=khQsPZZZ/lu5EPf/f5fpPWri2bfkb7cx4nAyz6jxZ98xBk8So/TAd9Fmona33lOf1k
         LNtH8R+V3HAo9JsWiQBZcHkAHBmCrxYgn7ZYN6MzKp3F8zVGWXqsflUwxBM5qpmwca/n
         FqYlh4NR6YM/HUiXr3zKIP6eYw99CiGTh78/PAjU4ZZuXVXEtkDue7Wu1EFYHiMhobKV
         gRM6fg+LoS9NBzCO+AwRmJvNb4KIaBvMi0rXNbztEZRAm8InsTvUPzorBbkuExyyIhbs
         3aBzFx4Fhb4bF/ZdtXR7eThChyXLOgkCMkKmuf95TDVO62YB7J5FKlkeXnjYoLINR5Z1
         xLEA==
X-Gm-Message-State: AOAM533DcUrlu7NVR4eOO2cRsmHo63jHlK8w4/KAWUyOXWgXAEiqMppU
        UCzaaFXBNU0Ra91E1oV1nVqyT2pj0klQtwVKasxXhQ==
X-Google-Smtp-Source: ABdhPJzyZRyz+P/9gdUPVZ2JsSGreOqCWZF1woTxfMn3Tgx7LW6epzWNKfujPYCHXJKB/3LlgasNGr1WrHXIQcRH7GE=
X-Received: by 2002:a25:d4d5:: with SMTP id m204mr19280771ybf.418.1636003513823;
 Wed, 03 Nov 2021 22:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211005234459.430873-1-michael.roth@amd.com> <20211006203710.13326-1-michael.roth@amd.com>
 <CAA03e5EmnbpKOwfNJUV7fog-7UpJJNpu7mQYmCODpk=tYfXxig@mail.gmail.com> <20211012011537.q7dwebcistxddyyj@amd.com>
In-Reply-To: <20211012011537.q7dwebcistxddyyj@amd.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Wed, 3 Nov 2021 22:25:02 -0700
Message-ID: <CAL715WKBBXNpJFK-3254ox_GU=v04RdYC=uXu4S5kbf=1R9aYA@mail.gmail.com>
Subject: Re: [RFC 06/16] KVM: selftests: add library for creating/interacting
 with SEV guests
To:     Michael Roth <Michael.Roth@amd.com>
Cc:     Marc Orr <marcorr@google.com>, linux-kselftest@vger.kernel.org,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Nathan Tempelman <natet@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

>
> >
> > > +#define SEV_FW_REQ_VER_MAJOR   1
> > > +#define SEV_FW_REQ_VER_MINOR   30
> >
> > Where does the requirement for this minimum version come from? Maybe
> > add a comment?
> >
> > Edit: Is this for patches later on in the series that exercise SNP? If
> > so, I think it would be better to add a check like this in the test
> > itself, rather than globally. I happened to test this on a machine
> > with a very old PSP FW, 0.22, and the SEV test added in patch #7 seems
> > to work fine with this ancient PSP FW.
>
> Ah, yes, this was mostly for SNP support. I'll implement a separate minimum
> version for SEV/SEV-ES.
>

I want to ask the same thing, I tried to run the sev selftest today
and I was blocked by this minimum version number... BTW: I suspect if
I want to update the SEV firmware I have to update the BIOS myself?
So, it would be good to know what is the actual minimum for SEV.

In addition, maybe that's side effect, I see a warning when building the kernel:

"module ccp.ko requires firmware amd/amd_sev_fam19h_model0xh.sbin"

Maybe I need some hints from you? Or maybe it is just harmless. I did
double checked and it looks like I was using either
amd_sev_fam17h_model3xh.sbin or amd_sev_fam17h_model0xh.sbin

Thanks.
-Mingwei
