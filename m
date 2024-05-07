Return-Path: <linux-kselftest+bounces-9604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B03788BE6C7
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 17:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B0028523D
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 15:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E061607A2;
	Tue,  7 May 2024 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S+rTj6WI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A64A15FA71
	for <linux-kselftest@vger.kernel.org>; Tue,  7 May 2024 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094011; cv=none; b=ag3aU20BdpRzOlT8a5S+HzGkF/2XBfqpFYecgDEn/yq6IMSiri1rIj/9NhEJtkhSjeQ45D7M1EAm9BehwxBTJK0VTDK55ieFCShd0NGJzNNwVv2O2gNo0dLfG4a93W6TE9SzSL8xYoZAboUwM7vrsCbgREAWWByDNaG8HZknKyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094011; c=relaxed/simple;
	bh=7DMliRef7hOuh6uBFLJxeHt7dv1FUEnkYZ8kcm/kZdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=deK4Rgqawx5cHUzN2bsZFRG8nno6wBLJWdsTMWtz1+lfYdXp+e+DKfYlMnHiOVIpX8RgLeHGYNz0ghn+0+SKqvdGnxbEwxcOUQrFkoaaMv1W2jcKZO7Q2Qv7Bx3DHqjgYVsYJPE7/5frJ598YJoKw0fNTEgQLRqKU9PGHxZ/2gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S+rTj6WI; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ee6e9e36-999a-42ab-80de-2ff4c4df3ae3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715094007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7F0zXFjGnIAReIrIEeVFWuD6Utz0jQNZcSyrYMCpOT4=;
	b=S+rTj6WIgX4WHCUV1seGXxdSXO2OiTDQLvWIvBSzFAnDvTsuylxqLiSAn8G6o3m9CtP681
	HlqRos8FLKJ7CUsDAVePmdR1t5bg2jsjrteLtjy1N2YlzYZjNqSdh8g56daGHGvkd5ZHUn
	7H/GJYgTkX29ppaMRGOhkxAHZ/BQjPA=
Date: Tue, 7 May 2024 22:59:36 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests: introduce additional eventfd test coverage
To: "Bird, Tim" <Tim.Bird@sony.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: SShuah Khan <shuah@kernel.org>, Andrei Vagin <avagin@google.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>, Dave Young <dyoung@redhat.com>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240505144648.18347-1-wen.yang@linux.dev>
 <SA3PR13MB6372229283A34550FD52F913FD1C2@SA3PR13MB6372.namprd13.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <SA3PR13MB6372229283A34550FD52F913FD1C2@SA3PR13MB6372.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/5/7 02:30, Bird, Tim wrote:
> 
> 
>> -----Original Message-----
>> From: Wen Yang <wen.yang@linux.dev>
>> Add several new test cases which assert corner cases on the eventfd
>> mechanism, for example, the supplied buffer is less than 8 bytes,
>> attempting to write a value that is too large, etc.
>>
>> 	./eventfd_test
>> 	# Starting 9 tests from 1 test cases.
>> 	#  RUN           global.eventfd01 ...
>> 	#            OK  global.eventfd01
>> 	ok 1 global.eventfd01
> 
> These are horrible test case names.  Can you please use strings which indicate
> what is being tested, that are useful to a human?
>   -- Tim
> 

Thank you for the review.
I will do the change and send v2 soon.

--
Best wishes,
Wen

