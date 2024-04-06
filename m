Return-Path: <linux-kselftest+bounces-7335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600BD89AC85
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 19:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8031C20D58
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 17:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFCE40857;
	Sat,  6 Apr 2024 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhRKf9n3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05EC1D53F;
	Sat,  6 Apr 2024 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712425189; cv=none; b=BFU9LQ47++YXOs1bCh7/tR+xkB5wFct4x0lB9lxzSqHdrI2oHFwmCOETuOARsSjCQ1nQL6nwSiqgBP0z3kqdeCJxIq0m7mBfTi7fFAbepy67KcaGoYnr+wpUlpQf8CkyjjbprpjkP7iTjh6woG7xs0tp4YPSeSQnWF6FGIgGaEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712425189; c=relaxed/simple;
	bh=oSMNoFjiijyVrEWt9uQKua4rXTAd9U6iITpiNbsiu30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLEETlkdvQjgxZavL2dT73JvATRLSOUfwuNJNLnwV6AXitzLjyGwS2Qf80omA+aBFl6C+9p4uVsHOU0xYMSpmORcMOXVcFIys4zZLYEfGPQhzfRi7O5RVoSfjktPrFDfKhyB5WVwoGcu+RvWJ4ozuObxmk46URxiH2D7eq5g5xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhRKf9n3; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5f034b4dcecso2183727a12.1;
        Sat, 06 Apr 2024 10:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712425187; x=1713029987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMkwB/rdKJ1zYF97d9chkJsTV6l3kjmuDMV7qKAyKgE=;
        b=AhRKf9n3/0/MT26ND9OkA1hbRAesQvL4Spk4xVAZymvRMSukkMPUcIyIHp5h9jXzLr
         0iGq3yaIQ0zbPoFaGqa3PKtOu32BEyetvz3bSlWn7+6FKljrQpj0b20+58JOaT5V5Q88
         h6MM2QyYy2ub2NbBzfy7opSEKLXImE5Q77GNsaqenCGLwr/wm2bGtElbV/Ypjvf8NSei
         DJEgVZ6ZXBQST4EOL9hMBISQ+ZqV9QamFC/8mshQ+d7vE0+QvQkIxdtSZeGALAx/6nqC
         3/BQsC5ecbYwbVKAwnsIKUIR5CzFc2uFLzZxz/q3C/X9B9msDjsW/396wdpO6xD9dydm
         4bhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712425187; x=1713029987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMkwB/rdKJ1zYF97d9chkJsTV6l3kjmuDMV7qKAyKgE=;
        b=xEUt5cyGh/7d4FQr9lvAmOceMLVPdaBq1hXAyoaItrIMVgLJmSetbNVJ87jNZZSDjH
         76JE4XC0Unn27ltK9pqrc1WCcP9csNMs2j+pdoh2zh4SUlaredPqn/tqa4aS98FWaO9S
         7fNfZPcVfW0adKADE4XhxuQuNIYCcRwZeWBAVgugVRmvcge7t4QAcT5Orv12I/pBDtk6
         VSXyeShfAD25FZtPmS4vTqVlryVLBFysSKhSvDpY4dQLNbpeP9HXbqBS/i0fruA7yqBz
         EbnaD1uLBz0k5R5aeD7i1LBmtCKtJ0iF8F4KVv4fFeZjeGh0V4xTgIlEuVQfsKDPF3Rn
         po1A==
X-Forwarded-Encrypted: i=1; AJvYcCU/044mQWHrfQcMwRGwNxix/zF/qS0J7PWGHSsbe6Wvf5o8kyrukGoWCmwPXVdZnIVrj9P0afxXTxeANMDI8FPjW5FGRY6PAVYTTv8LSd0Dzva8SeOEiM8IJVM/XTMK1z7NzwiATq6NNN8JvjCBfHNyoksrugtzVMlMywhYRFxySYqO
X-Gm-Message-State: AOJu0YxzZSsbEA1wvINhheIgO3CscivYEnUQa/DTSrrt/WR44oPVcolE
	8OGr89xTcWk5gkvv+wTyP7Ztim7RGeOagpGRuA1mmTcQlFz5PxV1l+O+Qx9QvVjWH0tO5WWkY59
	a/oxD43n4saoG4QBW6AHj8Iq2Y/E=
X-Google-Smtp-Source: AGHT+IFBLl24/81ABhUXUBI+i8gS3oGu0XfufEWyi+2tVQH52Akc2LAQNAul4GiO4lT6FvFIbNgAbxXa74fvAVejchE=
X-Received: by 2002:a17:90a:e286:b0:29b:c31:1fe1 with SMTP id
 d6-20020a17090ae28600b0029b0c311fe1mr6686825pjz.10.1712425187148; Sat, 06 Apr
 2024 10:39:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406092005.92399-1-andrea.righi@canonical.com> <20240406092005.92399-5-andrea.righi@canonical.com>
In-Reply-To: <20240406092005.92399-5-andrea.righi@canonical.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 6 Apr 2024 10:39:35 -0700
Message-ID: <CAEf4BzanzbBaVgP7Qu8v4jnfsWt+9vJqB6D9G7NjE5QL+3iKXQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] selftests/bpf: Add tests for ring__consume_n and ring_buffer__consume_n
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 2:20=E2=80=AFAM Andrea Righi <andrea.righi@canonical=
.com> wrote:
>
> Add tests for new API ring__consume_n() and ring_buffer__consume_n().
>
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/ringbuf.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/tes=
ting/selftests/bpf/prog_tests/ringbuf.c
> index 48c5695b7abf..33aba7684ab9 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> @@ -304,10 +304,18 @@ static void ringbuf_subtest(void)
>         err =3D ring_buffer__consume(ringbuf);
>         CHECK(err < 0, "rb_consume", "failed: %d\b", err);
>
> +       /* try to consume up to one item */
> +       err =3D ring_buffer__consume_n(ringbuf, 1);
> +       CHECK(err < 0 || err > 1, "rb_consume_n", "failed: %d\b", err);
> +
>         /* also consume using ring__consume to make sure it works the sam=
e */
>         err =3D ring__consume(ring);
>         ASSERT_GE(err, 0, "ring_consume");
>
> +       /* try to consume up to one item */
> +       err =3D ring__consume_n(ring, 1);
> +       CHECK(err < 0 || err > 1, "ring_consume_n", "failed: %d\b", err);
> +

Did you actually run this test? There is ring_buffer__consume() and
ring__consume() calls right before your added calls, so consume_n will
return zero.

I dropped this broken patch. Please send a proper test as a follow up.

>         /* 3 rounds, 2 samples each */
>         cnt =3D atomic_xchg(&sample_cnt, 0);
>         CHECK(cnt !=3D 6, "cnt", "exp %d samples, got %d\n", 6, cnt);
> --
> 2.43.0
>

