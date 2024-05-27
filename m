Return-Path: <linux-kselftest+bounces-10703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976288D0223
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 15:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EACFCB2BFD2
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 13:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5497715FA7A;
	Mon, 27 May 2024 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hEf6kgG7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BF815ECFE
	for <linux-kselftest@vger.kernel.org>; Mon, 27 May 2024 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716817176; cv=none; b=klL69pWgNAB9LP/pd8C2sBQWKIp408u0lMMtOBYx/I8QuuGSq2Lrq7He6WJPIqFI6WTJYPwQ/vTYd7eTZhxDqLQFymFEXuY/b5swNOKHSYWCkmCMErYISW/Gp0IB8XePOJ94xkNATb5/q4G6+GslZrG5g4qlzVqOeuqS8tgVFEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716817176; c=relaxed/simple;
	bh=KDhroGorFCsdiRgWfSYZTVn5iZsTxCHBgOFLmn8xgPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9bc/1hMjnZNePfuwIZl2yWpoL7z/1khRzsamuWmwJl5lJg+P9H8TKIz4jrPFqk9CZWzykwqABhMHDsZAf4HmlxAy1VCFgkUMrSBj7zqaGKugPoE4g4VFR0R36KPD+EFU6+kAF9N9RThdMs6UZLnbbrVzs9tkDa7XTPp6lEPiMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hEf6kgG7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716817173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2eC1AqL9QH4TVSIhzgj/eAmDmIh2MF6QUCJEMwiWIh4=;
	b=hEf6kgG7EQWP9OOLF1Barx7+2rADwTNJck3TjD6IqcFK/VexArPDxo7d1yhzBqNGxDF6sW
	U64i3XodQKDx3Jb2BBb12njLyz+4R+hqwLs8krqGVgP+bD8xxurMQSSr8ia7HZ08QbbEK3
	0UgQKETcFoCOZgjVvbF/WJo2tDuH/G0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-iP535LRQO9etkWbU7dnvBQ-1; Mon, 27 May 2024 09:39:32 -0400
X-MC-Unique: iP535LRQO9etkWbU7dnvBQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-354dd6b61f8so1652910f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 27 May 2024 06:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716817171; x=1717421971;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2eC1AqL9QH4TVSIhzgj/eAmDmIh2MF6QUCJEMwiWIh4=;
        b=oRCKQfkx3l4gEIUSTQtNxlqzbUyUxyh2UxCQwAppMBitncUkggSVLG7IHd/I4wa+20
         ZmgaXEUa0kPTiguThk0J2S3nb6dRu/ymwbiGGwK1jsmmRtW7iEzT31Ud5wW4OpI7CzBY
         4VpAyMq3B4mh5xEeeLHG2rDsShEl0mg79e40u/SCAPjkWAh9j/LLxin9MIvbXkXv0hoo
         iTigKoGLUfHl6p2bR98OPZhjooocPTsbZC6CIvEz7TGQfLBnDwdIXaeQuYmYLULlby69
         7+GT/MQUY2uSRSAH1oplP4w1k1N0+3mbLtyt4Hc2IUBTSuxLHPpvEyW2VQfuAyDVfc5+
         Irpw==
X-Forwarded-Encrypted: i=1; AJvYcCWToWcRPppNKPn6f7WBbJ/kB9zEzCIBPd/mGFRNeQMqAQrkacsTkJq61IoPyB3GAAQ52ZJj2R0WXTVocjoM4HUSu3GHmGI4Iebuff100kPQ
X-Gm-Message-State: AOJu0YzzDn+HT4xGv7OxHpfbny6o+tvEIwlwLLCUoN9Wmbtf4+8a0kwH
	9ef7KTiKDTqGNNB/vLP9NkpK5X+wh7MdbprEYBjcjOkTdINA2+laK7ZDcIguBX6jQhP0vQ7qla/
	niSqG/ifuZ493kDCLS8x6Vy93frBQYrQ5fTN+PuJr1N/R08k1bEbuUJqzd+LFAnU6ug==
X-Received: by 2002:adf:ce91:0:b0:351:dab1:1c72 with SMTP id ffacd0b85a97d-3552fe19370mr5518358f8f.47.1716817171288;
        Mon, 27 May 2024 06:39:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJi2vIIxWHVtVaqrk9KpM8qaLYbVgc0Qr6RygT7+fixJZT0bBXLoaHrSAeKoaGf+A5cmf0/Q==
X-Received: by 2002:adf:ce91:0:b0:351:dab1:1c72 with SMTP id ffacd0b85a97d-3552fe19370mr5518342f8f.47.1716817170911;
        Mon, 27 May 2024 06:39:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4600:d3a7:6c26:54cf:e01e? (p200300d82f284600d3a76c2654cfe01e.dip0.t-ipconnect.de. [2003:d8:2f28:4600:d3a7:6c26:54cf:e01e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557dcf08basm9271206f8f.108.2024.05.27.06.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 06:39:30 -0700 (PDT)
Message-ID: <6f2da186-be75-44de-bc3a-e7f6d0e23498@redhat.com>
Date: Mon, 27 May 2024 15:39:29 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: hugetlb_madv_vs_map: Avoid test skipping by
 querying hugepage size at runtime
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, shuah@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Anshuman.Khandual@arm.com
References: <20240509095447.3791573-1-dev.jain@arm.com>
From: David Hildenbrand <dhildenb@redhat.com>
Content-Language: en-US
In-Reply-To: <20240509095447.3791573-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Am 09.05.24 um 11:54 schrieb Dev Jain:
> Currently, the size used in mmap() is statically defined, leading to
> skipping of the test on a hugepage size other than 2 MB, since munmap()
> won't free the hugepage for a size greater than 2 MB. Hence, query the
> size at runtime.
> 
> Also, there is no reason why a hugepage allocation should fail, since we
> are using a simple mmap() using MAP_HUGETLB; hence, instead of skipping
> the test, make it fail.
>   
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---


Likely it would make sense to rewrite that test to try with all available 
hugetlb sizes (like cow.c does).

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb


