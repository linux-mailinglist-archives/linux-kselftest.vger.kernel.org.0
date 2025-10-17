Return-Path: <linux-kselftest+bounces-43395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6753BEAD07
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 18:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEEA37C37B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 16:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3B52C08D7;
	Fri, 17 Oct 2025 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="RE5ZjTxH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06F82C08DC
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718047; cv=none; b=dxEs+vNyGe9d54blnhud8xwCClC7vZU7c6Ha0LTcMgo45kNbuJpT3HZ+5jSRO6MWeE9phn6NH3V1BeKWAUvE4DOTJ2cvzOsr9KsD8fqg47biohvWK+G+WBc05OO6zeHxgxbVNuJDGNWsR1yFPWA3KH+M3rX7mJg680677DG4Y04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718047; c=relaxed/simple;
	bh=jPnIBNXjWFgFyMR6aOnBqBJY3wZ36RIzhFnOSbYyl8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDw7PezZG/8lVwoiJ/9oI3jZwL2EI28CKeRF9eW73axkx0UDxORF6beyUYsJelkTrXLDOWUwFQ5a647BJvDBG7PymYMLg/pBTJ9LkjUJ+9SmQ9ZmESyg8nGNz/TkXgBiMcuLw7yOO8BS2IJqVRnz+r5IRbSTn2qncEjBr7la+WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=RE5ZjTxH; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-430a5fe0c5cso16538175ab.0
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 09:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760718045; x=1761322845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uHcp/aWTKuBzfOH84Xc834di52qmuKsQVMyFNNeyUD0=;
        b=RE5ZjTxHWpSyS/gTIOEr2E0b7TshmBK12gGzmFK0QIG0wYfT0dODRDAFZUnQ35Qase
         KmfBGSzd98vsvsQxzaG7aD+k14XvjaL6GtvjUXuWULC257CxoaF6wElyIq9OqCz+e0ey
         HiyCHuysunF6Ez722nAYzZjEm0Xa/y424Sudb85AEegBkdICvAlSt3noNPUgH/j+rvYe
         33TfzSB0TjvrsfLvViSFk3OaVMksWcGQuMe3nKaGdk8a2dCHdeVEWJqQRtdIgcDB1X2z
         i7V1mQ+9/94No048cacCi2C9BJEjCI/p5y7vV98ESjikw/L/l1B8zFrjNNP/+omSPnas
         fBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760718045; x=1761322845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHcp/aWTKuBzfOH84Xc834di52qmuKsQVMyFNNeyUD0=;
        b=UlpqcXHySiTVBxa9GWkJ5XdqPcqRpHy9LSN6te+1Gr+OURnyJ1PfoXob6t4y6/iC6E
         3HPOYN2KTGoqMTRrpblCI3diHj95/ceKXQ+qxy7KZWtm5qAmaRfblKX27ks/h7Z9M2cY
         xsFyPfq9XYla2AFnL1oyHXFkbMP67XUFZP+SguwBmAaymXTSfbcUEt/BShVqAgVA/Eze
         cz9DXuDc2rWc9IEWYyDuQPHOxl8eFk3lOelY2NWxgi70ZWdMNwSVM+1eHv3S+DXdyJm0
         n4YdXBV4UQusoiEBsjenqrmfrXlmNPETB9zWo9czGfTaxMa99Ii1AAF35UZ66//oco5V
         UDkw==
X-Forwarded-Encrypted: i=1; AJvYcCVV2/XM8JEGmta9RqFSHRuCykO5cnIMCnVQ1bn8z2gQgOCXXOeCgsUYOEqu9gdszEeW68dBgjjFfwChJ4IriGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaZmn9YCOLqwTwsqcFEuAYo8p0I/4Saw6d7OhfRAqFAPKfE2iu
	EXbt0V6NmpAeCaQUshLFWZ3dtKyZb/ATgBY0cunBswQr5BLHEMMXq5EmCDwSBfJMFN4=
