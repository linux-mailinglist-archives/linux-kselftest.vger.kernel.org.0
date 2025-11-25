Return-Path: <linux-kselftest+bounces-46422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC85FC84B35
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 12:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69143B10EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 11:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346CC2F39A9;
	Tue, 25 Nov 2025 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+WoOOhe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A184C26C39E
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764069634; cv=none; b=arckcp9WZ5DXabrie4PQYz1ItX6cNmn/lp4GIriCJCoOYkqPfmOvKyK5V3Jr6eHe98GaeTmcMGU1FCXhi4CPucSl5hm9zfCzGsx7IZYZ2fXhesFofw9OMukJ92SAuf7KsVcdtWrSXrrVGPDLdmf+eUbkUKy7m82dLdKhdRf7fK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764069634; c=relaxed/simple;
	bh=a4+h+unp3TP1oyr0yJ3XjFYwuxew3KdwZUR593H/1O8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sv6xNsaL0pRtc/FFZgV2hWD3Hb7eYZ3LJiwVwUpugoV4TKaLX3ozI/mbEfbhWsuDQLH1Fb66Jk9bQT8sjyy43axQTjzyB2qPF7ZVFhwB9hV7Zr+FQxgyKiUr9nmpQcn/hMkAgjzgbG+mvnR8Azaqg8pAOCX4NMANYW8jtBUXW/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+WoOOhe; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7ba49f92362so3121681b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 03:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764069632; x=1764674432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eVhOQpkFhqqTf3BtOV6vobGzp0Wpfer3ElYSjbBrdyo=;
        b=j+WoOOhe0UpTZ/8/sOF3ccO+YV+LpBsOELWZTOEeNIwMYCCPkVUmN6xd47eqM4RPA8
         AsR+eIG2+0fheyMrJkzTKLEGNsGDXPj0xwLyfXIjmfNl2rtRDUH1lxqlL1+SUjMB1T3F
         RorpWQQ9LsHnS3Vu5i3xdITgVzT9AF7lFBBJyGopVwSRTury1sS0jz31suLT6fBmT6/0
         enuYL/j/FrUckry8sTJcLPQOma3+L1BHzOVUGRsI4GpD736UQzABXZiF6vmf8Kq5EnnE
         MLco88n8zLTvecRvttmUb9f232prbTo3aM/NyheIHVYxiPCsp6/gl5Fym+v0p/kaUCV1
         +7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764069632; x=1764674432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eVhOQpkFhqqTf3BtOV6vobGzp0Wpfer3ElYSjbBrdyo=;
        b=KQudf/yVrJn+9EHAlYsbwOBDkGf36J3efNrEV58p8mn57gjirP8oxA+mX4eofye80i
         efKm6jfUjYKME9BiIyJ0VEMPq1dSsV4pJcBFXAYhCJmwp7l6UoGaHS2YmzxmA4pK1MXk
         pnPuf0F5U1Y5bHohFRXpfunSTUK7xZh5mzvPt34ZYo6nX8qJZ3AVFmevgqLBr7BMLFVg
         u46HPxPz54K+z1KHYqNhtgbJeORV4Ya/lPORZU2JqXsauayx6hHg9MlhMy6nHO81RKo6
         JJGG3bLxiwVDqaghN6SVZwmqn4oZ8Py00upyqz2NHdO+gx3lDBSgROhvg/hXvHV839xC
         cQEw==
X-Forwarded-Encrypted: i=1; AJvYcCXX31nkuZhJZu2HsqBnuHLKoxJZdVHQlN2og/GDQ4+PmoJtHLlqrpvpDIoWfAqSsbagfmgs9X0B6YyVrKE5++k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRlbN4myWHSnmsgVlfXzO8sc0JP9AKnucr2PMvI71npp081mck
	hjz5ZpKM7SDdexoWUJMUf90TMRPoYrjid7iCxk5Ebqm3Bj0dY7YKsSx+
