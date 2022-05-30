Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D782537312
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 May 2022 02:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiE3ARd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 29 May 2022 20:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiE3ARd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 29 May 2022 20:17:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD551BE8F;
        Sun, 29 May 2022 17:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=3MFiazr+BIa7mxTlJyKT5T3zyYYhOWZJgXwNkt8FF0c=; b=rNex2oA2fs7Gn5+tXSYIhdA39b
        kiZia63GDM53cV29Hz5AdAJIoT2HXVakwRHy4qe9kRDMDiMvrcA4gx+n+Lkh+sxtFD3fgFltLlNVN
        nX5HJhBUukjzEnxmUtP/tAQqvXFK+XyWYyEEazTEhewVMZ66RJXEmHxUVHCLnRbNui0Gg+z6dEEDg
        4J+pVZeCe7HWD7PMs3tKx045R6b4enr71bM45tK11Gugx5NBTXXch6vDnjeP5oCcPmD/OKCVniHna
        lZ1/WTeMKtXcJxUI50b5BpjZIsqO4GhUvX2anWRg/zKRdsJ6eyPtZcm16y7SwIA6n4ScfEyaEr4uS
        1dFBYU2Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvT65-002t4I-3s; Mon, 30 May 2022 00:17:26 +0000
Message-ID: <593f31f6-1628-87f2-1b5d-ad8e79119dd6@infradead.org>
Date:   Sun, 29 May 2022 17:17:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: kbuild problem: ERROR: modpost: missing MODULE_LICENSE() in
 drivers/iio/afe/iio-rescale.o
Content-Language: en-US
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
References: <18500f18-9cd5-a81c-4a55-14e999ed4496@infradead.org>
 <3ae306e0-c6c7-ed12-cacd-62b1c26dba3c@infradead.org>
 <6671de03-c09c-bfaf-e06c-e45af70d4354@infradead.org>
 <6601a387-de9a-a0d0-11b5-01e0cfa75657@infradead.org>
 <7a97bac3-6ade-8e1b-cf0c-4a05c83163a3@infradead.org> <Yo+lHSmeIsx144cv@shaak>
 <3b7ec693-f4a5-e1aa-3e07-b22a4008d4c9@infradead.org> <YpPjqC+kVLIBpNlq@shaak>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <YpPjqC+kVLIBpNlq@shaak>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 5/29/22 14:20, Liam Beguin wrote:
> Hi Randy,
> 
> On Thu, May 26, 2022 at 01:04:41PM -0700, Randy Dunlap wrote:
>>
>>
>> On 5/26/22 09:04, Liam Beguin wrote:
>>> Hi Randy,
>>>
>>> On Thu, May 26, 2022 at 08:36:34AM -0700, Randy Dunlap wrote:
>>>> Liam:
>>>>
>>>> Any comment on this?
>>>> Otherwise I'll just send a formal patch like this (below).
>>>
>>> Apologies for not answering earlier.
>>>
>>> I wanted to look more into Masahiro's comment and try to fix the
>>> Makefile, but that can be done after.
>>>
>>> IMO your patch improves the current Kconfig, so I'd recommend sending
>>> the patch. If it can wait a bit, I can look at the Makefile over the
>>> weekend.
>>>
>>
>> Liam,
>>
>> I'll wait until next week to see if you come up with anything.
>>
> 
> The following patch fixes the issue while addressing Masahiro's comment.
> I also considered `select IIO_RESCALE`, but I'm not sure what's usually
> preferred.
> 
> diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
> index 56ca0ad7e77a..4c66c3f18c34 100644
> --- a/drivers/iio/test/Kconfig
> +++ b/drivers/iio/test/Kconfig
> @@ -6,7 +6,7 @@
>  # Keep in alphabetical order
>  config IIO_RESCALE_KUNIT_TEST
>  	bool "Test IIO rescale conversion functions"
> -	depends on KUNIT=y && !IIO_RESCALE
> +	depends on KUNIT=y && IIO_RESCALE=y
>  	default KUNIT_ALL_TESTS
>  	help
>  	  If you want to run tests on the iio-rescale code say Y here.
> diff --git a/drivers/iio/test/Makefile b/drivers/iio/test/Makefile
> index f15ae0a6394f..880360f8d02c 100644
> --- a/drivers/iio/test/Makefile
> +++ b/drivers/iio/test/Makefile
> @@ -4,6 +4,6 @@
>  #
>  
>  # Keep in alphabetical order
> -obj-$(CONFIG_IIO_RESCALE_KUNIT_TEST) += iio-test-rescale.o ../afe/iio-rescale.o
> +obj-$(CONFIG_IIO_RESCALE_KUNIT_TEST) += iio-test-rescale.o
>  obj-$(CONFIG_IIO_TEST_FORMAT) += iio-test-format.o
>  CFLAGS_iio-test-format.o += $(DISABLE_STRUCTLEAK_PLUGIN)
> 
> I'll send a patch as soon as you confirm this works for you too.

Looks good. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
