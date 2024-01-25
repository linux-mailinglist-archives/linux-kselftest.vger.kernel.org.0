Return-Path: <linux-kselftest+bounces-3570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0656683C607
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 16:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ABC81F21C7D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 15:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AB86E2DE;
	Thu, 25 Jan 2024 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndtQg5nI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA9163417;
	Thu, 25 Jan 2024 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195041; cv=none; b=TC7MXwlqwqgouKnFDuqqmADt0SHg129ABJ7MT92Qe4Wahkai396vxMLwK/ZESoA4wV0agvS0NA7gzgpu/yUxdmtA1kd/4wZQDXGVEslnFvlvgz37U47W9sN2BWwDqmp4gxKnqNyzUxzMaKyW13FbV1T0nfUiz/XEU8FLHNS85Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195041; c=relaxed/simple;
	bh=4VYWv2Sx+Bj+pNWhyYB4bNelSQ6tBkzliNyt2O6LlME=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=n4kmbsW53e7M9ZjRp68R+1aXcVHJZknyJY+UKNbsmIC2pApXVIcOpQYLVstA/k13i/AZMTQvzNy6sg9k4G6tRQqEEWibRYKIjfDjmWmzlKxPNPhR+qhyw6z25ge880y42j2WArcFKwPPlAtzfJbzJE4TtJtNosCnNmzdYPegAwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndtQg5nI; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cf1288097aso33942081fa.0;
        Thu, 25 Jan 2024 07:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706195036; x=1706799836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+JpqUewR5ly7xx/0WdrZNITm60TbG3dfiLr/Mb15eVA=;
        b=ndtQg5nIlVSxts8+ALmCMos72Y1hXAfdCxxxOYt0Nqoc5vHo4YUwQBI9dshKFJUe/0
         MIIAP636MqnppV4kjbJjyspU/OPitslZKPpwaO0nhSxWB5u5QETMMVrJSM5HjOqbdT2b
         xoj5XzNbtDthcovsczzr/kPjseUJLAoM5arzIpEVrT/vdF6mEsJEpj55kvZefP4mtXnZ
         A14+XUQ0hvPMIDK3eqDtrxUj2rpSaq3XciUP7ZvjLwR8gc91pGGsBHv0/Dad86H3dtl3
         X+j515SC9s+qCcLi3QqhPKq15ca5FI/bXZT18pCtrzvu94C0rxpfYCOqfr+oY+vToYWm
         gYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706195036; x=1706799836;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JpqUewR5ly7xx/0WdrZNITm60TbG3dfiLr/Mb15eVA=;
        b=jJAn0pqXHHnqac0/RZgnbuJxmFf4aZgIkfN+bKmUG+62qvVm28NXLQfwP37QMQLwCe
         youNxsgk5OgH9dKFHIQXsyW/xEL15m5ck1VHRfN2vL9zVNJSlQB6KLtFHSifTRQfD7DC
         fNET2KtWjEJRsfgOEkJ4ey5BKA54Eb9EwRlTnNniQRCpdIejNgeH6s3pnhc5ct0Z+JW9
         Lx0OQLsCRaxYZ8Ym4Ubna0dtZ8/5Zo7V28Z9aIMMJFDbP79Ij+2vh3VLyC9Cj28w3gsE
         bfNmSqypzXHkRyctg6Hker/LrImubnxGmsgseoGcerTLTR1XoLtnOidg5ubiuYfafmo8
         fvrQ==
X-Gm-Message-State: AOJu0Ywrww8FHV9yZmAoK0G2Vt39gj5+Ax3PjfQRKu7SUOCoae/jUeL6
	d0pK8Rb1BquEsBMSeCizrz9s8NKRwOZ/64107Sf5J/gzshWg/hPm
X-Google-Smtp-Source: AGHT+IEV9bU/1HezSvqZlnMJ5W09F5EZpnBqlNTyjnRmTSRX2hEV9eVCrpvUUcfa7KLh8a+ZzU7ItA==
X-Received: by 2002:a2e:300d:0:b0:2cc:d4cd:18a3 with SMTP id w13-20020a2e300d000000b002ccd4cd18a3mr714289ljw.89.1706195036120;
        Thu, 25 Jan 2024 07:03:56 -0800 (PST)
Received: from [10.95.150.111] (54-240-197-225.amazon.com. [54.240.197.225])
        by smtp.gmail.com with ESMTPSA id u7-20020a5d6da7000000b00337d735c193sm8119636wrs.49.2024.01.25.07.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 07:03:55 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <2b4d020c-08ba-46ac-b004-cd9cb7256bd9@xen.org>
Date: Thu, 25 Jan 2024 15:03:54 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH v12 00/20] KVM: xen: update shared_info and vcpu_info
 handling
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240115125707.1183-1-paul@xen.org>
Organization: Xen Project
In-Reply-To: <20240115125707.1183-1-paul@xen.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/01/2024 12:56, Paul Durrant wrote:
> From: Paul Durrant <pdurrant@amazon.com>
> 
> This series has one small fix to what was in v11 [1]:
> 
> * KVM: xen: re-initialize shared_info if guest (32/64-bit) mode is set
> 
> The v11 patch failed to set the return code of the ioctl if the mode
> was not actually changed, leading to a spurious failure.
> 
> This version of the series also contains a new bug-fix to the pfncache
> code from David Woodhouse.
> 
> [1] https://lore.kernel.org/kvm/20231219161109.1318-1-paul@xen.org/
> 

Ping?


