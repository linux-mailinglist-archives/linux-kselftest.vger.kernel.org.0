Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2567BEE69
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2019 11:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfIZJ0i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Sep 2019 05:26:38 -0400
Received: from foss.arm.com ([217.140.110.172]:43380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfIZJ0h (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Sep 2019 05:26:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F5691000;
        Thu, 26 Sep 2019 02:26:37 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 842F63F67D;
        Thu, 26 Sep 2019 02:26:36 -0700 (PDT)
Subject: Re: [PATCH 1/2] kselftest: add capability to skip chosen TARGETS
To:     Tim.Bird@sony.com, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     dave.martin@arm.com
References: <20190925132421.23572-1-cristian.marussi@arm.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977BD152@USCULXMSG01.am.sony.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <5aeaf05c-e5da-458f-45b8-c78094e74eab@arm.com>
Date:   Thu, 26 Sep 2019 10:26:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977BD152@USCULXMSG01.am.sony.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Tim

thanks for the review.

On 25/09/2019 21:20, Tim.Bird@sony.com wrote:
> Just a few nits inline below.
> 
>> -----Original Message-----
>> From: Cristian Marussi on Wednesday, September 25, 2019 3:24 AM
>>
>> Let the user specify an optional TARGETS skiplist through the new optional
>> SKIP_TARGETS Makefile variable.
>>
>> It is easier to skip at will a reduced and well defined list of possibly
> 
> It seems like there's a word missing.
> at will a -> at will using a
> 
>> problematic targets with SKIP_TARGETS then to provide a partially stripped
> 
> then -> than
> 
>> down list of good targets using the usual TARGETS variable.
>>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>> ---
>>  tools/testing/selftests/Makefile | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/tools/testing/selftests/Makefile
>> b/tools/testing/selftests/Makefile
>> index 25b43a8c2b15..103936faa46d 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -132,6 +132,10 @@ else
>>  		ARCH=$(ARCH) -C $(top_srcdir) headers_install
>>  endif
>>
>> +# User can optionally provide a TARGETS skiplist.
>> +SKIP_TARGETS ?=
>> +TARGETS := $(filter-out $(SKIP_TARGETS), $(TARGETS))
>> +
>>  all: khdr
>>  	@for TARGET in $(TARGETS); do		\
>>  		BUILD_TARGET=$$BUILD/$$TARGET;	\
>> --
>> 2.17.1
> 
> Great feature!  Thanks.
>  -- Tim
> 

I'll fix all in V2.

Thanks

Cristian

