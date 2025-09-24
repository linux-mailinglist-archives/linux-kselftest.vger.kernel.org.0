Return-Path: <linux-kselftest+bounces-42231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0145EB9B76F
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 20:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D56A3BD1B8
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 18:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00F8321F34;
	Wed, 24 Sep 2025 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXfW0sDe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2213C3191BF
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737951; cv=none; b=KCZiKxhEz+d5DwwLUS0Up6c72kZeMH/T5QdJPIEJNZ1fkyKwzEkgE7SxQXBcLmEtglZ8mk/AskZTz13aLndWzQ86qIwOAYLZDNw1kfbU72+JcZYAYlRoqgJty+7FpAWYUwcQL7FKQyODaMEFQDmGRe3zURpEGc3YoTFH8hj4Y9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737951; c=relaxed/simple;
	bh=/teJlWbOiy711s826a7v+SpOfK1BJbJESGoYo6DPnLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHCYEJ+ptOIdL0bxwue50e6lJ7yl6PcVAE3jyRASGpihmt58SQHEPqAGPV2V6GoKiL+WJ616adG6isLUa2pxaQ94eVbqmN4HQVQn5kqconBbUSydInPEl9Uh0vZPvVaLfFuDW8GK522FLAhjObu09eGAM4+Ww7yBLZIx1c+GYII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXfW0sDe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758737949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+GVKNWNi5HMo/lBrmWhAcg83rtAIgDpsQXqdRYrctmM=;
	b=ZXfW0sDeZ1TMr/+gJtYJjgM/9BXoFDStAVj5k1xn1ciQSMP9AhuGe6C8lQBRb66XTuXY7N
	oVwTLjGG0Fuaj3jh3iKWfgHPR7xp2yQ8dM4DYxeU/9mmYc9CIMk/OLhhWnJJiFIowVL1Py
	Wh1H8qNWObowmkREFLRoADxAaIDBx4s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-S9mvkFOqNPuTh4aI3h7bJg-1; Wed, 24 Sep 2025 14:19:07 -0400
X-MC-Unique: S9mvkFOqNPuTh4aI3h7bJg-1
X-Mimecast-MFC-AGG-ID: S9mvkFOqNPuTh4aI3h7bJg_1758737947
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4612d068c47so493395e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Sep 2025 11:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758737946; x=1759342746;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+GVKNWNi5HMo/lBrmWhAcg83rtAIgDpsQXqdRYrctmM=;
        b=V+NtnlJmIc7VWeFiUrLaQKn6BwrebXqGwVAJI5xj1lKuRLgZ/J7z/0/kO8veL96Lwc
         JOKiAugmlmENfj1sANukv8cB+8oOhpOZPJaOx/Z5hvpF33PtHOxyHMF8vLaXAz4mXbn/
         4wtwrC0AAcb2FUd6DJ7h5BQtHpQgk85nWcUfkkrxz5ZgQYn6saSHaauCr/Tay+7GZgCk
         2qOWCIeo2Hdod0xqkuAX+E0AwQmlQhh4GwLnIXmxEqJFjUWi6m9vBB1eDeK0EA0wPoXE
         CmbtKwmY9r5WogYVQZ3p4vOpys+ebk8YkE4urjZQh9fIeeXXX5cAIfnsr/d9HUSztIDK
         WeEg==
X-Forwarded-Encrypted: i=1; AJvYcCWOJbsoZXAAxj56b/wHylE7YF9PMnj+W2YWGBzlslIWp/wFLIaxTr4QGoqhFeW0ZKHA0vWoxLhlEDyyG80a748=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyTuRcB4KbAavb7gxwkbYaF/LgDTzyc6bUgnwT2k1dFK+Y20Go
	8fi2jenPxtF8OQs9w2cNjrGEqiqlv13Q/RkH8zDl6SNv361iZHrfyBWY/bR8glJqKBrOzJIMAHa
	98XhFGjMDP/aBKM8J6aJnPsDdL4+t1gVp30Sv0+o4QgG0LOycfhmxYCq/+YXWntXshsTiWA==
