Return-Path: <linux-kselftest+bounces-20304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88BB9A90DC
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 22:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8B12816EE
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 20:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3012F1FCC71;
	Mon, 21 Oct 2024 20:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XN9Pp8/x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052741FCF5B
	for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 20:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541871; cv=none; b=kxaIzgruDpVgRkURplq7H8VqL3h60pOqNxNtqpwmXo1ZeL/cChnioiL8XKv11HCm1rck/QHgXxk2xY+agcYvIE89rJR0n1D78ueliz4vcHd8cpCG89xidQIGH/vbY3dwW0zNIqvD3d2GQP3wUSdDFQ6nJD2DDjuj4AxfPnaq8zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541871; c=relaxed/simple;
	bh=gKlCBgfS0AAaKqcA8VmWYf3KLgGgMvP22We/vPMIQpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQY0nCExo0RTIjOKQNbK2XV9FWOfqxiiaPaZrxsy2bdYssNRBpajMPEPcHgis2qosnxr07A9TQ3lB+O7CG1q33WmYbB28E+Ezm6q017PxDrSwV8w1u8aeRfLNsu/s2ltFo/ZbZfAwuZHIu0AVDWkhgVFNoYXFE4FQcfTHgfSq0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XN9Pp8/x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729541867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/G1GqEMjdPi5AZxteZatISgExeCR/ovT8Q2adnrrCQ4=;
	b=XN9Pp8/xsFq0Y+4y2MYWldERYkBw9+RfDezESNp89aFuY+9AiIijKHA5aDcgU7IRKyEKDF
	77CbJzitNOwkAyNHNE33fL5hcYdwTvsFitAbf5KSRlqRSZb6ehgj4wgur+G/p3mCioip56
	6PUMM4qA3E/bR1CdymHdN7EsN0IgGdo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-_0JYDHr2Mbi9gjY4pcSOnQ-1; Mon, 21 Oct 2024 16:17:39 -0400
X-MC-Unique: _0JYDHr2Mbi9gjY4pcSOnQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-431518ae047so28854575e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 13:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729541857; x=1730146657;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/G1GqEMjdPi5AZxteZatISgExeCR/ovT8Q2adnrrCQ4=;
        b=As0LLiDu3mknQ3OnJ7O9aWkBl+o40U8Su/YDiKyNZfYOXUC+q8UzGqNIXA4wkGUn7Z
         vJ/pTQ4uxYRtj1byHZZs/0JPmGAyiK+DTgFW2/1N0owqLt2rs3b+2gGTG55aYnSrp8kL
         DyY05Ee1pJfpP5Ar9fq2MFzPA/1pLrOs8Vi6lZ9BOmqwgXA9ixuqHAicrSE7cNCmTJqL
         iGpx/d/KZh43XoSGOMp8gQorbzCOMlhl1A3xzZEVJirSFb6TW2RtPdXe4aIIGs3Iuudh
         cwwRNv4A2xxLpp7c7rDz8RIhxbnggAw2/iVTtDaeShgI6RlAuINUPS94mDRBGEUC4Bnz
         0PNg==
X-Forwarded-Encrypted: i=1; AJvYcCUMJviH0Cgg55wtuqtbRE5Fb8rN9/LY98q91MDQiWY8k44jTrzgIAbUMfCxNuYp8yFyj9ZpHnoRZ5KsC6JNjK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX/otTp2YMbDg5yog56k2OFuDzEmPFvUKMMWgQ5l4yq+WGYe69
	7ngm+wn109i1tBsvQCBiu9FQObE2zJDHC9CBJvDviOKcWbaxvzSrpevaUKvuBcyIhCl9qn7YBY9
	tygVLR3XyZto+aSzf33iuvfD8fwt3J+qQnW075sc4/kxLMNhB+Lx59I4SUVaHtHzr6g==
X-Received: by 2002:a05:600c:1c22:b0:431:416e:2603 with SMTP id 5b1f17b1804b1-4317bd76f7fmr5414375e9.3.1729541856915;
        Mon, 21 Oct 2024 13:17:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcY1DD7dFo8tIwpxs1LdF1DOFzxE4mXucxTWHHXPyvc0KgSzW88PnW4jnVAg8xj9BhT6tJhA==
X-Received: by 2002:a05:600c:1c22:b0:431:416e:2603 with SMTP id 5b1f17b1804b1-4317bd76f7fmr5414165e9.3.1729541856448;
        Mon, 21 Oct 2024 13:17:36 -0700 (PDT)
