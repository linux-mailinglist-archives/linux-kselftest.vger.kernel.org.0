Return-Path: <linux-kselftest+bounces-40254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C140B3B3EB
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 09:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A8DA02CC8
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 07:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE36F26A0C6;
	Fri, 29 Aug 2025 07:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llzdcQ4V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B67269CF0;
	Fri, 29 Aug 2025 07:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756451399; cv=none; b=A5pWKLDmwI9VuJJZqpPHRsnM4OqE6QtcHmxj+oKE8Mc6+JMts0pYCly63OGyEjBoIdzqHQUwEF7Tp0vo3DB7JpuEpvcYwZHpBvOW3TMs/cMgbbxc7mgxh99RtL7G2t74QgoUQxLei4iQ/34e5mVkLn4+LOLA1DHi1lOek+yjFcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756451399; c=relaxed/simple;
	bh=HYx+Zk1058/5oto7OfyHPENrkH+C8WmQWhdcII+vzYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5mqL23m+HeFHFnsetppi+oZpj8YWyW2DMfIPgX6AUk2YeUIIK3twr4qLphOLM0reDcVUz3VNArwBQLgQr1KRo4irsTPlEDimarfHUV9c8KLi8+4X3H59hh8DR7vfek0wx9j+8E10trK0XWQwgS411bpqaFVmO4BfRVmR4Czt1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llzdcQ4V; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-70df4418f98so14491936d6.0;
        Fri, 29 Aug 2025 00:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756451396; x=1757056196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUkGjldN+EofC9u85s21ovIaAl+rkgsc6ddh+BEGdNE=;
        b=llzdcQ4VVCtyvwmL4p5V9W+1Y/Od/PjF1yjJGcHrad0gng/UQ/t67Cyv6OIJF9OnpC
         7MDWh/NGcBXbXkSWh/z05rR7OUK3LwA1iwqN3b35zd7AnEdEo3zdG1VFojmSIVJv8vV4
         VkMF7i6ISpxQKSN62X0AT088+eKr3khL5JYgDhmaOUhxNR86xGc7DvZxET15LOpbbt6H
         EZsHYtKY+gXbgkIxX7HzkPq4Z35K4jUg/XSTh2AdGJLJ/1HiGiAtnRdb0faBNZRMXcfp
         i/v8mocpphQft0mLZgepY0O0+s3H13Hg7ZycY5OulvIbPZlOCmqpte3mFNbpe0xlAmZl
         6vAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756451396; x=1757056196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUkGjldN+EofC9u85s21ovIaAl+rkgsc6ddh+BEGdNE=;
        b=c6N+ZoR2QEPWG1QMiqU8i5a/b4ueYlngTAH1fcrYUGcim5nSRRxP77Pm0q958NIGch
         bYW4JyC+KX4gE9GfTO0c7BpsD33l1c7N4KL16RcAoBuMw1TgNUgX7XOd3qjNza+OGLDL
         4GVRuZwMjov5mZfXu+3VlU8ihPfUngsm0349eQMjgZ06TzCZg5B5s7AmW63pIqAbUks0
         LwA5HpWphkSoWPinSgBlb/MigcI81+PQlHkA3OTqHqfmn0ZaYEyCz8YcS6IQ7XmTEB26
         NtYmJhEEbD85NysfGXy/8YwpPwd5WyHRBMy+YmtKiQvUZe/yPQlkhtpMO24bmonVuhOc
         hY6g==
