Return-Path: <linux-kselftest+bounces-37111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C71ABB01DFA
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 15:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68F31CC0B99
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 13:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E572D46A4;
	Fri, 11 Jul 2025 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFqogJIN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1AC3A1CD;
	Fri, 11 Jul 2025 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241160; cv=none; b=XXwbXDtfV4ZUQuYKz87ToMQEHn/j2qPf32HSF92GHGSk+VxSmc1sxyTbO0PfNkYaHFUe/IkrRmBM8+UWNg6wC4EZEmYFyWlFEnYgyN/KonB4AxfRcu8LSH17M+fFABzLkFjbGHbRW4NqoroAk5G7Gw/ftDjbCdZAI6B40sf2wEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241160; c=relaxed/simple;
	bh=eFgED19dQRcbU4DIqiWV1GygAUnicd546BK4INZAAss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0pcEQDrnH8uF69nrSK635L3jPZA6wjUX6vz5TSnMSB+KF2pyIZLnniLNEXAjZ6q1N+cAfKDfCaecZy2gS3bMA8fEuaNQ3KyCJcdkyXTLnU4M1pMOC2RdXexH5Wo83DBbB++cKr0DyAZfJ2RVYemmca/HHNqjVmddPsjqv8ItgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFqogJIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC08C4CEED;
	Fri, 11 Jul 2025 13:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752241159;
	bh=eFgED19dQRcbU4DIqiWV1GygAUnicd546BK4INZAAss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dFqogJINkHleezubFaTYRjl9rOp7Qu3v6UH1d2kfuLU5Att7mBp+vYht8FbPQ2OLj
	 7MhhtQkPYEZxklTihibLlMUGol5w/Xp99J4gsFDg9gRDfNTXKNmFb1CkawU+l0Ew/5
	 /A1yj3bLqkYUEgvw8IbL7LwWDPQqLaTU3V1+bbqaB/c56AEgU4h6Yd1hVgeGC2DGWC
	 SPKFNohRdYyeFos9QOEHPd6O7Q+9RRSBSlNmkJBKYRE7vKv/KR85ywFxMI7st/L3MR
	 ODx7cS5YtdOXPKjxmvkCcF6W4TkJnDTWGLDm5UfRwhddzARKVf4GjgS/B+uUmDVc+4
	 Zkfu7ZLi/2d7w==
Date: Fri, 11 Jul 2025 06:39:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 cratiu@nvidia.com, noren@nvidia.com, cjubran@nvidia.com, mbloch@nvidia.com,
 jdamato@fastly.com, gal@nvidia.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next V2 0/5] selftests: drv-net: Test XDP native
 support
Message-ID: <20250711063917.7aad27f7@kernel.org>
In-Reply-To: <20250710184351.63797-1-mohsin.bashr@gmail.com>
References: <20250710184351.63797-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 11:43:46 -0700 Mohsin Bashir wrote:
> This patch series add tests to validate XDP native support for PASS,
> DROP, ABORT, and TX actions, as well as headroom and tailroom adjustment.
> For adjustment tests, validate support for both the extension and
> shrinking cases across various packet sizes and offset values.

The program does not load in the CI :(

509: (15) if r1 == 0x0 goto pc+142    ; frame1: R1=scalar(smin=umin=umin32=1,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
510: (25) if r1 > 0x100 goto pc+141   ; frame1: R1=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=256,var_off=(0x0; 0x1ff))
511: (bf) r3 = r10                    ; frame1: R3_w=fp0 R10=fp0\n; if (bpf_xdp_load_bytes(ctx, 0, tmp_buff, hdr_len) < 0) @ xdp_native.bpf.c:377
512: (07) r3 += -256                  ; frame1: R3_w=fp-256
513: (bf) r1 = r7                     ; frame1: R1_w=ctx() R7=ctx()
514: (b7) r2 = 0                      ; frame1: R2_w=0
515: (bf) r4 = r8                     ; frame1: R4_w=scalar(id=3) R8=scalar(id=3)
516: (7b) *(u64 *)(r10 -280) = r5     ; frame1: R5=32 R10=fp0 fp-280_w=32
517: (85) call bpf_xdp_load_bytes#189
R4 min value is negative, either use unsigned or 'var &= const'
processed 262 insns (limit 1000000) max_states_per_insn 1 total_states 26 peak_states 26 mark_read 7
-- END PROG LOAD LOG

I suppose it may be due to compiler version:
$ clang --version
clang version 15.0.7 (AWS 15.0.7-3.amzn2023.0.4)

LMK if you need more info / can't repro, but I think the suggestion
makes sense?

