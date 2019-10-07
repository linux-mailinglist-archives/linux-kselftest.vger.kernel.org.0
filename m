Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E622ECEE5E
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2019 23:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfJGVVu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Oct 2019 17:21:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34710 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbfJGVVu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Oct 2019 17:21:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id k7so7477207pll.1
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Oct 2019 14:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GsvcU2KGKv6Wh4QabuUFjkJ5xQPVUKa9FSrhPMTtoFE=;
        b=jyxaf7/dTaZ+q4T59acfogE2zbeh+0nqMNQW3YPo1CsXnT5OmSevJFiW2exj0a49fr
         FoqrU2qTZSF5xtXcOO06JUdBiIAluu3KqhxtWxzvAlesekaNCDX3PcleiNVCS2AfAU1g
         TugIkp41hjm3W7KYzuZZeKbBtZoSOtokly1Vb8sB2NhWqfdnpRUO6RbdqMMLe801Iy3s
         G8/vMtQs/+0U4ZASgob/SYXGxfabqdC08vYRG6j1wO2p5XC3Cfm/weRZFNB+lWYQGLQB
         d/cSxTIo+lkbRjFDltrt64IlOEtWc4rsHpUr9f8ZDBulZAq5VCz5t8ni0sQQ3PJwipur
         EdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GsvcU2KGKv6Wh4QabuUFjkJ5xQPVUKa9FSrhPMTtoFE=;
        b=ludkkHLObU0vRROBx53NOZEmoUVxxs/7gqiijvkUPFLj5vZSW+PKBeIUq3qG1oIwMo
         5Q4kkkpHzHIhz47iIRnSEn2o8+AroVX99mkXmNVqvXfowtUQpThzMTTZbKjQcoKNS23S
         Jmj/fvJ82HZg4z2Ayk+nXdUjEZCilAPwvxsct0IjrLl4ckyQVZB5qiErm4UKpNMOHPtY
         vkTEWKWMUKbCPHIEmms7Hc7T5sZX3iU2CmX7/BO2E20JOPuwHBqp5h64+BRf/KrEBwIo
         EbXAdjk7gwMx/GpN0RUxjepKtUdnzXyRrUwtfhr8lpaLrC6xBVD9kSHlDg7/OKdECFPV
         QoIg==
X-Gm-Message-State: APjAAAXs82aCTWNhI3WngmDXXnziJZidiv6WdezbhnbraopAtDqDEvWP
        HvIJ+DTY6Tk6nT0KyK7ml+CtS+sL0gD/UMHBoQDiXnlsaME=
X-Google-Smtp-Source: APXvYqyhn5xIsmDVIFikqXJ7mgYnkrHLgabHjBcnGVoeqi0MYx4zXpP/5kjbIsi8wge6osokTu5NTFb0sPuV1Sl2kQI=
X-Received: by 2002:a17:902:ff0e:: with SMTP id f14mr32259234plj.325.1570483308970;
 Mon, 07 Oct 2019 14:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <RT-Ticket-80110@linuxfoundation> <20191002215351.GA177672@google.com>
 <rt-4.4.0-12639-1570215347-1334.80110-6-0@linuxfoundation>
In-Reply-To: <rt-4.4.0-12639-1570215347-1334.80110-6-0@linuxfoundation>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 7 Oct 2019 14:21:37 -0700
Message-ID: <CAFd5g45OmXTpUubLv9kwNXGc0+KNLjLj9tmw=qoEzvQVsWqGkw@mail.gmail.com>
Subject: Re: [Kernel.org Helpdesk #80110] Bugzilla Component for KUnit?
To:     kernel-helpdesk@rt.linuxfoundation.org
Cc:     kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 4, 2019 at 11:55 AM Konstantin Ryabitsev via RT
<kernel-helpdesk@rt.linuxfoundation.org> wrote:
>
> On 2019-10-02 17:53:58, brendanhiggins@google.com wrote:
> > Hi,
> >
> > I am thinking about requesting a Bugzilla component for my kernel
> > project KUnit. I am not sure if this is the right place for it.  Some
> > background on KUnit: We are working on adding unit testing for the
> > Linux
> > kernel[1][2]. We have our initial patchset that introduces the
> > subsystem
> > in the process of being merged (Linus sent our PR back to us for a
> > minor
> > fix[3], so it should be in either 5.4-rc2 or 5.5, but is nevertheless
> > in
> > linux-next). However, we also have a staging repo that people are
> > using
> > and some supporting code that lives outside of the kernel.
> >
> > So I am trying to figure out:
> >
> > 1. Is it appropriate to request a Bugzilla component before our
> >    subsystem has been merged into torvalds/master? I would just wait,
> >    but I have some users looking to file issues, so I would prefer to
> >    provide them something sooner rather than later.
> >
> > 2. Is it appropriate to use the kernel's Bugzilla to track issues
> >    outside of the Linux kernel? As I mention above, we have code that
> >    lives outside of the kernel; is it appropriate to use kernel.org's
> >    Bugzilla for this?
> >
> > 3. Does Bugzilla match my planned usage model? It doesn't look like
> >    Bugzilla get's much usage aside from reporting bugs. I want to use
> >    it for tracking feature progress and things like that. Is that
> > okay?
>
> Yes, we can certainly host this on bugzilla.kernel.org. Would you be okay with Tools/KUnit as product/category?

Cool, well as long as none of my above points are an issue for you.
Then yes, can you create me a component? I am fine with Tools/KUnit as
the product/category.

Thanks!
