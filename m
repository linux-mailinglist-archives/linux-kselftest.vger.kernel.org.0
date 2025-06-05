Return-Path: <linux-kselftest+bounces-34384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F134ACF4AC
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 18:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B2FC3A36A0
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 16:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EC52749F2;
	Thu,  5 Jun 2025 16:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGVWz6Ix"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3068D5FEE6
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Jun 2025 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142136; cv=none; b=aGkjcufGmpXEgsrCItoBcoiyDByjes7x0BFPa+I3op+PBJVz3fEJ8rdmkj4JJpAZtLLthOzMIFDtNkoeWsoRYkKplfyB3swC3Q3xGOJxrFyWffnDc1V15bjXdOaMdjvs0TqPBesDXfyvustpvINFHn2dl1aaeAWp/ayZ2EWLsXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142136; c=relaxed/simple;
	bh=564+cF/axRft9116ScwHN6MoAGhv4fCV2KyeaaSML0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=imIKo1sw6GsDB2cTpXZTQq1h4dpomVD8XKibOMPO5I1qhbh0rKMRpNVfX4bSp94udIKW1uzzBDR+dcL2Sc+2ksDflgv69Sx7qbluXZA/a1GibndCg1RA8xHlfaTmhSxacYFwt37gMt3ayFAc5kjzIC/wSzK+8NoJ51jJ6fwqdhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aGVWz6Ix; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749142134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EhGEn/OmiPAvj5eatsAY05GMVNPxdCqcjhL6DIoJxjs=;
	b=aGVWz6IxlA21uvx6k9dRUKJshGHZGRHgKMkdpi0ze5Y4fKSICX5Wes3uFvv+LyKPQEZRSc
	xFnDDlvvkAet52/IDQ032pIELF1pMXCoAvwL3qDrt8ov2OcK6Mx4HyrvlpZPmmVS+Jwt2v
	Eb2yr+nzsK7Jd6kmhoLlQgYribAJoBM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-1BhTR-hHOw2xVWRsnWXz2g-1; Thu, 05 Jun 2025 12:48:52 -0400
X-MC-Unique: 1BhTR-hHOw2xVWRsnWXz2g-1
X-Mimecast-MFC-AGG-ID: 1BhTR-hHOw2xVWRsnWXz2g_1749142132
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a52cb5684dso425206f8f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Jun 2025 09:48:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749142132; x=1749746932;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EhGEn/OmiPAvj5eatsAY05GMVNPxdCqcjhL6DIoJxjs=;
        b=SsNgylw1Fjpno+pje8GQ1ZGq3LCxy56AYLI1fJIG1kDEXXFcO60rC1GzNYCdtBuEE+
         o9nNXIOK8I+dkXrsoaDfaKmEJdFpyOJH9a54reCupZ0/v+v3dq+TknjHlOnxTo93Bx/Z
         olCnN8tH+uVsDExkZwYsvWCMyzIAIFlCIyRZ1uv8qGpUKdpVqXKmCFU+cqrJx50nW+yd
         TcF3wiSCn9xuEy0Gwyfa0xQjh55vtbqHuXxCOWtE6+DZFHiSxMOqnbNAhcf84eRsAOo/
         qvnTlUzvEkFXQW/lksjIEGPg0nOowafq4DXcxCjWmqPayIlkJTNUGACsELkmTnunjKlG
         tMQA==
X-Forwarded-Encrypted: i=1; AJvYcCWG4BCegsu/2z0cg2L9Adw8lmUs8RDOT6e+4kAnKgSq07ybM8tJ+WwTsLMfDIaf/WuVt/D1yZHhq0pCIflV/RE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo9SSeEBCHXtMP3dFlQYml/pftFqwhFUzE9c4HniHOPlWf4xds
	4C7B2QJ82FR5IOOz51KsJd/KQ2gOUm2l6Pv7jlwyKmcTA0fOjuvNwG+PaQkk+fRQsFf9cgIZwF4
	ROKpr4kfUvaPcBXm62ZUOz9lrVUxpf510nL++51bVvTM9zl01miBd/IkfxiprNGdYWrCsjQ==
