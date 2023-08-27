Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5AE789CBE
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Aug 2023 11:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjH0Jjb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Aug 2023 05:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjH0JjN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Aug 2023 05:39:13 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B41119;
        Sun, 27 Aug 2023 02:39:09 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52a1ce529fdso3191763a12.1;
        Sun, 27 Aug 2023 02:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693129147; x=1693733947;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qYyzxHypFBZu/5PuZAP2/UcI26Zcil+L0Fz3Xp+pJfs=;
        b=PRj8lZz2kPU20CTQgrwm6OxN3uB9aGl90ghYmA9xlacx3vNPAyu9xPRovJzhp+l03T
         VVoGuXIqMc9LvAO2tjyZmK7yNDC9wcLyhx0jo2RUl27nMIpsSQe+IhS5sQMyPH1d0gLi
         EDnBBERDHxrw/VDkLkT4DoHxYBWYhjKYrzLnGANw2dLTADA4G6/Y0p5Lizwu8ockIj/3
         GRAhqOdLAKY4F/oSh5MWZQA1OcyibCcDwAMJRmh7c87VnI118or4xaYyH7f1BcodaZtO
         874uy5qbkRJ2QRjvojVdRhH6H7z732fwdAwEwSKfrb0ZxLh7HBA9o3uGmLjcGxu40rlY
         eIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693129147; x=1693733947;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qYyzxHypFBZu/5PuZAP2/UcI26Zcil+L0Fz3Xp+pJfs=;
        b=WT0Q06Lv3DoRKw0cKHbIzon3oHK2/Sw9QgtKqw/BIbOinvemcWMWxqwQLN4QhBnCDj
         lY/Vw7rlqL6Z0L0gsJs46lpshxpP6qX4DdGUsn9UoUCJwGrGL4x3zoZwfugEp7uKFf2q
         gFD1YK8mmNs0lDI4rWrWP2i/Gg83kCzLs/nUicLD8RdDDZ3njT6nvfLK49g1Oy9wwxr/
         iof2jaye5LVS5SCGPlbAj2q5nhKrELG+5H6gSurYVzAE3IIy7kzPk3X7YkZ3BM88hiC+
         yaqbd1cg/jVCLoi5tTJ6HlHddEwMeJ7RCjOEAL3+YyeZfwD7DjxeVfYCg7XCKAHK2fCb
         on/w==
X-Gm-Message-State: AOJu0YxWPfySICspxxtCSdzXSGWPUBbMRh5Dn/BKbqSjGWIOWBRPziqV
        ncUBa/lHTY076n3l+DCbEdc=
X-Google-Smtp-Source: AGHT+IHTC4+PGmt36J8oWvy7QzTwxMbml7C6CiDClOpCdEFZwNhm40K4/mfJtEwA6CRVXVk6ZbNOIQ==
X-Received: by 2002:a17:907:2709:b0:9a1:eb67:c0ce with SMTP id w9-20020a170907270900b009a1eb67c0cemr9153281ejk.50.1693129146743;
        Sun, 27 Aug 2023 02:39:06 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id n4-20020a170906688400b0099cf840527csm3206574ejr.153.2023.08.27.02.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 02:39:06 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sun, 27 Aug 2023 11:39:02 +0200
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Rong Tao <rtoax@foxmail.com>, olsajiri@gmail.com,
        andrii@kernel.org, daniel@iogearbox.net, sdf@google.com,
        Rong Tao <rongtao@cestc.cn>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Daniel =?iso-8859-1?Q?M=FCller?= <deso@posteo.net>,
        Manu Bretelle <chantr4@gmail.com>,
        Xu Kuohai <xukuohai@huawei.com>,
        Ross Zwisler <zwisler@google.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" 
        <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH bpf-next v8] selftests/bpf: trace_helpers.c: optimize
 kallsyms cache
