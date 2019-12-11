Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05D7D11B9F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2019 18:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbfLKRU2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Dec 2019 12:20:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:52544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730823AbfLKRU2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Dec 2019 12:20:28 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 296862073D;
        Wed, 11 Dec 2019 17:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576084827;
        bh=JHuvTlW3jgbnrHg+UAFqzVHC4Yp7D0o0CKpG2cSfsDs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=L5buTqSpIyBJ5O27cxhTPHfsjWBHU/TFDWCSzbb/yFLNAwYdIwIMK43SuH3x0pMCh
         Iy18U2IRquRRZaQcgJ/G9xR4YD5/fol2nJTeh3Ulq+Eyq1Ftfb7zqGIkTa1dZwzOc4
         ku9cwf+9MRwdPFkJqJjC9RJi+GrGq/RlFEh/9TRw=
Subject: Re: [PATCH 2/2] kselftest: Support old perl versions
To:     Kees Cook <keescook@chromium.org>,
        SeongJae Park <sjpark@amazon.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        sj38.park@gmail.com, SeongJae Park <sjpark@amazon.de>,
        shuah <shuah@kernel.org>
References: <20191202114221.827-1-sjpark@amazon.com>
 <20191202114221.827-2-sjpark@amazon.com> <201912071047.D7BDF3DD9F@keescook>
From:   shuah <shuah@kernel.org>
Message-ID: <5e9eb477-6889-e85a-5d4e-a10bfaf8966b@kernel.org>
Date:   Wed, 11 Dec 2019 10:20:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <201912071047.D7BDF3DD9F@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/7/19 11:47 AM, Kees Cook wrote:
> On Mon, Dec 02, 2019 at 12:42:21PM +0100, SeongJae Park wrote:
>> From: SeongJae Park <sjpark@amazon.de>
>>
>> On an old perl such as v5.10.1, `kselftest/prefix.pl` gives below error
>> message:
>>
>>      Can't locate object method "autoflush" via package "IO::Handle" at kselftest/prefix.pl line 10.
>>
>> This commit fixes the error by explicitly specifying the use of the
>> `IO::Handle` package.
>>
>> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> 
> Good catch!
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> -Kees
> 
>> ---
>>   tools/testing/selftests/kselftest/prefix.pl | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/kselftest/prefix.pl b/tools/testing/selftests/kselftest/prefix.pl
>> index ec7e48118183..31f7c2a0a8bd 100755
>> --- a/tools/testing/selftests/kselftest/prefix.pl
>> +++ b/tools/testing/selftests/kselftest/prefix.pl
>> @@ -3,6 +3,7 @@
>>   # Prefix all lines with "# ", unbuffered. Command being piped in may need
>>   # to have unbuffering forced with "stdbuf -i0 -o0 -e0 $cmd".
>>   use strict;
>> +use IO::Handle;
>>   
>>   binmode STDIN;
>>   binmode STDOUT;
>> -- 
>> 2.17.1
>>
> 

Applying to fixes for next 5.5-rc

thanks,
-- Shuah
