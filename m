Return-Path: <linux-kselftest+bounces-8444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D7D8AB23B
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 17:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E3D1C21786
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 15:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA59412FF93;
	Fri, 19 Apr 2024 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4BSm3zF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A9F12F5A3;
	Fri, 19 Apr 2024 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541549; cv=none; b=uZrcoj+g6v9ypcfEDO+BG6wfMATIVdURaQ34quhlJf+uf3+17T1mbjbxcazAFYRqPezM/WfboKbar9S5XdlG+69/uDx1KKvf00tiEjfsAF4zwWw6u0Vlt1nRbVUgCm5szjtYNBgZyu2h3+IvHyBuH4kCtEzhQskL/31RxWGKlXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541549; c=relaxed/simple;
	bh=VsHiV3sJXY6clmFYZP87P9hiEDmV+Q8vGENBwO5KwDA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lVKKyjwyHyquif4wqyRwB77CHrQDvMdkEP6RgpYSpCk6H0nxgac5eva411NR6PFzR5G9/qKvt97JT+beYphcvizO+IYpxN9dEkqWoWhIF/tDJ+/vg+prXfF+NkixLnMgl0GIrG240JGQzre20jJ4eSZJu9WN4Cibh20hKUq6l6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4BSm3zF; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a5590f3b60eso28284566b.1;
        Fri, 19 Apr 2024 08:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713541546; x=1714146346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Igt3nyZHnJFoLExicXWRh9ig32kbEPXi1h6YLsNI80Q=;
        b=c4BSm3zFpG9jzcPHUZE+Y202qUNKS0AKxAUfbf5rcrziogzV85YbOzOMBBZpvkoLFc
         7clak/PaNAg9rCsr0NW/bYBNsBpJHf34m336AIvaiV/zoMgT6n4VPdaSQn9mAxhfFg4c
         Skbo2/Jg5Rp4uadUxsMmdFeNE8d60nETMni3i5ad3ev6aDbra8Qa0WMjQZE8gGNU0JWD
         upwn9+r39Kwb0UCpI5zSCwmIbO8RZFJpEE3tPNnjXntI1bzZa9ThOqBy3RxjKbBmzdh3
         h6r7p/JqdaNpGT1WP+NbiUTsCvkHcSye4zJyxmdNjmhUh4C0kqD5h/4I/2oqIVEbs+ZO
         eAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713541546; x=1714146346;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Igt3nyZHnJFoLExicXWRh9ig32kbEPXi1h6YLsNI80Q=;
        b=evqBp1t2UQcab2s6xVMtcWkuvjhiRkir42yuod+b5fcMDrkL+rXPXUlMnTk72QdOFB
         DsggNjEwNfWAhf2qz3S3x/rKgVtZoaq8XP2k+3qJkuNOw6EET20m2xhEYciBNQ/xzRjU
         OyDxGFNR3bTNmQvRULyjR3vlTjWATV67kz5WaAm2OyLE+Jr9tpDghZqHNO/4SW7gmt1T
         NK3U8P18jQsnCXTEoqjrv7L9VkSjjykFNLDij9vNQuVec4hHOxkzpEqHfi1kPQcmt4Ee
         guJLOVJc45hSXZbaCV4CVcxmUVwR7zpmMmlVXmgQlEKWZyvr5Cwear2aDeensjGRxmY0
         U2kw==
X-Forwarded-Encrypted: i=1; AJvYcCXZpo5f/QDiDOqqQB+wdKHokiShMTaZkgrY1orKJcI7MJSxMD65teNB4Cr+CmncAEvKuZ1ssElZLp/4bMvbOuHdEIcvzLGPNV7Fs55W2Sa+qZk1rmSBWdF5mY4MPHuiXbpwzNh6FcR0NzgKGpuEkTcvL8RJc0Bsfg9j9jZXBZTx8GezmlvUS6R2gFCzgVeXfA0G8VZ1oP+oIPFIpXqc
X-Gm-Message-State: AOJu0YxvT9hyKoP1E1phhRKAgsptv+S45pDvizPckJj+lXRhdPYeFKbd
	L5185slKL75oAyJI8JlK6hL1RCbKlFniNSs1WoY/fXkFBnAKtMhI
X-Google-Smtp-Source: AGHT+IH4oMDVv63C4YrB7MPWKe+gpklFuZnLR5uOJrOvrQ0NIbfXqFtmXWCqZJCWyjmnL9PUr7abCQ==
X-Received: by 2002:a17:906:6c99:b0:a52:2d81:6d1 with SMTP id s25-20020a1709066c9900b00a522d8106d1mr1716531ejr.51.1713541546339;
        Fri, 19 Apr 2024 08:45:46 -0700 (PDT)
Received: from [192.168.18.253] (54-240-197-236.amazon.com. [54.240.197.236])
        by smtp.gmail.com with ESMTPSA id i21-20020a170906a29500b00a526a992d82sm2331342ejz.4.2024.04.19.08.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 08:45:46 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <38a88d9c-4908-4658-a6fa-63ff7a534132@xen.org>
Date: Fri, 19 Apr 2024 16:45:44 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH 05/10] KVM: x86: Explicitly disable TSC scaling without
 CONSTANT_TSC
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
 <20240418193528.41780-6-dwmw2@infradead.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <20240418193528.41780-6-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/04/2024 20:34, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> KVM does make an attempt to cope with non-constant TSC, and has notifiers
> to handle host TSC frequency changes. However, it *only* adjusts the KVM
> clock, and doesn't adjust TSC frequency scaling when the host changes.
> 
> This is presumably because non-constant TSCs were fixed in hardware long
> before TSC scaling was implemented, so there should never be real CPUs
> which have TSC scaling but *not* CONSTANT_TSC.
> 
> Such a combination could potentially happen in some odd L1 nesting
> environment, but it isn't worth trying to support it. Just make the
> dependency explicit.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   arch/x86/kvm/svm/svm.c | 3 ++-
>   arch/x86/kvm/vmx/vmx.c | 2 +-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


