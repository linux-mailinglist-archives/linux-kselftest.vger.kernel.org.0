Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAB42DB1FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Dec 2020 17:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgLOQ4P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Dec 2020 11:56:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:56148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729733AbgLOQ4J (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Dec 2020 11:56:09 -0500
X-Gm-Message-State: AOAM5334F9QL4UWoTELJAqiY4PL24ThrZ9JUefd9/3pmqxFe00zoB0aF
        9HcCw+INl8Tfm4cOQwq6aTm+wfiicBRejZiJoq3aiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608051328;
        bh=wxgX7rhYWEdaXnSJ6bJp8xImT47Xo70cIxCVXhRWJMk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bKx5sHyUxlKUO5O1VSKvYl+KlaKh1xk5TM0+wfneX+9+TIBF2Ie4C+vqt8p2kpB3X
         CK624/Y76U1sBgrmcfi9FCN5fcukZN45Lozelv3Ea3HzoxndJlYYC5+FfQulzZuYrN
         Pvj8RGFxAewuiKi2Wg7CczDgRFskM9e+OZWs/SX0PoGuSI0wPr+kvIVzKZ4UoU2BcC
         nTdolSOetdQAWReQbNu/yqGiSiJ/Q73LRR/2qzl8i57W/cmJxFNNCI/vQRq92AKEgc
         ZtCO8fqfbsYDLZpZ7/FWmhc94qBXM4EIVTO/xtLEhZSwreSN1H61I3dOjCj25I7bKK
         rUViwgN8UvXhA==
X-Google-Smtp-Source: ABdhPJw+VfdnYClq2C1NfMWCzjVSwytcRYUNwbuO86jDcwu7QTrd/YpYWhMAV2WfVcfj0qIb+FX0haGZwRfdhSVCd1Y=
X-Received: by 2002:a5d:4905:: with SMTP id x5mr19403633wrq.75.1608051326140;
 Tue, 15 Dec 2020 08:55:26 -0800 (PST)
MIME-Version: 1.0
References: <875z5c2db8.fsf@nanos.tec.linutronix.de> <20201209163434.GA22851@fuller.cnet>
 <87r1nyzogg.fsf@nanos.tec.linutronix.de> <20201210152618.GB23951@fuller.cnet>
 <87zh2lib8l.fsf@nanos.tec.linutronix.de> <20201211002703.GA47016@fuller.cnet>
 <87v9d8h3lx.fsf@nanos.tec.linutronix.de> <20201211141822.GA67764@fuller.cnet>
 <87k0togikr.fsf@nanos.tec.linutronix.de> <d9063c37-a965-d5cf-e923-c0c9f6ddc044@redhat.com>
 <20201215105927.GA3321@fuller.cnet>
In-Reply-To: <20201215105927.GA3321@fuller.cnet>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 15 Dec 2020 08:55:15 -0800
X-Gmail-Original-Message-ID: <CALCETrWSnMm-mfC5LjzsFLk6Tt_40Udrif-Kh34TTj6fp_8ZLw@mail.gmail.com>
Message-ID: <CALCETrWSnMm-mfC5LjzsFLk6Tt_40Udrif-Kh34TTj6fp_8ZLw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 15, 2020 at 3:35 AM Marcelo Tosatti <mtosatti@redhat.com> wrote:
>
> On Fri, Dec 11, 2020 at 10:59:59PM +0100, Paolo Bonzini wrote:
> > On 11/12/20 22:04, Thomas Gleixner wrote:
> > > > Its 100ms off with migration, and can be reduced further (customers
> > > > complained about 5 seconds but seem happy with 0.1ms).
> > > What is 100ms? Guaranteed maximum migration time?
> >
> > I suppose it's the length between the time from KVM_GET_CLOCK and
> > KVM_GET_MSR(IA32_TSC) to KVM_SET_CLOCK and KVM_SET_MSR(IA32_TSC).  But the
> > VM is paused for much longer, the sequence for the non-live part of the
> > migration (aka brownout) is as follows:
> >
> >     pause
> >     finish sending RAM            receive RAM               ~1 sec
> >     send paused-VM state          finish receiving RAM     \
> >                                   receive paused-VM state   ) 0.1 sec
> >                                   restart                  /
> >
> > The nanosecond and TSC times are sent as part of the paused-VM state at the
> > very end of the live migration process.
> >
> > So it's still true that the time advances during live migration brownout;
> > 0.1 seconds is just the final part of the live migration process.  But for
> > _live_ migration there is no need to design things according to "people are
> > happy if their clock is off by 0.1 seconds only".
>
> Agree. What would be a good way to fix this?
>

Could you implement the Hyper-V clock interface?  It's much, much
simpler than the kvmclock interface.  It has the downside that
CLOCK_BOOTTIME won't do what you want, but I'm not really convinced
that's a problem, and you could come up with a minimal extension to
fix that.
