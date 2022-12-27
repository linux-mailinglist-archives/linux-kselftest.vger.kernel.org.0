Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A4A656B5A
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 14:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiL0NdF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Dec 2022 08:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiL0NdE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Dec 2022 08:33:04 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0576DB1D6;
        Tue, 27 Dec 2022 05:33:03 -0800 (PST)
Received: from [10.7.7.5] (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id E95E37E2BA;
        Tue, 27 Dec 2022 13:32:59 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1672147983;
        bh=i77DIBl5pA2lkekeQ2mmSNW2g6Fu6p88wv+enkBT8hE=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=ZJ9DyL6bvMg8msWUpK4TCfW2D4cIYzCMfRUIMsX/ZkxiXK1ZqLIWoWXmT4F8jbWll
         tz00VjQyscF2J1yhFPY5qH0P5yK5Vfxjf2a19id7bUkaOszrGMahimYM80SKcjxdpj
         edd7+S8AiCB2qrwY8s62RoXWepaMts709vINjUhtjzXCPF5R052ue2yu5m2aLq+siv
         H2cJqhcazkY1yxdX7MQVAR3/QTFT4glQvo25e5uaPv/CvvRToXzDAyWWX+2ki6XF0E
         vLaChiUrF3J0ujWrmY0b4iLdL+8IHOEO3y9uqkjWfjB6tPES/Stg2nX83FiuTwooXa
         JYk+uogr9pLHQ==
Message-ID: <00eee75f-59fa-83b2-c7e1-f0da347b2dde@gnuweeb.org>
Date:   Tue, 27 Dec 2022 20:32:57 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
To:     Willy Tarreau <w@1wt.eu>
Cc:     Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        VNLX Kernel Department <kernel@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Kanna Scarlet <knscarlet@gnuweeb.org>,
        Muhammad Rizki <kiizuha@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
References: <20221222035134.3467659-1-ammar.faizi@intel.com>
 <20221222043452.GB29086@1wt.eu>
 <20221222134615.3535422-1-ammar.faizi@intel.com>
 <20221227062640.GA5337@1wt.eu>
Content-Language: en-US
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [RFC PATCH v1 0/8] nolibc signal handling support
In-Reply-To: <20221227062640.GA5337@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/27/22 1:26 PM, Willy Tarreau wrote:
> Yes, and quite frankly I prefer to make that the least complicated.
> Doing just a simple loop in the _start code is trivial. The main
> concern was to store the data. Till now we had an optional .bss
> section, we didn't save environ and errno was optional. But let's
> be honest, while it does allow for writing the smallest programs,
> most programs will have at least one global variable and will get
> this section anyway, so we don't save anything in practice. This
> concern used to be valid when I was making tiny executables when
> running on floppies where each byte mattered, but now that's pointless.
> 
> Thus what I'm proposing is to switch to weak symbol definitions for
> errno, environ, and auxv. I did a quick test to make sure that the same
> symbol was properly used when accessed from two units and that's OK, I'm
> seeing the same instance for all of them (which is better than the current
> situation where errno is static, hence per-unit).

Looks good to me.

> Thus now my focus will be on storing these variables where relevant
> for all archs, so that your getauxval() implementation works on top
> of it. It will be much cleaner and will also improve programs' ease
> of implementation and reliability.

Are you going to wire up a patchset for it?

If so, I'll wait for it. When it's already committed, I'll base this
series on top it.

Or I take your series locally then submit your patches and mine in a
single series.

What do you prefer?

-- 
Ammar Faizi

