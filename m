Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05666514221
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Apr 2022 08:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236958AbiD2GFN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Apr 2022 02:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354334AbiD2GFL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Apr 2022 02:05:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7085FB82EE
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Apr 2022 23:01:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id q20so4055377wmq.1
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Apr 2022 23:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6xD3tKo0cs/45brcK1pt0MHgdpX3SLfWxjb+dwLYqc=;
        b=SrVSMXAjbWU4fRF6a9/P38sO2D/VuaDnchN0A3N16lOms5q9p1zkdesS9mtKmQFRnG
         O+ER2In+0cc54vFRvPbo4fGjuA/5mPDghv5/ZXFy1I/p9csUd+bnZq8HZSNMV+mG9ETe
         7ROh6dglDXbWmgxcQd62DvNurxj7NpUkIQWgOzLgJvdX/20Hm42wN4+LAXYTXd0kOg5Y
         hunARS0VWl3N6JejsbSnorCZz90k/MF3OQNWcP3K4YgTNbcwE+bk4z04/xDd7emRJBWq
         uE7QhN/BjfxyiAeVnNi+25fph9ZIr6969CPv+m0qEKGhjbuSaRVnvbD7kMQlm5ZK6bXW
         95Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6xD3tKo0cs/45brcK1pt0MHgdpX3SLfWxjb+dwLYqc=;
        b=HVSYf3Uj48D62/0kYdI5mf1rY3iPNHQw8hUg6MGJ+FP5hqv/ELFv58kY/qp4N9v62u
         bqH2CcenqOvE2fKTtC/M3bofsB92QB626F8Hxy0fRY5OMC1kRZcpJI7pqfChuTOR//p4
         seSWBif9i4qYiMc9UsNIl06NbCeG+4z+PxicMFL/yXJwNmR5gdtBq1+ZDT5ax+otLTL9
         uATau/uxtPROG0FY9yoOUnaSW/x/OPNo2J1dWBqd4X63Dctj1VpF4+f+HrkNTHa+DqQT
         N/oZCz6bSRWDq1zc5wPzFaV5hUz/jGDpcewQbeI+8e4rxc1PnOF27auEJgFBHK3A+l7g
         Zdgg==
X-Gm-Message-State: AOAM530cjG8kZX8VWifzWB8Nc3nfkSHDqmyLw3cWh/2Db54xGo6NEuFe
        5wvjQop6xFfaPF6MWzC4u+lmSRBM7bGcwI3RhdIkDw==
X-Google-Smtp-Source: ABdhPJyfWBjpEfnTBUKXQ1yykULLFfb1wjAT6SImQc+eZt5S2dSA6t1bwQrJYItdQotDFR99MWaq7E4Cfq+i0AAwavs=
X-Received: by 2002:a05:600c:2307:b0:38e:bf05:677c with SMTP id
 7-20020a05600c230700b0038ebf05677cmr1596951wmo.44.1651212111689; Thu, 28 Apr
 2022 23:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220426181925.3940286-1-dlatypov@google.com> <20220426181925.3940286-2-dlatypov@google.com>
 <CABVgOSkqymYzwaQ68AdEC5yake9VT8HkQmqbyi+9-bg1Jk1UAQ@mail.gmail.com> <CAGS_qxrowBiRBBhNmo+RyQSR6NQphkzx1k3HZ7KqXUNDZFZDzw@mail.gmail.com>
In-Reply-To: <CAGS_qxrowBiRBBhNmo+RyQSR6NQphkzx1k3HZ7KqXUNDZFZDzw@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 29 Apr 2022 14:01:40 +0800
Message-ID: <CABVgOSnb0CveWUqbB8aSYu53uRmi+H9Dim3mYbyXi+eQo=y4ww@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: add ability to specify suite-level init and
 exit functions
To:     Daniel Latypov <dlatypov@google.com>
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

On Wed, Apr 27, 2022 at 11:06 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Tue, Apr 26, 2022 at 8:56 PM David Gow <davidgow@google.com> wrote:
> > >
> > >  static size_t kunit_suite_counter = 1;
> > >
> > > -static void kunit_print_suite_end(struct kunit_suite *suite)
> > > +static void kunit_print_suite_end(struct kunit_suite *suite, int init_err)
> >
> > A part of me feels that it'd be nicer to have the init_err be part of
> > struct kunit_suite, and have kunit_suite_has_succeeded() take it into
> > account. It could go either way, though -- WDYT?
>
> Yeah, passing it around as a parameter felt a bit icky.
> But I think adding it in as a field feels worse.

Personally, I don't have a problem with having it as a field (other
than the memory usage, which shouldn't be so much as to cause
problems). It seems that the suite result is logically part of the
suite, and given that status_comment is in struct kunit_suite and
there's a kunit_status field in kunit_case, having it as a field in
the suite seems the most logically consistent thing to do.

>
> Another thought: perhaps have this function take a `kunit_status`
> parameter instead?
> Moving the ?: expression below out into the caller isn't that bad, imo.

It still doesn't solve the fact that kunit_suite_has_succeeded() no
longer tells you if a suite has succeeded or not. If we stick with
this (with the conditional either here or in the caller), I think we
should at least rename kunit_suite_has_succeded() to something like
kunit_suite_subtests_status().

That being said, I do prefer passing a 'kunit_status' around to an 'int'.

>
> >
> >
> > >  {
> > > +       enum kunit_status status =
> > > +               init_err ? KUNIT_FAILURE : kunit_suite_has_succeeded(suite);
> > > +
