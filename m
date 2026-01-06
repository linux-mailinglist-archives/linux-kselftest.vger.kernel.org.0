Return-Path: <linux-kselftest+bounces-48336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CBACF9EF6
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 19:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5982230299F2
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 18:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BB434FF64;
	Tue,  6 Jan 2026 17:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yi8mYVt8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BAF34B1AE;
	Tue,  6 Jan 2026 17:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721471; cv=none; b=I/B2/UOO2sK8Y2m00T3Q8JH8aHmoGhG0w57z5oyAATEg5yXZiOTsl2m5lhrvKdRH6HPLUaSXRMdq+1xVZa5unf5oHAhGfNa5YFUySpD/oZRRkYzGRRCF61Bg08BeDIKSId2i/2TtDwtmYIcseNVgqIhTY1VRB4qYzqGEncCTHpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721471; c=relaxed/simple;
	bh=laYqOL5e+Dyr/33tSA3p8NIZiT4lV2AVKHO90HrI+Tw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=L+RXUhZCyT5lcPaAgEWf1M3VfYFGCtKql2+I2WZcOzlQI5iX6fKDodfHuAGuswSsVelYBWRXIYNr6f7k9o2eyjIQOLtPhWMPlonE3lQflDB5x6UI7jXeLtJbtGJrsz+jupkX/21hucCIklGXj5gQBmRiaMbMBpDf9WVkUgBJA/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yi8mYVt8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5B5C116C6;
	Tue,  6 Jan 2026 17:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767721470;
	bh=laYqOL5e+Dyr/33tSA3p8NIZiT4lV2AVKHO90HrI+Tw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Yi8mYVt8t6s0y5JSo5uoh5xuFuh6cB66j010+1x90/15GxYS+PMwHMgsWb9Ex4l9x
	 t/2MZUFJ3/F4p23QdNkbhTyPezoFhv8lCyb0a/oAHLTj1haYdWeRcCJHMNrmfFXQov
	 QsuYYfQvmYcof0dW9QyPcgnla7QYKNuqEikF99/7xpaWY+/kZTvnr0ifa0riSzj9iV
	 zWFwAT8WLAdy1tPlx6n97PZDbsepyo2jqpEW2q75w6ddGRp6D0cLGEkhRzp8aoAsTw
	 DIOIkvboeUGm6Cf/k3Vlswn9K98FhmRAojvyEcxrJ3VU1tAdM4jyApkgQ5/ILTaTF6
	 9xrk0zs64aQkQ==
Content-Type: multipart/mixed; boundary="===============3537800355671611745=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <53542ad28c0d27ffcfcf9ea325fb6a77eeb3d569e17a6fad9d95685b5ea25467@mail.kernel.org>
In-Reply-To: <20260106172018.57757-4-leon.hwang@linux.dev>
References: <20260106172018.57757-4-leon.hwang@linux.dev>
Subject: Re: [RESEND PATCH bpf-next v4 3/9] bpf: Refactor reporting log_true_size for prog_load
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,brauner@kernel.org,oleg@redhat.com,leon.hwang@linux.dev,sforshee@kernel.org,yuichtsu@amazon.com,aalbersh@redhat.com,willemb@google.com,kerneljasonxing@gmail.com,paul.chaignon@gmail.com,yatsenko@meta.com,memxor@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,rongtao@cestc.cn,linux-kernel@vger.kernel.org,linux-api@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  6 Jan 2026 17:44:30 +0000 (UTC)

--===============3537800355671611745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 8f464b847405..1739601fb7bd 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> @@ -6160,12 +6160,22 @@ static int prog_assoc_struct_ops(union bpf_attr *attr)
>  	return ret;
>  }
>
> +static int copy_prog_load_log_true_size(union bpf_attr *attr, bpfptr_t uattr, unsigned int size)
> +{
> +	if (size >= offsetofend(union bpf_attr, log_true_size) &&
> +	    copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, log_true_size),
> +				  &attr->log_true_size, sizeof(attr->log_true_size)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>  static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
>  		     bpfptr_t uattr_common, unsigned int size_common)
>  {
>  	struct bpf_common_attr common_attrs;
>  	union bpf_attr attr;
> -	int err;
> +	int err, ret;

[ ... ]

> @@ -6215,7 +6225,10 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size,
>  		err = map_freeze(&attr);
>  		break;
>  	case BPF_PROG_LOAD:
> -		err = bpf_prog_load(&attr, uattr, size);
> +		attr.log_true_size = 0;
> +		err = bpf_prog_load(&attr, uattr);
> +		ret = copy_prog_load_log_true_size(&attr, uattr, size);
> +		err = ret ? ret : err;
                    ^^^^^^^^^^^^^^^^^^^^

If bpf_prog_load() succeeds, it returns a positive file descriptor.
Then if copy_prog_load_log_true_size() fails with -EFAULT, this line
overwrites err with -EFAULT, losing the FD value.

The BPF program has already been loaded and the FD allocated at this
point. Since the FD is never returned to userspace, the program
remains loaded but unreachable - could this leak the BPF program?

In the previous code, the copy_to_bpfptr_offset() happened inside
bpf_check() before the program was fully committed:

    if (uattr_size >= offsetofend(...) &&
        copy_to_bpfptr_offset(...)) {
            ret = -EFAULT;
            goto err_release_maps;
        }

This goto caused bpf_check() to return an error, preventing the FD
allocation in bpf_prog_load(). Moving the copy outside changes the
semantics - the FD can now be allocated before a copy failure occurs.

> +		break;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20756616585

--===============3537800355671611745==--

