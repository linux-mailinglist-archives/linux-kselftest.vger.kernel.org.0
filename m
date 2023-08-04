Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108817706E4
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 19:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjHDRPW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 13:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjHDRPV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 13:15:21 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AC2469A;
        Fri,  4 Aug 2023 10:15:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 669F460177;
        Fri,  4 Aug 2023 19:15:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691169317; bh=sb+VS7L5uN94PDJDVY+D3C5Qp9r6bdxatdxyOwcIY78=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=o55LdpicpCEISOuOMZpN2vqwB7CeMEghdBFWb5zaDnAkP9aJegW2OhxJepMZZWpIS
         62g/X+BcRjdhwZiDa2KWNMF93ilGBm/6P2JYGhKDyS6ErpUCJ55iaupK+Sz976E55+
         c63Zv8ueZcRq9ryljItaSjbrbsdzMZEqfwHUgw4gqc2lubt/dshTRafhDycA/mprER
         YFAoZl9SDy0paZXYqCvtBTZtVuCFskG9JKcupeOTo2a+0Y5AxVR1V++cSra7YujoR9
         mLkCxwOg/GN6KlSZr+FGmOWrkg1f5+xXIUDzr2tdllv2AMm+AsgpY32FrPudthv2hO
         +tJe1QLzx0tag==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Bnq7fFXCgYMd; Fri,  4 Aug 2023 19:15:14 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id BFF3E60174;
        Fri,  4 Aug 2023 19:15:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691169314; bh=sb+VS7L5uN94PDJDVY+D3C5Qp9r6bdxatdxyOwcIY78=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L4w1aMKgw7IGC9Vqt1cQGfMyxddvk56MZHTaN0VFrB/rgGFl1ZiQoxyo0ShzNtwRj
         geVdJ6Q/J9D+5TuUXNZizl6t6QX3Om17RhC6esXkeAif+8BgV60T2rx2SW2ZjjwEGB
         F/nyxc42Oeo3poLTy5YLNI2LaZCsxKl4K29mcTsUIK0O+uQOY8MtDBha1AqL0n9se0
         4j2FwSLsS5hbFEjxIbuOsP4WMtKPdvcHdEetYInUZt0HSuj99TbIHfxMzNqQs2Umlm
         8829CHjOgm8rJ746VVBALblQcMqtoMV1LXFmJfQJ72Xe3i5DxYROn/yJR0Q3pIMdvk
         Jvt/PcNuBpcQw==
Message-ID: <a2a844d0-0d2c-c74b-e2d3-d924a9dc1e00@alu.unizg.hr>
Date:   Fri, 4 Aug 2023 19:15:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/2] [DONE REQ CHG] test_firmware: prevent race
 conditions by a correct implementation of locking
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Tianfei Zhang <tianfei.zhang@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>
References: <20230803165304.9200-1-mirsad.todorovac@alu.unizg.hr>
 <2023080435-unweave-suspect-3299@gregkh>
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <2023080435-unweave-suspect-3299@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Mr. Greg,

On 8/4/23 13:22, Greg Kroah-Hartman wrote:
> On Thu, Aug 03, 2023 at 06:53:04PM +0200, Mirsad Todorovac wrote:
>> [ Upstream commit 4acfe3dfde685a5a9eaec5555351918e2d7266a1 ]
> 
> <snip>
> 
> Ok, I am totally confused as to what patch is the newest one, and which
> is for what branches, sorry.
> 
> So, I've deleted all of the patches from my review queue and I would ask
> that you start over.
> 
> Note, if you put the kernel version in the subject line, it makes it
> simpler for me to understand what goes where.
> 
> Here is an example to follow:
> 	https://lore.kernel.org/r/20230802170227.1590187-1-eahariha@linux.microsoft.com
> 
> There are loads of other examples on the stable mailing list, please
> don't make it hard for me to understand what to do here, make it obvious
> as I'm dealing with hundreds of patches a day.

Done requested changes and resubmitted. I hope it is done right this time. Of course,
it could be better still, but this should work out.

It is a paramount that we make your life with applying patches easier and this is
a new situation that I haven't got covered yet.

I will also try to imitate the skilled patch submitters the next time before wasting
your time or reinventing the wheel.

> thanks,

You're welcome.

Kind regards,
Mirsad
