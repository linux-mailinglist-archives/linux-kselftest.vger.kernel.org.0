Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313CC22CC2F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jul 2020 19:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgGXR32 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jul 2020 13:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGXR32 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jul 2020 13:29:28 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C605C0619E5
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jul 2020 10:29:28 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x8so4841909plm.10
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jul 2020 10:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=xVJb6QB7yJwnn1Z6Ovzuc7SiH2/mFZI/eEetibZkjak=;
        b=oCF2bACf0J3wi10Mkevj6a1lx9ZJ2XYqftXol/Y5C3BUVETOi1ThoRhsL2OxKFCyb4
         LGJ3ZE9QuRoT+dYLR9CdhNjE9P+KA1F0J34lD0z4Rjmsdl1uULCFsHQh/kjIrw/3yYIN
         MIxEx6ObahD1W2wfYbyu5J04MgrODyT6hzuLM3mpaqgWNY1btI1HYMmRRqfrG327H9oM
         z5+CURUIEaZafgf40maNhBKcXiwP+sIOTIqvFURURI9WNSOzDt9L7YckftzfASDKb67X
         c6S0yxsINqy7Fs9MCqKwbe5ZznH0YewS4KMFQ8V9Fo2+D3qH4LKoiOb9hjdKp/ooZMns
         71UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=xVJb6QB7yJwnn1Z6Ovzuc7SiH2/mFZI/eEetibZkjak=;
        b=AX5gDu5cFGM8qDwkf7rbHbnFPNzi6gBEl82b1qy96cDBFDJ7UpOWuBUuuhq7IaRBti
         JpJSZs8bN7UAKaBleWNh7MYqUDwL+lIA8Jxc1aoM2YPRMJDpI9CsL73kD32uzTx5sP3B
         SyCH7RnqWhPtF7qW38hyfdakWh5KHrsCwrml5wPibX/2Dg1syitzdnIhKdgAhD2blwvt
         7hpX8SYnk/CZpDwsD67D555YiEUGDohD4DUY/fVqznk/I+XolHfc4zh07SrCnkIs1sy9
         jn+036Bq9ageikXNLBNp2SLvmRIroq/2Egu8GaOOQtMO+L2MbEuOpxgFsMSIqq57cc2H
         Cn1w==
X-Gm-Message-State: AOAM533KxzAwjXcyyft9pn3jSR6CHYjQYC4nwbHm5KWlhoxbTxn9NtL1
        /NLxKM7RqXcTGJuI6rKk9vMK8w==
X-Google-Smtp-Source: ABdhPJxgGZkOO3kQzBrpxCwHwlk1F6DYD0lzx0NwksvJwkCVThBWugwQYsACXzFP/Kw/IrlXRyq2VQ==
X-Received: by 2002:a17:90a:1b2c:: with SMTP id q41mr6495292pjq.195.1595611767681;
        Fri, 24 Jul 2020 10:29:27 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:cc1b:c95e:6185:cfc7? ([2601:646:c200:1ef2:cc1b:c95e:6185:cfc7])
        by smtp.gmail.com with ESMTPSA id x66sm6882326pgb.12.2020.07.24.10.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 10:29:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across exceptions
Date:   Fri, 24 Jul 2020 10:29:23 -0700
Message-Id: <D866BD75-42A2-43B2-B07A-55BCC3781FEC@amacapital.net>
References: <20200724172344.GO844235@iweiny-DESK2.sc.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
In-Reply-To: <20200724172344.GO844235@iweiny-DESK2.sc.intel.com>
To:     Ira Weiny <ira.weiny@intel.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


> On Jul 24, 2020, at 10:23 AM, Ira Weiny <ira.weiny@intel.com> wrote:
>=20
> =EF=BB=BFOn Thu, Jul 23, 2020 at 10:15:17PM +0200, Thomas Gleixner wrote:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>>=20
>>> Ira Weiny <ira.weiny@intel.com> writes:
>>>> On Fri, Jul 17, 2020 at 12:06:10PM +0200, Peter Zijlstra wrote:
>>>>>> On Fri, Jul 17, 2020 at 12:20:56AM -0700, ira.weiny@intel.com wrote:
>>>>> I've been really digging into this today and I'm very concerned that I=
'm
>>>>> completely missing something WRT idtentry_enter() and idtentry_exit().=

>>>>>=20
>>>>> I've instrumented idt_{save,restore}_pkrs(), and __dev_access_{en,dis}=
able()
>>>>> with trace_printk()'s.
>>>>>=20
>>>>> With this debug code, I have found an instance where it seems like
>>>>> idtentry_enter() is called without a corresponding idtentry_exit().  T=
his has
>>>>> left the thread ref counter at 0 which results in very bad things happ=
ening
>>>>> when __dev_access_disable() is called and the ref count goes negative.=

>>>>>=20
>>>>> Effectively this seems to be happening:
>>>>>=20
>>>>> ...
>>>>>    // ref =3D=3D 0
>>>>>    dev_access_enable()  // ref +=3D 1 =3D=3D> disable protection
>>>>>        // exception  (which one I don't know)
>>>>>            idtentry_enter()
>>>>>                // ref =3D 0
>>>>>                _handler() // or whatever code...
>>>>>            // *_exit() not called [at least there is no trace_printk()=
 output]...
>>>>>            // Regardless of trace output, the ref is left at 0
>>>>>    dev_access_disable() // ref -=3D 1 =3D=3D> -1 =3D=3D> does not enab=
le protection
>>>>>    (Bad stuff is bound to happen now...)
>>>=20
>>> Well, if any exception which calls idtentry_enter() would return without=

>>> going through idtentry_exit() then lots of bad stuff would happen even
>>> without your patches.
>>>=20
>>>> Also is there any chance that the process could be getting scheduled an=
d that
>>>> is causing an issue?
>>>=20
>>> Only from #PF, but after the fault has been resolved and the tasks is
>>> scheduled in again then the task returns through idtentry_exit() to the
>>> place where it took the fault. That's not guaranteed to be on the same
>>> CPU. If schedule is not aware of the fact that the exception turned off
>>> stuff then you surely get into trouble. So you really want to store it
>>> in the task itself then the context switch code can actually see the
>>> state and act accordingly.
>>=20
>> Actually thats nasty as well as you need a stack of PKRS values to
>> handle nested exceptions. But it might be still the most reasonable
>> thing to do. 7 PKRS values plus an index should be really sufficient,
>> that's 32bytes total, not that bad.
>=20
> I've thought about this a bit more and unless I'm wrong I think the
> idtentry_state provides for that because each nested exception has it's ow=
n
> idtentry_state doesn't it?

Only the ones that use idtentry_enter() instead of, say, nmi_enter().

>=20
> Ira
