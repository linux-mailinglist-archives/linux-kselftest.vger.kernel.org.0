Return-Path: <linux-kselftest+bounces-39257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1941EB2B329
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 23:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF8C189DD1A
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 21:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2736123A58B;
	Mon, 18 Aug 2025 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ant9n3My"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F9D1E868
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 21:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550880; cv=none; b=Wa69w9HVXkozAXOeK796ITfmNnaO6ma9hrETgtBJLzpKITf+Tw3tKZt6/OAQ/jho4xJgFHI5RCRSN5IlTFLt75PizMgCuaU29684KJzYi5r5PcqIF4UUc2PGJp4e4+IH2FUH1Xsg9ODgrUrNJJ6XOrKLq+fap/kpj8i4attxJkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550880; c=relaxed/simple;
	bh=94V2oxncUNCGGpu+Iq+45gM38Y+E66NCd49Ad/nyJWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJ8J1EVKZSLOwA2hFZfeMM6g2PIlZlGfhOd8UKEGO9h0gE9R4+/bhz4qW/peTCuygdaUstIv/kA/IqzNNXJ7mXMuCa0sF/XBBGFWc3KvXT4UxctCahZmRP1Mr5hP5iQvaMfp7iAZioSsv1H2uolYqOUPZQNef+CGEG20nM8NNIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ant9n3My; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-88432e29adcso112962239f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 14:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755550877; x=1756155677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3nZTzF2lhsZGOWdY8YDL7P1nyHVBb5WBP5wnL3mixY4=;
        b=ant9n3MyhidCzVK4theaKTpSBYdHnNf1AlnxKN4VruncyD/QKO5lRVnBcJxRRl18Ep
         dBvUXCgywKh9f+pydfPoIDRfvxntqWL62fPbARpVwlr4aVNp1sZ1VJfXMuz3qzWY48Fs
         eSzlQ29YVxyFrHBjB5v+owui42xEfoMVri60nVnNc+ehIe4FPjwFR29l7g6aMg1dlr3O
         JJmfTlZdu7td/3gija5voI7T12pTQFtwEJcVXJhzmmyPcgUOd3rLkSaqmrsp+6QcB+vN
         rPX4i1OKaaZc/D2aztEsXR9WQN/dREWhFlGe2JTd+7GJP2bxZvfqkoMwYSjh/TBsFrj9
         d3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755550877; x=1756155677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nZTzF2lhsZGOWdY8YDL7P1nyHVBb5WBP5wnL3mixY4=;
        b=J+VquZpW1Jg63GuZKonjoD4Ym+oSS94RxZQjWwLJuSPyReOSi+Q+H93U8VTttV5Rol
         MiMm+PZaGgdKZSmxT8NwBEcOOVcIJxjUDzHIYzP4Q9UrqbOpcJ7j8tbQU0Hgf1ZA6tba
         Inw4S94ltqEnBfox0hzfTPctEFPgz/43YR7gzkPCXK2uAU1IgngfdDsS9D7LQPMQ3ytB
         idLZ6CBAnD4L/jCBW8aJCJWZlwkqETx8SGDExG8rbX7bg03xuf9zKGHl3eeDfw7kdLQP
         oiYLC6Qht+/Z//dqy5NupXUVU7fHstS5NxUZtWJXREEo+CpNUmAfmdUuTcZkZ16Rrns4
         1c8g==
X-Forwarded-Encrypted: i=1; AJvYcCUQ86BqKxKyae8W/t6DpjiWHcDNK0ihG4OHrum30+WTrcdaPhvv5DXLVvjzKBMFoSFXUErnGQ0M34/QNyVWH8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAB8BypeWc56E8LcoujK5WUVeOZ3N4mH1LwPkTP3buUv+rJ1km
	S8MfFkkOWHeL9hoINAsDo2w1CaSQdmp7A6PTofJlUGp4+vT4RRhs6raqlK7HxOi56jA=
X-Gm-Gg: ASbGncuRPJj0sb+i7rs0SYXSFeW5glBz9Q2lDsIP5BJYzqM2ol52D5XKO7s3mXtrHQN
	zt5Fu5p5+HFADA15GESZKfPb4N9Doy7tCbAOIi+fPX95hXB4TWW2/VF5s7kCtPYO32M10aNvwcx
	5ob4sM21VMTzd9GVKDCO1DqJK5fn7TZJK9ehC6KezFMTgU/dNaCUMTo1A90dIsQa10Ia+KiL1E0
	+E7jt1PizK3Uf4UgDh25sxZQOhYl3mbTMdJ7QP6+gyWvaiyfCvgwegoth3zGILQ+wmLQx2X1+5D
	AyfuWGA5XMVBIqIjDDFh632nhpfFM5bYH9vQVsEmFpdM5JSqVw0gXz5f7p6GU8xAg7ri1jBOoLO
	v2T6F7MXUitV0hpoYUErsUtHD
X-Google-Smtp-Source: AGHT+IFFpFqrnNZItu3L5GNLWSB269pADqOsIU+gIQEJhNsMNbkPMIMecR7fgqDGFDi8X/YtnL7Gbg==
X-Received: by 2002:a05:6602:2cd1:b0:881:87ac:24a with SMTP id ca18e2360f4ac-88467ecf75amr19364539f.7.1755550877544;
        Mon, 18 Aug 2025 14:01:17 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8843f9c47f5sm345226739f.20.2025.08.18.14.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 14:01:16 -0700 (PDT)
Date: Mon, 18 Aug 2025 16:01:16 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: dayss1224@gmail.com
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atish.patra@linux.dev>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Quan Zhou <zhouquan@iscas.ac.cn>
Subject: Re: [PATCH v2 3/3] KVM: riscv: selftests: Add missing headers for
 new testcases
Message-ID: <20250818-4672b703d0bf9518ee1d4162@orel>
References: <cover.1754308799.git.dayss1224@gmail.com>
 <cafaa0b547d4a1fc45a38753038c011ea7201d04.1754308799.git.dayss1224@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cafaa0b547d4a1fc45a38753038c011ea7201d04.1754308799.git.dayss1224@gmail.com>

On Thu, Aug 07, 2025 at 10:59:30PM +0800, dayss1224@gmail.com wrote:
> From: Dong Yang <dayss1224@gmail.com>
> 
> Add missing headers to fix the build for new RISC-V KVM selftests.
> 
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Dong Yang <dayss1224@gmail.com>
> ---
>  tools/testing/selftests/kvm/include/riscv/processor.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
> index 162f303d9..4cf5ae117 100644
> --- a/tools/testing/selftests/kvm/include/riscv/processor.h
> +++ b/tools/testing/selftests/kvm/include/riscv/processor.h
> @@ -9,7 +9,9 @@
>  
>  #include <linux/stringify.h>
>  #include <asm/csr.h>
> +#include <asm/vdso/processor.h>

This is fine, but...

>  #include "kvm_util.h"
> +#include "ucall_common.h"

...this isn't correct. We should instead add this include line to all the
source files that need it:

access_tracking_perf_test.c
memslot_modification_stress_test.c
memslot_perf_test.c


Thanks,
drew

>  
>  #define INSN_OPCODE_MASK	0x007c
>  #define INSN_OPCODE_SHIFT	2
> -- 
> 2.34.1
> 
> 
> -- 
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv

