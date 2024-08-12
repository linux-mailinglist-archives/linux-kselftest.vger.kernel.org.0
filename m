Return-Path: <linux-kselftest+bounces-15178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1532794F8D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 23:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF58C2830D2
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 21:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1AB19307E;
	Mon, 12 Aug 2024 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KA2rGYeV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9358518E051;
	Mon, 12 Aug 2024 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723497439; cv=none; b=Yq36lP4A/Pw24b1IlJUYF/K4tT4d51f+kEPUwxCYM65RoR/JmO0/437Q9oBqfRx2oyOP7EoavxxvppiXLvvN6z0WiqOBcG6haMmgN//0CZtT2Bhg5IXTkwPMR/PjNBegnZ4DnbA5HQxy2r3YJR1VJCAjfxJWlKsRYhle9prKFvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723497439; c=relaxed/simple;
	bh=qXbSKVYOp703lMou18LJTMv2aROXl0o6Emm6S2Z6gGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVvN0RtJHC21h0Z2g7cHs0dSYLmUeDQ7mIAJzPWDizjLxPh/oQL3B+XTJJfEsv2Eruk3DEvgWQUpD6RvH/Up5QcC+SX98lmbkw1EWut75D8IgcDPPYKgRUDHeDY4xKsqU+GxG8Y6pfCMKar6MVg22Ko3/ar6DMhaAWNeUiohJ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KA2rGYeV; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cb4c584029so3724777a91.3;
        Mon, 12 Aug 2024 14:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723497435; x=1724102235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mbl+io8W3Adu1FtPTdkK2PsqHbTxT5/nTBxDfEamSyE=;
        b=KA2rGYeVBeUi2DUNbUyowfVniwqlxXMa6ZARdWkly7SI1UB2CP1EE9fV01bX6MhFV+
         68x1RTua9my5uhV9/eapkQY3ytN9XC09KP+cIO5TNXzLfDHPkN2nNUsxDmhAfSb+PRby
         nunSz3Cxr223fh/YMix14Pq42EDQqTp9avagha9q1Y9fRUcVYoxeZul/EcBhNaSU/imF
         VczXAWb/W6T/cCYIzimpvU+mKc34STyVuykiCWB6NkOQvCxNmYXIxtmC1Gl7aLJiVCtQ
         QrcInu7Fk4qQU9POsEfcz7lzRxMQ9iyrVgeGM884kzu5EIpY3WkHVLDK53HiXNK3mCE3
         yQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723497435; x=1724102235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mbl+io8W3Adu1FtPTdkK2PsqHbTxT5/nTBxDfEamSyE=;
        b=S4J+HIFuPlpKM3/qOJ5pRguxm7Y+QhEcmntx8iKCTHmSrzEa7xY61QrAO1kyv7+txB
         pPpuWQBnnhFHRG4XQMdKYGM0YdQCr424n1r+SgaAcXuYqgomp42xc0veIe4CEAPQUHPK
         lWrlAv57CtCoKv0+Guap1dKUleo4+RpT4ikD3xHbUXsAcez66QgHpoGqWstY6seB39aA
         uD1ITsOPWDrD/AsDZFjnLPzVRT08rup5I+T1KeT9NlkG3uVx/qTCLAwfhTS73kv/TIl3
         tL1aIA3ic2SZBVGD2KVgFeofiu9o62ZxM6Rb5sLfwtqQkd15eYJXu0+/ZihQjyVXVuFn
         uHdw==
X-Forwarded-Encrypted: i=1; AJvYcCVLN66pOdKy5gldfJqeihhCYW4RFCuOxLQLhJT78/G1w/uUD9BJvokhahTtOF49GXgoUDzlvoamN11860KHTbK4dZQnGcWyVvLL0VlIjZz/L7xxX4pYVPraGM3bCoTLATSlp+3xU5ivwnLv3v2UCx6pdWECE1pZyT+OzeXP
X-Gm-Message-State: AOJu0YxW8F0DY5b/TUq/u5qVwUWLWZcgQ9vcmLRA1njbO0ZxXuddzHw5
	jda2jE1URhf605sUf03qZQLYfEit1gB6XRYUfBeJgTloaAfQLyWQ1c2UFSzrkcMJrSudqBFo958
	23kvEbDP1kKICYKtIz5Co8pHG2jOFO5Ad
