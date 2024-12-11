Return-Path: <linux-kselftest+bounces-23231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AC59EDB04
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 00:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36AB1688EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 23:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940131F238B;
	Wed, 11 Dec 2024 23:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmeWeDr6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38A11EC4FF;
	Wed, 11 Dec 2024 23:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733958756; cv=none; b=HWaU49HJK2mC0aBc7alwGmkStbphVmqeqq03m1V2Xz0u4N7NrTJBVxSlyHBU9uoW0oBpv16EcPIUr2QYqZq5/9nnxOHGZQTJsp0RL87tgVpAk59E4FmemTCj59DVfnn0nuoYCljfVSHcYLCoUKWkCSuArhhsRD79vor3wi3MXD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733958756; c=relaxed/simple;
	bh=EAhbE5FnzPrjYNKQthkW7n6a3bm7zIYVzKfWffn+RC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBqS5QF8yu7ON3JSG8l8njwCa5lVFNP31vrmtISRiTWAGLChHMTjz+hzJfK0aIhF0XpIwcHgI3ZoJz3dt1Bm2Ykh8pJZL0oYwc7bSaggD1n48Ha842htWFvw2KEo/Wc0tGUm6X0T5H2NWUDVUZk8SPUgrRxarShkrAzTEb6Sw9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmeWeDr6; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385ed7f6605so3298342f8f.3;
        Wed, 11 Dec 2024 15:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733958753; x=1734563553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H0G/tFvxt07BfyGaMcXOJ1EEDxLzNA9gUV0WXr7dWt8=;
        b=bmeWeDr6M+tDpHxrzDca1w4nZnNStkiMQvdGA1CMqcWEXszGCJoN068GyFWL50q7Bc
         vF1VEX1gx4aUZp/UyAaNExNtNKkrzp/ggBzv71AaDrPOr2i4r+fARkDC9a842N2uaIyK
         pMi6p+TqXYhjhA55Fn+ZVkGPUaTccugu1on7+vQNGVbQxdkO8bqFTD8uTIAUylNjldRh
         YBvCqzVU/Eb+1791v4/mTTThzNJ6kIlw3UUJMfAbcaFWnz68PMyw3fKwjHjKqtkIFbxH
         ZrytkbA96Rk9JngVyh4KcT3YKWVnnQf/MMvANmfjdEgx059BjXDWz+XMmu73nDde1UHt
         VCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733958753; x=1734563553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0G/tFvxt07BfyGaMcXOJ1EEDxLzNA9gUV0WXr7dWt8=;
        b=DEfbvZPggqEJx/CPuGYjIV7tjHDzQgsY8oywLgJxoDzTjm+8X4MLCiX1n7fb+qHBbv
         KX+FhJ8RkQtkiJhjPOuCWaUt0H7vGa/k079gv+Pp92MEaWXqgPLrL+fgo00++1uRXlg6
         ltPM2Cnp2lgu7IKs1CTRXRpxu1qvWV6hpJLkk6VnPf5acju2801fvDg+p9fUKDq0bEyk
         CWZ0PGLlY1PYuPOyJ82CblgC+RAJvAu55RW9rwFEAKmORN3t4hvrYp9WnjPGJ3LA3wlI
         2zitg/Qb/oPZuO1N/Qi8XFHIXcFycD17Tz3mTsgH8otnkxJkp7TsNsjL08EKa52bAW/X
         Ui/w==
X-Forwarded-Encrypted: i=1; AJvYcCUJ4FbzneGiG2Y6C841Y9sXD1tL+UzmhpP4mJtCKDqpR56qcUpFNBEdvu51M66Mr/cSRFABCs4L+dtTpFCEl/vd@vger.kernel.org, AJvYcCV5SvG/akYCNRKus+7iIihafVbtoXjYgVAyAiT2spmKNchHz4aVRaExfFORNCxVDqmDOfZQO2vraxz9pvc5@vger.kernel.org, AJvYcCX/VfdYgFIYXu5bVn1TLRwv4In92/4Cy57YUOKbPLK+Jugg8a2TZH1rPwuvCwYFQHmAXSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ZEzGb4CuJs1G/rn3afbHVjEZ8GRVBW8nv6nuU2Bjb43xEQqy
	E8KrTW/hoTmPt1NIp/MWNrCqBlxitrmwXxSPxW/Hp2M6BNGpqVkMQPj/Qg==
