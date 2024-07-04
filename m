Return-Path: <linux-kselftest+bounces-13205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CCC927CD8
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 20:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3803B1C21FEF
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 18:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A966F065;
	Thu,  4 Jul 2024 18:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZ0j/Maf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4D439FC1;
	Thu,  4 Jul 2024 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720116555; cv=none; b=Uf4eKizKJIsIaYPNJpdaUlhLY7bQ15Ycbgaj+UbcbmDMhvA3Z6mHW3k+XmUmsdl+AwTEA6Sx5r0qhUvGUX0B3UETVS6qv/3s7m2Wvelv5ANRynCT3SipYobqd4fxQETy+LChlIQq3TwMENO5Ta3oR5PoZL4UolVSQ1q9B3BEh2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720116555; c=relaxed/simple;
	bh=QCsD6s+u0aExCYRBKpNVR1hOsGWSC9BM3te+aNP96Kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KD29NOUFnymptvzyzFCamfsY4BhXvLpRqyn5ap+wWZUVbJkhEX4I3j2M0/nQIjl2agS9bZnTQCTAG7OgnYlWgy9Jaaya3/oW4dhU3gmctBMutoI7SOd/jfDecLUzR4tgMnKD31AB19d7PZYChkk8QtRSDso/jiT0cjUyVlnPyXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZ0j/Maf; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ee910d6a8bso5479561fa.0;
        Thu, 04 Jul 2024 11:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720116552; x=1720721352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCsD6s+u0aExCYRBKpNVR1hOsGWSC9BM3te+aNP96Kc=;
        b=HZ0j/Maf/qlozCBMUr6bfNUkZC9vIwVCBHClwE42R73KUZTDIGDTZXWOEBB8sJ58xG
         rB46EiK5+DLpM+tqLP1QB65nWx6QnuFOyKjloFvbX0rDSUGYEqWY0dBcOoubuK/7X5Ex
         G1DdLDLw1epfTw6DEEdhEdxtFTgG2pa6YqaR/aYN3r4o3iBETDTKnvyRsqfd9jZReWV6
         yRBDfiBcN0JPbZa9GqogRWFvAfKd3IcL3xQyKJtGeYi9Ib4sxtt6n1DNcVuvkG+o/F/w
         V361edo0O/VrFU6kRJsHsYAC8RChGXpmyBI4HC30jfAvDoVgBouGa8nA+WMeJOO4/Fei
         QEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720116552; x=1720721352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCsD6s+u0aExCYRBKpNVR1hOsGWSC9BM3te+aNP96Kc=;
        b=n944hatxFWT9OI3Fo2bFIZFYwrV/YXWUyCoYl756leLv94K5LrBSz0JQ92knvln3hm
         1mKrefQCwvqxsvUuqabRRlD+LQejdYG0UdUuObX3rFcCBHIajz6NaZkwJIm/lIOzXhYm
         yAIYCLjWaRsXDRGhtmNcY7Gbi72YFUUxU7lPRNtYvV0m233XXM4/IzP2SRQsBK/o5XFD
         jDAWOFN6BIDkK4XZECThSZpKyGp7iAiRmlgWx4hsOaWZzeL/t5DWW1AQaQW9Coqkb/Vu
         XmOjE4aw1pGi/Zzj6t263yWVb6L8pIr7fLBjiqNA1Tajx7kJJI5DDEJ4BaOlAPReCeiU
         gn0w==
X-Forwarded-Encrypted: i=1; AJvYcCW+CnBfrlwjhJsmXd8qw9BnAfNkzvGxpGOE2Fa7v96rmzH9YMDVUKsFjtwfNxxlvYeEzjBn2E0EWD2iJEFBbSJHr1cOGaZZMm7dwOu/eMSV2fHey7p9N4DSseE9qN7W82FO9fn6l4wNTfLzF4Dv7AmOJ7uUR3lvqLS1o1YSjIdY5cgx
X-Gm-Message-State: AOJu0Yw7zDmpACF0fROUg/fWDX8fg+ufOpYfLvAYviuEAMPqCGNAzkpi
	ICDBvSSaYdOCo5vvt7dLZKAwDYdh94Nqqn2goKafNg8K1QPwgrYkNuM3fCnbhJAHPNWYtqLbMyZ
	zUuntJOcIucqjcIpTCdsLZI1S7M4=
X-Google-Smtp-Source: AGHT+IH/9UA/m4pjF/4HSNRx8SVcH8Asf6Tf6JEX1guGPE9+2Z/kc5Mga4FYeXUELSP3XjSH+LHnrbrxBno3nFaOGSc=
X-Received: by 2002:a2e:a58a:0:b0:2ec:5fe1:c762 with SMTP id
 38308e7fff4ca-2ee8ee14ecamr17959011fa.46.1720116551800; Thu, 04 Jul 2024
 11:09:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704173227.130491-1-puranjay@kernel.org>
In-Reply-To: <20240704173227.130491-1-puranjay@kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 4 Jul 2024 20:09:00 +0200
Message-ID: <CANk7y0gjBh7F=_woAEs3pQXgCqeX5ojEm3g7=4tyWsc-vmjBfA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] arm64, bpf: Add 12-argument support for bpf trampoline
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 7:33=E2=80=AFPM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
>
> The arm64 bpf JIT currently supports attaching the trampoline to
> functions with <=3D 8 arguments. This is because up to 8 arguments can be
> passed in registers r0-r7. If there are more than 8 arguments then the
> 9th and later arguments are passed on the stack, with SP pointing to the
> first stacked argument. See aapcs64[1] for more details.
>
> Add the support of storing and restoring arguments passed on the stack
> to the arm64 bpf trampoline. This will allow attaching the trampoline to
> functions that take 12 arguments.
>
> [1] https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst#=
parameter-passing
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Please ignore this patch, it doesn't work correctly for tracing_struct self=
test.
Sorry for the noise.

Thanks,
Puranjay

