Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64791464F69
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Dec 2021 15:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243146AbhLAORE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 09:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238769AbhLAORD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 09:17:03 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A01FC061574
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Dec 2021 06:13:42 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v11so52607470wrw.10
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Dec 2021 06:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lwGtcWrExmKriF2wN+zvnNRfBCutx0hyLfQNb4LTKdk=;
        b=li1UHffcpoEWxzpIhxE5KP4K/GRG9hAvhh0mdqBkjxQdJXHOl1Wn+CMiTpKOz1GNHB
         s7NQKCLTLQHTv9JppDD6Va6ptPCEddQxicuTsT8HvLugBKkI3jAFdALpmZqnZfSQAfSM
         U2x3/7EA/qdTqPgh0AyiVEkxR5mtfrsnvRY9A5pC37Q+WYeFvNQQ6Vtek4yaNf9Baldd
         O6FpxTtBZqBT9dcxyVw82IITrbtzHhsFER+wo/c4UIpQWmM8w5R/PKTx49dM7uSLCxIp
         hgHqDH54WHf82li0EcnbXGMa7uK+NfRkfWwDUgEZmmkNkUTciRiClx6oGe1od6Wys+2Z
         SZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lwGtcWrExmKriF2wN+zvnNRfBCutx0hyLfQNb4LTKdk=;
        b=xZC99R9PPkd+FQAlDJHRnH8f5X9EDf7G+ssRY/TgwIdltRcJk/KflpGOTuFIHs6C2H
         TihcJ/PEKN+Xt93CpTOihyapmshsObRROi+5OKOKi3GfZrpDKUZueTlDhsgxL6wwLQNc
         KHzwJScbezCJp15rkCRg4UPSupdOQrzd14km7qV/3skQDPx/ZdVrjD+fyIdx4od+sO1a
         DI09ykM/xs5fOTlqwUC+2cv/hKya2KsA8u+sjuzeTPQOTs4CefQ5Z8zSR7UUmVTuy00o
         GIFLjs3kEtNUJIv3hDrXcGh8hAWf1mSvOYsUy71vhnsWLMqiEfAlOdHfw8CYPk8nw8dE
         latA==
X-Gm-Message-State: AOAM530tJ4V7B3tjr+FCcFBi2mPFq4i48Ywiq5ItAlXSa7NGtCZFYWZ/
        GpPE2vDc8/Hf0jChuCi4xZpaig==
X-Google-Smtp-Source: ABdhPJw8xpFALfdBRCYOtz6hwodjBBsrNs6Fiji/NmyNWWuuexwyZ/+ppQfip3DrFSPJko65CTzD/A==
X-Received: by 2002:adf:f44c:: with SMTP id f12mr6878614wrp.620.1638368020895;
        Wed, 01 Dec 2021 06:13:40 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id r83sm1147358wma.22.2021.12.01.06.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 06:13:40 -0800 (PST)
Date:   Wed, 1 Dec 2021 14:13:18 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Build testing_helpers.o out of
 tree
Message-ID: <YaeC/mu5CiUohu27@myrica>
References: <20211129111508.404367-1-jean-philippe@linaro.org>
 <CAEf4BzZqyiGC-941FwOxRJZPVHn38vkyEp479nfchKZnZ=kehw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZqyiGC-941FwOxRJZPVHn38vkyEp479nfchKZnZ=kehw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 29, 2021 at 03:23:02PM -0800, Andrii Nakryiko wrote:
> On Mon, Nov 29, 2021 at 3:17 AM Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > Add $(OUTPUT) prefix to testing_helpers.o, so it can be built out of
> > tree when necessary. At the moment, in addition to being built in-tree
> > even when out-of-tree is required, testing_helpers.o is not built with
> > the right recipe when cross-building.
> >
> > Fixes: f87c1930ac29 ("selftests/bpf: Merge test_stub.c into testing_helpers.c")
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >  tools/testing/selftests/bpf/Makefile | 32 ++++++++++++++--------------
> >  1 file changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index 35684d61aaeb..082f6aeec1d9 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -192,22 +192,22 @@ TEST_GEN_PROGS_EXTENDED += $(DEFAULT_BPFTOOL)
> >
> >  $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(BPFOBJ)
> >
> > -$(OUTPUT)/test_dev_cgroup: cgroup_helpers.c testing_helpers.o
> 
> one of cgroup_helper.c (C source code) or testing_helper.o (object
> file) is wrong, let's ensure that the dependencies are correct while
> at it?

Sure, I'll change this to object files

Thanks,
Jean

> 
> 
> > -$(OUTPUT)/test_skb_cgroup_id_user: cgroup_helpers.c testing_helpers.o
> > -$(OUTPUT)/test_sock: cgroup_helpers.c testing_helpers.o
> > -$(OUTPUT)/test_sock_addr: cgroup_helpers.c testing_helpers.o
> > -$(OUTPUT)/test_sockmap: cgroup_helpers.c testing_helpers.o
> > -$(OUTPUT)/test_tcpnotify_user: cgroup_helpers.c trace_helpers.c testing_helpers.o
> > -$(OUTPUT)/get_cgroup_id_user: cgroup_helpers.c testing_helpers.o
> > -$(OUTPUT)/test_cgroup_storage: cgroup_helpers.c testing_helpers.o
> > -$(OUTPUT)/test_sock_fields: cgroup_helpers.c testing_helpers.o
> > -$(OUTPUT)/test_sysctl: cgroup_helpers.c testing_helpers.o
> > -$(OUTPUT)/test_tag: testing_helpers.o
> > -$(OUTPUT)/test_lirc_mode2_user: testing_helpers.o
> > -$(OUTPUT)/xdping: testing_helpers.o
> > -$(OUTPUT)/flow_dissector_load: testing_helpers.o
> > -$(OUTPUT)/test_maps: testing_helpers.o
> > -$(OUTPUT)/test_verifier: testing_helpers.o
> > +$(OUTPUT)/test_dev_cgroup: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
> > +$(OUTPUT)/test_skb_cgroup_id_user: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
> > +$(OUTPUT)/test_sock: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
> > +$(OUTPUT)/test_sock_addr: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
> > +$(OUTPUT)/test_sockmap: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
> > +$(OUTPUT)/test_tcpnotify_user: cgroup_helpers.c trace_helpers.c $(OUTPUT)/testing_helpers.o
> > +$(OUTPUT)/get_cgroup_id_user: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
> > +$(OUTPUT)/test_cgroup_storage: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
> > +$(OUTPUT)/test_sock_fields: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
> > +$(OUTPUT)/test_sysctl: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
> > +$(OUTPUT)/test_tag: $(OUTPUT)/testing_helpers.o
> > +$(OUTPUT)/test_lirc_mode2_user: $(OUTPUT)/testing_helpers.o
> > +$(OUTPUT)/xdping: $(OUTPUT)/testing_helpers.o
> > +$(OUTPUT)/flow_dissector_load: $(OUTPUT)/testing_helpers.o
> > +$(OUTPUT)/test_maps: $(OUTPUT)/testing_helpers.o
> > +$(OUTPUT)/test_verifier: $(OUTPUT)/testing_helpers.o
> >
> >  BPFTOOL ?= $(DEFAULT_BPFTOOL)
> >  $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
> > --
> > 2.34.0
> >
