Return-Path: <linux-kselftest+bounces-39167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7A0B29223
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 10:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8683AA2F9
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 08:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44A120ADEE;
	Sun, 17 Aug 2025 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FEimq962"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212207E107
	for <linux-kselftest@vger.kernel.org>; Sun, 17 Aug 2025 08:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755418029; cv=none; b=ThUPSkB6GAtagqJycruSppzzFUNHenInHmIpaJ9U77cKx86tUwfZfTCMQ5fpRYDrLUfmUY1wyJ1YTfIo3pTaKHfEBWOHu3nRGbu0HZV09XV9smrGBvM0kgy7X7vWIn88u29OVbVXdMUZI4v4i21ob6xn9KdQpM3IEj7rJRPyVqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755418029; c=relaxed/simple;
	bh=b34IIFoIzX6q6W9maIi9XbuBc6ZoYqWIty3/Gl6Aa1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GftlyFsvTGiqB6WY49W4fApfdagGZtPKfCX6KhSVAiZLbxfoulg//KKd/+GGu3Pv9GqpVxb7qe7K8M+kppCIbxY1JmBGkRXU4DVneDMi7VCW430rqinPstjOsK/Jmq+RDlWm6lrANVBhC1T6L48VQarX5E+fF4W2UJs1/IaNsqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FEimq962; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755418027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oXCR6jx4ey42aR655U9PtXbjqfLl2uQopYEZjH9HCRE=;
	b=FEimq962U5BvlrTsVYx6VW6gGbHJ+ozrc08ECa0XxXb4HBiDnquOq6BpI40B4ymuxVdb22
	2RKyCd0yaElpxqBIsBRdcQLsGW38+rSPqqMxhbZKjGHH7vtBQS4mlMpGWbyIGM5WK4t0Fr
	CZM5inHf/UWlBz1iZC2v0Pl4pdmWTcY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-4aylwWfCMjqMMVzz_hvTrQ-1; Sun, 17 Aug 2025 04:07:05 -0400
X-MC-Unique: 4aylwWfCMjqMMVzz_hvTrQ-1
X-Mimecast-MFC-AGG-ID: 4aylwWfCMjqMMVzz_hvTrQ_1755418024
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0b2b5cso19684635e9.2
        for <linux-kselftest@vger.kernel.org>; Sun, 17 Aug 2025 01:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755418024; x=1756022824;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXCR6jx4ey42aR655U9PtXbjqfLl2uQopYEZjH9HCRE=;
        b=QKY7W0ziVeN+S45UZY3rPoj5YPlYtDSg/2f2yxsBbC/mH7ybRttmZxuMt33GqQU0xF
         osCLiRQLk4ePlwFasxnTyZ/Yx5j5e1GSsG8QuPfO7Zu9Lm/6m2mXaeDMPPzCNLkOOF/k
         AvTPkRS3IkKV4Dl/bgT3LNiv5GSww7Gf96sqJtajYAebYo1Jpdu75zvsbbBu+PwSDPPX
         vDsy+m2Xe1WvRFQHU+2qK9Nk3xngl37py/3zIySSvEe7ChGzBtK3/oWB1DFz2G0zS6J5
         UUKKiq2fXM+kz2ZFn5m+IUrpzm2TFRn//WUSVm23ThgzeqQVbMsFOE5LgFaaHLIBw1p7
         Z9pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu+90Hws/XDGSubGqCRrNO7CJ6oEuyiwIN9twazpkjedZdiQGopoV343IfwbuciuV0oR28T/YbYfq8Nq3wCO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydopyJ/D+tgS/kTM85wU98BPm+LBZukXbTcJmfXq3RN9HfeaX2
	J2UHV9rdMJWBnW9XcZUs15PofxVA6Lk0IsJaQMT0RmCy2Si20mfoysHpgvrV21UkU8QRDwL1vWf
	ma59xEYvUTNJiKaGCBtWJnZKYOwSXmxhQ34+0XBhCFoL0c7wkXWtAXrT05rpQVd+4vvRmdw==
X-Gm-Gg: ASbGnctxa39VlvQrQWohdDyFhWaf9PNizefN2DiS1o6WV8nOqzGa0EpkZk2NYtkwqw3
	PzkB0gYkt/aZtSxO7BJQGeHSDiaKUe5QwqTIHEv+JZy6EUlhhY5IOB3gCVv5SOcn3ccCGlcW2NK
	bteQzVSnpjlD8F/JAyvlTW3EQgfLZ88lqVNe3lEUuol67P+CJJtuKHjA4wMXGKVoGo2yDB3Kxhu
	kEq8e3UotiHe4fXirx6JGf1IHu32FjCjD6wKYLFRwcGYpAz+GEFzlukiPGY3tr6y+kyfOxAArvR
	mAOh4D6kbxbIp2PjTB5J0VcvbxTUiI5/6EjDy99IlQYjg09dNMm2l16lmqyw1lccbypRqtPq272
	w8+5iXKDrKpW7iUZmq6ftM9Ey+9CNueoaZpRgTRCOcbc5U9Kw0XRXXIDhvYTYWmeihzU=
