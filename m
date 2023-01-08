Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B049666157C
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 14:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjAHN2u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Jan 2023 08:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAHN2r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Jan 2023 08:28:47 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FE695A0;
        Sun,  8 Jan 2023 05:28:46 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        by gnuweeb.org (Postfix) with ESMTPSA id 4E5847E6A7;
        Sun,  8 Jan 2023 13:28:46 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673184526;
        bh=NUhEKHbp1ZSg/5fryL3c7xwNAI0jtUPQT2k1XEQd/Ow=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jRQeImF7G52uBDI6EBQxcph4XwppajYWCL0OVszoQzSQNANnfYN1U7dDizj+oe0UA
         2ZsLN4IzbDudRd6BekI8X/7Xm1St0WkY5yQB7jsP8Ov7yYMDhzdP7fwnKls/S9Kids
         9VHPbe3ktgAYfjKcxW7xrIeQJfGoMFsfo0aXI42/5xFQiQ2XOwZhAD8LdaRQdzvW7S
         A9ksuw17yUjrkNTEyOJMlwkbIJ6m9ihxv93P+pE9PF/wqYQPI3zZzFq4rs7//olrNQ
         pHvI8EJBjtFP2HHgEAKLsIOOf/b7rmveu7ttgPii2zhsD2+KG198Yzo1uZ7actTUun
         8zUJBfSIeW90w==
Received: by mail-lj1-f173.google.com with SMTP id s25so6226259lji.2;
        Sun, 08 Jan 2023 05:28:46 -0800 (PST)
X-Gm-Message-State: AFqh2kpfh7HSqIKUxYV2smRwfB34YKtnn6jLvhvxHDma5Umk1FClUgjP
        q2GwF2V5I/KEffxtaS4/puD6c65f4oO/US5YJs0=
X-Google-Smtp-Source: AMrXdXs+JI4nsTk7zkZANfoD3G5UAZL6VfW/tgox6fAFDBV5NDpcL22QPXCFxLOpyaQJdSxPOnzdMgL4yEYU4tIzHhk=
X-Received: by 2002:a05:651c:1a2c:b0:281:17dd:4b05 with SMTP id
 by44-20020a05651c1a2c00b0028117dd4b05mr727812ljb.394.1673184524403; Sun, 08
 Jan 2023 05:28:44 -0800 (PST)
MIME-Version: 1.0
References: <20221222035134.3467659-1-ammar.faizi@intel.com>
 <20221222043452.GB29086@1wt.eu> <20221222134615.3535422-1-ammar.faizi@intel.com>
 <20221227062640.GA5337@1wt.eu> <00eee75f-59fa-83b2-c7e1-f0da347b2dde@gnuweeb.org>
 <20221227184902.GA6287@1wt.eu> <23e84c59-4f2c-01b4-5b8a-80af39a1d761@gnuweeb.org>
 <20221228133513.GA7457@1wt.eu> <39d68044-2641-75da-929a-f5e852f0a3d0@gnuweeb.org>
 <CAOG64qOT6wa+ShCuV3wM0QYy6TBOYap8xoAbUBU5DM_bhdafYg@mail.gmail.com>
 <20230103035427.GA4474@1wt.eu> <086ff43d-2647-0459-d993-6fc90d7ae779@gnuweeb.org>
 <20230108131038.841204-1-ammar.faizi@intel.com>
In-Reply-To: <20230108131038.841204-1-ammar.faizi@intel.com>
From:   Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Date:   Sun, 8 Jan 2023 20:28:33 +0700
X-Gmail-Original-Message-ID: <CAOG64qOZ7tw_HQjpu9S4ORpW2oVgFd5gK2YyvmA3AswSMsnO9Q@mail.gmail.com>
Message-ID: <CAOG64qOZ7tw_HQjpu9S4ORpW2oVgFd5gK2YyvmA3AswSMsnO9Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] nolibc signal handling support
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jan 8, 2023 at 8:10 PM Ammar Faizi wrote:
> 3)  More selftests.
>
>     This series also adds selftests for:
>       - fork(2)
>       - sigaction(2)
>       - signal(2)
[...]
> Ammar Faizi (4):
>   nolibc/sys: Implement `sigaction(2)` function
>   nolibc/sys: Implement `signal(2)` function
>   selftests/nolibc: Add `fork(2)` selftest
>   selftests/nolibc: Add `sigaction(2)` selftest

The signal() self test is missing?
btw, it's too crowded here, let's create a new thread for this if you
ever send another version
