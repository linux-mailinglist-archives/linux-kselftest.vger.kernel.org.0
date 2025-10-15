Return-Path: <linux-kselftest+bounces-43172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBE3BDD81D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 10:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E7BE4FBF6E
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 08:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9133176EB;
	Wed, 15 Oct 2025 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQL/nZo9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E393148CA
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518050; cv=none; b=jhCAZ42rUFpbKZ4MKX6n6AR3dF9FuMmjzV/tHAW8KTfYLrBgYAsMbKMSteiDQPN1Lgfceg+HLzLys9XmtfWwrAEurEN/kpqzGkQ1AWo7Bxi/GQ4JxD2CLzuPfgA8zRd1zSwbYWAfZ/OSRUbjU7msIv7zh9lz6MzNPT+8HfG77bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518050; c=relaxed/simple;
	bh=14n35NeqXA882vKlokyVCkeUKE/sM8X/UlP5wTGO0LQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i63W//YlkPr1h7UDcDKMJTbdsWmpi1IyNHRiFZY3kI3uYznWubcBywjQeR7UyyIX+oasJHIzOUl4LtaBhhDcdFzb3/anYASEVRPG/rbC9eWVDynr2IBkdKSlt8W0OWW2JY1/Zr8sc13KUC9JHTeRCjiZncyLbnl+H0mX+iO99lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQL/nZo9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760518047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mvDmNeoCngAvqfFphlxRaIVqa4lNYICD47e+Hsgb9Ec=;
	b=WQL/nZo9V7BHXTvmO6LR4Od4qoVUeNxOlHbh5Bp8qAAwtEqHybbBJZKv03+MFSi/1TwuXH
	SNWjjAznDesJboh0BLvZfOKpATQCcjjwT2odJjgCUmasaVTVhgm4W4wDJ/jvC8qxEaz3hw
	ugSN+cMnRsqUDsdWCVpNJR6Fz53yH4A=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-RA7TlTgbPTylM5IaH70dWg-1; Wed, 15 Oct 2025 04:47:26 -0400
X-MC-Unique: RA7TlTgbPTylM5IaH70dWg-1
X-Mimecast-MFC-AGG-ID: RA7TlTgbPTylM5IaH70dWg_1760518046
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-88e133107adso207991085a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 01:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760518046; x=1761122846;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mvDmNeoCngAvqfFphlxRaIVqa4lNYICD47e+Hsgb9Ec=;
        b=aG4uMW//7mJim98gHvB5CCoO+HoNTvPI1concfmQaiTJ1wmGTmYBMIZPPcZCZRaAfp
         jxsfRL0vbcnnrH0g8pQUrl0JG3SmkXaV1Be9fDfJjUePX5WBVkjBx+S7+cxyyFU6QrHE
         8VyLKg4yEDugcxuq3BOGarl3S5RNZmklrfLITBhVPDk+2z5pEG/SdIY5YAsWH1fbbPOk
         JwzB+43FzIbvmieQD3ryzFf7iVB61oJvCbVcoXGgyFt/Q4yurMnIaQaJymTmafn/lK30
         WJ+j4zFCtqjmRmpXYIDb7Noeh7OXUHqBHzNyvPLiiw3ZTnZejdxRBTl24Oq5TWBghvJj
         zTdw==
X-Forwarded-Encrypted: i=1; AJvYcCWRxG/p49PQg/09h1SC6nhwUhIEMb6qX9gIVDgxVYYCYH+T6yPyFLEL90m+shu4EaBmh4LY0fxPjUDfZW7KvOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR3QK4JqJU6LYpRKTOlVT+3zklfvyvuaqdU+ZiKlgOKSy4SRDj
	g/Ue+Ar1oQcRDN/ZqZYKVaBc3zqXp68t0+Covr5GGY/B1bWTi6mCe0qvVHXZXKNCnUMDgfJCJtm
	VjUyWcBIRkRJLOU4XxzqpLop9hzx8zUqwhx5KFuyYVHOtnLXEJvzQc6gzOYJJ8xL54zlAEw==
X-Gm-Gg: ASbGncuvhXTIhUNU7EvzKOl+jnarlKBz52uyNOtO3irGdaQ92EmwQtiGCE0h0TKTXFT
	NM0a/wKeZ6GoB8r50J/U+YIRLS+pcGvyUqCzVCSMIsRCLGuv7CPznOYxPnUCpW0qdQ4VYo7zv8P
	WEVhNdyYygIglv20hIorK3zFGIKBb0iDfYLHsHZE2eOBrE9XLhD9ZvsxytAlaifAZ7I9vHseDuV
	20Waa0MT3ZoHPvDPDjUSUvVISCXkJcLMibvwaxc/6fpSjBVf5hYDAjY/LBfpp3NL3wumRnWL6TS
	iZ+owU+1kClK/aPu2rh8SVrKcTZsjKntSxDo2MP91A3JS+7V83GI/D+/bGrEfJc=