>> 	#  RUN           global.eventfd02 ...
>> 	#            OK  global.eventfd02
>> 	ok 2 global.eventfd02
>> 	#  RUN           global.eventfd03 ...
>> 	#            OK  global.eventfd03
>> 	ok 3 global.eventfd03
>> 	#  RUN           global.eventfd04 ...
>> 	#            OK  global.eventfd04
>> 	ok 4 global.eventfd04
>> 	#  RUN           global.eventfd05 ...
>> 	#            OK  global.eventfd05
>> 	ok 5 global.eventfd05
>> 	#  RUN           global.eventfd06 ...
>> 	#            OK  global.eventfd06
>> 	ok 6 global.eventfd06
>> 	#  RUN           global.eventfd07 ...
>> 	#            OK  global.eventfd07
>> 	ok 7 global.eventfd07
>> 	#  RUN           global.eventfd08 ...
>> 	#            OK  global.eventfd08
>> 	ok 8 global.eventfd08
>> 	#  RUN           global.eventfd09 ...
>> 	#            OK  global.eventfd09
>> 	ok 9 global.eventfd09
>> 	# PASSED: 9 / 9 tests passed.
>> 	# Totals: pass:9 fail:0 xfail:0 xpass:0 skip:0 error:0
>>
>> Signed-off-by: Wen Yang <wen.yang@linux.dev>
>> Cc: SShuah Khan <shuah@kernel.org>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: Andrei Vagin <avagin@google.com>
>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Dave Young <dyoung@redhat.com>
>> Cc: linux-kselftest@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   .../filesystems/eventfd/eventfd_test.c        | 116 ++++++++++++++++++
>>   1 file changed, 116 insertions(+)
>>
>> diff --git a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
>> index f142a137526c..eeab8df5b1b5 100644
>> --- a/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
>> +++ b/tools/testing/selftests/filesystems/eventfd/eventfd_test.c
>> @@ -183,4 +183,120 @@ TEST(eventfd05)
>>   	close(fd);
>>   }
>>
>> +/*
>> + * A write(2) fails with the error EINVAL if the size of the supplied buffer
>> + * is less than 8 bytes, or if an attempt is made to write the value
>> + * 0xffffffffffffffff.
>> + */
>> +TEST(eventfd06)
>> +{
>> +	uint64_t value = 1;
>> +	ssize_t size;
>> +	int fd;
>> +
>> +	fd = sys_eventfd2(0, 0);
>> +	ASSERT_GE(fd, 0);
>> +
>> +	size = write(fd, &value, sizeof(int));
>> +	EXPECT_EQ(size, -1);
>> +	EXPECT_EQ(errno, EINVAL);
>> +
>> +	value = (uint64_t)-1;
>> +	size = write(fd, &value, sizeof(value));
>> +	EXPECT_EQ(size, -1);
>> +	EXPECT_EQ(errno, EINVAL);
>> +
>> +	close(fd);
>> +}
>> +
>> +/*
>> + * A read(2) fails with the error EINVAL if the size of the supplied buffer is
>> + * less than 8 bytes.
>> + */
>> +TEST(eventfd07)
>> +{
>> +	int value = 0;
>> +	ssize_t size;
>> +	int fd;
>> +
>> +	fd = sys_eventfd2(0, 0);
>> +	ASSERT_GE(fd, 0);
>> +
>> +	size = write(fd, &value, sizeof(value));
>> +	EXPECT_EQ(size, -1);
>> +	EXPECT_EQ(errno, EINVAL);
>> +
>> +	close(fd);
>> +}
>> +
>> +/*
>> + * If EFD_SEMAPHORE was not specified and the eventfd counter has a nonzero
>> + * value, then a read(2) returns 8 bytes containing that value, and the
>> + * counter's value is reset to zero.
>> + * If the eventfd counter is zero at the time of the call to read(2), then the
>> + * call fails with the error EAGAIN if the file descriptor has been made nonblocking.
>> + */
>> +TEST(eventfd08)
>> +{
>> +	uint64_t value;
>> +	ssize_t size;
>> +	int fd;
>> +	int i;
>> +
>> +	fd = sys_eventfd2(0, EFD_NONBLOCK);
>> +	ASSERT_GE(fd, 0);
>> +
>> +	value = 1;
>> +	for (i = 0; i < 10000000; i++) {
>> +		size = write(fd, &value, sizeof(value));
>> +		EXPECT_EQ(size, sizeof(value));
>> +	}
>> +
>> +	size = read(fd, &value, sizeof(value));
>> +	EXPECT_EQ(size, sizeof(uint64_t));
>> +	EXPECT_EQ(value, 10000000);
>> +
>> +	size = read(fd, &value, sizeof(value));
>> +	EXPECT_EQ(size, -1);
>> +	EXPECT_EQ(errno, EAGAIN);
>> +
>> +	close(fd);
>> +}
>> +
>> +/*
>> + * If EFD_SEMAPHORE was specified and the eventfd counter has a nonzero value,
>> + * then a read(2) returns 8 bytes containing the value 1, and the counter's
>> + * value is decremented by 1.
>> + * If the eventfd counter is zero at the time of the call to read(2), then the
>> + * call fails with the error EAGAIN if the file descriptor has been made nonblocking.
>> + */
>> +TEST(eventfd09)
>> +{
>> +	uint64_t value;
>> +	ssize_t size;
>> +	int fd;
>> +	int i;
>> +
>> +	fd = sys_eventfd2(0, EFD_SEMAPHORE|EFD_NONBLOCK);
>> +	ASSERT_GE(fd, 0);
>> +
>> +	value = 1;
>> +	for (i = 0; i < 10000000; i++) {
>> +		size = write(fd, &value, sizeof(value));
>> +		EXPECT_EQ(size, sizeof(value));
>> +	}
>> +
>> +	for (i = 0; i < 10000000; i++) {
>> +		size = read(fd, &value, sizeof(value));
>> +		EXPECT_EQ(size, sizeof(value));
>> +		EXPECT_EQ(value, 1);
>> +	}
>> +
>> +	size = read(fd, &value, sizeof(value));
>> +	EXPECT_EQ(size, -1);
>> +	EXPECT_EQ(errno, EAGAIN);
>> +
>> +	close(fd);
>> +}
>> +
>>   TEST_HARNESS_MAIN
>> --
>> 2.25.1
>>
> 

