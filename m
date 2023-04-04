Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CE26D57A7
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Apr 2023 06:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjDDEnq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Apr 2023 00:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjDDEnp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Apr 2023 00:43:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33837E71
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Apr 2023 21:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:To:From:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=y+45/tR1xUIW+NW2xOJXo2/WIZVObQZACpkC9+9EWgo=; b=SsIrHjTHTHD8jnh/Rjtj4yeLbq
        mKB6KgstsEZRGMzKxfuEl+0MF2PP3GeVu3PBgwAnP/4wqCrfk4t6Vt7iaI5QBF8HpzeJd2XV123rB
        rHxigNi1ktOS6dnfmwkll8HCMMBZC6ZOqYpRyg5sbS14VnqgmnuPyRk/Lcl7dWSXyTIfjowkqolR6
        eRssTOAgO/y1pu09R6ZVw/db5J+JrkPA66+z5IHKm42wlw+o4+4MWeS0pQ/76IU3BiIzJtoeryXNX
        t/9m0vLdlQJBUtI/Zfuf9RVQPZhlk8EcvSoQslAkQQ4G1mEhAtuj6gTFO9bgL1ksjQICVpuoB35eo
        +u6qUuWA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjYWB-0002Il-1l;
        Tue, 04 Apr 2023 04:43:39 +0000
Message-ID: <1c880cd5-b3f1-46b9-fc66-f7743e068c7a@infradead.org>
Date:   Mon, 3 Apr 2023 21:43:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Kernel panic, CONFIG_FIPS_SIGNATURE_SELFTEST, missing dependency
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     "Kernel.org Bugbot" <bugbot@kernel.org>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, bugs@lists.linux.dev,
        skhan@linuxfoundation.org
References: <20230403-b217293c0-1e5391e4b7f5@bugzilla.kernel.org>
 <20230403-b217293c2-4b94a5e6478a@bugzilla.kernel.org>
 <1d7e238b-7e8f-9ce0-1ecb-68e2b80b6d92@infradead.org>
In-Reply-To: <1d7e238b-7e8f-9ce0-1ecb-68e2b80b6d92@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi again,

On 4/3/23 13:19, Randy Dunlap wrote:
> 
> 
> On 4/3/23 13:04, Kernel.org Bugbot wrote:
>> o6irnndpcv7 writes via Kernel.org Bugzilla:
>>
>> Hi Randy!
>>
>> (In reply to Bugbot from comment #1)
>>> Randy Dunlap <rdunlap@infradead.org> writes:
>>>
>>> Please tell us what the kernel panic message is.
>>>
>>
>> There is no message. I'm sorry.
>> I just get a black screen.
>>
>> I'm using EFI to boot my machine. And I can get some output if I enable 'earlycon=efifb' via CMDLINE. 
>>
>> The output stops at:
>> Console: colour dummy device 80x25
>> printk: console [tty0] enabled
>> printk: bootconsole [efifb0] disabled
>>
>> At this point the machine freezes. No error message.
>>

I can reproduce this or at least something very similar to it, but it
doesn't matter if FIPS_SIGNATURE_SELFTEST is set or not.


>> And when I set:
>> CONFIG_PANIC_ON_OOPS=y
>> CONFIG_PANIC_ON_OOPS_VALUE=1
>> CONFIG_PANIC_TIMEOUT=-1
>>
>> That gives me a reboot loop.
>>
>>>
>>> Have you tested this on a mainline kernel, without gentoo patches?
>>>
>>> Does gentoo add any patches in this area?
>>>
>>
>> Unfortunately I don't know if Gentoo is adding any patches that may affect this.
>>
>> But I can confirm that the problem persists while using vanilla-sources for kernel 6.2.9.
> 
> Please put your kernel .config file on the bugzilla entry.

I'll test with your .config file...

> What makes you think that this is related to FIPS_SIGNATURE_SELFTEST?

and still that question...

-- 
~Randy
