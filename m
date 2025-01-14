Return-Path: <linux-kselftest+bounces-24464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE4FA10CBE
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 17:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026643A45DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 16:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A101B6CFB;
	Tue, 14 Jan 2025 16:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DnwKDPoC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9761B87C6
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736873646; cv=none; b=Fc1vuWVWVrGyUzu/gWB5tDVupR/EtudxNwsbIg1xO3ddjFRJhm/aIUULJdt+vbbFZbO3CNlY26O4U+KhjA9Z52vpPe9SHQ9PtIx8lcF71mbYUYKUEoKGc+FT5f90UNxiZkBZkMTrbXQh6r4BoIKj6Vddi/IdANAmFuRUV6LPinE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736873646; c=relaxed/simple;
	bh=E6rBuDhlJ4GjffILCBxpeUuQWhfKb+jIjMY361CEv0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKF1Mnz0FaA7+T2A7OB5Q7xk3JZ9QpG+vRdSR2z3lD4o9liuN2CIidBgMpbt7vtYmyYfVcVI7vnhHKpoz5ngZf/z216c6+M/i4HvJ5GS6+AsSnqt80AJUvU477e32cwRwy6XoGDkCChd2E5PmIaw89fpjj2M2rzlRzZczn+Ge3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DnwKDPoC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736873644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=056ZHJ91+HDRI4BQYHeDGeZYL/iE09ANEtZFdy1HhhA=;
	b=DnwKDPoCL3j8XQTUMgbkopa/ZO+Thg7SMabGSdh67PniNISgUhzXixbYRWoUJu9tfr4+FW
	3yxz3CHBLceuNVGysG7kQsbto+jmAf9LZBoAz38QXHO3EFbJn9U64BvyEcfPdkrYWNcr0L
	rfnPt6J2nsfElRb2eSq9e9gQFa3trms=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-NJr042eAOVCU_iiiRWDU0Q-1; Tue, 14 Jan 2025 11:54:02 -0500
X-MC-Unique: NJr042eAOVCU_iiiRWDU0Q-1
X-Mimecast-MFC-AGG-ID: NJr042eAOVCU_iiiRWDU0Q
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385e03f54d0so2547743f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 08:54:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736873641; x=1737478441;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=056ZHJ91+HDRI4BQYHeDGeZYL/iE09ANEtZFdy1HhhA=;
        b=qfITwhQWDkeZYPyAvyEMmxQ/2jKxg665nl0mHW0/7G0YfnbUBj4JIjOSDhJ8AacSVx
         63T2BAtofezmwI3beAcjRwHvrQrbOT3CNMT2obOC46R3ZXnDWPVbx3IlLyPXUTciADfg
         CqJFGEVR7zvqz/xOopUSROyy8PDRTrCvJT3xLmkpUZt8GpLoZFVvA4KmQylD3GNYMUqv
         NDNkSFrB6uGqm4UiCFxiHswEUKZXnGn6Uy7OjfOENDFMYdCaA46EjwN8I3/J03uX8fzF
         fQVazMGK5uGCVvzh7HasR9dtenjeWyKXA+ObhHZ9DTwxoKDkFlWcQ7cmI0qbWn1aWjG1
         e9OA==
X-Forwarded-Encrypted: i=1; AJvYcCX4ZimsYDxOeDyGQ1p4JNdNJu3ouMPRtNSPGuptNNsh0QYWo1kgxDmLuPRClKhWG7bpaGNpetnun2eHqIRbtU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSWDXXdK7UUI3CBNbS15eDTjJg/IR4P8lzkO3gK/wzRnJw8ojt
	Id+OsUY9KEo1oA5BRBzN1B5qOMSNnruKw3Aoa4CVdmLB7K5Dom3lj3jRcBAzHfNFEdus6u7X9vn
	8xgFLVcnXYgkIjHci4vE2QgeK2zTv12mlJmTkBJV462q2Y2FD0c/0ImWb26gZT4iHtQ==
