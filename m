Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8201E6950
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 20:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405807AbgE1S37 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 14:29:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60779 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405744AbgE1S35 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 14:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590690595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i0Vd3Rmv/FJ0VzEZAhAOa4CEuK81Nugu5T6/vtWTnzw=;
        b=KGBA1jWlRM2uLj5qpA0M9JJOWfyqBd+43PW4C1cUIB/PhwJYGDZlzNItES17CxbG6JcXJA
        O+LFmz7dtwMaMMGWq+4hr8gQR13xxjjdsMzAzMpAfrqaLsexdXTegZCo1kIBXUPD0IVcCs
        WdiYjR9hTLi4eJ4wKOgfKv2IZCTqr00=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-WH_tcWtvP-S76CtgqutoDg-1; Thu, 28 May 2020 14:29:53 -0400
X-MC-Unique: WH_tcWtvP-S76CtgqutoDg-1
Received: by mail-ot1-f69.google.com with SMTP id 6so1790822oth.1
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 11:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i0Vd3Rmv/FJ0VzEZAhAOa4CEuK81Nugu5T6/vtWTnzw=;
        b=PtmNvqenjRExV45++3nAUsYIpAFExm3hOD/T8VzFye4cfJzxJGjS+6wTEhSw9hpTgx
         xH301QB4OSKhKIXu+73b5obDqxjmudXzx3GRtFVWPnkZu+ZoLnWEPM6QM/XJq2rTxmt+
         xS+D3rFlg8FU+UalHwe9nycirS/nf2tbr2zz8tkf9iC2jlfe9dS/V269wKnHZzkWmRsu
         NfifzKkgkTYH+X5LlEXTATt8bopnf5G0gXMOxmjbsWl3zlq+6lQH5x49ewTHeTQoMkbr
         uccoUyz4vVAz6bY8POhXpTOb1rheZNmYKEzaJOTlVwUGH2uH98eerhLgA9/tNYYE9GdN
         M/ig==
X-Gm-Message-State: AOAM53020JVYKHr/lSBWapvolaG9wZgMsxOjp0uYUdulzXVbisck7wvQ
        4D+OpJi8q6N2lpbXVb8hxBNa2NUGvG/hNs0/fROij4oZm6qC+N3mof7GPNNpFikRPcegejEz7Wh
        57m4d6iEKiymu+6hmRNgs6SHO12k64sYOBvkDAdgYn2Dh
X-Received: by 2002:a05:6830:2155:: with SMTP id r21mr3468288otd.187.1590690592708;
        Thu, 28 May 2020 11:29:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzg4T0ToaCnYPW94GkNCgylY/4Ew6dw2U7zjptPDZEbgJaQv0LDiIcZmgltwjOWCVFVaLpICn3DsZX1DQVw7yo=
X-Received: by 2002:a05:6830:2155:: with SMTP id r21mr3468272otd.187.1590690592491;
 Thu, 28 May 2020 11:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <xuny367lq1z1.fsf@redhat.com> <CAADnVQ+1o1JAm7w1twW0KgKMHbp-JvVjzET2N+VS1z=LajybzA@mail.gmail.com>
 <xunyh7w1nwem.fsf@redhat.com> <CAADnVQKbKA_Yuj7v3c6fNi7gZ8z_q_hzX2ry9optEHE3B_iWcg@mail.gmail.com>
 <ec5f6bd9-83e9-fc55-1885-18eee404d988@kernel.org> <CAADnVQJhb0+KWY0=4WVKc8NQswDJ5pU7LW1dQE2TQuya0Pn0oA@mail.gmail.com>
 <20200528100557.20489f04@redhat.com> <20200528105631.GE3115014@kroah.com>
 <20200528161437.x3e2ddxmj6nlhvv7@ast-mbp.dhcp.thefacebook.com>
 <be0a24f4-8602-ba1b-6ca4-7308b01d7a48@linuxfoundation.org> <20200528181546.eqzcc5kq5y6hnbcu@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200528181546.eqzcc5kq5y6hnbcu@ast-mbp.dhcp.thefacebook.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Thu, 28 May 2020 21:29:36 +0300
Message-ID: <CANoWsw=NOvkFAv_roNSJhCqK6Z=xAv79CERzDNKz0qSqzZPstQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: split -extras target to -static and -gen
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
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

Hi!

On Thu, May 28, 2020 at 9:16 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, May 28, 2020 at 11:07:09AM -0600, Shuah Khan wrote:

[...]
> >
> > Here is what CI users are requesting:
> >
> > - ability to install bpf test with other selftests using kselftest
> >   install. The common framework is in place and with minor changes
> >   to bpf test Makefile, we can make this happen. Others and myself
> >   are willing to work on this, so we can get bpf test coverage in
> >   test rings.
>
> so you're saying that bpf maintainers and all bpf developers now
> would need to incorporate new 'make install' step to their workflow
> because some unknown CI system that is not even functional decided
> to do 'make install' ?
> That's exactly my point about selfish CI developers who put their
> needs in front of bpf community of developers.

May be, it can work both ways to make everybody happy :) (I haven't
seen yet fundamental problems why not).

