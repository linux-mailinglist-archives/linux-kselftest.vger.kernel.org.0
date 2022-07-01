Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7E8563104
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Jul 2022 12:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbiGAKI5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Jul 2022 06:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiGAKI4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Jul 2022 06:08:56 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EDA2C13C;
        Fri,  1 Jul 2022 03:08:55 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 261A8aYu011451;
        Fri, 1 Jul 2022 19:08:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 261A8aYu011451
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1656670117;
        bh=+AGZqubtv+JE9ARRYLJRXqG6x9IG0KNs7lCiEienC8Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pLZabHSvBltRhJIKJC/Qq8hA/g+Yx6K5p6adHbe6rAsQFelaubCoyNmRwMQ1DrOhH
         F3v9iKlxhTvTmSn0FXPqKXyfHbJl6ik592Zt52qsoqU+wsR9I7cQVCblqZ7XUHnSEu
         ojRcy//DhhpDfS2ExR98VAhbqlxbva3u/TrHe5L23ZO+hKseI2orWQDyT1S4eclxL8
         QcoX5ZwA0OkyYfGPMFa1qxXmx3yUSFN19g0CYkT8Lf1a2NAQXvuSeTp6LaAC9DggeA
         AiM797ML2tP8iDtTYANyTfXUemWrfI0YC4sZ9swbr4j4zaUUhb1jJ7mzMEQc3bQXQ5
         Vi3aadKnpBFvg==
X-Nifty-SrcIP: [209.85.128.50]
Received: by mail-wm1-f50.google.com with SMTP id j7so997760wmp.2;
        Fri, 01 Jul 2022 03:08:37 -0700 (PDT)
X-Gm-Message-State: AJIora94AJLY4R6YXcOHdVxcaKbh07KlJmKhxC+cK0s1hkc1s0tVdolC
        cALXk5bkAWj+4C0Y3XjxTvD7VHvx1UhJY+362gc=
X-Google-Smtp-Source: AGRyM1vB8UA94xyy0xpJ0uekSex+ZkmJLWc1ww9wkLTD36KmzyTLEdEMHZJOYxElxMz1J0vVn2hsmHvg4QAQnYAOYRY=
X-Received: by 2002:a1c:6a06:0:b0:3a0:5099:f849 with SMTP id
 f6-20020a1c6a06000000b003a05099f849mr16431790wmc.14.1656670115702; Fri, 01
 Jul 2022 03:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220627070214.432390-1-usama.anjum@collabora.com>
 <15532d64-6744-c8a5-184b-18358211d345@linuxfoundation.org>
 <CAK7LNARxSFSQgmrZe2CXj+V153kymBVyGkXwOPWLNoybQ8+bfg@mail.gmail.com>
 <04f168f8-0369-f0f6-8eab-9d384aced2c8@linuxfoundation.org> <95a3eb80-645e-a1b9-8373-46b1ad015e96@collabora.com>
In-Reply-To: <95a3eb80-645e-a1b9-8373-46b1ad015e96@collabora.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 1 Jul 2022 19:07:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNARxG2A9us1V7Z+Fjhuu8mJ7kAw6CNH56E+nYymeCvyqSg@mail.gmail.com>
Message-ID: <CAK7LNARxG2A9us1V7Z+Fjhuu8mJ7kAw6CNH56E+nYymeCvyqSg@mail.gmail.com>
Subject: Re: [PATCH v1] kbuild: fix sub directory output build of kselftests
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kieran Bingham <kbingham@kernel.org>, kernel@collabora.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, guillaume.tucker@collabora.co.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 30, 2022 at 6:44 PM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Hi Masahiro,
>
> >>> Please resend cc'ing linux-kselftest
> >>>
> >>> thanks,
> >>> -- Shuah
> >>
> >>
> >> Please do not send this any more.
> >> This part is good as is.
> I'm confused. Have you accepted or rejected the patch?

Sorry for confusion.
Rejected.



>
> >>
> >
> > + linux-kselftest@vger.kernel.org
> >
> > The reason I suggested resending cc'ing linux-kselftest is because
> > this fixes a kselftest problem.
> >
> > I am assuming this patch will go through kbuild
> >
> > Acked-by: Shuah Khan <skhan@linuxfoundation.org>
>
>
> --
> Muhammad Usama Anjum



-- 
Best Regards
Masahiro Yamada
