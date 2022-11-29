Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1439D63BC00
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 09:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiK2Ith (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 03:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiK2Itf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 03:49:35 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A51421BC;
        Tue, 29 Nov 2022 00:48:42 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so16632482pjs.4;
        Tue, 29 Nov 2022 00:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EC4xRvqluGfZQhXOMZWHGN3jn09RvjDMpBCLAdi0QzI=;
        b=goyC1rqlr+kCBTqmN6es+d4t4wo7D0f1KQ5hgdppbSYnj7tqeGedd6ITcEC1uXu8Hb
         JxPzDxEL2sgzlkfwbrhuzUFkPmmnvRp/Wh3VyHlJ/3PLOFLM4A/j09FEKcBzcu2qUdS8
         Qgfhat/bh+OsnvNTB7Ovb51Heu2cUi9sz7fsIraxd/+nlL4SkM9uVRdSDvpCKMaOv1Hi
         yabXURGGkNNQJJ6QWkv7aVsIsRaStLFpD12/yFDPvfX1yJUI3zZ82zE8RufdkHR/gQ3Z
         Igwq84ygge8XJSbD5dJ0vla90wrpcT9dQPtF2UJpgU635rg+e4ThC6q2809e+lVn2gat
         LU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EC4xRvqluGfZQhXOMZWHGN3jn09RvjDMpBCLAdi0QzI=;
        b=n0aDzRHmMZbDb2HyhcqJ5HlHUYiGhcTEULLSpRSCbogSRSA9XFvqUmOh1FWjQi0L8C
         OzqqgM7oOzIdTOuGt9hSeIM/fN9J2HeHJ+oAPKqLRmaywVh8m0KKkppfwVQFqtevqbIq
         OI3C5h2T8pmAG38Fdv2No8B2CL70vZRso6Xi08/Q7cN7zPxXjFOJOpu7BrczonANGmyf
         V9pIUOZlvpolYv2ksF1dYpl1slhii0S72yvmWR6aZKubwmD63TV+cZqse4nTRnHV4PMA
         Ch8GQf6FFFmqI5eRqUnpu2iuYK5q7Cqeriq7UEcW4sP5jz4XpFestxwGMXPqUaj/aZmS
         1ICw==
X-Gm-Message-State: ANoB5plKluklRp+gMvGkTytcCmDMPZloxJXxw8oWoaZ7tWox37t3gm25
        /gGLgKPf1FuPttVPQOTxcRYz5oi/+Nf+E9If
X-Google-Smtp-Source: AA0mqf5rVsOhZuL3V/KGRx4gIVWTwHBsR8edMvyXagWtyn99J6QjqMwIEXljBY1iLo4r+PV4YXpcDQ==
X-Received: by 2002:a17:90a:7885:b0:217:e32e:e931 with SMTP id x5-20020a17090a788500b00217e32ee931mr64379443pjk.146.1669711722097;
        Tue, 29 Nov 2022 00:48:42 -0800 (PST)
Received: from mail.google.com ([103.135.102.183])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902d48a00b00188a7bce192sm10258651plg.264.2022.11.29.00.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 00:48:41 -0800 (PST)
Date:   Tue, 29 Nov 2022 16:48:29 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] makefiles: do not generate empty vmlinux.h
Message-ID: <20221129084829.ktim5wfe5rpjxw67@mail.google.com>
References: <20221126111147.199366-1-changbin.du@gmail.com>
 <20221126111147.199366-3-changbin.du@gmail.com>
 <CAEf4BzZ6Ks0T=72vtGNc0TyPxHMO6PEFQb8TEYj7XmtqWjfDwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ6Ks0T=72vtGNc0TyPxHMO6PEFQb8TEYj7XmtqWjfDwQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 28, 2022 at 10:00:14PM -0800, Andrii Nakryiko wrote:
> On Sat, Nov 26, 2022 at 3:13 AM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > Remove the empty vmlinux.h if bpftool failed to dump btf info.
> > The emptry vmlinux.h can hide real error when reading output
> > of make.
> 
> wouldn't this be better handled by adding .DELETE_ON_ERROR: to
> bpftool's Makefile?
>
yes, let me replace it.

-- 
Cheers,
Changbin Du
