Return-Path: <linux-kselftest+bounces-44509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D27C23DDD
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 09:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7223BFF72
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 08:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A402FD7A0;
	Fri, 31 Oct 2025 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFI0lSAR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342612236E9;
	Fri, 31 Oct 2025 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900129; cv=none; b=gUnwpaHWK1iu8UEc9ZvG6S3EPLWZQw2Wb8VaDs2IUOxqMqGFYMRHQ4ccXDT13s092FIN8fq8dC4k6/L+DpriyfI8MjWzx1csUzt9vgkuM7Vkym46fGtzsnZUJ7wKTFPlUgF0Hc+EBXuxVlPZWAFIzf1aCBcR/T9BatP4Qqzg0J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900129; c=relaxed/simple;
	bh=LsmQ6z8kGwXnSdHnI7TPSjdstl879Pup1qDCMjeA4rw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hlCpnICt2AxT93ETEyftf+8AM8A/VKPJIKvcODvNZELjBxd3wB6pzAnlBfNT/5sDkT2w4hawnYbu0GWnPCtkt6er98LPjW8ngR9wkKn7okLBjAzX5mNhvPP6H6K6ebLfFBp18MOqlKFN0l35vOTzKPV76S5KOPahEcfn7A+sgkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFI0lSAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2A0C4CEE7;
	Fri, 31 Oct 2025 08:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761900127;
	bh=LsmQ6z8kGwXnSdHnI7TPSjdstl879Pup1qDCMjeA4rw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=fFI0lSARsMuen0hxaJMWksTtXNtNWHhD4Eam+cVMPDOZbdGKroQY3oB3EBaQW7o03
	 /VDIZ/m+x1E/rd6vu9K8uMZpBPmXeIWcrVxwbmjbjZnK6L/D8+fvlH3Zm1tI1tKR3D
	 5cC8lM7hiqnEKPAQsGhDjazsSdPjWpN2fhhHNkkPfZHBpueAbxsj3XrSweOD6n9eC+
	 PsGvqn9liaB0Oa4j3TP6HJCUPo8TklenswjW87iyjkw7oAXFxXygmofEoEAAimf5pA
	 r5Btz/M0Q6ikHYpd4aj+cHQIn9jRTNXRHpMfb62w/7Cel1xpRhxtmqFV4JI3kmZbZO
	 QPT093Tskxctg==
Content-Type: multipart/mixed; boundary="===============4140934912037261014=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8601d952a9b55c901d849b856698b2567eafcd09a9b80d144e786a9d0b037d9e@mail.kernel.org>
In-Reply-To: <20251031-xsk-v7-9-39fe486593a3@bootlin.com>
References: <20251031-xsk-v7-9-39fe486593a3@bootlin.com>
Subject: Re: [PATCH bpf-next v7 09/15] selftests/bpf: test_xsk: Don't exit immediately when xsk_attach fails
From: bot+bpf-ci@kernel.org
To: bastien.curutchet@bootlin.com,bjorn@kernel.org,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,jonathan.lemon@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,mykolal@fb.com,shuah@kernel.org,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org
Cc: thomas.petazzoni@bootlin.com,alexis.lothore@bootlin.com,netdev@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,bastien.curutchet@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 31 Oct 2025 08:42:07 +0000 (UTC)

--===============4140934912037261014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit f4ff202b333a83faed1f820153ca90a030e95808
Author: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>

selftests/bpf: test_xsk: Don't exit immediately when xsk_attach fails

This commit changes xsk_reattach_xdp() and xsk_attach_xdp_progs() from
void to int return types to propagate errors instead of calling
exit_with_error(), allowing tests to continue after attachment failures.

> diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
> index 7db1d974e..0adb6c0b9 100644
> --- a/tools/testing/selftests/bpf/test_xsk.c
> +++ b/tools/testing/selftests/bpf/test_xsk.c
> @@ -1643,7 +1643,7 @@ static bool xdp_prog_changed_tx(struct test_spec *test)
>  	return ifobj->xdp_prog != test->xdp_prog_tx || ifobj->mode != test->mode;
>  }
>
> -static void xsk_reattach_xdp(struct ifobject *ifobj, struct bpf_program *xdp_prog,
> +static int xsk_reattach_xdp(struct ifobject *ifobj, struct bpf_program *xdp_prog,
>  			     struct bpf_map *xskmap, enum test_mode mode)
>  {
>  	int err;
> @@ -1652,31 +1652,40 @@ static void xsk_reattach_xdp(struct ifobject *ifobj, struct bpf_program *xdp_pro
>  	err = xsk_attach_xdp_program(xdp_prog, ifobj->ifindex, mode_to_xdp_flags(mode));
>  	if (err) {
>  		ksft_print_msg("Error attaching XDP program\n");
> -		exit_with_error(-err);
> +		return err;
>  	}
>
>  	if (ifobj->mode != mode && (mode == TEST_MODE_DRV || mode == TEST_MODE_ZC))
>  		if (!xsk_is_in_mode(ifobj->ifindex, XDP_FLAGS_DRV_MODE)) {
>  			ksft_print_msg("ERROR: XDP prog not in DRV mode\n");
> -			exit_with_error(EINVAL);
> +			return -EINVAL;
>  		}
>
>  	ifobj->xdp_prog = xdp_prog;
>  	ifobj->xskmap = xskmap;
>  	ifobj->mode = mode;
> +
> +	return 0;

Can xsk_reattach_xdp() leave the XDP program attached when the mode check
fails?

The flow is:
1. xsk_detach_xdp_program() removes old XDP program
2. xsk_attach_xdp_program() attaches new program (succeeds)
3. xsk_is_in_mode() check fails
4. ifobj state updated to reflect new attachment
5. Returns -EINVAL

At this point the new XDP program is attached to the interface but the
function returned an error. Should the newly attached program be detached
on this error path, or should the ifobj state updates be moved after all
checks pass?

>  }
>
> -static void xsk_attach_xdp_progs(struct test_spec *test, struct ifobject *ifobj_rx,
> +static int xsk_attach_xdp_progs(struct test_spec *test, struct ifobject *ifobj_rx,
>  				 struct ifobject *ifobj_tx)
>  {

[ ... ]

> @@ -1789,7 +1798,8 @@ static int testapp_validate_traffic(struct test_spec *test)
>  		}
>  	}
>
> -	xsk_attach_xdp_progs(test, ifobj_rx, ifobj_tx);
> +	if (xsk_attach_xdp_progs(test, ifobj_rx, ifobj_tx))
> +		return TEST_FAILURE;
>  	return __testapp_validate_traffic(test, ifobj_rx, ifobj_tx);
>  }


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `selftests/bpf: test_xsk: Don't exit immediately when xsk_attach fails`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18966766839

--===============4140934912037261014==--

