Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172621E692D
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 20:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405768AbgE1SRx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 14:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405735AbgE1SRw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 14:17:52 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9E5C08C5C6;
        Thu, 28 May 2020 11:17:52 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d3so11949580pln.1;
        Thu, 28 May 2020 11:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8g3nSFfFtHg0EndD9BPNck6fy8M7jE9Q+n5Ov4ytjrk=;
        b=WAnI9POxMpkbQaQbNspeUHKjPXcpM9EmTLCwqJMkrIzN7hhR7aF43SRqyzkdR6h9vi
         5UJIIWmpJEhI49VRKD4wMcevFw6aF2jJW+q7lvvaSDYbHoTtqKeWEgAmcQguSMr3bkjA
         SXbcenhtySoUFh/ne76tkGQcJz7GpIprYMPIQNXBwJ4CATWOZb9CzC+anBXy84uX0HCA
         ZTsvsQXTtkbOEZjXXJ7OsprQn4yo+N8tgKc1TCtVCj2Asu6hnkNEfdeLbz4l1JS3rPGK
         QJDHRbuACS8IbVtDl3kVAMAeuEz+bjfVPtAczw/H9rdvX4nVt+xW83WAFnsubPYD8ptK
         cy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8g3nSFfFtHg0EndD9BPNck6fy8M7jE9Q+n5Ov4ytjrk=;
        b=ZF8t0cX7cLHebN9jF5a7u8o48lkkhnLFoEr5b3CzhzB8dx1SFukaKTolyR3svLZ6WK
         w+W1RUTgYSqyzPYq5Sj35G18L/11rfZaEXaNDlkoWVTk3hJfUrlpRfcNS0IxF3iDdf5m
         CZ3s9akHNwobEB5LoRwydyukgf7IShuh16mGAbQmlkksNMpGioBcUmI1qzduICdkC1He
         0HAMNWGfEcde8DOqdE3bXnXAhuCm1FifzjBLNSFuFGifC3stvqUrmi0icg5uo41/gClD
         8dS79wSyOzGyVgVYHvFPFhc9cF0tPwU6ndAzBmCm+/yjr7nUq3klW2LYPhjbRAfArlmR
         SHCA==
X-Gm-Message-State: AOAM531qiggy/qGgBt8fb7nMeCTeb8a9TXM+z68pmm4/10xuKH+W8dNh
        s3KDmfgGabFhs6Chpgn+HA8=
X-Google-Smtp-Source: ABdhPJykyNtwJKA4EUv9LnFy38v+pCS0kEbbwO/zOp4WepNs+0dB/AVEvHpGZq47PkgShETrtRTVHg==
X-Received: by 2002:a17:90b:344d:: with SMTP id lj13mr5358916pjb.160.1590689871737;
        Thu, 28 May 2020 11:17:51 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:4a1c])
        by smtp.gmail.com with ESMTPSA id y85sm5276401pfc.24.2020.05.28.11.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 11:17:50 -0700 (PDT)
Date:   Thu, 28 May 2020 11:17:48 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jiri Benc <jbenc@redhat.com>,
        shuah <shuah@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/bpf: split -extras target to -static and -gen
Message-ID: <20200528181748.fsc7vivfppe4rsx2@ast-mbp.dhcp.thefacebook.com>
References: <xuny367lq1z1.fsf@redhat.com>
 <CAADnVQ+1o1JAm7w1twW0KgKMHbp-JvVjzET2N+VS1z=LajybzA@mail.gmail.com>
 <xunyh7w1nwem.fsf@redhat.com>
 <CAADnVQKbKA_Yuj7v3c6fNi7gZ8z_q_hzX2ry9optEHE3B_iWcg@mail.gmail.com>
 <ec5f6bd9-83e9-fc55-1885-18eee404d988@kernel.org>
 <CAADnVQJhb0+KWY0=4WVKc8NQswDJ5pU7LW1dQE2TQuya0Pn0oA@mail.gmail.com>
 <20200528100557.20489f04@redhat.com>
 <20200528105631.GE3115014@kroah.com>
 <20200528161437.x3e2ddxmj6nlhvv7@ast-mbp.dhcp.thefacebook.com>
 <CANoWswkGoJEZVcfLiNverDWyh6skSoix=JqxeJR9K8A=H8x=rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANoWswkGoJEZVcfLiNverDWyh6skSoix=JqxeJR9K8A=H8x=rw@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 28, 2020 at 08:10:57PM +0300, Yauheni Kaliuta wrote:
> Hi, Alexei,
> 
> On Thu, May 28, 2020 at 7:14 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, May 28, 2020 at 12:56:31PM +0200, Greg KH wrote:
> > > On Thu, May 28, 2020 at 10:05:57AM +0200, Jiri Benc wrote:
> > > > On Wed, 27 May 2020 15:23:13 -0700, Alexei Starovoitov wrote:
> > > > > I prefer to keep selftests/bpf install broken.
> > > > > This forced marriage between kselftests and selftests/bpf
> > > > > never worked well. I think it's a time to free them up from each other.
> > > >
> > > > Alexei, it would be great if you could cooperate with other people
> > > > instead of pushing your own way. The selftests infrastructure was put
> > > > to the kernel to have one place for testing. Inventing yet another way
> > > > to add tests does not help anyone. You don't own the kernel. We're
> > > > community, we should cooperate.
> > >
> > > I agree, we rely on the infrastructure of the kselftests framework so
> > > that testing systems do not have to create "custom" frameworks to handle
> > > all of the individual variants that could easily crop up here.
> > >
> > > Let's keep it easy for people to run and use these tests, to not do so
> > > is to ensure that they are not used, which is the exact opposite goal of
> > > creating tests.
> >
> > Greg,
> >
> > It is easy for people (bpf developers) to run and use the tests.
> > Every developer runs them before submitting patches.
> > New tests is a hard requirement for any new features.
> > Maintainers run them for every push.
> >
> > What I was and will push back hard is when other people (not bpf developers)
> > come back with an excuse that some CI system has a hard time running these
> > tests. It's the problem of weak CI. That CI needs to be fixed. Not the tests.
> > The example of this is that we already have github/libbpf CI that runs
> > selftests/bpf just fine. Anyone who wants to do another CI are welcome to copy
> > paste what already works instead of burdening people (bpf developers) who run
> > and use existing tests. I frankly have no sympathy to folks who put their own
> > interest of their CI development in front of bpf community of developers.
> > The main job of CI is to help developers and maintainers.
> > Where helping means to not impose new dumb rules on developers because CI
> > framework is dumb. Fix CI instead.
> >
> 
> Any good reason why bpf selftests, residing under selftests/, should
> be an exception?
> "Breakages" is not, breakages are fixable.

As I said early the location of bpf selftests in tools/testing/selftests/
was a historical mistake that needs to be corrected.
There is no value in residing in that directory.
kselftest are aiming to test the kernel whereas selftests/bpf are testing
kernel, libbpf, bpftool, llvm, pahole. These are the tests for bpf ecosystem.
