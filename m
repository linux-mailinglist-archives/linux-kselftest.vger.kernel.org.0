Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9ED3159A5
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Feb 2021 23:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbhBIWq3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Feb 2021 17:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbhBIWYt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Feb 2021 17:24:49 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89358C0698CF
        for <linux-kselftest@vger.kernel.org>; Tue,  9 Feb 2021 14:21:47 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id o7so77993ils.2
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Feb 2021 14:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dVB7ZPJgZD0gpsdinXm4ggMxiYerGmhY62XEYI3Nvq8=;
        b=MxNbW+PSVA9TGA1dcXUzDd9bAT7WKBNgXyxHyeswIk6TSdAUod8lXC/nWOMXa979O/
         xBxNNaElu7TdqiVNrY0TRFzj9jrwd3DdFBtJ48YlJrKoYVQGKsMGZYw1l7akRl14XWpL
         t7b95PSVF8yxQloGrXMTYycD3J5vKU/hme/z/rF4fOpv9eqK3JmSPu+MC0b2anLybZyN
         c2/vW44wOhfTXH6SKcrxC/Xcb5cWTh0equ1x4Rs0IGRxPC3QtVEEpwMmokOkOw8ALJRK
         klH/MzllIuuySzxIaiqaCHjRwC7o6ooA1bm+hwuPmvhNYrbbp0GLBSNflkJDJ1EbkUkP
         ZJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dVB7ZPJgZD0gpsdinXm4ggMxiYerGmhY62XEYI3Nvq8=;
        b=aGb/SHNuYg54AEU3kr23BGexGxCtyRl9XTjtkUiyzUUsEm0LymZ22FUAP49yVJFuZR
         FYKXIr7fhPHJX+X5Htvf95hL2baRg3ovn7/E22/3EnrzxJLpOIFNMuEVhnzTsW9ycfYO
         lAuK4cXTA6AkRPq/lsr/cqhVeXi9KZDcEaCYAAtWUKJ9JLeE/Zma6no87THDwaV3wyPx
         qbl/nnuxMuJlafzSUNO0qfeyocB/o1kLTzD3LpResObrxFpo/kNWTSLiUPierYztVBps
         8SZWkXHR5l8khxqWD3qVy7mcPpLZnAghFBP1mIIlYQn9wF0e/SGezYihOSYDthCn2tGC
         iZjQ==
X-Gm-Message-State: AOAM533jyMlpi7xgs0uB2pi5oq8nyNJm4FNcnaBAzFyb6yLHA4aNATb7
        Nb3oGiqsGzz286hvcv6cj3CGcxapKtRvGh+ycVC78A==
X-Google-Smtp-Source: ABdhPJx5q2ZQo4k+YcVYi75bqEuxPbjDvIIaQC9E/n5oSuLoAlRW92mjRhtm3o1vU+aF/DAthpqhJ/Ny5hmX7n+FGqA=
X-Received: by 2002:a92:cda6:: with SMTP id g6mr175127ild.274.1612909306850;
 Tue, 09 Feb 2021 14:21:46 -0800 (PST)
MIME-Version: 1.0
References: <20210205235302.2022784-1-dlatypov@google.com> <20210205235302.2022784-2-dlatypov@google.com>
 <alpine.LRH.2.23.451.2102091717001.1783@localhost> <CAGS_qxoRt+yibVgVBoMGp+GpVt9TSKuyyk08vfcSyQeTyAgN+A@mail.gmail.com>
 <alpine.LRH.2.23.451.2102092210150.20236@localhost>
In-Reply-To: <alpine.LRH.2.23.451.2102092210150.20236@localhost>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 9 Feb 2021 14:21:35 -0800
Message-ID: <CAGS_qxqZqn=Qve5C1pcCkhtifLqS+BmSjO=q9AcpJKwJhBN1kA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kunit: support failure from dynamic analysis tools
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Uriel Guajardo <urielguajardo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 9, 2021 at 2:12 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Tue, 9 Feb 2021, Daniel Latypov wrote:
>
> > On Tue, Feb 9, 2021 at 9:26 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > >
> > > On Fri, 5 Feb 2021, Daniel Latypov wrote:
> > >
> > > > From: Uriel Guajardo <urielguajardo@google.com>
> > > >
> > > > Add a kunit_fail_current_test() function to fail the currently running
> > > > test, if any, with an error message.
> > > >
> > > > This is largely intended for dynamic analysis tools like UBSAN and for
> > > > fakes.
> > > > E.g. say I had a fake ops struct for testing and I wanted my `free`
> > > > function to complain if it was called with an invalid argument, or
> > > > caught a double-free. Most return void and have no normal means of
> > > > signalling failure (e.g. super_operations, iommu_ops, etc.).
> > > >
> > > > Key points:
> > > > * Always update current->kunit_test so anyone can use it.
> > > >   * commit 83c4e7a0363b ("KUnit: KASAN Integration") only updated it for
> > > >   CONFIG_KASAN=y
> > > >
> > > > * Create a new header <kunit/test-bug.h> so non-test code doesn't have
> > > > to include all of <kunit/test.h> (e.g. lib/ubsan.c)
> > > >
> > > > * Forward the file and line number to make it easier to track down
> > > > failures
> > > >
> > >
> > > Thanks for doing this!
> > >
> > > > * Declare it as a function for nice __printf() warnings about mismatched
> > > > format strings even when KUnit is not enabled.
> > > >
> > >
> > > One thing I _think_ this assumes is that KUnit is builtin;
> > > don't we need an
> >
> > Ah, you're correct.
> > Also going to rename it to have two _ to match other functions used in
> > macros like __kunit_test_suites_init.
> >
>
> Great! If you're sending out an updated version with these
> changes, feel free to add
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

Oops, there was a race in sending v3 and seeing this in my inbox.

If you could reply to the v3 that'd be great. I've already amended the
commit locally.
Thanks!
