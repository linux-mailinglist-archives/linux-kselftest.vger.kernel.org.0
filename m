Return-Path: <linux-kselftest+bounces-47806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04981CD4585
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 21:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E5A83005E8C
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 20:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5AF31D36D;
	Sun, 21 Dec 2025 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1UbcO3k";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4hKX/P5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D395D3090FE
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 20:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766348654; cv=none; b=Y6FxnwqvbRwzf6D6Cc3SHV2nSWF1+eyocslc6SAXT+j/7s+eZWidOCF0qbGeehepqEupO3BpiPo7VczRBsSHvme0IBfEVKFyMMKUm0mMwI59obhml2dGRvnKlKJ+ueXI6XR0uuWgdfwx2bdpv11eXXry4aUjdPgk+14F9Op0+tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766348654; c=relaxed/simple;
	bh=WMwYvRuzVeCANwDXGEsdYd5ZoOoGGN7xJCYl8T27Hlw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Vj68eNtwn1Q784n5GekWBvnwm4Wdhu5+goy+Lqjc4sWo3424KRxyJpmWc/VL3H3iPBD7T/7f+SZbQXHE9FgzqXrq2bhiZhQG8g1Gj2shmxkv9Rg4R6OIkMAeYZef4WfzN5rd+vZW9mQP9abK7CXIx5T+SQ1EtSYcK9F7O+TylNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1UbcO3k; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=W4hKX/P5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766348651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W4PeecUk2a6L2i8pfYFYfBUlmDZOtnSSUja03gxfqdo=;
	b=E1UbcO3kSlbwuEHSisXrcfOs9HlNG72jzfnQMkiduIrAWFixYM4lMHgsIfY1Q/Yma5iADE
	z4i1kRc3Gg8ulHVSwfEkIs15gaMQZ+lA6jtKa2whEiGNSTqP8qCQQY5/yXl+MBL+XbRhOK
	yNiWP9ewLP9VgJ1H7u7chlQ6okYxV1I=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-ZvzP3eXvPEGg-lnArG6c-g-1; Sun, 21 Dec 2025 15:24:09 -0500
X-MC-Unique: ZvzP3eXvPEGg-lnArG6c-g-1
X-Mimecast-MFC-AGG-ID: ZvzP3eXvPEGg-lnArG6c-g_1766348649
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b6a9c80038so308868985a.2
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 12:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766348649; x=1766953449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W4PeecUk2a6L2i8pfYFYfBUlmDZOtnSSUja03gxfqdo=;
        b=W4hKX/P52UnzVjTp15qSI6Qzdwbz2uXTkE1HhlgRsbNXWj7IiPtp6mFsjQnyELBBWr
         8BUZE180k3qSCCH0424PHmzXKd9obmXGQkNpmjLhc87Z0/EvDgdTC1wcvgNUQ3wbfMPM
         3NO+OrjAwtleBp8yUnp8iW7RYmlJNbgPSY4j7A/l3DzhwEJk/aRA0Jz8fjwzFKcdIdRf
         BC8+Y2mhjVX+oJqRlk6R5LRIXUNTvVuJxhCRmM8o0BLQiKGf3lKA9NhxzbU6/IVpleQy
         eLaY3VkCqU+NBIm/crXghFc5pQSz7k4FcZvr2Wamz374nrKy7eZqvU2Df0hf+MuQK5lA
         cpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766348649; x=1766953449;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4PeecUk2a6L2i8pfYFYfBUlmDZOtnSSUja03gxfqdo=;
        b=JIMprF6Anx9EhRgmffnd+39ioYdtUS+ymSNzj9Xnc3f+loMJh668RUInPBlpfQbt3e
         KYA4OUaNeGtWCYgSfa+4PHKmiAHup5Edsl2BVwBmoR+Vec/LIE+UMaj77FG7fTBfrpU5
         aPJykY9tTekFc6P2B6tzjYqBs8LWKupk4lcrDekyNexNq5RiPOQ3/GN0B6Rhqnpk41vI
         oDuvk+SoEwWziU+mDvQ28+AbAmT69Q/JY0UbgcUBkRsqJs/4zv7AoeUVwAuE1ch/iwWa
         JFCBtQUxRsfVmUYbsY8NOZ4di7YgVu15l+J/j4LkBq0VXgW+TN8d5oqCOxqpMeJk91m0
         /J4w==
X-Forwarded-Encrypted: i=1; AJvYcCUYfb/CNAiRciYr8oKU7KR7zo4Gy9vGDPemMZ64p4w6wsuPGlZkRFEJwLALWorCDYOPl/pyYthA1EAvcTF/XF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOLux0iTOe46jpZ3uR8kooLHnlCPfidTmJXfI9CIIKwjYnAGbP
	nNS25yMf3115dWlsGbifwIF0WF6ntIzw98Yyg/fJM3/W+5qYpC1P/R4cIqVysQ9Mz8v+cOAoPBt
	ymiLAKx7X6S2XsNPQlTNxRhgizqR6PZw+rJHn7Mum0sxkSz97bOnWZNFSGllk3KojcU7T0g==
