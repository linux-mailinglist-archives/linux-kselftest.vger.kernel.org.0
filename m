Return-Path: <linux-kselftest+bounces-14265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD9893D00D
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 11:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A230B20D82
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 09:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E550176FB4;
	Fri, 26 Jul 2024 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="evI9lmLZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BCD13C8F9
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Jul 2024 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984681; cv=none; b=Eporywbug+beLICrAyRA0zrGupCZjWxzl29xY/pRdG4816a6M+1wwRlV3Yth0bcNL9gy2e0EStXciB/BJIt9KMP4Qzy6X7uPjgs0GjpgCvuE48XV4x0Y/ftVtMt6Qn3Y5BzOMWThXDuiZwCqI6UKpzBLJtrj6GOLNsunHhGFTwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984681; c=relaxed/simple;
	bh=d/QR2vivKnmDTRAhxMFOAcqhKM9oDO/AaQHBmraNENo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BhVR9L02vjHKBIKXmZvA+cEtUl/gNyfyYK/TolavGVUgdhS0prfJyZqmNXaXHuXY583juEeCGZix7f7Qw7a7kv8Bn/SwoS7nLdgTacqrEGINr9aAaAq8Ai0Iw9dEQA25qQ3UaDA+0D3FeodILv1SyNQiVSt1S3s3uDeW+oigKUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=evI9lmLZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-427d8f2611fso2202155e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jul 2024 02:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721984677; x=1722589477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nPNljb5qNYMPMOw83Na142uqAvImzCX5024L1+3yenM=;
        b=evI9lmLZojlQD3uj70kgsH61A5vmPlJhSa3v5N344QRF3Q8pbhJtLGfYcSZmOUz6B4
         TUjhi3MV4Ma6RQj7IOd4eD8PEPytJioWFCosURjqN9ytHxb9ZnvXGWi7avpdEFVEuIc8
         nT//n4qCmUHy/LKuoMtFqZZ/xb1gn3hHkhcV6oS5OpTCX6lCvoMd3VhTU8TQzIKEcp6T
         b0QIbbrBYYskZQZL28jZvxHSsatlCN8nRW6dkzC40E71VYtMeF0wfjdzdHTIn7E4nj9M
         Mi1tJCeSprzgQbWQGELeIp7u+GVmv+URNULEN1+IlSuZsPJ+Byxqc8lKT1AkvPDwEHwD
         wjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721984677; x=1722589477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nPNljb5qNYMPMOw83Na142uqAvImzCX5024L1+3yenM=;
        b=TDuM+wGlTxFQrGRhnMVWJfL4Xj3x4X38dwl2UM08l3q0W1h4n5XlkE67SmB8Srhpdr
         BpyWdlEa/6NyHQx4TBuJIl1JJGc5KNBP/wabjXwBwFjgm/qT3cdkItlDUYv2iG93kwXh
         kvgHbfahXz+ln1S4fTl/HtKrETUmO07XUFeClV4nHwJNHS8RqxDnmNA1QJbzYeiz9NZ6
         yFIjKead+r9BQcSNaj7zfequPBlPIYJv1XH9c6/sxyqELH649Oeht072AISamIISiWFE
         TkdE7KtFvVEvqqE8nHsQqsP/77qfSStyw6KuEA/4TWTIZH7bc9Clgu3uBFK4sKTjZLIX
         pgVg==
X-Forwarded-Encrypted: i=1; AJvYcCWisMAEDp9b4jRsmC7VLuqDOg1/bqqpUdSDmXXTOld9UbsxRgMrmi55S0UlHY6wxufoRcGbe86yODjY0wgEIxzVhSnyOETsV9UW8DyJGClc
X-Gm-Message-State: AOJu0YxNjRkUL9fNr7gVuCjeoJSOb9GpMZi7NoMglRWVKusMjK6m1Sjm
	/+AYpiJqTy+Gq0KAXNbPyFrmQHqNj8WLpXBQShNPQtH9EmHHG/xa//sGUeZNtFs=
X-Google-Smtp-Source: AGHT+IHpM5WQagCaKcwKi7l210VOh4MjHNgi0pLYAhmXUw4nGhc+sr2ehr8mh8kMFL5gq6elvxoPuw==
X-Received: by 2002:a05:600c:3b87:b0:426:5f08:542b with SMTP id 5b1f17b1804b1-428053c9c55mr21919405e9.0.1721984677149;
        Fri, 26 Jul 2024 02:04:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c032bsm4476347f8f.12.2024.07.26.02.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 02:04:36 -0700 (PDT)
Message-ID: <f65d5184-d397-46ce-b8ba-dfe2d3a5ad40@rivosinc.com>
Date: Fri, 26 Jul 2024 11:04:35 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] KVM: riscv: selftests: Fix compile error
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
 kvm@vger.kernel.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com,
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-kselftest@vger.kernel.org
References: <20240726084931.28924-1-yongxuan.wang@sifive.com>
 <20240726084931.28924-5-yongxuan.wang@sifive.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240726084931.28924-5-yongxuan.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/07/2024 10:49, Yong-Xuan Wang wrote:
> Fix compile error introduced by commit d27c34a73514 ("KVM: riscv:
> selftests: Add some Zc* extensions to get-reg-list test"). These
> 4 lines should be end with ";".
> 
> Fixes: d27c34a73514 ("KVM: riscv: selftests: Add some Zc* extensions to get-reg-list test")
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> index f92c2fb23fcd..8e34f7fa44e9 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -961,10 +961,10 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zbkb, ZBKB);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zbkc, ZBKC);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zbkx, ZBKX);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zbs, ZBS);
> -KVM_ISA_EXT_SIMPLE_CONFIG(zca, ZCA),
> -KVM_ISA_EXT_SIMPLE_CONFIG(zcb, ZCB),
> -KVM_ISA_EXT_SIMPLE_CONFIG(zcd, ZCD),
> -KVM_ISA_EXT_SIMPLE_CONFIG(zcf, ZCF),
> +KVM_ISA_EXT_SIMPLE_CONFIG(zca, ZCA);
> +KVM_ISA_EXT_SIMPLE_CONFIG(zcb, ZCB);
> +KVM_ISA_EXT_SIMPLE_CONFIG(zcd, ZCD);
> +KVM_ISA_EXT_SIMPLE_CONFIG(zcf, ZCF);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zcmop, ZCMOP);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zfa, ZFA);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zfh, ZFH);

Arg, my bad. Thanks for fixing that.

Reviewed-by: Clément Léger <cleger@rivosinc.com>

Thanks,

Clément

