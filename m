Return-Path: <linux-kselftest+bounces-38677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEACB203F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 11:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD42188D244
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 09:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CE42253A9;
	Mon, 11 Aug 2025 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="AbljZKnb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C6722422E
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905302; cv=none; b=i3y1vccQ1m+YcENYv7x64xYT6Oo9165snMaRFUHsZKRFdGkOpdZ68XH3sNDN+C/+q2O16BXKujM74jpUeiFyjL2l4akgkEvQDSalQYyd8ASWL9ezlw0CALqlbAR+JGgZkvqcNk1eG+VYjDXep+XJkZ6sLIXTuACjR1OdhgBvz08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905302; c=relaxed/simple;
	bh=FegSiZ/uTFpjfSl6w3mw++RAIeSoUOFcA93L/NfHQZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbbeAHiSk582gh0Xlm04fViQ/8vYRj31OXXdj71ecJGbOnXWJACWF4/SxJ1P05tUEQyf8iYv+OSbWKzYOgHxQpyiY+MnYRka6sQrly1bPAAOyeqgByaMBAasBMhAdz8/RrTMvqwrb7ESlqLXlxwNVYiFt0yfMcwYmWCuy5P+Vg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=AbljZKnb; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55b85d01b79so4312279e87.3
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 02:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1754905299; x=1755510099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cy59ORjyXtIVFFgfYeqm1wmJyEdmnPmaEOXMVqFckn4=;
        b=AbljZKnbDcKb7rjVsQSH4FwsC4jB1y+FTmw/znt5dyJFeR20/8cxkzVFF/phMbgXHR
         F/3fALREVG+MqUobCe+7Oo9lcbH8ldP+EhGd0Lxh2okKC5MG+bY9fS6i47YN0+WlMsv0
         B3z66gns21qhGlLBx54jv5p9WX3Nw+HFh+y+3/l8VKAj/LeapLFaSklMaYvFH+vceozn
         V8RFVeE8mESbVKKznQbi0DGzzjmeAILEAfjOaXuQbHDHxR2CEUr9mbCI20H9DFBh30hX
         KDx9dUrYl7f/DEnbqFYaOQqhzpD3lBu8sSDXYOzmk74PjPtSewPQprXnzy1zcZOYXU7d
         3wsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754905299; x=1755510099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cy59ORjyXtIVFFgfYeqm1wmJyEdmnPmaEOXMVqFckn4=;
        b=kditPjtLqvd53sEhL1Agk25tydkgnF2yNbqy/WtyFj12yKILco3Bg6D8OqbvrTKBY5
         Lr/f9DURPnyI6PIK04uwxE8Zt9/xWbZns6rubBVFaO2cQY861RN/jG8k7IT8fNqxpvhe
         7euorlP/+kqIfCmr34q3n7FxuvPi02BHXNZJnMZwcPFGEMCxaE58fHpp1m0HLg5jJe2C
         yhBOxlbtffzXzBofrrMistjV/15LhVJt8cMdl7vx2l+S7oVZTuHOFSgXtKbb3YY+94kB
         cuBOruEdbrlnXZ021HS5gqBJpu+J6M59ypb57no8VT770DAtHRJhmQp6bYO3hYHCbIvu
         WFOg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ9E1eAjXKAaGWod1emj8bIEZ8IRr4YM2Q9M1FL/4xpS8EA4PVLydq5lwwH6K0GEFzNzMix/tvxecjNl57gOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+L/bEXdQ7j7NLUdr9uTzFRm8kdTfOa+DQwvm2A3Mh+GoGCTqP
	VhlnKtDMJVoi/04sIbe6nWgrE6piVT/nGaqq1p8JNf5O5EOe9Mpzgg04SxtP+H2uzFZHvJnR/mf
	CtHrPahX6vrAobyX62Xddabm/WsJ0nkHkp8KjvbjZNw==
X-Gm-Gg: ASbGnctW6BODKCVJSvnSBLCYtTBeiTWLEf1HCWhk5L3a17KBxsekYAsjkG1TGP70M5i
	yd3/Qp7L+k6K+TiPLEO2jb10cKr/tebcohFCfemlxA8lGjrMhXcetKr15f343F+41gOVUXYbpnt
	4pToFoxoz5vMv9V9r1S9NZ7CeTWn/x/OOkSPKfdpp0plfzOrVkbse+jiHuXdCl7DkNuKMVAxyqZ
	daxjO9+M3vI6ugYJnU=
