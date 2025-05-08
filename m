Return-Path: <linux-kselftest+bounces-32680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADC2AB046F
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 22:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE691BA64AA
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 20:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90F528BA91;
	Thu,  8 May 2025 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xZWoJtMG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D146628B4EE
	for <linux-kselftest@vger.kernel.org>; Thu,  8 May 2025 20:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746735495; cv=none; b=Vt2zq+/2ujHjpSg4SR1M+ntBrSzMJAybf9+dFTfbcpvOXGuyDH+7eBYXJIELfjYw5MST358dY6ZkQVwF6poKsjMvpAXvw7RkqJ/+mq9Kb5n1XnQG/CLgzNMIdiAxtsgWTGsekpCSA7yBguQW0urmPawPAPAeukFP8qqYxyr8nDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746735495; c=relaxed/simple;
	bh=UojBaLSnI5K18WhmwXexF1bLjMn9YNs1CQZUt/Yl9eY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jn/NkUV31/6ofmJ6BwiWsd+fvBDy8SKbx3ozKoCb/GFUm7thXIR18QYFheXtjIaVLN+jw90ea70DhcH6envTCmNNI2jB6Gi3YPkKMOwUK4VbGgAfsrHmL3ImZ5gqmQy9qWtDhAUWaFfLYOkt4BZxU5qOJur7U6KZ2ZQmOvs/nAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xZWoJtMG; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <eab937fc-6d9f-46b4-9c45-e8defa31f038@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746735490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qCMU+yBPYWIBqtx4wjHgX8QEBpwX3EBt77ds4u9eyfA=;
	b=xZWoJtMGJ++IS2qmyND2yhJRoBrczbjEo2hlwL/TGR0NLs3NA+1wjTsb6ZNV39r57Kep0f
	WK/pqk/zOpQNeIUS/pr0Q3jfn53kCi2Xq8zdnPb2Sf+yQK3L9/klTRciIsSpxH8Mb0yP6n
	92cBRHwE1HIrrJTuMlEikZ6N96AmwwQ=
Date: Thu, 8 May 2025 13:18:05 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 02/14] riscv: sbi: remove useless parenthesis
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
 Andrew Jones <ajones@ventanamicro.com>, Deepak Gupta <debug@rivosinc.com>
References: <20250424173204.1948385-1-cleger@rivosinc.com>
 <20250424173204.1948385-3-cleger@rivosinc.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20250424173204.1948385-3-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/24/25 10:31 AM, ClÃ©ment LÃ©ger wrote:
> A few parenthesis in check for SBI version/extension were useless,
> remove them.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>   arch/riscv/kernel/sbi.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 1989b8cade1b..1d44c35305a9 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -609,7 +609,7 @@ void __init sbi_init(void)
>   		} else {
>   			__sbi_rfence	= __sbi_rfence_v01;
>   		}
> -		if ((sbi_spec_version >= sbi_mk_version(0, 3)) &&
> +		if (sbi_spec_version >= sbi_mk_version(0, 3) &&
>   		    sbi_probe_extension(SBI_EXT_SRST)) {
>   			pr_info("SBI SRST extension detected\n");
>   			pm_power_off = sbi_srst_power_off;
> @@ -617,8 +617,8 @@ void __init sbi_init(void)
>   			sbi_srst_reboot_nb.priority = 192;
>   			register_restart_handler(&sbi_srst_reboot_nb);
>   		}
> -		if ((sbi_spec_version >= sbi_mk_version(2, 0)) &&
> -		    (sbi_probe_extension(SBI_EXT_DBCN) > 0)) {
> +		if (sbi_spec_version >= sbi_mk_version(2, 0) &&
> +		    sbi_probe_extension(SBI_EXT_DBCN) > 0) {
>   			pr_info("SBI DBCN extension detected\n");
>   			sbi_debug_console_available = true;
>   		}

Reviewed-by: Atish Patra <atishp@rivosinc.com>