X-Forwarded-Encrypted: i=1; AJvYcCUZgQf3LXunsOLEbdzFdjCC67bjkecr6eK3MwVpFxnPkQguQH9pwhYe+vIj4gp3t0RRXS46OMYAWrBCrgdUSwXu@vger.kernel.org, AJvYcCVKWbCaEDV38u0MkHSKCqA5kA9vOdozVUzU+MWE8QMHZPaS2k3hMvBGr+liLBP7Dz5o/K7kVXg81iM3/yx1@vger.kernel.org, AJvYcCW6TunD66jps4qjUPejqnDVLsS2AkTqhRRw08lmCwGqHj9uTTGoQDDssm08iSHZE/AgYhI=@vger.kernel.org, AJvYcCXljjtHyV6EEgXmeMkNowD8dvc7fQVvTKUeULWP/wmoMJ3WhXTcPs8joxpG0Eld5Ievq+SE1sDw@vger.kernel.org
X-Gm-Message-State: AOJu0YwIiRuJyOclgV4oehTFIwhv7W3LZy+/La6bxoLvwaKg57B0/4Uo
	2PIIqPruILPWJc3KNz1trlzzWLOuPcWyAsli9nSMkopDp72aw5UAqwiKkQuL0aDD99Z4s14P7e7
	5IhboboZAWMoK82QXNphHdlHFEGaaD5Q=
X-Gm-Gg: ASbGnctIPOdlsUZny8f0Fni5GiOYuFCBufgNuInqsidKCC5u32XtF9KhxiRYqPLtanW
	zFKQr6whBwNclAF14ZDxEBPKaygn0mB6w+Cc9+6pS+NpfZta4ZYAvYo7DU4LSUHtjAfbAkWIF+h
	8jryKGku73ObEjXzyg5HaPgtjksBOeYwMwRVyzGCPHUtSzZo+QKNESahHW1TOavp2zQPEXGXMl+
	qMh6KO8kPaOlOkBvw==
X-Google-Smtp-Source: AGHT+IFxcKRG9r7dVp8KIPkGJJPtopwmLGupqW0RCrwq8dUceOmP7gOI7OSsPxXhCfqC1dH93npJoNvblBEIevYMKyU=
X-Received: by 2002:a05:6214:765:b0:70d:9d01:d7f3 with SMTP id
 6a1803df08f44-70dd59c0dbamr151992376d6.32.1756451395820; Fri, 29 Aug 2025
 00:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-selftests-bpf-test_xsk_ret-v1-1-e6656c01f397@suse.com>
In-Reply-To: <20250828-selftests-bpf-test_xsk_ret-v1-1-e6656c01f397@suse.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Fri, 29 Aug 2025 09:09:45 +0200
X-Gm-Features: Ac12FXwEo1YoTOSA95m6PPBg4ofOarTUXiF9XHhF14W-vruutPg6yLL_VH6of1I
Message-ID: <CAJ8uoz2US3EtXe17E2Rq6J+pkHe0TqiN9S8dM9npGaRskQo5QQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Upon failures, exit with code 1 in test_xsk.sh
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Aug 2025 at 20:48, Ricardo B. Marli=C3=A8re <rbm@suse.com> wrote=
:
>
> Currently, even if some subtests fails, the end result will still yield
> "ok 1 selftests: bpf: test_xsk.sh". Fix it by exiting with 1 if there are
> any failures.
>
> Signed-off-by: Ricardo B. Marli=C3=A8re <rbm@suse.com>

Thanks Ricardo.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> ---
>  tools/testing/selftests/bpf/test_xsk.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/self=
tests/bpf/test_xsk.sh
> index 65aafe0003db054e9dfd156092fed53b07be06a0..62db060298a4a3b4391ee4cfa=
50557cf4a62d3d5 100755
> --- a/tools/testing/selftests/bpf/test_xsk.sh
> +++ b/tools/testing/selftests/bpf/test_xsk.sh
> @@ -241,4 +241,6 @@ done
>
>  if [ $failures -eq 0 ]; then
>          echo "All tests successful!"
> +else
> +       exit 1
>  fi
>
> ---
> base-commit: 5b6d6fe1ca7b712c74f78426bb23c465fd34b322
> change-id: 20250828-selftests-bpf-test_xsk_ret-1eb27dbac071
>
> Best regards,
> --
> Ricardo B. Marli=C3=A8re <rbm@suse.com>
>
>

