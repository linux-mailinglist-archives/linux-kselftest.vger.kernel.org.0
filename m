Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD0B651863
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Dec 2022 02:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiLTBhR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Dec 2022 20:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbiLTBgi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Dec 2022 20:36:38 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99A41CFDC;
        Mon, 19 Dec 2022 17:27:17 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id fy4so10918525pjb.0;
        Mon, 19 Dec 2022 17:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VyFIxEgnWqnUvo2rmjS4K7Tu88OX44TFhCrJ6tX8KIo=;
        b=pRhs1ishrMoO0v8GXYtYFW3V+IYFBQEmh2x+AG0gOs6cT4Uy5tiuqt4aiyOJ4DJiun
         qWBHDzAZRkNq82gRAyZOOKcgHg8Ynw3f6FQSMYViTs2HWZloSoO+Yg2eKt9VJNo5mZgE
         bCAy05R8dfxMCrw6+wP3K3n1C1OOIRc+hWNNrvOjkVqNo4ZW00A7/1ovOIO/QtULkWnB
         mh1q5TY54GdeYuOJvU1couiG3TPM0EDfr4UDySQFkaljr5/BuQoriv5m44ADD6bUvjbM
         lZYej0+R2o3mt3V8VnQFeA+soAQO3pAacWqfZeRBZVX4VZ6mZ7ERXAjCTqWEAlvD3hGd
         OUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyFIxEgnWqnUvo2rmjS4K7Tu88OX44TFhCrJ6tX8KIo=;
        b=PKQ0H63iDmBiqQ11wLfgSeUj7o6IM7cclQZmf2uA2Q1gzPezcWEPHUUE9Fj87uTNnf
         4CqFa9TYqqmNa1kkgKcpR6TXCYBpMmIIoDmBZQ66K87Wd96oQn3sARFmpa3RSxZKu/OX
         YxKTMyYaA7kbqxtBLZqdg7SyWOE51cy7FCP3HMXBn3nzWtNOLxBwcQS9WLdgR2Qk3L0d
         vreUKkNFhdILrluzoN17ystf/qQFzdbeoXhAREkDG3c4hxBzDC7uQnfSavck1cUAEuDP
         WJF1v5wlfWPpYxgQijSqHJrh3DG9bW9JV+5DjNVtto1su+5YXhikx2uTkg911SpyZLv7
         Mzxg==
X-Gm-Message-State: ANoB5plcwtY8Xwjx9aTT4ugbgnpDguwYU8j+VV4r1/bo8//WJiOlmRsb
        LiViE+6Md8tUDVBQj4VxZK8=
X-Google-Smtp-Source: AA0mqf4OqzW+ADzg42aFu8z0iEvFsDM+iVlEHmzssm+K1iZXv+6XSb7BY4xrtjZfxfX7dQl4HvxQgg==
X-Received: by 2002:a17:902:e5c8:b0:189:6ab3:9e75 with SMTP id u8-20020a170902e5c800b001896ab39e75mr63049706plf.15.1671499612787;
        Mon, 19 Dec 2022 17:26:52 -0800 (PST)
Received: from mail.google.com ([103.135.102.144])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903121000b001745662d568sm7826467plh.278.2022.12.19.17.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 17:26:52 -0800 (PST)
Date:   Tue, 20 Dec 2022 09:26:47 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Leo Yan <leo.yan@linaro.org>
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
Subject: Re: [PATCH v3 2/2] bpf: makefiles: do not generate empty vmlinux.h
Message-ID: <20221220012647.oytzq7q6ahwfhdow@mail.google.com>
References: <20221217223509.88254-1-changbin.du@gmail.com>
 <20221217223509.88254-3-changbin.du@gmail.com>
 <Y5/hqqIwJIjdBSRh@leoy-yangtze.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5/hqqIwJIjdBSRh@leoy-yangtze.lan>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 19, 2022 at 11:59:38AM +0800, Leo Yan wrote:
> On Sun, Dec 18, 2022 at 06:35:09AM +0800, Changbin Du wrote:
> > Remove the empty vmlinux.h if bpftool failed to dump btf info.
> > The empty vmlinux.h can hide real error when reading output
> > of make.
> > 
> > This is done by adding .DELETE_ON_ERROR special target in related
> > makefiles.
> 
> We need to handle the same case for perf building, its makefile
> linux/tools/perf/Makefile.perf also uses bpftool to generate
> vmlinux.h, see:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/Makefile.perf#n1067
> 
> Please consider to use a separate patch to add the same change in
> Makefile.perf?
>
It's alreay there.
https://lore.kernel.org/lkml/20221217225151.90387-1-changbin.du@gmail.com/T/

> Thanks,
> Leo
> 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/bpf/bpftool/Makefile           | 3 +++
> >  tools/testing/selftests/bpf/Makefile | 3 +++
> >  2 files changed, 6 insertions(+)
> > 
> > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > index 787b857d3fb5..313fd1b09189 100644
> > --- a/tools/bpf/bpftool/Makefile
> > +++ b/tools/bpf/bpftool/Makefile
> > @@ -289,3 +289,6 @@ FORCE:
> >  .PHONY: all FORCE bootstrap clean install-bin install uninstall
> >  .PHONY: doc doc-clean doc-install doc-uninstall
> >  .DEFAULT_GOAL := all
> > +
> > +# Delete partially updated (corrupted) files on error
> > +.DELETE_ON_ERROR:
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index c22c43bbee19..205e8c3c346a 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -626,3 +626,6 @@ EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
> >  			       liburandom_read.so)
> >  
> >  .PHONY: docs docs-clean
> > +
> > +# Delete partially updated (corrupted) files on error
> > +.DELETE_ON_ERROR:
> > -- 
> > 2.37.2
> > 

-- 
Cheers,
Changbin Du
