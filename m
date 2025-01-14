Return-Path: <linux-kselftest+bounces-24438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2891FA103C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 11:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C9C18876CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 10:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABB722DC3C;
	Tue, 14 Jan 2025 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0qRM5Gt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4A91CF2B7
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736849741; cv=none; b=AnbqOapMzivyAuuiyOVtNDXdeGiHZodXhbTHFkb+T8bdc1afH7xRLtXAdMBRwjBMhXnkelx1QxswOBGCXWbH3jyS+yII7q9AyBy/XEc06IW+JXm4ng4djmwX7w4mcY1rJgxP4gomHnqlJELCfHk4LDwzZsECvZIjGeNICJsJahA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736849741; c=relaxed/simple;
	bh=KTl3q5pYXLSH0DeiMj44Uash53egDogV0MDwlIHtVVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWwqCBKjawqSpeHGp6/4oNvSKY3WIiysJxaXD4DpsoaWmmQdv62+3eG88EllbY+LkP+0dZMvdKYP4RZPxnaqUR8KR/Gqp8NDoDQj0fxssVVcITcoHF0FTgY1yA9WBbtfF3RiPxu+tg3kVaEGI0qUHsSmYyvtxaG1mQlIvjsH+oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J0qRM5Gt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736849738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bL9exZbXhYW4wMhK5x/31VM6rwxkJFZApmhn7EVPFHA=;
	b=J0qRM5GtFgsb1mGBfhmOYL7KuWYxP8VL7SPpJS5QlV5w796NA7wD0hUftnOzNM5Y3YjVoU
	Oqd0hl7XQmEWg82XJD10IoiOQ3NKIanffELskJd1WiZaEpond9lYe837wJ4KT5usVR6Iy3
	6wzZUcrkTZFLX2WK7pWHx1AHLeXOrSo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-VXsUphiiMQWbdgZbH0u7KA-1; Tue, 14 Jan 2025 05:15:37 -0500
X-MC-Unique: VXsUphiiMQWbdgZbH0u7KA-1
X-Mimecast-MFC-AGG-ID: VXsUphiiMQWbdgZbH0u7KA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43651b1ba8aso36329305e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 02:15:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736849736; x=1737454536;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bL9exZbXhYW4wMhK5x/31VM6rwxkJFZApmhn7EVPFHA=;
        b=ECopWISfssBPRivMOmerNYA0yny3TriIsv9hXDVRqEDyaJb75064DILeGgubJiSbIo
         lVCjYR+W7Py/bossSzKQd/yuEfY568bZFuBkXwkjmqT5o/0sVyW76KPalBM1s3VmO7N1
         qeLHLJTOp6n6sK4UNDTbcqSbF22A6gFGEFtLocu3pt79DTFJbaX+zZzLE1ULgV1/k4wT
         h5Qhuaji2v/QN+wRXYC/RrBe6Wy8cJpBmGTpzsy/yEKjxXuNo8MYqy2JprcOYyOrwLHr
         4oXVLvC1fFmWacoFP5Z7lsXE/jlqNX7LgfTjxfZHEOy/giWBNCF7fliQlD1Na/dtbdqV
         WP9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvF4W2Gx0fBIZ/tpTuX4JDTJVcN7dcR2y/UX4xsVNc8KVcgwQPZVJrXn3dIsOUTJi1rKhoFlvkb75IDgB107o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMS3h1ijsu3Ax5C3dRz06CTrxBpb6QeNRo8xNdcWZwAratW3ut
	rYkO9gUzK/rTmgQRWGYqtjsxF9b1+4RzN/VIijejVEf3m7wcDex/MFUrKDzhcKaNtYomL17w6ie
	5W1OYrFXAGFYlQ4Z4xG2Wh9ZVo3nbjZLXuMsWQK6x5IDQYgmoJgc1AyaKi8nabRZrew==
X-Gm-Gg: ASbGnct6WaHofxv/KO7Kyr6pj7mWmk6SN4n6be3hr8j2XsKCZzPQ2rJFP/bIOpxbzG3
	jJ4A/DQscQYSKYc97sSS3trqa1+h4mrnA2Hg7NAtgc4UokrgwwZUEJhwLcQGqBIyQ9kElVhtdHf
	5WKR+5EGrJXhIwlAUhQou0+UPeIr/CK3QiYMatJU10i4YDRdhrcHr1LpVvzvS3GDQgmJvipA7W0
	cGHjH/7Fd97gsNmbM5ia3DkbNGq06THb4Xf5amVPIEqUTIqSa2A9GbS6ap/TeD5JkA6GkUe4WA0
	gmrkalC5RLXF9QhoVjaWzVMGlqFJqf0RDndhyYYbLd77tMYWtXwWhkSRAz9Hx9eONijSAo7nsV6
	juxcOV84R
X-Received: by 2002:a05:600c:138a:b0:434:a781:f5d5 with SMTP id 5b1f17b1804b1-436e271bcb3mr241756425e9.30.1736849736084;
        Tue, 14 Jan 2025 02:15:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGMrkauFOVr3JbtLeqJkX9WkpCDEDyD7FpKkIC0rHyr+Xh4wMJkpIAALTNhPD7GJmK8V8xow==
