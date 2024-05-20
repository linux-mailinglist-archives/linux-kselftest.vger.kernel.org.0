Return-Path: <linux-kselftest+bounces-10418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC948C98CA
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 07:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9143C28207D
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 05:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170BDD52F;
	Mon, 20 May 2024 05:33:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30774A33;
	Mon, 20 May 2024 05:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716183227; cv=none; b=GjxvFdhNaiXWQqDEzXqP2GmlyFLiTlcYQCxMGMt3VZOKeu0My5pSR8UFeqRtJ0hPqB0ilgOP7CCn1bnsVn1srCGJe/PNzrGGf/Kx3zVGjht65dhjV5H7OlQ1hDT9WDQR8ymomrnawYDh7+Pw6er6KtHiME77LdWZNGXUli2sqPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716183227; c=relaxed/simple;
	bh=IsM10BpPphUwdEvI3pBk/i9Z2dn7vmXffsVb7eqnyYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvwzHw3AccVYmBsCFGZd3KlF1Df3DEASgGjOoGTwf0937UV0ITDxs0qWr1SNf/BdaOAi2bSy1ErwhW8E9mfh0Rnm+cg90h7R6gwHHxG5BxdGfstBZwqu0bPxwIcQpsmEV8earHUqtUQSmowB5ZFZ2AridXjb2yI36p45Kb3wEjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02867FEC;
	Sun, 19 May 2024 22:34:08 -0700 (PDT)
Received: from [10.162.40.20] (e116581.arm.com [10.162.40.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52C203F641;
	Sun, 19 May 2024 22:33:41 -0700 (PDT)
Message-ID: <4bef9468-a403-4bb5-940d-aacb611f28d1@arm.com>
Date: Mon, 20 May 2024 11:03:38 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/mm: compaction_test: Fix trivial test
 success and reduce probability of OOM-killer invocation
To: Andrew Morton <akpm@linux-foundation.org>
Cc: shuah@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Anshuman.Khandual@arm.com,
 sjayaram@akamai.com, stable@vger.kernel.org
References: <20240515093633.54814-1-dev.jain@arm.com>
 <20240515093633.54814-3-dev.jain@arm.com>
 <20240519170357.757d30aac192c686f10d709c@linux-foundation.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20240519170357.757d30aac192c686f10d709c@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/20/24 05:33, Andrew Morton wrote:
> On Wed, 15 May 2024 15:06:33 +0530 Dev Jain <dev.jain@arm.com> wrote:
>
>> Reset nr_hugepages to zero before the start of the test.
>>
>> If a non-zero number of hugepages is already set before the start of the
>> test, the following problems arise:
>>
>>   - The probability of the test getting OOM-killed increases.
>> Proof: The test wants to run on 80% of available memory to prevent
>> OOM-killing (see original code comments). Let the value of mem_free at the
>> start of the test, when nr_hugepages = 0, be x. In the other case, when
>> nr_hugepages > 0, let the memory consumed by hugepages be y. In the former
>> case, the test operates on 0.8 * x of memory. In the latter, the test
>> operates on 0.8 * (x - y) of memory, with y already filled, hence, memory
>> consumed is y + 0.8 * (x - y) = 0.8 * x + 0.2 * y > 0.8 * x. Q.E.D
>>
>>   - The probability of a bogus test success increases.
>> Proof: Let the memory consumed by hugepages be greater than 25% of x,
>> with x and y defined as above. The definition of compaction_index is
>> c_index = (x - y)/z where z is the memory consumed by hugepages after
>> trying to increase them again. In check_compaction(), we set the number
>> of hugepages to zero, and then increase them back; the probability that
>> they will be set back to consume at least y amount of memory again is
>> very high (since there is not much delay between the two attempts of
>> changing nr_hugepages). Hence, z >= y > (x/4) (by the 25% assumption).
>> Therefore,
>> c_index = (x - y)/z <= (x - y)/y = x/y - 1 < 4 - 1 = 3
>> hence, c_index can always be forced to be less than 3, thereby the test
>> succeeding always. Q.E.D
>>
>> NOTE: This patch depends on the previous one.
>>
>> -int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
>> +int check_compaction(unsigned long mem_free, unsigned int hugepage_size,
>> +		     int initial_nr_hugepages)
>>   {
>>   	int fd, ret = -1;
>>   	int compaction_index = 0;
>> -	char initial_nr_hugepages[10] = {0};
>>   	char nr_hugepages[10] = {0};
>> +	char init_nr_hugepages[10] = {0};
>> +
>> +	sprintf(init_nr_hugepages, "%d", initial_nr_hugepages);
> Well, [10] isn't really large enough.  "-1111111111" requires 12 chars,
> with the trailing \0.  And I'd suggest an unsigned type and a %u -
> negative initial_nr_hugepages doesn't make a lot of sense.
>
>>   
>> +int set_zero_hugepages(int *initial_nr_hugepages)
>> +{
>> +	int fd, ret = -1;
>> +	char nr_hugepages[10] = {0};
> Ditto?


Sure, makes sense. I'll just change that to 20 and make it unsigned.

>
>> +	fd = open("/proc/sys/vm/nr_hugepages", O_RDWR | O_NONBLOCK);
>> +	if (fd < 0) {
>> +		ksft_print_msg("Failed to open /proc/sys/vm/nr_hugepages: %s\n",
>> +			       strerror(errno));
>> +		goto out;
>> +	}
>> +
>> +	if (read(fd, nr_hugepages, sizeof(nr_hugepages)) <= 0) {
>> +		ksft_print_msg("Failed to read from /proc/sys/vm/nr_hugepages: %s\n",
>> +			       strerror(errno));
>> +		goto close_fd;
>> +	}
>> +
>> +	lseek(fd, 0, SEEK_SET);
>> +
>> +	/* Start with the initial condition of 0 huge pages */
>> +	if (write(fd, "0", sizeof(char)) != sizeof(char)) {
>> +		ksft_print_msg("Failed to write 0 to /proc/sys/vm/nr_hugepages: %s\n",
>> +			       strerror(errno));
>> +		goto close_fd;
>> +	}
>> +
>> +	*initial_nr_hugepages = atoi(nr_hugepages);
>> +	ret = 0;
>> +
>> + close_fd:
>> +	close(fd);
>> +
>> + out:
>> +	return ret;
>> +}

