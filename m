Return-Path: <linux-kselftest+bounces-11843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372789066E5
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 10:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F9FA1C226D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 08:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0A213DB99;
	Thu, 13 Jun 2024 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jrz6ntXs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFCE4F8A0
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 08:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267516; cv=none; b=jGzlYNH0obUM9UZ8lXnuSvmdOV1A59o6yCE26tJuE5qcMXEs5SFFZTK+xpOfPXzqhDKzjPoEphN6SX927f1W2zuliymgIJ6Zw1BSRWYLGlGGUVNu3FujpswOG8QHaB1p4pqht7c74VwVDja7LP2pN0jcoC1OgGJvsXcNydFCJFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267516; c=relaxed/simple;
	bh=whSDBIPeQCp4gMTbg1boII8Ecw7cjvT8USnKGbp5wwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpbQdqiTuZeqhnp33tZQY3z9tJY5lapZddDfYi3k/1no4CBWjmIq/0dMDccn1WK+Lzp2R5xnOUt6w2mnH3BGbgVvY0xTOrvNL64dSTL77QrMqV6h1PxZz/5eYbdq/8kylAYjThFquuk9Xx6r/P/ibaSHCEu4/vVLUbZIioAwN3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jrz6ntXs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718267514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y5ofu96uaYHKd8h9JHJ7poUCKR58img+rTZnrw0Den4=;
	b=Jrz6ntXsJUaeUx2Zio1wYfb1YkPptTDkOFgdXOCb9wahYg+gUzaPCrunf4/pRhfB/KZslu
	+jUvpWJpaFhWjhuwVvvlOJsUcjJSj6OLnshTTo15AqdMrQ+UecQR0e90QQrL9WtR9rGTYI
	OIm9QMwrvdsgnGZiigAAFnHk47ybysc=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-CKdGwOMoOB6aQk8rBD5pGw-1; Thu, 13 Jun 2024 04:31:51 -0400
X-MC-Unique: CKdGwOMoOB6aQk8rBD5pGw-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5ba819595deso89424eaf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 01:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718267511; x=1718872311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5ofu96uaYHKd8h9JHJ7poUCKR58img+rTZnrw0Den4=;
        b=Ipkf+TZzKS92hCvOlEOvCfuRdT6FlFTc8TEcH4O9nWvdoDOlO/WPYJJf32j9837Yla
         udcC8GTiL4/mjDqsumkZk6UYdWZVml7dEisBP8SDQA/cM2wpGCBC2MtKBzDhEHFGQUo3
         sOil50rbHz8LQ4rAQQ/1aB6MnBnFIttoEKk6O6dugwtw2+abNu7CGmxwVFc6SpjN9zbc
         eZ82Djy3dIwgMTBMoZXpVDR8pXH9DLqcTrPWGf0bSBjcfZLx8VGMQwS9nuOeVRgVh/0J
         ntLu/TpwrqDwOlaQRTEZLNPgCGWDL2ntNNpThNC8dEMRzWXi9B9laFVOXZJ1QHcsR7VD
         4qUA==
X-Forwarded-Encrypted: i=1; AJvYcCWoK2C4rUx6Bnn+aqq8RRFDfZ66crR59QNKYpft3w81gJCBvBvl1tVeB1J3DiR/tEOpTIj2Md0Bvj/LsztKjOao1mEJtRwuh6Pu1pUxdIQU
X-Gm-Message-State: AOJu0Yz++ckaTvyIjx5EnFwdyHWJLhr68dTHY347IHNMjO8OwwKerIQa
	ZqBA0OwA2Q0E32G7Nl/dsit3Xpdmk5VqbVZA3Omq6ubAo6L4vzggauFpvo6BRP7AeWrfhpyqbxL
	4J6w85EfXU4Dh4lZwjn6TT81otXk+AYfQ6kOzx8S5UwuVVRumdub2rtLCQdylz8hmBQ==
X-Received: by 2002:a05:6808:1520:b0:3d2:1b8a:be6f with SMTP id 5614622812f47-3d23e1841d5mr4726138b6e.4.1718267510988;
        Thu, 13 Jun 2024 01:31:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ4j79H8ujkrU/qWo7O+2rnKVyh0633ZsTv+AwDBtZWDY6NR7eeeLO/kPYWb9bhOY6WZNPLA==
X-Received: by 2002:a05:6808:1520:b0:3d2:1b8a:be6f with SMTP id 5614622812f47-3d23e1841d5mr4726128b6e.4.1718267510446;
        Thu, 13 Jun 2024 01:31:50 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cde0dbdcsm726826b3a.147.2024.06.13.01.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 01:31:49 -0700 (PDT)
Message-ID: <7f1ca739-42f5-4e3a-a0c9-b1eac4522a97@redhat.com>
Date: Thu, 13 Jun 2024 16:31:45 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/2] KVM: arm64: Making BT Field in ID_AA64PFR1_EL1
 writable
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: kvmarm@lists.linux.dev, Eric Auger <eauger@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, James Morse
 <james.morse@arm.com>, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
References: <20240612023553.127813-1-shahuang@redhat.com>
 <Zmkyi39Pz6Wqll-7@linux.dev> <8634pilbja.wl-maz@kernel.org>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <8634pilbja.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marc,

On 6/12/24 18:07, Marc Zyngier wrote:
> On Wed, 12 Jun 2024 06:30:51 +0100,
> Oliver Upton <oliver.upton@linux.dev> wrote:
>>
>> Hi Shaoqin,
>>
>> On Tue, Jun 11, 2024 at 10:35:50PM -0400, Shaoqin Huang wrote:
>>> Hi guys,
>>>
>>> I'm trying to enable migration from MtCollins(Ampere Altra, ARMv8.2+) to
>>> AmpereOne(AmpereOne, ARMv8.6+), the migration always fails when migration from
>>> MtCollins to AmpereOne due to some register fields differing between the
>>> two machines.
>>>
>>> In this patch series, we try to make more register fields writable like
>>> ID_AA64PFR1_EL1.BT. This is first step towards making the migration possible.
>>> Some other hurdles need to be overcome. This is not sufficient to make the
>>> migration successful from MtCollins to AmpereOne.
>>
>> It isn't possible to transparently migrate between these systems. The
>> former has a cntfrq of 25MHz, and the latter has a cntfrq of 1GHz. There
>> isn't a mechanism for scaling the counter frequency, and I have zero
>> appetite for a paravirt interface.
> 
> Note that there *is* an architectural workaround in the form of
> FEAT_CNTSC. But of course:
> 
> - it is optional (and likely not implemented)
> - it is global (hence affecting all SW running on the machine)
> - it invalidates the requirements of ARMv8.6 (who cares?)
> - KVM has nothing to do with it (yay!)
> 
> So if the two systems (from the same manufacturer) were ever designed
> to allow migration between the two, they would have at least baked
> some of that in.
> 
> As for the paravirt interface, I agree that this is a non-starter
> (been there, done that, dumped it in the bin).
> 
> The patch itself is interesting and may be of use once it has been put
> to a compiler and not just dumped on the list without any testing.
> 
> 	M.

Thanks for putting your comments here.

If we don't care about the FEAT_CNTSC right now. Could I fix the compile 
issue and respin this again without the background of enabling migration 
between MtCollins and AmpereOne, and just keep the information of the 
different BT field between different machine?

Thanks,
Shaoqin

> 

-- 
Shaoqin


