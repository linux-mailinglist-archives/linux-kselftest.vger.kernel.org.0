Return-Path: <linux-kselftest+bounces-15632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E969567C9
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 12:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C5E1C21770
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 10:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CE115CD61;
	Mon, 19 Aug 2024 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="QFQNtX6z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCC7148FE0;
	Mon, 19 Aug 2024 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061937; cv=pass; b=sORd3vXR1cAmt4S7MiowD6cIKtOSAE7NzrXwyX334WTgNcZvkpMQwopSwnVasyX5zCDTjNbJWl56rxmvG6JHHRoKampnACY6U/z2AV9kK0MJsyUVvW5WanV+TDHUVbQOkasCx7+2KWhC6F8HsJL01ykb8bAsPVOLXupBikbLbkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061937; c=relaxed/simple;
	bh=Hh8QfZgSepyCVNdlw8p6+aGPEFGsy6XYRFHLeqgAijE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JEVE1Qh32Jt6bvOLcRYE2wd9h7sM/k8EU+iWwLyn+QIoP5yhmrjSymRJ95cgm2SkUJXjXv07SFGVYMcxBMM8Imxe84fZBq12o9pi70x/X2Fn2fp8kdVWGnt+hQHCu6z/JTz0M/U+Z1RGx/7nuSaBjkLhUk4dh97k6T9HBVBj38Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=QFQNtX6z; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: Usama.Anjum@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724061921; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MXOhc7NLEDPDr/iPpz6LDk+OKmaWGNi608mPfY3+G8aMooSY4q1YtJlBkTErvALqkiJB36Evfe3+xm5KMlBjUUTuMEaHw+dfpepIghc9za9DvnI0Bz/4DR0dTATzX5UTsxCgz2VFiQLOJnehAK/RryheLGuF5psEDjud0LbaY3Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724061921; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=clWg1cFDvmBXHk5ECX33rfzkJ2REgKM2jV0tZFYmIeQ=; 
	b=PUlR2JI/qzO2k81FjM2m5k5QxwrKZ9omUh/3J+0lC+Mwx+1OiPktwnoi1g3JtYdyFWX9oOnQD8nsBzUJAbXP1ISIWPuDsikRTqIadvYWwWh6t5DXjEmxY7eZsymgSCKZh3NSJWTK5fBD3zLLV0hqpKLAguhZThbpmBtLJjRu0Dk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724061921;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=clWg1cFDvmBXHk5ECX33rfzkJ2REgKM2jV0tZFYmIeQ=;
	b=QFQNtX6zd8MeGg+ZTXgH2wzzY9xNeJKd5YubWcapTV7m5lk9rX13WKKixaCfjLPY
	xVrvQjc0GOdi0gTl0msRIJwR5ePxQKYjV/6x1rlG+eya7C4oUl3s2ItFgMYLiZXHrkI
	eLBRGE4NmrGShGj6+dhZv88676r6cOD0rW38Oasw=
Received: by mx.zohomail.com with SMTPS id 1724061920204590.2573152825611;
	Mon, 19 Aug 2024 03:05:20 -0700 (PDT)
Message-ID: <1b36ba43-60a4-441c-981f-9b62f366aa95@collabora.com>
Date: Mon, 19 Aug 2024 15:05:07 +0500
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
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <CABi2SkWgPoWJY_CMxDru7FPjtQBgv61PA2VoCumd3T8Xq3fjbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 8/14/24 3:29 AM, Jeff Xu wrote:
> Hi Muhammad
> 
> On Fri, Aug 9, 2024 at 1:25 AM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> The __NR_mmap isn't found on armhf. The mmap() is commonly available
>> system call and its wrapper is presnet on all architectures. So it
>> should be used directly. It solves problem for armhf and doesn't create
>> problem for architectures as well. Remove sys_mmap() functions as they
>> aren't doing anything else other than calling mmap(). There is no need
>> to set errno = 0 manually as glibc always resets it.
>>
> The mseal_test should't have dependency on libc, and mmap() is
> implemented by glibc, right ?
> 
> I just fixed a bug to switch mremap() to sys_mremap to address an
> issue that different glibc version's behavior is slightly different
> for mremap().
> 
> What is the reason that __NR_mmap not available in armhf ? (maybe it
> is another name ?)  there must be a way to call syscall directly on
> armhf, can we use that instead ?

It seems __NR_mmap syscall is deprecated for arm. Found this comment in
arch/arm/include/asm/unistd.h:
/*
 * The following syscalls are obsolete and no longer available for EABI:
 *  __NR_time
 *  __NR_umount
 *  __NR_stime
 *  __NR_alarm
 *  __NR_utime
 *  __NR_getrlimit
 *  __NR_select
 *  __NR_readdir
 *  __NR_mmap
 *  __NR_socketcall
 *  __NR_syscall
 *  __NR_ipc
 */

The glibc mmap() calls mmap2() these days by adjusting the parameters
internally. From man mmap:
C library/kernel differences:
This  page  describes the interface provided by the glibc mmap() wrapper
function.  Originally, this function invoked a system call of the same
name.  Since Linux 2.4, that system call has been superseded  by
mmap2(2), and nowadays the glibc mmap() wrapper function invokes
mmap2(2) with a suitably adjusted value for offset.

I'm not sure if behaviour of glibc mmap() and syscall mmap2() would be
same, but we should use glibc at most places which accounts for
different architectures correctly. Maybe the differences were only
present in case of mremap().

-- 
BR,
Muhammad Usama Anjum


