Return-Path: <linux-kselftest+bounces-12832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE77919B5B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 01:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E5F281E74
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 23:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81E9194158;
	Wed, 26 Jun 2024 23:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDS91rAU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4564F173338;
	Wed, 26 Jun 2024 23:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719445330; cv=none; b=LEf/ejqPXVIk3Zl8OVOyEtrjyxKilz7uRwNypMdBtg4e9J4PkLPONMdkz+dc9pphJa0HUbcjU9Cqs8MpzYvHjwNGU1FUF1pnuUnT2OwKLFkXbnYD7XDDObjHiFSOd7GzMq+e42tR0T0/pEMay2gmCI7r+ihzRuXkjRitCd4OmNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719445330; c=relaxed/simple;
	bh=sMeLhiwFv/j1a88YDMUKlL+AXEf7JJBJVtTWqgBJsBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lhemvMIpYfT6Gnp87sd0CI9mwyrMUmiDyNAGwZ6C0HLJyahpQHKhzb5Q8At6iNmFbh5+9hmvVZJTPXJ4j4XujyNAZN7jEy1+GNsUQq54dt5YTO5GjjZ6u2O93rt2i+UTGpXuUo6W090xnXo+ztE8FqmEFxpaJ3udjfrWyHedW9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDS91rAU; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7067272245aso3464305b3a.1;
        Wed, 26 Jun 2024 16:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719445328; x=1720050128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8van3ONhsMj39x+CZK6w7GS9JJmzbBkImHTnPcwvUI=;
        b=TDS91rAUrbHx7G+kUFo73jPXhuDS3JO/tDF5L9HQbry2avZpHb8F0gYdUbX9fepf0T
         OOFKIKx7OkBv+PwM71Wwi2zUNWltwtkdBWNf0MEPdZY+rIXc0TSUT07pRtWdgNWjD5uc
         CFdqp0VnsZNqS8z2q7d+QXC8lebTR4Rc1ghpEF/j7vRmkK+eCFPu3tqjN5866koTMFjg
         vkCak8rOvXRhEsUNN0BFHYqebmupFN17AhcHFGCmggfGd3YknVLBI4aKpLqGaHW+2lLf
         C+5HABQb6IUkbT4W1RwhI0WZ/NUFMc8eCheisXuVt8hkvGVZTvQ8a1UQ8xFXm9Z/JCR1
         BPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719445328; x=1720050128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8van3ONhsMj39x+CZK6w7GS9JJmzbBkImHTnPcwvUI=;
        b=CM177GkgwiqhZmdCnDwuDG93VlW1NAClALzaoZNId0qLfDQvTlN86oR70BOhSu7yYU
         PCZeJODU4M0mXhJhZkwfY18HpheSKXBlpd/XacvMMLilPC+jmyR6FchSUBktPP/pVTcN
         UlQYvtVV9J9nzXSd0jSgmmazWZtm6Yv5VbvvQVtHG7ga7OLguVJcfyUV4kH2AeeNXqkW
         8VU3o4AYaRN7gB8Un1MYC/9uXj6xEZLGkhumJuuLS8TJfDgJnEYt2wXYWmhp51VFpAux
         i4LvEX863+xleUlaGt35I304sN+fPU6hEdEJKQCzlZDd07NYF9lcvXv4PFrheSjk/h0w
         CGJA==
X-Forwarded-Encrypted: i=1; AJvYcCVLciGFgvFmjLx0DSGw0OeM41a+Nd+QpiCGdzhe0/Lsq0NurgKcicIquzIge6s5YfafDVH3Ypqt5VeJjcBNo8l+qYti5CQHi8pqANucOmvROmNTsEqJAmfNO45DWIEkFuUF56YSwF4bD/CrKPq1UNxk4SQHhRMCp0Ab6u4AEycDg+qR
X-Gm-Message-State: AOJu0Ywt8Z2euMGDW/DPHANizN0QfBaCMrd95zKC4/GvusJFhij+J2mX
	af1dkWM1DT/k1kgh1w63shaUJGSdbA6eeSGvQKQaMHZCXrOFWjBeI6jdjWbxDeIfdE6kvcog6VD
	L/0IrZEDQvR1QWxO4TPP599c1smfiYg==
X-Google-Smtp-Source: AGHT+IFzbQjuLKsUJ+jLS+EMYdJEh0LApRPYjHXhLeR3ZZ2Z87WNrYOcTLB/RrmDqo+olpA5R7fWtcofOW8HuqgWYh8=
X-Received: by 2002:a05:6a21:19b:b0:1b5:be9e:42fc with SMTP id
 adf61e73a8af0-1bcf7ecaad1mr12478728637.32.1719445328466; Wed, 26 Jun 2024
 16:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626121828.2859797-1-make24@iscas.ac.cn>
In-Reply-To: <20240626121828.2859797-1-make24@iscas.ac.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 26 Jun 2024 16:41:56 -0700
Message-ID: <CAEf4BzZ555XPu=E6c-10ShgZ9UscHq+4Ub8S12Bz7FTioHu=wA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: improve file descriptor closure handling
To: Ma Ke <make24@iscas.ac.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, 
	shuah@kernel.org, iii@linux.ibm.com, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 5:19=E2=80=AFAM Ma Ke <make24@iscas.ac.cn> wrote:
>
> serial_test_fexit_stress() has a non-robust handling of file descriptor
> closure. If an error occurs, the function may exit without closing open
> file descriptors, potentially causing resource leaks.
>
> Fix the issue by closing file descriptors in reverse order and starting
> from the last opened. Ensure proper closure even if an error occurs early=
.
>
> Fixes: 8fb9fb2f1728 ("selftests/bpf: Query BPF_MAX_TRAMP_LINKS using BTF"=
)
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  tools/testing/selftests/bpf/prog_tests/fexit_stress.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>

there is no need for this change, I've applied your previous patch but
adjusted > 0 checks, see my comment there. That should be enough.

> diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c b/tool=
s/testing/selftests/bpf/prog_tests/fexit_stress.c
> index 596536def43d..b1980bd61583 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
> @@ -49,11 +49,14 @@ void serial_test_fexit_stress(void)
>         ASSERT_OK(err, "bpf_prog_test_run_opts");
>
>  out:
> -       for (i =3D 0; i < bpf_max_tramp_links; i++) {
> +       if (i >=3D bpf_max_tramp_links)
> +               i =3D bpf_max_tramp_links - 1;
> +       while (i >=3D 0) {
>                 if (link_fd[i])
>                         close(link_fd[i]);
>                 if (fexit_fd[i])
>                         close(fexit_fd[i]);
> +               i--;
>         }
>         free(fd);
>  }
> --
> 2.25.1
>

