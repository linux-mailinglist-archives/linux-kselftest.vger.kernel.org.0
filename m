Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5371E6866
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 19:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405325AbgE1RLY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 13:11:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20993 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405320AbgE1RLX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 13:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590685882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xaYkM24G2m803F/chb/jq5pTBxpALIamh9MB8ZyiK4k=;
        b=iWqT0jPEdVYW2EFs+jeCB0IpawTEa/FX/SZXR/7BsoX0Q5mlAm7FK3hHfsSP01T7+wngHm
        QFurspHsSy86616FsbgcD2GNd0I9ITiJvh3CQiVBgp0UWBRkxL7bzK9dBoa+kqLphruDL7
        /vRSOH886lqDHNFuspRWopTd66I6goc=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-jSYqGc4pMT-YIUl8Q_TvUg-1; Thu, 28 May 2020 13:11:20 -0400
X-MC-Unique: jSYqGc4pMT-YIUl8Q_TvUg-1
Received: by mail-ot1-f69.google.com with SMTP id 6so1691590oth.1
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 10:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xaYkM24G2m803F/chb/jq5pTBxpALIamh9MB8ZyiK4k=;
        b=ZqgAR4C+nlg6EKxaI5aMrJ78YUhpPKJOewUOlwztS3Ol2Uc0OID6oKEHFiwHn1JfPR
         1ijbewhdZW9akAS00FbdcoFQIw9EKxD76XAf5Gl2huDOKo7Xz5Lgv5UWeaIdAmpLLwEg
         Pj4BveXjaTsgsOs+wMcjZGPQh2ozHNklZIIX9+RwGCAYFVaOKc2vH6EDhf5CsIpadK1p
         sCJ4kRl8IDdA5EVhVxaNKZ/1tszmH1vYE+xitvW//ttFuJ8sby/c1ipkb86964/YudX3
         bTHlpNVsmvK1MiULh8q2jNI6v43htPAP5GW9z7gZn8cdnw6ZBA+UPKtpsj2xakH/URLx
         6RKw==
X-Gm-Message-State: AOAM5305gnsymubdMvO1bv+nBskM7b4fv/ylEVW3IUx+4B4R49Hh2EbT
        Go4r7tf5oPSVYTjXDjqehMRHwS3tdkpy7NTfMXAW6XgyRgugMTy0A8ExNqp1LGJXSA4+VDXt/R4
        28NEdOHSrXR+CIJInE1vJAURWsV57VSaVzpnccC9joql2
X-Received: by 2002:aca:f3c6:: with SMTP id r189mr2798495oih.73.1590685873680;
        Thu, 28 May 2020 10:11:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNpt7lm09wPE/RS56oNAzVrcNKbkTdlzTw/HKlW3RUZud4VndZKG1homLi/1T2REUUB8K/J+bW21Kp6ThU/Pk=
X-Received: by 2002:aca:f3c6:: with SMTP id r189mr2798478oih.73.1590685873348;
 Thu, 28 May 2020 10:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <xunya71uosvv.fsf@redhat.com> <CAADnVQJUL9=T576jo29F_zcEd=C6_OiExaGbEup6F-mA01EKZQ@mail.gmail.com>
 <xuny367lq1z1.fsf@redhat.com> <CAADnVQ+1o1JAm7w1twW0KgKMHbp-JvVjzET2N+VS1z=LajybzA@mail.gmail.com>
 <xunyh7w1nwem.fsf@redhat.com> <CAADnVQKbKA_Yuj7v3c6fNi7gZ8z_q_hzX2ry9optEHE3B_iWcg@mail.gmail.com>
 <ec5f6bd9-83e9-fc55-1885-18eee404d988@kernel.org> <CAADnVQJhb0+KWY0=4WVKc8NQswDJ5pU7LW1dQE2TQuya0Pn0oA@mail.gmail.com>
 <20200528100557.20489f04@redhat.com> <20200528105631.GE3115014@kroah.com> <20200528161437.x3e2ddxmj6nlhvv7@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200528161437.x3e2ddxmj6nlhvv7@ast-mbp.dhcp.thefacebook.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Thu, 28 May 2020 20:10:57 +0300
Message-ID: <CANoWswkGoJEZVcfLiNverDWyh6skSoix=JqxeJR9K8A=H8x=rw@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: split -extras target to -static and -gen
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jiri Benc <jbenc@redhat.com>,
        shuah <shuah@kernel.org>,
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

Hi, Alexei,

On Thu, May 28, 2020 at 7:14 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, May 28, 2020 at 12:56:31PM +0200, Greg KH wrote:
> > On Thu, May 28, 2020 at 10:05:57AM +0200, Jiri Benc wrote:
> > > On Wed, 27 May 2020 15:23:13 -0700, Alexei Starovoitov wrote:
> > > > I prefer to keep selftests/bpf install broken.
> > > > This forced marriage between kselftests and selftests/bpf
> > > > never worked well. I think it's a time to free them up from each other.
> > >
> > > Alexei, it would be great if you could cooperate with other people
> > > instead of pushing your own way. The selftests infrastructure was put
> > > to the kernel to have one place for testing. Inventing yet another way
> > > to add tests does not help anyone. You don't own the kernel. We're
> > > community, we should cooperate.
> >
> > I agree, we rely on the infrastructure of the kselftests framework so
> > that testing systems do not have to create "custom" frameworks to handle
> > all of the individual variants that could easily crop up here.
> >
> > Let's keep it easy for people to run and use these tests, to not do so
> > is to ensure that they are not used, which is the exact opposite goal of
> > creating tests.
>
> Greg,
>
> It is easy for people (bpf developers) to run and use the tests.
> Every developer runs them before submitting patches.
> New tests is a hard requirement for any new features.
> Maintainers run them for every push.
>
> What I was and will push back hard is when other people (not bpf developers)
> come back with an excuse that some CI system has a hard time running these
> tests. It's the problem of weak CI. That CI needs to be fixed. Not the tests.
> The example of this is that we already have github/libbpf CI that runs
> selftests/bpf just fine. Anyone who wants to do another CI are welcome to copy
> paste what already works instead of burdening people (bpf developers) who run
> and use existing tests. I frankly have no sympathy to folks who put their own
> interest of their CI development in front of bpf community of developers.
> The main job of CI is to help developers and maintainers.
> Where helping means to not impose new dumb rules on developers because CI
> framework is dumb. Fix CI instead.
>

Any good reason why bpf selftests, residing under selftests/, should
be an exception?
"Breakages" is not, breakages are fixable.

-- 
WBR, Yauheni

