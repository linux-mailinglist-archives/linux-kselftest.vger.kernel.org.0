Return-Path: <linux-kselftest+bounces-3599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8349583CC15
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 20:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E861F22FD1
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 19:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C628F1350E4;
	Thu, 25 Jan 2024 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KZBQyURt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4001350C4
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706210814; cv=none; b=eOdM7m5fu+LHgIJKgSlieWNcEFAB04VZGBLO3Zlypo5HR0aFBDeZmPoJoBlX4Uwq4fKtO6rV/5yxSwZy0YPfngpetVuo2DBPncCQNBfhZydX4A7qpoNuCwjpFfdjGzzuNH1h9cVVdr8f8ZxnNnGGhTj9TzZbfp2NRwOpSyUXNmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706210814; c=relaxed/simple;
	bh=ylFJKzXqxkLLZFj7AHYMJMyVTFRolbBhbtaZYtJqeFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsK+JoT7PfmIX4ukEZ9w3/84vt2zPF2VZ/hTsWfhXE3tPYkdx73riy/EuL57EcJMgGWFHJqGQsonwIjfxUXzg3t++RUr68/Hr1783n6scSdwtbWzuwvJw/d3cuPeKzCgH1xEVyhGcJg2KgY9f0B9ixXPMeSGrw+SFh5WCXIgQ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KZBQyURt; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d51ba18e1bso65282015ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 11:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706210812; x=1706815612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UQXEmk/KhfqrXjoSGAenKDc1hYdrFqHQSs6fJFT2dl0=;
        b=KZBQyURtNBdCg+5WsV/2PlC507i7ad612vIfMFRBP61Vt34euQ9shTDsWKVCx5hgMI
         ftGD0bO4VvQTdRtXnx8ZZdLoLiK3pma0F7er3An7b7T+4W6+I0MIJ70eqEyPMMF09A0g
         YSzG4J6gLjld9tJzfWAoddgdoWygvrWA3L5G+Y6b6JCRnCnNzYRpSNq2bd9Zvon50qtj
         XLYFV2/qZebdyPJTyi1L1crYRtgU8e3OIiZwR9kTpy/hH7ioaB1mU/E1Z03FtiQp+la1
         pu0mlEAbIo15jeplcDLgWN0LsZIVMz82cCms/hxMhs0yaQEGVGUH3ORluIOMfSDKgovk
         M4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706210812; x=1706815612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQXEmk/KhfqrXjoSGAenKDc1hYdrFqHQSs6fJFT2dl0=;
        b=hD2z9oNanMgjT5AlJT7aldZ4Q23fO+4mbir2tL7XD9V7RK/mLbg7On3jYlaeMHdkuZ
         5QCE66j95wq1YCUPLhn2LZpvCoIulMU6t0M62cnU+VbvXOn3RwCpIdZkeRGjm0BYH0ZP
         zItNRE9YOiQ0vK9YESwkcmgRtki46+tx/EipS8X7vZeharDUP2XJ2bTg1RW2+DQhteD8
         JJBF81t8f9MmeZHBbrn2cv3QyaMq5srEWRJKYo9mo+zbDgXKZjMQ0hC3cGzwKziCQGA2
         FGQn76UFDwhPJc0HtzMegShbCT+s+jU8b+0HkxlQxGBY8MHR1bHZ+lX1XoMhd/MHr/g8
         mLTg==
X-Gm-Message-State: AOJu0YzSN4CvTP/n5l/RSsU0RdM+SXObLlwi+9VlHCdMAkOjJWWIyub+
	nkgInS6wgx6sijaq+xWTErk9MCGuA2Im8qP3dRAtBJKkX1uz5QKZx2jppOdQaTg=
X-Google-Smtp-Source: AGHT+IEjKhTyFXdeaj6bJIwWSc4zBffLzTHNmIGLnbACUsqZozte6YVSrp4zqdesGPXDBC/y4GWPyA==
X-Received: by 2002:a17:903:2350:b0:1d4:97:b8e with SMTP id c16-20020a170903235000b001d400970b8emr186405plh.79.1706210812431;
        Thu, 25 Jan 2024 11:26:52 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id l11-20020a17090270cb00b001d757e49a70sm6544821plt.112.2024.01.25.11.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:26:52 -0800 (PST)