X-Gm-Gg: ASbGncu/min8TF0k677cQ34C3AJPt/Eyyg+juYDMHOXRLUq9nV7kU+tQUJEocu0Z1Uu
	Mw7mOtPrG7ZhxawePmgTOfzV9N4jo1vwrCRxfJcPuWvwKPIGv8Ifq/02rJucVr5Zt5bf/fcfk9X
	bmRhDddYbW4eWD3iQcN8lihHFZMhPRLCUJvm6YjaNz5c3E7HJpXWY/C6D6TNA8tUlwMjQeczn+4
	cTrMX59m15lamt7ecfGJ5oc4gCZN0lkliuk7X1Ir0N4yIZDIIhVrQwoXJU44aLpCPfkeGIF7g6u
	wiSr7Vj2+3yxlyxxerZ33G+CQ9lsVDx56KPiiHj2deTBs9JKTFCb7O+Bb8coF2HW+mrGtMk24h+
	E6E1HwDB4fAzuvDilxRrQ2Qy9vwTk6B0ua4rrx8Hib8c1R+6FGzFcsnk0vCFlTijQWJuM0jz0OA
	8K6A==
X-Google-Smtp-Source: AGHT+IGb7WVIYEXYDolygsCFth05K0mPGRPpQvAMXm74hPFwBGeILraMt8hiRJ5jXXj3KN04uw/DDg==
X-Received: by 2002:a05:6e02:1905:b0:42f:9e54:76d0 with SMTP id e9e14a558f8ab-430c52ac0d8mr55233645ab.23.1760718044856;
        Fri, 17 Oct 2025 09:20:44 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d07a874csm804025ab.19.2025.10.17.09.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:20:44 -0700 (PDT)
Date: Fri, 17 Oct 2025 11:20:43 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Atish Patra <atish.patra@linux.dev>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 4/4] KVM: riscv: selftests: Add SBI MPXY extension to
 get-reg-list
Message-ID: <20251017-7e149a197ad3d9d99bd45a4b@orel>
References: <20251017155925.361560-1-apatel@ventanamicro.com>
 <20251017155925.361560-5-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017155925.361560-5-apatel@ventanamicro.com>

On Fri, Oct 17, 2025 at 09:29:25PM +0530, Anup Patel wrote:
> The KVM RISC-V allows SBI MPXY extensions for Guest/VM so add
> it to the get-reg-list test.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> index 705ab3d7778b..cb54a56990a0 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -133,6 +133,7 @@ bool filter_reg(__u64 reg)
>  	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_SUSP:
>  	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_STA:
>  	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_FWFT:
> +	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_MPXY:
>  	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_EXPERIMENTAL:
>  	case KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_VENDOR:
>  		return true;
> @@ -639,6 +640,7 @@ static const char *sbi_ext_single_id_to_str(__u64 reg_off)
>  		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_SUSP),
>  		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_STA),
>  		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_FWFT),
> +		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_MPXY),
>  		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_EXPERIMENTAL),
>  		KVM_SBI_EXT_ARR(KVM_RISCV_SBI_EXT_VENDOR),
>  	};
> @@ -1142,6 +1144,7 @@ KVM_SBI_EXT_SUBLIST_CONFIG(sta, STA);
>  KVM_SBI_EXT_SIMPLE_CONFIG(pmu, PMU);
>  KVM_SBI_EXT_SIMPLE_CONFIG(dbcn, DBCN);
>  KVM_SBI_EXT_SIMPLE_CONFIG(susp, SUSP);
> +KVM_SBI_EXT_SIMPLE_CONFIG(mpxy, MPXY);
>  KVM_SBI_EXT_SUBLIST_CONFIG(fwft, FWFT);
>  
>  KVM_ISA_EXT_SUBLIST_CONFIG(aia, AIA);
> @@ -1222,6 +1225,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
>  	&config_sbi_pmu,
>  	&config_sbi_dbcn,
>  	&config_sbi_susp,
> +	&config_sbi_mpxy,
>  	&config_sbi_fwft,
>  	&config_aia,
>  	&config_fp_f,
> -- 
> 2.43.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

