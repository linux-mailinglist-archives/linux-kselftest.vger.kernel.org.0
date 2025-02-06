Return-Path: <linux-kselftest+bounces-25873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B3AA29E0D
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 01:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEBA31888EB5
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 00:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6805C1C68F;
	Thu,  6 Feb 2025 00:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jL23Zbz5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD823B1A4;
	Thu,  6 Feb 2025 00:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738803069; cv=none; b=RDDmuhn26e3U7MadqBN7Q1ryWamtsEXt8uiSVHO130QMiaoFNGMdF/VW4QkoeZNihBigAS51AdAkFtxAUAGrXiZomm/rHXKQgWOYDLjYWZDwhupmAAuzswUqEW/i/64zzs5QRFwSpCyLOwrjQM4J74kiWGPZq07hytH9am/6xhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738803069; c=relaxed/simple;
	bh=0iL3E4VG0qImG8S0CCPnqbyKDS9qsWKgPru9TE81B6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2ZufH+FTvdNYbzRfiqibWPS4+Yvn7vAR1t9SpUczDvIPdXHaAhZKsagKPwcfJoZcTFAOUa+3XC5ws7oWcqO393vOBxApSxHbwB0qS5lWcejAAylgES0C51oXPsRF4NOZ9QLnt5C0PY8ZILdYqKOHvXcWL4YxxObWbq2Y67b+Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jL23Zbz5; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f83a8afcbbso503826a91.1;
        Wed, 05 Feb 2025 16:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738803067; x=1739407867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4/keD5s03/Kq1V0kQTivHig4tZxw6U4TktrhJfP4+g=;
        b=jL23Zbz5vb3Dzf7Raug8n3PPBu1N4Ow55KL4xtKbOt2sVfvI4+xaC9rp5ufi2j57oF
         li631kwCwjVV7XpElpSYTjiLmfMAk4laRzlooPyp35G9Urzds6LnQ8wHhGpWSUx5zGqI
         YNMc2RFre7o6dbqsSV+uhLfP6ti6BdOqTN2H3QXTJWdIA5oLR0EzrC6+JslMSTEv4ajx
         7rggDhXUmKUPAf+cjRYeyDjPKzfS7ZxSdnrL65vwlxxbqu3YHyqsezHQf5Zqn7mJaKVk
         mYjU3iRZLoz+Vf5m5STyep4rv65vjHA6yi5IHjDvr2xUOr87c33UCaQRXqACMF9sDxp5
         CO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738803067; x=1739407867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4/keD5s03/Kq1V0kQTivHig4tZxw6U4TktrhJfP4+g=;
        b=hgkQJZGOX3Tk4pCEb5H0yOhvCaMCM4z+dTjpUSPiI2qXbDIQzSa8wHgTEu4vvxRH+E
         F2C2GXhUiaEaWtv+WgmBpL5J7cWTsUlv8Ppx0DDLndIJtUfKq289+vkdhFlGyytzWB5o
         yhzEUFPAErE/XlfnS6BLr/O5ip27hMWocotlBOy38S25M5qBk+WFPjHI7N8TxemWQOcC
         l8qxV+IbfKpJFPGJn1Ix8s/u6v4IaEAq5BO7a9FGpxWZGKAShS9MIeOBz7KT1wc18lUd
         Hm9XAE4qp3N80uMlgUXv6W9I872ZHjTcKC5dR8bMtM8xzb+Yew79WgBmKuBQbCQ9VQQ6
         nOgw==
X-Forwarded-Encrypted: i=1; AJvYcCUUs92JX3vd81V5JWzuqoxqkJ3yFGON7NLBcCCMyJT7WWrtWdK/UgDiMkncZyV1SnalBVv0CqoKLijoHQEC@vger.kernel.org, AJvYcCUc5vDrMDdir5oDcGqlVs7VPlw8sK0dUIAxFplOSSz3JFyE7f8NspSIzlMCHxmYeM/mCCJeq3qKa4Wlgq5jy7kY@vger.kernel.org, AJvYcCXppAoY4DBEP15Qn9Yulm3gVfx3ZOe8sz3C1/eXy0URwPcnITj4bXp3r1KOhs+w1u0pW58=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNSWUGGTm/AQ4ebaQZFH0C8oKqvZ2RAK1A7YC5tAVhhNZYGjwb
	EOOBAtj+itis/6aKh68/2I20GPUoEo2StLJ9KbkwleVdMa4g8zTneEKymgf1PFktudP+Xlr5rgt
	wVTVXDvS1ScbaNAstfHuOLIfPOmg=
