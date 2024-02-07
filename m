Return-Path: <linux-kselftest+bounces-4225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2839984C694
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 09:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696EE1F27EEA
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 08:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2988B208BA;
	Wed,  7 Feb 2024 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4MIXknH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1C0208B9;
	Wed,  7 Feb 2024 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707295695; cv=none; b=EM2Pl9ouv2SiVXFghoDBYuh/HEQVdGUJF638T/XHr/Bed0DsnWT9CbKa1L13RQigiwhOxzaOdzQtouL02GO9GzuLEiN3gaHo+cPfV3RFSaauTW6R41vJp7Mi+UUEZiT5nkKxQn+feDwUSoeDzUlo/8vURLmB9jgqFIJ2WU0bD6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707295695; c=relaxed/simple;
	bh=dt8hzbTascoa4l4AGdRm3+8cLSOSYx3O1wN3E7heOjo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DEeDC2of5YVDOSd/k3gvFYP8RVbRQTQYHnKVvI4gfO+5CvBl3yPQ8L5/PBXIguD81bymt06f7Uj8GkXmRt1OZJds8PKX/WCK1puvHiNeLgWVx/wjuVDSqpPNiUPiR4CeOyVjj9GS4bZ/ylWOTBF2/E5Rn8ZfA+PyI5oFW3Muu9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4MIXknH; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a372a3773a5so38959566b.3;
        Wed, 07 Feb 2024 00:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707295692; x=1707900492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=umVkVcQlllxg2jaOuf58sSKKw2cF+x9a/MWyBZj1VFY=;
        b=A4MIXknHscOQhliW3agzNBOnFBEQdMVlzKLDHl5CJDarHTjiOr4Ev1O+THOvnQCZW9
         IEMdJBjNS3mb99cUuBbVPPjSYjenkgLKhFAFoCv1BUd4fZ6MmjeZviScKZNyXETfYhJ9
         x7X7/3oY9LfJTdGkK7E7vZXAr/30k+gBarf7+3x40daQiyGTxy9vgHG4MH4OEI2DVE8b
         qkDVPE/zg3wrSACol8bvOJPKy2gJyvNZb1bvpCfmn7HpkYxYr5/qxnkegv7XnnUJrbai
         Qy98JN4psC5YOYr8smcV+AOeFGY5Gw1yUFZ/C/T97ARmMRw9v0FYeh6hwktiCfp+njDp
         ADeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707295692; x=1707900492;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umVkVcQlllxg2jaOuf58sSKKw2cF+x9a/MWyBZj1VFY=;
        b=PHjp/C3ge0SjxEu5949z5zdXnmTh7AZ43hheN9+WuiejGUmw4q+GW+ZLR+xB5NUK+G
         XNnMQWsrXqFITjBkgXCaad5uk8mH0swSg6JSqHexGJeqjxILFQ+Way4Bv7lh2WgzH1es
         ZWRRfxVJAb/XyQR6YETtFNY/O1HAlmVH1qfwoRf9LB45Na+gfds+SQkIbcx3FRyy0mNn
         yYHVhzgGR1R2WBxv5B392LqGmUvIbGZKx0qw1LKFP83u/JJQ9wsmNRvcoH4ngxWVhv4j
         8LjNszRT3adHtN205UuY0m6c7XXF/LSzssAtjvq77CkOPWlLiu+02MYQbq3AvlRW+MnP
         5iFQ==
X-Gm-Message-State: AOJu0YzyFKL387tEhnEQwXAwEDXiZi1o+BgkrBdyqXQ5aNo7k3kr0/8n
	mPKH/PtInXckpGBH4E4L2VePsyFkVGY3jXrLGtkKaDNNzdcY7BkV
X-Google-Smtp-Source: AGHT+IGpUJ/0ACcl+neX6Ydjjpk6uS/ABCcNl7cu4cSkVrgLltpTwm0NKB4H4lPU0IaRRiBMne+Z3A==
X-Received: by 2002:a17:906:318b:b0:a37:a3bf:4045 with SMTP id 11-20020a170906318b00b00a37a3bf4045mr3233509ejy.35.1707295691492;
        Wed, 07 Feb 2024 00:48:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXeyWDdHdcxKWvxJYpmrL/bXiL5OHWoD6aoK8AJu7zCoIoy8TKnr5vPZ06R+G3/boLJ8wZF0FOn/QS83M7O83S0dNav9M+kuRMWlZlPmOYwDWg56cgNmWb4bxG4dIM06zMQ595V0/xr73ps1KaU/s8n8TNvTJzvGvIaz/LkivzOzhKLsGUEv6Mt2G4AixLLBOvsqsif03jJRolPC7eS7sJ8dSycxaYpr6zUTBu+xKa12AxwPeliH1zLacYzJSQbQhU5nDk8R0BLG7Wdhj1O7TwP28lBKc1sUnhrm/YP4Q5YcA4ful1F5un+EMnOs9DNnG4oI0tN737e1bIgnS3wzpgMBXn3r9JGmXh7fZuyjEhG3IFMDFG4lrHGdpBYcvnj3uboS7qWbFyc6+SrPkoqlHe22T9Nsc7Bh7pbVlBGtnDOgqk275g=
Received: from [192.168.11.39] (54-240-197-227.amazon.com. [54.240.197.227])
        by smtp.gmail.com with ESMTPSA id i26-20020a170906115a00b00a36c7a7b4f7sm503528eja.207.2024.02.07.00.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 00:48:11 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <05edc239-0f9d-43e8-9e59-4cdb6d2bcbed@xen.org>
Date: Wed, 7 Feb 2024 08:48:04 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH v12 03/20] KVM: xen: mark guest pages dirty with the
 pfncache lock held
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240115125707.1183-1-paul@xen.org>
 <20240115125707.1183-4-paul@xen.org> <ZcL2Y1gpRG8C1_8f@google.com>
Organization: Xen Project
In-Reply-To: <ZcL2Y1gpRG8C1_8f@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/02/2024 03:17, Sean Christopherson wrote:
> KVM: x86/xen: for the scope please.  A few commits have "KVM: xen:", but "x86/xen"
> is the overwhelming favorite.

If I have to re-post anyway then I can do that.

