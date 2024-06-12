Return-Path: <linux-kselftest+bounces-11737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1E49049B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 05:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCDCD1F23E82
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 03:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B06417C77;
	Wed, 12 Jun 2024 03:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spiEw1oJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EB563BF;
	Wed, 12 Jun 2024 03:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718163562; cv=none; b=Xj1YE6itdjF4UFCKSc13EzAGbaYr2D2gBNJqp5ADcH2bHG5GdrJE00nnwVJAjzdHxsNivTKAAevJEy6GUr6XB+0F4twfQq2RaDYui8MPFrncu7XC3C8wDVcp5nHRLQLxhr3LassHTEKNqTQ4SXFS5xuttORVbHllums/CDgjxQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718163562; c=relaxed/simple;
	bh=kCHLhjfWOErMWtccEkpMiZ0dqi402JQBcE0Ura3iAIA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s17qIkemt8XwLd0pKAheCsBq6YGZONkyc1srKoYzWgrT2yWnsX2A4JYvu1XOPuZIeTgQixa9GS1IxEUQLfm/Ly9arHqnDjv+ssr2dP9r1u1FbmGaQ0PxNzwCz5W8GLWF2UJfAuqtBP+qEwI4VncKy3IMqnieT8hNsoKpneECfEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spiEw1oJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D1CC2BD10;
	Wed, 12 Jun 2024 03:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718163561;
	bh=kCHLhjfWOErMWtccEkpMiZ0dqi402JQBcE0Ura3iAIA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=spiEw1oJbB9hmrc+s3oX2ADCAe/8FkMxVzWRwWG522Q+zZhAq/qGG0YYIkcm6aL1V
	 /HwKjImfnQ0kcUfdIXeOXEweN1m+OhAcIjH/FEFoxtsW0Qjq3hXVBGCpcJN+i042pB
	 YvpHhhRQWlyUqpZXTFu7USAnZeuIRQWyqCoNHHvGvRTMA3GJ7dkeK/0RHCHkXBtX6s
	 kfr4sq1ZucI3BcOFBKg7wL2BsYkg6kxStmdVIiaKLZzsY6MWbQe7CmRw+C6Sg/ILFe
	 OF8u4meMOFFNYlaDr/YPX3NPw3EzaSD7w3yVfVgF/V7tsSOAPpsrzPzS15LNN9F+VM
	 STWseuYIJfrPQ==
Message-ID: <cc489496784f5d023dee99a2f3ab512e0ab20b48.camel@kernel.org>
Subject: Re: [PATCH bpf-next 1/5] selftests/bpf: Drop type from
 network_helper_opts
From: Geliang Tang <geliang@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>,  Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Wed, 12 Jun 2024 11:39:12 +0800
In-Reply-To: <90648db3ed02c6f75ce2f90cf6651c8a6f0123a0.camel@gmail.com>
References: <cover.1718070939.git.tanggeliang@kylinos.cn>
	 <b80ca04f4f1e65e4b796331c48283ea282fe7ee0.1718070939.git.tanggeliang@kylinos.cn>
	 <90648db3ed02c6f75ce2f90cf6651c8a6f0123a0.camel@gmail.com>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-06-11 at 14:20 -0700, Eduard Zingerman wrote:
> On Tue, 2024-06-11 at 09:59 +0800, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > The opts.{type, noconnect, must_fail} is at least a bit non
> > intuitive or
> > unnecessary. The only use case now is in
> > test_bpf_ip_check_defrag_ok which
> > ends up bypassing most (or at least some) of the
> > connect_to_fd_opts()
> > logic. It's much better that test should have its own
> > connect_to_fd_opts()
> > instead.
> > 
> > This patch adds a new helper named __connect_to_fd_opts() to do
> > this. It
> > accepts a new "type" parameter, then opts->type can be replaced by
> > "type"
> > parameter in this helper. In test_bpf_ip_check_defrag_ok, different
> > types
> > are passed to it. And the strcut member "type" of
> > network_helper_opts can
> > be dropped now.
> > 
> > Then connect_to_fd_opts can implement as a wrapper of this new
> > helper.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> 
> Patches #1,2,3 trade options specified as struct fields for options
> specified as function parameters. Tbh, this seems to be an
> opinionated
> stylistic change, what is the need for it?

Thanks for your review.

Patches 1-3 address Martin's comment for "Drop type parameter of
start_server_addr" [1].

Since opts.{type, noconnect} are only used in ip_check_defrag.c and
opts.must_fail is only used in cgroup_v1v2.c, they are not generic
enough to be added into network_helper_opts. So this set removes them
from network_helper_opts and use them as function parameters.

Thanks,
-Geliang

[1]
https://patchwork.kernel.org/project/netdevbpf/patch/65dd42dd91d678740e9c05e32852f5e01ba2b7bc.1716369375.git.tanggeliang@kylinos.cn/

> 
> If anything, I think that this is less readable:
> 
> > +	client_rx_fd = __connect_to_fd_opts(srv_fd, 0, &rx_opts);
> 
> compared to this:
> 
> >  	struct network_helper_opts tx_ops = {
> >  		.timeout_ms = 1000,
> > -		.type = SOCK_RAW,
> >  		.proto = IPPROTO_RAW,
> >  		.noconnect = true,
> >  	};
> ...
> > -	client_rx_fd = connect_to_fd_opts(srv_fd, &rx_opts);
> 
> (given that by patch #3 three parameters are added to
>  __connect_to_fd_opts() *and* it also accepts options).
> 
> [...]