X-Gm-Gg: ASbGncsjKb9jDdfQrakpVwmKDXTBUogkjoQFzYySExqP0T37NY26U2FJE9g4RPxkC2y
	X5aPE2esqjx6TajLLTHaBVOhsxT8UyW8oEAZGPEmq8bsBYJdlbFQfd+PisniFFbv9hn0SSacd6a
	Sg8wDD/yW94bRf
X-Google-Smtp-Source: AGHT+IEM4edWMzxCplFBh9oI0xtCLtQLZ0y5dDP0e13Ujh/dgE6X3ojtv5NwWVk+GEEYMJadgwFWheoCJuIN3yavqGM=
X-Received: by 2002:a17:90b:3b41:b0:2f7:4c7a:b5f with SMTP id
 98e67ed59e1d1-2f9ff786427mr2440811a91.2.1738803066751; Wed, 05 Feb 2025
 16:51:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <872b64e93de9a6cd6a7a10e6a5c5e7893704f743.1738276344.git.dxu@dxuuu.xyz>
In-Reply-To: <872b64e93de9a6cd6a7a10e6a5c5e7893704f743.1738276344.git.dxu@dxuuu.xyz>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Feb 2025 16:50:52 -0800
X-Gm-Features: AWEUYZlmr6_GyGpRgTJA_Eakh3HYUq6e5lgl1acOQWCLsgKBEHoiIcewOpigSbQ
Message-ID: <CAEf4BzbHQ6WajDTAWHmjvA2FaAQz37sd8RwFY9ysKK7D+uc_=A@mail.gmail.com>
Subject: Re: [PATCH] selftests: bpf: Support dynamic linking LLVM if static
 not available
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: shuah@kernel.org, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	nathan@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	mykolal@fb.com, ndesaulniers@google.com, morbo@google.com, 
	justinstitt@google.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 2:34=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Since 67ab80a01886 ("selftests/bpf: Prefer static linking for LLVM
> libraries"), only statically linking test_progs is supported. However,
> some distros only provide a dynamically linkable LLVM.
>
> This commit adds a fallback for dynamically linking LLVM if static
> linking is not available. If both options are available, static linking
> is chosen.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  tools/testing/selftests/bpf/Makefile | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>

Note, we expect [PATCH bpf-next] as subject prefix and "selftests/bpf:
" prefix for BPF selftest-related patches. Please help with
consistency. I fixed it up while applying.

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 6722080b2107..da514030a153 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -184,9 +184,14 @@ ifeq ($(feature-llvm),1)
>    LLVM_CONFIG_LIB_COMPONENTS :=3D mcdisassembler all-targets
>    # both llvm-config and lib.mk add -D_GNU_SOURCE, which ends up as conf=
lict
>    LLVM_CFLAGS  +=3D $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) --=
cflags))
> -  LLVM_LDLIBS  +=3D $(shell $(LLVM_CONFIG) --link-static --libs $(LLVM_C=
ONFIG_LIB_COMPONENTS))
> -  LLVM_LDLIBS  +=3D $(shell $(LLVM_CONFIG) --link-static --system-libs $=
(LLVM_CONFIG_LIB_COMPONENTS))
> -  LLVM_LDLIBS  +=3D -lstdc++
> +  # Prefer linking statically if it's available, otherwise fallback to s=
hared
> +  ifeq ($(shell $(LLVM_CONFIG) --link-static --libs &> /dev/null && echo=
 static),static)
> +    LLVM_LDLIBS  +=3D $(shell $(LLVM_CONFIG) --link-static --libs $(LLVM=
_CONFIG_LIB_COMPONENTS))
> +    LLVM_LDLIBS  +=3D $(shell $(LLVM_CONFIG) --link-static --system-libs=
 $(LLVM_CONFIG_LIB_COMPONENTS))
> +    LLVM_LDLIBS  +=3D -lstdc++
> +  else
> +    LLVM_LDLIBS  +=3D $(shell $(LLVM_CONFIG) --link-shared --libs $(LLVM=
_CONFIG_LIB_COMPONENTS))
> +  endif
>    LLVM_LDFLAGS +=3D $(shell $(LLVM_CONFIG) --ldflags)
>  endif
>
> --
> 2.47.1
>

