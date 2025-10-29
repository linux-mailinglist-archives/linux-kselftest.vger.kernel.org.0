Return-Path: <linux-kselftest+bounces-44297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C261C1B501
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 15:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD4CF5A78A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 14:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5249C27A462;
	Wed, 29 Oct 2025 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtnLJZah"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DC626C39F;
	Wed, 29 Oct 2025 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747953; cv=none; b=DsDp0M1uypvLrEbynzel9FYeRkdFL1cphSXBXdGPT2DlgkDfbdZXmo6QpyMKT/njuQ+o26KDqQkowU9K7DTz5J0GyuH2SSPRb4qjxPdZU0eIiXelrqXWUjhzL3vMImXK/N8iFZbxY1IjMlIl+5bDFafnSg/bCqucpZrnpZWKHEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747953; c=relaxed/simple;
	bh=eX4MwDdVNFiSJIUIDmCiZKp9nu2G7K/VXocP8qjTRlw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=k51XZIZXEFlnu7PQKtXgNFl83Zd5pd5C4a+PmvY7HNgaFwVz/YUHjkmNEI+sZe2AEPg8BAz6mD10tnZ12luGwYnvYpAfTzrBb621hgTTgRa11SCcHlhKdYQhg03SSt8HSJBRFm1DC9jNCTwRMpIuK9MwQNuUEI7UACkpbA/IyIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtnLJZah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74334C4CEF7;
	Wed, 29 Oct 2025 14:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761747953;
	bh=eX4MwDdVNFiSJIUIDmCiZKp9nu2G7K/VXocP8qjTRlw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=rtnLJZah0zkZY3E6GlkRXjyP9ZgcQTQOeXraInstDmxh/JWMNN1qhZVMoM6uCAAjl
	 zwnFSbvoj5xyi84d88E3+p6/xWog3LorSHHeLWlKN8lpJe7uU00/Lsm4BvqtavBPR6
	 idp/kNGr3VGLyq7WkqDSwI/aHNXl9LVD9chEboM+4MfCY4jvsFBSENBiDP9eS3gMk8
	 XM4c4tD5euqtU9yxPlz8avj5nAB5iUbBpKEVt8dI4drAott6zUS+M/1XoXP2QcoLdH
	 4Ik8K5o6zXtoIpVG2sPIqqVjbCSaLn3VBHPzluBYNwC41G/Xv0YBbXvej8uT8OqO0x
	 gNDJBviXt7ulw==
Content-Type: multipart/mixed; boundary="===============7495328656080687778=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b13f0f29e5f3308b5b2d973237634a7a7ec7c7be034227a633d6e49ed9f657cd@mail.kernel.org>
In-Reply-To: <20251029-xsk-v6-12-5a63a64dff98@bootlin.com>
References: <20251029-xsk-v6-12-5a63a64dff98@bootlin.com>
Subject: Re: [PATCH bpf-next v6 12/15] selftests/bpf: test_xsk: Don't exit immediately if validate_traffic fails
From: bot+bpf-ci@kernel.org
To: bastien.curutchet@bootlin.com,bjorn@kernel.org,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,jonathan.lemon@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,mykolal@fb.com,shuah@kernel.org,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org
Cc: thomas.petazzoni@bootlin.com,alexis.lothore@bootlin.com,netdev@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,bastien.curutchet@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 29 Oct 2025 14:25:50 +0000 (UTC)

--===============7495328656080687778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit 5ed620bf5df1b2a38af461580d5207eadf5c552e
Author: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>

selftests/bpf: test_xsk: Don't exit immediately if validate_traffic fails

This changes __testapp_validate_traffic() to return TEST_FAILURE instead
of calling exit_with_error(), and adds cleanup for sockets and umem
before returning on pthread_barrier_destroy() failure.

> diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
> index 2c392d5b9..18a6ce648 100644
> --- a/tools/testing/selftests/bpf/test_xsk.c
> +++ b/tools/testing/selftests/bpf/test_xsk.c
> @@ -1772,12 +1772,12 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
>  	err = test_spec_set_mtu(test, test->mtu);
>  	if (err) {
>  		ksft_print_msg("Error, could not set mtu.\n");
> -		exit_with_error(err);
> +		return TEST_FAILURE;
>  	}
>
>  	if (ifobj2) {
>  		if (pthread_barrier_init(&barr, NULL, 2))
> -			exit_with_error(errno);
> +			return TEST_FAILURE;
>  		pkt_stream_reset(ifobj2->xsk->pkt_stream);
>  	}
>

[ ... ]

> @@ -1791,8 +1791,11 @@ static int __testapp_validate_traffic(struct test_spec *test, struct ifobject *i
>
>  	if (ifobj2) {
>  		pthread_barrier_wait(&barr);
> -		if (pthread_barrier_destroy(&barr))
> -			exit_with_error(errno);
> +		if (pthread_barrier_destroy(&barr)) {
> +			clean_sockets(test, ifobj1);
> +			clean_umem(test, ifobj1, NULL);
> +			return TEST_FAILURE;
> +		}
>
>  		/*Spawn TX thread */
>  		pthread_create(&t1, NULL, ifobj2->func_ptr, test);

In __testapp_validate_traffic(), thread t0 is created via pthread_create()
before the barrier operations. If pthread_barrier_destroy() fails, can this
leak thread t0?

The pthread_create(&t0, ...) happens earlier in the function. The normal
execution paths handle t0 via pthread_kill() or pthread_join(), but when
pthread_barrier_destroy() fails, the new error path calls clean_sockets()
and clean_umem() but never joins or kills t0 before returning TEST_FAILURE.

The commit message says "Release the resource of the 1st thread if a
failure happens between its creation and the creation of the second
thread", but the code only releases sockets and umem.


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `selftests/bpf: test_xsk: Don't exit immediately if validate_traffic fails`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18910697393

--===============7495328656080687778==--

