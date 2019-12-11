Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFFB611B9EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2019 18:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbfLKRTw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Dec 2019 12:19:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:52214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730318AbfLKRTv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Dec 2019 12:19:51 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21C4020409;
        Wed, 11 Dec 2019 17:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576084791;
        bh=5mOZy9aSvWTDBTgTyHdmoUhFYOB7lePCh8AYYsfh7YE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RtWJx34Zl/FZtq9slmr5312KpXPQL1rk9I/EarUJzhOlFkYGZuhzcOG1i5oYEjH2H
         JoQtSBH4EyOey5qljIW0woKtFhsxpocUnGs79xBWzZyJdSytXnxp/HDvwAmQc0oEkL
         JGoyrRAeQ0RO2Qe/gaeySjlqUA0rf6YNaMVpHLo4=
Subject: Re: [PATCH 1/2] kselftest/runner: Print new line in print of timeout
 log
To:     Kees Cook <keescook@chromium.org>,
        SeongJae Park <sjpark@amazon.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        sj38.park@gmail.com, SeongJae Park <sjpark@amazon.de>,
        shuah <shuah@kernel.org>
References: <20191202114221.827-1-sjpark@amazon.com>
 <201912071047.E373E19A97@keescook>
From:   shuah <shuah@kernel.org>
Message-ID: <cbbe2517-06bc-36c4-8762-a2cd28fa1e4a@kernel.org>
Date:   Wed, 11 Dec 2019 10:19:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <201912071047.E373E19A97@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/7/19 11:47 AM, Kees Cook wrote:
> On Mon, Dec 02, 2019 at 12:42:20PM +0100, SeongJae Park wrote:
>> From: SeongJae Park <sjpark@amazon.de>
>>
>> If a timeout failure occurs, kselftest kills the test process and prints
>> the timeout log.  If the test process has killed while printing a log
>> that ends with new line, the timeout log can be printed in middle of the
>> test process output so that it can be seems like a comment, as below:
>>
>>      # test_process_log	not ok 3 selftests: timers: nsleep-lat # TIMEOUT
>>
>> This commit avoids such problem by printing one more line before the
>> TIMEOUT failure log.
>>
>> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> Cool, yeah, this looks fine to me. Nice idea!
> 
> -Kees
> 
>> ---
>>   tools/testing/selftests/kselftest/runner.sh | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
>> index 84de7bc74f2c..a8d20cbb711c 100644
>> --- a/tools/testing/selftests/kselftest/runner.sh
>> +++ b/tools/testing/selftests/kselftest/runner.sh
>> @@ -79,6 +79,7 @@ run_one()
>>   		if [ $rc -eq $skip_rc ]; then	\
>>   			echo "not ok $test_num $TEST_HDR_MSG # SKIP"
>>   		elif [ $rc -eq $timeout_rc ]; then \
>> +			echo "#"
>>   			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT"
>>   		else
>>   			echo "not ok $test_num $TEST_HDR_MSG # exit=$rc"
>> -- 
>> 2.17.1
>>
> 

Thanks. Applying to fixes for the next 5.5-rc

-- Shuah
