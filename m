Return-Path: <linux-kselftest+bounces-45658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 352B2C5E1D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 17:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A12035890C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 15:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6347F32860A;
	Fri, 14 Nov 2025 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJ+TBhwt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3606432573E;
	Fri, 14 Nov 2025 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763135445; cv=none; b=IAtA8NvbFSwiYcCo16BJD+R+DZvsmuo1lk9oAedUzf2MfLbdLk7SjkpsHqa1Os5QZEua7nNRPzjearynUWM/L2wHwUf8FIZApWdeRsA/0B/8RUGPZDaa7HvaqLZfL4oLMfs1WedMVN7GpgV3S4EVC1aLaxYShDF+2qrIt2D5h9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763135445; c=relaxed/simple;
	bh=gWuEqdXL4uGm4/GN2QCHlpQiA1HRAbOVm/For/nXLi0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=KV6rqApwseQpuIW5emPbk89Qf6C+Aamdc5e5z3biBdDswGxikaaAttyHnAqw4gbXNkN2ArnQJPSoohSkd+8y4+oRoyiZdLZ83sdH+99EpQtNEjQVZnroZtVK2INLUYsGrYfVvKk+7ZE20BjFRWs1/13PawdAx1ZDYqd01wLNeog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJ+TBhwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D56C4CEF1;
	Fri, 14 Nov 2025 15:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763135444;
	bh=gWuEqdXL4uGm4/GN2QCHlpQiA1HRAbOVm/For/nXLi0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=MJ+TBhwtivVjhfbu4/WCqrF8ilUPTpTbNDdXSNpZVn5711uvZRwM+ofkzYV8hKsWE
	 Jpj8Kj8PWnY1jm2UpiaQvCC4IrsKNdYcnVRRLkWRnKE+7LrdGqB9aiqQHtzlVu0Fgs
	 CHblkfajwgNxUOhv1pFV0rDiVP5hes3XK1my0F/PHnN4iTXenttzAh3gg9pExRhFI0
	 wevrBd4j4KEZei2b9va3RL8VUu/MusGQZZTBmTyoxwFhnvrYFKOiBjpET/WrxVzfyK
	 sd9cBnLyA/AqzICb/DBZ0L7mD47maVTQ/jhU2Q4Ri5q0GKs689oRGDK1o74Ps8QvMD
	 Sm+i8yQHgnT7w==
Content-Type: multipart/mixed; boundary="===============0174633250882976625=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3b15cc4d71bfa87ffcd49f69c1453d88c6457ef0c9c312c11b8a550f862e8f2b@mail.kernel.org>
In-Reply-To: <20251114152653.356782-1-skb99@linux.ibm.com>
References: <20251114152653.356782-1-skb99@linux.ibm.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix htab_update/reenter_update selftest failure
From: bot+bpf-ci@kernel.org
To: skb99@linux.ibm.com,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com,sachinpb@linux.ibm.com,venkat88@linux.ibm.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Nov 2025 15:50:44 +0000 (UTC)

--===============0174633250882976625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/htab_update.c b/tools/testing/selftests/bpf/prog_tests/htab_update.c
> index 2bc85f481..96b65c1a3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/htab_update.c
> +++ b/tools/testing/selftests/bpf/prog_tests/htab_update.c
> @@ -15,17 +15,17 @@ struct htab_update_ctx {
>  static void test_reenter_update(void)
>  {
>  	struct htab_update *skel;
> -	unsigned int key, value;
> +	void *value = NULL;
> +	unsigned int key, value_size;
                           ^^^

Is key supposed to be initialized? The old code had 'unsigned int key = 0,
value = 0;' but the new code drops the initialization. Later uses of key
at the bpf_map_update_elem() calls will pass uninitialized stack memory.

>  	int err;
>
>  	skel = htab_update__open();
>  	if (!ASSERT_OK_PTR(skel, "htab_update__open"))
>  		return;

[ ... ]

> @@ -33,14 +33,32 @@ static void test_reenter_update(void)
>  	if (!ASSERT_OK(err, "htab_update__attach"))
>  		goto out;
>
> -	/* Will trigger the reentrancy of bpf_map_update_elem() */
> -	key = 0;
> -	value = 0;
> -	err = bpf_map_update_elem(bpf_map__fd(skel->maps.htab), &key, &value, 0);
> -	if (!ASSERT_OK(err, "add element"))
> +	value_size = bpf_map__value_size(skel->maps.htab);
> +
> +	value = calloc(1, value_size);
> +	if (!ASSERT_OK_PTR(value, "calloc value"))
> +		goto out;
> +	/*
> +	 * First update: plain insert. This should NOT trigger the re-entrancy
> +	 * path, because there is no old element to free yet.
> +	 */
> +	err = bpf_map_update_elem(bpf_map__fd(skel->maps.htab), &key, &value, BPF_ANY);
> +	if (!ASSERT_OK(err, "first update (insert)"))
> +		goto out;
> +
> +	/*
> +	 * Second update: replace existing element with same key and trigger
> +	 * the reentrancy of bpf_map_update_elem().
> +	 * check_and_free_fields() calls bpf_obj_free_fields() on the old
> +	 * value, which is where fentry program runs and performs a nested
> +	 * bpf_map_update_elem(), triggering -EDEADLK.
> +	 */
> +	memset(&value, 0, sizeof(value));
               ^^^^^^^

Does this memset zero the allocated memory? It looks like this zeros the
pointer variable itself (8 bytes) rather than the memory it points to.
Should this be 'memset(value, 0, value_size)' instead?

> +	err = bpf_map_update_elem(bpf_map__fd(skel->maps.htab), &key, &value, BPF_ANY);
> +	if (!ASSERT_OK(err, "second update (replace)"))
>  		goto out;
>
> -	ASSERT_EQ(skel->bss->update_err, -EBUSY, "no reentrancy");
> +	ASSERT_EQ(skel->bss->update_err, -EDEADLK, "no reentrancy");
>  out:
>  	htab_update__destroy(skel);
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19369517166

--===============0174633250882976625==--

