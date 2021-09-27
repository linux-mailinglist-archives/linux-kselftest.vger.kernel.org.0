Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECB54193CD
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Sep 2021 14:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbhI0MEt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Sep 2021 08:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbhI0MEt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Sep 2021 08:04:49 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537CFC061575
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Sep 2021 05:03:11 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id v10so63821609edj.10
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Sep 2021 05:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HgxsgFEJyDrPgvkPyP1u+drogRTW/Ry0SDoI8qAzwZo=;
        b=MuNocPT8FacPIl0EopBHd85thJms4slUrjm4uPzlymPqGD8YDyKfwnVY3SJnreZnlq
         mP+QfsrAYwFZpAURiJ5bX4eFnYZNJ3O/TiRZNURNlYVHyN6TR0ACjd+c2flkpnV/rsmU
         aJq2IOB8vFchay6qK47Nrbe0DqG0pSCszdegHFdt3Ra+LIDnnMKAvMY8oZyAolmVRdaO
         zDEDc5EUTrOghgV0JjyoHJ5js1G/grpuDJzX4pIVFpaX2g+tphSJc0iJr77wz7n53tLI
         xaQxlhYf0hWxNGX1/juvNoS/o4h+xTG1ACPOQ9ogtAfSxObcaLkGGWXmgsVv9vaj3d+n
         LF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HgxsgFEJyDrPgvkPyP1u+drogRTW/Ry0SDoI8qAzwZo=;
        b=aiaRV9+SZJejpDSosvNX7uMqL59tEYtQxi3z4BrCc86HCUWl3A7x5DFOjNviECCNZ2
         EDDJQB5+/z56DwgjwAVcJUPEhW4W4DmWbzuBgpOxE/YBDA6/sJVOxWMALPkbfVh7cuvI
         XseRqzGWybDuxPTFOO9+VohWvtX4Et1WQ9aoKZBLimeoyj7J4rnm1uIMgUma42JcpiF3
         uqiDx46LqHc7wZnyRYaE4NPvuw3znhK3yXZzdkfB35JJf80618ZRq97SqaDJn0+s3i1B
         toLwquRW7CJH02W3/5bgLT9dmZnpaCcY+OonZWGv6DHyJhAPnQOPG4c1zdVLXwjVgEty
         nmXg==
X-Gm-Message-State: AOAM532BCTJ5mdBpry5hyPFXqtFBxdMk1PSNjYfEgCx1ULpjyJFSdArG
        GbFgUckidSrMYOWYTcAfMLDs16BpcCFMziuwfOdlVA==
X-Google-Smtp-Source: ABdhPJzmsFbA0j9GZCj2/1npqP3jxyQTWa14E7dOuuz4XzPn7iCGB9AIe6yLdGfRckAWaTGt2FG/OxeP3bKRPt4igbo=
X-Received: by 2002:a50:e0c8:: with SMTP id j8mr22479077edl.283.1632744189819;
 Mon, 27 Sep 2021 05:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210926223322.848641-1-isabellabdoamaral@usp.br>
 <20210926223322.848641-4-isabellabdoamaral@usp.br> <CANpmjNN4z9YsD=KjGjgdXsQbKD68RGh5bu-AEX6FeryZ2GdXCQ@mail.gmail.com>
In-Reply-To: <CANpmjNN4z9YsD=KjGjgdXsQbKD68RGh5bu-AEX6FeryZ2GdXCQ@mail.gmail.com>
From:   Isabella B do Amaral <isabellabdoamaral@usp.br>
Date:   Mon, 27 Sep 2021 09:02:58 -0300
Message-ID: <CAAniXFQv6r+dmVYc9e-MuJxLqDoyayFLfBZw0FqW3hP7+RQXjg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] test_hash.c: split test_hash_init
To:     Marco Elver <elver@google.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Enzo Ferreira <ferreiraenzoa@gmail.com>,
        =?UTF-8?Q?Augusto_Dur=C3=A3es_Camargo?= 
        <augusto.duraes33@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        ~lkcamp/patches@lists.sr.ht,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Marco,

On Mon, Sep 27, 2021 at 5:17 AM Marco Elver <elver@google.com> wrote:
>
> On Mon, 27 Sept 2021 at 00:33, 'Isabella Basso' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > Split up test_hash_init so that it calls each test more explicitly
> > insofar it is possible without rewriting the entire file. This aims at
> > improving readability.
> >
> > Split tests performed on string_or as they don't interfere with those
> > performed in hash_or. Also separate pr_info calls about skipped tests as
> > they're not part of the tests themselves, but only warn about
> > (un)defined arch-specific hash functions.
> >
> > Changes since v1:
> > - As suggested by David Gow:
> >   1. Rename arch-specific test functions.
> >   2. Remove spare whitespace changes.
> > - As suggested by Marco Elver:
> >   1. Add struct for carrying test variables.
>
> Did the patches get mixed up? The struct doesn't appear to be introduced here.

Yeah, thanks for the heads up! I must have mixed the messages when rebasing.
Sorry about that. The struct was actually introduced in patch 2/5. Do
you want to
have a look at it or should I send the v3 with the correct message before that?

Cheers,
Isabella Basso
