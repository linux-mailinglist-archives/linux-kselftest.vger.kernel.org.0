Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284E7515374
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Apr 2022 20:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359584AbiD2STx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Apr 2022 14:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiD2STw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Apr 2022 14:19:52 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4561983017
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Apr 2022 11:16:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g20so9953384edw.6
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Apr 2022 11:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ohaQRt+I1XeCpnE3EiyqpTvMxPt5XexVM3H7FwMAdFU=;
        b=tJz5t1IcyaN8zpMztE+5rV8GEb1T2YPxEdNhP6bbaY4sVNLePDXwwQ+evAOZ/JInBp
         RtGfNgX3L9L2j2Gy4F8LwqcW6Nb3EzQ9MaG/EJqSl+mRQM+8WVhtEU4XfkkO//Uaj67Q
         nnkJlcxlGyCwPGyEH2Cj27cysYQSto8jOxaKqIkyWEvuRLQSYXLKBqvHgJJDpZA9pmDw
         7laMzclRTSviwaeZgbxxcqzj84LK1SiIJGJLftbIM78IhA7anCmnOfb9+EHlLvNaVpxr
         3IsaGCKIzNOjUfZms74qXgqk6ojmBLFqkr8TJcXN+U58d49VqQvSKI+Uo0aSULhC2zXG
         j3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ohaQRt+I1XeCpnE3EiyqpTvMxPt5XexVM3H7FwMAdFU=;
        b=pRsDEu3EdF1fBtWX1C6ZDe7gF4KCZxjtJNUNiIDubJIChXvfCAM+qO2acHMglHiMFA
         4gMmk1/KBwPCE0BSAMtuGKyYvPotbJF3f6+x0MraJFXnA64xqQsm4XBOPkHJLA+irQP2
         yWssrnrLR5A6KKiEuISr9Bwu/Q2zAULH3gcVDQQi0wO1/Y1VAqrVM33QRA/rRre6zwV+
         Pkmyvp4DEAlfYBNiH9qZjIExCHIkCszBRZw66cdBvaBIyIG1N7Koq6IKh9kKNiopJwra
         pfX8aJwlbZ8X0vsfNboEXENTCTyjTNv4k8To6+3wtsf81FRlnY4FI/b7SyBryoyd/2LR
         lsVg==
X-Gm-Message-State: AOAM5310kO1WdBllBEPmh+AFXkP+W75ldhxyohOp/4tdLmWlEXPpE+F0
        9+2QpNZoWzrsJXWzQO1hZk96W15Yhco5hjbxvioCMA==
X-Google-Smtp-Source: ABdhPJwyK0N4HlFzqGLBaqw7fh74X2fztVO9hByk1Odg8qzawUebgMFjxloMQHtsXE/FK8QTrROfQQZgrDj8RToyRfM=
X-Received: by 2002:a05:6402:3492:b0:426:19be:bf36 with SMTP id
 v18-20020a056402349200b0042619bebf36mr549149edc.36.1651256191598; Fri, 29 Apr
 2022 11:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220426181925.3940286-1-dlatypov@google.com> <20220426181925.3940286-2-dlatypov@google.com>
 <CABVgOSkqymYzwaQ68AdEC5yake9VT8HkQmqbyi+9-bg1Jk1UAQ@mail.gmail.com>
 <CAGS_qxrowBiRBBhNmo+RyQSR6NQphkzx1k3HZ7KqXUNDZFZDzw@mail.gmail.com> <CABVgOSnb0CveWUqbB8aSYu53uRmi+H9Dim3mYbyXi+eQo=y4ww@mail.gmail.com>
In-Reply-To: <CABVgOSnb0CveWUqbB8aSYu53uRmi+H9Dim3mYbyXi+eQo=y4ww@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 29 Apr 2022 13:16:20 -0500
Message-ID: <CAGS_qxoKXFutLVa_XWHpSSjvAyX_vL+BaQDWEMDBSa3S80rSWg@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: add ability to specify suite-level init and
 exit functions
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 29, 2022 at 1:01 AM David Gow <davidgow@google.com> wrote:
>
> On Wed, Apr 27, 2022 at 11:06 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > On Tue, Apr 26, 2022 at 8:56 PM David Gow <davidgow@google.com> wrote:
> > > >
> > > >  static size_t kunit_suite_counter = 1;
> > > >
> > > > -static void kunit_print_suite_end(struct kunit_suite *suite)
> > > > +static void kunit_print_suite_end(struct kunit_suite *suite, int init_err)
> > >
> > > A part of me feels that it'd be nicer to have the init_err be part of
> > > struct kunit_suite, and have kunit_suite_has_succeeded() take it into
> > > account. It could go either way, though -- WDYT?
> >
> > Yeah, passing it around as a parameter felt a bit icky.
> > But I think adding it in as a field feels worse.
>
> Personally, I don't have a problem with having it as a field (other
> than the memory usage, which shouldn't be so much as to cause
> problems). It seems that the suite result is logically part of the
> suite, and given that status_comment is in struct kunit_suite and
> there's a kunit_status field in kunit_case, having it as a field in
> the suite seems the most logically consistent thing to do.
>
> >
> > Another thought: perhaps have this function take a `kunit_status`
> > parameter instead?
> > Moving the ?: expression below out into the caller isn't that bad, imo.
>
> It still doesn't solve the fact that kunit_suite_has_succeeded() no
> longer tells you if a suite has succeeded or not. If we stick with

I forgot kunit_suite_has_succeeded() is called in the debugfs code.
So it looks like we need to track the init error in struct
kunit_suite, as you said.

It might be cleaner to just store a status in the suite eventually,
but I'll just add the int for now.

Sending a v2 series here:
https://lore.kernel.org/linux-kselftest/20220429181259.622060-1-dlatypov@google.com
I also added on a new patch to fix the type confusion in the debugfs
code (using bool instead of enum kunit_status).
