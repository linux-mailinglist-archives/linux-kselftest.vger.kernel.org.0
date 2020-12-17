Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58E72DD44B
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Dec 2020 16:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgLQPgC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Dec 2020 10:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgLQPgC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Dec 2020 10:36:02 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCD9C0617B0
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Dec 2020 07:35:21 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id b8so9345363plx.0
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Dec 2020 07:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=cF1lpVOfX+qqIliOA4fJEolSXJPbWdzTY82HZk7M6Ss=;
        b=jmCoo2KfKiXBFPZ5Pu4hTHY3iB5JmJdEW2xDg11/qL0XDN1JfsdN7XyC2j8sEoH95y
         GFMTYGr0oCS+l4J4pMyQxd8aZ/F75Twiay44FOIBLAxCIaB28JlAUo9Ib+wLBPNGhIB5
         JZos5e7Irlc2WYQAdv2N/x8jYTVEVdXO+q3lEFoIwQJafSWpP75RiwxCcuG16exsWsl1
         /xaldJycza+FyblXi0w7S8BUo7Flvd3XJQ13gxiBJ6wf0KNWX2NhU00LCXp3C5ufBfWG
         twR6w2w9HVJM956l2GZbRuU5Uhi+JmF4wOm7e79KWTwg3krAg7CO6ep+OzxKH/X27pcp
         D66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=cF1lpVOfX+qqIliOA4fJEolSXJPbWdzTY82HZk7M6Ss=;
        b=oIb7e07V42U7Md3wWdEWI1bHYQXCAOuSRC+x0ZEghdrCHpclvzwQn+GgiRY4WXn1Ms
         ENS9HkIi/OD1v9+qfBT6oAzvD+nGBDXVKuqKZJoRadcuv71PBKkzr/DHT4wmggXlJ566
         u/DqdCI5MMtKNGW2fCmVPwfmRqfwog8TdDLq5wMSri1VyUYRJRwCogXWD8cEUVOu11h7
         Wq8/vy58qn/ojjKq/QKZjJY09aR/oURZRKf5mcyYhz3OmKgboQHIjqE2uecD7AEOFz+9
         QmnUSDVRIOU5WBrdQ3zz5KZRiXLpiOepwGWTPQvOJGmn4YiP1xUqCi8JLttaGHiIfTIF
         lxJA==
X-Gm-Message-State: AOAM530/J6OrRfRoMh99xA/3oQM7Ef2zwphL3IEL43atviqfcXiuI0VH
        5PV3r+ClClurK5q35+vVV57vlw==
X-Google-Smtp-Source: ABdhPJxqYT8PU/t0P9GGyShWjJrS4X7K4WGiEwYmQMQu9GEUzGcTkb4Xv4/Y1sZVsWotkJYwFWmFsw==
X-Received: by 2002:a17:902:64:b029:da:a9cf:4065 with SMTP id 91-20020a1709020064b02900daa9cf4065mr36533471pla.26.1608219321514;
        Thu, 17 Dec 2020 07:35:21 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:9dc1:d988:a568:787a? ([2601:646:c200:1ef2:9dc1:d988:a568:787a])
        by smtp.gmail.com with ESMTPSA id r123sm6059458pfr.68.2020.12.17.07.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 07:35:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V3.1] entry: Pass irqentry_state_t by reference
Date:   Thu, 17 Dec 2020 07:35:18 -0800
Message-Id: <24F5DC49-1FB3-42CF-8323-B0B39D936F7F@amacapital.net>
References: <20201217131924.GW3040@hirez.programming.kicks-ass.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Weiny Ira <ira.weiny@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
In-Reply-To: <20201217131924.GW3040@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (18B121)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


> On Dec 17, 2020, at 5:19 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> =EF=BB=BFOn Thu, Dec 17, 2020 at 02:07:01PM +0100, Thomas Gleixner wrote:
>>> On Fri, Dec 11 2020 at 14:14, Andy Lutomirski wrote:
>>>> On Mon, Nov 23, 2020 at 10:10 PM <ira.weiny@intel.com> wrote:
>>> After contemplating this for a bit, I think this isn't really the
>>> right approach.  It *works*, but we've mostly just created a bit of an
>>> unfortunate situation.  Our stack, on a (possibly nested) entry looks
>>> like:
>>>=20
>>> previous frame (or empty if we came from usermode)
>>> ---
>>> SS
>>> RSP
>>> FLAGS
>>> CS
>>> RIP
>>> rest of pt_regs
>>>=20
>>> C frame
>>>=20
>>> irqentry_state_t (maybe -- the compiler is within its rights to play
>>> almost arbitrary games here)
>>>=20
>>> more C stuff
>>>=20
>>> So what we've accomplished is having two distinct arch register
>>> regions, one called pt_regs and the other stuck in irqentry_state_t.
>>> This is annoying because it means that, if we want to access this
>>> thing without passing a pointer around or access it at all from outer
>>> frames, we need to do something terrible with the unwinder, and we
>>> don't want to go there.
>>>=20
>>> So I propose a somewhat different solution: lay out the stack like this.=

>>>=20
>>> SS
>>> RSP
>>> FLAGS
>>> CS
>>> RIP
>>> rest of pt_regs
>>> PKS
>>> ^^^^^^^^ extended_pt_regs points here
>>>=20
>>> C frame
>>> more C stuff
>>> ...
>>>=20
>>> IOW we have:
>>>=20
>>> struct extended_pt_regs {
>>>  bool rcu_whatever;
>>>  other generic fields here;
>>>  struct arch_extended_pt_regs arch_regs;
>>>  struct pt_regs regs;
>>> };
>>>=20
>>> and arch_extended_pt_regs has unsigned long pks;
>>>=20
>>> and instead of passing a pointer to irqentry_state_t to the generic
>>> entry/exit code, we just pass a pt_regs pointer.
>>=20
>> While I agree vs. PKS which is architecture specific state and needed in
>> other places e.g. #PF, I'm not convinced that sticking the existing
>> state into the same area buys us anything more than an indirect access.
>>=20
>> Peter?
>=20
> Agreed; that immediately solves the confusion Ira had as well. While
> extending pt_regs sounds scary, I think we've isolated our pt_regs
> implementation from actual ABI pretty well, but of course, that would
> need an audit. We don't want to leak this into signals for example.
>=20

I=E2=80=99m okay with this.

My suggestion for having an extended pt_regs that contains pt_regs is to kee=
p extensions like this invisible to unsuspecting parts of the kernel. In par=
ticular, BPF seems to pass around struct pt_regs *, and I don=E2=80=99t know=
 what the implications of effectively offsetting all the registers relative t=
o the pointer would be.

Anything that actually broke the signal regs ABI should be noticed by the x8=
6 selftests =E2=80=94 the tests read and write registers through ucontext.

>=20
