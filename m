Return-Path: <linux-kselftest+bounces-18015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F68979AA5
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 07:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D4A1F215BD
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 05:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0E31F61C;
	Mon, 16 Sep 2024 05:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="F+27Yvno"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8296FDC;
	Mon, 16 Sep 2024 05:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726463506; cv=pass; b=lCSXcSdYJUQRxt1IOYaSWt87nK379nATnxyCDnb0SGAPY/E9T588+R21v93nYg5foQitcGgSJz0neH6szuLPUvUJfVn3q1Vt1NpgZpjMWWIAg41lgTOUWf2h/YecvvJIFlEEsYZu+pA6NyKx163HDAkSppdIzx3sd6/xc6Qb4RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726463506; c=relaxed/simple;
	bh=JXtRfIu5OcEA9kgFjsMrRK/elxa5CFF6iRmJv8pi3I4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CKxz/Zr+n4ObikMiJ0yaQ/zH+4YmR8N361nNLABGzrGnEA2PA6aJSaIsfGOzlIT6Y4swJ9Rqw1IyLlTEsv+5dQcp2o+qNgF0DxYk5KL4DP9tElaZJAbgbj3tEArgQP3m+hUiya7+oU5QtbzwuGuTz4gY7eNg3vdbBZxvhQBpQ4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=F+27Yvno; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726463488; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kwggkEmqLX6Mfr7HygJA+b/VB1IVl/+GGxQ6NewS4pNwJQfJJPZHSJC1Brpegyu6EotB1FwseDlPIm+6ZJsL279Qtrvqvd6qFxPKmlpjN2LOwCXnKwKhn15hBOmXN1jEtm1vxmcVE3QHUZLR3NpXEsoHB54XeImjGvaS0PDey1Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726463488; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fiQmj+mg8bdz3LaM2MFQ1wsitBjBxISWyvNuEMIjyb8=; 
	b=DEVN37ppZUptSjjd62+W82sZ1aykTgPENQNnsMnM7OT6S2HczvX7va+vYlprR+Vtn1dcLI7N9PkPrUWmAtoOrT224DIaM2xdabXrp5SJZrC5NnZIc3XRikECzy5hCu49oRk7TGzH3+ZmRzn/5oGFbOKoQYV8XCzRpiBdPBuUsc4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726463488;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=fiQmj+mg8bdz3LaM2MFQ1wsitBjBxISWyvNuEMIjyb8=;
	b=F+27YvnoFfhS8+LKAGj8b2uDd3XSSkH3ITGIZxWb20cWNcUlRRSUQmxE/HeJaaSv
	G11BOFu2zhhjSsuKo726Hv9Ch1doS4cZMUdXNcWXJetVAhRdP+5VoOn1k8thcBR1pCR
	eRDRMVeCRp1jqiBvczy4z4xX0QTtyMG3Hnbjz0K0=
Received: by mx.zohomail.com with SMTPS id 1726463487032102.77484826415719;
	Sun, 15 Sep 2024 22:11:27 -0700 (PDT)
Message-ID: <406c2919-a546-40e4-89af-baa910c22740@collabora.com>
Date: Mon, 16 Sep 2024 10:11:18 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, kernel@collabora.com,
 stable@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: mm: Fix build errors on armhf
To: Jeff Xu <jeffxu@chromium.org>
References: <20240809082511.497266-1-usama.anjum@collabora.com>
 <CABi2SkWgPoWJY_CMxDru7FPjtQBgv61PA2VoCumd3T8Xq3fjbg@mail.gmail.com>
 <1b36ba43-60a4-441c-981f-9b62f366aa95@collabora.com>
 <CABi2SkWk8igT=HCTcawv72uxrf2rhzj1A23k4EixCxcDKhSNxw@mail.gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <CABi2SkWk8igT=HCTcawv72uxrf2rhzj1A23k4EixCxcDKhSNxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 9/14/24 3:33 AM, Jeff Xu wrote:
> On Mon, Aug 19, 2024 at 3:05 AM Muhammad Usama Anjum
> <Usama.Anjum@collabora.com> wrote:
>>
>> On 8/14/24 3:29 AM, Jeff Xu wrote:
>>> Hi Muhammad
>>>
>>> On Fri, Aug 9, 2024 at 1:25 AM Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:
>>>>
>>>> The __NR_mmap isn't found on armhf. The mmap() is commonly available
> 
> What is armhf ?
> is that arm64 ? I was able to build arm64 correctly.
It is arm architecture. Use following toolchain with it:
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-

Please test your patches on it.

> 
> -Jeff
> 
>>>> system call and its wrapper is presnet on all architectures. So it
>>>> should be used directly. It solves problem for armhf and doesn't create
>>>> problem for architectures as well. Remove sys_mmap() functions as they
>>>> aren't doing anything else other than calling mmap(). There is no need
>>>> to set errno = 0 manually as glibc always resets it.
>>>>
>>> The mseal_test should't have dependency on libc, and mmap() is
>>> implemented by glibc, right ?
>>>
>>> I just fixed a bug to switch mremap() to sys_mremap to address an
>>> issue that different glibc version's behavior is slightly different
>>> for mremap().
>>>
>>> What is the reason that __NR_mmap not available in armhf ? (maybe it
>>> is another name ?)  there must be a way to call syscall directly on
>>> armhf, can we use that instead ?
>>
>> It seems __NR_mmap syscall is deprecated for arm. Found this comment in
>> arch/arm/include/asm/unistd.h:
>> /*
>>  * The following syscalls are obsolete and no longer available for EABI:
>>  *  __NR_time
>>  *  __NR_umount
>>  *  __NR_stime
>>  *  __NR_alarm
>>  *  __NR_utime
>>  *  __NR_getrlimit
>>  *  __NR_select
>>  *  __NR_readdir
>>  *  __NR_mmap
>>  *  __NR_socketcall
>>  *  __NR_syscall
>>  *  __NR_ipc
>>  */
>>
>> The glibc mmap() calls mmap2() these days by adjusting the parameters
>> internally. From man mmap:
>> C library/kernel differences:
>> This  page  describes the interface provided by the glibc mmap() wrapper
>> function.  Originally, this function invoked a system call of the same
>> name.  Since Linux 2.4, that system call has been superseded  by
>> mmap2(2), and nowadays the glibc mmap() wrapper function invokes
>> mmap2(2) with a suitably adjusted value for offset.
>>
>> I'm not sure if behaviour of glibc mmap() and syscall mmap2() would be
>> same, but we should use glibc at most places which accounts for
>> different architectures correctly. Maybe the differences were only
>> present in case of mremap().
>>
>> --
>> BR,
>> Muhammad Usama Anjum
>>

-- 
BR,
Muhammad Usama Anjum


