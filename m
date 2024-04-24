Return-Path: <linux-kselftest+bounces-8753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8B68AFEEC
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 04:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9EE1C223F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 02:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BA313340B;
	Wed, 24 Apr 2024 02:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAG4t1ep"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D343C129A9C;
	Wed, 24 Apr 2024 02:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713927417; cv=none; b=AfPrwRGIrYZy++AHuzDAOKWQ1YqFxok9TAK2bACP9u5xW504G2k4fZMqSeLQL1KAZpbx+jZB0hvTUMztl11Dq94KS9q7MhiJ1q4dzXE/SQ46rdCU375/MZ1kROyHQvIy6TyoHf66GBRxfaZSgmjise0aJoJhL0RfkcfdLPSXLWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713927417; c=relaxed/simple;
	bh=/5pmIFmXPkmAlPGyKfgD/8qmZjBx715ObeJgbZPB71Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9tOooQJYekesB3ttOae2t3siqeGKyTi10Dd2FYh7S22qXOic7QAI892J/UKIdcF4T4yaP5+dBUqm4OqZd5OgEgukGkd+hb7R7Hng/mgwLYLkwd8E5NYUMl4S0crMIh0wRgsa3/w70FRXeGgM3QvkO3K+GR2y7MNCByWtGQ6bFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAG4t1ep; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34665dd7610so3240427f8f.3;
        Tue, 23 Apr 2024 19:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713927414; x=1714532214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50U8awpANlESe7fsxcFoAzxWkGcwzVdwCPUvxCD4upA=;
        b=dAG4t1epU/NsQLD5enMavNX8FFIkuTDZZSTFSytnDKy0mxhEMrQvCChCto1aN6X0Q7
         8tV+PtO88XXP9kesOB9jONd/bVTVovusZt2E2pwCqz3cQBlVpHPHhn0u4STFANCXt0MW
         eSyrpKFcxcGpXTCZF2XojnLxm4lsE/0B79wCt3Nm9uIE6q/yNr2JNwrU7whVNuBnKDxD
         CJ+1GlbjdAAPOv2vVSrHcnxCNgObiXao8HgMF7cZ9bmKr6mjZj9XJRKPvbEe54FEeOCp
         PU+/SgnPHyZJstH65juns9VH1GB63oTBcmfx90c98AQSm2ga1dMNBkLXVvtGhTY384aw
         3zyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713927414; x=1714532214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50U8awpANlESe7fsxcFoAzxWkGcwzVdwCPUvxCD4upA=;
        b=XMI91tyVDEAypPmUQVtyK8OTCdOD/f6wjX4bZWzAtzDF023KC9N78mwpxQXQKiUyJe
         NKz5X5MB/hteqCKRNZ8CTZ2pDCiFDHEcVYr38AdnHs45+46HBTn5nZnIc+nQl4OefoOI
         gw0Citwx0PhoSoRps4cA/ggU2Nrt8nYlwB3YU8RXbl2xgADDtihP4iBzu1L8iV1mpMpJ
         AdTQ3iwdW2CMbpL+J8l6kAfb+7acWxcF/HuQioBHorhkexwMd4kv2Py4I7KOkSzYPJoQ
         VnBeBxh9Tue24ZwWxKjley+JD0aBO9/5M1cgTuoV0jvCzrBia3FNztjJoWoq9b0+qXVj
         54bw==
X-Forwarded-Encrypted: i=1; AJvYcCWG9f4tXirrFA8iNaNdStuSpTUMc5urNI5YseUfU8V0wGs5Vxh+357TbYxDneUJO31Ymx1PRJ1P/6X68J40HNL+ocfXNAl1+MquEOKzblAzTn8E3k5g+GINVb9hjeZLv6zGnwl81o/VrFE9231Av36i2TRRTI/ncWzvcQkbIRBLk9TP
X-Gm-Message-State: AOJu0Yw6+HHk6YnCyTdvQa8W0HOJGmU4+os9gHwkqbYQkOr4ISTbSGoO
	ct6vmu4zKoWl4ZzNMQsEl0rMmXDTfEW9wZXGKLyW/B5lFJBm6tXvh03zJ/pDYqmYscsX+qnPLwF
	Me1rFd9sw7xHHhYWRd2fg0+ZeWk4=
X-Google-Smtp-Source: AGHT+IEuCqH3eh47wECnECQrOO35nmQN/2iOSzKyqoN+lsJfXd4CUGp3lkwGM+BrC+bUqjPGqN1l0B/9x5c2x8TNE3k=
X-Received: by 2002:a5d:6182:0:b0:346:14d2:fef6 with SMTP id
 j2-20020a5d6182000000b0034614d2fef6mr565473wru.62.1713927414330; Tue, 23 Apr
 2024 19:56:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org> <20240420-bpf_wq-v2-10-6c986a5a741f@kernel.org>
In-Reply-To: <20240420-bpf_wq-v2-10-6c986a5a741f@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Apr 2024 19:56:42 -0700
Message-ID: <CAADnVQLbn9UUZ+oH=uoB7OqCL02ZCYmSbtf3YWA56+XHvG0USg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 10/16] selftests/bpf: add bpf_wq tests
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 2:10=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
> +
> +SEC("tc")
> +/* test that workqueues can be used from an array
> + */
> +__retval(0)
> +long test_call_array_sleepable(void *ctx)
> +{
> +       int key =3D 0;
> +
> +       return test_elem_callback(&array, &key);
> +}
> +
> +SEC("syscall")
> +/* Same test than above but from a sleepable context.
> + */

I adjusted all these comments to be normal single line comments.

The main thing to follow up is to figure out how to wait for wq
to finish.
Since we have this message:
./test_progs -t wq
...
#521     wq:OK
Summary: 2/9 PASSED, 0 SKIPPED, 0 FAILED
Failed to unload bpf_testmod.ko from kernel: -11

and doing manual "rmmod bpf_testmod"
after the test run is quite annoying.

Overall great stuff. Thank you for pushing it through.
Much appreciated!

