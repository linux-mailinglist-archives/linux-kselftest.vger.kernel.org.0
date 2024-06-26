Return-Path: <linux-kselftest+bounces-12831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619EE919B58
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 01:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC756B20DDD
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 23:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0651940B1;
	Wed, 26 Jun 2024 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4vCMK8c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0A8173338;
	Wed, 26 Jun 2024 23:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719445286; cv=none; b=iaQ4da2q6ko7gHt+Qy1AiPbrpyH6zvjL8gjJpCMM1nO4RLfEfE4u4lNQnli0ldF52FHpi2Kro2B0xX7Gbwq/VvgiHsDrR8mN9yBzJ4iHFJDD0zRp+/TzdiHnS9akivPF1dxJsXiMYlQs4M82+VafXyTQugkCMoGMNlp6PBczHu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719445286; c=relaxed/simple;
	bh=zodotJsNLqz/8VDxv5vb1VRn0Na3rR66tkglkObhjkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxyJkFUOebPCE4gYXiu+DZGcUEnlQ7AQ8rs/kQe1x4ROck5gKLu01svZknLmrTOxZMJRHxSwZxBJ3g6KLyi4IYLH1kWkGmtTKC0P9h9THo7q80QieLRL09j2ghjzR19Z7HalYuQb/72711JBLdw5f2cmmmri/n7cUQiTuhaBUg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4vCMK8c; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c8c6cc53c7so1439287a91.0;
        Wed, 26 Jun 2024 16:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719445284; x=1720050084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q75y4HlcnMFhNSdXYzOid0DuOcRP1tLE1Madx/8kx5E=;
        b=L4vCMK8c3thrY8+beKutXTYXyTmOO6oHDbjWsVenClxeWMcb5ztg/cJinPEF0AUxgR
         D5A7gG9YPYKAvWww3kpBiyFiLARQ/FSAsr5mXaEUm5WMQ/sy6pq3NLsP/8/i6fOWPPt0
         qzfJI+d2T/sObVPIRhIWGrGiYFn8MVHYkUhd67RhKMGbropgDzSlClSj3EHgmHxAbt2L
         KwHNZ7wKYEqkJIsdnaqvigV30faaqQtelrFbjV/yK8rD+e8MtSJGlkyXmRjmn24umnuE
         1audl0FlhtMC6KQ83oetZbMOV5HIgfQScX+uVzPWZvoHVEcQbxRJIBX8+3BWSts1WTa8
         pB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719445284; x=1720050084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q75y4HlcnMFhNSdXYzOid0DuOcRP1tLE1Madx/8kx5E=;
        b=sDWryVB6QIl7uC46riaMQCW1b81OGYWr/4KO2oIL1DpgvSTXr08FG5ilBDakbAd6oX
         p0F+mT1/2SClcFUqaVoE2GGZFmYL5J0sBDjwB4kuAzlF6nbwlusWps0yQDITkJA67bJJ
         u56EMa1imAATW6T4KCyCmPIPqCb9WEgeXqYyVzkSCINaX1Y3Ttzb2KKAzVDCYprCfjiB
         mngw7qcBXqsC3vnf1UekiHnanqHS8KBn9b1+Bw2JxjBFKl5lNU0rov9W1zp9iIP2C118
         qGmRsmIs/MyO3TKcp3Lhox+FsnLAxsgsXLiBF2Ica6BQaFmZcZyGZo+DvSBSYVgA6Pi7
         83vA==
X-Forwarded-Encrypted: i=1; AJvYcCUoSnGhNBJigtYYuC/wuR16DAABOlAWk6HRQh9psrpgHP6XUSfBBSW0JXECo9vfpEAdJ1pVJJ8u4MiBkuZNls2F7G//Dqik7oXSnBv38e6Q10exCbNoWPORvHMur7/8joZX+PoZY2qzFRSS97SvHwmdanHvXzGVSrniCnV6KHPtJyNw
X-Gm-Message-State: AOJu0YyW/CgcOMIzflV6CCudUrBFPRGx7hIUefG64Ne1Mg3/5kDGc7Gq
	VHX0iwfwcVz4TvAI6tn1Gbyo1hPR8hLzS3ilCMW6fi6rpYT68wwjiEfLqUM/lfbHcJedK4+uPfy
	Su8EoNfo4mMmm/K3GHO/jEL0jb0Y=
X-Google-Smtp-Source: AGHT+IFpzOA7dcXhS+wxQxyW/fwg+ij4v1TChHqSbVlfYnr6fbvZzzY/48isworciXLs8gTngYWF2MOr6kWq/6dPDKw=
X-Received: by 2002:a17:90a:b116:b0:2c8:858:7035 with SMTP id
 98e67ed59e1d1-2c8614096cemr9671258a91.25.1719445284421; Wed, 26 Jun 2024
 16:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240623131753.2133829-1-make24@iscas.ac.cn>
In-Reply-To: <20240623131753.2133829-1-make24@iscas.ac.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 26 Jun 2024 16:41:11 -0700
Message-ID: <CAEf4BzbudMt+2VS+F7B70X8bniNH4m-Y3P5tTm0zgABYZcA_UA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: don't close(-1) in serial_test_fexit_stress()
To: Ma Ke <make24@iscas.ac.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, 
	shuah@kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 6:18=E2=80=AFAM Ma Ke <make24@iscas.ac.cn> wrote:
>
> Guard close() with extra link_fd[i] >=3D 0 and fexit_fd[i] >=3D 0
> check to prevent close(-1).
>
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  tools/testing/selftests/bpf/prog_tests/fexit_stress.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c b/tool=
s/testing/selftests/bpf/prog_tests/fexit_stress.c
> index 596536def43d..94ff1d9fc9e4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
> @@ -50,9 +50,9 @@ void serial_test_fexit_stress(void)
>
>  out:
>         for (i =3D 0; i < bpf_max_tramp_links; i++) {
> -               if (link_fd[i])
> +               if (link_fd[i] >=3D 0)
>                         close(link_fd[i]);
> -               if (fexit_fd[i])
> +               if (fexit_fd[i] >=3D 0)
>                         close(fexit_fd[i]);

bpf_link_create() and bpf_prog_load() will return FDs > 2, so we
should just check > 0 conditions. I fixed it up while applying.

>         }
>         free(fd);
> --
> 2.25.1
>

