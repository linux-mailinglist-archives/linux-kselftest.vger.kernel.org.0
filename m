Return-Path: <linux-kselftest+bounces-49052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EF9D27E59
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 20:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A8AE32052B6
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 18:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29D13D7D86;
	Thu, 15 Jan 2026 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXWMH5xT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473543D7D7B
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 17:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499927; cv=none; b=jMxfgeoWdqzN9qbyAJLcX4tCWvH5zGTHs/ZgKyvQu0SWsZsvnH8YfyWBHkkSNEBiTtW1Zfc4kPZDKHTQJyrE8vhZxi4x5E9YzphNDAd+aTf1CfxOl/MhTIHikfJoDs17oZVk3TJuZCLOFjUJp5/vqLuw+T62ai1W4NpxdPKFHd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499927; c=relaxed/simple;
	bh=wiWpCBlo8csBanFpP1T8JWd5VmZQnlI4yTdQ7wyvXQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQI0NUDQXbyn97XdwhctUecFmyG4GI1GP7WTZiZ2bNqD1RIRpYl9OXQ1kaad5rA0TXWRldXsGQvkfxwIXOEzWQ24t2VX72WdXE1mT2IKkxGHteaT3gTbWrNrsc0pfC/JMWSKF+zKkRIlkgslVhDm39zkjkYepEgh52WT64u8RBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXWMH5xT; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c93e0269cso1489687a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 09:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768499924; x=1769104724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vW07CLD2WVG+glQ8ijfA32Jhr+9FjGh1F8sZT7yFNek=;
        b=fXWMH5xTkW6TCpv3NRfoI81lnzjMUFPOyn6M7nSvl5Yts/mi8dPxtK7oGACW9XLL9B
         BlvUEB0lsd//cyehWLlM8jo934rsRg40PSUtYIlCJHgZU/jVdzL4auCrUneu5xUmZJOr
         KgKticEUOTW3v+5RsJX1YFv5S3o9Bqvjf3YnWLYVKkb8gYo2gLcWSOVlBMl2KN2PGtHz
         BS66J3yMaMBHrDlzMAzQYnGGUhEK1nUw224qLGd+jFyv2mkqG+az33BQ6b+z1Uf7B5Zu
         1URy9oWbcPBW1tpL8DFFNRuKM6BdqYw9j4vcRN9DuHvI0oBDztD1+vW1FcPPGxUBgYvQ
         gRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768499924; x=1769104724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vW07CLD2WVG+glQ8ijfA32Jhr+9FjGh1F8sZT7yFNek=;
        b=iYY7uat/nhYuKA/C5RFLsGosiol7btPrHc7Kz5jBRGOyadbXd0VJ9qGHsynbKPy1jP
         vvcQ8Qiz/NfT7ZHsx3nam6Ql4wqnDXoeEanWrEfWrPpcuFSoYzUvfY1BQPenZ8RKtzat
         HKYAvZxHK/IIbw3Ocm23MKQ4w8BBP44EYWFOzCFd5NxUYArGHoS6r/l4BWV7a5MsmtTa
         5u1lwMILjdG8liuqpyGCIw62RhuK5BX6iBPhU/K7HsEElGHGPs1J4wT2+zdEt1PdTl+v
         1XSgCRpMLnxYxns4D3l/ixZT+T1dysuBmVQ1URRbUMi/nUJpWoB3GNhldFVfSIfwSqCx
         TSwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk7W2yHRv6EZeXM478PRmJ/dAQ27aGAOtWNEvTAnhYyykIvj+NuSgXPM2RQ/eL4Yu7PG6+nDGt63Hjcrh+r3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWDgiCE9wtboc4zPAxmE7UFQSgQCjXNsk4660AWIRCAanGyxlN
	OxmRJZWwC2FPwHKp9SM8wtTeRzVHW/nwYYJG/5OeDNyenI0S+8saXkm6QOTHLxFXke72h7pbfYm
	dHU+xC5NnRqfL9dh9vpvJsWE8eZ3+DzI=
X-Gm-Gg: AY/fxX6i2CCUbbSWODnecZriJTkNmEbuxvPvi/KiSQFhuHchSLN6EkSS77viwzaJpx8
	k836E+PADxJR82T8eEki+WNccz9JMkXpy0U5mTvU2QVkCeuBvsUoTbZB2iwJy9hDmo1YDe813zV
	ML+khv9i5kK4J21PNbfDjlPbrmXRPEb4kySr15c5TKjwKFJBrzLaJ2eoYZSMNvqtIkxw/HHMZyJ
	TVT5Cvwxdq5DT1d9VMo+s6kBQ6zKkfgfcn6OKLe3NoTUCAqxi20Nq4keSxAV7Zn1h0TZw9FXg8N
	I8uWulTk
