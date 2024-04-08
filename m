Return-Path: <linux-kselftest+bounces-7439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B58789CEAD
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 01:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57711C21934
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 23:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40A92C853;
	Mon,  8 Apr 2024 23:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0EYPhco"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4557171B0;
	Mon,  8 Apr 2024 23:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712617263; cv=none; b=WyR8pWHcbtzsG4QOErH13rnD2uJ63l8/Xo/7kQiRElsmCLfZB8N3H+IKAdaA1YtvDdfpQPtKD3ORJn7YXZpq/Q93N42aILRgyQbSPuXpNxhQYm9YkedGoncdvMTX8ptTGTwUcKsk7ngbBRKG5M6gR0omV/+njlrMh99Ml0lOLlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712617263; c=relaxed/simple;
	bh=OAsz0EGpjNsfwAUUziWbCE7j/dd8G1Znz0rMM+f9JuY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hqT6b8bczvZw9xPy0P20hBx6wUmF7hvANJcoMVUI1KRebwRSAArLSBWFnNnlbinBLs9TqCr9tMIAmii8MFZZ7H5P/8NEX+tAfnD+gWn4LobDViZc7XF+O3Ute3mnNVdK1yS5ow0qVQLUlc5vUN7LYPjsCwt0DpQ0McsLujlsFSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0EYPhco; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so1613931a12.3;
        Mon, 08 Apr 2024 16:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712617260; x=1713222060; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ex4cABK/2LwSM4KFuJqDUgpu5JdxWc0Mk135ytvTrHU=;
        b=c0EYPhcoeVltwMmwVbQAYu27qyNmvYk4W1rdXQe7AuxZVmrircmtthcKI+Eese+kL3
         rfJEZT0fecQ2DN1vquQtDAO3OOGOlfKfQLBCcQM/EOILjP6rYf42ZjNXOlzRwwCk2G6e
         LRJgj86SoxRd7a/7KLE+SeEEy8vS5qjL54+mJxtfpyy/VrQ2s1QGFmMBehAts6MWxvwD
         xbYbOhNYHxmzZqPX9IDbZQWSj70+ST3mP95DTTPOJ7XTCB/YcwrbtJkXpwTFgQKR44Os
         7G9aqmddDl4jWwPlKoEgvttHIQkFwOm6HcxstzSnN/g4C40s3qemfFWHScD6odSZdsVz
         O1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712617260; x=1713222060;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ex4cABK/2LwSM4KFuJqDUgpu5JdxWc0Mk135ytvTrHU=;
        b=R/oNZtH/ivQyBJphYPU/NxIEx3591Xa62DTV+oeHrIgax/Dfn4VQBXHeeWl7Aci6fq
         os/t0LUnaeK0Sm0UNG1+WUlx3/vB/dKO6n+INL2oI07NL8igEGrhoe4ahhnvkhdbHcR7
         GKCkjEwbzm6BqQ40lJrb729XQUnVb/AJ6DC9FMMcHKgxGIl8ybERRRJ63O695CVN+/Oo
         uFAh1Mh0e1mdlMcOQLjAJV7UWBdrIyIwEPgV5Wl6i5Rv9RCn/lu+JT1Ke3gG1YwNGzGj
         g4cY7czhXTJWybwCI67J2UQcAfLHU0ss7mrjlm48LM8k7vDf2cGtLdmukBC+gAIMNAbd
         N5bA==
X-Forwarded-Encrypted: i=1; AJvYcCU4k+NaKvODWruIv9RwgsoMrfoMN+UYjJXyPpEK77UQaZ5ypW2c2V8iXzvNBEkWD+k3KdEDUGlBRIibkblMt8ouj0EmMWpiiUR95Mr5heHIuQkInYPkUJ71tWvNQIruOHRMuW3v24NQuW8Jy/30
X-Gm-Message-State: AOJu0Yy6ALJ+0n9xDjgw8r3NicDM0G/gRO8PWNP1UTyc129pAgmbmjqj
	Xdm3smBJGCv4sdfXKEUSU1O2faLCueyWmFqNd3sOTTrbycnuHV3R
X-Google-Smtp-Source: AGHT+IFzDUd/Jkx2g9Qg+ypG71YkVGTGpaG7cyWDZjhBQQYPONQ+ksGMvPqd7py8vfm28iCNxVA8fw==
X-Received: by 2002:a50:f615:0:b0:56e:2f2c:e249 with SMTP id c21-20020a50f615000000b0056e2f2ce249mr7082773edn.7.1712617259822;
        Mon, 08 Apr 2024 16:00:59 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id et6-20020a056402378600b0056b8dcdaca5sm4535904edb.73.2024.04.08.16.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 16:00:59 -0700 (PDT)
Message-ID: <345cddbdfe8e91dc6395331c838329d02d519863.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v6 6/6] selftests/bpf: add sleepable timer
 tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Tue, 09 Apr 2024 02:00:57 +0300
In-Reply-To: <20240408-hid-bpf-sleepable-v6-6-0499ddd91b94@kernel.org>
References: <20240408-hid-bpf-sleepable-v6-0-0499ddd91b94@kernel.org>
	 <20240408-hid-bpf-sleepable-v6-6-0499ddd91b94@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-08 at 10:09 +0200, Benjamin Tissoires wrote:
