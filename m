Return-Path: <linux-kselftest+bounces-6173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 246C9877CC4
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 10:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD921F2104A
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 09:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9DC182C5;
	Mon, 11 Mar 2024 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXjpKQHu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602DF171A5
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Mar 2024 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149512; cv=none; b=AW/yJTvfe3UoeiTANYF/UTELgy4uiRiLXRAKqttUu03DoqvNJQzcBgyfKmWFeoPx8b24cMxXJkLTFclCwN7bkkQ5Zxr4+PWWisgMSvQ3bQH00ve1QCK0CKlYZ5Y5N6mX8+S2+qibn87mmYfFaWJnz92txYepXDYBJAfuG1w7kwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149512; c=relaxed/simple;
	bh=hH7DjYecXDBb3PppoL62gOMOcFN6iAyb+l+d5Qs1Dxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M1FQK/THXh34Qu9PfCjMv5v+sems5H6BQ7oKA//+NaXQ1EEutcyTcQWCXwzhmhOg+6KZELzdlqsAFhFMhnQ+R8jriunccmQd/Iy59gKB4KGsbU4BVwdwAPxLaW9yNvVqRiV0w3/LN4oaF6JRnJl3seKQNoQuHj9CBnnScJ5ElGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hXjpKQHu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710149508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TRK4RmTk4kmrSDrZbejl0PU5Yx+wA9WMsh0HUgjryk0=;
	b=hXjpKQHultZY1WgEXj3U/QVLA6jb9/a2rSpjtXT+yFGjZGMjURMtDYAwZllRFyXY02Q0t+
	o6aDCbcSAbQ0iy/KYRJCu2bF1g/M0W2CIGpTRaARhelVkVpWHVCS+QtPXh1tzL/Q6aMbhP
	G5tiFSav9FscypuA3RSqVSGjcdg0aIU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-sgWZyV6SM5OtMjVObUl2BQ-1; Mon, 11 Mar 2024 05:31:45 -0400
X-MC-Unique: sgWZyV6SM5OtMjVObUl2BQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33e897f71dcso644356f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Mar 2024 02:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710149504; x=1710754304;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRK4RmTk4kmrSDrZbejl0PU5Yx+wA9WMsh0HUgjryk0=;
        b=Kllc1RBlNOokjnqB0/vyuMbcys0CLIxinqExoTYrX3+vdSQlPdWTMlLeoUmoqmF9bb
         nbbTC+q22IouKUw9n6+TjSSW/q4j5BV7dhTe+kOoXPxi9V3c71xM9WyCsApL+JGQ4Kk1
         QgREZneV3YCezz+d6Ha5B8+VO0uEHoexApGPPaQG4R3hAllj2AWDM1QZiEbd37BEaZK5
         E4VTQDWAGbldOpss6nfdiRbMw0MobgguYUwK5aeKK9pcWn93aHZBfZ1qROvavuz5Vocb
         mXPx4SgJR+/Vy8+vm402W2+78l0dphoc8f4bNi6O1hzSZlBN/x/w1sbZzlNj2hju2aNX
         bOZA==
X-Forwarded-Encrypted: i=1; AJvYcCU/ygV62yMRIZtQ5CygzaC76sj4bNhm3BXVjCA7meCSDsY77S4VV/3gTRGvTyOnzEH45mK4aWJ2ntqDZ9pUBHeYMsvm4Gn3PToiECOcDgWn
X-Gm-Message-State: AOJu0YxbVx6+0SNIQg7vK0qvYZe1411c/L5dk9uIH94fsqI2LEIoOFDS
	HjKO952mhK4FTjE8Y5UQWWnzEn30I7qtinCjgaghza69LF/HS7QXMs9XXCGpiz0oDesUTRclDvo
	DFw5DhckjMKOSwxdR+Ff6L7HpyfBaB5/sI4hzLhp+bMxGtOAKkvJP/JN9gtahXmLBcQ==