X-Gm-Gg: ASbGncuOxA/kqjf4Tj6J+NgPSmu3To/pZT7ewVuU+2FsyhLh3DU9viyex1GnboyQ0/Y
	KddrShJXwFASn8LF3hiQoJq7/doJ/V4i7YPYKdJHIZeT0e16fZl+FX35leIKc2ZGbvP4auunulT
	rHUnh0vN5UGXU71wKnKpJprBgsS3amj1v45oxkliMHDlthzjD5I0KoOd9EJPAEyuRXgxb5gcaZE
	uGzAi7auZShnNodAsMRi6N4bRSoyl5aPzXRdZep/YyM0IIEuhfWl51+Rfu38wE5jUJgAYuDLdVW
	jaiv7Ri+gDkcqWZT0MBJ220FfPCd6BK5no1DeisehALadBXfjU7lrCOHvJNS+8csJiUETI4WxTq
	/0JDWLJSV
X-Received: by 2002:a5d:5985:0:b0:38a:2798:c3e0 with SMTP id ffacd0b85a97d-38a87358f3bmr22039207f8f.54.1736873641189;
        Tue, 14 Jan 2025 08:54:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHszYQ25Q8gOYLXiUeL3WQw5fG7HtbGIoBScqOz9la2MvGnmSzFJ80J/RseI4NGCCdbYcB6Eg==
X-Received: by 2002:a5d:5985:0:b0:38a:2798:c3e0 with SMTP id ffacd0b85a97d-38a87358f3bmr22039192f8f.54.1736873640840;
        Tue, 14 Jan 2025 08:54:00 -0800 (PST)
Received: from ?IPV6:2003:cb:c738:3100:8133:26cf:7877:94aa? (p200300cbc7383100813326cf787794aa.dip0.t-ipconnect.de. [2003:cb:c738:3100:8133:26cf:7877:94aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9d26a7bsm187883795e9.0.2025.01.14.08.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 08:54:00 -0800 (PST)
Message-ID: <56a1657c-d60f-4cdc-88a7-826ad977890f@redhat.com>
Date: Tue, 14 Jan 2025 17:53:58 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] selftests/mm: virtual_address_range: Avoid reading
 from VM_IO mappings
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
References: <20250114-virtual_address_range-tests-v4-0-6fd7269934a5@linutronix.de>
 <20250114-virtual_address_range-tests-v4-4-6fd7269934a5@linutronix.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250114-virtual_address_range-tests-v4-4-6fd7269934a5@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.01.25 17:06, Thomas Weißschuh wrote:
> The virtual_address_range selftest reads from the start of each mapping
> listed in /proc/self/maps.
> However not all mappings are valid to be arbitrarily accessed.
> 
> For example the vvar data used for virtual clocks on x86 [vvar_vclock]
> can only be accessed if 1) the kernel configuration enables virtual
> clocks and 2) the hypervisor provided the data for it.
> Only the VDSO itself has the necessary information to know this.
> Since commit e93d2521b27f ("x86/vdso: Split virtual clock pages into dedicated mapping")
> the virtual clock data was split out into its own mapping, leading
> to EFAULT from read() during the validation.
> 
> Check for the VM_IO flag as a proxy.
> It is present for the VVAR mappings and MMIO ranges can be dangerous to
> access arbitrarily.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202412271148.2656e485-lkp@intel.com
> Fixes: e93d2521b27f ("x86/vdso: Split virtual clock pages into dedicated mapping")
> Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Link: https://lore.kernel.org/lkml/e97c2a5d-c815-4936-a767-ac42a3220a90@redhat.com/
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Acked-by: David Hildenbrand <david@redhat.com>

Unfortunately, vsyscall doesn't seem to set VM_IO, it only has

VmFlags: ex


Which is rather weird.

So we cannot remove that special-casing right now,

-- 
Cheers,

David / dhildenb


