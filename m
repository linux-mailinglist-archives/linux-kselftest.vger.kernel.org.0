Return-Path: <linux-kselftest+bounces-34539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD52AD2D4F
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 07:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8E43A6293
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 05:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957BD25EF94;
	Tue, 10 Jun 2025 05:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDlm2AoN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2075380;
	Tue, 10 Jun 2025 05:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749533507; cv=none; b=uANIAN/pvSpYKn8pYTeFap3Uy0RNhPnV5UPNQuchKGYPgMUgFuAKuXgu3afX2+P17uCwpFhVed19fgiZ8tTlcJ+5iYswg/snFs6CqMUAA6BW8wnsw6j9ovUG3duZPraArc8p21N5vqC0+pxyxCz1KXqIjfzHH0WHRVViGzC+asY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749533507; c=relaxed/simple;
	bh=BwUvV9resS0KVNH2HRLp2myVkNYOXjscA41YiBvlfa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=giF9hqC2TUnkbdrbPb1sCoEQTaNAguffuPWvyx1fr3hvbQBJUC4f3dUOmUSlPHySzGmQ7ABo8tHchQgnZdVlcenoLbpYhdfwtSVqE2d2ee6MMatDJVXTRGR1w2FixnsOduP7wiuuYXZpmdbAEJWH2IoJvpEHtt0UVlIqk09uW2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDlm2AoN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4531e146a24so1770675e9.0;
        Mon, 09 Jun 2025 22:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749533503; x=1750138303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6NSSSUaPkJ2Knx1I9AqaaAXzKIj7ARZfjyL5txYCRc=;
        b=IDlm2AoNYX9iUVO+yMlshSe05roLf4m3/vmDTK+g48BB/8PfFjm7d0pLgavVEGgMeO
         HNkegqkeF3PZDClunoO8dhh6AE/bAfjz3L2JljwrtC8zNq2b2LUW4sD8lV3XMwz+35sb
         ODMeriMUMkK1wa6do8wvv/BOqkbmOSmCOrouToPSFdYMVmMoWS2ioUP4fY4JA74FL422
         n3ccG9hKS5l+gOCVB74wMnyFdCbkBG4ArShwRUOrrB+kA2ZIE4xNBKtospiZmj+mCD8O
         2vs3/n3/7st0TjOkMxbzHAUd4L7QJV2jvCBFHD+FSkNkI25LeHqyIMkvWvaMYkmw0nNY
         KrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749533503; x=1750138303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6NSSSUaPkJ2Knx1I9AqaaAXzKIj7ARZfjyL5txYCRc=;
        b=SOnpPxddws6xMsmH9dtsk+8Qb5tQ2NGqxk7D145C/0QBNzNtjymx/RwEJdhos+b68v
         iAeabQTF6WOWB/eNSP4rmui4/pDx8V3wXvDQRI9FvwlkZa09pgEVSq4xqp2eDgxcUTWA
         pEjnG/33FM6fPzb5KSape/CUWXRTS+TWKcPRrDL8y2C7XiDrWQDeZ6qbPU2MeDKcL/7M
         T5L4ch9q2DlRLeJt1ghRl5MB9NLXWucKbkC6qo0xhErGgsvoy18n+fC7rHoKP5Cp+E9J
         RFx2zU/YEdl6ij0/C7IFd4Q4eGlm5Ho2BNSEw+MY0+Bux8FOXYi4C0GShZjX+p4KFtdL
         DnRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/Gcu1fEyjnEFUL4C/WlNeEclpvrHmF4YEj4eP2GkjGfSs6xeEbyMDDgvh5vGqP5oxWe2Hy/wnAJQUbvdT@vger.kernel.org, AJvYcCWq6P2Vnp/rv2qbXsuo7Jmj+9rieUmRkx6+sY0aVIBPUUykwSK2XULuh7i29/ddyLAACdo=@vger.kernel.org, AJvYcCXE/MMYd7Ojtbm+2vO2ecN03xCo9dVvMnATbmFH2xNQnHnMN9sVBXnL6c6eazVkrarXlQfIHdyF1QTIWneFcSgN@vger.kernel.org
X-Gm-Message-State: AOJu0YyMsQgAXXc2JCRVyaKoGDIQBJgRHc7eGO7GT0q9GdUGfg7enVko
	cAHVDVA+VmJEvA+hW06exo6FxcKQIKqb+39HSE+Mcd0fMHlqDf+kigPs0wXaKhoqraCFLL3dCsa
	7CHVwNAIDuB54MDHNJpS0f9mOGj3D4q0=
