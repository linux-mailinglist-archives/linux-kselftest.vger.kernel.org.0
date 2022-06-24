Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58295559E63
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jun 2022 18:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiFXQN2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jun 2022 12:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiFXQN0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jun 2022 12:13:26 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E272933E33
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jun 2022 09:13:21 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eq6so4148410edb.6
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jun 2022 09:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vwqux9HBY2fym7y4v9sHiA/8CttUFnIIaCazdcNKSY4=;
        b=s2y9G3CoATFd63g+bc+p0PBExbmQzhhXtpMJSMqLFmAc+8H+VoxN5ZKfLuVWyyaPks
         OvOaBeatWiR/9Btp6HtadPnrZtBj7KS4q98+SNz728ys5bYfJNJ7nIAW6BPGr7/iNVE0
         DdnEMMfOXqQ8JNKyj7MbIZVacdpXmAHBU275tK2969RwMOglJ6TeDpyJbrfPlFcEAl6Y
         C1Jf4CC5F5DZpKC8VAGTvd94SI29XyU48BQ/J9eergk2efSTCip6jL06w3BkoYE3glmG
         U/X3QyE7mBJf1MS9neexQl0XWhz0S7Q4hOl36Ty4Dp608U+P3dRIa0ANTG9u060xzZjJ
         hdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vwqux9HBY2fym7y4v9sHiA/8CttUFnIIaCazdcNKSY4=;
        b=QyhTssrCQrlMM8Du6DvtQKpq0ie0op6UXxW0pLK+siDme3PEz8GUaR0ea9qV2QywR5
         7r2zzsIsbCu9k8GegXNNt6pQG/w7o+er2hcoSOM6ZGZ5HMX+vu8ItoDlyuh8AAqrbxxz
         /ScjTvdbh62H2myzzAT77yZMr9XZ0OrPeKSZi89hiDcgsYrOUHZNOR+3izkJNMjG1/L8
         rVbxD3pVVr2Soi+bOO8Pi16vE6hNzRQXrVqGYl4ewRjV9Q2LvihBjXDtXk/jVY7r2QNB
         NA0FvTqxBhae9q6jke/f+dcVsCfO4XIW410pZ/p13EWoQJOEbyld4gLI96VYdBovqJ2V
         jKEQ==
X-Gm-Message-State: AJIora/JHF37FWC6Y0D5icd3rkHfv6r231oDQoo4ffqs+8WjMvaRpoj0
        xYavA+2uEnh1LIb76Bjf7wYnWevxxmMMYe0RrFRP6Q==
X-Google-Smtp-Source: AGRyM1uV6NHyxTZWKaaslYXdWbIZhZ7BBf4w2rJnFFADVORjRnFIu7EQuWGLVSMMSFWGrQyBZxXtzGXyM12H2Sp5UWg=
X-Received: by 2002:a05:6402:5188:b0:437:618c:c124 with SMTP id
 q8-20020a056402518800b00437618cc124mr3067044edd.233.1656087200237; Fri, 24
 Jun 2022 09:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220624001247.3255978-1-dlatypov@google.com> <20220624001247.3255978-2-dlatypov@google.com>
 <CABVgOSn_v8p2nRaioz2MK0FEV6UmzfHHFipiqy05d54y73XFzQ@mail.gmail.com> <6e46976d-bcf3-e7fd-cd30-bc25c67c5518@usp.br>
In-Reply-To: <6e46976d-bcf3-e7fd-cd30-bc25c67c5518@usp.br>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 24 Jun 2022 09:13:08 -0700
Message-ID: <CAGS_qxodP-3=mcL4pcG=BSremBZiDeT1YdCRDPP4oVWVEZ=pEg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: add coverage_uml.config to enable GCOV on UML
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 24, 2022 at 7:12 AM Ma=C3=ADra Canal <maira.canal@usp.br> wrote=
:
>
> On 6/24/22 04:55, 'David Gow' via KUnit Development wrote:
> > On Fri, Jun 24, 2022 at 8:12 AM 'Daniel Latypov' via KUnit Development
> > <kunit-dev@googlegroups.com> wrote:
> >>
> >> Now that kunit.py's --kunitconfig is repeatable, let's create a file t=
o
> >> hold the various options needed to enable coverage under UML.
> >>
> >> This can be used like so:
> >> $ ./tools/testing/kunit/kunit.py run \
> >>    --kunitconfig=3Dtools/testing/kunit/configs/all_tests_uml.config \
> >>    --kunitconfig=3Dtools/testing/kunit/configs/coverage_uml.config \
> >>    --make_options=3DCC=3D/usr/bin/gcc-6
> >>
> >> which on my system is enough to get coverage working [1].
> >>
>
> It's great to see this coming to KUnit! As I was testing this series, I
> wasn't able to generate the coverage stats with GCC11. I got a linking
> error from ld:
>
> ERROR:root:/usr/bin/ld:
> /usr/lib/gcc/x86_64-redhat-linux/11/libgcov.a(_gcov.o): in function
> `mangle_path':
> (.text+0x19f0): multiple definition of `mangle_path';
> fs/seq_file.o:/home/mairacanal/linux/.kunit/../fs/seq_file.c:441: first
> defined here
> collect2: error: ld returned 1 exit status
>
> By changing the name of the function to `seq_mangle_path`, it is
> possible to solve the linking error and run the tests. But, anyway, no
> .gcda files are generated.
>
> I checked out, and this is a known issue that was already discussed in
> this series [1] (but I guess it didn't move on).

There's the two main issues I knew about and that you noted.
* no gcda files produced (gcc 7+)
* seq_mangle_path (I don't remember, gcc 8 or 9+?)

The latter can be worked around locally fairly easily, as you also found.
The former is due to how the exit handlers work, iirc.

I didn't know about [1], but it also mentions the exit handlers issue.
However, from the sounds of [2], it seems like it might be a dead end for n=
ow :\
So I wouldn't hold onto hope of using modern GCC versions with this.

[2] https://lore.kernel.org/all/d36ea54d8c0a8dd706826ba844a6f27691f45d55.ca=
mel@sipsolutions.net/

Daniel
