Return-Path: <linux-kselftest+bounces-38244-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85691B1A515
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 16:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC953BA141
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 14:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39D3271A9A;
	Mon,  4 Aug 2025 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MqRN3aXx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA94C2701DA
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Aug 2025 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754318179; cv=none; b=e3KKgarwRESZ3qzsjcuyIKAM6jr6T0lVtG7OdZ6Z/mIp/w4/r+35+KMFPl3JjaMc7un8/MpvPtYc9ACp0gIXnq37vTlW6PUxERdQvN8ljwcFV2+842jIjeEEQ+WLxw+PgAyfaX9xcvRpFNtEO6DKYCiGjPxN++s6qR+JnvDOD8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754318179; c=relaxed/simple;
	bh=qymuip9h5QJXklpbzM6kg7N6sxHI8OBQUJjeeIqKpLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ArrJJekcG2SXtBKPqAR7sgD5Kj2Q9Jh/SP+uQGBCfzLS4MFsBctnRhH+02Na2YbTl2GLWdKuFi4lfh15Awj+ElLZjPxHIgbxgLrOQynyZcyhvcq734uMQSrv6fb7HjyKfKrtAfp86uNW8waH7CVRZ0tYWnqJm/RO3acXRpnpwfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MqRN3aXx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754318176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bKInsm6bnVNCfi59KtVGbMO4lX6gaZZcpWuiTBk1kCI=;
	b=MqRN3aXxLDmqmQ6Nw2ws6Xz4L/zZrG4R/8R034CZJoC+P8ZxbRs3cBL9szhflwpqdnuEQO
	7iNLtFgygNz98HoTz5dc7YCubtS23SbAPvv1VBuGnDaZBdLpe3f8PYcPIJ+mJWA8xqRIGd
	PbIEznvY2UsEuWe5P0ax3RBaGkf2DLM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-PodsVg-KPQ2_smqPUwE0Pw-1; Mon, 04 Aug 2025 10:36:15 -0400
X-MC-Unique: PodsVg-KPQ2_smqPUwE0Pw-1
X-Mimecast-MFC-AGG-ID: PodsVg-KPQ2_smqPUwE0Pw_1754318173
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-459d7da3647so8345595e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Aug 2025 07:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754318173; x=1754922973;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bKInsm6bnVNCfi59KtVGbMO4lX6gaZZcpWuiTBk1kCI=;
        b=Y1iK2PndzEf+DOklydmxHUszleOoLzZdnxplOhOoVO/kh8Zq0OPQNPsva5fzk0802c
         PLNTWeIQTX4KMcVy+ZtBcjd3wzRCCpJXKzjfFmzhOcQljHK/L0yip4psT5E189JdAFfe
         B9ZW0pyEzkgKa5+cPRxungYHglUUBgxVrLQRrE2jDixtfFUWYMN7IYan/u88yq5BfiD3
         fT7xsEITmHg54GqOnaLnku4lPK6rB4o2s4MoHALUWT33GGqibotjbKt0fc7PtM2RFm3f
         OA8lpq7TA3cg4n6YbMvJXUY8414fL0LVsO4SPtZSHf/Gx4ux0c3cgwP566fbZFrhjV5Q
         vTSg==
X-Forwarded-Encrypted: i=1; AJvYcCUGRsEhKmrvkmRaadkE0OLN/5aAv8APgapL8GtAN+Qgw+IoY/KtgQjBFICrdSTgptfzqagGfMOppQ7y5vdO9l0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ZVHT29dV9oXtTI4rtEgvd9q1v19uMxt+XBJn5fmfH+0fFIV2
	FkSPLm+nCn9z/9IjOiN4YPKFoAvEex4y67QpPzsHGTrTPLVwoLnNZDn407dXX/z49dUOzjmjr8F
	aN7KffoKV47xkEYyWTKzVKdMkuperUTAF3b2xU/IUfVsmGZusL8cOdI0+JO9/7TBV+S8BTg==
