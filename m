Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE602656B5F
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 14:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiL0Ngw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Dec 2022 08:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiL0Ngs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Dec 2022 08:36:48 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9021FB7C5;
        Tue, 27 Dec 2022 05:36:47 -0800 (PST)
Received: from [10.7.7.5] (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id 016557E2BA;
        Tue, 27 Dec 2022 13:36:43 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1672148207;
        bh=EAmnj0RlIG0MGwi3OSqM2CbWUp31upcL4Rr7mE3BEzk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m3vFWGgFos4CVm/6DKMfvLRN3lO3Hf8erFN7TuCBwpYdoRs5SfWZcewOZyO2yKniC
         PhHPT0lNHM20h0JbVMUIz5AgtdblS2c/vDzoQcqw7sy3p1kBoMd/53NX+Z9S4weeul
         WKhSisQDra81GMtPICtyInDEtD2enrqqqrhr48cbccPliJOU5u1veaQ+ffJm1B1zvm
         jWk+ckJjVJgeG95ZIVAcdGqMAPg6sb9i6Vgb2m9/b/XxNZpYXl5R2M5hqpM9+fPTH1
         7Ex289a63N1CVaG/s9F8wMDiRCuN9TPxoiATEeyktBNqg/PoJxHI4ze8Lnrpa5dXCM
         54+J+p+MRtnRw==
Message-ID: <d206f87d-2107-7cdb-ee2a-7fe718f06f3d@gnuweeb.org>
Date:   Tue, 27 Dec 2022 20:36:41 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH v1 0/8] nolibc signal handling support
Content-Language: en-US
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
 <00eee75f-59fa-83b2-c7e1-f0da347b2dde@gnuweeb.org>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <00eee75f-59fa-83b2-c7e1-f0da347b2dde@gnuweeb.org>
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

On 12/27/22 8:32 PM, Ammar Faizi wrote:
>> Thus now my focus will be on storing these variables where relevant
>> for all archs, so that your getauxval() implementation works on top
>> of it. It will be much cleaner and will also improve programs' ease
>> of implementation and reliability.
> 
> Are you going to wire up a patchset for it?
> 
> If so, I'll wait for it. When it's already committed, I'll base this
> series on top it.
> 
> Or I take your series locally then submit your patches and mine in a
> single series.
> 
> What do you prefer?

Side note:
I only know x86 Assembly. So unfortunately, I can't get them working
on all arch(s).

-- 
Ammar Faizi