Message-ID: <ZOsZtjw3NAeMdWfv@krava>
References: <tencent_6D23FE187408D965E95DFAA858BC7E8C760A@qq.com>
 <CALOAHbCXVNXk4WUCRGCDsezzTfieDcLT=Jt00m4UX4zdw=RtsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCXVNXk4WUCRGCDsezzTfieDcLT=Jt00m4UX4zdw=RtsQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 27, 2023 at 10:48:44AM +0800, Yafang Shao wrote:
> On Sat, Aug 26, 2023 at 10:46 PM Rong Tao <rtoax@foxmail.com> wrote:
> >
> > From: Rong Tao <rongtao@cestc.cn>
> >
> > Static ksyms often have problems because the number of symbols exceeds the
> > MAX_SYMS limit. Like changing the MAX_SYMS from 300000 to 400000 in
> > commit e76a014334a6("selftests/bpf: Bump and validate MAX_SYMS") solves
> > the problem somewhat, but it's not the perfect way.
> >
> > This commit uses dynamic memory allocation, which completely solves the
> > problem caused by the limitation of the number of kallsyms.
> >
> > Acked-by: Stanislav Fomichev <sdf@google.com>
> > Signed-off-by: Rong Tao <rongtao@cestc.cn>
> > ---
> > v8: Resolves inter-thread contention for ksyms global variables.
> > v7: https://lore.kernel.org/lkml/tencent_BD6E19C00BF565CD5C36A9A0BD828CFA210A@qq.com/
> >     Fix __must_check macro.
> > v6: https://lore.kernel.org/lkml/tencent_4A09A36F883A06EA428A593497642AF8AF08@qq.com/
> >     Apply libbpf_ensure_mem()
> > v5: https://lore.kernel.org/lkml/tencent_0E9E1A1C0981678D5E7EA9E4BDBA8EE2200A@qq.com/
> >     Release the allocated memory once the load_kallsyms_refresh() upon error
> >     given it's dynamically allocated.
> > v4: https://lore.kernel.org/lkml/tencent_59C74613113F0C728524B2A82FE5540A5E09@qq.com/
> >     Make sure most cases we don't need the realloc() path to begin with,
> >     and check strdup() return value.
> > v3: https://lore.kernel.org/lkml/tencent_50B4B2622FE7546A5FF9464310650C008509@qq.com/
> >     Do not use structs and judge ksyms__add_symbol function return value.
> > v2: https://lore.kernel.org/lkml/tencent_B655EE5E5D463110D70CD2846AB3262EED09@qq.com/
> >     Do the usual len/capacity scheme here to amortize the cost of realloc, and
> >     don't free symbols.
> > v1: https://lore.kernel.org/lkml/tencent_AB461510B10CD484E0B2F62E3754165F2909@qq.com/
> > ---
> >  samples/bpf/Makefile                          |   4 +
> >  samples/bpf/offwaketime_user.c                |   7 +-
> >  samples/bpf/sampleip_user.c                   |   9 +-
> >  samples/bpf/spintest_user.c                   |   7 +-
> >  samples/bpf/task_fd_query_user.c              |  13 +-
> >  samples/bpf/trace_event_user.c                |   7 +-
> >  .../selftests/bpf/prog_tests/bpf_cookie.c     |   7 +-
> >  .../selftests/bpf/prog_tests/fill_link_info.c |   9 +-
> >  .../bpf/prog_tests/get_stack_raw_tp.c         |  10 +-
> >  .../bpf/prog_tests/kprobe_multi_test.c        |  13 +-
> >  .../prog_tests/kprobe_multi_testmod_test.c    |  13 +-
> >  tools/testing/selftests/bpf/trace_helpers.c   | 116 ++++++++++++------
> >  tools/testing/selftests/bpf/trace_helpers.h   |  10 +-
> >  13 files changed, 154 insertions(+), 71 deletions(-)
> 
> I think we'd better split it into two patches: one for samples/bpf/
> and another for tools/testing/selftests/bpf.
> 
> BTW, why can't we just load it once for all ?  IOW, load the kallsyms
> before we start each individual test, and free it after all tests
> finish.

there are bpf_testmod tests that unload module so we need fresh
symbols after that

jirka
