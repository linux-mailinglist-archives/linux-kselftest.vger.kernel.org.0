Return-Path: <linux-kselftest+bounces-34710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34718AD56D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 15:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D652C3A1BDE
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 13:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874EA287519;
	Wed, 11 Jun 2025 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1kSA2As"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A927817A58F
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749648077; cv=none; b=mVVq2RuvZ4dtQ0CIBdE1Be13s0zXQfp0RPoAvGJrRoaj8rWylkgAvAksmbdjrm/2RDkJ7yP3+IV4ssg3S45R6+zW+5sIlIhsqE3rmRv04fA1SL3KE55c0CRLh9cNdARAfGMd4aQ1V7K87djJpVzYpOnwnBn8KAT9ywoFar+3ADY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749648077; c=relaxed/simple;
	bh=C4hxsxe0fLBrBotaEoFZDYCLmEECNhldsO7lXFI9foc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sf6+Un6gJv+eUNhCz01EHyPd2cOW7ueFBGfzNEk1j5Oc++IhrCOxTwCcsASK9WYsGFgwsxN57kg0qOIiWAoXGLY0/q8TDSdvSRbOmRRS2Kv1kkL0q892ru52WlhfPwQq7E0shgRsRtNCXrArUzRkAaFniNAS8hmWXmUZwf8bYN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P1kSA2As; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749648074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BgaQSbJjCXfhBaWKuPSsh/e0eXuCE8ryvRzwpdMmhNk=;
	b=P1kSA2AsoeCB+yyswsur1yDfsHfxbvldjSIokwSataMx5Y4QYrT++wrOUjkcV1/5lh8ZPX
	ZaVoGtYwiTQP4XybgOGckfvb9tskIXFDmT2ThowSw6/ZO8njsKxrL8KaMS2zBxJSjP6nzP
	iZP6sSbahOxdUIdfcX0por2K1zYMA94=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-SBMimf8NPJCItOw-ZFYIIQ-1; Wed, 11 Jun 2025 09:21:12 -0400
X-MC-Unique: SBMimf8NPJCItOw-ZFYIIQ-1
X-Mimecast-MFC-AGG-ID: SBMimf8NPJCItOw-ZFYIIQ_1749648072
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4a43ae0dcf7so9889781cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 06:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749648072; x=1750252872;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BgaQSbJjCXfhBaWKuPSsh/e0eXuCE8ryvRzwpdMmhNk=;
        b=u+zMPtZncClavKixi+M573OargFppHBQKkMETpOimbahRqiQwg1xOPQ3fO5dvOb7y0
         Kqt2166oJOwObopO6R0CEuH9uTsArx5xUAGLGJAq5OkIdvHoHVyH4U2VNput9g6tyqAb
         bZJPbS1+xNLuYt77yksUVtIehoL72IhHKZ02ReezdsSk61OkRK5sS8s+ln3QmGf/D9mJ
         R6ZydA8pEMb/sluBW+1PWjOKuwaOV9+hKQ5SIrVnXDvp9/KIlYvwRiE/k8oS5xYdupuv
         iKWtYfcKJretf/LJpJuGxRttK4mAhrC6JYPlmPsqKelEFluhcuHY2MMeyzNemYFXoBP8
         wv1A==
X-Forwarded-Encrypted: i=1; AJvYcCUhf09VvsJXhXujb0XkTSqYtBvn3zNlTK7tv/YDS1hW1lyJz8ElnHkCONqun+JGueUGeM1rpOJ6lgjF6IFpDiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuzne2w8XHaRX95RpKRu6MAX+Wtw2SHrTtWVlUsCmY9mbq9vvo
	E6tYL5zhXbJti4LIw+9FSdG0c2O4w2fB7uMPWV6evnVjL995wk3XeH3QXSAmqAAhjwvdLsyZI0n
	GVQxadZ9Pm8/XP2uhhstlesv60BeYYpxBfqnl4BJYC2ehAFoC2dPw+o1Ig5WV7Vs3DQkE8A==
X-Gm-Gg: ASbGncuFXAvsZoTi37YOvJO0e09RFR9oDUaVWLkZ7wK9xWpslyHUMneLx4N1YOxz6V6
	prgANP/WM8fgEulodVXsEgPAIsdwgx8JoppCvNQsbDjaihN0mD7Q3QrKx+wshVvbuCwd5G7HVJn
	/hMH4fGH/kR+Qx1ry3DtaDuxPyEaHoDE/tVQrXzL5y0wL4WQs449UHa42/TLqQJPVIuI/mZE2ml
	VItl6ts9jKZ1pCFCyWRlbYzyPkMJDkRCCayKOWvEg3SfpmY203UDMjN+z6pPdihAp3T3TbKu4n5
	yZnM8X020ObllNDjOr1VvlZZ519IEpDl3i+rzZv/E94V
X-Received: by 2002:a05:622a:5c17:b0:4a6:c5ee:6ced with SMTP id d75a77b69052e-4a713b8ba7dmr56471081cf.4.1749648068359;
        Wed, 11 Jun 2025 06:21:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1ArCnkm2Czjve19sYRLRVRmIA4chf1R1aoKdRXRTJmJlpegiSPkj7PSA7rA024CD57QwdaQ==
X-Received: by 2002:a05:622a:5c17:b0:4a6:c5ee:6ced with SMTP id d75a77b69052e-4a713b8ba7dmr56464691cf.4.1749648059408;
        Wed, 11 Jun 2025 06:20:59 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a61116c02asm86858761cf.32.2025.06.11.06.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 06:20:59 -0700 (PDT)
Message-ID: <a020ab91-2da7-4c47-b88e-4639b8b0bd37@redhat.com>
Date: Wed, 11 Jun 2025 15:20:57 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Check for YAMA ptrace_scope configuraiton
 before modifying it
To: Mark Brown <broonie@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250610-selftest-mm-enable-yama-v1-1-0097b6713116@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250610-selftest-mm-enable-yama-v1-1-0097b6713116@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.06.25 16:07, Mark Brown wrote:
> When running the memfd_secret test run_vmtests.sh unconditionally tries
> to confgiure the YAMA LSM's ptrace_scope configuration, leading to an error
> if YAMA is not in the running kernel:
> 
> # ./run_vmtests.sh: line 432: /proc/sys/kernel/yama/ptrace_scope: No such file or directory
> # # ----------------------
> # # running ./memfd_secret
> # # ----------------------
> 
> Check that this file is present before trying to write to it.
> 
> The indentation here is a bit odd, and it doesn't seem great that we
> configure but don't restore ptrace_scope.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


