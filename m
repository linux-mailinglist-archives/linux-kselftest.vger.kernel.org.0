Return-Path: <linux-kselftest+bounces-13764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DEE931FBC
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 06:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE86A1C20CB5
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 04:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3796811711;
	Tue, 16 Jul 2024 04:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JfxiQq/e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAA4171B6
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2024 04:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721104704; cv=none; b=rk4xwyYq3FJ/YOCpdpF3H949u8ntqJWHYbb8xAB8PTk1sPk0hV1uN09JxpN87CNQRmr76CIxAsrBkbEN1kjAJjEtlndreMxteHmC8iNoVLAWfnDI/a79qv+I+QfyH3I4z1DmodliTK/uY7J7YZh4qZhohHEraHePThsR6gQNozc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721104704; c=relaxed/simple;
	bh=ztt71uxgqQGaS1jupaXZbcJdohblC5lD4CiMmk2sDXA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=J+SaWBdLY0jpZeefoCB+MUhie173WT+rGiTzk8vEZZYioGnlPeXy53GnbKCLBsflhNfob74kuSHiZcuSR4BMvoUHTXEAR6/MKAE5rg1ytqNvsCinWT7qAIEWIEfGtE5j1fYC7kQs3Mtx82I0BFtlvBUxfDmTlcvohO5UL37FOVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JfxiQq/e; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-70847d0cb1fso2802696a34.3
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jul 2024 21:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721104702; x=1721709502; darn=vger.kernel.org;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6RYJet4RQukgf9/gOwGFhMgYHqkPIZETJ4In2JBN77A=;
        b=JfxiQq/ePZfOIHDc/unxOh7oIYbjtOkstFIgL+5EHn7neaF1S6EbbaDllOwV6wderG
         TMTaAWOqEhfat/dErD0DJEcOKE2tS57ydymXQCO9ri+MZ6IfQE9DTx8lEZrkbByGLIXL
         +m4UDDNSrq/lOKrz/xBAdQNs1bNK+gItI9SnDGT5IvTmsFLlYEOnBc2zBm3QFkeu0IAz
         7fKQGz+Ak1RRV6Zh7J5e4Ku6DlLcabeBjOYTN8HqtVQ0DDPu+YKodJ1ZE6nqifcRkXCf
         hpuRon3hGGal5pFbCsEXPBCjfMGMlG9q3qnYF/CgIdhEJ6yjseUbQhkiLU/FaeR1qiYD
         K4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721104702; x=1721709502;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6RYJet4RQukgf9/gOwGFhMgYHqkPIZETJ4In2JBN77A=;
        b=SK2vBiT+txupOEDOF/TuvGXVZKa1rjRdMyl4L5SJwCJ8tcE2GHNXetCh8BBELbuPCC
         yLl5QW0SK0CgTXs7jJnhMWixSIxkQZTdZCjfUr/SO/GyWfyDYeaqASqmc0nHwrylg46+
         MRm1T7IGQKbm50AuR2dxNsT90Hu+SispJpkZMEO0qufLriIMCO9SV3FKt1GHfeR+IE5E
         pz3ZrWGjzC4R2jZkoNF+Dds3qSHHheqXlUvy+hPcx9XLuvlcEaxqwehiqRjXULKp3nME
         80WOaM6mT/q2XAGa40R5XpaDo9Eu10iuKhCMsn3sQ+6gWe+y427KEVCY2dPWQJ5HdCU5
         JCSA==
X-Forwarded-Encrypted: i=1; AJvYcCXBh14Ic9RdTiAFloaN93tIaSB0gFDc58wXeBe8vgrkozHkIbw9J8fo1/B10UQ2SXz+vzDsfh7kO43maBFVPQXA2KgiXLfwNVK162WN4fGX
X-Gm-Message-State: AOJu0YzMnwt633tSJFnuCrwinf3tQ9yHXxusFiq62k5wcd0Kf0yMQ/Rl
	U1zcUs/e0r51bkyecp5KdgWkTI3lmeg55amA44L45cQFGV4DrrGZDAKiLvOqs8E=
X-Google-Smtp-Source: AGHT+IFuTBiSX/I/b8/1CrzFpy+eoFfX+Oe4M7y7ZGQlYD/Samet5CuV1ME9BquFP8D6J9TkXx2HIw==
X-Received: by 2002:a05:6830:6d16:b0:708:d84d:f628 with SMTP id 46e09a7af769-708d99bc4cbmr1446194a34.31.1721104701772;
        Mon, 15 Jul 2024 21:38:21 -0700 (PDT)
Received: from localhost ([2804:14d:7e39:8470:2914:689d:ed52:527])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7ff8csm5250315b3a.135.2024.07.15.21.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 21:38:21 -0700 (PDT)
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: broonie@kernel.org
Cc: Szabolcs.Nagy@arm.com,bp@alien8.de,brauner@kernel.org,bristot@redhat.com,bsegall@google.com,catalin.marinas@arm.com,dave.hansen@linux.intel.com,david@redhat.com,debug@rivosinc.com,dietmar.eggemann@arm.com,fweimer@redhat.com,hjl.tools@gmail.com,hpa@zytor.com,jannh@google.com,juri.lelli@redhat.com,kees@kernel.org,linux-api@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,mgorman@suse.de,mingo@redhat.com,peterz@infradead.org,rick.p.edgecombe@intel.com,rostedt@goodmis.org,shuah@kernel.org,tglx@linutronix.de,vincent.guittot@linaro.org,vschneid@redhat.com,will@kernel.org,x86@kernel.org
Subject: Re: [PATCH RFT v6 3/9] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
In-Reply-To: <20240623-clone3-shadow-stack-v6-3-9ee7783b1fb9@kernel.org>
Date: Tue, 16 Jul 2024 01:38:18 -0300
Message-ID: <87ttgqt0hx.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hello,

> diff --git a/mm/Kconfig b/mm/Kconfig
> index b4cb45255a54..45416916dec1 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1249,6 +1249,12 @@ config IOMMU_MM_DATA
>  config EXECMEM
>  	bool
>  
> +config ARCH_HAS_USER_SHADOW_STACK
> +	bool
> +	help
> +	  The architecture has hardware support for userspace shadow call
> +          stacks (eg, x87 CET, arm64 GCS or RISC-V Zicfiss).

s/x87/x86/ ?

-- 
Thiago

