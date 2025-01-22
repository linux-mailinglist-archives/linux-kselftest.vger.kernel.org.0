Return-Path: <linux-kselftest+bounces-24947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AD5A19523
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 16:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9C23AC99D
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 15:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404632144BB;
	Wed, 22 Jan 2025 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QqlXDhds"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A996A214205
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Jan 2025 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737559664; cv=none; b=BhW3NFOXF6Zbm3Vgx6vuNbEFO6xa4UsrECOpHJ+8QYW+eV0soJpQeqFsWhQzZDAQzv3DOIXyb1cLWIRkiBgb9ycrR7BLm8qWhmZ9aFnnmWG0hzrVJSk+VihuMCITUHW8cFFN+Jgq7MJ/nM+NvwU2qXhJs2n8sdbnrwFJ4jlDCIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737559664; c=relaxed/simple;
	bh=Cd31MgGBv02EuqVDTZ/3jHZcf7wxKZigIdqJfL11Dik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ClAH65SbjRsFElssNLDfiFBLV7yqvrk8g6K7JMEnoRrOBhZ7bmnt2YfEuKE0QfF4P4I232e7Mb2THgt7n9Vx23qp3b8GncmYTKVKiT4Mq/as2KQYcxahcE9cfW99wyIyl/Ps6BYpU5Ns8guN5HPtP+fIwb1SxnL2h+sREWeURtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QqlXDhds; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737559661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T+YDgQGBJgVx1lvy+gZdC/Xrn6pGp2o2cfelN9+I6lc=;
	b=QqlXDhds1hAcF3ezqz3rKUP6+oKnJu/9k8if8HM9Voj2AK2vz7qIaZciFWZei/ke6A4azO
	W2xb6uqAS6eREaTYrJbf/odgyXZ6YZ32nPJYV3G0HhDrbMRJq/Ue8+/1JfadJO0ddY7z0N
	sEr0HZzUO/U7sPdWSQSFAvuxmCogRoY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-nDyQmGcEMUCHs7Z5FMfg8A-1; Wed, 22 Jan 2025 10:27:40 -0500
X-MC-Unique: nDyQmGcEMUCHs7Z5FMfg8A-1
X-Mimecast-MFC-AGG-ID: nDyQmGcEMUCHs7Z5FMfg8A
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5da0ce0ee51so6632876a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Jan 2025 07:27:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737559659; x=1738164459;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T+YDgQGBJgVx1lvy+gZdC/Xrn6pGp2o2cfelN9+I6lc=;
        b=HVa/wt5LEiD7nIup877YSpMzqw4fGyNuP0P71gCTk8JhUmhIgqYVvW31AgxoJdl4bh
         NmvZOXrl+z+cyg8p7KLyDfdbHZT4iDivp1faeSgOhq6nP4k8mNUfJXOtAeP4VyTfIX2S
         V0hu1A4pQ4bbYehlX+E/ffjOgCCxJ+EJAvoSS9/vcsN0+iry5D9G0sS3bbQ5G7rWglCY
         zv3odZxuYUmbK0XJox1NyHJOqXIUeVeC0fmyvJ1zl9HrVDutmIn86vg6uZUiYCxLzCcz
         qXPUhzgsRIEn5sCtxMY7Y2je1f+73o6XSDhaJNenxOYBJfeR5QKt/B7ZoNunn76WDuTg
         Andw==
X-Forwarded-Encrypted: i=1; AJvYcCU5HsVP4V7b5qq/JF5wiw7QG/8TbZTGXTF94cUG0CcBMHuBSjPHnPBaRxyCCNIiNAvDEmiizxHTGzWJq/0NppI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4N3pVSlwMIQIZr+j2KDtAQuCYoqvMDyumtIcjd3nSK3LDGOfE
	sLH5a+3yvhgrFriT8T1P07ojoM6VbQcJAsz5kp/fLsL7oy8tKWr1i0Q6+A34yvJ8gx7njUAzhU9
	BmLfV4JlPdvcufeypkW9+nYbDcOlSlVKkiN8Z8qna+Le7DQ4MxWcBGFyqj7s0lVMKvg==
X-Gm-Gg: ASbGncvYBHfg+ZJt9QrT3Iwy8pTviVfLyTbYlv78YatdI1jNnbtgTYerzw5po7ChQwa
	38QifU0SZQ/qd4GeNGc0ptkJ9nhX3i8x0MssQwPFV4Vd9GwyGAL96YS/wjyhfOr0SyrRWFXq+Yr
	RnQUZSqZC/zGtkFbndHrTj3McsyTMTmUlPZitkuMVkFvLyYW47xICu4iJA2n5guqF7uR40Npn+K
	lIvK41zBO/oBJ/jh0m5W+ldPjSHJq0v8dVMm3z3C2PC2YNB/iuS0DkdH1SxtsR5OlAcv8pm/UfY
	KWhWqg6fsg4mreh1dzkZoeECgBGAY7NMyl4MqL5fA3H8EH1Ocf8D6CD0FhJSqN1NYqkPaPpBJXv
	lVYZRIeyhWo4nCFv85Fr0gg==
X-Received: by 2002:a05:6402:40c9:b0:5d0:214b:96b0 with SMTP id 4fb4d7f45d1cf-5db7d2e2f66mr19601840a12.1.1737559658907;
        Wed, 22 Jan 2025 07:27:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtKgLJQ8x85oYipwxoO34t91jw0XiOCoHNVStnorTPyuTG+XMi/NXmDH19FuoIbyrYXa+i4A==
X-Received: by 2002:a05:6402:40c9:b0:5d0:214b:96b0 with SMTP id 4fb4d7f45d1cf-5db7d2e2f66mr19601802a12.1.1737559658396;
        Wed, 22 Jan 2025 07:27:38 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:db00:724d:8b0c:110e:3713? (p200300cbc70bdb00724d8b0c110e3713.dip0.t-ipconnect.de. [2003:cb:c70b:db00:724d:8b0c:110e:3713])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73684dd3sm8750534a12.46.2025.01.22.07.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 07:27:37 -0800 (PST)
Message-ID: <d66cea11-9522-43f4-8590-2e11ed43a8e5@redhat.com>
Date: Wed, 22 Jan 2025 16:27:35 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftests/mm: make file-backed THP split work by
 setting force option
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250122124047.1216024-1-ziy@nvidia.com>
 <04002289-c78f-4e1d-b242-144dd53a62f8@redhat.com>
 <D78P942WWF1O.IKY64R8JAIJG@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <D78P942WWF1O.IKY64R8JAIJG@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.01.25 16:16, Zi Yan wrote:
> On Wed Jan 22, 2025 at 9:26 AM EST, David Hildenbrand wrote:
>> On 22.01.25 13:40, Zi Yan wrote:
>>> Commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs")
>>> changes huge=always to allocate THP/mTHP based on write size and
>>> split_huge_page_test does not write PMD size data, so file-back THP is not
>>> created during the test.
>>
>> Just curious, why can't we write PMD size data instead, to avoid messing
>> with the "force" option?
> 
> It also works. I used "force", because I notice that it is intended for
> testing. Using it might be more future proof, in case huge=always changes
> its semantics again in the future.

I recall discussing with Hugh in an upstream call that "force" is a 
relict from older times, so naturally I would have just adjusted the 
test case to trigger the PMD scenario. No strong opinion, though, was 
just wondering.

-- 
Cheers,

David / dhildenb