X-Received: by 2002:a05:600c:138a:b0:434:a781:f5d5 with SMTP id 5b1f17b1804b1-436e271bcb3mr241756045e9.30.1736849735677;
        Tue, 14 Jan 2025 02:15:35 -0800 (PST)
Received: from ?IPV6:2003:cb:c738:3100:8133:26cf:7877:94aa? (p200300cbc7383100813326cf787794aa.dip0.t-ipconnect.de. [2003:cb:c738:3100:8133:26cf:7877:94aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9d8fc5csm171535915e9.2.2025.01.14.02.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 02:15:35 -0800 (PST)
Message-ID: <c494f2b2-714e-4531-9c39-2fb9f7ebfe06@redhat.com>
Date: Tue, 14 Jan 2025 11:15:28 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] selftests/mm: virtual_address_range: Avoid reading
 from VM_IO mappings
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
References: <20250113-virtual_address_range-tests-v3-0-f4a8e6b7feed@linutronix.de>
 <20250113-virtual_address_range-tests-v3-4-f4a8e6b7feed@linutronix.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250113-virtual_address_range-tests-v3-4-f4a8e6b7feed@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.01.25 14:15, Thomas Weißschuh wrote:
> The virtual_address_range selftest reads from the start of each mapping
> listed in /proc/self/maps.
> However not all mappings are valid to be arbitrarily accessed.
> 
> For example the vvar data used for virtual clocks on x86 [vvar_vclock]
> can only be accessed if 1) the kernel configuration enables virtual
> clocks and 2) the hypervisor provided the data for it.
> Only the VDSO itself has the necessary information to know this.
> Since commit e93d2521b27f ("x86/vdso: Split virtual clock pages into dedicated mapping")
> the virtual clock data was split out into its own mapping, leading
> to EFAULT from read() during the validation.
> 
> Check for the VM_IO flag as a proxy.
> It is present for the VVAR mappings and MMIO ranges can be dangerous to
> access arbitrarily.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202412271148.2656e485-lkp@intel.com
> Fixes: e93d2521b27f ("x86/vdso: Split virtual clock pages into dedicated mapping")
> Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Link: https://lore.kernel.org/lkml/e97c2a5d-c815-4936-a767-ac42a3220a90@redhat.com/
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 
> Revert "selftests/mm: virtual_address_range: Avoid reading VVAR mappings"
> 
> This reverts commit 05cc5d292ac4238684b59922aecf59c932edefa0.
> ---
>   tools/testing/selftests/mm/virtual_address_range.c |  4 ++++
>   tools/testing/selftests/mm/vm_util.c               | 21 +++++++++++++++++++++
>   tools/testing/selftests/mm/vm_util.h               |  1 +
>   3 files changed, 26 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> index 386e4e46fa65b98af78dee4bb30144eb2b51f528..b380e102b22f0a44654ab046f257e8c35e8d90e9 100644
> --- a/tools/testing/selftests/mm/virtual_address_range.c
> +++ b/tools/testing/selftests/mm/virtual_address_range.c
> @@ -15,6 +15,7 @@
>   #include <sys/time.h>
>   #include <fcntl.h>
>   
> +#include "vm_util.h"
>   #include "../kselftest.h"
>   
>   /*
> @@ -159,6 +160,9 @@ static int validate_complete_va_space(void)
>   		if (prot[0] != 'r')
>   			continue;
>   
> +		if (check_vmflag_io((void *)start_addr))
> +			continue;
> +
>   		/*
>   		 * Confirm whether MAP_CHUNK_SIZE chunk can be found or not.
>   		 * If write succeeds, no need to check MAP_CHUNK_SIZE - 1
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
> index 8468a19d6acca10c7e9228c03a935cdeb2402b5d..161fe03b07af78244efc669a36155ad603fa6f7d 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -400,3 +400,24 @@ unsigned long get_free_hugepages(void)
>   	fclose(f);
>   	return fhp;
>   }
> +
> +bool check_vmflag_io(void *addr)

Interestingly, this will only work if addr really is the start of the 
mapping, as __get_smap_entry() cannot handle "address falls into a 
mapping". Good enough for now, but might be worth a comment.

(wrong usage would fail with  No VmFlags for ... )

> +{
> +	char *saveptr, *flag, *strtok_arg;

" On some implementations, *saveptr is required to be NULL on the first 
call to strtok_r() that is being used to parse str."

Maybe just initialize it to NULL.

> +	char buffer[MAX_LINE_LENGTH];
> +
> +	strtok_arg = __get_smap_entry(addr, "VmFlags:", buffer, sizeof(buffer));
> +	if (!strtok_arg)
> +		ksft_exit_fail_msg("%s: No VmFlags for %p\n", __func__, addr);
> +
> +	while (true) {
> +		flag = strtok_r(strtok_arg, " ", &saveptr);
> +		if (!flag)
> +			break;
> +		if (strcmp(flag, "io") == 0)
> +			return true;

Are these early exit allowed with strtok_r()?

An alternative seems to be using strcspn() that doesn't modify 
strings/maintain state in-between calls.

-- 
Cheers,

David / dhildenb


