Return-Path: <linux-kselftest+bounces-3001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A0D82DCBA
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 16:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CFAA282EEE
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 15:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFE21799C;
	Mon, 15 Jan 2024 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="FieKyD5c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E521217C6A
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Jan 2024 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2d348d213dso213211066b.0
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jan 2024 07:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705334168; x=1705938968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N+FWP52nAagysrVb6ATyYzWCbthUEld2opRqU4Opd68=;
        b=FieKyD5czlyszJP2qj/nZGfDE2RfUTNOnU1DXTBCQtJJCbGgqan+z1Z7vb1jiVW+Ss
         71rCGiS1lYVGyfAIRW629KRi9RntBgiS0uFbdLC3VPO3lWCxnAKoBSyTQeE2kpdNaqU/
         UUWEL8/xfJxDIo41i4rbwvJtta+wq7Yz1ZIbZEiwUWLJTwHbg4JS1dVGuzFZblX6som5
         V0shaUsvpmFcC7VJwrt7irYEwmPK976V32ED+LcxYhR8J0ZBMmViC6dlaGV3fJBzzetn
         jsuooNfZ4eqLaI9hM/jeLTh2P1FYboI/CprxdnH9jsKrVh2A21pORWlOGXTTxrKYJg1C
         HjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705334168; x=1705938968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+FWP52nAagysrVb6ATyYzWCbthUEld2opRqU4Opd68=;
        b=VcDjz/MSVv7hCxa1zT2Lyrv8ML+VjSHsJiqtYe6To3XDof+5ctjfYDJVl4rF/a4OOe
         RhyDBRjfcF6n5SKe4YmIuRUYYcM18mfjymHJ86f5VHiRqGGLWHQ/ncswsZqnrFJ8LTtr
         OnRtn3neamDaFDscfrBhj7+qTCOMIWeNErjruBd85IoMf2Gq8J/rl+wF5gyf13G1DUeG
         OtyMAqcgbGgj5P0o2MEXBClYXkCKZewUc0BZb/vX1GDqg5WpiN57FUL0bp/65FZBqOol
         2iq6Wkv4TRGwjjM3CDLoKNf25VqhnmwxzzkfMZ1kyFwtrS4gOrImY/z98ChYLJKtbUmB
         giGA==
X-Gm-Message-State: AOJu0Yx6J8My5pw2g3gEyEmVFGrXCVyB3FYgWZwiqG0GOgQln/TEP2UV
	Ff0lr48++2lECEFmaOR8QyFxoS02CiuMtg==
X-Google-Smtp-Source: AGHT+IGVzxObySjbrHXjQqBB+OXIeisu2vuqG55GXhVs4Z4pPd7aisPFZga9dsKJCg64OYSUiCnjYg==
X-Received: by 2002:a17:907:707:b0:a28:98f4:2799 with SMTP id xb7-20020a170907070700b00a2898f42799mr3424248ejb.48.1705334168313;
        Mon, 15 Jan 2024 07:56:08 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id xo16-20020a170907bb9000b00a26aa5c5a60sm5491885ejc.19.2024.01.15.07.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 07:56:08 -0800 (PST)
Date: Mon, 15 Jan 2024 16:56:06 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Atish Patra <atishp@atishpatra.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, 
	devicetree@vger.kernel.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 10/15] RISC-V: KVM: Allow Zihintntl extension for Guest/VM
Message-ID: <20240115-86ac7741a7b0dcecef1a01bf@orel>
References: <20231128145357.413321-1-apatel@ventanamicro.com>
 <20231128145357.413321-11-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128145357.413321-11-apatel@ventanamicro.com>

On Tue, Nov 28, 2023 at 08:23:52PM +0530, Anup Patel wrote:
> We extend the KVM ISA extension ONE_REG interface to allow KVM
> user space to detect and enable Zihintntl extension for Guest/VM.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/uapi/asm/kvm.h | 1 +
>  arch/riscv/kvm/vcpu_onereg.c      | 2 ++
>  2 files changed, 3 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

