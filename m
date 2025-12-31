Return-Path: <linux-kselftest+bounces-48030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C2ECEC6E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 19:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02B5130012D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 18:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276B02F5A22;
	Wed, 31 Dec 2025 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dd9E6Cgq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9FD2F5474;
	Wed, 31 Dec 2025 18:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767204255; cv=none; b=d+fXWjWYCQEVHS98M72KbclU3Rv/a5CDJ5ChRBmPShxTSNsxb7YEr3eEKErkoejv7Ie9fCqMS8b7C7sa/tLPd+kDTXZoG0MhTuMbpdp/5iXDvR7gBr7NXwXbrm/DTCrJkmqertiFGqKG1HTSDfq9XgV0/V3BAK6C7V4GcXtLews=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767204255; c=relaxed/simple;
	bh=0Ro/XQqblVYAcHi56aVJIXOsSIn7Ux3IzaTJsrElFYg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GMUlBJMl6Dh54So39ELOo0cqpLqhuK7CaHmRtB7Cu2uZjSR3Eqb1E9cTg7SBQ9oPx2wtSgGd0pqECwTyqHitv268OAtAruDnTXOVXw//ADiJ60vDsRV3JHGMmDFoUBJd3SGPKiKdM656ZnVNe8zmM9gBGJKFMj969+j5nTlnW3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dd9E6Cgq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCA9C113D0;
	Wed, 31 Dec 2025 18:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767204254;
	bh=0Ro/XQqblVYAcHi56aVJIXOsSIn7Ux3IzaTJsrElFYg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=dd9E6CgqjuFYXrdSBGiq5lsWev299NUcKd1xVS1RKFPZZZyM30QY31MvqGgsiSpu1
	 f/+/caqUZitQGpRxRWkODAmz/Ba+DTMSDUoDm0TtOJoPHK/rR8Hp7hRtTcRbAPJbHK
	 nYzgsL4iaPCKzf7Ry9Lu3sNQHqGINWt5sJ7kqfrxbscHUPIY5RKxUgG/vLsbOY3Xn+
	 Dc2H1sXmW2k1Hj/qphuHnH1KkDa34WemgE/glkWH3HT6D+ZSCR+csvHpfTFZzsjKyL
	 FpFShgn/otYQwLUfwe30RgJi8RNJiN/a+jFC1Y2KQk/w6POn4OaI6dHxCNeYvvcNoS
	 +xQampOmp7r+A==
Content-Type: multipart/mixed; boundary="===============5488489058363418599=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e9a1bd633fb4bb3d2820f63f41a8dd60d8c9c5e3c699fa56057ae393ef2f31d0@mail.kernel.org>
In-Reply-To: <20251231173633.3981832-6-csander@purestorage.com>
References: <20251231173633.3981832-6-csander@purestorage.com>
Subject: Re: [PATCH 5/5] selftests/bpf: make cfi_stubs globals const
From: bot+bpf-ci@kernel.org
To: csander@purestorage.com,jikos@kernel.org,bentiss@kernel.org,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,tj@kernel.org,void@manifault.com,arighi@nvidia.com,changwoo@igalia.com,mingo@redhat.com,peterz@infradead.org,juri.lelli@redhat.com,vincent.guittot@linaro.org,dietmar.eggemann@arm.com,rostedt@goodmis.org,bsegall@google.com,mgorman@suse.de,vschneid@redhat.com,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,dsahern@kernel.org,jhs@mojatatu.com,xiyou.wangcong@gmail.com,jiri@resnulli.us,alibuda@linux.alibaba.com,dust.li@linux.alibaba.com,sidraya@linux.ibm.com,wenjia@linux.ibm.com,mjambigi@linux.ibm.com,tonylu@linux.alibaba.com,guwen@linux.alibaba.com,shuah@kernel.org,mcoquelin.stm32@gmail.com,alexandre.torgue@foss.st.com
Cc: linux-input@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,sched-ext@lists.linux.dev,linux-rdma@vger.kernel.org,linux-s390@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-stm32@st-md-mailman.stormreply.com,linux-arm-kernel@lists.infradead.org,csander@purestorage.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 31 Dec 2025 18:04:13 +0000 (UTC)

--===============5488489058363418599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index 90c4b1a51de6..5e460b1dbdb6 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c

[ ... ]

> @@ -1275,7 +1275,7 @@ bpf_testmod_ops__test_return_ref_kptr(int dummy, struct task_struct *task__ref,
>  	return NULL;
>  }
>
> -static struct bpf_testmod_ops __bpf_testmod_ops = {
> +static const struct bpf_testmod_ops __bpf_testmod_ops = {
>  	.test_1 = bpf_testmod_test_1,
>  	.test_2 = bpf_testmod_test_2,

Is it safe to make __bpf_testmod_ops const here? In bpf_testmod_init(),
this struct is modified at runtime:

    tramp = (void **)&__bpf_testmod_ops.tramp_1;
    while (tramp <= (void **)&__bpf_testmod_ops.tramp_40)
        *tramp++ = bpf_testmod_tramp;

Writing to a const-qualified object is undefined behavior and may cause a
protection fault when the compiler places this in read-only memory. Would
the module fail to load on systems where .rodata is actually read-only?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20624206229

--===============5488489058363418599==--