X-Gm-Gg: ASbGnctIcqNMLVPYyHsnaMa31BQ5oPnC2kTu9QBetNukRmHGFFT+I5YLNEFD+7f7ydh
	G3X0L8iTy+yzGNQJLSAtD4aAYS3Bp5TDYPf1d4L5a+xmE/6kYdwG1W3kZkIXIbwkexNexCXrspi
	rhaxkvjbkIpcPQqogdoOhkz1MeI6XgMo0qeVBrsIlTmKEeQlE2hmqhirOILbg5V7OR+Tz9yE5k9
	tgoSUjXuCMGquykakM6P617ijz3W00kEClbAj2xxwz0ytOat6q2nk44+g3+/RmstD2FEEq+4yl3
	GU9JLAVZx4V70F67N5MNjmKYvAgxY6txqlr/KUW0XXAnIrtPXTKP+ynB5qZQlc3wZ7zM2gcV
X-Received: by 2002:a05:600c:1f16:b0:45f:2cf9:c229 with SMTP id 5b1f17b1804b1-46e3292ea63mr9349105e9.0.1758737946373;
        Wed, 24 Sep 2025 11:19:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWiZOUG5fae31rurFMM73vXO6jc0v8mG1U6clMBR7MZT6xxje1XWRB74TlFYPhZbJta7VNSw==
X-Received: by 2002:a05:600c:1f16:b0:45f:2cf9:c229 with SMTP id 5b1f17b1804b1-46e3292ea63mr9348115e9.0.1758737945821;
        Wed, 24 Sep 2025 11:19:05 -0700 (PDT)
Received: from [192.168.3.141] (p57a1a5c4.dip0.t-ipconnect.de. [87.161.165.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996da2sm50902695e9.5.2025.09.24.11.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 11:19:05 -0700 (PDT)
Message-ID: <1b01ebab-a43e-4344-ae38-50f0a031332f@redhat.com>
Date: Wed, 24 Sep 2025 20:19:00 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kvm-next V11 0/7] Add NUMA mempolicy support for KVM
 guest-memfd
To: Shivank Garg <shivankg@amd.com>, willy@infradead.org,
 akpm@linux-foundation.org, pbonzini@redhat.com, shuah@kernel.org,
 seanjc@google.com, vbabka@suse.cz
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, dsterba@suse.com,
 xiang@kernel.org, chao@kernel.org, jaegeuk@kernel.org, clm@fb.com,
 josef@toxicpanda.com, kent.overstreet@linux.dev, zbestahu@gmail.com,
 jefflexu@linux.alibaba.com, dhavale@google.com, lihongbo22@huawei.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 tabba@google.com, ackerleytng@google.com, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com,
 vannapurve@google.com, chao.gao@intel.com, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, shdhiman@amd.com, yan.y.zhao@intel.com,
 Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, michael.roth@amd.com,
 aik@amd.com, jgg@nvidia.com, kalyazin@amazon.com, peterx@redhat.com,
 jack@suse.cz, hch@infradead.org, cgzones@googlemail.com,
 ira.weiny@intel.com, rientjes@google.com, roypat@amazon.co.uk,
 chao.p.peng@intel.com, amit@infradead.org, ddutile@redhat.com,
 dan.j.williams@intel.com, ashish.kalra@amd.com, gshan@redhat.com,
 jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com,
 yuzhao@google.com, suzuki.poulose@arm.com, quic_eberman@quicinc.com,
 linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20250827175247.83322-2-shivankg@amd.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250827175247.83322-2-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.08.25 19:52, Shivank Garg wrote:
> This series introduces NUMA-aware memory placement support for KVM guests
> with guest_memfd memory backends. It builds upon Fuad Tabba's work (V17)
> that enabled host-mapping for guest_memfd memory [1] and can be applied
> directly applied on KVM tree [2] (branch kvm-next, base commit: a6ad5413,
> Merge branch 'guest-memfd-mmap' into HEAD)
> 

Heads-up: I'll queue this (incl. the replacement patch for #4 from the 
reply) and send it tomorrow as a PR against kvm/next to Paolo.

-- 
Cheers

David / dhildenb


