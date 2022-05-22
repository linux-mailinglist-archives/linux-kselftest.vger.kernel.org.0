Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38395304E6
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 May 2022 19:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243247AbiEVRQX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 22 May 2022 13:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbiEVRQU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 22 May 2022 13:16:20 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED5013E00;
        Sun, 22 May 2022 10:16:16 -0700 (PDT)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 24MHFw3s024765;
        Mon, 23 May 2022 02:15:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 24MHFw3s024765
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653239758;
        bh=iJUQ11zdibvEKML1MoaBG63neGvxnn+10KFJyibTf7w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B4fFu8cukgve1ap2HSFu/zK9ZKa0IO6x2O3sFN4Xgne3SmGdYp/Cwn2J0KN2Fr2+v
         vswDVXXi+gfrSowdrbrW7fm4vq+q0edVZukOWju5bHFui1E5pE5JS+J/PquoG8Mshl
         bfqJ8TBLiT5LsCkN4U5b6kmKrwGpGorXoKP901TjdzieEafo/QvNESyitHxe7Nmrqu
         TaOsWdmXOXI/FQQVBSlTH5TZ5DHuqZ2hlVpXgBcK7AQpPlTqeUBneRrAYfErbDekKU
         JWGJIrIf2JGcwrb1cdzuLmQxpNmxJcQ8POo8oZwK8aYS9KHzP9MRs/aagXoJuF40pH
         3BGPj6hkEZhhg==
X-Nifty-SrcIP: [209.85.216.50]
Received: by mail-pj1-f50.google.com with SMTP id oe17-20020a17090b395100b001df77d29587so15534658pjb.2;
        Sun, 22 May 2022 10:15:58 -0700 (PDT)
X-Gm-Message-State: AOAM533DRXsn1szpLeIOX1rUsa4ARzt4ZVPuFEIG+QKSkNKLaeG7lvoA
        h3MzyoNt6fFb/recYhEgHiBRcrgkMp+LFsKCBFE=
X-Google-Smtp-Source: ABdhPJyykpXi7s5uskolfZaSKiw35bTUvst8h7wiyAxDIQaxc0v050U9CgKdvdYtN8pvyfJgabdVf0hLsDvSHfbVMIs=
X-Received: by 2002:a17:90b:1e50:b0:1e0:3a08:9b12 with SMTP id
 pi16-20020a17090b1e5000b001e03a089b12mr4350049pjb.119.1653239757627; Sun, 22
 May 2022 10:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <c25d7ea7-4f72-4a2b-d8c3-d317e64fcbbb@collabora.com>
In-Reply-To: <c25d7ea7-4f72-4a2b-d8c3-d317e64fcbbb@collabora.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 23 May 2022 02:15:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNATL4nMmKgrjS8meavnpn=HisD30QxuPUKDqtWWgbGcSZw@mail.gmail.com>
Message-ID: <CAK7LNATL4nMmKgrjS8meavnpn=HisD30QxuPUKDqtWWgbGcSZw@mail.gmail.com>
Subject: Re: [Bug Report] - kselftest build fails if output directory is first
 level sub-directory
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        KERNEL SELFTEST FRAMEWORK <linux-kselftest@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernelci@groups.io" <kernelci@groups.io>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 21, 2022 at 3:44 PM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Hello,
>
> kselftest can be built using the kernel's top most Makefile without
> using kselftest's Makefile directly. But there is bug in the top most
> Makefile. The build fails if the specified output directory is first
> level sub-directory. Here is a example to reproduce this bug:
>
> make kselftest-all O=build
>
> "The Make is working in a wrong directory, that is why the relative path
> does not work." Masahiro Yamada. Feel free to fix it if someone pin the bug.
>
> It should be noted that the build works in some other combinations:
> make kselftest-all (works)
> make kselftest-all O=/tmp (works)
> make kselftest-all O=build/build2 (works)
>
> My unsuccessful attempt to fix this bug can be found here:
> https://lore.kernel.org/lkml/20220223191016.1658728-1-usama.anjum@collabora.com/
>
> Thanks,
> Muhammad Usama Anjum


This problem starts from the bad design of the kselftest framework.
I did some research before. I think I can fix the root cause but
currently I do not have enough time to do it.


KBUILD_ABS_SRCTREE is a user-interface to request
Kbuild to use the absolute path.
If it is forced in the top Makefile, users have no way to
negate it.
It is true that using the absolute path is a quick work-around
because you do not need to care about the current working directory.

If you insist on it,  just go ahead.  It is just two line changes.
Once the issue is fixed in a better way, your patch can be reverted easily.



-- 
Best Regards
Masahiro Yamada
