Return-Path: <linux-kselftest+bounces-39922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DEDB355F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 09:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DAFC170A9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 07:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23F4281378;
	Tue, 26 Aug 2025 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOoMDE3+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684D71FE45D
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 07:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756194349; cv=none; b=XUcRHQ8FUms+Ij8EnZ+bV4RA3qU2xAf3P7ew6WD76SWKeThPfZp8XrI4CkcMl/xsIT1Jwy7rSwxhX+kVyO/tA4A2u3UC3/GnT0JpVzHEQ/NquLkT8PIwBOcsxCcfmEKNnXY87sjmS7WjNHWbIbgQxh7b3w3B9VthToLhjOsKh9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756194349; c=relaxed/simple;
	bh=Y9Gq/Wwg4WWspUchsswhzCL9lxSEIz0k58XAcXsS74U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwlC0PsfLxz5sqKOGQrkfMJ5ElaPhtEnzLTgbmo13quMVuxrSFCGYGMH55OIomJ7bpPGQOwWQRaLXwToFP7OGDMtoCnHCy47MVv6clo5kza1X9uoZqmLzuZPjjjSCX3rx/LSZDa/QRLx6fsJtynMoEDVH767s65H/MgykwYrhII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NOoMDE3+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756194347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k/OuiSc8DvwL4ze5IiMvnOja29ttjPgB686MqiOHyN4=;
	b=NOoMDE3+HUBs2oxA3O2KXoHdpr8PG3wOWypanl8qqXqiCkzmbVRoAI14PsgRVSvUQBbS5N
	vnR4jHdRO8aH1vDjNrxLrrTi++opUc8ixL24OBCpdqtzGSAMbJFEK9rgHXWtQspZh+17gy
	yXGgPBhcl8YL4oF+ZRPagWn+L0kCIEI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-pbVo1bEROpedZw2fQyg9AA-1; Tue, 26 Aug 2025 03:45:44 -0400
X-MC-Unique: pbVo1bEROpedZw2fQyg9AA-1
X-Mimecast-MFC-AGG-ID: pbVo1bEROpedZw2fQyg9AA_1756194343
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3c6abcfd218so2265215f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 00:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756194343; x=1756799143;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/OuiSc8DvwL4ze5IiMvnOja29ttjPgB686MqiOHyN4=;
        b=CUmluLrfEWC1Mp+e4+JnoAhagD6BWAFaKBu1qt5bPyhsaXGE1A5bYwChT5Av8Lm8V2
         tFs4DMtG0U4Y7rixaqWNqbZ+3XOFCvniL6wge5p53ACIUl6kPi4hGb9h5cVGLO9yfRiK
         oThso5u/nv3UoUuPQPVEdGAcrDXWDUSftjMooanQaZlx0SPgWovl2iTjJU66D2C+UUhC
         5i/tf6dfAGDJy7miBCnUvqghSGCnQckqQythWRQJVRHdWhKy/pen91D4suA2ETtv+kL+
         s701cOss4trxE+roPtPcfvLyfCkS1pUO2FQLgzENOVkLjfb11kTTnssrigFGKQSMIi3i
         vumw==
X-Forwarded-Encrypted: i=1; AJvYcCU7DV4BDc2SC5qzefXyA0/Fq6VYs7/ytw+EwyRghi1RB4uBJnOEb9cYliBRRb5KvciQLyOIjVsX6luTRc1lG78=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJp/TxNizpVwo3MX+83JrazxKk+mtSjk4xDsD8yPPkFhGTmo4k
	FIc6pag09wPDeRMi1SK6ACQByj+ZcRVA/dldBqxUgqha7Au7GjVVOJb88woxX2v0HGGAwfzcwxw
	ftUzu5uuWb0Dr8vsp1/SEDfZja7iJrtcXtmv47ZAQuuZO7+ylHBRvwByO5ivlxSRBR3gU5Q==
X-Gm-Gg: ASbGncv2ZGj8UVKj6t5CLkcrBdIwle+OL9TUq/zGaSpQbDfRd0csCaV8XhxzZhMMyyN
	C2H3bPX8DD3yzHus+cF1k38MZxdzTxreM+T6PO0zhSlLed01njFdCV5PAAKLoea2GdpYrQxshxp
	1yUVByT6YPDvzKxNwRj8kH4sIE3j9Gg9eszZ/818oa+jppYAqaP+7xsfs5oNQrGyIs5kvnBirqs
	IePYREAFnlyqyPWyKRUZaiTIB1hy0cx4sc2Y9P1k26eyUgdSg2y1fZtkQpv0AVVeRMmrWQGpVVx
	t2dtOZy71ReFqlO2BkrdW2hjS7tO/7U+gD7PBYdsvPIvah1oYmq60NM+peOgakI14W9Vv4+oBA=
	=
X-Received: by 2002:a05:6000:40dc:b0:3c9:38ca:2c1e with SMTP id ffacd0b85a97d-3c938ca3186mr6269518f8f.63.1756194342701;
        Tue, 26 Aug 2025 00:45:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUH1J19kuTuf3s2CHLvi8u0X2SupxylUeCeMPuY/SxI9i/ktTCtrSz18UCsho7ir9h8yIYxw==
X-Received: by 2002:a05:6000:40dc:b0:3c9:38ca:2c1e with SMTP id ffacd0b85a97d-3c938ca3186mr6269476f8f.63.1756194342238;
        Tue, 26 Aug 2025 00:45:42 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5753503esm137958415e9.1.2025.08.26.00.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 00:45:41 -0700 (PDT)
Message-ID: <5c983e27-9220-4ef1-b5ac-0be95b37d8d8@redhat.com>
Date: Tue, 26 Aug 2025 09:45:40 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] selftests/mm: Add -Wunused family of flags
To: John Hubbard <jhubbard@nvidia.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
 Leon Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, kevin.brodsky@arm.com
Cc: kernel@collabora.com
References: <20250822082145.4145617-1-usama.anjum@collabora.com>
 <20250822082145.4145617-5-usama.anjum@collabora.com>
 <4a9e0017-53a6-48dd-8e3c-774a859a28dc@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <4a9e0017-53a6-48dd-8e3c-774a859a28dc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.08.25 20:21, John Hubbard wrote:
> On 8/22/25 1:21 AM, Muhammad Usama Anjum wrote:
> ...
>> diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
>> index 9bc4591c7b169..4fa03679e9b07 100644
>> --- a/tools/testing/selftests/mm/compaction_test.c
>> +++ b/tools/testing/selftests/mm/compaction_test.c
>> @@ -203,7 +203,7 @@ int set_zero_hugepages(unsigned long *initial_nr_hugepages)
>>   	return ret;
>>   }
>>   
>> -int main(int argc, char **argv)
>> +int main(void)
> 
> Hi Muhammad,
> 
> This is not helpful nor desirable, in selftest code.
> 
> In fact, I think this particular patch is actually a solid
> illustration of why you probably should just abandon the -Wunused
> flag in kselftests.
> 
> Skimming through the other patches doesn't change my initial
> impression, either. This is adding churn and admin overhead,
> but for test code there is basically no benefit here. Certainly
> not enough to be worth it.

Fully agreed.

-- 
Cheers

David / dhildenb