X-Received: by 2002:a05:600c:4f89:b0:455:fc16:9eb3 with SMTP id 5b1f17b1804b1-45a2679b098mr31050595e9.33.1755418023909;
        Sun, 17 Aug 2025 01:07:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELs9JlOUQoCDAv7GOq3qlfRmrWqshCbe5IY8nTGKMjFukcAnSW5YEjUHnLDr5jRqTIMYyWXA==
X-Received: by 2002:a05:600c:4f89:b0:455:fc16:9eb3 with SMTP id 5b1f17b1804b1-45a2679b098mr31050285e9.33.1755418023465;
        Sun, 17 Aug 2025 01:07:03 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0b:a400:87b2:80d2:3e99:1b85? (p200300d82f0ba40087b280d23e991b85.dip0.t-ipconnect.de. [2003:d8:2f0b:a400:87b2:80d2:3e99:1b85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c78b410sm127199905e9.24.2025.08.17.01.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 01:07:02 -0700 (PDT)
Message-ID: <fb4d74b9-a92a-4040-8d3a-09c72db3f35a@redhat.com>
Date: Sun, 17 Aug 2025 10:07:01 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] mm/selftests: Fix split_huge_page_test failure on
 systems with 64KB page size
To: Giant Sand Fans <rampxxxx@gmail.com>, Wei Yang <richard.weiyang@gmail.com>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "shuah@kernel.org" <shuah@kernel.org>, "pfalcato@suse.de"
 <pfalcato@suse.de>, "ziy@nvidia.com" <ziy@nvidia.com>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 "npache@redhat.com" <npache@redhat.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "dev.jain@arm.com" <dev.jain@arm.com>, "baohua@kernel.org"
 <baohua@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "donettom@linux.ibm.com" <donettom@linux.ibm.com>,
 "ritesh.list@gmail.com" <ritesh.list@gmail.com>
References: <20250816040113.760010-1-aboorvad@linux.ibm.com>
 <20250816040113.760010-5-aboorvad@linux.ibm.com>
 <20250816143129.u2rdwpwvfhsdptvx@master>
 <CABPJ0vja95qLmJA3uRa3MhCfDX3GoLJ6MHu881Z=sZuVdBbbEg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CABPJ0vja95qLmJA3uRa3MhCfDX3GoLJ6MHu881Z=sZuVdBbbEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


>  >>diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/ 
> tools/testing/selftests/mm/split_huge_page_test.c
>  >>index eadbeb820d71..7cbeaebc9d71 100644
>  >>--- a/tools/testing/selftests/mm/split_huge_page_test.c
>  >>+++ b/tools/testing/selftests/mm/split_huge_page_test.c
>  >>@@ -523,6 +523,9 @@ int main(int argc, char **argv)
>  >>       const char *fs_loc;
>  >>       bool created_tmp;
>  >>       int offset;
>  >>+      unsigned int max_order;
>  >>+      unsigned int nr_pages;
>  >>+      unsigned int tests;
>  >>
>  >>       ksft_print_header();
>  >>
>  >>@@ -534,35 +537,38 @@ int main(int argc, char **argv)
>  >>       if (argc > 1)
>  >>               optional_xfs_path = argv[1];
>  >>
>  >>-      ksft_set_plan(1+8+1+9+9+8*4+2);
>  >>-
>  >>       pagesize = getpagesize();
>  >>       pageshift = ffs(pagesize) - 1;
>  >>       pmd_pagesize = read_pmd_pagesize();
>  >>       if (!pmd_pagesize)
>  >>               ksft_exit_fail_msg("Reading PMD pagesize failed\n");
>  >>
>  >>+      nr_pages = pmd_pagesize / pagesize;
>  >>+      max_order =  sz2ord(pmd_pagesize);
>  >                     ^
>  >                     extra space here
>  >
>  >>+      tests = 2 + (max_order - 1) + (2 * max_order) + (max_order - 
> 1) * 4 + 2;
> 
> Is it possible to have some defines here instead plain numbers?
> Thanks

I assume we should look into using kselftest_harness as a separate 
effort, so we can avoid this manual test calculation completely. I'm 
afraid even using defines will not make this significntly more readable.

-- 
Cheers

David / dhildenb


