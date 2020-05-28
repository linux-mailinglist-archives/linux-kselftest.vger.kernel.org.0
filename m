Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D99E1E5D85
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 12:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387950AbgE1K4e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 06:56:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387926AbgE1K4e (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 06:56:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24CE120888;
        Thu, 28 May 2020 10:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590663393;
        bh=8CgwqSD7FbFvIGgxB8tScQMyzULSJiYFcTKOgBAiwQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fStPkTQipiuj77vcWwUO9FB4A+IroYZVbZo5RM1uIpAn2+WVsBMeFGhWbkkGHkWmK
         BqDPsBeNPPe/kHNn4vkXbquqZYpYKdr99ex3cK5BGgGuoXNOxzZzulHKYkocNZUfoG
         fqlBdrNHSkd4xNs1yYFbtjWlve5iLizOAvwwnaNc=
Date:   Thu, 28 May 2020 12:56:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Benc <jbenc@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     shuah <shuah@kernel.org>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/bpf: split -extras target to -static and -gen
Message-ID: <20200528105631.GE3115014@kroah.com>
References: <CAEf4BzZaCTDT6DcLYvyFr4RUUm4fFbyb743e1JrEp2DS69cbug@mail.gmail.com>
 <xunya71uosvv.fsf@redhat.com>
 <CAADnVQJUL9=T576jo29F_zcEd=C6_OiExaGbEup6F-mA01EKZQ@mail.gmail.com>
 <xuny367lq1z1.fsf@redhat.com>
 <CAADnVQ+1o1JAm7w1twW0KgKMHbp-JvVjzET2N+VS1z=LajybzA@mail.gmail.com>
 <xunyh7w1nwem.fsf@redhat.com>
 <CAADnVQKbKA_Yuj7v3c6fNi7gZ8z_q_hzX2ry9optEHE3B_iWcg@mail.gmail.com>
 <ec5f6bd9-83e9-fc55-1885-18eee404d988@kernel.org>
 <CAADnVQJhb0+KWY0=4WVKc8NQswDJ5pU7LW1dQE2TQuya0Pn0oA@mail.gmail.com>
 <20200528100557.20489f04@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528100557.20489f04@redhat.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 28, 2020 at 10:05:57AM +0200, Jiri Benc wrote:
> On Wed, 27 May 2020 15:23:13 -0700, Alexei Starovoitov wrote:
> > I prefer to keep selftests/bpf install broken.
> > This forced marriage between kselftests and selftests/bpf
> > never worked well. I think it's a time to free them up from each other.
> 
> Alexei, it would be great if you could cooperate with other people
> instead of pushing your own way. The selftests infrastructure was put
> to the kernel to have one place for testing. Inventing yet another way
> to add tests does not help anyone. You don't own the kernel. We're
> community, we should cooperate.

I agree, we rely on the infrastructure of the kselftests framework so
that testing systems do not have to create "custom" frameworks to handle
all of the individual variants that could easily crop up here.

Let's keep it easy for people to run and use these tests, to not do so
is to ensure that they are not used, which is the exact opposite goal of
creating tests.

thanks,

greg k-h
