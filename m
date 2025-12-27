Return-Path: <linux-kselftest+bounces-47970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAABDCDF3C9
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Dec 2025 04:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BA5B3005FCE
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Dec 2025 03:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632D52248BE;
	Sat, 27 Dec 2025 03:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rmA5i7pG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD11021C9F9
	for <linux-kselftest@vger.kernel.org>; Sat, 27 Dec 2025 03:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766807072; cv=none; b=eaCZwdG3RqrohD4cb3UhZyHAspolMXqCc0GWEKNraB8MaJ/52/SxAm1sv9l692YtcLO7VjUjMctIF4MdWPLvFvNgXtjUQyHwNZF7Y/g68tBHxvJ6TCpVS+wLl6kbKUMD1L7ko9uhFZ1h9RPWGsE7GY1Ewf0hO3WRkt+Tbngc15U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766807072; c=relaxed/simple;
	bh=BNmJdaF02VYerSxAn/zNU6FChII5a52OpX0Qjt/FFdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hy3SitVFVRFJVdTkjcwfmwb62WXKz6EzaET+wsnOgkV/AnMKhuKy88sIxjlae7vJYGYjAaF8qmK/W0PQV06JcvQxO/tJtlllv0Z58h+49URwb66OqiyMSjMiP+Lae4u3V0Mm1AJw0A5i2yTFXxL327AeR72Armp22WFaWyQEw6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rmA5i7pG; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766807057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SFLzyHiaIj1Qfw1UwpV6wygz3n0qAY7bO9yAKNS3K4=;
	b=rmA5i7pG5dIYjH/3KxN5eYLh0zp+zRFa6avDm6iSvczf9+CFgApbzTzVJ/e3apvUpf0QWn
	LMeAkP9VXsoT/JkFdCH5jhGdH9xOp9L7jTxnjgKNz+KhBDz5Il0nDmBWHxmzFkdNbNsPPh
	A8rfGqrCXWAnDgQS9bKT+QWNUDXoeAQ=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: rostedt@goodmis.org
Cc: fushuai.wang@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	shuah@kernel.org,
	wangfushuai@baidu.com
Subject: Re: [PATCH] selftests/tracing: Fix test_multiple_writes stall
Date: Sat, 27 Dec 2025 11:44:06 +0800
Message-Id: <20251227034406.73156-1-fushuai.wang@linux.dev>
In-Reply-To: <20251226132927.4c406bd9@gandalf.local.home>
References: <20251226132927.4c406bd9@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

>> When /sys/kernel/tracing/buffer_size_kb is less than 12KB,
>> the test_multiple_writes test will stall and wait for more
>> input due to insufficient buffer space.
>> 
>> This patch check current buffer_size_kb value before the test.
>
> Never use "This patch" in a change log. See Submitting Patches:
>
> https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
>
>     Describe your changes in imperative mood, e.g. “make xyzzy do frotz”
>     instead of “[This patch] makes xyzzy do frotz” or “[I] changed xyzzy to
>     do frotz”, as if you are giving orders to the codebase to change its
>     behaviour.
>
>

Thank you for pointing this out. I will follow this guideline
in future submissions.

>> If it is less than 12KB, it temporarily increase the buffer to
>> 12KB, and restore the original value after the tests are completed.
>> 
>> Fixes: 37f46601383a ("selftests/tracing: Add basic test for trace_marker_raw file")
>> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
>> ---
>>  .../ftrace/test.d/00basic/trace_marker_raw.tc    | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>> 
>> diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
>> index 7daf7292209e..216f87d89c3f 100644
>> --- a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
>> +++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
>> @@ -58,7 +58,7 @@ test_multiple_writes() {
>>  	echo stop > trace_marker
>>  
>>  	# Check to make sure the number of entries is the id (rounded up by 4)
>> -	awk '/.*: # [0-9a-f]* / {
>> +	awk -v ORIG="${ORIG}" '/.*: # [0-9a-f]* / {
>>  			print;
>>  			cnt = -1;
>>  			for (i = 0; i < NF; i++) {
>> @@ -70,6 +70,7 @@ test_multiple_writes() {
>>  					# The number of items is always rounded up by 4
>>  					cnt2 = int((cnt + 3) / 4) * 4;
>>  					if (cnt2 != num) {
>> +						system("echo \""ORIG"\" > buffer_size_kb");
>
> Why are you doing this in the awk script?
>>
>>  						exit 1;
>>  					}
>>  					break;
>> @@ -89,6 +90,7 @@ test_buffer() {
>>  	# The id must be four bytes, test that 3 bytes fails a write
>>  	if echo -n abc > ./trace_marker_raw ; then
>>  		echo "Too small of write expected to fail but did not"
>> +		echo $ORIG > buffer_size_kb
>>  		exit_fail
>>  	fi
>>  
>> @@ -99,9 +101,21 @@ test_buffer() {
>>  
>>  	if write_buffer 0xdeadbeef $size ; then
>>  		echo "Too big of write expected to fail but did not"
>> +		echo $ORIG > buffer_size_kb
>>  		exit_fail
>>  	fi
>>  }
>>  
>> +ORIG=`cat buffer_size_kb`
>> +
>> +# test_multiple_writes test needs at least 12KB buffer
>> +NEW_SIZE=12
>> +
>> +if [ ${ORIG} -lt ${NEW_SIZE} ]; then
>> +	echo ${NEW_SIZE} > buffer_size_kb
>> +fi
>> +
>>  test_buffer
>>  test_multiple_writes
>
> Could add:
>
>   if ! test_multiple_writes ; then
> 	echo $ORIG > buffer_size_kb
> 	exit_fail
>   fi
>
> instead.
> 
> -- Steve

Thank you, and this looks better.
I will send a v2 shortly.

---
Regards,
WANG

