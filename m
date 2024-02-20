Return-Path: <linux-kselftest+bounces-5021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20E385BC3A
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 13:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C37282439
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 12:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400AA69D1F;
	Tue, 20 Feb 2024 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="X0pt4tab"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1C46997D;
	Tue, 20 Feb 2024 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708432323; cv=none; b=kposO515/IVKl6sWVD6NwPUFncAxr1OC3RJkXaPl7uInlQVP6cjKNHy7LfYPwE5S2L5Lmr364VHJ58GF+N7Fc6tbnSH2QIsJG7oMSPotRA71gV+0kgywpWcF2/NomzMb+TTW9oNFl8lPzF5J+Ey9aj9gajwJAP2vJlCdwAZguvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708432323; c=relaxed/simple;
	bh=C57tELA+v1jLOo/fRRVSiXHSRcnzvGUu74uuhfpwA/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kR7eoarZhYTeninsUc9D1k9BwgozIQIJiOgHhZ8/5Ca8oax6abRTEkCZTNwsakgJskUe/notW2tqM4KbrVatncaLLNXQI3hWewfZc9GmzWcNiffmZc4OxoTEqQGt5DXw58Mif/TJsdrim1/3ra4m8yi0JtjIEflqghAflFiFh8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=X0pt4tab; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708432316; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=i8MeXBL4Q21bO6Mt0CWzsHtCP+BDuMSfUqLrqrJbi1g=;
	b=X0pt4tabGMITGOSIoiT5jMJGNCsEj0CyYMkZWuGJ3nbdQxOiJnWdwHe/+V0tkkjtZ1tY38aCO7p1jj1pTJli5MENhtVRrQulUPRGBYIdF9H80HzwAGQHurf6Dj5+84H/upjsrIq1tHkdtXELT79ZAsUtFpnOloswp9qP6dpnVZ0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W0wo.d5_1708432314;
Received: from 30.178.67.248(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0W0wo.d5_1708432314)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 20:31:55 +0800
Message-ID: <4b69e961-878d-45b0-bdc3-edcfe2306149@linux.alibaba.com>
Date: Tue, 20 Feb 2024 20:31:53 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tools/testing: adjust pstore backend related selftest
To: Kees Cook <keescook@chromium.org>
Cc: tony.luck@intel.com, gpiccoli@igalia.com, shuah@kernel.org,
 corbet@lwn.net, xlpang@linux.alibaba.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kselftest@vger.kernel.org, xiangzao@linux.alibaba.com
