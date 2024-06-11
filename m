Return-Path: <linux-kselftest+bounces-11671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5522E9037E0
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 11:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E15B1C234FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 09:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A421D17B40C;
	Tue, 11 Jun 2024 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3n3OzuD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28F21791EF
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718098299; cv=none; b=FtJLa53rfJgQgtm2VPMk4G3mjxPVknrkSMyIVYdkGn8gk5FZgEFq3m9zSg17HVDSNxyLlwa/jdpEflK00ST41VxFUScYmlk54mpiJDcZY0U03W+mVLsjUJ3XnI0vqL59VmvzPqigS6VI3/smwQils1yD9khRncCUQR2Tp6fAi1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718098299; c=relaxed/simple;
	bh=Ynpkxfg4RKiWOD6S5grcQZ3o0u+yCzEua8zeUOqbTdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KE/02UFjss6LvrDdYekfBtCgTAGJfU7p2diDUeyK7qxA9NMsFt+vSknA5UJASZfqlA+FjviXlRSewqGF4Muq6UIJlAVqtCPYIeICnEi/84I0Ed5RJIJPabaNr840b8w8tw4ceNbBNhUmLysb4DXrLaYXoGg8EVQsP39FpJSkeqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A3n3OzuD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718098296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uG737WfG6Tkr1k/786kxDcpDifeb+2U34yvKgaEkzs0=;
	b=A3n3OzuDKDZapPuZWBLhFET9MzWi+6kgofBnS9sOosKoycju/wJhRcadGqcmAw1k4cfq2s
	4nVVac6DDGV0wuA1dfEI10mMXWvcaHGE1GCFOr4C9JCUOL4hu76hPcOrFzMDsJtSGV04M9
	+DSg5O51C7Wy/FdqmyNy5MiDAXWdCDk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-EGajR88hMGevzSp0otSGbA-1; Tue, 11 Jun 2024 05:31:34 -0400
X-MC-Unique: EGajR88hMGevzSp0otSGbA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52c944cf9b5so405752e87.0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 02:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718098293; x=1718703093;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uG737WfG6Tkr1k/786kxDcpDifeb+2U34yvKgaEkzs0=;
        b=Y9bJcXyUXr38xySWr22BQpep/VbgThg/FacxsbJub+bdhKceKkcl9WIMl1hBpPvG56
         51Og6R270Gb6ScWijrMxYE1aDQ3EpXeYjV3lv6xnlbx6TtBAnRiQ+BNmOx8vVHoNJLR/
         YLkFYYddxo6aFA9WukWHG+cSgJHn7nV3/wwB0tGt+RRiKmER/zLsvePpjT1Xymo5Y4CB
         Pq6kw6LPvNxW6azs0IZ2q8qzwBcG6d/pHZWgAicqoWXvfDY25+izrcseRYlJUVsiHJKl
         MdLeX7cfbqtz5kYHJuRRlJb+zTcwG9PpKckzEu7R3d7rnIFrTHUJkFIDlO75jNzeTlVQ
         Kcjw==
X-Forwarded-Encrypted: i=1; AJvYcCX2HpvTRrA0US3FaFoyiuM6k/wk65Cz2lVBvKrAjbUpjkVHog1KtmMBcumRxrNJ5xYnmCuz1YQS/4ysaECGDgnpSUgcnF8OGpSk8Yzq7cpj
X-Gm-Message-State: AOJu0YwnmVe2CFvv5x1RPq3O7kAKApoffMSjSE7QsJGtm5maunWOu/sR
	PqUjQPT+smgk601MgmswlOFYQ3nHHZQRCjtniAIMK95b5l4ZNJ8YX5bhsZeLL8tEyYkCQwH/6Z4
	eaCgrNgvrnqPcFwWkTr2lMqzJwT+5wPZfKvw85OKfm6DcO5ZiKqsW23lEBZT7q0l8/A==
X-Received: by 2002:a05:6512:33ca:b0:52c:9421:2739 with SMTP id 2adb3069b0e04-52c94212a77mr1128627e87.9.1718098292958;
        Tue, 11 Jun 2024 02:31:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwY43q16ah4tKmJLasiEw8hEatDj9bDQW7O57GFFvLqtN/5X7hzHWJoq6L0qvv09aAoMGvgA==
