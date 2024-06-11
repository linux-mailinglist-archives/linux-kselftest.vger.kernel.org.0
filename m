Return-Path: <linux-kselftest+bounces-11632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E46902E3B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 04:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0A71C20B3A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 02:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A695FBA34;
	Tue, 11 Jun 2024 02:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxHSNDg7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799CAB65E;
	Tue, 11 Jun 2024 02:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718071971; cv=none; b=qVLgtlsBnIFaQ4apdcUFJyxO2/5s/hWGZ3SYbxkIbO45pexS5AVYo6+JgVLYyWZss6pQrFy6wXFrIpaWncIFF8eOPcBM1xbBpuwSecbzNq9PQGHHEdKrxsTGZFiL01X+eiM0iD71KghW3i8mVOhoLdvmDLU3r1vPbI1rGW8CtoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718071971; c=relaxed/simple;
	bh=TyA403amK9lcRVjAZTflcdsXdF/2I86jaIjKOguFtHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duo9mXXvkwL0GzuMybnjAmDWvETo6e2YnS00yW82a/Q+CNxKFswnIZyk2YKjIkGUz7hCJhoYXPjB+XRuhysRSvyjtuOpeFxMppE/cyepcUm6zut1qKvzsUw/gmCZApoWeuBLC2PtELXXLhmGB0q/x0aC/+urFZLsgwW1RB7A1UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxHSNDg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1333C2BBFC;
	Tue, 11 Jun 2024 02:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718071971;
	bh=TyA403amK9lcRVjAZTflcdsXdF/2I86jaIjKOguFtHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZxHSNDg7+iNDJ7huYTPg2B22EWZs9HJTAN9UiaJ2NxFSfvfujUoVTj8LZd9W5KJQf
	 pjN0QcjcKa5q5FfuOg6kBokLhpRek40zE08qln4pRtoZzh+eGicEegm13arExhFnc3
	 ow8ZnefshIPYFE+N2joWZGouPU6XF+EmiCnttzLCWuUVphlfL7Vazo5k4IB/pFQKTw
	 mJ/9C7MSPqKmeW0mYYs/IEDsrjPOJSNJVm/8QQXxMq1MxfPARj7sNwFBdb0rAc5s/V
	 iFbTJT/+gE8UHnhNZ+F/+2HdDWrqcebrRSxWgAxgL/nCpG+f3/kNClfrVskdeBBRBk
	 Z6mwDA6qtHOoQ==
Date: Tue, 11 Jun 2024 10:12:40 +0800
From: Geliang Tang <geliang@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Enable INET_XFRM_TUNNEL in config
Message-ID: <ZmeymDeduB5UogEx@T480>
References: <acb442e38544bc5c60dcaa61d56ca1e6bbbc82fe.1715823610.git.tanggeliang@kylinos.cn>
 <978a90ad-2e4c-ac06-30bf-6449444d47f9@iogearbox.net>
 <8c406b8d6cf2347589c1e40f0b87095550306c4a.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c406b8d6cf2347589c1e40f0b87095550306c4a.camel@linux.ibm.com>

On Wed, May 29, 2024 at 02:01:06AM +0200, Ilya Leoshkevich wrote:
> On Fri, 2024-05-24 at 18:27 +0200, Daniel Borkmann wrote:
> > On 5/16/24 3:41 AM, Geliang Tang wrote:
> > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > 
> > > The kconfigs CONFIG_INET_XFRM_TUNNEL and CONFIG_INET6_XFRM_TUNNEL
> > > are
> > > needed by test_tunnel tests. This patch enables them together with
> > > the
> > > dependent kconfigs CONFIG_INET_IPCOMP and CONFIG_INET6_IPCOMP.
> > > 
> > > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > > ---
> > >   tools/testing/selftests/bpf/config | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/bpf/config
> > > b/tools/testing/selftests/bpf/config
> > > index eeabd798bc3a..8aa56e6bdac1 100644
> > > --- a/tools/testing/selftests/bpf/config
> > > +++ b/tools/testing/selftests/bpf/config
> > > @@ -95,3 +95,7 @@ CONFIG_XDP_SOCKETS=y
> > >   CONFIG_XFRM_INTERFACE=y
> > >   CONFIG_TCP_CONG_DCTCP=y
> > >   CONFIG_TCP_CONG_BBR=y
> > > +CONFIG_INET_IPCOMP=y
> > > +CONFIG_INET_XFRM_TUNNEL=y
> > > +CONFIG_INET6_IPCOMP=y
> > > +CONFIG_INET6_XFRM_TUNNEL=y
> > > 
> > 
> > [ +Ilya ]
> > 
> > Looks like this triggers a boot hang on s390x :
> > 
> > https://github.com/kernel-patches/bpf/actions/runs/9215175853/job/25353574288
> 
> Hi,
> 
> I could not reproduce this neither with vmtest nor with my own build,
> and it doesn't look related.
> 
> I'm not exactly sure what could cause d_alloc_parallel() to hang, but
> apparently the CI is using a different vmtest script, which uses 9p to
> mount root - perhaps there is a deadlock in 9p?
> 
> Can someone retrigger the build to see if the issue persists?

Hi Daniel, Ilya,

I'll resend this patch together with another fix for test_tunnel soon. At
that time, CI can be triggered again.

I changed this patch status as "Superseded" on patchwork.

Thanks,
-Geliang

> 
> Best regards,
> Ilya

