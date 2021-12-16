Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414A24769D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Dec 2021 06:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbhLPFoU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 00:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbhLPFoI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 00:44:08 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51811C061747
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Dec 2021 21:44:07 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id a14so45279882uak.0
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Dec 2021 21:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x007l9CmyG5Mhhl6awj68hvF5+xlJ18gJv8C9c3RB/s=;
        b=UolJxkM+o0a/L8Ra7hSn1Ky4oY3Pka/VGcJlZdk/d4vFLX56xk+7lp61iVZ6B0j87D
         C7MkG3zg7SRMOC3y4bNwSrgoKKdTYbB/UlBqoc+CdPTDcP4w+vz+Xj/zyefXgeIzwVNf
         vr8PUqIOCoJk136IgPGjS93vbKOASExiSmFP1jd6MYz66I3+kbuh5buyl4/bvZdnXViI
         Mbpw+AoYUJoqBhIckf9koLlW8P/oWXKIDUXKxSIJB7vFeSgkrELwUK3SlJ7vwQ3QCYVz
         eYNFamX9ptAqG3w2xNUJTxXUqUjJDrUMqPsOmwiQjdwiwCpJ7aAXKJ0XACVmiu1jFb6F
         2o5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x007l9CmyG5Mhhl6awj68hvF5+xlJ18gJv8C9c3RB/s=;
        b=YM8y8rIKaWhPsBKRRomWkSawZY7I/Y5S4gXunf3tJeVfjFHnuiCVQ5iftPun4ewvSB
         ecaCXLhL/j2GhJqrDMP/s4aUSJ9B5Dl/rqYuycby8W/rUvLwRdBwlgV9a7BpzS2M+pGt
         gH6vuI1aZXEVxevZ1anHS8qcKLlyRzQ9M2BuZS5nKwAIJybqpLFOLyZI7RqtF6KOpuXY
         6BXA/IK4PBw57YKPKc57cJmE6pklhaIRJJbB2gRbgV3xsDOWeb+0mfJC3449yyyjoopN
         xnO38qGK5kiypac1pjvLZ+IK2YXzY0QuocpBAETKOZ2IWTDEiNK9y04e6wHfrrwNmNZZ
         xD9A==
X-Gm-Message-State: AOAM53068YLQMt/QXMluhriEzV7rloFzSBbbVsUuR/gWJoyMF3c3/ah5
        pwOW7kBG69aeG8KVbyfxCTacvwqOrI98Ryt7brjdcQ==
X-Google-Smtp-Source: ABdhPJy0wqUiatEFEWteWm06fAmno9O7xiq6EHaGvlkmy6QCOhcwxFFBS2wM3t99xh/uKjIGIG5bKPtMnvnEZtpAXFk=
X-Received: by 2002:a05:6102:a4a:: with SMTP id i10mr4847667vss.47.1639633446329;
 Wed, 15 Dec 2021 21:44:06 -0800 (PST)
MIME-Version: 1.0
References: <20211207054019.1455054-1-sharinder@google.com>
 <20211207054019.1455054-6-sharinder@google.com> <BYAPR13MB2503EB20A1A804BEA0D08508FD6E9@BYAPR13MB2503.namprd13.prod.outlook.com>
 <CAHLZCaHWK_oUbnFMeZ7yeCg1XtwTzb1qYNtG8qgi_dOm4ZNafQ@mail.gmail.com> <BYAPR13MB250382B305D19D310AE45916FD719@BYAPR13MB2503.namprd13.prod.outlook.com>
In-Reply-To: <BYAPR13MB250382B305D19D310AE45916FD719@BYAPR13MB2503.namprd13.prod.outlook.com>
From:   Harinder Singh <sharinder@google.com>
Date:   Thu, 16 Dec 2021 11:13:55 +0530
Message-ID: <CAHLZCaGTercyt_GOFuqjT_OmZRDhA3FGReGTf7e1vVTr1VszkQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] Documentation: KUnit: Rework writing page to focus
 on writing tests
To:     Tim.Bird@sony.com
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org,
        corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Tim,

On Fri, Dec 10, 2021 at 10:46 PM <Tim.Bird@sony.com> wrote:
>
> Thanks for responding to my review.  I reviewed the remaining patches (v3 patches 6 and 7)
> and found no issues.
>
Do you want me add your name as reviewed by you for patches 6 and 7?
>  -- Tim
>
> > -----Original Message-----
> > From: Harinder Singh <sharinder@google.com>
> >
> > Hello Tim,
> >
> > Thanks for providing review comments.
> >
> > Please see my comments below.
> ...
>
Thanks,
Harinder Singh