X-Google-Smtp-Source: AGHT+IGmUn3ZM7jBX7D1YyhKjvaPN2e4dHa6K9n92Zz8n8QotO81v1sGyRseqSkkKtsFNnDYwv8ehf88vLMTTISTp9c=
X-Received: by 2002:a05:6512:2316:b0:553:3a0a:1892 with SMTP id
 2adb3069b0e04-55cc008637dmr3351518e87.15.1754905298946; Mon, 11 Aug 2025
 02:41:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805193955.798277-1-jesse@rivosinc.com> <20250805193955.798277-6-jesse@rivosinc.com>
In-Reply-To: <20250805193955.798277-6-jesse@rivosinc.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Mon, 11 Aug 2025 15:11:27 +0530
X-Gm-Features: Ac12FXzX2WBI8Efn8ZEvJJb1ujk-ZIhK3W3ZYl12yeFcZ1SpyaqkJna1l4oNLS8
Message-ID: <CAK9=C2X2J4ROJ7nKB0hcD9dVav7ZMFWw2Qy+GEsmYN_Tt8DxPQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] riscv: hw_breakpoint: Use icount for single stepping
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Shuah Khan <shuah@kernel.org>, 
	Himanshu Chauhan <hchauhan@ventanamicro.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Deepak Gupta <debug@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Atish Patra <atishp@rivosinc.com>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
	Evan Green <evan@rivosinc.com>, WangYuli <wangyuli@uniontech.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Nam Cao <namcao@linutronix.de>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, Joel Granados <joel.granados@kernel.org>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Celeste Liu <coelacanthushex@gmail.com>, 
	Chunyan Zhang <zhangchunyan@iscas.ac.cn>, Nylon Chen <nylon.chen@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Akihiko Odaki <akihiko.odaki@daynix.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jesse,

On Wed, Aug 6, 2025 at 1:10=E2=80=AFAM Jesse Taube <jesse@rivosinc.com> wro=
te:
>
> The Sdtrig RISC-V ISA extension does not have a resume flag for
> returning to and executing the instruction at the breakpoint.
> To avoid skipping the instruction or looping, it is necessary to remove
> the hardware breakpoint and single step. Use the icount feature of
> Sdtrig to accomplish this. Use icount as default with an option to allow
> software-based single stepping when hardware or SBI does not have
> icount functionality, as it may cause unwanted side effects when reading
> the instruction from memory.
>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
> OpenSBI implementation of sbi_debug_read_triggers does not return the
> updated CSR values. There needs to be a check for working
> sbi_debug_read_triggers before this works.
>
> https://lists.riscv.org/g/tech-prs/message/1476
>
> RFC -> V1:
>  - Add dbtr_mode to rv_init_icount_trigger
>  - Add icount_triggered to check which breakpoint was triggered
>  - Fix typo: s/affects/effects
>  - Move HW_BREAKPOINT_COMPUTE_STEP to Platform type
> ---
>  arch/riscv/Kconfig                |  11 ++
>  arch/riscv/kernel/hw_breakpoint.c | 179 +++++++++++++++++++++++++++---
>  2 files changed, 172 insertions(+), 18 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index fd8b62cdc6f5..37f01ed199f3 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -546,6 +546,17 @@ config RISCV_COMBO_SPINLOCKS
>
>  endchoice
>
> +config HW_BREAKPOINT_COMPUTE_STEP
> +       bool "Allow computing hardware breakpoint step address"
> +       default n
> +       depends on HAVE_HW_BREAKPOINT
> +       help
> +         Select this option if hardware breakpoints are desired, but
> +         hardware or SBI does not have icount functionality. This may ca=
use
> +         unwanted side effects when reading the instruction from memory.
> +
> +         If unsure, say N.
> +

We expect the same kernel image to work on a platform with
icount triggers and without icount triggers.

Please drop this kconfig option. The decision of falling back to
computing hardware breakpoint step address should be at
boot-time and not compile-time.

Regards,
Anup