X-Gm-Gg: ASbGnctNLyQahI+Z7qI9/u/9Rb48a2LlsAo6oCstLFJnLXIzat728RcFsxxRCx2K062
	o64TeKdbwmoZW0HE5/PEIXVU35zqC4J86mIVqtNzoWxMEnrgeFnmORYZ6NgVXyz1iyTIXPHVyA9
	2QpQc5KP4+pChPNUKlQ2vXL3vO2hJdHrmmmo/KjOgiZlLeL4wl9dPtmT2zLQXZ6x0CcGBHPZpjd
	3quv+6JJJ5/dUh1HGqLUNklMXOduqp1/RF63ZvnctZcD0Ayx49J/j752Y3+mTLaAQF/Ogaw5dO4
	DrYi0B6uJW7e5qjhtKa2Xp7sxNM3kMhxCue9A3HaVIaCQiuYb9eMO7jbjSOmgOehiwo4FD2ycmY
	g7m5AtPPBq5e2sHJJnkWn5RSMGdDvi/AgIqTGG5JHYFhXB/OUWeJ7QAh+VdOpuevnfek=
X-Received: by 2002:a05:6000:4202:b0:3b7:9617:c9d6 with SMTP id ffacd0b85a97d-3b8d94c4853mr6430788f8f.45.1754318173078;
        Mon, 04 Aug 2025 07:36:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgF7WdMM20TEgdrxz26bfqmzRB7DX+Wy1M6x4RxWiGvkCMPMJ2Regb4dTIbgWyxWvwdHL0cw==
X-Received: by 2002:a05:6000:4202:b0:3b7:9617:c9d6 with SMTP id ffacd0b85a97d-3b8d94c4853mr6430750f8f.45.1754318172621;
        Mon, 04 Aug 2025 07:36:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9? (p200300d82f0e2c00d6bb8859fbbcb8a9.dip0.t-ipconnect.de. [2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e9464f46sm1633873f8f.19.2025.08.04.07.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 07:36:11 -0700 (PDT)
Message-ID: <9f4e1263-c3d4-45be-a964-3eb0de828d95@redhat.com>
Date: Mon, 4 Aug 2025 16:36:10 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] selftest/mm: Fix ksm_funtional_test failures
To: Wei Yang <richard.weiyang@gmail.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, donettom@linux.ibm.com, ritesh.list@gmail.com
References: <20250729053403.1071807-1-aboorvad@linux.ibm.com>
 <20250729053403.1071807-4-aboorvad@linux.ibm.com>
 <20250804091141.ifwryfmgjepwrog4@master>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250804091141.ifwryfmgjepwrog4@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>> }
>>
>> @@ -338,6 +341,7 @@ static void test_unmerge_zero_pages(void)
>> 	ksft_test_result(!range_maps_duplicates(map, size),
>> 			"KSM zero pages were unmerged\n");
>> unmap:
>> +	ksm_unmerge();
>> 	munmap(map, size);
>> }
>>
>> @@ -366,6 +370,7 @@ static void test_unmerge_discarded(void)
>> 	ksft_test_result(!range_maps_duplicates(map, size),
>> 			 "Pages were unmerged\n");
>> unmap:
>> +	ksm_unmerge();
>> 	munmap(map, size);
>> }
>>
>> @@ -452,6 +457,7 @@ static void test_unmerge_uffd_wp(void)
>> close_uffd:
>> 	close(uffd);
>> unmap:
>> +	ksm_unmerge();
>> 	munmap(map, size);
>> }
>> #endif
>> @@ -515,6 +521,7 @@ static int test_child_ksm(void)
>> 	else if (map == MAP_MERGE_SKIP)
>> 		return -3;
>>
>> +	ksm_unmerge();
>> 	munmap(map, size);
>> 	return 0;
>> }
>> @@ -548,6 +555,7 @@ static void test_prctl_fork(void)
>>
>> 	child_pid = fork();
>> 	if (!child_pid) {
>> +		init_global_file_handles();
> 
> Would this leave fd in parent as orphan?

Probably yes, but only until the child quits, so likely we don't care.

-- 
Cheers,

David / dhildenb


