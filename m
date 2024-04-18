Return-Path: <linux-kselftest+bounces-8293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D348A9187
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 05:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B91B21E73
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 03:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7CD4F896;
	Thu, 18 Apr 2024 03:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhrUr3wQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7935244;
	Thu, 18 Apr 2024 03:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713410734; cv=none; b=bXasLddcOOLJ1ZnmXrVs9pMOgG5Wr7E6Dw43sqdM8WuDm7HKGC/IXytciqnQj4k3IuStlRrHAhwJomOag5fBs6Mso7r/HjpijwGap+XJlCcIJxgEuX/WERFYMT3/1IEMW3k+E0rfuEX77zIf60bbBpZte0FebFWhSo6P4aoQd3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713410734; c=relaxed/simple;
	bh=rxKsOCKe0DAcEdcR0ylfZC8wvWu25zLu+9a6x1ho/mM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4+vUr175AGLpnrrvtVLD8JJkv++vaeE87bI+Atbb6tj8tsJxjiMth0POC2idwn3SRByVenrjOaZQHHfm+DqHKjqb57Gz5e5potqrIBdxNyQhNkwGfPJO4cRotQn6gg0UD1XRpGXplAVG80qisT4NHnRY5YNPOMFthrTunSwBQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhrUr3wQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2CDC4AF07;
	Thu, 18 Apr 2024 03:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713410733;
	bh=rxKsOCKe0DAcEdcR0ylfZC8wvWu25zLu+9a6x1ho/mM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IhrUr3wQdS7pMOqL38LvOm8p0MZNEvn6fOcHj2wfhmP+73+5LLudV1Lgnfamja9Y6
	 sRl3cvEx4+efmsi6OoN6IQjmIVywTvetkiMpSK/kppc0rcmLoQirUiGUNuRp5zaDZ2
	 LjJ4fHwEigd6MH+yOWiy4vP0aMpf8qmvO6JPDKtnG9dlwK1a1r0jYllWkLv2Q22jj/
	 3qtmgPDWL0OloTxzL4fcSRTYW7nhY00gB6uFDeGTbOUItxehk8YdogbK0ZWu5vtDn9
	 DY0o74obhDlmX7PpkTQP2qmin9R4/WNa2pfOLif9mG5R57uVTPils9I/cDFnsNeX8J
	 68kk/Rkf0r9LA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516cdb21b34so410129e87.1;
        Wed, 17 Apr 2024 20:25:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVs4+6ZxYTa7WihoPdbf64NIZhJrHZcxf8fIddCPb84mFIjd5lK3YvBo2lXXj+YYaS/g/eZ/2hG1yqqjQOBSB5GVS/krVCzA3T9y5uJDs0LHx53j3H/bnPQA0R+j/QWA20kOPk9rZvzE7Y7lXX/z7iM1gLZ8zHP0SN0G/vTHCgrpzkx
X-Gm-Message-State: AOJu0Yznro36Xf84n9BQhJjXaL5xOAOnnR1/fWP8UFSU+36xh5s5u1XQ
	TFReJ8HriQT6tH9uoOQA10Bjb6PBhIZBc30ZP/1BB2rW8GI9RvQ/9aKXg6LGzozM9Sgju4VjIuC
	QEmrbYijPM+e+qzVAoTH6cQdUbYU=
X-Google-Smtp-Source: AGHT+IGUtpS9rTXmlBW6njK75ylM7y5nn/N0myZPB1e1PWVQP7ROCNH19qp8oV8CHQjg2tUP6qEN1GWUJ/J9UvLa6d8=
X-Received: by 2002:a19:771d:0:b0:518:8e3c:4647 with SMTP id
 s29-20020a19771d000000b005188e3c4647mr624875lfc.7.1713410732054; Wed, 17 Apr
 2024 20:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org> <20240416-bpf_wq-v1-16-c9e66092f842@kernel.org>
In-Reply-To: <20240416-bpf_wq-v1-16-c9e66092f842@kernel.org>
From: Song Liu <song@kernel.org>
Date: Wed, 17 Apr 2024 20:25:20 -0700
X-Gmail-Original-Message-ID: <CAPhsuW46OYRj2TrqSeD4bPTN3bxbpj7DaFJnc3g0a--Gkjj2AQ@mail.gmail.com>
Message-ID: <CAPhsuW46OYRj2TrqSeD4bPTN3bxbpj7DaFJnc3g0a--Gkjj2AQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 16/18] selftests/bpf: add checks for bpf_wq_set_callback()
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 7:11=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
[...]

> +SEC("?tc")
> +__log_level(2)
> +__failure
> +/* check that the first argument of bpf_wq_set_callback()
> + * is a correct bpf_wq pointer.
> + */
> +__msg("mark_precise: frame0: regs=3Dr1 stack=3D before")

This line and some other "mark_precise" lines are causing issues for
test_progs-no_alu32 in the CI. I can reproduce it in my local tests.

I am not quite sure what is the best fix. Maybe we can just
remove it.

Thanks,
Song

> +__msg(": (85) call bpf_wq_set_callback_impl#") /* anchor message */
> +__msg("off 1 doesn't point to 'struct bpf_wq' that is at 0")
> +long test_wrong_wq_pointer_offset(void *ctx)
> +{
> +       int key =3D 0;
> +       struct bpf_wq *wq;
> +
> +       wq =3D bpf_map_lookup_elem(&array, &key);
> +       if (!wq)
> +               return 1;
> +
> +       if (bpf_wq_init(wq, &array, 0))
> +               return 2;
> +
> +       if (bpf_wq_set_callback((void *)wq + 1, wq_cb_sleepable, 0))
> +               return 3;
> +
> +       return -22;
> +}
>
> --
> 2.44.0
>

