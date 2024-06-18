Return-Path: <linux-kselftest+bounces-12125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 145E090C345
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 07:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA531F24AA8
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 05:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31A41CAB0;
	Tue, 18 Jun 2024 05:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FoazC+yg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA4418E1D
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 05:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718690137; cv=none; b=gmS6ODT8uUNePPYZenp4sukAwawCE+djkhRz20yV60Kt9Q2/GNSRx4iKBUHGUeWPJHiIHsaEm5Rb4Rm56nh6re+L5XGOdaDBArE8e2XBesyzs93RNSeLKn3yUFlYpYUL34iHnVMqvyQoPtycTRSUt9ntbhs0w9SBoWhSbvxjdQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718690137; c=relaxed/simple;
	bh=7RiwnKT2I1MFdE03Yi9OQNr5nfwBkB7Vzra8koLRLqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OYXrHoSw24nJD8Xq6jyaXiLVb2MsNK6Y1nnwocXmv3pdVhAsqBiFPtICz+wTKZI+qMtKsm6KnXj80RIk0nwuqV1fywhBaZyFby2JVDW5SskqwEPFsIadRmQzrpRdUrir5PtbVbz66ofa3JoVQo8oGtRlNWZ44i8hJVw+d5qcgMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FoazC+yg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718690135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWu/voSZi4FQiwHW6WOBcFhupKmk2O/NDijOpbvubbo=;
	b=FoazC+ygplA9pUbJ0Y2rODGrh+n0sPWK8Wd8yvUaPUpLc79rgNEiN6XWuis2XlGudLQgTK
	qTaRAQmev89rXS0GIwtYI/M6el8ajzBtnQCDIyMbqDD5Et4iLiZ2cn8Zb8di3IzB5uaZPT
	Zjs8zGPK7B5QHF2uXLJFvOLPB5BxoWs=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-LTN_cj-BNHWBkroEJ16LvQ-1; Tue, 18 Jun 2024 01:55:28 -0400
X-MC-Unique: LTN_cj-BNHWBkroEJ16LvQ-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-25008ff67c1so42261fac.2
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 22:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718690128; x=1719294928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hWu/voSZi4FQiwHW6WOBcFhupKmk2O/NDijOpbvubbo=;
        b=CxNMe8zANgEkxRR/FzJDzRUi+7JjAD+Kpl8E6sJZUhvfJ1copT+sq8IFvKSCAnzH2h
         PMpNnxxE2ePIoqf3H0+LAicsbsQJ2zstKsJgLsKR65nOFK8I8Tr8Kn1PDBz0lT5xG13e
         7wGU08Z8HQzZvlvAjPx/RH/qm2sac09XN7Tj2CswOaXuST/vfbTJUjZ+MQL/n6bP7z2l
         mI6TOZs80ermu8wRXy0Jwcz0F5tbJwUUnuOWBmkerF/jLw3A98/V5MgCfglcIuEN7SqP
         +y8ZfBl0m0Zh0H849fh6EzPLr1gye5H9stS10N7SDQfrU9s7l0GiRsg3NG/VdQLcO02h
         Xaag==
X-Forwarded-Encrypted: i=1; AJvYcCWlnt0Jxh4ABCk5sWCV1vW0n+01x/TWdmPFaVLhCqCp/j1ok5KTqQczVXxaVMJoN0OMHrjGymuE3332V/pZx27hhgakhzmdQ8vwfRAwPIrG
X-Gm-Message-State: AOJu0YyAkM+lhEtLGSWAIEQM7Xoff8NdrcXpKJjtiUpod12QKeBdXx+m
	VE20F9psjl1XzywP+LyTa6zNCo/3PQHpuYBHpcPE4gip5fMnmwl5XWjEMam9gOD1LEwob1mKpAf
	1VF++soBWeA8MbF5qJgN6XdBqrW4pMlZgyjKpBu2qEyPz2ynC0rI+dxbgYNi1YaDa6g==
X-Received: by 2002:a05:6358:8a6:b0:19f:4cd0:aad1 with SMTP id e5c5f4694b2df-19fb4eb049cmr1247884555d.2.1718690128084;
        Mon, 17 Jun 2024 22:55:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmf7CqoB5qG+f+SoSDNog9sHPlb0eZ/k8nda7B9rivFb2/iFdvUu6nxAvxJ5wxsEEdjtvYqg==
X-Received: by 2002:a05:6358:8a6:b0:19f:4cd0:aad1 with SMTP id e5c5f4694b2df-19fb4eb049cmr1247882755d.2.1718690127611;
        Mon, 17 Jun 2024 22:55:27 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedf592f0csm7512541a12.54.2024.06.17.22.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 22:55:27 -0700 (PDT)
Message-ID: <8fd7e58d-1d87-430d-a974-47ee05bc72de@redhat.com>
Date: Tue, 18 Jun 2024 13:55:22 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] KVM: arm64: Making BT Field in ID_AA64PFR1_EL1
 writable
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
 Catalin Marinas <catalin.marinas@arm.com>, James Morse
 <james.morse@arm.com>, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
References: <20240617075131.1006173-1-shahuang@redhat.com>
 <ZnB1FPw3Eg8-61mL@linux.dev>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <ZnB1FPw3Eg8-61mL@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Oliver,

On 6/18/24 01:40, Oliver Upton wrote:
> On Mon, Jun 17, 2024 at 03:51:29AM -0400, Shaoqin Huang wrote:
>> In this patch series, we try to make more register fields writable like
>> ID_AA64PFR1_EL1.BT since this can benifit the migration between some of the
>> machines which have different BT values.
>>
>> Changelog:
>> ----------
>> RFCv1 -> v1:
>>    * Fix the compilation error.
>>    * Delete the machine specific information and make the description more
>>      generable.
> 
> Can you please address Marc's feedback?
> 
> If we only make things writable a field at a time it's going to take
> forever to catch up w/ the architecture.
> 
> https://lore.kernel.org/kvmarm/86zfrpjkt6.wl-maz@kernel.org/

Ok. I will update the patch series again with tackling the full register.

Thanks,
Shaoqin

> 

-- 
Shaoqin


