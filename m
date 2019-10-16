Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7AA1D9C37
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 23:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437363AbfJPVF5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 17:05:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32988 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437357AbfJPVF5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 17:05:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id i76so15026948pgc.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2019 14:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qjV7EM47JVSinM4boRo6vuSJwIoQAUJUWrKIe+pEDW4=;
        b=eelzKIWFNh+gRNtHdk+7M1530iFhX/BUMRNjgmGFuj0gJJ/VrL+bK3BIsLxL6pl4hu
         JHget8koKzZYtiHF+05Uc2XF7+SndTigrr6/ZWOoXA6ltstxbL9uHBvTHAJ+pVnWW7Vm
         nal7K3cBXYbIdwQwBz1yV8ApWRP17VQyd+1DW2q5l55Mc8E8NqP8Y2Hfx3TUQFeiYkTP
         K/WDR8zNQJTw0/dAiu+amP4ZFIotK1dfR2Ts+vfV5pJwdTdoyTbKv4dybETlwMlkTnNJ
         OOvwuRldl689rJQ4djTKiCPARCAEVN0iS83eC6FBzn7AqR6XYFqhgkwmS/KPbw0Ms5dZ
         L8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qjV7EM47JVSinM4boRo6vuSJwIoQAUJUWrKIe+pEDW4=;
        b=QAdRM+POdksjohDQxUYIsw2aHIemlVD/KOB0gH/ukRhTO5t0tNe5P1c1+XvKz7e1X+
         xijzfFTnQrqVLP/Lx4ZdgX/beQtynWxJChiT7SlmM6WAoQFP/oSEhZk19su77zl4/AO3
         /W8awyn7FQJDLd0hWtiSpivfrrsm6fSZhKbEJVeSrnrk9W/aKknf0ufvpArXpw8xFJwU
         v09YQ4GzlE0czG179d2HZzsKYGWyUOzxSqKCsr1htd1HAFV/EanjwHZ9H09jjVhoV2Yl
         XSjY1RQK5rKSPdcGUW2ItlnrGPkfwbGnGwxpMMdLe+TDZJq1uHxBcwQbSr4BFzb9kaq/
         ymIA==
X-Gm-Message-State: APjAAAUVqTSZp9esVUyTv0KaybTTE9IDINs6TzkHZZukdvQYBM9Ey0V9
        Eb1ZG1NPqMC5wm7UIcIvuevN22y+TJsN4nddUxdduT/1H8I=
X-Google-Smtp-Source: APXvYqxIZNjmNb+rFuHuwUF2SY13oQd0no+yF6+IiLGl5QlSFcoE6N7wBF0xI74HJ05LKRrIsIG8J004PljLzwpxVUA=
X-Received: by 2002:a17:90a:2451:: with SMTP id h75mr7570869pje.131.1571259956064;
 Wed, 16 Oct 2019 14:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <RT-Ticket-80110@linuxfoundation> <20191002215351.GA177672@google.com>
 <rt-4.4.0-12639-1570215347-1334.80110-6-0@linuxfoundation>
 <CAFd5g45OmXTpUubLv9kwNXGc0+KNLjLj9tmw=qoEzvQVsWqGkw@mail.gmail.com>
 <rt-4.4.0-14627-1570483310-1693.80110-6-0@linuxfoundation> <rt-4.4.0-13264-1571170451-794.80110-6-0@linuxfoundation>
In-Reply-To: <rt-4.4.0-13264-1571170451-794.80110-6-0@linuxfoundation>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 16 Oct 2019 14:05:44 -0700
Message-ID: <CAFd5g44=MXf+nnYwaRg4eHYPQtfTo-KgH2z2+G=FA16xoUf-hg@mail.gmail.com>
Subject: Re: [Kernel.org Helpdesk #80110] Bugzilla Component for KUnit?
To:     kernel-helpdesk@rt.linuxfoundation.org
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 15, 2019 at 1:14 PM Konstantin Ryabitsev via RT
<kernel-helpdesk@rt.linuxfoundation.org> wrote:
>
> On 2019-10-07 17:21:50, brendanhiggins@google.com wrote:
> > On Fri, Oct 4, 2019 at 11:55 AM Konstantin Ryabitsev via RT
> > <kernel-helpdesk@rt.linuxfoundation.org> wrote:
> > >
> > > On 2019-10-02 17:53:58, brendanhiggins@google.com wrote:
> > > > Hi,
> > > >
> > > > I am thinking about requesting a Bugzilla component for my kernel
> > > > project KUnit. I am not sure if this is the right place for it.
> > > > Some
> > > > background on KUnit: We are working on adding unit testing for the
> > > > Linux
> > > > kernel[1][2]. We have our initial patchset that introduces the
> > > > subsystem
> > > > in the process of being merged (Linus sent our PR back to us for a
> > > > minor
> > > > fix[3], so it should be in either 5.4-rc2 or 5.5, but is
> > > > nevertheless
> > > > in
> > > > linux-next). However, we also have a staging repo that people are
> > > > using
> > > > and some supporting code that lives outside of the kernel.
> > > >
> > > > So I am trying to figure out:
> > > >
> > > > 1. Is it appropriate to request a Bugzilla component before our
> > > >    subsystem has been merged into torvalds/master? I would just
> > > > wait,
> > > >    but I have some users looking to file issues, so I would prefer
> > > > to
> > > >    provide them something sooner rather than later.
> > > >
> > > > 2. Is it appropriate to use the kernel's Bugzilla to track issues
> > > >    outside of the Linux kernel? As I mention above, we have code
> > > > that
> > > >    lives outside of the kernel; is it appropriate to use
> > > > kernel.org's
> > > >    Bugzilla for this?
> > > >
> > > > 3. Does Bugzilla match my planned usage model? It doesn't look like
> > > >    Bugzilla get's much usage aside from reporting bugs. I want to
> > > > use
> > > >    it for tracking feature progress and things like that. Is that
> > > > okay?
> > >
> > > Yes, we can certainly host this on bugzilla.kernel.org. Would you be
> > > okay with Tools/KUnit as product/category?
> >
> > Cool, well as long as none of my above points are an issue for you.
> > Then yes, can you create me a component? I am fine with Tools/KUnit as
> > the product/category.
>
> Apologies for the delay, mostly due to Thanksgiving in Canada. You should=
 be able to start using Tools/KUnit now. It uses a default virtual assignee=
 tools_kunit@kernel-bugs.kernel.org, so to start receiving bugmail for it, =
please follow instructions on this page:

No worries.

>
> https://korg.wiki.kernel.org/userdoc/bugzilla#to_start_getting_bug_report=
s_for_a_component

Thanks!