X-Gm-Gg: ASbGncugv6L/YoiwTc5ZCiEz/ihBJaognPF1/D6LX6WeSQiS12/Un6hCt4LilnznsWN
	XdMGGqTGaQb/6Yj8WZ3D+rMuBnW7l/xEqPrAaS/Ajvw+jJkZ2Mup58O59MoccDxpn9lOmlebxXi
	1hqo/pBqtJ2Pp2sV/ygxHHhskGr6DtcLMfHny2Qdfl0KrOMgb4p/WIVUqVgwIsoguV/4Tljaf9D
	ZDxIPRPV4491+WKhToL48nvxjXpWIZQnWmMX7Pr2fKwKvJKg/0tbZnb7nCuYTaY1fns+xTKVRNA
	JxdVNRmotmvqx828Xjb0zxU=
X-Google-Smtp-Source: AGHT+IFDEYUGEXXWANtZGVvGV93et6FVrxvSd5oSyDoZDY/bBfBGHmy3MYjduVrqTIfsaEDluJiOTQ==
X-Received: by 2002:a05:6000:1449:b0:385:f409:b42 with SMTP id ffacd0b85a97d-3864cea44c2mr4278755f8f.53.1733958752995;
        Wed, 11 Dec 2024 15:12:32 -0800 (PST)
Received: from ?IPV6:2a02:8012:e013:0:1ab3:1f25:931:4d97? ([2a02:8012:e013:0:1ab3:1f25:931:4d97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52c0be4sm273633405e9.28.2024.12.11.15.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 15:12:32 -0800 (PST)
Message-ID: <2b75550c-0dc7-4bcc-ac60-9ad4402c17f8@gmail.com>
Date: Wed, 11 Dec 2024 23:12:29 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] KVM: VMX: Handle vectoring error in
 check_emulate_instruction
To: Sean Christopherson <seanjc@google.com>, Ivan Orlov <iorlov@amazon.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com,
 pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, hpa@zytor.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, x86@kernel.org, pdurrant@amazon.co.uk,
 dwmw@amazon.co.uk
References: <20241111102749.82761-1-iorlov@amazon.com>
 <20241111102749.82761-4-iorlov@amazon.com> <Z1nWykQ3e4D5e2C-@google.com>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <Z1nWykQ3e4D5e2C-@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/24 18:15, Sean Christopherson wrote:
> Hmm, this should probably be "pf_mmio", not just "mmio".  E.g. if KVM is emulating
> large swaths of guest code because unrestricted guest is disabled, then can end up
> emulating an MMIO access for "normal" emulation.
> 
> Hmm, actually, what if we go with this?
> 
>    static inline bool kvm_can_emulate_event_vectoring(int emul_type)
>    {
> 	return !(emul_type & EMULTYPE_PF) ||
> 	       (emul_type & EMULTYPE_WRITE_PF_TO_SP);
>    }
> 

Hm, by the way, what is the desired behaviour if EMULTYPE_ALLOW_RETRY_PF 
is set? Is it correct that we return an internal error if it is set 
during vectoring? Or KVM may try to unprotect the page and re-execute?

If so, we may need something like

static inline bool kvm_can_emulate_event_vectoring(int emul_type)
{
	return !(emul_type & EMULTYPE_PF) ||
	       (emul_type & ~(EMULTYPE_PF));
}

So it returns true if EMULTYPE_PF is not set or if it's not the only set 
bit.

-- 
Kind regards,
Ivan Orlov

