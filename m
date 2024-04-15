Return-Path: <linux-kselftest+bounces-7963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F858A51C7
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 15:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99E71F259B3
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 13:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD4183A0D;
	Mon, 15 Apr 2024 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LqkYce8m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1E882D82
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188168; cv=none; b=TDOGsrBJKuPa1f134/XKtN3AIG0f6Qtk3d4oeQXZzePoOTLoLghGpXlJ2gAQhscw+uxklcwDVkU2Gq46oywLGO6dtAC5ccGyNYAthK1SLtdpPa+XexdIOh3lzydxohcWfC6Tj3BLZiSLkQBdxQhmI3VWW8XHPD9MCjzVcIGphus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188168; c=relaxed/simple;
	bh=ozqYEnii4rkQXzes4moBBaVstK2FV6J0b7MHvEFXy4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4RweSO5JpRPn6V5njBCsdCTNM5CRcP3IZV7uz+GngDP3JyAts05bfHuZ54JP6VmHQAWYL/sb/Um+wiNR/8cFr9s/0tQC2+G0ZsHhayW0PJHl5VI/ZW1TIRSLF/bcZeUZd5b1w1WbvRjIpbDogE37OWKjJUVJxq8DZoNT9uugS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=LqkYce8m; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e346224bdso2509324a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 06:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713188164; x=1713792964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ik1rd9kTZT4cDzsiZg8RCbbgRc5INy51wGM0TkC03wk=;
        b=LqkYce8mkVBwP4qttJVmz1LpF02j5bdksmAHEJcWht17n3UK6vZulON/Wiy47fo7Gu
         DQryIh7JnicjImh3GmcyTFb3ptn2tMO1bTlxwlzcSVdToFzw8cx8sCHOP1RNz1sgEV0Y
         w++HJbRiLVFqHGkcGBZGV6F2IYGnUQ+zLdGWOUd/NQJpeadsRsoYlRW2XKdT+34hwsKb
         v9W09SBW16lDE/GPV94UeS+0tyq34AcYnLxFtkYEglAxvmtaZO3CW3ze5nfaAzeIgYrg
         KOhuozOh+gOVzTzj4GV3NFMPuow2x5kxyfcbLR7kaeWRc6QxokzVjrj+PQtCd0NpZUAb
         Q7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713188164; x=1713792964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ik1rd9kTZT4cDzsiZg8RCbbgRc5INy51wGM0TkC03wk=;
        b=qbA3Q/GMu+YJLKDW7/vpphRErQsFiGfDUjLTuNljDBvm0g4ZwbJH8WraR16/inKEEr
         RsUF9zJzcIEw+Ve6jqqxZS9iQhYdHp9i6PiWKUXLuRiP+YKRphlyiVEuFsi1ozBvhcL+
         yKK18mdPuIHg2QH2YhWDg+UFS4o7frmt2Z4/3h7YV78gvVo4Pecn7xoS9WopW4qgJItx
         JSUZtOeiF6I0WYl17GhJEinpFjnq3d7hgRAtnPAADQA6lyt0qb5VAGB1IsKopRqgRtfs
         qAXcxZ/ZTSf5IhHI50jc74ndjRBYKgdJMwpv96XSQH0t4nlNZwMjuKcXHknC1riu5yPX
         uLkg==
X-Forwarded-Encrypted: i=1; AJvYcCUtEWlGBsruL47PdBSSQMP7hXt30gwOCOHO/LMJDR9it0WNQUZ0dXMhBfsD99D7uj4zvCfPJAYyum/ZjDS9LzC0lcoGGYsctqdS9lyrCCG1
X-Gm-Message-State: AOJu0Yy4C8TStJMr7DOo7wubYNZ2jso2fBvV3U+xuW+Om63stEaGshRM
	2QTvTwSGSPp+HWU9FmeNP+5e/2118qk0lz0P/DKIg18OJT95KduEp+LVA5ZjZ4AqNS4sXNizo7x
	m
X-Google-Smtp-Source: AGHT+IEBkh8/VlmJkVNcbXTlR7xWxfl1Gb/HA9GDVYEQgXUvmj0tPoU+uxzOFA/Tf9vaZXoxYUtgyw==
X-Received: by 2002:a50:8a92:0:b0:56c:3dfb:a1f5 with SMTP id j18-20020a508a92000000b0056c3dfba1f5mr7405106edj.22.1713188163639;
        Mon, 15 Apr 2024 06:36:03 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id fd23-20020a056402389700b0057021b811eesm1735813edb.67.2024.04.15.06.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 06:36:03 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:36:02 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Alexey Makhalov <alexey.amakhalov@broadcom.com>, 
	Atish Patra <atishp@atishpatra.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, Will Deacon <will@kernel.org>, 
	x86@kernel.org
Subject: Re: [PATCH v6 23/24] KVM: riscv: selftests: Add a test for counter
 overflow
Message-ID: <20240415-418eb2e18cfeb613d252fff0@orel>
References: <20240411000752.955910-1-atishp@rivosinc.com>
 <20240411000752.955910-24-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411000752.955910-24-atishp@rivosinc.com>

On Wed, Apr 10, 2024 at 05:07:51PM -0700, Atish Patra wrote:
> Add a test for verifying overflow interrupt. Currently, it relies on
> overflow support on cycle/instret events. This test works for cycle/
> instret events which support sampling via hpmcounters on the platform.
> There are no ISA extensions to detect if a platform supports that. Thus,
> this test will fail on platform with virtualization but doesn't
> support overflow on these two events.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  .../selftests/kvm/riscv/sbi_pmu_test.c        | 113 ++++++++++++++++++
>  1 file changed, 113 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

