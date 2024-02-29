Return-Path: <linux-kselftest+bounces-5611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA88286C477
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 10:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085F21C20F44
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 09:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB4956B7E;
	Thu, 29 Feb 2024 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AG8U9TRY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BA85476B;
	Thu, 29 Feb 2024 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709197440; cv=none; b=tLkKZjIYdPMpSS6SbE1I2mEY0sZ6Ng+2XHpXNUSWjwzNk97O8cj3zpviLbKnvLM3iAaJEn7r3mtoNPa1jI87+h59v2rK76KExQm6hKkACCTVrzLaKpoZYFuDu0yqpHiqhqBo6AOKbkB5eW3EbrxmyYqXDgTgqiOW/lxSSU5KdKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709197440; c=relaxed/simple;
	bh=ZEO3zUtsmtIZ7QThUIN+s0UTwuRy+h14LUFXyZi7GHI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=noc9kcVhQdd1GZyPci45UKmLpz+tZr6ds1O21LasY2XnnPh3+2wyHCK7p/w4noZS1OLO6pNVwo8xLsA4ce4GThMAg6zzXiaJqwkEAoyIhHqXzPKVHy3MeRBvs9yIyaiWDOqN4lRKyCPr03f26nfNdbIrvdHvuEzSgCWffT7FBwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AG8U9TRY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709197437;
	bh=ZEO3zUtsmtIZ7QThUIN+s0UTwuRy+h14LUFXyZi7GHI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=AG8U9TRYIWy29Qq7Vr/pz5Uf3we0Ltt6+yZKVukqq1b19waMXtUdJ2y4n2r84RXxg
	 bILax/S/OgW1Rxuod9QLejMLL51Ui6uN8M1Ry3576HqYMnkN5KAIJGAVbMhbDGKtrb
	 VdnR8l+rvH/T4LyyGUJ0Io5ZIPeurvdjMrsy7LWu38CLLBiXFuaQqNWI9B4YKsQkGB
	 LYaRALvbugCsA5ux4tnkQJi9CU8601XQMHlGbdagwjHiLBOuV23aF/Aj862ZaiPt3G
	 1iU7qVc3w9T4ZmP6JItNEEZwxPbES7hNAgvJYgh9JkOaHAAz6VCLc/cEIFYgylIjzl
	 XA57wgNhJkHMQ==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 78C4537820DD;
	Thu, 29 Feb 2024 09:03:54 +0000 (UTC)
Message-ID: <5843852d-7353-40ec-b36d-7d2502fc6a83@collabora.com>
Date: Thu, 29 Feb 2024 14:04:19 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] selftests/dmabuf-heap: conform test to TAP format
 output
To: "T.J. Mercier" <tjmercier@google.com>
References: <20240227121920.1905095-1-usama.anjum@collabora.com>
 <CABdmKX39M6e7o_Ossyy_Yg-CYQd-7piT6DmJk8ffEU9pPpP-8Q@mail.gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABdmKX39M6e7o_Ossyy_Yg-CYQd-7piT6DmJk8ffEU9pPpP-8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/28/24 11:51 PM, T.J. Mercier wrote:
> On Tue, Feb 27, 2024 at 4:21 AM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
> 
> ..
> 
>> +static int numer_of_heaps(void)
>> +{
>> +       DIR *d = opendir(DEVPATH);
>> +       struct dirent *dir;
>> +       int heaps = 0;
>> +
>> +       while ((dir = readdir(d))) {
>> +               if (!strncmp(dir->d_name, ".", 2))
>> +                       continue;
>> +               if (!strncmp(dir->d_name, "..", 3))
>> +                       continue;
>> +               heaps++;
>> +       }
>> +
>> +       return heaps;
>>  }
>>
>>  int main(void)
>>  {
>> -       DIR *d;
>>         struct dirent *dir;
>> -       int ret = -1;
>> +       DIR *d;
>> +
>> +       ksft_print_header();
>>
>>         d = opendir(DEVPATH);
>>         if (!d) {
>> -               printf("No %s directory?\n", DEVPATH);
>> -               return -1;
>> +               ksft_print_msg("No %s directory?\n", DEVPATH);
>> +               return KSFT_SKIP;
>>         }
>>
>> -       while ((dir = readdir(d)) != NULL) {
>> +       ksft_set_plan(9 * numer_of_heaps());
> 
> Shouldn't this be 5 (one for each test_alloc_* below) instead of 9?
This number 9 doesn't represent number of functions. It represents the
number of test-cases. One function may have multiple of these. (Hence this
number is equal to the number of ksft_test_results_*() functions calls).

> 
>> +
>> +       while ((dir = readdir(d))) {
>>                 if (!strncmp(dir->d_name, ".", 2))
>>                         continue;
>>                 if (!strncmp(dir->d_name, "..", 3))
>>                         continue;
>>
>> -               printf("Testing heap: %s\n", dir->d_name);
>> -               printf("=======================================\n");
>> -               ret = test_alloc_and_import(dir->d_name);
>> -               if (ret)
>> -                       break;
>> -
>> -               ret = test_alloc_zeroed(dir->d_name, 4 * 1024);
>> -               if (ret)
>> -                       break;
>> -
>> -               ret = test_alloc_zeroed(dir->d_name, ONE_MEG);
>> -               if (ret)
>> -                       break;
>> -
>> -               ret = test_alloc_compat(dir->d_name);
>> -               if (ret)
>> -                       break;
>> -
>> -               ret = test_alloc_errors(dir->d_name);
>> -               if (ret)
>> -                       break;
>> +               ksft_print_msg("Testing heap: %s\n", dir->d_name);
>> +               ksft_print_msg("=======================================\n");
>> +               test_alloc_and_import(dir->d_name);
>> +               test_alloc_zeroed(dir->d_name, 4 * 1024);
>> +               test_alloc_zeroed(dir->d_name, ONE_MEG);
>> +               test_alloc_compat(dir->d_name);
>> +               test_alloc_errors(dir->d_name);
>>         }
>>         closedir(d);
>>
>> -       return ret;
>> +       ksft_finished();
>>  }
>> --
>> 2.42.0
>>
>>
> 

-- 
BR,
Muhammad Usama Anjum