X-Gm-Gg: AY/fxX4GfSUcDKahQHl1wUtEM0qXSHpyPNua1t6v8Vqlq+SnPAHpRs4O/if0M0pYxRb
	II0SFIn4EKmGsNKCrWmpDaLEiazySzuiH2IMWBvqcRgZ1zufokDp0FFi4jaBhnTX9MMGjM7z5bp
	d+/3GpgMDlIpxYLcrUZrdonya65SdLozVICekjyV7tOMfwrOdzbtobHHa6FwmZSXdO5EDfHP/er
	poPMnOJKP/0Buwfb47aoL7JG3KmSax3P4Fq4ncq6br9notSViQmWpuYGIAwbEEucV1tAe6KwwCr
	q41n4nY0AocE6D7PWyXdVqt1pq3N9gF4/stvb59AEk1gY31nxeiXxfF2Iy+V/7jBDQonFTiKHZU
	XN+vsyEBbFjm8MqUX7ixPkOeT3jZI9Q++wtySiOOd17iZOCYZEyDbr6FB
X-Received: by 2002:a05:620a:7114:b0:8be:8e2a:3132 with SMTP id af79cd13be357-8c08fd2d107mr1368458985a.58.1766348649184;
        Sun, 21 Dec 2025 12:24:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELLPt/d8YPTRQPIvq2OfKTnGEFneF8fAaQ6NksD/z4JSDYjcG+7kGAIDZrrF7jvkRrURTZFg==
X-Received: by 2002:a05:620a:7114:b0:8be:8e2a:3132 with SMTP id af79cd13be357-8c08fd2d107mr1368456985a.58.1766348648807;
        Sun, 21 Dec 2025 12:24:08 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c096783a81sm679124985a.9.2025.12.21.12.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Dec 2025 12:24:08 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <94e2d707-94d6-4120-acc8-ee65f91af1c9@redhat.com>
Date: Sun, 21 Dec 2025 15:24:06 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] selftests/mm/charge_reserved_hugetlb: drop mount
 size for hugetlbfs
To: Li Wang <liwang@redhat.com>, akpm@linux-foundation.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: David Hildenbrand <david@kernel.org>, Mark Brown <broonie@kernel.org>,
 Shuah Khan <shuah@kernel.org>
References: <20251221122639.3168038-1-liwang@redhat.com>
 <20251221122639.3168038-3-liwang@redhat.com>
Content-Language: en-US
In-Reply-To: <20251221122639.3168038-3-liwang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/21/25 7:26 AM, Li Wang wrote:
> charge_reserved_hugetlb.sh mounts a hugetlbfs instance at /mnt/huge with
> a fixed size of 256M. On systems with large base hugepages (e.g. 512MB),
> this is smaller than a single hugepage, so the hugetlbfs mount ends up
> with zero capacity (often visible as size=0 in mount output).
>
> As a result, write_to_hugetlbfs fails with ENOMEM and the test can hang
> waiting for progress.
>
> --- Error log ---
>    # uname -r
>    6.12.0-xxx.el10.aarch64+64k
>
>    #./charge_reserved_hugetlb.sh -cgroup-v2
>    # -----------------------------------------
>    ...
>    # nr hugepages = 10
>    # writing cgroup limit: 5368709120
>    # writing reseravation limit: 5368709120
>    ...
>    # write_to_hugetlbfs: Error mapping the file: Cannot allocate memory
>    # Waiting for hugetlb memory reservation to reach size 2684354560.
>    # 0
>    # Waiting for hugetlb memory reservation to reach size 2684354560.
>    # 0
>    ...
>
>    # mount |grep /mnt/huge
>    none on /mnt/huge type hugetlbfs (rw,relatime,seclabel,pagesize=512M,size=0)
>
>    # grep -i huge /proc/meminfo
>    ...
>    HugePages_Total:      10
>    HugePages_Free:       10
>    HugePages_Rsvd:        0
>    HugePages_Surp:        0
>    Hugepagesize:     524288 kB
>    Hugetlb:         5242880 kB
>
> Drop the mount args with 'size=256M', so the filesystem capacity is sufficient
> regardless of HugeTLB page size.
>
> Fixes: 29750f71a9 ("hugetlb_cgroup: add hugetlb_cgroup reservation tests")
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> ---
>   tools/testing/selftests/mm/charge_reserved_hugetlb.sh | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
> index e1fe16bcbbe8..fa6713892d82 100755
> --- a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
> +++ b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
> @@ -290,7 +290,7 @@ function run_test() {
>     setup_cgroup "hugetlb_cgroup_test" "$cgroup_limit" "$reservation_limit"
>   
>     mkdir -p /mnt/huge
> -  mount -t hugetlbfs -o pagesize=${MB}M,size=256M none /mnt/huge
> +  mount -t hugetlbfs -o pagesize=${MB}M none /mnt/huge
>   
>     write_hugetlbfs_and_get_usage "hugetlb_cgroup_test" "$size" "$populate" \
>       "$write" "/mnt/huge/test" "$method" "$private" "$expect_failure" \
> @@ -344,7 +344,7 @@ function run_multiple_cgroup_test() {
>     setup_cgroup "hugetlb_cgroup_test2" "$cgroup_limit2" "$reservation_limit2"
>   
>     mkdir -p /mnt/huge
> -  mount -t hugetlbfs -o pagesize=${MB}M,size=256M none /mnt/huge
> +  mount -t hugetlbfs -o pagesize=${MB}M none /mnt/huge
>   
>     write_hugetlbfs_and_get_usage "hugetlb_cgroup_test1" "$size1" \
>       "$populate1" "$write1" "/mnt/huge/test1" "$method" "$private" \
Acked-by: Waiman Long <longman@redhat.com>