Date: Thu, 25 Jan 2024 11:26:47 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: rick.p.edgecombe@intel.com, broonie@kernel.org, Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com, keescook@chromium.org,
	ajones@ventanamicro.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
	alexghiti@rivosinc.com, corbet@lwn.net, aou@eecs.berkeley.edu,
	oleg@redhat.com, akpm@linux-foundation.org, arnd@arndb.de,
	ebiederm@xmission.com, shuah@kernel.org, brauner@kernel.org,
	guoren@kernel.org, samitolvanen@google.com, evan@rivosinc.com,
	xiao.w.wang@intel.com, apatel@ventanamicro.com,
	mchitale@ventanamicro.com, waylingii@gmail.com,
	greentime.hu@sifive.com, heiko@sntech.de, jszhang@kernel.org,
	shikemeng@huaweicloud.com, david@redhat.com, charlie@rivosinc.com,
	panqinglin2020@iscas.ac.cn, willy@infradead.org,
	vincent.chen@sifive.com, andy.chiu@sifive.com, gerg@kernel.org,
	jeeheng.sia@starfivetech.com, mason.huo@starfivetech.com,
	ancientmodern4@gmail.com, mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com, bhe@redhat.com, chenjiahao16@huawei.com,
	ruscur@russell.cc, bgray@linux.ibm.com, alx@kernel.org,
	baruch@tkos.co.il, zhangqing@loongson.cn, catalin.marinas@arm.com,
	revest@chromium.org, josh@joshtriplett.org, joey.gouly@arm.com,
	shr@devkernel.io, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v1 24/28] riscv: select config for shadow stack and
 landing pad instr support
Message-ID: <ZbK198Vovbw2CwrR@debug.ba.rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-25-debug@rivosinc.com>
 <20240125-snitch-boogieman-5b4a0b142e61@spud>
 <ZbKkgNX7xfU5KO8X@debug.ba.rivosinc.com>
 <20240125-implement-coagulant-3058e743a098@spud>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240125-implement-coagulant-3058e743a098@spud>

On Thu, Jan 25, 2024 at 06:44:48PM +0000, Conor Dooley wrote:
>On Thu, Jan 25, 2024 at 10:12:16AM -0800, Deepak Gupta wrote:
>> On Thu, Jan 25, 2024 at 06:04:26PM +0000, Conor Dooley wrote:
>> > On Wed, Jan 24, 2024 at 10:21:49PM -0800, debug@rivosinc.com wrote:
>> > > From: Deepak Gupta <debug@rivosinc.com>
>> > >
>> > > This patch selects config shadow stack support and landing pad instr
>> > > support. Shadow stack support and landing instr support is hidden behind
>> > > `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wires up path
>> > > to enumerate CPU support and if cpu support exists, kernel will support
>> > > cpu assisted user mode cfi.
>> > >
>> > > Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> > > ---
>> > >  arch/riscv/Kconfig | 15 +++++++++++++++
>> > >  1 file changed, 15 insertions(+)
>> > >
>> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> > > index 9d386e9edc45..437b2f9abf3e 100644
>> > > --- a/arch/riscv/Kconfig
>> > > +++ b/arch/riscv/Kconfig
>> > > @@ -163,6 +163,7 @@ config RISCV
>> > >  	select SYSCTL_EXCEPTION_TRACE
>> > >  	select THREAD_INFO_IN_TASK
>> > >  	select TRACE_IRQFLAGS_SUPPORT
>> > > +	select RISCV_USER_CFI
>> >
>> > This select makes no sense to me, it will unconditionally enable
>> > RISCV_USER_CFI. I don't think that that is your intent, since you have a
>> > detailed option below that allows the user to turn it on or off.
>> >
>> > If you remove it, the commit message will need to change too FYI.
>> >
>>
>> Selecting this config puts support in Kernel so that it can run tasks who wants
>> to enable hardware assisted control flow integrity for themselves. But apps still
>> always need to optin using `prctls`. Those prctls are stubs and return EINVAL when
>> this config is not selected. Not selecting this config means, kernel will not support
>> enabling this feature for user mode.
>
>I don't think you understand me. "select RISCV_USER_CFI" will
>unconditionally build it into the kernel, making stubs etc useless.
>You're talking like (and the rest of your commit implements it!) that
>this feature can be enabled in menuconfig etc. Having this select
>will always enable the config option, rendering the choice below
>redundant. Try turning it off in menuconfig.

Aah got it now. Thanks.
I'll fix this messaging and select in next version.

>
>Oh and if it were valid to have here, you put it in out of order. That's
>an alphanumerically sorted list :)

Thanks for pointing that out. Will fix it.
>
>Cheers,
>Conor.
>



