Return-Path: <linux-kselftest+bounces-44298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBE3C1B3D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 15:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62741A63534
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 14:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CCF29B778;
	Wed, 29 Oct 2025 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyzeamCx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EAE279DAD;
	Wed, 29 Oct 2025 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747957; cv=none; b=tCGMkbH0V0IzXg8+zcI+mHjnpq8xeqGpJ98gAiCPd5hYKIW09Mf20hzyUKHFLOSZoIdSeiiEdXuvBz3GyuBjdSLBs4xRpxXWK0S4N9PLbalSOkMzTMutdeP/VFGdUPAbqaJWWzqM9lOSdwcdqx+W52VfaUa6ESQ3/S+dN/lnftk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747957; c=relaxed/simple;
	bh=/+m6iaLC0y8uWmkcCY6x46zjKoMEvP59Em2DnUNlUQQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=diA7VjPN++5vTwB68fQ9EfJuG5a5cuUzKZqkwu1/XX9TQ0y1PPnp+UKVIHa2TuofyXycddgTOwk02NA9RI+s64kHhU1wFppl6KqAyCj1mfgJFbmbdSc/fyj310GEVMtq7yERC07f9hrxIfQCj4IKHKFzbpt6tPVAbX1Obp/kwok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyzeamCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AEAC4CEF8;
	Wed, 29 Oct 2025 14:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761747957;
	bh=/+m6iaLC0y8uWmkcCY6x46zjKoMEvP59Em2DnUNlUQQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=tyzeamCxzKQNjRoRx/GdN3bKl+3qM4dQEvmBtQC9RnsBFsXj+OmD29nwII9XnqHHS
	 yp4CVGDsaxCKMYQbhRcdjjzWfmzs2aszsf/DSeQUoqIqftsQ6LCGdQiVwcbpx4p6Vh
	 +4iu2EorZg668PD06pWjAmISJoPmG73YPbc4lZNhmkobdgjdii5pYAfGeENbiyNBsj
	 c8JyOVD78DBgAf0RYVCyuAvRH8zoUWsUfcNLZuT8sbNH4WGqNaHT9xHbSKCGobzECi
	 mor1Fg+QN/K51Q4Ki0r6X546M5fM12Oqo9VClqs08BWs6KaaYaBKHDOTcqIHI9V70S
	 1eUYT3bn41r7w==
Content-Type: multipart/mixed; boundary="===============3524767868395641498=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5c1c4101d42cc486366273556492d9be559f521d16629bbcd6b3adc6a4b746f0@mail.kernel.org>
In-Reply-To: <20251029-xsk-v6-11-5a63a64dff98@bootlin.com>
References: <20251029-xsk-v6-11-5a63a64dff98@bootlin.com>
Subject: Re: [PATCH bpf-next v6 11/15] selftests/bpf: test_xsk: Don't exit immediately when workers fail
From: bot+bpf-ci@kernel.org
To: bastien.curutchet@bootlin.com,bjorn@kernel.org,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,jonathan.lemon@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,mykolal@fb.com,shuah@kernel.org,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org
Cc: thomas.petazzoni@bootlin.com,alexis.lothore@bootlin.com,netdev@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,bastien.curutchet@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 29 Oct 2025 14:25:54 +0000 (UTC)

--===============3524767868395641498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit f89231e503dc0b97c81f4bb32d28532fb3471acd
Author: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>

selftests/bpf: test_xsk: Don't exit immediately when workers fail

This commit converts the test program from using exit_with_error()
(which immediately terminates) to proper error propagation through
return values. This allows the test suite to continue running after
failures.

> diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
> index 2c955e109..2c392d5b9 100644
> --- a/tools/testing/selftests/bpf/test_xsk.c
> +++ b/tools/testing/selftests/bpf/test_xsk.c

[ ... ]

