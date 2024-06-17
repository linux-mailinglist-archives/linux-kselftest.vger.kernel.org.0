Return-Path: <linux-kselftest+bounces-12047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C3990ADF5
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 14:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16FF41C21D1A
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 12:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF9F195987;
	Mon, 17 Jun 2024 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLBVerP5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11FA195815
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718627379; cv=none; b=H4AYGXnZyIbZuy9NJsgoeBxYqCHggvk27YtbDi3fmlKTK0c6dz9dKosJaDv+Qm5rsapgJN7H8U2gYsGLPHVtkkOdn3L+BDlJHG4MVMAEKbWaQe756bxzXFcRgf/nAl9oW/eYBtwG3hewn8m2tYcKOtFvHZMY8UyYel4XplnlYBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718627379; c=relaxed/simple;
	bh=oXXpiunHz1XPLIz1naFMTm6sFnP7b0TdXzOlcK0P/sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0pNITLcOuD0bh7UVJ/7HvaTMyg5DkmbgPZ3rTVPFYb763bsHvEyr+S8X0vBlQ/zHfKlVCkBN4yKdSsApAALhbojaMdyKpX1dFLOqrmMNff49d9oYA9BdotAzlsbzrayoZoHs7NKSckAe2F4HUJx4LZdsKf31VCr3wHkBhbvkEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLBVerP5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718627376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I4ssGu5P5LE/MFN4qx06ygb2gBN8nmvpUBOwBXD3IEM=;
	b=aLBVerP5yGv/3KczdlhrshLk5x05rw0VkSJ3DMgg7a6pTOEhEn9RInn3kXIA70TlsND75V
	/aenze/9SuiXWgYi5kpyUvT6tDfdCYhamLdE2o2Gozx7hbksH41Mlbl9E5a1sopp3a+ICy
	x8e8lnxj8OU+sxM/a8MHGesI7TDhtyU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-t6nbU16JOza-3fDmUi4_bg-1; Mon, 17 Jun 2024 08:29:34 -0400
X-MC-Unique: t6nbU16JOza-3fDmUi4_bg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c507f6673bso559742a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 05:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718627373; x=1719232173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4ssGu5P5LE/MFN4qx06ygb2gBN8nmvpUBOwBXD3IEM=;
        b=heeLnxaMYxfnILNCDQ4VtIPVSSNLJMXkf6zGJ30ACLJKr4rE5VjLqB16/xM7O/ETA5
         ILyl0qqHwoIXJjqM4Y0QTAgxJfsmuBPtqwfdoFdl6bpescfjJcsIYxNG7Yxcn5nu4rvb
         GshJvrME+kSTGw4j8UBU8Fks91WJXmj/jVpHdntWJ0ntfLwfCFut89kgS1s9XjkPMQm0
         8WvHn8r4FVDqW5lgjE3LjZRvYWf0xwnKDa/n6j8w/DIf+wBcNbf/UJhy54jfdPQ2iF2t
         aCU6ZhGMb1q+n+FEo6kAvdKKY1+qwvlfpP+l/UKw63OS1M6J6lgySXpTeT7/TFoh9ink
         nrNA==
X-Forwarded-Encrypted: i=1; AJvYcCV50wgEBYnARnLeeEQSyoIVY9Fec8ULmUn6VOjhlifPPSGiy8xw7T4ZGqBIkebT7mpN6QLd+x+CYiANhZS6QrkFDbt5aV561umn64bYokeR
X-Gm-Message-State: AOJu0YxBJnECGv60iSNOvYLPp3nedI++wcYwS9lZ1STxji5P/tmSgFHM
	D+vCVXEqnJ7AQ+zT3LzHRjtND5rTMl2ulLJ9q+QiUs7A+SYegoUy0BQYMvT8UUD+cyMOpqu7r/X
	7OPIg1q3ayatnYgXxPERQFy9Dn3Nk85oOipRS9Im5FoeUj2M7zX2BqpKnCl7LtsLTBw==
X-Received: by 2002:a05:6a20:5aa9:b0:1b0:1be7:3708 with SMTP id adf61e73a8af0-1bae7e3d928mr8545352637.1.1718627373331;
        Mon, 17 Jun 2024 05:29:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOU5fYRtot9iBJXy2SS9IX2XSkrNEwI68apkvLYUeP2Vlv30jHjv3k+GFqCmYhxr4fz+B5Wg==
X-Received: by 2002:a05:6a20:5aa9:b0:1b0:1be7:3708 with SMTP id adf61e73a8af0-1bae7e3d928mr8545338637.1.1718627372892;
        Mon, 17 Jun 2024 05:29:32 -0700 (PDT)
Received: from [10.72.112.55] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc967356sm7261218b3a.63.2024.06.17.05.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 05:29:32 -0700 (PDT)
Message-ID: <9db95188-71c2-491a-a4c7-434e7cd3c407@redhat.com>
Date: Mon, 17 Jun 2024 20:29:26 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/2] KVM: arm64: Making BT Field in ID_AA64PFR1_EL1
 writable
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev,
 Eric Auger <eauger@redhat.com>, Sebastian Ott <sebott@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Catalin Marinas
 <catalin.marinas@arm.com>, James Morse <james.morse@arm.com>,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>,
 Zenghui Yu <yuzenghui@huawei.com>
References: <20240612023553.127813-1-shahuang@redhat.com>
 <Zmkyi39Pz6Wqll-7@linux.dev> <8634pilbja.wl-maz@kernel.org>
 <7f1ca739-42f5-4e3a-a0c9-b1eac4522a97@redhat.com>
 <86zfrpjkt6.wl-maz@kernel.org>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <86zfrpjkt6.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marc,

On 6/13/24 16:42, Marc Zyngier wrote:
> On Thu, 13 Jun 2024 09:31:45 +0100,
> Shaoqin Huang <shahuang@redhat.com> wrote:
>>
>> If we don't care about the FEAT_CNTSC right now. Could I fix the
>> compile issue and respin this again without the background of enabling
>> migration between MtCollins and AmpereOne, and just keep the
>> information of the different BT field between different machine?
> 
> As I said, I think this patch is valuable. But maybe you should
> consider tackling the full register, rather than only addressing a
> single field.

Yes, it would be better to tackling the full register. I will put more 
time on other fields in the register and try to making more field to be 
writable. But currently I just respin the series with deleting the 
machine specific information and fixing the compilation issue.

Thanks,
Shaoqin

> 
> Thanks,
> 
> 	M.
> 

-- 
Shaoqin


