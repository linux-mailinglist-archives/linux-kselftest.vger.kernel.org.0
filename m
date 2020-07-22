Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37173228DEA
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jul 2020 04:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbgGVCNK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jul 2020 22:13:10 -0400
Received: from condef-07.nifty.com ([202.248.20.72]:30785 "EHLO
        condef-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731621AbgGVCNJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jul 2020 22:13:09 -0400
Received: from conssluserg-01.nifty.com ([10.126.8.80])by condef-07.nifty.com with ESMTP id 06M29rjj003253;
        Wed, 22 Jul 2020 11:09:53 +0900
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 06M29TuW014750;
        Wed, 22 Jul 2020 11:09:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 06M29TuW014750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1595383770;
        bh=06gcJexBF/tpPqvX05Gt/CkE+hULn79ToD587rmdDQs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dSg4gOQ/jjsop05eIvXnSVytHbNKER9gJUCj/xFmRlxYS+uGMyhYC2Jk8d1UBmCVX
         N1wjZTgmQYzpQCSGv2J5c4KvJ2kjyLKOzJFC5l8gYX1yjdoAtZ7mns1fCfS9MfKUGa
         feiB1WnrJiEjtgGX1PThQkOVSt0m95ze/qj3NqeLBZOk3KVAJoyBMNQGHxUiE6bUgU
         S7BpYr/Q3jpf2LPbiVV4KR9pdEwxudC0XZrB2hLCO21kIoIwLsPStojFwuyeXxnb3e
         +DA66Lbh5i1vksPqHMaAxXTAXudMclMGABTxcYMX8driO5gHjm+9iL6JkpQWAP1/AR
         VVd88rpFkynxw==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id s20so330522vsq.5;
        Tue, 21 Jul 2020 19:09:29 -0700 (PDT)
X-Gm-Message-State: AOAM533nsgc4IMlpB454vyz6TB6mt+fAfr7w+7yvTX9jwoDxUQuIjOAS
        1ZOQry2AGUE6VKL880TXZIx/CvCLACPhDxKUjJI=
X-Google-Smtp-Source: ABdhPJzHR+EIktThMD2rIpFhI4uTJPOQdJWdMC4eTf5k71hKCt1edF/2edrSgjCexGMNslyvA9SMcKmKrD1IOmpXMxw=
X-Received: by 2002:a67:de09:: with SMTP id q9mr21900661vsk.179.1595383768506;
 Tue, 21 Jul 2020 19:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200707092117.963394-1-masahiroy@kernel.org> <20200707092117.963394-2-masahiroy@kernel.org>
 <20200707120212.7010fa4f@oasis.local.home>
In-Reply-To: <20200707120212.7010fa4f@oasis.local.home>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 22 Jul 2020 11:08:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNASdytWgqQWux1cyBrGJb_FvS7Ur5UqgHaA2Xf5cwfL85A@mail.gmail.com>
Message-ID: <CAK7LNASdytWgqQWux1cyBrGJb_FvS7Ur5UqgHaA2Xf5cwfL85A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kbuild: trace functions in subdirectories of lib/
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Haren Myneni <haren@us.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jiri Kosina <jikos@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Tal Gilboa <talgi@mellanox.com>, kunit-dev@googlegroups.com,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 8, 2020 at 1:02 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue,  7 Jul 2020 18:21:17 +0900
> Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> >   ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
> >
> > exists here in sub-directories of lib/ to keep the behavior of
> > commit 2464a609ded0 ("ftrace: do not trace library functions").
> >
> > Since that commit, not only the objects in lib/ but also the ones in
> > the sub-directories are excluded from ftrace (although the commit
> > description did not explicitly mention this).
> >
> > However, most of library functions in sub-directories are not so hot.
> > Re-add them to ftrace.
>
> I'm OK with this change, but note, it wasn't just the hot path that I
> disabled ftrace on lib for, but some of these calls are done very early
> at boot up. It may have been PowerPC that I was stumbling over. The
> issue is that they would call mcount before the kernel was mapped
> properly, and the system would crash.
>
> My PowerPC box no longer boots so I can't test this anymore. But a lot
> has changed since 2008, and all this may very well be OK.
>
> -- Steve


That's why I split this into two commits
so that we can do git-bisect and
revert the second one in case of a regression.

Anyway, we have some more time to test this in linux-next
(and somebody reports an issue, if any).


-- 
Best Regards
Masahiro Yamada