References: <20240207021921.206425-1-xiangzao@linux.alibaba.com>
 <20240207021921.206425-4-xiangzao@linux.alibaba.com>
 <202402070452.24B3200@keescook>
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
In-Reply-To: <202402070452.24B3200@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/7 20:53, Kees Cook wrote:
> On Wed, Feb 07, 2024 at 10:19:21AM +0800, Yuanhe Shu wrote:
>> Pstore now supports multiple backends, the module parameter
>> pstore.backend varies from 'registered backend' to 'backends that are
>> allowed to register'. Adjust selftests to match the change.
>>
>> Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
>> ---
>>   tools/testing/selftests/pstore/common_tests   |  8 +--
>>   .../selftests/pstore/pstore_post_reboot_tests | 65 ++++++++++---------
>>   tools/testing/selftests/pstore/pstore_tests   |  2 +-
>>   3 files changed, 38 insertions(+), 37 deletions(-)
>>
>> diff --git a/tools/testing/selftests/pstore/common_tests b/tools/testing/selftests/pstore/common_tests
>> index 4509f0cc9c91..497e6fc3215f 100755
>> --- a/tools/testing/selftests/pstore/common_tests
>> +++ b/tools/testing/selftests/pstore/common_tests
>> @@ -27,9 +27,9 @@ show_result() { # result_value
>>   }
>>   
>>   check_files_exist() { # type of pstorefs file
>> -    if [ -e ${1}-${backend}-0 ]; then
>> +    if [ -e ${1}-${2}-0 ]; then
>>   	prlog "ok"
>> -	for f in `ls ${1}-${backend}-*`; do
>> +	for f in `ls ${1}-${2}-*`; do
>>               prlog -e "\t${f}"
>>   	done
>>       else
>> @@ -74,9 +74,9 @@ prlog "=== Pstore unit tests (`basename $0`) ==="
>>   prlog "UUID="$UUID
>>   
>>   prlog -n "Checking pstore backend is registered ... "
>> -backend=`cat /sys/module/pstore/parameters/backend`
>> +backends=$(dmesg | sed -n 's/.*pstore: Registered \(.*\) as persistent store backend.*/\1/p')
>>   show_result $?
>> -prlog -e "\tbackend=${backend}"
>> +prlog -e "\tbackends="$backends
> 
> Missing trailing "? Also, doesn't this end up printing multiple lines?
> Perhaps, like LSM stacking, we need a /sys/module entry for the list of
> backends, comma separated?
> 

To avoid printing multiple lines here we move $backends out of "" then 
it will print one single line backend names seperated by white space.

Yes, I also referred to LSM stacking and wondering if we need a module 
parameter to indicate which backends are registered at present. It would 
be nice for users to know which pstore backends are registered and 
selftest could take it for test easily. But I am worried about it would 
be confusing for users that there is a parameter pstore.backend to 
indicate which backends are allowed to be registered and another 
parameter to indicate which backends are registered now. At first the 
naming is a question. What is your advice?

>>   prlog -e "\tcmdline=`cat /proc/cmdline`"
>>   if [ $rc -ne 0 ]; then
>>       exit 1
>> diff --git a/tools/testing/selftests/pstore/pstore_post_reboot_tests b/tools/testing/selftests/pstore/pstore_post_reboot_tests
>> index d6da5e86efbf..9e40ccb9c918 100755
>> --- a/tools/testing/selftests/pstore/pstore_post_reboot_tests
>> +++ b/tools/testing/selftests/pstore/pstore_post_reboot_tests
>> @@ -36,45 +36,46 @@ else
>>   fi
>>   
>>   cd ${mount_point}
>> +for backend in ${backends}; do
>> +    prlog -n "Checking ${backend}-dmesg files exist in pstore filesystem ... "
>> +    check_files_exist dmesg ${backend}
>>   
>> -prlog -n "Checking dmesg files exist in pstore filesystem ... "
>> -check_files_exist dmesg
>> +    prlog -n "Checking ${backend}-console files exist in pstore filesystem ... "
>> +    check_files_exist console ${backend}
>>   
>> -prlog -n "Checking console files exist in pstore filesystem ... "
>> -check_files_exist console
>> +    prlog -n "Checking ${backend}-pmsg files exist in pstore filesystem ... "
>> +    check_files_exist pmsg ${backend}
>>   
>> -prlog -n "Checking pmsg files exist in pstore filesystem ... "
>> -check_files_exist pmsg
>> +    prlog -n "Checking ${backend}-dmesg files contain oops end marker"
>> +    grep_end_trace() {
>> +        grep -q "\---\[ end trace" $1
>> +    }
>> +    files=`ls dmesg-${backend}-*`
>> +    operate_files $? "$files" grep_end_trace
>>   
>> -prlog -n "Checking dmesg files contain oops end marker"
>> -grep_end_trace() {
>> -    grep -q "\---\[ end trace" $1
>> -}
>> -files=`ls dmesg-${backend}-*`
>> -operate_files $? "$files" grep_end_trace
>> +    prlog -n "Checking ${backend}-console file contains oops end marker ... "
>> +    grep -q "\---\[ end trace" console-${backend}-0
>> +    show_result $?
>>   
>> -prlog -n "Checking console file contains oops end marker ... "
>> -grep -q "\---\[ end trace" console-${backend}-0
>> -show_result $?
>> -
>> -prlog -n "Checking pmsg file properly keeps the content written before crash ... "
>> -prev_uuid=`cat $TOP_DIR/prev_uuid`
>> -if [ $? -eq 0 ]; then
>> -    nr_matched=`grep -c "$TEST_STRING_PATTERN" pmsg-${backend}-0`
>> -    if [ $nr_matched -eq 1 ]; then
>> -	grep -q "$TEST_STRING_PATTERN"$prev_uuid pmsg-${backend}-0
>> -	show_result $?
>> +    prlog -n "Checking ${backend}-pmsg file properly keeps the content written before crash ... "
>> +    prev_uuid=`cat $TOP_DIR/prev_uuid`
>> +    if [ $? -eq 0 ]; then
>> +        nr_matched=`grep -c "$TEST_STRING_PATTERN" pmsg-${backend}-0`
>> +        if [ $nr_matched -eq 1 ]; then
>> +	    grep -q "$TEST_STRING_PATTERN"$prev_uuid pmsg-${backend}-0
>> +	    show_result $?
>> +        else
>> +            prlog "FAIL"
>> +            rc=1
>> +        fi
>>       else
>> -	prlog "FAIL"
>> -	rc=1
>> +        prlog "FAIL"
>> +        rc=1
>>       fi
>> -else
>> -    prlog "FAIL"
>> -    rc=1
>> -fi
>>   
>> -prlog -n "Removing all files in pstore filesystem "
>> -files=`ls *-${backend}-*`
>> -operate_files $? "$files" rm
>> +    prlog -n "Removing all ${backend} files in pstore filesystem "
>> +    files=`ls *-${backend}-*`
>> +    operate_files $? "$files" rm
>> +done
>>   
>>   exit $rc
>> diff --git a/tools/testing/selftests/pstore/pstore_tests b/tools/testing/selftests/pstore/pstore_tests
>> index 2aa9a3852a84..f4665a8c77dc 100755
>> --- a/tools/testing/selftests/pstore/pstore_tests
>> +++ b/tools/testing/selftests/pstore/pstore_tests
>> @@ -10,7 +10,7 @@
>>   . ./common_tests
>>   
>>   prlog -n "Checking pstore console is registered ... "
>> -dmesg | grep -Eq "console \[(pstore|${backend})"
>> +dmesg | grep -Eq "console \[(pstore console)"
>>   show_result $?
>>   
>>   prlog -n "Checking /dev/pmsg0 exists ... "
>> -- 
>> 2.39.3
>>
> 
> Otherwise seems ok
> 