X-Gm-Gg: ASbGnct7M7DLQQf+nQs4WqATMCeWAHBVtj1e7n+lRcto69nB5+F2NErL77+9t6pGHPV
	9OHMnerQw4NSkl/+riEUU25XmkG5YB76qVb3UfELMhaOOCbOtkGcAiG8ZezchQ4mLPEWvCoj/Ly
	Q+XFRbgIIv3he+p1d6Mh8IN5CFXR5sOIXlAlO9Xb+MqsmiQuDaIMT8tFdQfqjGHxWa4Yapd15sz
	cdb13zzGiXjFiLp7Ml7SQ7YiJtpY+uFWVu0lUHNVJ7fFrJ1jI4nhpp7LBp8YUci/1EMw7CqfFxh
	P3SeKSIFWVeRYVV+twtqXBCxxwEOaAqyPBRbWCYWHjyED1afnX5DE0LRClagoceCpxZCrEmt0m3
	z6AB5s3d/b2CKnoVBzTfEFtDcU3CM06o7kaCVAquVCsXMOA5SDpIeZgSDjCPIoRDlg3KEgmanbw
	/AOP2a0fWuSFLjt4pRlZojSVIsmcJRpl9AVsKFqPKZMPFteBhZX8IeSytRP3nZcIhhG5WnuQqtq
	J8ZWafEfwrv0xFJ
X-Google-Smtp-Source: AGHT+IHceA3bqsPjmyCa2TPF6zTj0bq2CPgSfhCVMko2nEB7fZ8pj+ZsS/cB9USjHK3Gmjz3R3UxLg==
X-Received: by 2002:a05:6a21:99a5:b0:35f:31bb:5a5d with SMTP id adf61e73a8af0-3614f227b8fmr16367798637.2.1764069631818;
        Tue, 25 Nov 2025 03:20:31 -0800 (PST)
Received: from [172.16.132.48] ([119.161.98.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ecf7d70asm17822575b3a.13.2025.11.25.03.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 03:20:31 -0800 (PST)
Message-ID: <8e1ff2f1-b45e-4b1f-b545-d433e277607f@gmail.com>
Date: Tue, 25 Nov 2025 16:50:23 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/seccomp: fix pointer type mismatch in UPROBE
 test
To: Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, llvm@lists.linux.dev, khalid@kernel.org,
 david.hunter.linux@gmail.com,
 linux-kernel-mentees@lists.linuxfoundation.org,
 Jiri Olsa <olsajiri@gmail.com>, sam@gentoo.org
References: <aP0-k3vlEEWNUtF8@krava>
 <20251026091232.166638-2-nirbhay.lkd@gmail.com>
Content-Language: en-US
From: Nirbhay Sharma <nirbhay.lkd@gmail.com>
In-Reply-To: <20251026091232.166638-2-nirbhay.lkd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/26/25 2:42 PM, Nirbhay Sharma wrote:
> Fix compilation error in UPROBE_setup caused by pointer type mismatch
> in the ternary expression when compiled with -fcf-protection. The
> probed_uprobe function pointer has the __attribute__((nocf_check))
> attribute, which causes the conditional operator to fail when combined
> with the regular probed_uretprobe function pointer:
> 
>    seccomp_bpf.c:5175:74: error: pointer type mismatch in conditional
>    expression [-Wincompatible-pointer-types]
> 
> Cast both function pointers to 'const void *' to match the expected
> parameter type of get_uprobe_offset(), resolving the type mismatch
> while preserving the function selection logic.
> 
> This error appears with compilers that enable Control Flow Integrity
> (CFI) protection via -fcf-protection, such as Clang 19.1.2 (default
> on Fedora).
> 
> Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
> ---
>   tools/testing/selftests/seccomp/seccomp_bpf.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 874f17763536..e13ffe18ef95 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -5172,7 +5172,8 @@ FIXTURE_SETUP(UPROBE)
>   		ASSERT_GE(bit, 0);
>   	}
>   
> -	offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
> +	offset = get_uprobe_offset(variant->uretprobe ?
> +		(const void *)probed_uretprobe : (const void *)probed_uprobe);
>   	ASSERT_GE(offset, 0);
>   
>   	if (variant->uretprobe)

Hi all,

I'm following up on this patch that fixes the pointer type mismatch in
UPROBE_setup when building with -fcf-protection. It resolves the
incompatible-pointer-types error seen with Clang 19.

Please let me know if there are any comments or some changes needed.

Thanks,
Nirbhay Sharma



