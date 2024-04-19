Return-Path: <linux-kselftest+bounces-8452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EAF8AB279
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 17:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B4D0B22622
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 15:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94103130481;
	Fri, 19 Apr 2024 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBssYoT4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3454D110;
	Fri, 19 Apr 2024 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713542034; cv=none; b=lar4/Yb8GMKH4ISYNxKt0Rzefd+rpa3W2T6Wz1f8CncMS8+wWuI9fRuPaaq70POtL/SsDT9yLi6IBzc0hrH2uQYmG9Xyce6r1GcC9BCiO/puv2qvoUaYJB1oM5+aK0osvonochJfVQHKK2077vl2Y/bStPlhKGreCtXi1rHp47w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713542034; c=relaxed/simple;
	bh=cBJc/5ludq5tsm/6USaCmEXWAHt4KSBZz6I974uN9Po=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LZ5YYWX7SSnf/Bgh/H6z/ESIj4VZLmlI+s8/FIMTyL8fyvmOFtVECWx6+Hs6F5hekQAzlGK2HSn6xwYuTlOwXxT9tTsAWjtZADN5BZ+BstGxSfrbU1TgezLOic1hGvMztFaowm5jQJNCHy23w4jQgK588/Yb3MCcVzR5M9WFFFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBssYoT4; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a52aa665747so258645166b.2;
        Fri, 19 Apr 2024 08:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713542031; x=1714146831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fwQuiJSvzr8PFiUAI47KhzIHYFmwFwN2S6DtxceXDh0=;
        b=BBssYoT4cjbf6Ev039DE21SLr+WIpAMtiN5uGJ1nIExtxVJ5Vea6jtjXnA9aCMEqNn
         5fltdOV5WvLzOrBXNx/EaSboyNoaHODIgu2WvPqB4NTnxkPavH7ArQX0LaxXem9jh39V
         CZ1MtuckYeqZDcdEiNYfkbZV3jTfNy2ZdouHWUyeOdfliT+2HcgcvqSX9NZVvDQYOJ7Q
         jZTo/51E6CtyW/INwXJ+0UG30F+o6YtQQyD0paGSenoODFCv/JJfulz9iUdaKYdDECYD
         LtF3SMj0C1GRblHC8Eo3MJGT/ErshBPjjXh1ZIXv3MEgOgYCqcweH8Bgfkz79sCAXjjq
         YTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713542031; x=1714146831;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwQuiJSvzr8PFiUAI47KhzIHYFmwFwN2S6DtxceXDh0=;
        b=oBgsR6XDDjoU3kBvoApZvabWo2BI8ZOQiTVqcJVsqCfELbh8yNymHj4ntzEl7ykWbY
         c/vuFX5xTzb+DczePUl+l4U5PQNW50PX01C8K6mlhlhOiDnFnhfJhenCfXAGWSqnVPkz
         zQv+DxTHRUam3TT0zWDI8we/B2j6hFxw9Z9VeKWNUSZT7LtVPxqcC653mO0MF72h/Sae
         RT7kCfjTkZmBqkknAXrl+8JCwD7IM4uFctR5qgWiyuataiioa28brkyJbthwxUjgD4ZD
         X3xVrrc6Xd68ihXdcKv6jcUV3VfkbOQNiATIGncCSRI7B0GbFuoMhfC6r0nfpNrWgnMW
         /XFw==
X-Forwarded-Encrypted: i=1; AJvYcCUEo51p9RJ0GLGJve7IIBhKWc49dKqVdRGS//w0M++1bAOhSjDyJbdEOjdtAkILL47kqxYdZ27FM/BUBd5HXHVFFCAXEH9oACbHjpRGOJpA+exWgMokaquXPvutgJs74UpCiU9r8kQ2P7unWQLqHDrQ9cVorJuQYEe8RJVrBMNFp3UjSoNO8hbtRwxQXeu0R5urW0GgcO9GRTqhLc1G
X-Gm-Message-State: AOJu0YzM74PyMmKQcw9hX/MOSIXJxM0YeJ27y6YHhxe9gu35bHrwOT/S
	5CdJw4ZLfIzx058tIIO7O8HReuW9LgMrjeHifkIDo569mIAc3GyU
X-Google-Smtp-Source: AGHT+IGXLJwP1kkQdWIyL4VAo03CJGrcXSsdNIvYNktqHUK6leBuGOUh95WBNddN8oRcDWn2xbsV/A==
X-Received: by 2002:a17:906:3406:b0:a51:e5c7:55b7 with SMTP id c6-20020a170906340600b00a51e5c755b7mr1953078ejb.47.1713542031092;
        Fri, 19 Apr 2024 08:53:51 -0700 (PDT)
Received: from [192.168.18.253] (54-240-197-236.amazon.com. [54.240.197.236])
        by smtp.gmail.com with ESMTPSA id p25-20020a17090635d900b00a51d8a3a632sm2308501ejb.168.2024.04.19.08.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 08:53:50 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <b668e938-a48f-4295-a9ec-e66f0abd1bb0@xen.org>
Date: Fri, 19 Apr 2024 16:53:49 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH 07/10] KVM: x86: Avoid NTP frequency skew for KVM clock on
 32-bit host
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
 <20240418193528.41780-8-dwmw2@infradead.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <20240418193528.41780-8-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/04/2024 20:34, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Commit 53fafdbb8b21 ("KVM: x86: switch KVMCLOCK base to monotonic raw
> clock") did so only for 64-bit hosts, by capturing the boot offset from
> within the existing clocksource notifier update_pvclock_gtod().
> 
> That notifier was added in commit 16e8d74d2da9 ("KVM: x86: notifier for
> clocksource changes") but only on x86_64, because its original purpose
> was just to disable the "master clock" mode which is only supported on
> x86_64.
> 
> Now that the notifier is used for more than disabling master clock mode,
> (well, OK, more than a decade later but clocks are hard), enable it for
> the 32-bit build too so that get_kvmclock_base_ns() can be unaffected by
> NTP sync on 32-bit too.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   arch/x86/kvm/x86.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


