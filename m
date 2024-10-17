Return-Path: <linux-kselftest+bounces-20001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF6D9A2A99
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36650B24E69
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 17:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FAF1DF96D;
	Thu, 17 Oct 2024 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCwXVTDg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F021DE3A9
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185113; cv=none; b=tsb0uiQ/oDMPzCgCdp4tISJUaoZ9GQCPqRc32WvoKiGmKou7eVeAZfAe+C+1a7EWrcx0P+ygfRdzleIt1IqEzjZlLvn6rMDyfksXubygXXZjfO4vknVN9FPhZjr0lrhRhxU0c+KNBzc52PVoUlbzdtCp9vzZqfffdJWRhuSUtwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185113; c=relaxed/simple;
	bh=HCnbyxC2/JWASNxs/WWTqbQuZRGUIe5d26ntIwvaLAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CL6I731XG1cmyfSPUmDxZXdXbQ004f6+kFcu7ylo5MJeqHHBfFDfr+nyw86+6crLd5x8/dlsX5qiIlf1QqmPhUfiJg8ea0dDJ/8cgV6HzZebig9IFBA02eMT5dgloNLXOrLhNNTJDFbiX+XMdmO0Iq6Fnn9tPsGyBjDisaxvUzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iCwXVTDg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729185111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qHV84eQp4jlzcIekkn2dgcMLpv0xxnbynK47kf/zVOM=;
	b=iCwXVTDguxIRhBIIdLxg31eHk2/4v/ob96ObXFkS8FOtWGwLOxNlGO0sUcbT+EdDXQkeXx
	MPgAxSIOX6OeYPMNAZn2MLM/5gwRk7oH3A4E7CRT+bHoj69lvtgl1xtdlc0WHi3iX6uj50
	//K9oN6Lfd3MnhE/Cd2AYP8X37P/Xac=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-jTp687cyMrmWHy7sjXKSoA-1; Thu, 17 Oct 2024 13:11:50 -0400
X-MC-Unique: jTp687cyMrmWHy7sjXKSoA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4315c1b5befso6251235e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 10:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729185109; x=1729789909;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qHV84eQp4jlzcIekkn2dgcMLpv0xxnbynK47kf/zVOM=;
        b=LJ5aEqNnceYRkkD/GytjGh9vzX7JvwVggLof87Ys2ehRKIeTDH/NPCI73p7yjvImOd
         Qr32aeIsocTSwGZslIcapBcH4xkCjaBY78t0PMrinqSXzscwxMbDPVolQQg8+hcgjbYy
         ll8z57M1UJv0gTPSpq9MP0ZKsCMNXNQ4NZG+x65NMvyO8MLkUomghnJTcVQbwn/oqLSO
         +gjOLiOaLcuYT3Jq4C8FEOh/ho/ho3X63sJfwNfVYsWvBR/kxMdwQU/tE645irguVL00
         9yQz5Mq2hO+5HJY4QcPnRUVPe3dv4scZ7hALoeRf73YoAHLNsFAbNcvCJkOiIDDdo3rE
         hx/g==
X-Forwarded-Encrypted: i=1; AJvYcCXoaVsCsMefS+0WkvifRsBmb8KRN+i6sXmGuPJ8+uKRD1lJrDtvcuqvLtRKh/B3Jvk3ZdrmixXOwkYzzGzrIIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkA7rINNQV+zCopmnpOIJ9Mk25fxNiAAdCV9cYr3r7vfJOO9wZ
	dDArys8dGe5QIRTbjZA9w5nTjgOZ5gsERanxtg1k99+gQy/4TliS1N26//aWTULeUQN+Z1Rr4Xo
	4DGXHwXepqCaAr9X2JXEXcsAQVSwzlgQGXScYU0oQbJaFadAZyDkhNpLDzW3pruIm9g==
X-Received: by 2002:a05:600c:4688:b0:42f:80f4:ab31 with SMTP id 5b1f17b1804b1-4314a2ff46amr60476115e9.18.1729185108591;
        Thu, 17 Oct 2024 10:11:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwV/R3Z0AyOauuDdG7A023Di7UVdGbzPC0E2zw7ZdhJf1TCsYFeJ/Ll63ZR//w+5LbtvkNaw==
X-Received: by 2002:a05:600c:4688:b0:42f:80f4:ab31 with SMTP id 5b1f17b1804b1-4314a2ff46amr60475945e9.18.1729185108116;
        Thu, 17 Oct 2024 10:11:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7600:62cc:24c1:9dbe:a2f5? (p200300cbc705760062cc24c19dbea2f5.dip0.t-ipconnect.de. [2003:cb:c705:7600:62cc:24c1:9dbe:a2f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316069e1c9sm1407195e9.25.2024.10.17.10.11.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 10:11:47 -0700 (PDT)
Message-ID: <a63f0f7a-e367-4f0e-8d8e-ca7b632712df@redhat.com>
Date: Thu, 17 Oct 2024 19:11:46 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 26/39] KVM: guest_memfd: Track faultability within a
 struct kvm_gmem_private
To: Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>
Cc: Ackerley Tng <ackerleytng@google.com>, tabba@google.com,
 quic_eberman@quicinc.com, roypat@amazon.co.uk, rientjes@google.com,
 fvdl@google.com, jthoughton@google.com, seanjc@google.com,
 pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com,
 jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev,
 erdemaktas@google.com, vannapurve@google.com, qperret@google.com,
 jhubbard@nvidia.com, willy@infradead.org, shuah@kernel.org,
 brauner@kernel.org, bfoster@redhat.com, kent.overstreet@linux.dev,
 pvorel@suse.cz, rppt@kernel.org, richard.weiyang@gmail.com,
 anup@brainfault.org, haibo1.xu@intel.com, ajones@ventanamicro.com,
 vkuznets@redhat.com, maciej.wieczor-retman@intel.com, pgonda@google.com,
 oliver.upton@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <Zwf7k1wmPqEEaRxz@x1n>
 <diqz8quunrlw.fsf@ackerleytng-ctop.c.googlers.com> <Zw7f3YrzqnH-iWwf@x1n>
 <diqz1q0hndb3.fsf@ackerleytng-ctop.c.googlers.com>
 <1d243dde-2ddf-4875-890d-e6bb47931e40@redhat.com> <ZxAfET87vwVwuUfJ@x1n>
 <20241016225157.GQ3559746@nvidia.com> <ZxBRC-v9w7xS0xgk@x1n>
 <20241016235424.GU3559746@nvidia.com> <ZxEmFY1FcrRtylJW@x1n>
 <20241017164713.GF3559746@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241017164713.GF3559746@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.10.24 18:47, Jason Gunthorpe wrote:
> On Thu, Oct 17, 2024 at 10:58:29AM -0400, Peter Xu wrote:
> 
>> My question was more torwards whether gmemfd could still expose the
>> possibility to be used in VA forms to other modules that may not support
>> fd+offsets yet.
> 
> I keep hearing they don't want to support page pinning on a guestmemfd
> mapping, so VA based paths could not work.

For shared pages it absolutely must work. That's what I keep hearing :)

> 
>> I think as long as we can provide gmemfd VMAs like what this series
>> provides, it sounds possible to reuse the old VA interfaces before the CoCo
>> interfaces are ready, so that people can already start leveraging gmemfd
>> backing pages.
> 
> And you definitely can't get the private pages out of the VA interface
> because all the VMA PTEs of private pages are non-present by definition.

Agreed.

-- 
Cheers,

David / dhildenb