X-Google-Smtp-Source: AGHT+IG3CVt68kJspR9GvCKA/xZmRRKzjF+T+3kadzBnLfyhDLuLrJsJ70pnEZ7CQMKx1u16s+51vVeEjlh3+8vvgfU=
X-Received: by 2002:a17:90b:895:b0:2c9:6f5e:f5c1 with SMTP id
 98e67ed59e1d1-2d39250829fmr1755380a91.10.1723497434765; Mon, 12 Aug 2024
 14:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812004503.43206-1-danieltimlee@gmail.com>
In-Reply-To: <20240812004503.43206-1-danieltimlee@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Aug 2024 14:17:02 -0700
Message-ID: <CAEf4BzZsZYNx_mV0_0RrWvQS+Y7ixvtzv3SmTTQkOveeZeot+w@mail.gmail.com>
Subject: Re: [bpf-next 0/3] samples/bpf: Remove obsolete tracing-related tests
To: "Daniel T. Lee" <danieltimlee@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Yipeng Zou <zouyipeng@huawei.com>, linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 5:45=E2=80=AFPM Daniel T. Lee <danieltimlee@gmail.c=
om> wrote:
>
> The BPF tracing infrastructure has undergone significant evolution,
> leading to the introduction of more robust and efficient APIs.
> However, some of the existing tests in the samples/bpf directory have
> not kept pace with these developments. These outdated tests not only
> create confusion among users but also increase maintenance overhead.
>
> For starter, this patchset focuses on cleaning up outdated 'tracing'
> related tests within the BPF testing framework. The goal is to
> modernize and streamline selftests by removing obsolete tests and
> migrating necessaries to more appropriate locations.
>
> Daniel T. Lee (3):
>   selftests/bpf: migrate tracepoint overhead test to prog_tests
>   selftests/bpf: add rename tracepoint bench test
>   samples/bpf: remove obsolete tracing related tests
>

We already have tracepoint-specific benchmark (see
benchs/bench_trigger.c), try `./bench trig-tp` (it will pretty recent
kernel due to reliance on bpf_modify_return_test_tp() kfunc).

So maybe instead of adding code to selftests, let's just remove it
from both samples/bpf and prog_tests' test_overhead? Either way
test_overhead isn't very representative anymore, given big chunk of
its overhead is in write() syscall?

>  samples/bpf/Makefile                          |  12 -
>  samples/bpf/test_overhead_kprobe.bpf.c        |  41 ----
>  samples/bpf/test_overhead_raw_tp.bpf.c        |  17 --
>  samples/bpf/test_overhead_tp.bpf.c            |  23 --
>  samples/bpf/test_overhead_user.c              | 225 ------------------
>  samples/bpf/test_override_return.sh           |  16 --
>  samples/bpf/test_probe_write_user.bpf.c       |  52 ----
>  samples/bpf/test_probe_write_user_user.c      | 108 ---------
>  samples/bpf/tracex7.bpf.c                     |  15 --
>  samples/bpf/tracex7_user.c                    |  56 -----
>  tools/testing/selftests/bpf/bench.c           |   2 +
>  .../selftests/bpf/benchs/bench_rename.c       |  16 ++
>  .../selftests/bpf/benchs/run_bench_rename.sh  |   2 +-
>  .../selftests/bpf/prog_tests/test_overhead.c  |  14 +-
>  .../selftests/bpf/progs/test_overhead.c       |  11 +-
>  15 files changed, 39 insertions(+), 571 deletions(-)
>  delete mode 100644 samples/bpf/test_overhead_kprobe.bpf.c
>  delete mode 100644 samples/bpf/test_overhead_raw_tp.bpf.c
>  delete mode 100644 samples/bpf/test_overhead_tp.bpf.c
>  delete mode 100644 samples/bpf/test_overhead_user.c
>  delete mode 100755 samples/bpf/test_override_return.sh
>  delete mode 100644 samples/bpf/test_probe_write_user.bpf.c
>  delete mode 100644 samples/bpf/test_probe_write_user_user.c
>  delete mode 100644 samples/bpf/tracex7.bpf.c
>  delete mode 100644 samples/bpf/tracex7_user.c
>
> --
> 2.43.0
>

