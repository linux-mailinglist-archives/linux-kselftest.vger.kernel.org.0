Return-Path: <linux-kselftest+bounces-3568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F278183C48B
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 15:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2861F259AF
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 14:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBB4634FE;
	Thu, 25 Jan 2024 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNKyaXE+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D590634F8;
	Thu, 25 Jan 2024 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706192280; cv=none; b=PfrESHDbAt5nXBlkfaw0tP9AiI+ttWB6Z6himZuj3CVTkPalwtAG1c5sGS0CeAS2xa3Q5asVeuoyRGWTBJCvWgLHoVrtIuBb1zFQb0s8EQU4Wy8TD1E3+L7mBbf95rgKTxZH5YnihFp6hBFbNItMm50LLmC+tiDt4Au9hl81PnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706192280; c=relaxed/simple;
	bh=icWiZwOM74Kh14wiFXqt9/kp2dLbWV7CDIOrBFY5Mlg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B+CUgchs3p5857cRMhGH7RMQ5YD8pW7krInw+rVaPXwDzzZ8283NBVLDoDOktpldYFO8KqQXEbFZIcylCRIldQT4xaqky2odtAe1cr7l/vkrN2St1Glq2N/eNP7UjRFDGigS5UCyW+krS4cxfeW3n7elyvyRx/E8taM7I6ZDU0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNKyaXE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06E9C433B2;
	Thu, 25 Jan 2024 14:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706192280;
	bh=icWiZwOM74Kh14wiFXqt9/kp2dLbWV7CDIOrBFY5Mlg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hNKyaXE+he/7ACg9ofxnearlpXJA12D+Mu2BaDw3ADC8q9AW21Zwd4SM01WvBeBro
	 WqDWRbQILPr+gUDWScvimFpBlum8LcmvwCMfFWkP7Lj4iy5ktPm+l0R8r5Xtc3syqk
	 WTmn4eN230sREfv3PcFV0bO21SWS95aKjryZRK8/RTxZdxfu4rGG+T2ay+VQTF/5Vm
	 PNFiOWeWP1JTYzYTPTwPSavJ9ZrQM5lQPYDSC69+8UDOgC4ZRZceE8Noo1eZ6jGzaD
	 QK90ocqx1v+rWP9vt7tsgaSbs8fINsIv/rwbWQw7jnbC+/Iay3EwluX/6u82kWLflu
	 SWhEatGJP7aog==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Mykola
 Lysenko <mykolal@fb.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Include runner extras for
 install target
In-Reply-To: <20240125122715.1443022-1-bjorn@kernel.org>
References: <20240125122715.1443022-1-bjorn@kernel.org>
Date: Thu, 25 Jan 2024 15:17:57 +0100
Message-ID: <87h6j14huy.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> When using the "install" or targets depending on install, e.g.
> "gen_tar", the "runner extras" weren't included for the BPF machine
> flavors.
>
> Make sure the necessary helper scripts/tools are added to
> corresponding BPF machine flavor.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
> tools/testing/selftests/bpf/Makefile | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index fd15017ed3b1..a5e63ef78bf1 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -747,5 +747,15 @@ override define INSTALL_RULE
>  	@for DIR in $(TEST_INST_SUBDIRS); do		  \
>  		mkdir -p $(INSTALL_PATH)/$$DIR;   \
>  		rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;\
> +		rsync -a --copy-unsafe-links \
> +			$(OUTPUT)/$$DIR/bpf_testmod.ko \
> +			$(OUTPUT)/$$DIR/bpftool \
> +			$(OUTPUT)/$$DIR/ima_setup.sh \
> +			$(OUTPUT)/$$DIR/liburandom_read.so \
> +			$(OUTPUT)/$$DIR/sign-file \
> +			$(OUTPUT)/$$DIR/uprobe_multi \
> +			$(OUTPUT)/$$DIR/urandom_read \
> +			$(OUTPUT)/$$DIR/verify_sig_setup.sh \
> +			$(OUTPUT)/$$DIR/xdp_synproxy $(INSTALL_PATH)/$$DIR;\

Nevermind this patch. The btf_dump_test_case*.c files are missing. I'll
spin a v2 (and also try to avoid the name duplication from
TRUNNER_EXTRA_FILES).

Bj=C3=B6rn

