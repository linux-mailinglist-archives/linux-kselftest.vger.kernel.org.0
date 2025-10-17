Return-Path: <linux-kselftest+bounces-43392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B53EEBEACBF
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 18:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5E385C0374
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 16:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841F8285056;
	Fri, 17 Oct 2025 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="XmsHA4iR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD146283C9E
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 16:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717841; cv=none; b=aaKxlnfkKjXuoNaivzTGCjBJ+zInss0ZSRYAa/gkhkKWabH4HqIOJWDzM8v14VGaAPmQIwAAKPgyebGzMUeQ/1LI+0oLQR5IzezwTeU3TV73kUqy9UzAOcJdiG46604HYOZKPonaWGs4Q6RAtOKvMJZVF8mSIxg+WNG8OEKDIh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717841; c=relaxed/simple;
	bh=pPbWyGESoeFda9PL7qjMzI+KDFiJUk2WW07WgvOC0eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twCFdWsmKn+ZxxfO/XsTQrbaUJZHeaIR00va5pAlUgU6rO7S8t/6vQ4EpFZnMI2VxWCcUiVR1p0yBGHQT2ERMticoSNCk0rNnie8AfKh+V+/8dcf6rMO+I9NS3jS7hpQc6EhgUYHLv5D0T+eAVwYzO/1CWw7onAMRv1pdLrSPzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=XmsHA4iR; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-430abca3354so18726225ab.2
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 09:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760717839; x=1761322639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SE59U9D9FBD2TsP2y/MjrBzEhIdNihINvSqWeLt6f7A=;
        b=XmsHA4iRMCoUXkqoAhZz91mStbZj7/xZ0iyoONrFgdOm+jKx2lxaEn9Bc9f0rGxOuf
         9TISpV5P6qO8uTPgf6zJCqv+r8fhg8OVHCKf6oJGNjc16iBIiZt11YPTbnFmz5Xe+5kK
         IXUHAFPnBwQ7CbtyhIULtonUKMoPq0CMgcCRSo2Kojsn+wp4m+bCSRXg7Hy0QftbjPHP
         RXvTCpWz5U0Xp2XxOlKCSMfgi9TQQIm4V9f2ItyBVPkqA00asRhSutVjKgSy4vVfcBDH
         nQyIKlJZDPZ1c8LrumBep6Im4uutjqMDVxG6UV0fOiRHzuXkaVCe0yTODZhTSn8kN1xX
         JMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760717839; x=1761322639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SE59U9D9FBD2TsP2y/MjrBzEhIdNihINvSqWeLt6f7A=;
        b=bfZrVCxQxar6F5Oa/tvljRp9iOS0va1WsxvZPgk4zpahQ96t1kEGGE3B/cShDhT8aQ
         IafnUX+LQTkCm3MqoloJedaGMnLD7C8mJwFA25Q8xMnC0dxe6xBfjE1lmBznqgSACQHT
         m258l9SpIVomd+vTE9Q24VLOpnWVMRilIGy3iu7S3GRHf1spYvEFoofFYtdNpmrYY7YE
         0n6MG4Coxmv65Q7KAyciWTFAyqDIYLA6yZFUp4PYQtS3Cr83WFw7TIAc3s37twSOQqqE
         uGo8YmXG5vcrqarV7W2m2VaKpIWnx6LYuhMryCfVLC/QzxmfoYJOmGmABLJOstD1ck60
         xD3w==
X-Forwarded-Encrypted: i=1; AJvYcCUYo0GZA33lvRZnhn6/iHGtW++gljGtQhZhr5u7NC8MeyFO00hAFcqt5Mezmn1FFoW+lE8VZPEnjT3lNbPZDt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtcViZcJQsDgoNF7G/GaVn/DmBhabkwgnTcDaWOdxAOiMTUL4z
	6mFcswuOHk3GIr6TdvGsQ5e/3kkuhZNYBRU0ijntP5wgh+IywYUh379s04x+66Tr3SV+ZPUQI3u
	mQpxdMdw=
X-Gm-Gg: ASbGncsZGchsB+8yh0m9haFY1Ukls8MpqDFhFRr4tXqNnBW4xFDF2ozGclZESfNdDTO
	kWiB2jYHgKPNfqPUaKWZkjY/vzbulCSWCCdgx36jFxI45mROiJuMdzWrUCuetqs4yBykELFv5gx
	M51XFhDKS/pmcMlPBb6QwIIea5BWNiznvWYYwuAZIzW1ch+ey8UrEDWmvu0WA33ZrW3I9Ag/acZ
	qkmfURu1Tja7c7ovijz5fA3dBhcawrQAhFe31wgQWoG5Ypbxc46bxlPZECcbEq6odzwTj9rbaWA
	KQEdfuJGM4e2nAeW/QaHUsYvfJy9A3rk9UGmPnYHtPfjyenluaquuiWSwyHlNVfD2CochGyDU9e
	FkOsnOBjToJ7l7o/qjJQrIxAD7mON0NZelw0eHZKsXS23BoO6Gdlq+FgErG1xvP3/778+3M2eHG
	BOHg==
X-Google-Smtp-Source: AGHT+IE/MHK6bGWFUML6lB8EABvgh/StOgVAz5yCP4m6sZL2slTHOrBxRy/hwICm8V+ly8yQelL67Q==
X-Received: by 2002:a05:6e02:b44:b0:430:ae1a:3375 with SMTP id e9e14a558f8ab-430c529df57mr60456845ab.26.1760717838760;
        Fri, 17 Oct 2025 09:17:18 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a979ab14sm8576173.65.2025.10.17.09.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:17:18 -0700 (PDT)
Date: Fri, 17 Oct 2025 11:17:17 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Atish Patra <atish.patra@linux.dev>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/4] RISC-V: KVM: Add separate source for forwarded SBI
 extensions
Message-ID: <20251017-68a09a4da911ec4eec058592@orel>
References: <20251017155925.361560-1-apatel@ventanamicro.com>
 <20251017155925.361560-3-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017155925.361560-3-apatel@ventanamicro.com>

On Fri, Oct 17, 2025 at 09:29:23PM +0530, Anup Patel wrote:
> Add a separate source vcpu_sbi_forward.c for SBI extensions
> which are entirely forwarded to KVM user-space.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/kvm/Makefile           |  1 +
>  arch/riscv/kvm/vcpu_sbi_base.c    | 12 ------------
>  arch/riscv/kvm/vcpu_sbi_forward.c | 27 +++++++++++++++++++++++++++
>  arch/riscv/kvm/vcpu_sbi_replace.c |  7 -------
>  4 files changed, 28 insertions(+), 19 deletions(-)
>  create mode 100644 arch/riscv/kvm/vcpu_sbi_forward.c
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

