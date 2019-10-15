Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE097D6D45
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2019 04:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfJOCmE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Oct 2019 22:42:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45262 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfJOCmE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Oct 2019 22:42:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id y72so11446801pfb.12
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2019 19:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WmRb2+dqzrp0y48jYwh6Cbf3Uo7tqKuyLbS86YRFk/U=;
        b=b53TeBGOVgJ++2kARNaDScg3EZ1UF5jIScN/j4PCcFax1lk9nDw+gYi02vKOlQzT3d
         KOhU7WaAB/RxsXOkcvCVfHLFOqBjB43EvhifuGSwBSh/cvv444xgFOvvuBr/Wpw+5bwu
         hUe8m9hiLW2Sa8ik9kcBEBer9qSU0rbPiJ9DNaigmBxfgxb+CSmFztyyu9BovlHVpEQt
         KUgiQ6PjB9NVNADxanzoECL4s3pZI61me3AMVxqQPTWNQVsQrmi84QMBbBiuu7pal37x
         FgZ8dAOPx1Meja5qfcw32qetSqToZ8gaBhP0HGC6hM1Cy9bZUbhKCYSOFqvx0V2EqIVG
         ybAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WmRb2+dqzrp0y48jYwh6Cbf3Uo7tqKuyLbS86YRFk/U=;
        b=uAsk7jhXPkxmkxHdsitRBX90jwwzRgm+e4KL97IIX9heJRAmkGFHSuc+dkswmsUIOX
         qQicQLDEJwhQ/vqZAZrUVNVVS45diI0WoSOW9GGBqo4gx+WIMiNVVuQmBfB6CvlPwvFV
         9memwVnVKtbv4+9kJJ6cMS1e0WOe3k36FDjXk8ra2t0zYuV4DDaO+MPO16CV8i38BbXa
         tUYyElw501LlQVgXtnscjqhgaGOakDe7Jt/y8Hn9w24c3GKrvisLni5vquPArnL/gJgi
         mpLOb/umdZaTNrKq6MTYhEF6TvFapYsZH5Aa2qHSZ5PlxHYXl/NGCzMZugHcfIVCzoh2
         kzsA==
X-Gm-Message-State: APjAAAXq0jqGNKlWeGQn5v/SG3ybp87B6NytpuMt/hi2qte2NySW2Prg
        2li+06+P1fWDzvxgvbCa70xAgSFT9fpFc0mL0QNHyLhT
X-Google-Smtp-Source: APXvYqwvQDnGYLH6xA5bcxXeTcYQwPAfSAu/RwqSF3roKG1fC6y9x62fSMQd89Dr6cv+JxxVzJy1p1mJ3JETlCEndXU=
X-Received: by 2002:a63:3044:: with SMTP id w65mr35130364pgw.384.1571107323013;
 Mon, 14 Oct 2019 19:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <RT-Ticket-80110@linuxfoundation> <20191002215351.GA177672@google.com>
 <rt-4.4.0-12639-1570215347-1334.80110-6-0@linuxfoundation>
 <CAFd5g45OmXTpUubLv9kwNXGc0+KNLjLj9tmw=qoEzvQVsWqGkw@mail.gmail.com> <rt-4.4.0-14627-1570483310-924.80110-6-0@linuxfoundation>
In-Reply-To: <rt-4.4.0-14627-1570483310-924.80110-6-0@linuxfoundation>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 14 Oct 2019 19:41:51 -0700
Message-ID: <CAFd5g47oowqxMspHK0TA6T7Y-r6mHwTyUcW4xnRKULZq1CZDRw@mail.gmail.com>
Subject: Re: [Kernel.org Helpdesk #80110] Bugzilla Component for KUnit?
To:     kernel-helpdesk@rt.linuxfoundation.org
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 7, 2019 at 2:21 PM brendanhiggins@google.com via RT
<kernel-helpdesk@rt.linuxfoundation.org> wrote:
>
> On Fri, Oct 4, 2019 at 11:55 AM Konstantin Ryabitsev via RT
> <kernel-helpdesk@rt.linuxfoundation.org> wrote:
> >
> > On 2019-10-02 17:53:58, brendanhiggins@google.com wrote:
> > > Hi,
> > >
> > > I am thinking about requesting a Bugzilla component for my kernel
> > > project KUnit. I am not sure if this is the right place for it.  Some
> > > background on KUnit: We are working on adding unit testing for the
> > > Linux
> > > kernel[1][2]. We have our initial patchset that introduces the
> > > subsystem
> > > in the process of being merged (Linus sent our PR back to us for a
> > > minor
> > > fix[3], so it should be in either 5.4-rc2 or 5.5, but is nevertheless
> > > in
> > > linux-next). However, we also have a staging repo that people are
> > > using
> > > and some supporting code that lives outside of the kernel.
> > >
> > > So I am trying to figure out:
> > >
> > > 1. Is it appropriate to request a Bugzilla component before our
> > >    subsystem has been merged into torvalds/master? I would just wait,
> > >    but I have some users looking to file issues, so I would prefer to
> > >    provide them something sooner rather than later.
> > >
> > > 2. Is it appropriate to use the kernel's Bugzilla to track issues
> > >    outside of the Linux kernel? As I mention above, we have code that
> > >    lives outside of the kernel; is it appropriate to use kernel.org's
> > >    Bugzilla for this?
> > >
> > > 3. Does Bugzilla match my planned usage model? It doesn't look like
> > >    Bugzilla get's much usage aside from reporting bugs. I want to use
> > >    it for tracking feature progress and things like that. Is that
> > > okay?
> >
> > Yes, we can certainly host this on bugzilla.kernel.org. Would you be okay with Tools/KUnit as product/category?
>
> Cool, well as long as none of my above points are an issue for you.
> Then yes, can you create me a component? I am fine with Tools/KUnit as
> the product/category.

Ping.
