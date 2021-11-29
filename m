Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0F5460DCF
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Nov 2021 04:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376898AbhK2Dvj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 Nov 2021 22:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377182AbhK2Dti (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 Nov 2021 22:49:38 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED477C061799
        for <linux-kselftest@vger.kernel.org>; Sun, 28 Nov 2021 19:44:01 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l16so33593711wrp.11
        for <linux-kselftest@vger.kernel.org>; Sun, 28 Nov 2021 19:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+QDxtMYsiGpTbjQ64wPI5k5f7+JtFNl3ARwWkRt14a8=;
        b=ZU1Eln/9SfoVq+B1U5sfkGF2CKQj0m12USLmliZF8vtG281sSfnKd1llBqsKNcuqc2
         8N5fgyQytGWDCJcq36yzg17WxrxXioox9VRTAfRnldAXTNEp37nVe8IechsY1OXtWqmT
         +1peJdK+SSGcJwBQrdIZu4l/IIJXoUr4NSG4jK2hWbBB2oroBW5p+6DMWALBuFNs00oE
         yMtPXtXwPlRH38pIp3gZBltyLvbPamz2XjmQtJ+J3Z4+XxIBEXmozVRZ/SePp8ecprth
         WM9my2Gykuzd4pOFMsuZiVkqv1Jzi9fnhLbPO7pmX7iwo4SGyvjXsJ6stCH3cM13JSPE
         Q0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+QDxtMYsiGpTbjQ64wPI5k5f7+JtFNl3ARwWkRt14a8=;
        b=lV1Ck/9NJXHmD6TeOc+mBwMF2EmZHvbd3JrJZeio1ytwQY02z8B5TRKpYX0oKlGqNV
         BzvygVtxkuMi62R7dsTPaa/8mZ3dfXiIl017LKWS8MrT3iT12fYBuZuuFzL66daTcvZQ
         1xNxNgi3KeKXu6Olugk7MEgLnLYNCFetPp8ZeezxwOo2UX6OvjvEtwd0INPCjiDG1kqa
         bIIRXlhgTa9+GLQ3m9VEuEfiXPTTjWBwNEAgsa6HUrmEYGOxDQgMw2ucXMCa0Vl3a9GX
         hPKt7G+1DviHdrb6srCzlI8YLFdog+DF2f5IuEBlqYjyF8ByZCNx8lEQWlene8R9yXdk
         oGSA==
X-Gm-Message-State: AOAM530/FMBV0zP4RKi2/RrruRl1Ajt8oS5hb8ps2ibVFrgUmri/sRWM
        stzcOOf8z7Vxpx/du+Eiv/LjB9o9fSwa7vOXnOGIJQ==
X-Google-Smtp-Source: ABdhPJxVfNspMPegX0nnAqIOrb8ixJr5KGAdRv5R05/KZLzp7MAcQcov9DD8ovNlUXIEHNvkgRgpGDqR8pC579umDK8=
X-Received: by 2002:adf:e848:: with SMTP id d8mr31758948wrn.3.1638157440427;
 Sun, 28 Nov 2021 19:44:00 -0800 (PST)
MIME-Version: 1.0
References: <20211126154020.342924-1-anup.patel@wdc.com> <20211126154020.342924-4-anup.patel@wdc.com>
 <9545cab7-6365-b20d-fc05-82ace6368661@redhat.com>
In-Reply-To: <9545cab7-6365-b20d-fc05-82ace6368661@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 29 Nov 2021 09:13:49 +0530
Message-ID: <CAAhSdy0v=CrxJwiMtkPaR9y2WHcwqZZC9-mgc0ZncJ--69rVag@mail.gmail.com>
Subject: Re: [PATCH 3/4] KVM: selftests: Add EXTRA_CFLAGS in top-level Makefile
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Anup Patel <anup.patel@wdc.com>, Shuah Khan <shuah@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        KVM General <kvm@vger.kernel.org>,
        kvm-riscv@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 26, 2021 at 9:45 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 11/26/21 16:40, Anup Patel wrote:
> > We add EXTRA_CFLAGS to the common CFLAGS of top-level Makefile
> > which will allow users to pass additional compile-time flags such
> > as "-static".
>
> Is this just for debugging?  I cannot understand if it's used in patch 4.

Yes, this is just for debugging.

I am using it to add selftests ELFs to any arbitrary initrd so that I can
try selftests on Spike, FPGA, or even HW simulators.

Regards,
Anup

>
> Paolo
>
