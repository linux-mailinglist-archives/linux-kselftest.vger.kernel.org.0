Return-Path: <linux-kselftest+bounces-25503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 295ADA24788
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 08:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E1118891AC
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 07:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E609881749;
	Sat,  1 Feb 2025 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="fkMhyP05"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0246FAD2C;
	Sat,  1 Feb 2025 07:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738395139; cv=pass; b=lskdhjJ4hAeMpPSYoHAmJ4RbBJmpG7Ye++ycypT0zJIR4ao8AfTah4w+S9SBjMJbWoRwHIq+BdUgrBchGAzNwlFuzxFb4rVvbBtbWSCJPLaj8Fw+Zhgtp6gY0eSUlbPxwIVH8oqP3GAN2OjgZDhx8CilDkKRdcR1VgibZuXiYA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738395139; c=relaxed/simple;
	bh=BLhU4dUqbMNxZMOW/Iq+cOvSPA/jfm2hzzXIf+YVFO4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qYMRXWcQ12G9yuBI3JaZcSCdppN62kKoYDx3ve+XlOmJnnvg6bL1lgXoekTX764I6oWi5LiVbcbZyaFnpWURg6BnFGwv5ENafANsfN6GkWpEcODwNgMyNYe8EKAzjYjnsIIUhHn1fulH0B4gzw3KJUL+qvWN1aB+dXTpLHMm7GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=fkMhyP05; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1738395113; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Rfe9ZSjSkKPaFz/t1ESMbVqwfIOHPKTA8PHTBdoX2/DSOf+QqWzIlt9ns9BM9lLkeMKSSO6J8u28u0f+zy1mzKXUV0K1J0rFhTLFO77qAhVv/bKhVXxXkgWxBQSEzePKf0nEfXL898Y3fV/QsSkqXiSg39TghdffAHcjewYBSOk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738395113; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yPIDVcDWLvCXO6qjUDSCw6w2/zuz4gmUpH3iRUBTW9Q=; 
	b=XQ6/6DNOKlLnCf3mv8FDGhbcpBTgpdZT5ae7GHbkglsTTjNlfwPCYbauZL15W1sWiJAvYjTxic7fLOZGd4CBdywXhA97TCHI6uU9L/zUUfZStUfAir0Fs3eRSyGcI//p52ZRUfIvJsaWfCJm8rinGbVU4OgQPLSqOZdPm98CyPU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738395113;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=yPIDVcDWLvCXO6qjUDSCw6w2/zuz4gmUpH3iRUBTW9Q=;
	b=fkMhyP05nlECwp+8afA6ZdCnXRBEGqqOatHDveQW33cEN62Ivjo0lPQaOD66Fj7R
	dTRof9zsUg1tbDv+sU8BRWAsZpVXVSjpsf3kOL/7NfC3LWLNjOnECJvchoCHtYIHFlN
	loWAzalLSyl4C0nZ3tTxrZUzDiQd6IUpAmaA6Q8Q=
Received: by mx.zohomail.com with SMTPS id 1738395109031628.7086343806136;
	Fri, 31 Jan 2025 23:31:49 -0800 (PST)
Message-ID: <1175024c-6ef7-4557-95ca-180dd0a3dd5b@collabora.com>
Date: Sat, 1 Feb 2025 12:32:20 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, Kees Cook <kees@kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel@collabora.com
Subject: Re: [PATCH 01/16] selftests/mm: remove argc and argv unused
 parameters
To: David Laight <david.laight.linux@gmail.com>
References: <20250109173842.1142376-1-usama.anjum@collabora.com>
 <20250109173842.1142376-2-usama.anjum@collabora.com>
 <20250110190057.2294fd5a@pumpkin>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20250110190057.2294fd5a@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 1/11/25 12:00 AM, David Laight wrote:
> On Thu,  9 Jan 2025 22:38:27 +0500
> Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:
> 
>> Remove the following warnings by removing unused argc and argv
>> parameters:
>> In function ‘main’:
>>   warning: unused parameter ‘argc’ [-Wunused-parameter]
>>     158 | int main(int argc, char *argv[])
>>         |          ~~~~^~~~
>>   warning: unused parameter ‘argv’ [-Wunused-parameter]
>>     158 | int main(int argc, char *argv[])
> ...
>> diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
>> index 2c3a0eb6b22d3..8d23b698ce9db 100644
>> --- a/tools/testing/selftests/mm/compaction_test.c
>> +++ b/tools/testing/selftests/mm/compaction_test.c
>> @@ -194,7 +194,7 @@ int set_zero_hugepages(unsigned long *initial_nr_hugepages)
>>  	return ret;
>>  }
>>  
>> -int main(int argc, char **argv)
>> +int main(void)
> 
> Doesn't that generate a different warning because main() is a special function
> and gcc knows the arguments it should have.
No, we still get unused argument warning. 

> 
> Just disable -Wunused-parameter - there are far too many places where it produces
> unwanted warnings.
The purpose is to run static analyzer and find obvious errors to enhance quality of
the code which is only possible if we start using these compiler flags. This is just
my thinking.

Feel free to share your thoughts?

-- 
BR,
Muhammad Usama Anjum

