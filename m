Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B376BDB63
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 23:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjCPWLC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 18:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjCPWLB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 18:11:01 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A67D12869
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 15:10:27 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id d22so1836201pgw.2
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Mar 2023 15:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679004623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awbcQ87AXFDefB7HelHBqjVLmziuHb7OEm7wX7LNPNQ=;
        b=Sc8qv9CaVm0iTuuZOE76d3hvdFSVNuJS39gCLhGLVOJevMkc65H8RNQyX4g+Hn0qKQ
         b8PjiKZA5Cd+BpfwX8UFZ1CqWHMYcf9CaJNtj+XnWYKIcILQMkdZOl6bz/g1Bl8KBQH9
         TAexzBe+//YzxxXzCbHIQh1Sxj8jHwmEohfHXYdVYWlEpFIFup6C4owMQHPGHlCYsiEC
         3cbIxSmYHjM8BEozhWzkMbepHepwlYt6aQGP2kiXXPDI4acFLu7ARRBIJndYXCeNotZ1
         mZFxZEAmH1zJGkk/8mZppgBhVyXwXKupD0+MggrP8NXnIyiNZ2SYuQvI1NwKKChp0NlK
         pgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679004623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awbcQ87AXFDefB7HelHBqjVLmziuHb7OEm7wX7LNPNQ=;
        b=N66PQvOSbD3cLARrEmKpQnYzmaVyNqdVRTfOh0fBdKXPYlfIXQgQGSHP0WIDWwxV/1
         8jhg3/Ow71PVu4okULJ103xAm70eJEaNiuLX5KFD/CCryqJkH0q/fpha2Ga3dzawmUL4
         rRwq8kaJKvLXEnm7QnhFG3xUSVNSCEU1j0MhfvenIttYfTi3xmIWAmUgyKjPjgZyXHUq
         /kcuwSmEq09TRcde/aBFOW0q3B/vtqUKZRg+mK9uvIK4j6h1BEzMctZm4aZJo5hIGrW8
         qmFoakBPx/V+WNEds049AJ7gQ4WAWHNQ91GSp45Bb2jVd9qOECja1i7wGNHiKd//tabA
         yqQA==
X-Gm-Message-State: AO0yUKXggRkDhiGN99rsrQc4vBNd47JtbhDD8YW2RX4OwvU4RM1T/tTZ
        JpBXrf/4npVas29ZDy6OXUh/GkrCvUdVogPNPLK9UNhsBnHkuhw3xJ4ymILw
X-Google-Smtp-Source: AK7set+HB++rWBMouXE51lZprMRmTgUZGY/lZWIXNdWX3Y3sdY6Oo76vx3UzTYi6D5U3nxwY6PyT84TqOJO+N2fQtbU=
X-Received: by 2002:a65:4784:0:b0:4fb:1f2a:e6c6 with SMTP id
 e4-20020a654784000000b004fb1f2ae6c6mr1371386pgs.2.1679004623330; Thu, 16 Mar
 2023 15:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230315105055.9b2be0153625.I7a2cb99b95dff216c0feed4604255275e0b156a7@changeid>
 <CAGS_qxrJ53EyQaf5WqfSBYhOF0+LvWgvKL4gExu9vCPxRb7ipw@mail.gmail.com>
 <e028d27b3e998eaba2d71b6e224eb707015f8edf.camel@sipsolutions.net>
 <CAGS_qxpYEnzWM=nPXDAbebuQERN4ijb0FKFbtmX5hK9qwVn12A@mail.gmail.com>
 <9a172b50457f4074af41fe1dc8e55dcaf4795d7e.camel@sipsolutions.net>
 <CAGS_qxoEOW+FN33czFOhJ7xgPeKjGsj=BMc4iF-aP53TfyiyEQ@mail.gmail.com>
 <e4d5d03d37335e7e9ceb0333749a7fac1545f7e6.camel@sipsolutions.net> <CAGS_qxqQd5t1gB4PZCBBYBG2fy8977i5_CcA2aCTyp7x4DKUvw@mail.gmail.com>
In-Reply-To: <CAGS_qxqQd5t1gB4PZCBBYBG2fy8977i5_CcA2aCTyp7x4DKUvw@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 16 Mar 2023 15:10:12 -0700
Message-ID: <CAGS_qxoOc0+cbA1cOKPGriF6x0Mb7GJWcPMkmzj=NQOFGfKvMA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: fix type annotation for IO
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Mar 16, 2023 at 2:30=E2=80=AFPM Daniel Latypov <dlatypov@google.com=
> wrote:
> > I do find the whole type-checking, if occasionally a bit painful, to be
> > of benefit though, at least for larger code bases (and by larger I thin=
k
> > I probably would say "more than a single file that you can keep in your
> > head entirely" :-)
>
> 100% agree, just the concern is about trying to keep two different
> checkers happy when they might have conflicting demands.
> Pytype has been able to catch some relatively subtle errors, so I've
> prioritized it.

Actually, I've gotten both pytype and `mypy --strict` happy now:
https://lore.kernel.org/linux-kselftest/20230316220638.983743-3-dlatypov@go=
ogle.com/

That patch also updates kunit/run_checks.py so hopefully we can keep
`mypy --strict` happy going forward too.

Here's to safer python,
Daniel