> @@ -759,7 +761,7 @@ static bool is_metadata_correct(struct pkt *pkt, void *buffer, u64 addr)
>  	return true;
>  }
>
> -static bool is_adjust_tail_supported(struct xsk_xdp_progs *skel_rx)
> +static int is_adjust_tail_supported(struct xsk_xdp_progs *skel_rx, bool *supported)
>  {
>  	struct bpf_map *data_map;
>  	int adjust_value = 0;
> @@ -769,19 +771,21 @@ static bool is_adjust_tail_supported(struct xsk_xdp_progs *skel_rx)
>  	data_map = bpf_object__find_map_by_name(skel_rx->obj, "xsk_xdp_.bss");
>  	if (!data_map || !bpf_map__is_internal(data_map)) {
>  		ksft_print_msg("Error: could not find bss section of XDP program\n");
> -		exit_with_error(errno);
> +		return -EINVAL;
>  	}
>
>  	ret = bpf_map_lookup_elem(bpf_map__fd(data_map), &key, &adjust_value);
>  	if (ret) {
>  		ksft_print_msg("Error: bpf_map_lookup_elem failed with error %d\n", ret);
> -		exit_with_error(errno);
> +		return ret;
>  	}
>
>  	/* Set the 'adjust_value' variable to -EOPNOTSUPP in the XDP program if the adjust_tail
>  	 * helper is not supported. Skip the adjust_tail test case in this scenario.
>  	 */
> -	return adjust_value != -EOPNOTSUPP;
> +	*supported = adjust_value != -EOPNOTSUPP;
> +
> +	return 0;
>  }

[ ... ]

> @@ -1584,29 +1614,41 @@ void *worker_testapp_validate_rx(void *arg)
>  	int err;
>
>  	if (test->current_step == 1) {
> -		thread_common_ops(test, ifobject);
> +		err = thread_common_ops(test, ifobject);
>  	} else {
>  		xsk_clear_xskmap(ifobject->xskmap);
>  		err = xsk_update_xskmap(ifobject->xskmap, ifobject->xsk->xsk, 0);
> -		if (err) {
> +		if (err)
>  			ksft_print_msg("Error: Failed to update xskmap, error %s\n",
>  				       strerror(-err));
> -			exit_with_error(-err);
> -		}
>  	}
>
>  	pthread_barrier_wait(&barr);
>
> +	/* We leave only now in case of error to avoid getting stuck in the barrier */
> +	if (err) {
> +		test->fail = true;
> +		pthread_exit(NULL);
> +	}
> +
>  	err = receive_pkts(test);
>
>  	if (!err && ifobject->validation_func)
>  		err = ifobject->validation_func(ifobject);
>
>  	if (err) {
> -		if (test->adjust_tail && !is_adjust_tail_supported(ifobject->xdp_progs))
> -			test->adjust_tail_support = false;
> -		else
> +		if (!test->adjust_tail) {
>  			test->fail = true;
> +		} else {
> +			bool supported;
> +
> +			if (is_adjust_tail_supported(ifobject->xdp_progs, &supported))
> +				test->fail = true;
> +			if (!supported)
> +				test->adjust_tail_support = false;
> +			else
> +				test->fail = true;
> +		}
>  	}

Can the 'supported' variable be read uninitialized here? When
is_adjust_tail_supported() returns an error (non-zero), it doesn't
write to the *supported output parameter. The function returns early
from either the data_map check or bpf_map_lookup_elem() failure without
setting *supported. Then the code unconditionally checks "if (!supported)"
which would read uninitialized stack memory.

The control flow is:
  is_adjust_tail_supported() returns error
  -> test->fail = true is set
  -> execution continues to "if (!supported)"
  -> reads uninitialized 'supported' variable

Should this be structured with an else clause to only check 'supported'
when is_adjust_tail_supported() returns success?


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `selftests/bpf: test_xsk: Don't exit immediately when workers fail`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18910697393

--===============3524767868395641498==--