X-Gm-Gg: ASbGncv8se133++1DMXxIrnI18IJmbxR9OJAc63QOGk+y8nO7AXjUSyB49yFNqAshUx
	MQIqChY62DPatFDkZBzSFSCXSH5ueZ7U3e31dc0cohx77vMAQhd4jZmzz0yBltbIQaJ4JncXvcG
	OAEwndV7CzUPUSdHjP37XVvdOjyAyqq4fyfZKfCa136QKsUID4LsiwzXSgmCRqljwk39ZzTri28
	p/XkgyssE6b/IIUXf6C8LzsPHiNZK0/rj7b1R8HG/37HIMM3jZupEDGLCGRh1C2FIOYP8lGu5bk
	TI7peU25GU/L7EZKr7i/WCzZmXNMcgDHr+YvZIAjsi4+qj61lM9Kia+qHDwL4X/9SJxhndWMhN+
	oCVV7sYlay5J0CouZvcsgv3ROe483WjpmegQO
X-Received: by 2002:a05:6000:310e:b0:3a4:ea9a:1656 with SMTP id ffacd0b85a97d-3a51d8f5f86mr6635493f8f.10.1749142131668;
        Thu, 05 Jun 2025 09:48:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgxIlZfdw0n7Ig7PNG5drsa3AppFPtd8J3xQjqrfGMh581GAlmBD6NseEqNRK10dz3UBK3gw==
X-Received: by 2002:a05:6000:310e:b0:3a4:ea9a:1656 with SMTP id ffacd0b85a97d-3a51d8f5f86mr6635463f8f.10.1749142131235;
        Thu, 05 Jun 2025 09:48:51 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:ec00:4f4d:d38:ba97:9aa2? (p200300d82f27ec004f4d0d38ba979aa2.dip0.t-ipconnect.de. [2003:d8:2f27:ec00:4f4d:d38:ba97:9aa2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f99243e6sm29693115e9.35.2025.06.05.09.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 09:48:50 -0700 (PDT)
Message-ID: <65862fd7-16ca-4d3b-a589-4389d8df324e@redhat.com>
Date: Thu, 5 Jun 2025 18:48:49 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] selftests/mm: Fix test result reporting in
 gup_longterm
To: Mark Brown <broonie@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-4-ff198df8e38e@kernel.org>
 <a76fc252-0fe3-4d4b-a9a1-4a2895c2680d@lucifer.local>
 <722628a8-f3fd-4fb9-ae04-2313a52ffb36@sirena.org.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <722628a8-f3fd-4fb9-ae04-2313a52ffb36@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.06.25 18:15, Mark Brown wrote:
> On Thu, Jun 05, 2025 at 05:00:49PM +0100, Lorenzo Stoakes wrote:
> 
>> This seems to be causing tests to fail rather than be skipped if hugetlb
>> isn't configured. I bisected the problem to this patch so it's definitely
>> changed how things are handled (though of course it might just be
>> _revealing_ some previously existing bug in this test...).
> 
>> Using a couple of tests as an example:
> 
>> Before this patch:
> 
>> # [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
>> # memfd_create() failed (Cannot allocate memory)
>> not ok 39 R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (2048 kB)
>> # [RUN] R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)
>> # memfd_create() failed (Cannot allocate memory)
>> not ok 40 R/O longterm GUP-fast pin in MAP_PRIVATE file mapping ... with memfd hugetlb (1048576 kB)
> 
> That's the thing with memfd being special and skipping on setup failure
> that David mentioned, I've got a patch as part of the formatting series
> I was going to send after the merge window.

@Andew, why did this series get merged already?

-- 
Cheers,

David / dhildenb


