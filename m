Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7CC913AFBA
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2020 17:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgANQp7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jan 2020 11:45:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33284 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbgANQp7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jan 2020 11:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Flw8yamdhbUI/Y8isJM9I81gkbm2so+Fjah3kdZccsI=; b=d2OVa2oiSFbtq1TKQwTTOGbix
        +J7m6UjsOOPGsrC7vja9rBloPfhe00FEHIT2QzGCRF3/8hg290T8McF7EA/HHhSz8ovVYDTk9AoYw
        PuLWKu7sggYQj7lxpZUbRHHsmLhv85btRed/hc55TtkxEekUY4XmMHozA3Fm6pPgm0UGYpXNg30lu
        3WczxIg7RBeglC/yD3ZQvBgDHrjkEKoqLLiG2DcEQfKzEgj+jpMj0jIlav9pLkiSqiFxxWJzaatiR
        n4EOUYy93yNWtzTH2Blz7OcnE3+7BcitVKqeNU2fxJ5bziallXXPHLAkE1RRhSAp3GLI1pfqZXg3M
        GVvDl87eQ==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irPKI-0007IP-Gy; Tue, 14 Jan 2020 16:45:58 +0000
Subject: Re: [PATCH] software node: introduce CONFIG_KUNIT_DRIVER_PE_TEST
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     brendanhiggins@google.com, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, dmitry.torokhov@gmail.com, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
References: <1579018183-14879-1-git-send-email-alan.maguire@oracle.com>
 <2242e184-93a5-147d-d603-4017ca86eba9@infradead.org>
 <alpine.LRH.2.20.2001141639240.15464@dhcp-10-175-171-251.vpn.oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <51d7d427-2ef6-b0cd-ad23-2fb75b06b763@infradead.org>
Date:   Tue, 14 Jan 2020 08:45:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.20.2001141639240.15464@dhcp-10-175-171-251.vpn.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/14/20 8:42 AM, Alan Maguire wrote:
> On Tue, 14 Jan 2020, Randy Dunlap wrote:
> 
>> Hi Alan,
>>
>> On 1/14/20 8:09 AM, Alan Maguire wrote:
>>> currently the property entry kunit tests are built if CONFIG_KUNIT=y.
>>> This will cause warnings when merged with the kunit tree that now
>>> supports tristate CONFIG_KUNIT.  While the tests appear to compile
>>> as a module, we get a warning about missing module license.
>>>
>>> It's better to have a per-test suite CONFIG variable so that
>>> we can do selective building of kunit-based suites, and can
>>> also avoid merge issues like this.
>>>
>>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>>
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>>
> 
> Apologies for missing you out here.
>  
>>> Fixes: c032ace71c29 ("software node: add basic tests for property entries")
>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>> ---
>>>  drivers/base/test/Kconfig  | 3 +++
>>>  drivers/base/test/Makefile | 2 +-
>>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
>>> index 86e85da..d29ae95 100644
>>> --- a/drivers/base/test/Kconfig
>>> +++ b/drivers/base/test/Kconfig
>>> @@ -8,3 +8,6 @@ config TEST_ASYNC_DRIVER_PROBE
>>>  	  The module name will be test_async_driver_probe.ko
>>>  
>>>  	  If unsure say N.
>>> +config KUNIT_DRIVER_PE_TEST
>>> +	bool "KUnit Tests for property entry API"
>>> +	depends on KUNIT
>>
>> Why is this bool instead of tristate?
>>
> 
> The support for building kunit and kunit tests as modules has not merged 
> into linux-next yet, so if we set the option to tristate the build would
> fail for allmodconfig builds.   Once it's merged we can revisit though; I 
> should have mentioned this, thanks for reminding me!

Oh. I see.  Thanks.

-- 
~Randy

