Return-Path: <linux-kselftest+bounces-37128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA8CB02096
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 17:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1878A60533
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 15:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3473C2EA722;
	Fri, 11 Jul 2025 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCiOQl9L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821D02EA484
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248387; cv=none; b=h8FDkb/QSA9dEW9E1bYT/yfskYvW54NFJ/XY71B6FLSccS2cNPlv0IZS3vWsLMPvr44qt0VahEwRmWXmhSxrDsO6fw/zwp7oY7StnR+xiMMTbOGUtW7rIuvShWueDM6MNQYijL7BBvPTso2ghZBK7fXPWS2XmZAAm8RJWJ08u3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248387; c=relaxed/simple;
	bh=iDKvWVGdWzMvrL8epAVRrvAHvMZ70CWnf07tWeBNJM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XCsydviAFtNG1R4M5DlFQLDOeKdjC+q/F/viJqQurjwecHwsJUfcXi39ZY9AQ3FxYHP3AvxKoZpXTF0mTaYYhptmjE1fPo2Bpf4th+hdA0yJzMkyj1dDNXnibqRDH5SDq5Lf6XzkcFK2HdtRX0OQS2j4wbUB+7whxDr/O97QDAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SCiOQl9L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752248383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Op6OwT2dIq7TRp/R6vBF63A8ufBZSZflaHEUGioL84E=;
	b=SCiOQl9LxR1IGXt+97Xir0Mixj5jLPrdLPkBORGXN4r0/wczxyjORiOxl9NElHYQmoDifP
	e2kE3gH972/M35wQ1OWwyBvtc5sThBIQZQpuaEaSFSBV5frktZBHUWG/3w8qzG7drvLDC6
	TuTHSbWQT0p6Xgsm9qDfsITzEhU2bg8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-FqavdLcmPv66qHN2k1dDrQ-1; Fri, 11 Jul 2025 11:39:42 -0400
X-MC-Unique: FqavdLcmPv66qHN2k1dDrQ-1
X-Mimecast-MFC-AGG-ID: FqavdLcmPv66qHN2k1dDrQ_1752248381
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a6d1394b07so1552360f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 08:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752248381; x=1752853181;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Op6OwT2dIq7TRp/R6vBF63A8ufBZSZflaHEUGioL84E=;
        b=MheotfBvQzxTyqjdf3keF8NRMRorEVjsUlqDLLSuHJ/BsMAWqz/0cVARmNSifdE4Vo
         NnhslPTi0ERXVdViHDBuad7BRq2gyFmXtMh+5S1Ec69cxRjcJbbqYRTeojdjETH4yW7s
         19+zrMeefORcmbikRPGVvnsD/JttDQbYyXoRqmiuJ2R/8VRsjMzSgV6h28ZLgUg2TVAj
         9WeztBt9lnI2t/yDUk7RxcHQcyn8p5RPtWOdAm9SAt6GR6cER5hyz2BLhf2FDAp+wJUO
         yAhOW9sWl4WGjXasFdTYwS0KkSWcUXxoxi6uh0HlbbDHGygBZhNG4sPSD6vrKqdEhc1T
         FHFA==
X-Forwarded-Encrypted: i=1; AJvYcCV6tbEUrD2TXOJK6/08X3olNwy3vsBczcbGPZfSGpLPJqkgD9IWpNexCMhjIJQmo65sAFTjobDcQtlfTN0hNmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwepxD0O6ho3b6ud2WsezmHDqDXUxjAyK1JHtvR5UfFA5M7QAUn
	TRAco1n5HUWQBQcRoHzoU+ZmpqSp9GggK6RflLMVB0qYOaSepB8ioePp5NU363gr1LA1TzbP9KZ
	8O6N1FTvJC+ghAMjF4BTYIkERmCk5KE7JMZbr+xnKa48FsZgzGHOBCo1V64/VhJidgsRtlw==
X-Gm-Gg: ASbGncu0mgYdgaGbmyZDg0zsjndVoIiAwQ6Gz524PfHyxt3xeQJdKkbeBMxtpeL5rFZ
	2WBU98DAEKCh0zpcfdtIs4XHnbGZ9EBvCrlD2HYhY3qWVPzKqHAnXvL/oJo4y69nnZePQzA+Vjk
	5Uu7pgIH+uoUIWuw1X1eJxYpm1NgX7cWovbdWjFtKitq4Dhkqml1E8Aufrh6JQ1C83NzBb2GrLW
	78VjyQ8W+DxRK6LEUFV8buJ78bO2VIUiqXhFZ33nH/hKgYkjLAd4qOKusqRvJNQjjtYxJMwX2Ye
	iovzdo0K9Cp32wexChxu6ofgBelNn26NZ2sE/NaDP5BH/XvXpUDRv1IvsLsEaMf7ZWZkI1ryLqR
	K15Yb+VQ29UUzucvD3DQeL48gPQm48p9cfTZb7raALTotkxaoGV7yN4RfEBtAWgLN7dw=
X-Received: by 2002:adf:b60b:0:b0:3a8:6260:ea91 with SMTP id ffacd0b85a97d-3b5f1895c8cmr3646522f8f.40.1752248381083;
        Fri, 11 Jul 2025 08:39:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnCvzMyyEvyFYKJ/g85mv7riQ/Gzevo+uU0d/PPhHA1F1yEXgvZJwfRI2MzCk0eFRbUWeXug==
X-Received: by 2002:adf:b60b:0:b0:3a8:6260:ea91 with SMTP id ffacd0b85a97d-3b5f1895c8cmr3646495f8f.40.1752248380600;
        Fri, 11 Jul 2025 08:39:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26c97sm4840237f8f.90.2025.07.11.08.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 08:39:40 -0700 (PDT)
Message-ID: <2ee1d2ca-94c5-4c27-b2dc-bcea2b710dcf@redhat.com>
Date: Fri, 11 Jul 2025 17:39:39 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC Patch 2/2] selftests/mm: assert rmap behave as expected
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, riel@surriel.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250604082145.13800-1-richard.weiyang@gmail.com>
 <20250604082145.13800-3-richard.weiyang@gmail.com>
 <20250604083441.hilkdzlxmxygivvt@master>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250604083441.hilkdzlxmxygivvt@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.06.25 10:34, Wei Yang wrote:
> On Wed, Jun 04, 2025 at 08:21:45AM +0000, Wei Yang wrote:
> [...]
>> +int try_to_move_page(char *region)
>> +{
>> +	int ret;
>> +	int node;
>> +	int status = 0;
>> +
>> +	ksft_print_msg("worker %d move_pages of content: %.15s\n", getpid(), region);
> 
> One thing confused me here.
> 
> If I don't access region here, the following move_pages() would report
> -ENOENT occationally. The reason is do_pages_stat_array() ->
> folio_walk_start() returns NULL.

Right, the pages were not faulted in. The man page mentions that as

"-ENOENT: The page is not present."

-- 
Cheers,

David / dhildenb