X-Received: by 2002:a05:6512:33ca:b0:52c:9421:2739 with SMTP id 2adb3069b0e04-52c94212a77mr1128603e87.9.1718098292510;
        Tue, 11 Jun 2024 02:31:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c748:ba00:1c00:48ea:7b5a:c12b? (p200300cbc748ba001c0048ea7b5ac12b.dip0.t-ipconnect.de. [2003:cb:c748:ba00:1c00:48ea:7b5a:c12b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2cd247sm175758845e9.40.2024.06.11.02.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 02:31:32 -0700 (PDT)
Message-ID: <6580fccb-cbd8-480b-9405-b6191ae87754@redhat.com>
Date: Tue, 11 Jun 2024 11:31:30 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] cleanups, fixes, and progress towards avoiding "make
 headers"
To: John Hubbard <jhubbard@nvidia.com>, Jeff Xu <jeffxu@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Andrei Vagin <avagin@google.com>, Axel Rasmussen <axelrasmussen@google.com>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>, Rich Felker <dalias@libc.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240608021023.176027-1-jhubbard@nvidia.com>
 <CABi2SkVoNyXLrfU71gnv1qVUAADpUmFXiDoKKPc54MLb5JpB+Q@mail.gmail.com>
 <a8f9d4e2-8a12-4e5d-bd22-9c92955135f4@nvidia.com>
 <CABi2SkU8=tjWhD-e=OdiVr+YeU+BZZLB_vMfkNb-VWpbP2xcng@mail.gmail.com>
 <95005e7c-3705-48c5-8ee2-3d9b0688fcbc@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <95005e7c-3705-48c5-8ee2-3d9b0688fcbc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.06.24 08:25, John Hubbard wrote:
> On 6/10/24 9:45 PM, Jeff Xu wrote:
>> On Mon, Jun 10, 2024 at 9:34 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>> On 6/10/24 9:21 PM, Jeff Xu wrote:
>>>> Hi
>>>>
>>>>
>>>> On Fri, Jun 7, 2024 at 7:10 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>>>>
>>>>> Eventually, once the build succeeds on a sufficiently old distro, the
>>>>> idea is to delete $(KHDR_INCLUDES) from the selftests/mm build, and then
>>>>> after that, from selftests/lib.mk and all of the other selftest builds.
>>>>>
>>>>> For now, this series merely achieves a clean build of selftests/mm on a
>>>>> not-so-old distro: Ubuntu 23.04:
>>>>>
>>>>> 1. Add __NR_mseal.
>>>>>
>>>>> 2. Add fs.h, taken as usual from a snapshot of ./usr/include/linux/fs.h
>>>>> after running "make headers". This is how we have agreed to do this sort
>>>>> of thing, see [1].
>>>>>
>>>> What is the "official" way to build selftests/mm ?
>>>
>>>    From Documentation/dev-tools/kselftest.rst, it is:
>>>
>>>      $ make headers
>>>      $ make -C tools/testing/selftests
>>>
>>>> I tried a few ways, but it never worked, i.e. due to head missing.
>>>
>>> You are correct. Today's rules require "make headers" first. But
>>> I'm working on getting rid of that requirement, because it causes
>>> problems for some people and situations.
>>>
>>> (Even worse is the follow-up rule, in today's documentation,
>>> that tells us to *run* the selftests from within Make! This
>>> is just madness.
>>
>> That is hilarious! :)
> 
> :)
> 
>>
>>>    Because the tests need to run as root in
>>> many cases. And Make will try to rebuild if necessary...thus
>>> filling your tree full of root-owned files...but that's for
>>> another time.)
>>>
>>>>
>>>> 1>
>>>> cd tools/testing/selftests/mm
>>>> make
>>>>
>>>> migration.c:10:10: fatal error: numa.h: No such file or directory
>>>>       10 | #include <numa.h>
>>>>          |          ^~~~~~~~
>>>> compilation terminated.
>>>>
>>>> 2>
>>>> make headers
>>>> make -C tools/testing/selftests
>>>>
>>>> make[1]: Entering directory
>>>> '/usr/local/google/home/jeffxu/mm/tools/testing/selftests/mm'
>>>>      CC       migration
>>>> migration.c:10:10: fatal error: numa.h: No such file or directory
>>>>       10 | #include <numa.h>
>>>>
>>>
>>> Well, actually, for these, one should install libnuma-dev and
>>> numactl (those are Ubuntu package names. Arch Linux would be:
>>> numactl).
>>>
>>> I think. The idea is: use system headers if they are there, and
>>> local kernel tree header files if the items are so new that they
>>> haven't made it to $OLDEST_DISTO_REASONABLE.
>>>
>>> Something like that.
>>>
>> But I don't want to install random packages if possible.
> 
> Well...keep in mind that it's not really random. If a test program
> requires numa.h, it's typically because it also links against libnuma,
> which *must* be supplied by the distro if you want to build. Because
> it doesn't come with the kernel, of course.
> 
> So what you're really saying is that you'd like to build and run
> whatever you can at the moment--the build should soldier on past
> failures as much as possible.
> 
>>
>> Can makefile rule continue to the next target in case of failure though ?
> 
> That could be done, in general. The question is if that's really what
> we want, or should want. Maybe...

In cow.c, we warn if liburing is not around and build the test without 
these test cases. check_config.sh senses support.

We could do the same for numactl (numa.h), but maybe there would not be 
any test case to run in there without libnuma (did not check). Some 
tests also require lcap.

-- 
Cheers,

David / dhildenb


