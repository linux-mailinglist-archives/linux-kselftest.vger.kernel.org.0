Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4BC11B9DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2019 18:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbfLKRRk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Dec 2019 12:17:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:51476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730318AbfLKRRk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Dec 2019 12:17:40 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A2F120409;
        Wed, 11 Dec 2019 17:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576084659;
        bh=dOuJNHAPl5FHZkOeRPDhTFMXyq47JG1PI8yv+OOVfaU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gh0LcUDKYgOA/hOeopM/3GrtdmxbEsXTnQ81WJKaNZo3eqkNHo6+XUva4EPeWd8rp
         8ti1qC8cmm23LYt3T+EqEijft8ZbQmmJ5kkeqO1mrBeHMOmi+O+I013JhMJmQQZCvd
         Q7g/V7ngBKpaK8NGrTqdMAlzwIm3OoSKKfFetadw=
Subject: Re: [PATCH] selftests: Fix dangling documentation references to
 kselftest_module.sh
To:     Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20191206031738.29641-1-mpe@ellerman.id.au>
 <201912071043.748BB5A6@keescook>
From:   shuah <shuah@kernel.org>
Message-ID: <8f176a1d-23af-b4e7-f346-87d030adf239@kernel.org>
Date:   Wed, 11 Dec 2019 10:17:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <201912071043.748BB5A6@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/7/19 11:43 AM, Kees Cook wrote:
> On Fri, Dec 06, 2019 at 02:17:38PM +1100, Michael Ellerman wrote:
>> Commit c78fd76f2b67 ("selftests: Move kselftest_module.sh into
>> kselftest/") moved kselftest_module.sh but missed updating a few
>> references to the path in documentation.
>>
>> Fixes: c78fd76f2b67 ("selftests: Move kselftest_module.sh into kselftest/")
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> Whoops! Thank you! :)
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> -Kees
> 
>> ---
>>   Documentation/dev-tools/kselftest.rst       | 8 ++++----
>>   tools/testing/selftests/kselftest/module.sh | 2 +-
>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
>> index ecdfdc9d4b03..61ae13c44f91 100644
>> --- a/Documentation/dev-tools/kselftest.rst
>> +++ b/Documentation/dev-tools/kselftest.rst
>> @@ -203,12 +203,12 @@ Test Module
>>   Kselftest tests the kernel from userspace.  Sometimes things need
>>   testing from within the kernel, one method of doing this is to create a
>>   test module.  We can tie the module into the kselftest framework by
>> -using a shell script test runner.  ``kselftest_module.sh`` is designed
>> +using a shell script test runner.  ``kselftest/module.sh`` is designed
>>   to facilitate this process.  There is also a header file provided to
>>   assist writing kernel modules that are for use with kselftest:
>>   
>>   - ``tools/testing/kselftest/kselftest_module.h``
>> -- ``tools/testing/kselftest/kselftest_module.sh``
>> +- ``tools/testing/kselftest/kselftest/module.sh``
>>   
>>   How to use
>>   ----------
>> @@ -247,7 +247,7 @@ Example Module
>>   
>>      #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>   
>> -   #include "../tools/testing/selftests/kselftest_module.h"
>> +   #include "../tools/testing/selftests/kselftest/module.h"
>>   
>>      KSTM_MODULE_GLOBALS();
>>   
>> @@ -276,7 +276,7 @@ Example test script
>>   
>>       #!/bin/bash
>>       # SPDX-License-Identifier: GPL-2.0+
>> -    $(dirname $0)/../kselftest_module.sh "foo" test_foo
>> +    $(dirname $0)/../kselftest/module.sh "foo" test_foo
>>   
>>   
>>   Test Harness
>> diff --git a/tools/testing/selftests/kselftest/module.sh b/tools/testing/selftests/kselftest/module.sh
>> index 18e1c7992d30..fb4733faff12 100755
>> --- a/tools/testing/selftests/kselftest/module.sh
>> +++ b/tools/testing/selftests/kselftest/module.sh
>> @@ -9,7 +9,7 @@
>>   #
>>   #   #!/bin/sh
>>   #   SPDX-License-Identifier: GPL-2.0+
>> -#   $(dirname $0)/../kselftest_module.sh "description" module_name
>> +#   $(dirname $0)/../kselftest/module.sh "description" module_name
>>   #
>>   # Example: tools/testing/selftests/lib/printf.sh
>>   
>> -- 
>> 2.21.0
>>
> 

Thanks. Pulling it into fixes for next 5.5-rc

-- Shuah
