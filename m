Return-Path: <linux-kselftest+bounces-1862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E79811F9A
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 21:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0801C209E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 20:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCF57E553;
	Wed, 13 Dec 2023 20:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jH6SPAsq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B84EB
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 11:59:56 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-dbc72b692adso4083323276.2
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 11:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702497596; x=1703102396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s31Qnl2jy9dVbfR9SU0O1e0gpO4gYzM2ckO1KK9cNWQ=;
        b=jH6SPAsqxum5r3bxOr50QI5W87HWpirYc1yAIgS/RNk9lEb5qFNA6PDAz2emVohfq1
         gOwnW748Yc7xrx+hYRlaJMmMhMj4iEBIn1WM2oDG2dl/x1xnY3WsP8v7ITohdLywlGd8
         HGs2IvZ/FY9gTmgtVvecABlfpLXjRNz/FDTKUDSuL6/m4SMJBIAVzfqgMX6LeqDNWNuM
         73UkEIW4t49gpM0cixQTLOGffy9lfjQmwzbmxDaTGBmxQcsyTusofHLMOfFlP7SfKkMn
         BnDkfhGMO1ql5kdAQqUyYWJEmdzxqY4hriswEuWn8AqPsYBZLyEtrRFur1hvPEm9fZFt
         wEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702497596; x=1703102396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s31Qnl2jy9dVbfR9SU0O1e0gpO4gYzM2ckO1KK9cNWQ=;
        b=ppgpr0zQWZJOTpakBC1XZvPlhZfWiX5g+GUYVc3/bFhuCwMKPkvDFAqLPvP8G4G6pu
         mrg/jGUsLipSenxLe3D3UIlfZiSrAsAAxlqiW7G9wefcow68gifxVGejH6kfruQrUUzE
         tYIdyjldqZIh0vShhByeKULyHTMouyUDNRgQ66JYHGN/QH5WGfs/wBfU9m7+x3pUGow2
         KOak5ALzC/ENXlBTmiHTIqoUH1kyxsNz+MYNZqujfe7GYxFWXdsX+u62braaAbbflQ5P
         J0BHrIxm8XmGsekAJu7ZsfOOw1cb2pn57+NEERoseAD/WNkpAP2/dhZg5bIpluMzNlub
         pQQg==
X-Gm-Message-State: AOJu0YwT0Sb8bbNRXvmjZefb/g9e38K/ink1I/BXPMQmxPXK9wk8au9m
	jfleFDr9MacAeOD1LPN8NygT3OFL/jvKHAbddt4mog==
X-Google-Smtp-Source: AGHT+IGoanEfSAfWqtQw7++5uapiVETyiSe4lA5KkKISTBsZpDDCHd2EgxZu4V1rN9q+R/qEjWhYJ9uGnGBTlEe8bKg=
X-Received: by 2002:a25:6ac4:0:b0:db7:dacf:3fb6 with SMTP id
 f187-20020a256ac4000000b00db7dacf3fb6mr4418808ybc.99.1702497596004; Wed, 13
 Dec 2023 11:59:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org> <20231122-arm64-gcs-v7-20-201c483bd775@kernel.org>
In-Reply-To: <20231122-arm64-gcs-v7-20-201c483bd775@kernel.org>
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 13 Dec 2023 11:59:45 -0800
Message-ID: <CAKC1njQVB71A8fQBLmBnx++agM12XDLhS=7iL7-A4NTXSqUM+A@mail.gmail.com>
Subject: Re: [PATCH v7 20/39] arm64/gcs: Context switch GCS state for EL0
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, 
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Florian Weimer <fweimer@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 1:45=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
> +
> +/*
> + * Apply the GCS mode configured for the specified task to the
> + * hardware.
> + */
> +void gcs_set_el0_mode(struct task_struct *task)
> +{
> +       u64 gcscre0_el1 =3D GCSCRE0_EL1_nTR;
> +
> +       if (task->thread.gcs_el0_mode & PR_SHADOW_STACK_ENABLE)
> +               gcscre0_el1 |=3D GCSCRE0_EL1_RVCHKEN | GCSCRE0_EL1_PCRSEL=
;

If the intent is to disable, is the GCS stack freed or kept around?
I expect if libc is taking the decision to disable, kernel should free it u=
p.
Is it freed in some other flow?

> +
> +       if (task->thread.gcs_el0_mode & PR_SHADOW_STACK_WRITE)
> +               gcscre0_el1 |=3D GCSCRE0_EL1_STREn;
> +
> +       if (task->thread.gcs_el0_mode & PR_SHADOW_STACK_PUSH)
> +               gcscre0_el1 |=3D GCSCRE0_EL1_PUSHMEn;
> +
> +       write_sysreg_s(gcscre0_el1, SYS_GCSCRE0_EL1);
> +}