> bpf_experimental.h and ../bpf_testmod/bpf_testmod_kfunc.h are both
> including vmlinux.h, which is not compatible with including time.h
> or bpf_tcp_helpers.h.
>=20
> So keep sleepable tests in a separate bpf source file.
>=20
> The first correct test is run twice for convenience:
> - first through RUN_TESTS
> - then we ensure that the timer was actually executed, in a manual
>   load/attach/run
>=20
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
>=20
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
(With a few nitpicks)

> diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testi=
ng/selftests/bpf/prog_tests/timer.c
> index d66687f1ee6a..c6c7c623b31c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/timer.c
> +++ b/tools/testing/selftests/bpf/prog_tests/timer.c

[...]

> +void serial_test_sleepable_timer(void)
> +{
> +	struct timer_sleepable *timer_sleepable_skel =3D NULL;
> +	int err, prog_fd;
> +
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +
> +	RUN_TESTS(timer_sleepable);
> +
> +	/* re-run the success test to check if the timer was actually executed =
*/
> +
> +	timer_sleepable_skel =3D timer_sleepable__open_and_load();
> +	if (!ASSERT_OK_PTR(timer_sleepable_skel, "timer_sleepable_skel_load"))
> +		return;
> +
> +	err =3D timer_sleepable__attach(timer_sleepable_skel);
> +	if (!ASSERT_OK(err, "timer_sleepable_attach"))
> +		return;

Nit: this should call timer_sleepable__destroy();

> +
> +	prog_fd =3D bpf_program__fd(timer_sleepable_skel->progs.test_syscall_sl=
eepable);
> +	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> +	ASSERT_OK(err, "test_run");
> +	ASSERT_EQ(topts.retval, 0, "test_run");
> +
> +	usleep(50); /* 10 usecs should be enough, but give it extra */
> +
> +	ASSERT_EQ(timer_sleepable_skel->bss->ok_sleepable, 1, "ok_sleepable");

Nit: same as above.

> +}
> diff --git a/tools/testing/selftests/bpf/progs/timer_sleepable.c b/tools/=
testing/selftests/bpf/progs/timer_sleepable.c
> new file mode 100644
> index 000000000000..fc7829d8b6c4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/timer_sleepable.c

[...]

> +SEC("tc")
> +/* check that calling bpf_timer_start() with BPF_F_TIMER_SLEEPABLE on a =
sleepable
> + * callback works
> + */
> +__retval(0)
> +long test_call_sleepable(void *ctx)
> +{
> +	int key =3D 0;
> +	struct bpf_timer *timer;
> +
> +	if (ok_sleepable & 1)
> +		return -1;
> +
> +	timer =3D bpf_map_lookup_elem(&timer_map, &key);
> +	if (timer) {
> +		if (bpf_timer_init(timer, &timer_map, CLOCK_MONOTONIC | BPF_F_TIMER_SL=
EEPABLE) !=3D 0)
> +			return -2;
> +		bpf_timer_set_sleepable_cb(timer, timer_cb_sleepable);
> +		if (bpf_timer_start(timer, 0, 0))
> +			return -3;
> +	} else {
> +		return -4;
> +	}
> +
> +	return 0;
> +}
> +
> +SEC("syscall")
> +/* check that calling bpf_timer_start() with BPF_F_TIMER_SLEEPABLE on a =
sleepable
> + * callback works.
> + */
> +__retval(0)
> +long test_syscall_sleepable(void *ctx)
> +{

Nit: the body of this function is the same as in test_call_sleepable(),
     maybe factor it out as an auxiliary static function?
     (also, should these tests use different 'key' ?)

> +	int key =3D 0;
> +	struct bpf_timer *timer;
> +
> +	if (ok_sleepable & 1)
> +		return -1;
> +
> +	timer =3D bpf_map_lookup_elem(&timer_map, &key);
> +	if (timer) {
> +		if (bpf_timer_init(timer, &timer_map, CLOCK_MONOTONIC | BPF_F_TIMER_SL=
EEPABLE) !=3D 0)
> +			return -2;
> +		bpf_timer_set_sleepable_cb(timer, timer_cb_sleepable);
> +		if (bpf_timer_start(timer, 0, 0))
> +			return -3;
> +	} else {
> +		return -4;
> +	}
> +
> +	return 0;
> +}

[...]

> +SEC("tc")
> +/* check that calling bpf_timer_start() with a delay on a sleepable
> + * callback is returning -EINVAL
> + */
> +__retval(-22)
> +long test_call_sleepable_delay(void *ctx)
> +{
> +	int key =3D 2;
> +	struct bpf_timer *timer;
> +
> +	timer =3D bpf_map_lookup_elem(&timer_map, &key);
> +	if (!timer)
> +		return 1;
> +
> +	if (bpf_timer_init(timer, &timer_map, CLOCK_MONOTONIC | BPF_F_TIMER_SLE=
EPABLE))
> +		return 2;
> +
> +	if (bpf_timer_set_sleepable_cb(timer, timer_cb_sleepable))
> +		return 3;
> +
> +	return bpf_timer_start(timer, 1, 0);

Q: should verifier statically check that 3rd parameter is zero for sleepabl=
e timers?
  (same question for call to bpf_timer_set_sleepable_cb() with non-sleepabl=
e map)

[...]