Received: from [192.168.3.141] (p5b0c6747.dip0.t-ipconnect.de. [91.12.103.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4317d0ce992sm129745e9.1.2024.10.21.13.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 13:17:35 -0700 (PDT)
Message-ID: <6c282299-506f-45c9-9ddc-9ef4de582394@redhat.com>
Date: Mon, 21 Oct 2024 22:17:32 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm: madvise: implement lightweight guard page
 mechanism
To: Vlastimil Babka <vbabka@suse.cz>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 linux-kselftest@vger.kernel.org, Sidhartha Kumar
 <sidhartha.kumar@oracle.com>, Jeff Xu <jeffxu@chromium.org>,
 Christoph Hellwig <hch@infradead.org>, linux-api@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <fce49bbbfe41b82161a37b022c8eb1e6c20e1d85.1729440856.git.lorenzo.stoakes@oracle.com>
 <c37ada68-5bf5-4ca5-9de8-c0838160c443@suse.cz>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c37ada68-5bf5-4ca5-9de8-c0838160c443@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.24 22:11, Vlastimil Babka wrote:
> On 10/20/24 18:20, Lorenzo Stoakes wrote:
>> Implement a new lightweight guard page feature, that is regions of userland
>> virtual memory that, when accessed, cause a fatal signal to arise.
>>
>> Currently users must establish PROT_NONE ranges to achieve this.
>>
>> However this is very costly memory-wise - we need a VMA for each and every
>> one of these regions AND they become unmergeable with surrounding VMAs.
>>
>> In addition repeated mmap() calls require repeated kernel context switches
>> and contention of the mmap lock to install these ranges, potentially also
>> having to unmap memory if installed over existing ranges.
>>
>> The lightweight guard approach eliminates the VMA cost altogether - rather
>> than establishing a PROT_NONE VMA, it operates at the level of page table
>> entries - poisoning PTEs such that accesses to them cause a fault followed
>> by a SIGSGEV signal being raised.
>>
>> This is achieved through the PTE marker mechanism, which a previous commit
>> in this series extended to permit this to be done, installed via the
>> generic page walking logic, also extended by a prior commit for this
>> purpose.
>>
>> These poison ranges are established with MADV_GUARD_POISON, and if the
>> range in which they are installed contain any existing mappings, they will
>> be zapped, i.e. free the range and unmap memory (thus mimicking the
>> behaviour of MADV_DONTNEED in this respect).
>>
>> Any existing poison entries will be left untouched. There is no nesting of
>> poisoned pages.
>>
>> Poisoned ranges are NOT cleared by MADV_DONTNEED, as this would be rather
>> unexpected behaviour, but are cleared on process teardown or unmapping of
>> memory ranges.
>>
>> Ranges can have the poison property removed by MADV_GUARD_UNPOISON -
>> 'remedying' the poisoning. The ranges over which this is applied, should
>> they contain non-poison entries, will be untouched, only poison entries
>> will be cleared.
>>
>> We permit this operation on anonymous memory only, and only VMAs which are
>> non-special, non-huge and not mlock()'d (if we permitted this we'd have to
>> drop locked pages which would be rather counterintuitive).
>>
>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>> Suggested-by: Jann Horn <jannh@google.com>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> <snip>
> 
>> +static long madvise_guard_poison(struct vm_area_struct *vma,
>> +				 struct vm_area_struct **prev,
>> +				 unsigned long start, unsigned long end)
>> +{
>> +	long err;
>> +
>> +	*prev = vma;
>> +	if (!is_valid_guard_vma(vma, /* allow_locked = */false))
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * If we install poison markers, then the range is no longer
>> +	 * empty from a page table perspective and therefore it's
>> +	 * appropriate to have an anon_vma.
>> +	 *
>> +	 * This ensures that on fork, we copy page tables correctly.
>> +	 */
>> +	err = anon_vma_prepare(vma);
>> +	if (err)
>> +		return err;
>> +
>> +	/*
>> +	 * Optimistically try to install the guard poison pages first. If any
>> +	 * non-guard pages are encountered, give up and zap the range before
>> +	 * trying again.
>> +	 */
> 
> Should the page walker become powerful enough to handle this in one go? :)
> But sure, if it's too big a task to teach it to zap ptes with all the tlb
> flushing etc (I assume it's something page walkers don't do today), it makes
> sense to do it this way.
> Or we could require userspace to zap first (MADV_DONTNEED), but that would
> unnecessarily mean extra syscalls for the use case of an allocator debug
> mode that wants to turn freed memory to guards to catch use after free.
> So this seems like a good compromise...

Yes please, KIS. We can always implement support for that later if 
really required (leave behavior open when documenting).

-- 
Cheers,

David / dhildenb


