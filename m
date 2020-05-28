Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888B81E6A4A
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 21:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406305AbgE1TUv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 15:20:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55088 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2406298AbgE1TUo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 15:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590693642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VX0ZoJuDDOpVB5P5R4LGHdkAyZVcUv5obVtgfnyBRdI=;
        b=KIzKICBUe65s8tVSWCOr1pKwz6aDyWHDuL0/5HL8TzHY/9y+U4gaimEV/7lly8b/mgU6AP
        wJY8AseaA7/W7RSJ2lOdVIzjUOn1bRGTJ57WnQY5tPXrG3dP/75LN3CxCRKNaVY9EQiS1V
        OdRBxFhGFeNwf0n4xuyRMq69g2TjMYg=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-pOGEHsloOeWYMaGzYgQEqw-1; Thu, 28 May 2020 15:20:40 -0400
X-MC-Unique: pOGEHsloOeWYMaGzYgQEqw-1
Received: by mail-oo1-f71.google.com with SMTP id o9so4749oos.21
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 12:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VX0ZoJuDDOpVB5P5R4LGHdkAyZVcUv5obVtgfnyBRdI=;
        b=Ye28dY7EsDWypMnmXFJAxZYHx1g3xfO9IMxdOgDkp7kcWP4jhYzK6A9OTFW7EMdfCL
         jmT/57igb5q7vCyMHhhLpjM9UPilKAYHqMI1G8C8NWg5k0dgasD/q8sIECwKFvB5s+ym
         cTNuqRGMV8R2SgFPsYViCW0fWri802MB/OV8MKw2891wzL95Ux2Keco5rtnHKH8HTCkc
         tRXkhG0TQlHCFCAoSySBsoJFYbhuZtXrZIEslBduuqrf/O2PadJSUBpIEsrVJxbi2sqn
         cf2Ibu6u9bHHXrM6014mgtqA8+Foj3xBi7yuatei3cpf37LoolWYr+cdL0EzRjltf6GW
         y3Vg==
X-Gm-Message-State: AOAM531g6/GkVPDoVRcoMbGfD7mYvFDQoz7/uUSNt9ZPU7fsFT6FUQ5/
        uSR61XdRmC1OflnSH7XIvvk9VPO70UX7gCZpUa57CjD3uFYaLazcXqQxTPzC/EpAo4W/DZaod14
        EhQRgXkXuNq6yIDVnFH8fBa9fqbTb95PZQ/ixXHaBL3GA
X-Received: by 2002:a9d:65cc:: with SMTP id z12mr3436311oth.37.1590693639873;
        Thu, 28 May 2020 12:20:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymYXCaMuWzgShaQPkwHzcPbZdfosWPb85a8b/kyzHMHT/t+8wch3Ud3G1LTLCqy0yHnveMLLp/hdKJIOQTe5s=
X-Received: by 2002:a9d:65cc:: with SMTP id z12mr3436295oth.37.1590693639640;
 Thu, 28 May 2020 12:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <xunya71uosvv.fsf@redhat.com> <CAADnVQJUL9=T576jo29F_zcEd=C6_OiExaGbEup6F-mA01EKZQ@mail.gmail.com>
 <xuny367lq1z1.fsf@redhat.com> <CAADnVQ+1o1JAm7w1twW0KgKMHbp-JvVjzET2N+VS1z=LajybzA@mail.gmail.com>
 <xunyh7w1nwem.fsf@redhat.com> <CAADnVQKbKA_Yuj7v3c6fNi7gZ8z_q_hzX2ry9optEHE3B_iWcg@mail.gmail.com>
 <ec5f6bd9-83e9-fc55-1885-18eee404d988@kernel.org> <CAADnVQJhb0+KWY0=4WVKc8NQswDJ5pU7LW1dQE2TQuya0Pn0oA@mail.gmail.com>
 <20200528100557.20489f04@redhat.com> <20200528105631.GE3115014@kroah.com>
 <20200528161437.x3e2ddxmj6nlhvv7@ast-mbp.dhcp.thefacebook.com>
 <CANoWswkGoJEZVcfLiNverDWyh6skSoix=JqxeJR9K8A=H8x=rw@mail.gmail.com> <49931ed9-da92-4b32-ba54-aeba33166bdd@linuxfoundation.org>
