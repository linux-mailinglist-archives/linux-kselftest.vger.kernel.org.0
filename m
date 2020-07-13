Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED46721D23D
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jul 2020 10:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgGMIxJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jul 2020 04:53:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbgGMIxI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jul 2020 04:53:08 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06D8WGmr108228;
        Mon, 13 Jul 2020 04:53:03 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3277rcp7a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 04:53:02 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06D8WHYs108318;
        Mon, 13 Jul 2020 04:53:02 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3277rcp796-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 04:53:02 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06D8nqjp011262;
        Mon, 13 Jul 2020 08:53:00 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 32752820c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 08:52:59 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06D8qv7n11272682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jul 2020 08:52:57 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4E725204E;
        Mon, 13 Jul 2020 08:52:57 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.199.49.56])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id E4BD85204F;
        Mon, 13 Jul 2020 08:52:55 +0000 (GMT)
Subject: Re: [PATCH] selftests/livepatch: adopt to newer sysctl error format
To:     Joe Lawrence <joe.lawrence@redhat.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Shuah Khan <shuah@kernel.org>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200710051043.899291-1-kamalesh@linux.vnet.ibm.com>
 <20200710152735.GA20226@alley> <20200710183108.GA17581@redhat.com>
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Message-ID: <58df4b1b-9a5a-4ce4-08f0-0b962c8d40e0@linux.vnet.ibm.com>
Date:   Mon, 13 Jul 2020 14:22:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200710183108.GA17581@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_04:2020-07-10,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007130061
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/07/20 12:01 am, Joe Lawrence wrote:
> On Fri, Jul 10, 2020 at 05:27:35PM +0200, Petr Mladek wrote:
>> On Fri 2020-07-10 10:40:43, Kamalesh Babulal wrote:
>>> With procfs v3.3.16, the sysctl command doesn't prints the set key and
>>> value on error.  This change breaks livepatch selftest test-ftrace.sh,
>>> that tests the interaction of sysctl ftrace_enabled:
>>>
> 
> Good catch, it looks like it was this procps commit that modified that
> behavior:
> 
>   commit da82fe49b1476d227874905068adb69577e11d96
>   Author: Patrick Steinhardt <ps@pks.im>
>   Date:   Tue May 29 13:29:03 2018 +0200
>   
>       sysctl: do not report set key in case `close_stream` fails
>       
>       As we're using buffered I/O when writing kernel parameters, write errors
>       may get delayed until we close the `FILE` stream. As we are currently
>       outputting the key that is to be set disregarding the return value of
>       `close_stream`, we may end up in a situation where we report error and
>       success:
>       
>           $ sysctl kernel.printk_ratelimit=100000000000000
>           sysctl: setting key "kernel.printk_ratelimit": error code 22
>           kernel.printk_ratelimit = 100000000000000
>       
>       Fix the issue by only outputting the updated value in case
>       `close_stream` does not report an error.
>       
>       Signed-off-by: Patrick Steinhardt <ps@pks.im>
> 
> And I'd agree that echoing the failed new value was confusing to see
> from a user's perspective.
> 
>>>  # selftests: livepatch: test-ftrace.sh
>>>  # TEST: livepatch interaction with ftrace_enabled sysctl ... not ok
>>>  #
>>>  # --- expected
>>>  # +++ result
>>>  # @@ -16,7 +16,7 @@ livepatch: 'test_klp_livepatch': initial
>>>  #  livepatch: 'test_klp_livepatch': starting patching transition
>>>  #  livepatch: 'test_klp_livepatch': completing patching transition
>>>  #  livepatch: 'test_klp_livepatch': patching complete
>>>  # -livepatch: sysctl: setting key "kernel.ftrace_enabled": Device or
>>>     resource busy kernel.ftrace_enabled = 0
>>>  # +livepatch: sysctl: setting key "kernel.ftrace_enabled": Device or
>>>     resource busy
>>>  #  % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
>>>  #  livepatch: 'test_klp_livepatch': initializing unpatching transition
>>>  #  livepatch: 'test_klp_livepatch': starting unpatching transition
>>>  #
>>>  # ERROR: livepatch kselftest(s) failed
>>>
>>> on setting sysctl kernel.ftrace_enabled={0,1} value successfully, the
>>> set key and value is displayed.
>>>
>>> This patch fixes it by limiting the output from both the cases to eight
>>> words, that includes the error message or set key and value on failure
>>> and success. The upper bound of eight words is enough to display the
>>> only tracked error message. Also, adjust the check_result string in
>>> test-ftrace.sh to match the expected output.
>>
>> This looks really tricky.
>>
>> I wonder if we could use "sysctl -q" to refuse printing the value
>> even with older versions. The following patch works here with
>> sysctl 3.3.15:

Agree, "sysctl -q" is more robust, I tested it with sysctl v3.3.16 and the test
passes.  Can you please send the patch?

>>
> 
> FWIW, --quiet was added to procps way back in 2004, so it should be safe
> to use... and there's already a bunch of net selftests using it.

a couple of tests is using the "-q" options to set the sysctl values.

> 
>> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
>> index 2aab9791791d..47aa4c762bb4 100644
>> --- a/tools/testing/selftests/livepatch/functions.sh
>> +++ b/tools/testing/selftests/livepatch/functions.sh
>> @@ -64,7 +64,8 @@ function set_dynamic_debug() {
>>  }
>>  
>>  function set_ftrace_enabled() {
>> -	result=$(sysctl kernel.ftrace_enabled="$1" 2>&1 | paste --serial --delimiters=' ')
>> +	result=$(sysctl -q kernel.ftrace_enabled="$1" 2>&1 && \
>> +		 sysctl kernel.ftrace_enabled 2>&1)
>>  	echo "livepatch: $result" > /dev/kmsg
>>  }
>>  
>> diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
>> index e2a76887f40a..aa967c5d0558 100755
>> --- a/tools/testing/selftests/livepatch/test-ftrace.sh
>> +++ b/tools/testing/selftests/livepatch/test-ftrace.sh
>> @@ -53,7 +53,7 @@ livepatch: '$MOD_LIVEPATCH': initializing patching transition
>>  livepatch: '$MOD_LIVEPATCH': starting patching transition
>>  livepatch: '$MOD_LIVEPATCH': completing patching transition
>>  livepatch: '$MOD_LIVEPATCH': patching complete
>> -livepatch: sysctl: setting key \"kernel.ftrace_enabled\": Device or resource busy kernel.ftrace_enabled = 0
>> +livepatch: sysctl: setting key \"kernel.ftrace_enabled\": Device or resource busy
>>  % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
>>  livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
>>  livepatch: '$MOD_LIVEPATCH': starting unpatching transition
>>
>>
> 
> I think this method is less fragile than word count / cutting and we get
> to drop that strange 'paste' invocation (I had to look that up in the
> mapages to remember why we used it).
> 

-- 
Kamalesh
