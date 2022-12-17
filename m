Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDE564F877
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Dec 2022 10:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiLQJdD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 17 Dec 2022 04:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLQJdB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Dec 2022 04:33:01 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3775B2935F;
        Sat, 17 Dec 2022 01:33:00 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id c7so3241982pfc.12;
        Sat, 17 Dec 2022 01:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=36Nz4DJ+RB5NaUU/Zyw08W8HOPfFS0NX9MwWlHipeNk=;
        b=qA+Gfdg4FMuUl+yzoNxP7NW+nR2qrAE0dHiDv85L85UpUo/O24FasYg0q6Pd4kkSq+
         dpMCQL54amyKpYpUFe/lzTeCALoGqTxc3sqFygMrGGHo9IS6BuO4S43HdUeR+yVo7ynY
         31kptZ45ZNJhtqCF3iaw6IPgoZ7e2NjmIXdb7LzgUw3pjJXQD60WvF5dKhoJw6oh/jQs
         +6DtElvZjYLwV75qrzVQMKYgi5fdjZbzbNwNmzM6Os+/KAn5EwYbSBixFspGQvur/ELJ
         6QQufx7AH/AXpaxL59kxYYiB912dVe7ZKjVj638Z8ujghbXKKA93dU+ceZ9ou7PkvgXF
         uYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36Nz4DJ+RB5NaUU/Zyw08W8HOPfFS0NX9MwWlHipeNk=;
        b=sEtzO7EhIx1tEnz1Gn6jOBKNSPplHErRvuEnF+Q4NATJq8UOOcBBGUCRDp/LLqEfqL
         /lREEAF2DOLyev8AYyaRxq+Mmzt8jXc+N697C2FXyJBDNTrLmjXBC6WTz52xIwGgythr
         E/Il/0uxT4x22soQdn5RS0a1YPD3dBqc5zypZJqvWLwlyIj8N8RMhj8JDoZ5swuLRNYU
         PGagNWP6LcWzpG2R/5zORdHJpSWzmGBe7bh5+5/Mxe/wKiS1rsUh7ceWXxxgaKngSr0D
         8C71uzS2u4fdxoNENUDpwO/cY+a4UG00YrlwM+aKQn3CZL0FWVqY0rdn6yp7JSftq+0K
         ZbBA==
X-Gm-Message-State: ANoB5pmi7sNNeFis1Q4othK2gYXr9NMvOy+xmUWLm7oZkZKm3POK9StT
        bVffkJcYNS1TgwwL1MxivLU=
X-Google-Smtp-Source: AA0mqf7ZXczKLE/hOP7YBZuLgP36h8VNtTI9Wcw2gFVvS0Xx5lrLmv0rk86AD+mzxcHXvGnBSxJNkA==
X-Received: by 2002:aa7:93da:0:b0:576:de1:cd32 with SMTP id y26-20020aa793da000000b005760de1cd32mr37301869pff.0.1671269579563;
        Sat, 17 Dec 2022 01:32:59 -0800 (PST)
Received: from mail.google.com ([103.135.102.144])
        by smtp.gmail.com with ESMTPSA id l187-20020a6225c4000000b0057621a437d7sm2777156pfl.116.2022.12.17.01.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 01:32:58 -0800 (PST)
Date:   Sat, 17 Dec 2022 17:32:49 +0800
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
Subject: Re: [PATCH v2 2/2] bpf: makefiles: do not generate empty vmlinux.h
Message-ID: <20221217093249.54nmxw4stzyymbis@mail.google.com>
References: <20221129134217.52767-1-changbin.du@gmail.com>
 <20221129134217.52767-3-changbin.du@gmail.com>
 <CAEf4BzZPZeeGJTZC3NSm+Km4RZirGrwr8d8dXepLmBLTiUn8Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZPZeeGJTZC3NSm+Km4RZirGrwr8d8dXepLmBLTiUn8Hg@mail.gmail.com>
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

On Wed, Nov 30, 2022 at 04:52:11PM -0800, Andrii Nakryiko wrote:
> On Tue, Nov 29, 2022 at 5:42 AM Changbin Du <changbin.du@gmail.com> wrote:
> >
> > Remove the empty vmlinux.h if bpftool failed to dump btf info.
> > The emptry vmlinux.h can hide real error when reading output
> 
> typo: empty
>
Will be fixed, thanks.

> > of make.
> >
> > This is done by adding .DELETE_ON_ERROR special target in related
> > makefiles.
> >
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/bpf/bpftool/Makefile           | 3 +++
> >  tools/perf/Makefile.perf             | 2 ++
> >  tools/testing/selftests/bpf/Makefile | 3 +++
> >  3 files changed, 8 insertions(+)
> >
> > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > index 4a95c017ad4c..f6b1e65085db 100644
> > --- a/tools/bpf/bpftool/Makefile
> > +++ b/tools/bpf/bpftool/Makefile
> > @@ -265,3 +265,6 @@ FORCE:
> >  .PHONY: all FORCE bootstrap clean install-bin install uninstall
> >  .PHONY: doc doc-clean doc-install doc-uninstall
> >  .DEFAULT_GOAL := all
> > +
> > +# Delete partially updated (corrupted) files on error
> > +.DELETE_ON_ERROR:
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index a432e59afc42..265254fc641a 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -1149,3 +1149,5 @@ FORCE:
> >  .PHONY: libtraceevent_plugins archheaders
> >
> >  endif # force_fixdep
> > +
> > +.DELETE_ON_ERROR:
> 
> please split out perf changes, they should go through perf tree
> 
sure, I'll send a standalone patch to perf tree.

> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index e6cf21fad69f..f41c4b011221 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -617,3 +617,6 @@ EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)      \
> >                                liburandom_read.so)
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
