Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1B5BEE60
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2019 11:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfIZJY7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Sep 2019 05:24:59 -0400
Received: from foss.arm.com ([217.140.110.172]:43314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfIZJY7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Sep 2019 05:24:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C83871000;
        Thu, 26 Sep 2019 02:24:58 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38D5B3F67D;
        Thu, 26 Sep 2019 02:24:58 -0700 (PDT)
Subject: Re: [PATCH 1/2] kselftest: add capability to skip chosen TARGETS
To:     shuah <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     dave.martin@arm.com
References: <20190925132421.23572-1-cristian.marussi@arm.com>
 <e8848069-124d-a236-30c9-b8915471db16@kernel.org>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <45393e0b-666c-37b4-5454-cdbecc92361f@arm.com>
Date:   Thu, 26 Sep 2019 10:24:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e8848069-124d-a236-30c9-b8915471db16@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 25/09/2019 20:36, shuah wrote:
> On 9/25/19 7:24 AM, Cristian Marussi wrote:
>> Let the user specify an optional TARGETS skiplist through the new optional
>> SKIP_TARGETS Makefile variable.
>>
>> It is easier to skip at will a reduced and well defined list of possibly
>> problematic targets with SKIP_TARGETS then to provide a partially stripped
>> down list of good targets using the usual TARGETS variable.
>>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>> ---
>>   tools/testing/selftests/Makefile | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
>> index 25b43a8c2b15..103936faa46d 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -132,6 +132,10 @@ else
>>   		ARCH=$(ARCH) -C $(top_srcdir) headers_install
>>   endif
>>   
>> +# User can optionally provide a TARGETS skiplist.
>> +SKIP_TARGETS ?=
>> +TARGETS := $(filter-out $(SKIP_TARGETS), $(TARGETS))
>> +
>>   all: khdr
>>   	@for TARGET in $(TARGETS); do		\
>>   		BUILD_TARGET=$$BUILD/$$TARGET;	\
>>
> 
> Thanks for doing this. This looks good to me. Would you like to
> update the documentation file?
> 

Thanks for the review Shuah, I'll add doc and fixes in V2
with a proper cover letter

Thanks

Cristian
> thanks,
> -- Shuah
> 

