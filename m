Return-Path: <linux-kselftest+bounces-21091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CCF9B6080
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 11:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CEF9B22FBA
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 10:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E846F1E3DEB;
	Wed, 30 Oct 2024 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZYBpdp2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A978A1E3DD7;
	Wed, 30 Oct 2024 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730285409; cv=none; b=VJMqJmNrPBHEsD7OKGMDsGHoV9mpWQn8T2CR1R8xCe5tqal5aH30XqqbzMmZ0lSDy3sBlwqlLAJAr0KIuS6eBBatCD4Z2KhTXgsOcHlhozaEoolBDH91n2HZ7gcz0qzXCTSrBaa268U/RXEsLO0W8Vow6TUVbBuP9zhJxieP3Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730285409; c=relaxed/simple;
	bh=Xa2VhNuRqurWKjZDUhItHsHTIqISQSRfeYbdKkKyzuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eB+u+X5ykgTiet9QEsloAMIm1Npbzq4/+GwuDnsWFV/WgO3VuasMD3enRWDzTUkVNw+CmxDr41OG7qbpE8lLERHo4SSs9aGPaeHgx49nnHN2nWk56vfEegT8Zmqgw9Zm9UapWGA6Kwo0MvdmZ2+GUZg6hKRVF3VspviC9x7ar5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZYBpdp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731F4C4CEE3;
	Wed, 30 Oct 2024 10:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730285409;
	bh=Xa2VhNuRqurWKjZDUhItHsHTIqISQSRfeYbdKkKyzuE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RZYBpdp2FqmbqoQGHHgqRFB+1ruwRqT4jtnTn+xVCWgM5nEIIdZqb6IA9EzsDKHkG
	 txSjS+AxZo9+ZnqUMbEB8Onxf7B6mlhlg4xHnIzQ1dypxL8OR8bgNnU7Y7uXU7fvag
	 1J59kYE4pfkrTynf02u/GvWy/6L1B5S2Zfz/oUSrUkduxQbDGhN6lVBz6W0KdpCO1y
	 MjTaFA2fTth8urohJHIfUcLuGODoKntqtjCYR85i/0rESU6+AWWMTudFXa5MhE73Sv
	 U02foHSPjWOlL7R1KC2Kouimootz59e39s5CjYgMz35Yps10+BtU1S9yCjfkbcCOli
	 f2d6Lnu1PZ/5w==
Message-ID: <abb72d1b-3347-4493-9a18-43c1655b7449@kernel.org>
Date: Wed, 30 Oct 2024 11:49:58 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix compile error when MPTCP not
 support
Content-Language: en-GB
To: Tao Chen <chen.dylane@gmail.com>, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev
References: <20241030100108.2443371-1-chen.dylane@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Organization: NGI0 Core
In-Reply-To: <20241030100108.2443371-1-chen.dylane@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Tao Chen,

Thank you for having shared this patch.

On 30/10/2024 11:01, Tao Chen wrote:
> Fix compile error when MPTCP feature not support, though eBPF core check
> already done which seems invalid in this situation, the error info like:
> progs/mptcp_sock.c:49:40: error: no member named 'is_mptcp' in 'struct
> tcp_sock'
>    49 |         is_mptcp = bpf_core_field_exists(tsk->is_mptcp) ?
> 
> The filed created in new definitions with eBPF core feature to solve
> this build problem, and test case result still ok in MPTCP kernel.
> 
> 176/1   mptcp/base:OK
> 176/2   mptcp/mptcpify:OK
> 176     mptcp:OK
> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
> 
> Fixes: 8039d353217c ("selftests/bpf: Add MPTCP test base")

The commit you mentioned here is more than 2 years old, and as far as I
can see, nobody else reported this compilation issue. I guess that's
because people used tools/testing/selftests/bpf/config file as expected
to populate the kernel config, and I suppose you didn't, right?

I don't think other BPF selftests check for missing kernel config if
they are specified in the 'config' file, but even if it is the case, I
think it would be better to skip all the MPTCP tests, and not try to
have them checking something that doesn't exist: no need to validate
these tests if the expected kernel config has not been enabled.

But again, please correct me if I'm wrong, but I don't think there is
anything to change here to fix your compilation issue: simply make sure
to use this tools/testing/selftests/bpf/config file to generate your
kernel config, no?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