X-Received: by 2002:adf:9782:0:b0:33e:7c52:c899 with SMTP id s2-20020adf9782000000b0033e7c52c899mr5456057wrb.10.1710149504051;
        Mon, 11 Mar 2024 02:31:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgps8TniqOqubxlZesHQUm1fcS2Wcdvy0FCmvqkHgbbVbcMownrrkcgWC0WKaybmoSO6AaXA==
X-Received: by 2002:adf:9782:0:b0:33e:7c52:c899 with SMTP id s2-20020adf9782000000b0033e7c52c899mr5456027wrb.10.1710149503570;
        Mon, 11 Mar 2024 02:31:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:6100:aae:4b84:887c:15bb? (p200300cbc72f61000aae4b84887c15bb.dip0.t-ipconnect.de. [2003:cb:c72f:6100:aae:4b84:887c:15bb])
        by smtp.gmail.com with ESMTPSA id s12-20020a5d424c000000b0033e48db23bdsm5940953wrr.100.2024.03.11.02.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 02:31:42 -0700 (PDT)
Message-ID: <4a5c8d28-7f73-4c15-b288-641f0ccc91c2@redhat.com>
Date: Mon, 11 Mar 2024 10:31:41 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG selftests/mm]
Content-Language: en-US
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, linux-mm@kvack.org
Cc: Peter Xu <peterx@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Axel Rasmussen <axelrasmussen@google.com>
References: <a9e3120d-8b79-4435-b113-ceb20aa45ee2@alu.unizg.hr>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a9e3120d-8b79-4435-b113-ceb20aa45ee2@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.03.24 20:12, Mirsad Todorovac wrote:
> Hi,
> 
> Routine run of the test in net-next gave also this mm unit error.
> 
> root@defiant:tools/testing/selftests/mm# ./uffd-unit-tests
> Testing UFFDIO_API (with syscall)... done
> Testing UFFDIO_API (with /dev/userfaultfd)... done
> Testing register-ioctls on anon... done
> Testing register-ioctls on shmem... done
> Testing register-ioctls on shmem-private... done
> Testing register-ioctls on hugetlb... skipped [reason: memory allocation failed]
> Testing register-ioctls on hugetlb-private... skipped [reason: memory allocation failed]
> Testing zeropage on anon... done
> Testing zeropage on shmem... done
> Testing zeropage on shmem-private... done
> Testing zeropage on hugetlb... skipped [reason: memory allocation failed]
> Testing zeropage on hugetlb-private... skipped [reason: memory allocation failed]
> Testing move on anon... done
> Testing move-pmd on anon... done
> Testing move-pmd-split on anon... done
> Testing wp-fork on anon... done
> Testing wp-fork on shmem... done
> Testing wp-fork on shmem-private... done
> Testing wp-fork on hugetlb... skipped [reason: memory allocation failed]
> Testing wp-fork on hugetlb-private... skipped [reason: memory allocation failed]
> Testing wp-fork-with-event on anon... done
> Testing wp-fork-with-event on shmem... done
> Testing wp-fork-with-event on shmem-private... done
> Testing wp-fork-with-event on hugetlb... skipped [reason: memory allocation failed]
> Testing wp-fork-with-event on hugetlb-private... skipped [reason: memory allocation failed]
> Testing wp-fork-pin on anon... done
> Testing wp-fork-pin on shmem... done
> Testing wp-fork-pin on shmem-private... done
> Testing wp-fork-pin on hugetlb... skipped [reason: memory allocation failed]
> Testing wp-fork-pin on hugetlb-private... skipped [reason: memory allocation failed]
> Testing wp-fork-pin-with-event on anon... done
> Testing wp-fork-pin-with-event on shmem... done
> Testing wp-fork-pin-with-event on shmem-private... done
> Testing wp-fork-pin-with-event on hugetlb... skipped [reason: memory allocation failed]
> Testing wp-fork-pin-with-event on hugetlb-private... skipped [reason: memory allocation failed]
> Testing wp-unpopulated on anon... done
> Testing minor on shmem... done
> Testing minor on hugetlb... skipped [reason: memory allocation failed]
> Testing minor-wp on shmem... done
> Testing minor-wp on hugetlb... skipped [reason: memory allocation failed]
> Testing minor-collapse on shmem... done
> Testing sigbus on anon... done
> Testing sigbus on shmem... done
> Testing sigbus on shmem-private... done
> Testing sigbus on hugetlb... skipped [reason: memory allocation failed]
> Testing sigbus on hugetlb-private... skipped [reason: memory allocation failed]
> Testing sigbus-wp on anon... done
> Testing sigbus-wp on shmem... done
> Testing sigbus-wp on shmem-private... done
> Testing sigbus-wp on hugetlb... skipped [reason: memory allocation failed]
> Testing sigbus-wp on hugetlb-private... skipped [reason: memory allocation failed]
> Testing events on anon... done
> Testing events on shmem... done
> Testing events on shmem-private... done
> Testing events on hugetlb... skipped [reason: memory allocation failed]
> Testing events on hugetlb-private... skipped [reason: memory allocation failed]
> Testing events-wp on anon... done
> Testing events-wp on shmem... done
> Testing events-wp on shmem-private... done
> Testing events-wp on hugetlb... skipped [reason: memory allocation failed]
> Testing events-wp on hugetlb-private... skipped [reason: memory allocation failed]
> Testing poison on anon... done
> Testing poison on shmem... done
> Testing poison on shmem-private... done
> Testing poison on hugetlb... skipped [reason: memory allocation failed]
> Testing poison on hugetlb-private... skipped [reason: memory allocation failed]
> Userfaults unit tests: pass=42, skip=24, fail=0 (total=66)
> root@defiant:tools/testing/selftests/mm# grep -i huge /proc/meminfo
> 
> It resulted in alarming errors in the syslog:
> 
> Mar  9 19:48:24 defiant kernel: [77187.055103] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4631e000
> Mar  9 19:48:24 defiant kernel: [77187.055132] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46320000
> Mar  9 19:48:24 defiant kernel: [77187.055160] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46322000
> Mar  9 19:48:24 defiant kernel: [77187.055189] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46324000
> Mar  9 19:48:24 defiant kernel: [77187.055218] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46326000
> Mar  9 19:48:24 defiant kernel: [77187.055250] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46328000
> Mar  9 19:48:24 defiant kernel: [77187.055278] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4632a000
> Mar  9 19:48:24 defiant kernel: [77187.055307] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4632c000
> Mar  9 19:48:24 defiant kernel: [77187.055336] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4632e000
> Mar  9 19:48:24 defiant kernel: [77187.055366] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46330000
> Mar  9 19:48:24 defiant kernel: [77187.055395] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46332000
> Mar  9 19:48:24 defiant kernel: [77187.055423] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46334000
> Mar  9 19:48:24 defiant kernel: [77187.055452] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46336000
> Mar  9 19:48:24 defiant kernel: [77187.055480] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46338000
> Mar  9 19:48:24 defiant kernel: [77187.055509] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4633a000
> Mar  9 19:48:24 defiant kernel: [77187.055538] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4633c000
> Mar  9 19:48:24 defiant kernel: [77187.055567] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 4633e000
> Mar  9 19:48:24 defiant kernel: [77187.055597] MCE: Killing uffd-unit-tests:1321817 due to hardware memory corruption fault at 46340000
> 
> At this point, it can be problem with my box's memory chips, or something with HUGETLB.
> 
> However, since the "classic" allocations were successful, the problem might be in huge pages, or
> if I understood well, in deliberate poisoning of pages?
> 

Isn't that just the (expected) side effect of UFFDIO_POISON tests?

IOW, there is no problem here. We are poisoning virtual memory locations 
(not actual memory) and expect a SIGBUS on next access. While testing 
that, we receive these messages.

The "ugly" thing here seems to be that we can trigger repeated pr_err() 
from user space. There is no rate-limiting in place. Maybe UFFDIO_POISON 
requires root permissions so this cannot be exploited by unprivileged 
user space to flood the system log?

CCing Axel

-- 
Cheers,

David / dhildenb


