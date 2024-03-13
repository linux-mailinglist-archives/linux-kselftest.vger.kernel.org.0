Return-Path: <linux-kselftest+bounces-6303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2FC87B0E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 20:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0443B290BBC
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 19:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222936A8CD;
	Wed, 13 Mar 2024 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HF+a7X5l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2886A8BA;
	Wed, 13 Mar 2024 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710353555; cv=none; b=RRdnioLwxn6sQhhQ74Xn+ODthZSz0CtipgYIWMqE0M8Rf6kk6IFb15PFfYPheJyHfSpklhdTiyHUdu+8s14wORmibI/BQqOl/zna/81rOj5nMuVjjS4YIPqdYxDCst2Sq/Gc0G2ZGIcnQBE8UKHRpLJQiwmzssfCWYjbpwvFEdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710353555; c=relaxed/simple;
	bh=msE+LoodrnJuR41WimKwSvVNdBUojEMdM6lEeYgLaLE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NAO8G6ZEzWGhxfE0UcJVxmiZTU6QJ212g2/2mhnhTvD0e1wb5yoxFVcsE1HlLm9sSPET3dbg4b81HjP1yPJFnWHZDNdnIZNpp1Cf2zeiF72KX4A/dJxgSC6j9wIUUCKlPn3tErJ3aqqSDuoNuCrN4FtgEnaJt74QYH39qKrPkw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HF+a7X5l; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710353551;
	bh=msE+LoodrnJuR41WimKwSvVNdBUojEMdM6lEeYgLaLE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=HF+a7X5lXjnxaIDWE/8k8QRhMGELdabzRPU9htidGUlZ/EkTMOnUa2qc40ZRT3e5v
	 PXC1jq4Zty8ILQfh1SXwhw9ef53eHANm63bltn1VsnnJpWbj8AimTd/hTRX+MehWL2
	 N5VuZOLXcOb7nlGDoKOCTYK5UYa8sSeN1Yb/JVAn25GMy91aMtu5Ay5EUZEovc3Wy6
	 ERV6xwp0yoPWRhiCe3z7nbem9T2YSM+9Ho6xace7PVCBt6ttEEtMxKRlR2dpoVStrY
	 sBFyGkwe2sSDtEai0T0RRdfJz9fgPUO1+dBd0mnz6dvvAJ5RmoCcifOM4/05w3lRTq
	 To+iwhhdmvJxg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3126537802F2;
	Wed, 13 Mar 2024 18:12:26 +0000 (UTC)
Message-ID: <b7fb0e92-f74b-4e12-9eaa-0427901c2be5@collabora.com>
Date: Wed, 13 Mar 2024 23:12:58 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 kernel@collabora.com, Ryan Roberts <ryan.roberts@arm.com>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] selftests/mm: protection_keys: save/restore
 nr_hugepages settings
To: Joey Gouly <joey.gouly@arm.com>
References: <20240125154608.720072-1-usama.anjum@collabora.com>
 <20240125154608.720072-5-usama.anjum@collabora.com>
 <20240313145811.GA2896554@e124191.cambridge.arm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240313145811.GA2896554@e124191.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/24 7:58 PM, Joey Gouly wrote:
> Hi Muhammad,
> 
> On Thu, Jan 25, 2024 at 08:46:07PM +0500, Muhammad Usama Anjum wrote:
>> Save and restore nr_hugepages before changing it during the test. A test
>> should not change system wide settings.
>>
>> Fixes: 5f23f6d082a9 ("x86/pkeys: Add self-tests")
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  tools/testing/selftests/mm/protection_keys.c | 34 ++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>>
>> diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
>> index 48dc151f8fca8..f822ae31af22e 100644
>> --- a/tools/testing/selftests/mm/protection_keys.c
>> +++ b/tools/testing/selftests/mm/protection_keys.c
>> @@ -54,6 +54,7 @@ int test_nr;
>>  u64 shadow_pkey_reg;
>>  int dprint_in_signal;
>>  char dprint_in_signal_buffer[DPRINT_IN_SIGNAL_BUF_SIZE];
>> +char buf[256];
>>  
>>  void cat_into_file(char *str, char *file)
>>  {
>> @@ -1744,6 +1745,38 @@ void pkey_setup_shadow(void)
>>  	shadow_pkey_reg = __read_pkey_reg();
>>  }
>>  
>> +void restore_settings_atexit(void)
>> +{
>> +	cat_into_file(buf, "/proc/sys/vm/nr_hugepages");
>> +}
>> +
>> +void save_settings(void)
>> +{
>> +	int fd;
>> +	int err;
>> +
>> +	if (geteuid())
>> +		return;
>> +
>> +	fd = open("/proc/sys/vm/nr_hugepages", O_RDONLY);
>> +	if (fd < 0) {
>> +		fprintf(stderr, "error opening\n");
>> +		perror("error: ");
>> +		exit(__LINE__);
>> +	}
>> +
>> +	/* -1 to guarantee leaving the trailing \0 */
>> +	err = read(fd, buf, sizeof(buf)-1);
>> +	if (err < 0) {
>> +		fprintf(stderr, "error reading\n");
>> +		perror("error: ");
>> +		exit(__LINE__);
>> +	}
>> +
>> +	atexit(restore_settings_atexit);
>> +	close(fd);
>> +}
>> +
>>  int main(void)
>>  {
>>  	int nr_iterations = 22;
>> @@ -1751,6 +1784,7 @@ int main(void)
>>  
>>  	srand((unsigned int)time(NULL));
>>  
>> +	save_settings();
>>  	setup_handlers();
>>  
>>  	printf("has pkeys: %d\n", pkeys_supported);
>> -- 
>> 2.42.0
>>
> 
> This break the tests for me:
> 
> assert() at protection_keys.c::812 test_nr: 19 iteration: 1
> running abort_hooks()...
> 
> This is because some of the tests fork, so on their atexit() they will set the
> nr_hugepages back to the previous setting. Specifically the
> test_pkey_alloc_exhaust() test.
Thank you for reporting. Please can you test the following patch:

--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -1745,9 +1745,12 @@ void pkey_setup_shadow(void)
 	shadow_pkey_reg = __read_pkey_reg();
 }

+pid_t parent_pid;
+
 void restore_settings_atexit(void)
 {
-	cat_into_file(buf, "/proc/sys/vm/nr_hugepages");
+	if (parent_pid == getpid())
+		cat_into_file(buf, "/proc/sys/vm/nr_hugepages");
 }

 void save_settings(void)
@@ -1773,6 +1776,7 @@ void save_settings(void)
 		exit(__LINE__);
 	}

+	parent_pid = getpid();
 	atexit(restore_settings_atexit);
 	close(fd);
 }


> 
> Thanks,
> Joey
> 

-- 
BR,
Muhammad Usama Anjum

