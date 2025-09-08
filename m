Return-Path: <linux-kselftest+bounces-40945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F683B48E36
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 14:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B06447A1681
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 12:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302DE304BBF;
	Mon,  8 Sep 2025 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VK9GQjG5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4516304BA2
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Sep 2025 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336039; cv=none; b=I29j19FxtS8QJ5bhTjmh+8mu31MDP4SgAVYXwoytZV0JxyJEDHPh8CGuZWUItudcTNzIF+5dq9RyWtGJfJXNt1Pf1kO53PjVfwOVCpbvDOhwTntBhsLCh8WSeJ9k/WqOYvQDutFtsmPMMchuRkgIgqO5LFz7I1HhmhJWfTochuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336039; c=relaxed/simple;
	bh=233OW1LFydMeXOb8xSOoWvm9e3erkbWg/G1Yy+tesvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Av6JjxJB+6P6UeJFuWMMGZrQQ1E9ihUltcIxxKBvVj55cmgrlqpsRk4mIlim7VRmnBwHtl1UyosFwq456xOkN04cDCksY/R+MEwo81KKzItsdhkfr4l+UHVjzU0RgtBpVcPABwnXC7/K1Q0t4wi63KpLfPM9gvsGjSVrLCwJETc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VK9GQjG5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757336036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BLOEr+YqIuXqBDrjXURDf2AfCeVrrz6FeaRsnrIi6vs=;
	b=VK9GQjG5xv/vI0N8Y57zPDjTiMlFTxqH8yJE5L3Rfy8MZYnmBnNKpQJ9bZGPeawfGYeNki
	xI3rZvRlNj0DilPQD3A+ZIaY7ofhnoYMEkdoqu6d35vC25qH1Km8rz9jcgUpFnl6cc8NJa
	YRW6otvNKzAZCvnTejyEC0kvSdBk3/U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-e2c0Ixv1M0O-qDwe5eOOTQ-1; Mon, 08 Sep 2025 08:53:54 -0400
X-MC-Unique: e2c0Ixv1M0O-qDwe5eOOTQ-1
X-Mimecast-MFC-AGG-ID: e2c0Ixv1M0O-qDwe5eOOTQ_1757336033
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3e26569a11aso2130043f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Sep 2025 05:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757336033; x=1757940833;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BLOEr+YqIuXqBDrjXURDf2AfCeVrrz6FeaRsnrIi6vs=;
        b=bA3aPGKIztHaxweqdZFqS4NLNMTu0fVgEWmEWBiPI/DtsLPpAZ7O6tUdt4Cr1cQXVK
         WYDn9fAatHu2vNaSkWidfaX91vwQ6H8CASxa7in8Ks/qgTy0YvPVeE9HeBebEgtoIxvv
         VH4tYdUJkqE1yBsMZkz8u+7C/ZiG6wy0TbJfH+T4ZZEmyJpnjeh2QXqJD3mdk8wpnFs/
         nVTWFQh6z/Vn40m6qi9h/HJYy2yXbz+a7rDGVZiJ1ZKT33U1ajLWrmPBlGBJAANSjlbv
         MdLnEuuB0VxbFwVaAdK3k+BTdjgnb9/je4km8Odl46oBVhy5AFWs21xIsK/aHR0w6O5W
         +mVA==
X-Gm-Message-State: AOJu0Yz9dko/vhCFlAtDPOiaz5II7wCV28oQbR/gmZO7KWbIwenxRXTW
	JoBZ4Y6IxvcWPHV2dFSzc9mmmzBlEVW4GgxciI/oWuw5K2vrrMgdJQYHpted6qPzuP2pfKV0J/O
	Kk/WyVnqvUUBff3+9EMWyzf7rd+B8BNYuONvwOAgNO+Deshmtq8DOGyfyWxcpZY1rk7nu1A==
X-Gm-Gg: ASbGncukrVjl8mh+jotmik7ckbjPvrbs8mAmd4V1uk1GBu/ulNw5NDwqsPFdWz33iFF
	b6QVFp3xbJBq+oVhKP9zbUiGRs6c3UjrRnNZ8Iv77me5KZPboRc6pIHsmTHM1QMIFgfpkvkw11S
	PZAg6Ljo2hKVfjS/7YCQtiKlCOBEeOHlLUxsL8GV7onDqM4w5CZKeI3dTMke/Zh7q2SIqYkGJ9x
	LDwQObI/+p2ig7cKJI4wPgoUsBMM5IN/4NAiQYe8kg2U4+yyKJxqacLC8AuvPZxDlhD/KbxwScL
	vjp8UAwH39MvHKOpJD1btP2zkMubusH9la93r63AGDubPfWrdGpg3oz8/mIZillJVNbSmKPV3BX
	pJ47hUAUhV1ChcjDhnhz65hoZXgT8i4W/OGMr5PiNcjwI5mhQqbzbJFZ/cjrilrLK
X-Received: by 2002:a05:6000:230c:b0:3e3:3d84:9761 with SMTP id ffacd0b85a97d-3e62c284c68mr5425691f8f.0.1757336033169;
        Mon, 08 Sep 2025 05:53:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEhOhEXB3/NANpF0KM4SgHP7UU1Ksfhc0jmNzHaEtL3ivj5fCYOv+qhWrbqhmq7XSyBIxbIQ==
X-Received: by 2002:a05:6000:230c:b0:3e3:3d84:9761 with SMTP id ffacd0b85a97d-3e62c284c68mr5425670f8f.0.1757336032735;
        Mon, 08 Sep 2025 05:53:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf34494776sm41285539f8f.61.2025.09.08.05.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 05:53:52 -0700 (PDT)
Message-ID: <ad4abcd0-30d1-4683-97ab-abb1d151700f@redhat.com>
Date: Mon, 8 Sep 2025 14:53:51 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] selftests/mm: fix hugepages cleanup too early
To: Chunyu Hu <chuhu@redhat.com>, akpm@linux-foundation.org,
 shuah@kernel.org, linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com
References: <20250908124740.2946005-1-chuhu@redhat.com>
 <20250908124740.2946005-2-chuhu@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250908124740.2946005-2-chuhu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.09.25 14:47, Chunyu Hu wrote:
> The nr_hugepgs variable is used to keep the original nr_hugepages at the
> hugepage setup step at test beginning. After userfaultfd test, a cleaup is
> executed, both /sys/kernel/mm/hugepages/hugepages-*/nr_hugepages and
> /proc/sys//vm/nr_hugepages are reset to 'original' value before userfaultfd
> test starts.
> 
> Issue here is the value used to restore /proc/sys/vm/nr_hugepages is
> nr_hugepgs which is the initial value before the vm_runtests.sh runs, not
> the value before userfaultfd test starts. 'va_high_addr_swith.sh' tests
> runs after that will possibly see no hugepages available for test, and got
> EINVAL when mmap(HUGETLB), making the result invalid.
> 
> And before pkey tests, nr_hugepgs is changed to be used as a temp variable
> to save nr_hugepages before pkey test, and restore it after pkey tests
> finish. The original nr_hugepages value is not tracked anymore, so no way
> to restore it after all tests finish.
> 
> Add a new variable orig_nr_hugepgs to save the original nr_hugepages, and
> and restore it to nr_hugepages after all tests finish. And change to use
> the nr_hugepgs variable to save the /proc/sys/vm/nr_hugeages after hugepage
> setup, it's also the value before userfaultfd test starts, and the correct
> value to be restored after userfaultfd finishes. The va_high_addr_switch.sh
> broken will be resolved.
> 
> Signed-off-by: Chunyu Hu <chuhu@redhat.com>
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


