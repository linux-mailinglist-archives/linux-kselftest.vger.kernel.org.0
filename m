Return-Path: <linux-kselftest+bounces-8456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5DA8AB29C
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 17:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB121C223CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 15:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43952130AED;
	Fri, 19 Apr 2024 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTeGaFvb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D98A7641E;
	Fri, 19 Apr 2024 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713542273; cv=none; b=Ngl0NbvpPPczeCwuJF2cMvIHLu1dAjmhrKnatX/HHlERnt9Llfjv9hjScaXXrqjF9oo9/Mezd/vWYi9qU1d4AjpHSHb45XfMx9NlbuDuRGnehMbtpI2PPA8xvQGn/AQZL9HDi80Mb406wpC7d6wEX1KhwandkFMGyzc6aZqWzds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713542273; c=relaxed/simple;
	bh=p0krAk1jiQxQ123SAtQWQLXKI9LtWzjzx8uLRsGhf5c=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qe+z3OHJtgdzahLP4kVcqimmEDlyWvwmS+uHiCuhXGM63AeCe5seiRLqd6KFOGsVElQwInUz9C7y8scTLVkoS4ZqxRiFeZKHI1W3MHNygajXJQKEUI49PlR8AbhZUol3qVgFIvOn054C/dQbViSMQZduFVG71juF1WopLwc301M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTeGaFvb; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a523524e5baso226078766b.3;
        Fri, 19 Apr 2024 08:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713542270; x=1714147070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HpXOWQj2snTMmKD9LnnQ7qsX6BXZ2LIc/4KRNqoR6Rs=;
        b=NTeGaFvbNIoAwTqkgy/YOZWRA/SXyy2pmF9PPN1TX2jD5shC43bIrlQt+eVwHDpi5O
         UUJEBcDHhrveB+19Gd38UXdeo8m7HJkcpiSnZLpBrQGe31HIEOkxGfLjFnordNU7e1K5
         4DzWl3dqF7VLZ5Vm7XbZzceiSVTB9jQcw25UR6Cg1lxOrOM/Ej7Fp+0kFGv/lHpm4b4Z
         ognPfXdeaWFE+VAiyeerqg9QcWO1lk7wGHMt65pmMQTAkOE+VYfAI+G8/1tX0DL3et3K
         Fb+/pOpH+32ZIUEB1t6yvlXwQYDu+xto7WM1mmSWQgfvJk3ZMZz/QjDsL72zPz4K5+IV
         URFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713542270; x=1714147070;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpXOWQj2snTMmKD9LnnQ7qsX6BXZ2LIc/4KRNqoR6Rs=;
        b=kq2P3p37wlCHoqnR2CUld1pT4XSjMEOo3s0ypyFSVT21iEdRLO3HY5VhXeRrx1v5cW
         FDFm5ayaN1/sDMKUfzOuV3tK7N4Ch4y90h40pboFUeWT6PzMUaIGoOs1SlY3wDHnNd7w
         8PJr0pAHizUV6nmwdyMTpyg3ncQF/m41Gds2jBQLRJ3OPIohXNIzjGaJhcVmlkggdthc
         vH8LqP1j7Ec1SbHCIGxxrEL0VkCaE8kMP8tpHTPxhZRwuNRZ0uoYWB8uLQAid1Hs0CcE
         b/FUu8hyUusGePEAP2apPjzQ/EqdR1tCrufymrXA8030Bzlnf3Wa0mjofHZHtQamV+oT
         easA==
X-Forwarded-Encrypted: i=1; AJvYcCVFO+UWhTCKtt1dYEOZU+U9jW923awCK1yglnIurIw6Xa81aZ/OIHRsi4JOL4yPbd5OVJhlHsu1OjPiEu3aMOxda3vliLGEsMkXW1/9j1NMwLH0u8kX7lNwGVVX3AdjcFATwYyA0vA2JklZZfGlo/c0Rq4w2NA0jnUPtwXQF4gvyCGZrebVupXsdMGVFeinMICgMaUC6QhLjQHBwIp1
X-Gm-Message-State: AOJu0YyGDkILZqBUApncfNZ4+9Tj/2x0exgXcCsFjyNwA1EAxs4VW/sg
	DVnlbdXt0L0X6eq9OkQCy1XCveqUbWzsVfjCA+rtsTTSv7P2Xkgr
X-Google-Smtp-Source: AGHT+IFMnS2LQ0x5IC0rtaQ7gu7+SOitEiNCtvr3ygRrbIgIDwtV19ryHjjRz4sR35z73ejiJ/snNQ==
X-Received: by 2002:a17:906:7fd2:b0:a52:27c6:ee67 with SMTP id r18-20020a1709067fd200b00a5227c6ee67mr2202110ejs.43.1713542269690;
        Fri, 19 Apr 2024 08:57:49 -0700 (PDT)
Received: from [192.168.18.253] (54-240-197-236.amazon.com. [54.240.197.236])
        by smtp.gmail.com with ESMTPSA id u18-20020a17090657d200b00a51b26ba6c5sm2344277ejr.219.2024.04.19.08.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 08:57:49 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <5c9de76b-6981-416d-a833-50264496236e@xen.org>
Date: Fri, 19 Apr 2024 16:57:47 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH 09/10] KVM: x86: Kill KVM_REQ_GLOBAL_CLOCK_UPDATE
To: David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Oliver Upton <oliver.upton@linux.dev>, Marcelo Tosatti
 <mtosatti@redhat.com>, jalliste@amazon.co.uk, sveith@amazon.de
References: <20240418193528.41780-1-dwmw2@infradead.org>
 <20240418193528.41780-10-dwmw2@infradead.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <20240418193528.41780-10-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/04/2024 20:34, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> This was introduced in commit 0061d53daf26 ("KVM: x86: limit difference
> between kvmclock updates") to reduce cross-vCPU differences which arose
> because the KVM clock was based on CLOCK_MONOTONIC and thus subject to
> NTP frequency corrections.
> 
> However, commit 53fafdbb8b21 ("KVM: x86: switch KVMCLOCK base to
> monotonic raw clock") switched to using CLOCK_MONOTONIC_RAW as the basis
> for the KVM clock, avoiding the NTP frequency skew altogether.
> 
> So remove KVM_REQ_GLOBAL_CLOCK_UPDATE. In kvm_write_system_time(), all
> that's needed is a single KVM_REQ_CLOCK_UPDATE for the vCPU whose KVM
> clock is being configured.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   arch/x86/include/asm/kvm_host.h |  2 +-
>   arch/x86/kvm/x86.c              | 57 ++-------------------------------
>   2 files changed, 4 insertions(+), 55 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