X-Received: by 2002:a05:620a:288f:b0:862:ab87:ce6e with SMTP id af79cd13be357-88353846127mr3526612985a.27.1760518045766;
        Wed, 15 Oct 2025 01:47:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyPR7ITdiSnustS+ancsME8Nm74/0O7iLaBKc+qKE60Y+nTtzXmrVeAynkx03IohwzGSYLUg==
X-Received: by 2002:a05:620a:288f:b0:862:ab87:ce6e with SMTP id af79cd13be357-88353846127mr3526611385a.27.1760518045338;
        Wed, 15 Oct 2025 01:47:25 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849f9adb31sm1357375685a.19.2025.10.15.01.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 01:47:24 -0700 (PDT)
Message-ID: <9c323deb-ded8-480a-ab96-34ea47194a16@redhat.com>
Date: Wed, 15 Oct 2025 10:47:21 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: selftests/mm/rmap: verify correct RMAP handling of COW pages
 after fork()
To: Itamar Dalal <dalalitamar@gmail.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, riel@surriel.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
 jannh@google.com, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 shuah@kernel.org
References: <CAJoePDqCd6F0ai1itmVATawqMQzB+JRi4NUtMJtxyeOVOT56VQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAJoePDqCd6F0ai1itmVATawqMQzB+JRi4NUtMJtxyeOVOT56VQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.10.25 10:33, Itamar Dalal wrote:
> Add a new test `migrate.cow_after_fork` that verifies correct RMAP handling
> of Copy-On-Write (COW) pages after fork().
> 
> Before a write, the parent and child share the same PFN. After a write, the
> child’s PFN differs. This confirms that proper COW duplication occurred and
> that RMAP correctly tracks page ownership transitions during COW events.
> 
> Signed-off-by: Itamar-Dalal <dalalitamar@gmail.com 
> <mailto:dalalitamar@gmail.com>>
> ---
>   tools/testing/selftests/mm/rmap.c | 45 ++++++++++++++++++++++++++++++-
>   1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/rmap.c b/tools/testing/ 
> selftests/mm/rmap.c
> index 13f7bccfd0a9..2ba3361fecf0 100644
> --- a/tools/testing/selftests/mm/rmap.c
> +++ b/tools/testing/selftests/mm/rmap.c
> @@ -430,4 +430,47 @@ TEST_F(migrate, ksm)
>          propagate_children(_metadata, data);
>   }
> 
> -TEST_HARNESS_MAIN
> +TEST_F(migrate, cow_after_fork)
> +{
> +       struct global_data *data = &self->data;
> +       int status;
> +       pid_t pid;
> +       unsigned long parent_pfn, child_pfn;
> +       int pagemap_fd;
> +       char *region;
> +
> +       /* Map private anonymous memory and fault it in */
> +       region = mmap(NULL, data->mapsize, PROT_READ | PROT_WRITE,
> +               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +       ASSERT_NE(region, MAP_FAILED);
> +       memset(region, 0xaa, data->mapsize);
> +
> +       pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
> +       ASSERT_NE(pagemap_fd, -1);
> +       parent_pfn = pagemap_get_pfn(pagemap_fd, region);
> +       close(pagemap_fd);
> +
> +       pid = fork();
> +       ASSERT_NE(pid, -1);
> +
> +       if (pid == 0) {
> +               /* Child: write to trigger COW */
> +               region[0] = 0xbb;
> +
> +               pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
> +               ASSERT_NE(pagemap_fd, -1);
> +               child_pfn = pagemap_get_pfn(pagemap_fd, region);
> +               close(pagemap_fd);
> +
> +               /* Expect PFN to differ after write (COW happened) */
> +               if (child_pfn == parent_pfn)
> +                       _exit(FAIL_ON_CHECK);
> +               _exit(0);
> +       }
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_EQ(WEXITSTATUS(status), 0);
> +       munmap(region, data->mapsize);
> +}

We have excessive cow tests in cow.c, that are independent of any PFN 
checks.

So I don't think we need this.

BTW, I never received a mail that shows up right-aligned in my mail client.

Seems to be because of

Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"rtl"

The whole attachment should be dropped. Did you send this with 
git-send-email? :)

-- 
Cheers

David / dhildenb