X-Received: by 2002:a17:90b:1804:b0:32e:23c9:6f41 with SMTP id
 98e67ed59e1d1-35272bf1303mr274667a91.5.1768499924486; Thu, 15 Jan 2026
 09:58:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114-bpftool-tests-v1-0-cfab1cc9beaf@bootlin.com>
In-Reply-To: <20260114-bpftool-tests-v1-0-cfab1cc9beaf@bootlin.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Jan 2026 09:58:31 -0800
X-Gm-Features: AZwV_QiiJHMacsbeNADMd0KHpqQi4AA0UamPcGJk-PKWuvmj0gNuFUrcyu34jJs
Message-ID: <CAEf4BzYvZsjSpsDHXAuZ9G3=r4e27+c_LDpSUampw-fTfKA2=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] selftests/bpf: add a new runner for bpftool tests
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 12:59=E2=80=AFAM Alexis Lothor=C3=A9 (eBPF Foundati=
on)
<alexis.lothore@bootlin.com> wrote:
>
> Hello,
> this series is part of the larger effort aiming to convert all
> standalone tests to the CI runners so that they are properly executed on
> patches submission.
>
> Some of those tests are validating bpftool behavior(test_bpftool_map.sh,
> test_bpftool_metadata.sh, test_bpftool_synctypes.py, test_bpftool.py...)
> and so they do not integrate well in test_progs. This series proposes to

Can you elaborate why they do not integrate well? In my mind,
test_progs should be the only runner into which we invest effort
(parallel tests, all the different filtering, etc; why would we have
to reimplement subsets of this). The fact that we have test_maps and
test_verifier is historical and if we had enough time we'd merge all
of them into test_progs.

What exactly in test_progs would prevent us from implementing bpftool
test runner?

> introduce a new runner to support those tests. This new runner is
> heavily inspired from test_progs, with slightly less features.
>
> - First commit move the assert macros exposed by test_progs into a
>   shared header so that they can be used by the new runner
> - Second commit introduces the new runner, as well as a first test
> - Third commit adds a second test
> - Fourth commit drops the legacy scripts corresponding to those new
>   tests
>
> The series only adds the runner, but it is not enough to have it running
> in CI. The github actions need to be updated both in [1] and [2], and I
> am not sure how it si supposed to be contributed (the part needed in [1]
> must likely be integrated in the commit that is systematically brought
> on top of the bpf-next_base branch). Still, an example of test_bpftool
> run can be found in [3], in which I have forked and updated the needed
> Github actions ([4])
>
> [1] https://github.com/kernel-patches/bpf.git
> [2] https://github.com/libbpf/ci
> [3] https://github.com/kernel-patches/bpf/pull/10711
> [4] https://github.com/Tropicao/libbpf-ci
>
> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boot=
lin.com>
> ---
> Alexis Lothor=C3=A9 (eBPF Foundation) (4):
>       bpf/selftests: move assert macros into a dedicated header
>       bpf/selftests: introduce bptool test runner and a first test
>       selftests/bpf: add bpftool map manipulations tests
>       selftests/bpf: remove converted bpftool test scripts
>
>  tools/testing/selftests/bpf/.gitignore             |   1 +
>  tools/testing/selftests/bpf/Makefile               |  16 +-
>  tools/testing/selftests/bpf/assert_helpers.h       | 231 ++++++++++++
>  tools/testing/selftests/bpf/bpftool_helpers.c      | 114 ++++++
>  tools/testing/selftests/bpf/bpftool_helpers.h      |  19 +
>  .../testing/selftests/bpf/bpftool_tests/.gitignore |   2 +
>  .../bpf/bpftool_tests/bpftool_maps_access.c        | 370 +++++++++++++++=
++++
>  .../selftests/bpf/bpftool_tests/bpftool_metadata.c | 128 +++++++
>  tools/testing/selftests/bpf/test_bpftool.c         | 126 +++++++
>  tools/testing/selftests/bpf/test_bpftool.h         |  36 ++
>  tools/testing/selftests/bpf/test_bpftool_map.sh    | 398 ---------------=
------
>  .../testing/selftests/bpf/test_bpftool_metadata.sh |  85 -----
>  tools/testing/selftests/bpf/test_progs.h           | 226 +-----------
>  13 files changed, 1041 insertions(+), 711 deletions(-)
> ---
> base-commit: 807cd0dc688b0e7314f53dc3a594f247bb3b665b
> change-id: 20251212-bpftool-tests-bb165c4cceb8
>
> Best regards,
> --
> Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>
>