X-Gm-Gg: ASbGncuEWmOQlTLaWWiaeGOv7a77cUPiRjA7mrxwRtHrR2801HLwSLF2YO+vcYTnXOA
	6ue1tSTRV89SqgLwc0loQ/odN+ikYJU/ey4R4+srUX9X/wdwzBHKyWx24Ix16cUM8QYKW9ZpPj2
	8QDInChK+5RZ0x9+asxqJHX9I+4ZDW8IU6R0994ev/EDCv+hAhVKBudOC8gnJvjTqdxUCFfhZM
X-Google-Smtp-Source: AGHT+IGnCeVQwIATlfQCLPScvjR4zfSPZh3YpkxJkw/tAxQe10VCPdtaHGA0BCwCT9Hg5US8pQ1ILNVZfG578sV+3Yo=
X-Received: by 2002:a05:600c:34d2:b0:441:d4e8:76c6 with SMTP id
 5b1f17b1804b1-4531de9f85amr9648765e9.30.1749533502763; Mon, 09 Jun 2025
 22:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603205800.334980-1-luis.gerhorst@fau.de> <20250603213232.339242-1-luis.gerhorst@fau.de>
In-Reply-To: <20250603213232.339242-1-luis.gerhorst@fau.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Jun 2025 22:31:31 -0700
X-Gm-Features: AX0GCFu_O3ZRZr-RlnDuwnEJp2OCNNw_nXP9ivn8MSmq6jESTI3dBrI5bUO4Iuo
Message-ID: <CAADnVQLC_zViaCs5Huu63Jr2oCx1NGY3f_VCkJhrKvqst7HL=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 9/9] bpf: Fall back to nospec for sanitization-failures
To: Luis Gerhorst <luis.gerhorst@fau.de>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Henriette Herzog <henriette.herzog@rub.de>, Saket Kumar Bhaskar <skb99@linux.ibm.com>, 
	Cupertino Miranda <cupertino.miranda@oracle.com>, Jiayuan Chen <mrpre@163.com>, 
	Matan Shachnai <m.shachnai@gmail.com>, Dimitar Kanaliev <dimitar.kanaliev@siteground.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Daniel Xu <dxu@dxuuu.xyz>, bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	ppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Maximilian Ott <ott@cs.fau.de>, Milan Stephan <milan.stephan@fau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 2:32=E2=80=AFPM Luis Gerhorst <luis.gerhorst@fau.de>=
 wrote:
>
> ALU sanitization was introduced to ensure that a subsequent ptr access
> can never go OOB, even under speculation. This is required because we
> currently allow speculative scalar confusion. Spec. scalar confusion is
> possible because Spectre v4 sanitization only adds a nospec after
> critical stores (e.g., scalar overwritten with a pointer).
>
> If we add a nospec before the ALU op, none of the operands can be
> subject to scalar confusion. As an ADD/SUB can not introduce scalar
> confusion itself, the result will also not be subject to scalar
> confusion. Therefore, the subsequent ptr access is always safe.
>
> We directly fall back to nospec for the sanitization errors
> REASON_BOUNDS, _TYPE, _PATHS, and _LIMIT, even if we are not on a
> speculative path.
>
> For REASON_STACK, we return the error -ENOMEM directly now. Previously,
> sanitize_err() returned -EACCES for this case but we change it to
> -ENOMEM because doing so prevents do_check() from falling back to a
> nospec if we are on a speculative path. This would not be a serious
> issue (the verifier would probably run into the -ENOMEM again shortly on
> the next non-speculative path and still abort verification), but -ENOMEM
> is more fitting here anyway. An alternative would be -EFAULT, which is
> also returned for some of the other cases where push_stack() fails, but
> this is more frequently used for verifier-internal bugs.
>
> Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Acked-by: Henriette Herzog <henriette.herzog@rub.de>
> Cc: Maximilian Ott <ott@cs.fau.de>
> Cc: Milan Stephan <milan.stephan@fau.de>
> ---
>  kernel/bpf/verifier.c                         | 89 ++++++-----------
>  .../selftests/bpf/progs/verifier_bounds.c     |  5 +-
>  .../bpf/progs/verifier_bounds_deduction.c     | 45 ++++++---
>  .../selftests/bpf/progs/verifier_map_ptr.c    | 20 +++-
>  .../bpf/progs/verifier_value_ptr_arith.c      | 97 ++++++++++++++++---
>  5 files changed, 160 insertions(+), 96 deletions(-)

I applied the first 8, but this patch had odd merge conflicts
and I didn't want to risk it. Please rebase.

