Return-Path: <linux-kselftest+bounces-20826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2599B3655
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 17:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D0F1C22151
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 16:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F51188CCA;
	Mon, 28 Oct 2024 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpjgtP9a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000085B05E;
	Mon, 28 Oct 2024 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730132411; cv=none; b=CSWymggDn3m7xndxtyAnoBhy7pyOecJCE5BD/aBX4d1xKe8o5O8E6jVaqKNcxvdQsCTNC7WEiZDDAhVQmfFcGJu6cJTQEumm96wmtAHxtrH98SV1AAWwES31VZr6Lbe4DCtERo4IgvygII6n4Hx4padBXxkWkoYYCgRH2lz2LDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730132411; c=relaxed/simple;
	bh=fcGWPQbwayYHtwrqBcQotCKmoRjAKuPT7oqen5Hr+GY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3xDXzu7wXbrLVuPiaM71pMBuLiicPvD6g27askp8H6VSy3XwLBKMSMzSRik+s05uD42mAmwUAmBbSlVTHgUbXPNizLpCP0aITTIKX3KUdYfzXy/zrlyJLR+Bg6uMg9mzeJTQdJDHTB5OIN/FoMiQ6L+NRoeD1VAmxpq+ApwMSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpjgtP9a; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e5130832aso3133427b3a.0;
        Mon, 28 Oct 2024 09:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730132409; x=1730737209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUV2L7pA1QR3rAE8ezbf/kHutnV6iucGzEMlRpqIK8U=;
        b=KpjgtP9a7b1rH5ELFkSxx4nSi5Ecp0rtyoE506B6z9A1x5KUAxkZG8JzGfyYg0huNw
         yJbWZFnDZXuIGH9x3/bAE300Luk0AG6FIZrFcRILD0OTmqWZ1c9KKbhNB402FEDkF+6b
         J0UfBVa81NiJ+qP3xHHqjzKTMYnWpDQua2Uu7Dw/VBiivZV7TeEoAfiEY72KloDan627
         JhTTSVHZsHAyeqCZdOWHqy94XVM6xG+gRo3T+Sn7pSuKkNniJZXHlmzDI62IGdcwk4Hb
         d69rMn81Hm0RdkmE0Jx7cuETpWVABuY6ZEp89ICjW/o95OuUCLCes+FH1EG9lN0yuvpZ
         IVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730132409; x=1730737209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUV2L7pA1QR3rAE8ezbf/kHutnV6iucGzEMlRpqIK8U=;
        b=CmcIQ8hKDPqgDj2vKf8tw11F8sIsqn9lF2/V1U0qUHHpW02z9zqAgojfhP4EcM9lfI
         Pbo9ljag+bxs/G46km2uCpgkSa9f+iV2B4fablhFQwVXK5LcheCuAJVNQVJGRJSAx1i+
         0EbwGLcDQzb4ozmnUGAt6XPdNHkM29umu9ied2l2PbbPXvq9+2VDsO0e2wi+TuY4KHkQ
         uESelCP0B5OkSVVfkifJQL5hN9/zjI6o0N1VRwjgybUDXlwr2daYnYtLVHBcIs6PIMmv
         KExmMbHuuSpaxpDxb2nx2sC98j8UX1PxZlXUEb9IJGgMzW/gN0fsiub7Emst7aUgkGqM
         YzFg==
X-Forwarded-Encrypted: i=1; AJvYcCX1VUiOw8q7DOVpEq08li0MAOMlF4CV1/GmMWWeGjBxb/4qrxq3PcEKRoCHkHVGHh/V160=@vger.kernel.org, AJvYcCX6FnD4VRRdwWyXH+6QIAP5AOD37OGN/nPrz9x0D7Xyf1Pi2v1Iqnk4xmEgaYEKW1ggzrY8XGJX131QSxyeinoT@vger.kernel.org
X-Gm-Message-State: AOJu0YwJAmpPStTaNu7xFLWH+jqqoH2zh5MgAPk41a4d6K520V9gHZ6q
	xlQyP+P8ujsywPOZ51JmzHXl/wJJJ3SqpB/hjK3T6JX2RpmjPYcxTe9jSG3UJn/K7tfRFRfXmvc
	CO6JevDrXrSX7Od8F7UNCBFrzl54=
X-Google-Smtp-Source: AGHT+IHkfV0oslQxcKv+c9NWVWvCo3tZ+UMZPjyoAGZiHl4EENglXHmADnfBxVEaLVVVj7ooXMEXTSFhJJZ12vbSd3w=
X-Received: by 2002:a05:6a00:989:b0:71e:f14:869c with SMTP id
 d2e1a72fcca58-72062f4bd84mr12150971b3a.6.1730132409029; Mon, 28 Oct 2024
 09:20:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028034143.14675-1-kerneljasonxing@gmail.com>
In-Reply-To: <20241028034143.14675-1-kerneljasonxing@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 28 Oct 2024 09:19:56 -0700
Message-ID: <CAEf4BzYsTPTOMWyNcA1zRmOUhko9KYhWT8VNabZwz4S9_79_eA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: handle implicit declaration of function
 gettid in bpf_iter.c
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	mykolal@fb.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2024 at 8:41=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> As we can see from the title, when I compiled the selftests/bpf, I
> saw the error:
> implicit declaration of function =E2=80=98gettid=E2=80=99 ; did you mean =
=E2=80=98getgid=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>   skel->bss->tid =3D gettid();
>                    ^~~~~~
>                    getgid
>
> Adding a define to fix it (referring to
> tools/perf/tests/shell/coresight/thread_loop/thread_loop.c file.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c
> index f0a3a9c18e9e..a105759f3dcf 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -34,6 +34,8 @@
>  #include "bpf_iter_ksym.skel.h"
>  #include "bpf_iter_sockmap.skel.h"
>
> +#define gettid() syscall(SYS_gettid)
> +

We just call syscall(SYS_gettid) directly in all other tests, so let's
do just that?

pw-bot: cr

>  static void test_btf_id_or_null(void)
>  {
>         struct bpf_iter_test_kern3 *skel;
> --
> 2.37.3
>

