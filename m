Return-Path: <linux-kselftest+bounces-9777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9118C0C99
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 10:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5A51F2212B
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 08:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A4014A0AF;
	Thu,  9 May 2024 08:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5D41YDz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410C538D
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715243479; cv=none; b=qWC70qfis3DU24U7CrCl1MhROvujw1UZxs2ErcjjsptiyOehZG7qIAoOSlBP865mg6JO3sSLmutGiYdGnUqYH0Ty1QYW7zbAfxaLogIXqCS6UiZ01m2WzuX/CUrG2Ljiq8PbtxvNbUuowBW4To+Z5U0bu4JtjoYyune9WiET7kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715243479; c=relaxed/simple;
	bh=7ID1rToGO6FV8Ko6jC9I6odtMEZUtKX4UtvAihm9EJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBPMSqwrKDha18LXzJL274/qkeN/zguMTybw7vfYz+OV1arG5AVqTuXirkKXEK8UXsiwerSv0tZNzd+hvc7qtGAo56z4HKvrJAo9tczQ6o4Yt7jOowuEp0qcMws7AhBxCdcYseyasoCYgEEIpaC110txl0A6ig1H3s6vIQaKi+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D5D41YDz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715243477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qyLoEsP3k6nAZoTuZVbKVL9pP/BQ583fGCs2TBzayoY=;
	b=D5D41YDzSvej9nyp6J2MdSSc4syne5YDFzGCVZEV1ofpzhQ0Yv7QiyLkGjSS4Ef84ReBzA
	zxCt526i90NK7hF2JDjwZok1dqmoucsnwQyctJeyiFoQ+hbed/yot/F5jvvGBfyPLklImr
	bIL53yBXQiqOnMys03U7zfGk1PH/wew=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-KbF6rHi_NX-vBt8VSuTEXQ-1; Thu, 09 May 2024 04:31:14 -0400
X-MC-Unique: KbF6rHi_NX-vBt8VSuTEXQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1ec5ea746easo1675025ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 01:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715243473; x=1715848273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qyLoEsP3k6nAZoTuZVbKVL9pP/BQ583fGCs2TBzayoY=;
        b=eDv6n4g+BUlE2czYGWZl45PjuXaW7a7Yz9R659ALjvwC3eHGuJWV5ZVsLoJPa/YoXa
         mxGcmycTYCmYNXimDq2Cr3UEzZAcbGN+0sXGI1cHXQ4eikYzWVHpeCitOPXEqwivxdCd
         H9gQ11uvh3apZggOxsz9H6wthIUQCcUsN9ya/lKoujU7N/yGAxZYA2yIdSCE6GVuIcza
         STmjuvg4B5uAmZvzAGFGYn949XL0qX9S6vw8wt6fW5+AFGhiYvmrdpGCFZpdcCeQa5T2
         36EmJY8agiXw0W6/2YD6tQJcczuBwV6dF3YjZFlUtmy+RaGP811d9AWqPuwiEltNEkz1
         Jl4g==
X-Forwarded-Encrypted: i=1; AJvYcCUoneiiQ0SdQ4dsA6dWsmT0bkXi4NUOTXg5jYfoDSM6kV05UXb2ZUKhTGkslsmotHpxopGfZ7ds+guXaUugcqiJ4iJEbkSSuFMJbMNlL+nT
X-Gm-Message-State: AOJu0YzrpsWQ558imyzxyonV0a/+gjOP4ZW6CRLC3OI/CfLzeSmxvAT/
	Ws/BXdTYFxcZ1YSwnv33aVfu+YrsyXknL+HKD8dOlxCdA0RZO2kKMoR6na0e3fnnl5bsDtnZ2vG
	JnYp2qe8bp+PQeQ4lMDlkcmbiT3/gqcU1HvWA23Opxhy0LwXuC9a3lx9Bho1o+ltiwQ==
X-Received: by 2002:a17:903:32ca:b0:1e0:c91b:b950 with SMTP id d9443c01a7336-1eeb0991088mr55435965ad.5.1715243473455;
        Thu, 09 May 2024 01:31:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy88S+twFySdt2w58Zlcx8S84DyRgcz60dnvWnGkTIvs8eX96Nen1CTdXmNnwgxjimggZ+9w==
X-Received: by 2002:a17:903:32ca:b0:1e0:c91b:b950 with SMTP id d9443c01a7336-1eeb0991088mr55435805ad.5.1715243473059;
        Thu, 09 May 2024 01:31:13 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad5f0esm8687155ad.67.2024.05.09.01.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 01:31:12 -0700 (PDT)
Message-ID: <201ee016-9b0f-4d4a-ab85-722c3e6a1743@redhat.com>
Date: Thu, 9 May 2024 16:31:07 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] KVM: selftests: aarch64: Introduce
 pmu_event_filter_test
Content-Language: en-US
To: Oliver Upton <oliver.upton@linux.dev>, Eric Auger <eauger@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240409030320.182591-1-shahuang@redhat.com>
 <20240409030320.182591-3-shahuang@redhat.com>
 <acbc717e-5f7b-405b-9674-e03d315726cb@redhat.com>
 <Zjo_Yj9_dkZiQIBT@linux.dev>
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <Zjo_Yj9_dkZiQIBT@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Oliver,

On 5/7/24 22:49, Oliver Upton wrote:
> Hi,
> 
> On Tue, May 07, 2024 at 10:45:24AM +0200, Eric Auger wrote:
>> On 4/9/24 05:03, Shaoqin Huang wrote:
>>> +#define GICD_BASE_GPA	0x8000000ULL
>>> +#define GICR_BASE_GPA	0x80A0000ULL
>> in v4 Oliver suggested "Shouldn't a standardized layout of the GIC
>> frames go with the rest of the GIC stuff?"
>>
> 
> Just a heads up, commit 1505bc70f80d ("KVM: selftests: Standardise layout
> of GIC frames") will do exactly this, which is currently on /next.

Thanks for pointing this out. After this commit being merged, I can 
remove those GIC layout staff from my code.

Thanks,
Shaoqin

> 

-- 
Shaoqin


