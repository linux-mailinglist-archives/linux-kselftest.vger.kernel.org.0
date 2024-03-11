Return-Path: <linux-kselftest+bounces-6203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 690C38781F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 15:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D18E1C2040F
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 14:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9608F3FBBE;
	Mon, 11 Mar 2024 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XbU57WKy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11731E4A4
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Mar 2024 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710168502; cv=none; b=hNaKoUtWEYTgIBuFD9SEUFDWehseqNNuetvh15Q6OkZYY4qAuPg9ZfUTsFrGknSToD9EDZcJPXgXn6bCdTJ7A+t8K3DpMUVSKyjz/vgecN0O2FO0/gwYuR67+L9eM0CIObKnQFQui63d/uoxvhLDUzpAjEFMOJ8GLk8E8YeTrtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710168502; c=relaxed/simple;
	bh=0rYbMvpAOxpTDGc1NcwJeynFssMvzCzRaAD7WC8yl3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MnjFUiWOKx9hP+qHxLsP4HzSlBqmeIhR9b1FGEUWbl4gG+YUDHtAXPuASU9W3F8ifNdg1nDak88LzfwcyPzPca8xBxGQ1fBOx9bBmrjqnDwTVijq1aZqSoxF9BH3i4uEzcvsaAr3faqWT38+FafSQqkeLG8IN07zLzMUMYWwunE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XbU57WKy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710168499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EdldNs1N7RHnyhMk9oGWyBRuGTNEm2Wy6MhIkeoNEpk=;
	b=XbU57WKyaVUuQUaSdY/bX3AVk66N+J65X8GNv9WtIDzWQ+bWBgbvZYhYKAhQ7UNUffmDxM
	vTeuQWVPzZdOoYGbVfWJNWbr0xAvbT4VwG3QZDWqBqyXUpthf7B1dOb+0cjyvo3wyiw+ZC
	WyhA8EUMsXypR+n59CfmsTE+yolemR8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-xSQUouOYO7Cw56kKhI7XrQ-1; Mon, 11 Mar 2024 10:48:18 -0400
X-MC-Unique: xSQUouOYO7Cw56kKhI7XrQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5135aa34125so4633702e87.0
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Mar 2024 07:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710168496; x=1710773296;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdldNs1N7RHnyhMk9oGWyBRuGTNEm2Wy6MhIkeoNEpk=;
        b=gbkIguQrHeeU2cKLH8dJ0Ar6ybr3sNE1Zsxwlk78vO/+6GQVVHYpG9ZaFZIDLiJ5jC
         lBSP45mvIPai/RWmNvfBzVoDNOtKq3bvCdQKW4OEjOTqWzsGpDTeN2w3Hfo2v5SfYt5s
         u4GrZB1+KPsv0Jpu9fJkbZX3te4ODw0LsvX7rM/F5RSSaapWGfGES/CHVqT7JEQ9Ne+6
         lnsfypn7CoPc+ISGGamnR4O8b/sVGxXPXTA8tU3YWlolUlyWQBQQ5c80HGOwJBNdJ9mI
         Za8TvZpXHHhB0ZmSQIsyVPTChZDgX9QaY1zt1C8J2Yqz/cmFhXXfr1PRMZtmwgtqQJw3
         1FZg==
X-Forwarded-Encrypted: i=1; AJvYcCVcY0fnjcsTJf5CsZ1k1jYkJLa4o6726wHD1OwwMe8Q835rjJKuUvsGXheizSwtT2M3XewsvSBqKtKeR2o9+EaT/LNYZGIAsauOg6P5lBIX
X-Gm-Message-State: AOJu0YxHOH5sl2Le9usoe6Bgli9qUphcIT1PKW4wCVcbmEMBsrzmHHZy
	g3hSaVcsfWV8ucw7+IXz1370cdqxTN3ycPGyKhoxWKyThCRHehptqsqpNkmIJzOj3uazg5jgHGO
	zvuIG+ghC+JJY8Rwr74AJeH0lrLL2nKQiq0OjKyra6vXR60DpWEQbN7+JrQWFlmbzfg==
X-Received: by 2002:ac2:5967:0:b0:513:b432:a37d with SMTP id h7-20020ac25967000000b00513b432a37dmr168819lfp.25.1710168496430;
        Mon, 11 Mar 2024 07:48:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJVDMhNfRRHhId7b0wGOoxFKzW9vetGjbOiClSWQfjbU732Anxd/jOyqf+ZH/rNnNYcysJ6Q==
