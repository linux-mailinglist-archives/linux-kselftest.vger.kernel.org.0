Return-Path: <linux-kselftest+bounces-19472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E9599918B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 21:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4291B2830B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 19:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8511CC8BB;
	Thu, 10 Oct 2024 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6CEGH03"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A709719ABA3;
	Thu, 10 Oct 2024 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728586014; cv=none; b=KSgOQwqyPdtFNIsba2T3CvrbvYpYfIT38dChcav9HXcEQ+ETfNC9YRBQDlagYj/FNJFqwCzUC6okGeTmmu93nPmNecku8pRJ7WtyxPHNjSYF5zXdJdZZdWE2M2lZWx/zhpwfZ5SH+M4KfIv1Sh28vgHnhO1WJu0gHJIeVeeUpKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728586014; c=relaxed/simple;
	bh=0Y9YVXLPzYx81RKL1GGrowO/ucrFIu0Tagu6CXbMJEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5eiGvjhLFjtaCUBFPbFXrEEc3C8rF6NBTWG+Xlg+1raNjaMSeU6gww07M3XEUvTTtiBbcKI4hyMfGQY322ynnmDKMiinHATS6qKNVf1u3AhfQkI3WOU81CyucpugVGkIry7vOo2mhG7UmHjJzj7ZnxcrbFl5de4W3n6azlaozc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6CEGH03; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e06acff261so910770a91.2;
        Thu, 10 Oct 2024 11:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728586012; x=1729190812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyP494PRfZ+GoTHnTtT2JyazKwR7IZMIFXTCwMxXviQ=;
        b=Z6CEGH03xE1kRV+PP5crL7mHpbJtxTumPj+IZOAt9k31etrR8zrEMwDmhH2wJY/PgR
         m0vwUyRHnw1GaGViKGxjnT2sTM9PhtwcAZRnf1EIi8ZdUTA536EsA7kl6hgnttdTf0AX
         y1vEwkQ8m0ziYeteuXO6ByaEliIvJXR5sU7GgnFSBXDbE0NgdGoEyaOEkOgsdQ7R7AGG
         Mu8n4iSP9sZhjKF6xM6+SOZo7BoS67PlY3FEGRvDw3G/vpBzmgcar7zIhwlh+VdSM2kd
         DHMokgESrOd9b2Gn7SCGIv/mNIqOHmfYzTUdhl9M75n+tvp276Ir07lGejB5f5Te/dqW
         2rBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728586012; x=1729190812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyP494PRfZ+GoTHnTtT2JyazKwR7IZMIFXTCwMxXviQ=;
        b=fcARgZoNETsXTnCxl8o4IjDHVe4maRjIvDwa8pvEoag8UTjPT2T65X2Cg7p4cuV3by
         Qg1YshW5uklSH7IRo8fZskPXtP9V84RIlJtWuVBJANJ60KsN/BdDLSv7SUO+SBlB+OHZ
         Bf/rRgJU+eYy3iPlLoxA3rJ4BlhrRHvuGH/AlL823kWLAyLkC0N012T67v387TRjBLNn
         DA2W/pditRv6o80QVLZrKgvOlBrOluaDgKI1a8mxoLkVploRJP43utfsqHTJRZiz2Svd
         RuldZXe7pr1ADosN8vb6bAwG4OIGw9YEj1vc47YB1vF8tbsDNpRQ1X2s0gaRGgNyBagV
         Wu8w==
X-Forwarded-Encrypted: i=1; AJvYcCW6drxOR6snglI7SFR74GwHtWNyuUftkhTKkySvQMWqlGd+MV5LElRbA2UGOgqwx79Tg3hcycpPT1iJmI8=@vger.kernel.org, AJvYcCXFegi1lsbjNfmkvyI6ImzzP5JzGh8408JuQxVJN7BROXir0icXU8f9fXzloApB1e85rPWeesEXIaGCPX6jDrJN@vger.kernel.org
X-Gm-Message-State: AOJu0YzB+/AWZRHtuuTsTHf8y7CcMXrT2VMrSgUmGYMxEGx64NtBFYBA
	RymEjW6xxRoqzAhwPkihQe+Hx5RznqbnUZzWSrkJFOrYukjRkRH2Irot9B5xsnMJ3Ts772Sots7
	dbvXWNGA/6biHtdV3+Z/JP9wnqCNPHg==
X-Google-Smtp-Source: AGHT+IGDwIgkZrJYbh1BWe3FAqN5BAnHKZPssZQc4seVUXtI2g9DRN23gZjIDN5oJfP38DLkOh5Kjc/mw6/fW0t8kqw=
X-Received: by 2002:a17:90a:ae03:b0:2e2:e6bf:534b with SMTP id
 98e67ed59e1d1-2e2f0da0fc6mr124937a91.40.1728586011873; Thu, 10 Oct 2024
 11:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010064600.4574-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20241010064600.4574-1-zhujun2@cmss.chinamobile.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 10 Oct 2024 11:46:39 -0700
Message-ID: <CAEf4BzbNqcHAGzR6fud=gNxt3A9Yo-WGYVdn0HAAsJJLX5wcdA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Removed redundant variable
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, mykolal@fb.com, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 11:46=E2=80=AFPM Zhu Jun <zhujun2@cmss.chinamobile.c=
om> wrote:
>
> The error check is no longer needed for this test case,
> simplifying the code.
>
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/signal_pending.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

please add bpf@vger.kernel.org and resend. Also use [PATCH bpf-next]
prefix for email subject.

> diff --git a/tools/testing/selftests/bpf/prog_tests/signal_pending.c b/to=
ols/testing/selftests/bpf/prog_tests/signal_pending.c
> index 70b49da5ca0a..8920fadb3aa9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/signal_pending.c
> +++ b/tools/testing/selftests/bpf/prog_tests/signal_pending.c
> @@ -36,7 +36,7 @@ static void test_signal_pending_by_type(enum bpf_prog_t=
ype prog_type)
>         err =3D setitimer(ITIMER_REAL, &timeo, NULL);
>         ASSERT_OK(err, "test-run-signal-timer");
>
> -       err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> +       bpf_prog_test_run_opts(prog_fd, &topts);
>         ASSERT_LE(topts.duration, 500000000 /* 500ms */,
>                   "test-run-signal-duration");
>
> --
> 2.17.1
>
>
>

