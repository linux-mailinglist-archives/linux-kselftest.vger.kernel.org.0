Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A3E6E2850
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 18:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjDNQ3K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 12:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDNQ3J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 12:29:09 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C5CB477
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 09:28:49 -0700 (PDT)
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4B03C3F230
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 16:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1681489728;
        bh=wpNANq/ilARy9t0/XyiBw7GR8Agt/QoZqRUEJ1Ibgks=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=Zd0ECs63umkpldXAPTQbYEvVe1o9Y+0CvpY4AWu1ykRhWMjGyxOuTa0+mPeFYYn/y
         /EXlZBisaHHZFBAs2k9NP3wKL31J6ZAd5QqX3InqOiQq3kDSZ05NZGKx0N2V0g+FyG
         XdrlKgM/LnErZ1gb3vnphAXoNkGYGSEpoJ/C67HvrB8USYpBiko3IA7WmjnNfTHfU9
         2wA5csFJzBfvKW3BDe2gPdAU3T5stkoKa5agm1sa8G0uhJJAsTlrpIaAtrCuoUc/PD
         ijDyuj5FJEfTvgMyFZh3SkLmjb2yYlYFsWlvAiJG21JC6N4UP5ZAOlniglvT1PdRl9
         MjFQKyfBbNgdw==
Received: by mail-lf1-f71.google.com with SMTP id y5-20020a199145000000b004e85d663fa1so7293963lfj.5
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 09:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681489726; x=1684081726;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wpNANq/ilARy9t0/XyiBw7GR8Agt/QoZqRUEJ1Ibgks=;
        b=JAIeE/4snjKuLnk8rhaIaKvgmytGPNthgfskhTYClj6ARAHZF+HbazIAs1HCrnsObq
         m8R61OcS2nfbYyUred8wYIcgACNleluxpdeWK2mY9o1AYyjNxpjBxLNi91LeaSgppLXB
         nZLUL0LfWDke32UWLCM2S/1nmzwcxvkVFXSyzsVVMu61AEmVIquLIUMlAglNPRp8bUZV
         jsTTUAvh7iN2oV8zXPdOkf9Bcl+Q/TUiSAX4oStknDA2+YbZRl9GSVcgMw1ms2LIT6Ec
         0mXEHBE0JQggSLUYPx0jJNP8ZKqhZFphewrdvd+BatelWgMqseLAu5HRHpCSG3zXaGtN
         6N4w==
X-Gm-Message-State: AAQBX9dY9ROcet/sqSR6OFuNET08BsJ1RI+FpNmaEuXzK/5okTzHB1RL
        hEFkkiDd/lKgssh5G8nM7emXUEoTuo/h5+CE0ZAY9g9d5C2f+b8OherPZNmnwkrIe242DIopusL
        q77R4KsskqHW6Y2uF/jn1KlL5+gSBOIgaKLLDArPR6hMqfA==
X-Received: by 2002:aa7:c954:0:b0:505:513f:3d2d with SMTP id h20-20020aa7c954000000b00505513f3d2dmr7043301edt.40.1681489705618;
        Fri, 14 Apr 2023 09:28:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350YbGpRAixvk9knTsT5HdyKaFpVZaQIhjKQceN8mlrIOVuzQAKt2/2mI4XtLorXKKGVk3XV8Jg==
X-Received: by 2002:aa7:c954:0:b0:505:513f:3d2d with SMTP id h20-20020aa7c954000000b00505513f3d2dmr7043286edt.40.1681489705339;
        Fri, 14 Apr 2023 09:28:25 -0700 (PDT)
Received: from localhost (uk.sesame.canonical.com. [185.125.190.60])
        by smtp.gmail.com with ESMTPSA id q10-20020a056402032a00b004bd1fe2cc02sm2281873edw.16.2023.04.14.09.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 09:28:25 -0700 (PDT)
Date:   Fri, 14 Apr 2023 18:28:24 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/bpf: ignore pointer types check with clang
Message-ID: <ZDl/KFLy7wOBa2tj@righiandr-XPS-13-7390>
References: <20230412095912.188453-1-andrea.righi@canonical.com>
 <CAADnVQJ00Npkp=+XYaTybzaPnrcfK0nKrePAktVNBt2-YqWdEg@mail.gmail.com>
 <ZDjvZ7mx7+IsSCCO@righiandr-XPS-13-7390>
 <q5rj72tmwlpzx6qgkromem5t7q6xmen52aavfr65olnuv52f3z@wzs4p3xz3635>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <q5rj72tmwlpzx6qgkromem5t7q6xmen52aavfr65olnuv52f3z@wzs4p3xz3635>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 14, 2023 at 06:15:38PM +0200, Ilya Leoshkevich wrote:
> On Fri, Apr 14, 2023 at 08:15:03AM +0200, Andrea Righi wrote:
> > On Thu, Apr 13, 2023 at 09:56:00PM -0700, Alexei Starovoitov wrote:
> > > On Wed, Apr 12, 2023 at 2:59 AM Andrea Righi <andrea.righi@canonical.com> wrote:
> > > >
> > > > Building bpf selftests with clang can trigger errors like the following:
> > > >
> > > >   CLNG-BPF [test_maps] bpf_iter_netlink.bpf.o
> > > > progs/bpf_iter_netlink.c:32:4: error: incompatible pointer types assigning to 'struct sock *' from 'struct sock___17 *' [-Werror,-Wincompatible-pointer-types]
> > > >         s = &nlk->sk;
> > > >           ^ ~~~~~~~~
> > > > 1 error generated.
> > > 
> > > I cannot reproduce this and BPF CI doesn't complain about it either.
> > > What kind of clang do you use?
> > > Some special version and build flags?
> > 
> > I'm using Ubuntu clang version 15.0.7 (Ubuntu 23.04), no special build
> > flag (unless Ubuntu enables some different default flags, but it
> > shouldn't be the case... I'll double check).
> > 
> > -Andrea
> 
> Hi,
> 
> FWIW, I see similar errors when I don't use recent pahole.

I'm using pahole v1.24.

-Andrea
