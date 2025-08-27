Return-Path: <linux-kselftest+bounces-40116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B83B38EBE
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 00:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6467C3C59
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 22:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C569130F935;
	Wed, 27 Aug 2025 22:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9DTQr4i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D402F0693;
	Wed, 27 Aug 2025 22:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756335094; cv=none; b=GlHVvWkzJZ4be45nLwlWoVAFdpuAawnjk9miDvGoGXwQOEZLdw4TGIkISVkVa+5lJqq+Rk1DYWMfJeViczKxLdFWCPbfKKr7e9QhcO6ln+w3dsLISiZwQqAO9qQHM2ihWJuZapucBhw7I66CERW05Qd4NQgmmpJbtxU2IjbqRX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756335094; c=relaxed/simple;
	bh=q+iZaJMI5VC8X6LKlTV7NTHv1Ux31p6/4S9RFnQNftE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXHxo0ea6G3KHHvQxq1T6GFcAXN/OjK3C4RzhMYd/9i6areHzZWYEWrHahSe2gSCyd5X5RZd3+60YM1gpXxDvLg7Gcvd4vsdApPiNluxWq/ZrCPR2NZL44yapb22AYHAsobxsX9F/A5vNBlsXCoENkI55f17q+u2St4Z0Y+hcTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9DTQr4i; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32753ef4e33so298386a91.0;
        Wed, 27 Aug 2025 15:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756335092; x=1756939892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9E2sNlzuy2uLz4gS9frJKufdHd13tdDGNaqeRWyYmtc=;
        b=d9DTQr4ir5jG+J6fdYFIo/XtcX4YCd+jswkXDrbb62jajBmLSI3AB4yMERZBMBkxBR
         g8g9PxUetzKvuzOEwt05H2nF7nb6EvBSaZHrhx1j2GAAIOquhs9Mi3Gy6Ce+lZPDJ0Ea
         gI0y5J74ItG4j5P/TL7cw93GVPgjRSiNW7PoBvu9ZK9890oqA73168H1W6S4kR7GOb8u
         rfcV32cwrZ5zswbBUb1iYNY9OtngUtZIlX/kgH5274fO3ZBXO5uHBb91in1DtTaeKnyA
         /hWLX+yqhpTeBerFXM0Rn+H5qj16aGjzUqxKeoHqhUMfjAm9QPP1X5Lj33zqeaaEMtlY
         U7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756335092; x=1756939892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9E2sNlzuy2uLz4gS9frJKufdHd13tdDGNaqeRWyYmtc=;
        b=LM3OBNff5npx+UFAbk5QovXYJIJFOmS+YiBZyp25vLqmHSvUdxfurUpI3maUSv7CxL
         HWV50H7fFonA/7VY+bjBdsOqerKmfp2CxiJH3sbJn+wB63XeDp3zd6YSM0qztnCApF3V
         AUj/RUgQHGaOE/muvpu2noumAWZ+m8drL4Ido1c/HJaHyMg7lJLb3geb/RgbZuQSZiaI
         XjTB8I2xGhylRb5XsSgeN74YXhGwBqT+S29Q34j8v3Wf1ajdqg6dLtOHWv4aRm5S9ph8
         FfnDW9EEih7yV/jrqi/bsUzRUVmnbcfIOLSGjBttFuSQvQXs/q+joCjUD7hDZ//+a239
         JDtA==
X-Forwarded-Encrypted: i=1; AJvYcCUOFrLwoPPDZq3KddfqZ8VU6EKqkdtKTXL0ZA3abQM8A1ZVA/4CT48jFaqsoArGhaorolc=@vger.kernel.org, AJvYcCUxMpO5RqxMkrC6281/fJqKy5XAmoiaMX1RDFmtVdr6bxez2IlW4uJvhu+M/LxCH+ftZAL3+ZIvdEqQrXsh@vger.kernel.org, AJvYcCVY+WKC/NA3iebYHETckPoxU4abENHrAQmTsd6H0CTLePEZwZE1iDEG75qmjMMkPAlNVuU9p8byK7/E/hdqBG4T@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwgcc9ea2xmRZhj8/25eAOW/Rlbd+XiG4of2FzlhgqniqWLl6h
	2v2j15nlBPBlPnR8D0/ls/wVkmoBZ5edfFEmhC9eJJ7CSko3Q++Xf7KkdNGb7Wo+OXy+jcNYXCg
	jhqDZN9Qz3rvg3Pvqsd2M3hp8gStBavQ=
X-Gm-Gg: ASbGncvlSZA7Ei2DkWHqLyxyDue3CIc6UIy/abjCVrCczFeUUDiZQDLdAG0Jdp+yXqd
	/L8QBqcgiIkx1yvYyUxTWoBRJhwsGEvalf2oAQMZbyGqJVSrzCm0vBEyiWWSscL5ym04MUYwPoa
	bNk358B3os2kPMkJOQcFiWcTONjDLZydSqS0lZ7Ru6APTV+pBQNWu+onGYJSbmcV/1QbrH48AH2
	Op3H1lJU7b15kTOxXeek3TjAgxvMwbkZA==
X-Google-Smtp-Source: AGHT+IE2y1ku4yVQaU2bfw3zNcFhE7DhwRSiHxKM6VzCIj/33jfXgRKfOB1BP3ou1KQiYpb/L/yaw06QRoCNe0OPdzw=
X-Received: by 2002:a17:90a:e190:b0:327:8c05:f89a with SMTP id
 98e67ed59e1d1-3278c06016fmr3345624a91.4.1756335091558; Wed, 27 Aug 2025
 15:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827053128.1301287-1-phoenix500526@163.com> <20250827053128.1301287-3-phoenix500526@163.com>
In-Reply-To: <20250827053128.1301287-3-phoenix500526@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 27 Aug 2025 15:51:16 -0700
X-Gm-Features: Ac12FXxd9p_CvzpYECfVauL-N_T3Roxw7XRzVNeekhYdfy3Y14p6HRnJy9UcWhk
Message-ID: <CAEf4BzawZtJJvnMqDp2E7Z=tr9tFvkfA3+w8m9G3TfhsP8eYhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v16 2/2] selftests/bpf: Enrich subtest_basic_usdt
 case in selftests to cover SIB handling logic
To: Jiawei Zhao <phoenix500526@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yonghong.song@linux.dev, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 10:31=E2=80=AFPM Jiawei Zhao <phoenix500526@163.com=
> wrote:
>
> When using GCC on x86-64 to compile an usdt prog with -O1 or higher
> optimization, the compiler will generate SIB addressing mode for global
> array, e.g. "1@-96(%rbp,%rax,8)".
>
> In this patch:
> - enrich subtest_basic_usdt test case to cover SIB addressing usdt argume=
nt spec
>   handling logic
>
> Signed-off-by: Jiawei Zhao <phoenix500526@163.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/usdt.c | 84 ++++++++++++++++++-
>  tools/testing/selftests/bpf/progs/test_usdt.c | 31 +++++++
>  2 files changed, 113 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testin=
g/selftests/bpf/prog_tests/usdt.c
> index 9057e983cc54..9df2827991c7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@ -25,6 +25,7 @@ unsigned short test_usdt0_semaphore SEC(".probes");
>  unsigned short test_usdt3_semaphore SEC(".probes");
>  unsigned short test_usdt12_semaphore SEC(".probes");
>
> +

next time don't add random empty lines or unrelated formatting changes
(I fixed this up as well while applying)

>  static void __always_inline trigger_func(int x) {
>         long y =3D 42;
>

[...]