X-Received: by 2002:ac2:5967:0:b0:513:b432:a37d with SMTP id h7-20020ac25967000000b00513b432a37dmr168805lfp.25.1710168495899;
        Mon, 11 Mar 2024 07:48:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:6100:aae:4b84:887c:15bb? (p200300cbc72f61000aae4b84887c15bb.dip0.t-ipconnect.de. [2003:cb:c72f:6100:aae:4b84:887c:15bb])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d59c9000000b0033e22a7b3f8sm6472618wry.75.2024.03.11.07.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 07:48:15 -0700 (PDT)
Message-ID: <b5ff4c70-6379-4cc7-8c92-778d80a6a658@redhat.com>
Date: Mon, 11 Mar 2024 15:48:14 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG selftests/mm]
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Axel Rasmussen <axelrasmussen@google.com>
References: <a9e3120d-8b79-4435-b113-ceb20aa45ee2@alu.unizg.hr>
 <4a5c8d28-7f73-4c15-b288-641f0ccc91c2@redhat.com> <Ze8Wr2qH8V0LMi_5@x1n>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Ze8Wr2qH8V0LMi_5@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.03.24 15:35, Peter Xu wrote:
> On Mon, Mar 11, 2024 at 10:31:41AM +0100, David Hildenbrand wrote:
>> On 09.03.24 20:12, Mirsad Todorovac wrote:
>>> Hi,
>>>
>>> Routine run of the test in net-next gave also this mm unit error.
>>>
>>> root@defiant:tools/testing/selftests/mm# ./uffd-unit-tests
>>> Testing UFFDIO_API (with syscall)... done
>>> Testing UFFDIO_API (with /dev/userfaultfd)... done
>>> Testing register-ioctls on anon... done
>>> Testing register-ioctls on shmem... done
>>> Testing register-ioctls on shmem-private... done
>>> Testing register-ioctls on hugetlb... skipped [reason: memory allocation failed]
>>> Testing register-ioctls on hugetlb-private... skipped [reason: memory allocation failed]
>>> Testing zeropage on anon... done
>>> Testing zeropage on shmem... done
>>> Testing zeropage on shmem-private... done
>>> Testing zeropage on hugetlb... skipped [reason: memory allocation failed]
>>> Testing zeropage on hugetlb-private... skipped [reason: memory allocation failed]
>>> Testing move on anon... done
>>> Testing move-pmd on anon... done
>>> Testing move-pmd-split on anon... done
>>> Testing wp-fork on anon... done
>>> Testing wp-fork on shmem... done
>>> Testing wp-fork on shmem-private... done
>>> Testing wp-fork on hugetlb... skipped [reason: memory allocation failed]
>>> Testing wp-fork on hugetlb-private... skipped [reason: memory allocation failed]
>>> Testing wp-fork-with-event on anon... done
>>> Testing wp-fork-with-event on shmem... done
>>> Testing wp-fork-with-event on shmem-private... done
>>> Testing wp-fork-with-event on hugetlb... skipped [reason: memory allocation failed]
>>> Testing wp-fork-with-event on hugetlb-private... skipped [reason: memory allocation failed]
>>> Testing wp-fork-pin on anon... done
>>> Testing wp-fork-pin on shmem... done
>>> Testing wp-fork-pin on shmem-private... done
>>> Testing wp-fork-pin on hugetlb... skipped [reason: memory allocation failed]
>>> Testing wp-fork-pin on hugetlb-private... skipped [reason: memory allocation failed]
>>> Testing wp-fork-pin-with-event on anon... done
>>> Testing wp-fork-pin-with-event on shmem... done
>>> Testing wp-fork-pin-with-event on shmem-private... done
>>> Testing wp-fork-pin-with-event on hugetlb... skipped [reason: memory allocation failed]
>>> Testing wp-fork-pin-with-event on hugetlb-private... skipped [reason: memory allocation failed]
>>> Testing wp-unpopulated on anon... done
>>> Testing minor on shmem... done
>>> Testing minor on hugetlb... skipped [reason: memory allocation failed]
>>> Testing minor-wp on shmem... done
>>> Testing minor-wp on hugetlb... skipped [reason: memory allocation failed]
>>> Testing minor-collapse on shmem... done
>>> Testing sigbus on anon... done
>>> Testing sigbus on shmem... done
>>> Testing sigbus on shmem-private... done
>>> Testing sigbus on hugetlb... skipped [reason: memory allocation failed]
>>> Testing sigbus on hugetlb-private... skipped [reason: memory allocation failed]
>>> Testing sigbus-wp on anon... done
>>> Testing sigbus-wp on shmem... done
>>> Testing sigbus-wp on shmem-private... done
>>> Testing sigbus-wp on hugetlb... skipped [reason: memory allocation failed]
>>> Testing sigbus-wp on hugetlb-private... skipped [reason: memory allocation failed]
>>> Testing events on anon... done
>>> Testing events on shmem... done
>>> Testing events on shmem-private... done
>>> Testing events on hugetlb... skipped [reason: memory allocation failed]
>>> Testing events on hugetlb-private... skipped [reason: memory allocation failed]
>>> Testing events-wp on anon... done
>>> Testing events-wp on shmem... done
>>> Testing events-wp on shmem-private... done
>>> Testing events-wp on hugetlb... skipped [reason: memory allocation failed]
>>> Testing events-wp on hugetlb-private... skipped [reason: memory allocation failed]
>>> Testing poison on anon... done
>>> Testing poison on shmem... done
>>> Testing poison on shmem-private... done
>>> Testing poison on hugetlb... skipped [reason: memory allocation failed]
>>> Testing poison on hugetlb-private... skipped [reason: memory allocation failed]
>>> Userfaults unit tests: pass=42, skip=24, fail=0 (total=66)
>>> root@defiant:tools/testing/selftests/mm# grep -i huge /proc/meminfo
>>>
>>> It resulted in alarming errors in the syslog:
>>>
>>> Mar  9 19:48:24 defiant kernel: [77187.055103] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4631e000
>>> Mar  9 19:48:24 defiant kernel: [77187.055132] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46320000
>>> Mar  9 19:48:24 defiant kernel: [77187.055160] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46322000
>>> Mar  9 19:48:24 defiant kernel: [77187.055189] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46324000
>>> Mar  9 19:48:24 defiant kernel: [77187.055218] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46326000
>>> Mar  9 19:48:24 defiant kernel: [77187.055250] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46328000
>>> Mar  9 19:48:24 defiant kernel: [77187.055278] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4632a000
>>> Mar  9 19:48:24 defiant kernel: [77187.055307] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4632c000
>>> Mar  9 19:48:24 defiant kernel: [77187.055336] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4632e000
>>> Mar  9 19:48:24 defiant kernel: [77187.055366] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46330000
>>> Mar  9 19:48:24 defiant kernel: [77187.055395] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46332000
>>> Mar  9 19:48:24 defiant kernel: [77187.055423] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46334000
>>> Mar  9 19:48:24 defiant kernel: [77187.055452] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46336000
>>> Mar  9 19:48:24 defiant kernel: [77187.055480] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46338000
>>> Mar  9 19:48:24 defiant kernel: [77187.055509] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4633a000
>>> Mar  9 19:48:24 defiant kernel: [77187.055538] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4633c000
>>> Mar  9 19:48:24 defiant kernel: [77187.055567] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4633e000
>>> Mar  9 19:48:24 defiant kernel: [77187.055597] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46340000
>>>
>>> At this point, it can be problem with my box's memory chips, or something with HUGETLB.
>>>
>>> However, since the "classic" allocations were successful, the problem might be in huge pages, or
>>> if I understood well, in deliberate poisoning of pages?
>>>
>>
>> Isn't that just the (expected) side effect of UFFDIO_POISON tests?
>>
>> IOW, there is no problem here. We are poisoning virtual memory locations
>> (not actual memory) and expect a SIGBUS on next access. While testing that,
>> we receive these messages.
> 
> Correct.
> 
>>
>> The "ugly" thing here seems to be that we can trigger repeated pr_err() from
>> user space. There is no rate-limiting in place. Maybe UFFDIO_POISON requires
>> root permissions so this cannot be exploited by unprivileged user space to
>> flood the system log?
>>
>> CCing Axel
> 
> This is pretty unfortunate.
> 
> I'm not concerned too much on flooding whoever kicks off the selftests, but
> indeed this seems to be able to be used by anyone to trigger such endless
> reports in dmesg.

Right.

> 
> The issue with requiring a privilege means any hypervisor that will need to
> use this to emulate memory errors will also require such privilege, and it
> can be a problem.
> 

Yes, we don't want that.

> Logically such "hwpoison errors" are not real so it is not needed to be
> reported in dmesg, but now we're leveraging it to be exactly the same as a
> real hw error to share the code path, iiuc (e.g. on MCE injections).
> 
> One option is to use a different marker reflecting that such hwpoison error
> is internal, so we don't need to report in dmesg. That'll also require
> (besides another bit in pte markers) one extra VM_FAULT_* flag just for
> such reports.  Might be slightly an overkill, but I don't see another
> better way; not reporting HWPOISON will complicate at least kvm use case
> even more.
> 
> Or.. does syslog has its own protection in general for such printk floods?
> It'll be easier if that's not a concern to flood then, but I'm not sure
> from that regard.

 From what I know, flooding is considered problematic and we fix it up 
using "Fixes:" commits. See 1b0a151c10a6d823f033023b9fdd9af72a89591b as 
one "recent" example.


Usually we switch to the _ratelimited() functions, maybe 
pr_warn_ratelimited() is good enough? But we'd lose some details on a 
"real" MCE storm, though.

-- 
Cheers,

David / dhildenb


