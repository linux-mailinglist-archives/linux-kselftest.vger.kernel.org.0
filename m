Return-Path: <linux-kselftest+bounces-11018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 523AD8D649C
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 16:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74E91F241A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 14:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EC741C69;
	Fri, 31 May 2024 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LD3tAu+e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE23B3EA86;
	Fri, 31 May 2024 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717166157; cv=none; b=i/glmwqo9DJ48rquNN9tfSoYhI9S5CP9CLfOm+iTo5UFwb1rjycX9rcKzydrcywr0Gpuhtt4vYHqh37XFcjG4O+hSm2YaLzUlpjyzvcnixKOpK1FFQKzGrVT9zh9O8VeX2VkSgnF1+IZjuMnpITd1NoheNUAf1njNsRWMPFgQKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717166157; c=relaxed/simple;
	bh=/Ltdv79q3skkml0ifKj3D0gZrv9LGfP0o2gnIsRp+6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mson6biAPtxnYviketqfsJwQ7ivqHxqdNDLQgsQjfDQPfsnxlZNf9XuQF67Ly1ERpPo+yvM8Se8baJ0aVdnUqhcN8K+he2mCSiE+nqibNb/neeCvcHIDBDQ3nl1gmYOUU2AI6CS5JupOcZ033WEKi+GmUeYksZQuJpHeRgP3VJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LD3tAu+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A26BC116B1;
	Fri, 31 May 2024 14:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717166156;
	bh=/Ltdv79q3skkml0ifKj3D0gZrv9LGfP0o2gnIsRp+6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LD3tAu+e2GZhlS16l95NYRLhYtJf/bC/FGtKdWqvEJMCGTvsCjzT1oSP4xYjJFXtO
	 nKkOW0K18ohGEohKEyNOS4W6L+8uNkx3i2ekTEkr5wxwJ+mDlDFpHj82h3wuX7zoIp
	 v3+sqmTSVOgciQfMyPng5hhEwV/YYGPF54tmOaShwx1ggme3/TiWNGBrF+Xji3teHQ
	 nwBTWqNeo1OLQ4ZbQAdbF/X8lv8vvXNz4cv+MUsCwHQQxqV9HpS+NfDS2t8D6Z/HMK
	 EBomR6Du7bgyetQGT3GTgb/4n5KwpFEdMYA87cJLSlMXoZpRJPLiySkY75nHdLHkJa
	 3aAhimH/2aCxA==
Date: Fri, 31 May 2024 22:35:46 +0800
From: Geliang Tang <geliang@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
	mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/8] selftests/bpf: Use bpf_link attachments in
 test_sockmap
Message-ID: <ZlngQqfkS-R1PNqk@T480>
References: <cover.1716446893.git.tanggeliang@kylinos.cn>
 <32cf8376a810e2e9c719f8e4cfb97132ed2d1f9c.1716446893.git.tanggeliang@kylinos.cn>
 <6654beff96840_23de2086e@john.notmuch>
 <87wmnfujwg.fsf@cloudflare.com>
 <577531139c4db3cb35f3f40e23587bcb9815b0ba.camel@kernel.org>
 <66590f821d120_e5072085a@john.notmuch>
 <87wmnaw7x8.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmnaw7x8.fsf@cloudflare.com>

On Fri, May 31, 2024 at 01:13:39PM +0200, Jakub Sitnicki wrote:
> On Thu, May 30, 2024 at 04:45 PM -07, John Fastabend wrote:
> > Geliang Tang wrote:
> >> On Mon, 2024-05-27 at 21:36 +0200, Jakub Sitnicki wrote:
> >> > On Mon, May 27, 2024 at 10:12 AM -07, John Fastabend wrote:
> >> > > Geliang Tang wrote:
> 
> [...]
> 
> >> > > The one advantage of test_sockmap is we can have it run for longer
> >> > > runs by pushing different options through so might be worth keeping
> >> > > just for that.
> >> > > 
> >> > > If you really want links here I'm OK with that I guess just asking.
> >> > 
> >> > It was me who suggested the switch to bpf_link in reaction to a
> >> > series
> >> > of cleanups to prog_type and prog_attach_type submitted by Geliang.
> >> 
> >> Yes, patches 3-5 address Jakub's suggestion: switching attachments to
> >> bpf_link.
> >
> > OK. Lets just take them the series lgtm. Jakub any other comments?
> 
> Gave it a run - all looks well. Thanks for the patches.
> 
> Geliang, is there some MPTCP+sockmap use-case you're working towards?

Yes, indeed. I have been working on a task related to MPTCP+sockmap
recently, at least related to this test_sockmap.c selftest. We recently
received an issue with MPTCP [1], that is TLS cannot be set on MPTCP
sockets. The reason is that both MPTCP and TLS are implemented on TCP ULP.
And each socket only supports one type of TCP ULP.

I simply modified this test_sockmap.c selftest to support MPTCP, so that
it can be used as the first version of test for MPTCP+TLS. So I spent some
time reading and debugging this test.

The development of MPTCP+TLS is still ongoing, and currently only setsockopt
part has been successfully supported. The idea is simple, use an array of
tcp_ulp_ops in a socket, instead of a single one:

struct inet_connection_sock {
      ... ...
      const struct tcp_ulp_ops  *icsk_ulp_ops[ULP_INDEX_MAX];
      void __rcu                *icsk_ulp_data[ULP_INDEX_MAX];
}

The entire patch is in my commit "mptcp: tls support" [2]. It's not finish
yet, but I really want to hear your opinions, especially John's.

[1]
https://github.com/multipath-tcp/mptcp_net-next/issues/480
[2]
https://github.com/geliangtang/mptcp_net-next/commit/bba00a6cde75bab5a2c1c196d49812b4ed6addb0

Thanks,
-Geliang

