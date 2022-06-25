Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4834C55AB3A
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jun 2022 17:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiFYPMH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Jun 2022 11:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbiFYPMG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Jun 2022 11:12:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77A613EA6;
        Sat, 25 Jun 2022 08:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=dKTkwKojcLQzO4HZicW5lV577VlQCVPv8wgQNnjwa2A=; b=UeTQSq521AV81Bphy5XLseEV/S
        au3XmyaHmrSDSIcqBAB9k/VajVy3z12inr3Hs+20Z++0uKGvRH7dpnbg3d0E/oXzAnyvL7CaTwF5C
        9JXf8hk8mmJRiB2q7iWWMo/CXbEkVAT0IJee3MntbrOhHnTN4u5z4EHzjVcrsNcBTXSEGaHavK5C9
        d6R74bzIyG0APru5yLJnTkJLmgQgRliRwSsoDZvI8EtA85zrMizNkNmHV3HnLgkos92wxSRREtgoX
        4qv8phY72ve9CD4euWtfoaYdzMGQh52z0ZUZhfbqVMeGMbymTLq07TqlPCDcIrGPKPsdngymJoy11
        +2xrRa2g==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o57S6-006UD6-8t; Sat, 25 Jun 2022 15:12:02 +0000
Message-ID: <4c403239-3c71-4ab9-2168-f7e9d77008b2@infradead.org>
Date:   Sat, 25 Jun 2022 08:12:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] Documentation: kunit: eliminate code-block warnings
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, Harinder Singh <sharinder@google.com>,
        Tim Bird <tim.bird@sony.com>
References: <20220401024707.10550-1-rdunlap@infradead.org>
 <87fsjt50c8.fsf@meer.lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87fsjt50c8.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 6/24/22 12:27, Jonathan Corbet wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> Fix Sphinx complaints about code-block directive missing an argument.
>> For start.rst, add "none" since that is already heavily used in that
>> file. For run_wrapper.rst, use the simpler "::" literal block instead.
> 
> [Sorry that this fell through the cracks; I'm never quite sure who is
> going to handle kunit patches]
> 
>> dev-tools/kunit/start.rst:83: WARNING: Error in "code-block" directive:
>> 1 argument(s) required, 0 supplied.
>>
>> dev-tools/kunit/run_wrapper.rst:17: WARNING: Error in "code-block" directive:
>> 1 argument(s) required, 0 supplied.
> 
> So which version of Sphinx are you using?  The language argument became
> optional in 2.0, so you'd need to be running something pretty ancient to
> see this.
> 
> Ah, I see 1.8.5 in your later message...how wedded are you to that
> version?

It's what ships with OpenSuse Leap 15.3, which I have been using for quite
a long time.

I see that there is now OpenSuse Leap 15.4, so I could upgrade to that,
but I don't know what version on Sphinx it uses.

> Ostensibly we support back to 1.7, so I guess we should stick by its
> rules.  But the better solution, I think, is to raise our minimum
> version; I think I'll look into that shortly.
> 

>>  
>>  Run command:
>>  
>> -.. code-block::
>> +::
> 
> A much nicer fix for these would have been just:
> 
>   Run command::

Yeah, that is nicer.

> 
> Oh well, I've applied it.

thanks.

-- 
~Randy
