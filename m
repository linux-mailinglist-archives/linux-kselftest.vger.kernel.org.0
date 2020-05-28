Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450F31E672F
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 18:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404919AbgE1QOs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 12:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404899AbgE1QOq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 12:14:46 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5088C08C5C6;
        Thu, 28 May 2020 09:14:45 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ci21so3379052pjb.3;
        Thu, 28 May 2020 09:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cTa8jPiAl8cxlUiiMwc6w2KUDCB8Y2+LiAcBzLiLDjY=;
        b=F4c2HQlovV9Ue0VXuH4VKTzsDOI4XolpY0j+ZcnjzV04PCVEVg8zjAj/fQfr1B90IC
         EeAKNKwbskUkZkV3VOwG+5ZrQAXAZ7lR3e9gE7BKZSDeQrCRk4UabKJC/clVPRchBGBf
         9D9hI/0gahlyR7xT8NP/A+esZOu+B5vX95/rycYxSYN7AkdNn0psWqT+qzHe0XV3GEjE
         GqZU+dOokYayQBHFRyxNwbdy+Ng3VUorHDsma1XpA0mtz2ET+lR6NrO21s9MrwSRfEkN
         uayYeMc2WNz8+eMCg2BaLuBh1bl41uyh3LhCwIs643kfrJjxJz9fRK3FkPFQd7vPrqdy
         wRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cTa8jPiAl8cxlUiiMwc6w2KUDCB8Y2+LiAcBzLiLDjY=;
        b=nSmwGQcodVcLvjQACFejs5iG1BmuZTeePiUyZMhrtbayR8ZcBiTl+dNLWFaxryPj7R
         jKeNq5zla3WyxbxZetXrlTOWTZsPM4CCC3R+mYGOYZiRBtpmd39p7eCselTfwkdVwwk0
         SJ9ALYKRJMqtq3IDTpvFctPcvvbnhlrWBAHxs9OxTv375fgsUqtcr/5ucwweji638NxP
         LfWmPIgccuHh+Wh/qorVhU/iPBMF+OoE5j+0kAwp1hgfp1OsALSZKSykqitZMSexQ7v7
         ABc0a2EmR6nkafwZZ0otYT0C+4JCxgr/GWumfoDPG98/zEcyaVdOcr2QgW5KN4l7MNGB
         cDaA==
X-Gm-Message-State: AOAM531P3Ob+kDK8XBVfUAh+dxBhQdX+bPSrPcQ2Hh2+H+9YZ6aS266F
        NqgNrNLEefiZaPTySCrtNIFGjGkV
X-Google-Smtp-Source: ABdhPJw9pNbthryY5PJYcdzzvHVNTK4gq8CTpHrX2eGCaV/y1MaxW+3gxrRyvE3fqgD9tFNusbapXw==
X-Received: by 2002:a17:902:a515:: with SMTP id s21mr4285248plq.334.1590682485385;
        Thu, 28 May 2020 09:14:45 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:4a1c])
        by smtp.gmail.com with ESMTPSA id q193sm5193057pfq.158.2020.05.28.09.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 09:14:44 -0700 (PDT)
Date:   Thu, 28 May 2020 09:14:37 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Benc <jbenc@redhat.com>, shuah <shuah@kernel.org>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/bpf: split -extras target to -static and -gen
Message-ID: <20200528161437.x3e2ddxmj6nlhvv7@ast-mbp.dhcp.thefacebook.com>
References: <xunya71uosvv.fsf@redhat.com>
 <CAADnVQJUL9=T576jo29F_zcEd=C6_OiExaGbEup6F-mA01EKZQ@mail.gmail.com>
 <xuny367lq1z1.fsf@redhat.com>
 <CAADnVQ+1o1JAm7w1twW0KgKMHbp-JvVjzET2N+VS1z=LajybzA@mail.gmail.com>
 <xunyh7w1nwem.fsf@redhat.com>
 <CAADnVQKbKA_Yuj7v3c6fNi7gZ8z_q_hzX2ry9optEHE3B_iWcg@mail.gmail.com>
 <ec5f6bd9-83e9-fc55-1885-18eee404d988@kernel.org>
 <CAADnVQJhb0+KWY0=4WVKc8NQswDJ5pU7LW1dQE2TQuya0Pn0oA@mail.gmail.com>
 <20200528100557.20489f04@redhat.com>
 <20200528105631.GE3115014@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528105631.GE3115014@kroah.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 28, 2020 at 12:56:31PM +0200, Greg KH wrote:
> On Thu, May 28, 2020 at 10:05:57AM +0200, Jiri Benc wrote:
> > On Wed, 27 May 2020 15:23:13 -0700, Alexei Starovoitov wrote:
> > > I prefer to keep selftests/bpf install broken.
> > > This forced marriage between kselftests and selftests/bpf
> > > never worked well. I think it's a time to free them up from each other.
> > 
> > Alexei, it would be great if you could cooperate with other people
> > instead of pushing your own way. The selftests infrastructure was put
> > to the kernel to have one place for testing. Inventing yet another way
> > to add tests does not help anyone. You don't own the kernel. We're
> > community, we should cooperate.
> 
> I agree, we rely on the infrastructure of the kselftests framework so
> that testing systems do not have to create "custom" frameworks to handle
> all of the individual variants that could easily crop up here.
> 
> Let's keep it easy for people to run and use these tests, to not do so
> is to ensure that they are not used, which is the exact opposite goal of
> creating tests.

Greg,

It is easy for people (bpf developers) to run and use the tests.
Every developer runs them before submitting patches.
New tests is a hard requirement for any new features.
Maintainers run them for every push.

What I was and will push back hard is when other people (not bpf developers)
come back with an excuse that some CI system has a hard time running these
tests. It's the problem of weak CI. That CI needs to be fixed. Not the tests.
The example of this is that we already have github/libbpf CI that runs
selftests/bpf just fine. Anyone who wants to do another CI are welcome to copy
paste what already works instead of burdening people (bpf developers) who run
and use existing tests. I frankly have no sympathy to folks who put their own
interest of their CI development in front of bpf community of developers.
The main job of CI is to help developers and maintainers.
Where helping means to not impose new dumb rules on developers because CI
framework is dumb. Fix CI instead.