In-Reply-To: <49931ed9-da92-4b32-ba54-aeba33166bdd@linuxfoundation.org>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Thu, 28 May 2020 22:20:23 +0300
Message-ID: <CANoWswmSGHddKpSmyxvxjFEMZDB7u0cAp=ceGB6tU2AcdGRcaw@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: split -extras target to -static and -gen
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Benc <jbenc@redhat.com>, shuah <shuah@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 28, 2020 at 10:09 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 5/28/20 11:10 AM, Yauheni Kaliuta wrote:
> > Hi, Alexei,
> >
> > On Thu, May 28, 2020 at 7:14 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Thu, May 28, 2020 at 12:56:31PM +0200, Greg KH wrote:
> >>> On Thu, May 28, 2020 at 10:05:57AM +0200, Jiri Benc wrote:
> >>>> On Wed, 27 May 2020 15:23:13 -0700, Alexei Starovoitov wrote:
> >>>>> I prefer to keep selftests/bpf install broken.
> >>>>> This forced marriage between kselftests and selftests/bpf
> >>>>> never worked well. I think it's a time to free them up from each other.
> >>>>
> >>>> Alexei, it would be great if you could cooperate with other people
> >>>> instead of pushing your own way. The selftests infrastructure was put
> >>>> to the kernel to have one place for testing. Inventing yet another way
> >>>> to add tests does not help anyone. You don't own the kernel. We're
> >>>> community, we should cooperate.
> >>>
> >>> I agree, we rely on the infrastructure of the kselftests framework so
> >>> that testing systems do not have to create "custom" frameworks to handle
> >>> all of the individual variants that could easily crop up here.
> >>>
> >>> Let's keep it easy for people to run and use these tests, to not do so
> >>> is to ensure that they are not used, which is the exact opposite goal of
> >>> creating tests.
> >>
> >> Greg,
> >>
> >> It is easy for people (bpf developers) to run and use the tests.
> >> Every developer runs them before submitting patches.
> >> New tests is a hard requirement for any new features.
> >> Maintainers run them for every push.
> >>
> >> What I was and will push back hard is when other people (not bpf developers)
> >> come back with an excuse that some CI system has a hard time running these
> >> tests. It's the problem of weak CI. That CI needs to be fixed. Not the tests.
> >> The example of this is that we already have github/libbpf CI that runs
> >> selftests/bpf just fine. Anyone who wants to do another CI are welcome to copy
> >> paste what already works instead of burdening people (bpf developers) who run
> >> and use existing tests. I frankly have no sympathy to folks who put their own
> >> interest of their CI development in front of bpf community of developers.
> >> The main job of CI is to help developers and maintainers.
> >> Where helping means to not impose new dumb rules on developers because CI
> >> framework is dumb. Fix CI instead.
> >>
> >
> > Any good reason why bpf selftests, residing under selftests/, should
> > be an exception?
> > "Breakages" is not, breakages are fixable.
> >
>
> Let's not talk about moving tests. I don't want to discuss that until
> we are all on the same page on what is the problem in adding install
> support to bpf Makefile.
>
> It is possible that there is a misunderstanding that bpf maintainer
> and developer workflow will change. Which is definitely not needed.
> If this patch series requires it, it isn't correct and needs to be
> reworked.

patch series does not change it. Running bpf tests in-place is one of
my own usecases, I'm not going to break it :)
The series tried to fix what does not work (install and build in
$(OUTPUT) directory) but exists in the code. I'll include you in Cc
for the respin(s) if you are interested.

The discussion is pretty much not connected to the patchset, but about
bpf selftests and the infra in general.

-- 
WBR, Yauheni

