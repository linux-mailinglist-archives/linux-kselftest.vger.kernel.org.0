Return-Path: <linux-kselftest+bounces-14140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE50393AD4A
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 09:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9341D280EC1
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 07:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843B47602D;
	Wed, 24 Jul 2024 07:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkJYZZug"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DED33D97A;
	Wed, 24 Jul 2024 07:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721806934; cv=none; b=Gkkp3UjqCYQl6Oea4b30YNL1dHD7451Tke0pyfu50f5m8n8kLxTQtbMuGivCg2ZiVwLzRTbM85hTdIzucAYm3YwFuoY5M+r3QptR5PxCoeffVQTfRDOgerq2iYPRzO6W3OfUEBq+FfR4vXuPYW5mGMJ73/LPAHSbtE8/0ZBjI9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721806934; c=relaxed/simple;
	bh=qIRmIsGfOifbd0F+slj35U+RDiwKrNFSa5amWJn8fiM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=spBnj9pUqLAF8ItwLF9syb6J9OiofcwKp8/qwmKKLR7ErOYzkgd6jqRpp+7VMDRBKgf5OFM75/mdirFV42LTZ96/buE1SIhBgyT5j42Ox0ri9FbGS0DSWK2HL+P79R2upgu1KWhTChJe3HEuXDURuE3W/6DSnVUC0+aHy3meAS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkJYZZug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A365CC32782;
	Wed, 24 Jul 2024 07:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721806933;
	bh=qIRmIsGfOifbd0F+slj35U+RDiwKrNFSa5amWJn8fiM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TkJYZZugd0NUf8tJQyAImQPkUnqngbiiuQv8mHcfTnt8nqgXA8jCOtKi4Isq7KjWO
	 oSCGBhbFS3M341CPzDzX03RCniqueIawKgoG6CnGIpFjGdzGaZgoj45V7Ccpqffcfp
	 +zWMVdEDIXnp+lh0a1qT0IqGfeDXihurY42IIYU1JsCfVG7fwy4cy+BtX/HFoEaKs7
	 k7moWY4mk9Y6yZV74xLTWaSMqQdqkx08TSuHEzMB/TsDl0RjlIK+iDVhJBU+yjHwAh
	 fql6mKrZhg36UGS1eWBR26v2zOaTs6VQ9xwLA2wxEQG5Sd/+H6vST724MiUrWNp8xi
	 TbYobkUQ36yeQ==
Message-ID: <780ed38257480940def86947b2ee354f298e890b.camel@kernel.org>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: Add mptcp pm_nl_ctl link
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Martin KaFai Lau
	 <martin.lau@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Geliang Tang <tanggeliang@kylinos.cn>, 
 mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Shuah Khan
 <shuah@kernel.org>
Date: Wed, 24 Jul 2024 15:42:01 +0800
In-Reply-To: <ab8112e6-ea7b-4b36-b395-049214e1608d@kernel.org>
References: 
	<20240703-upstream-bpf-next-20240506-mptcp-subflow-test-v3-0-ebdc2d494049@kernel.org>
	 <20240703-upstream-bpf-next-20240506-mptcp-subflow-test-v3-2-ebdc2d494049@kernel.org>
	 <08f925cd-e267-4a6b-84b1-792515c4e199@kernel.org>
	 <90e916e8-ec4e-447b-8ee6-eb247f3a72ad@linux.dev>
	 <ab8112e6-ea7b-4b36-b395-049214e1608d@kernel.org>
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

Hi Matt,

On Sat, 2024-07-06 at 02:25 +0200, Matthieu Baerts wrote:
> Hi Martin,
> 
> Thank you for your reply!
> 
> On 06/07/2024 01:10, Martin KaFai Lau wrote:
> > On 7/4/24 3:48 AM, Matthieu Baerts wrote:
> > > > diff --git a/tools/testing/selftests/bpf/Makefile
> > > > b/tools/testing/
> > > > selftests/bpf/Makefile
> > > > index e0b3887b3d2d..204269d0b5b8 100644
> > > > --- a/tools/testing/selftests/bpf/Makefile
> > > > +++ b/tools/testing/selftests/bpf/Makefile
> > > > @@ -144,7 +144,7 @@ TEST_GEN_PROGS_EXTENDED =
> > > > test_skb_cgroup_id_user \
> > > >       flow_dissector_load test_flow_dissector
> > > > test_tcp_check_syncookie_user \
> > > >       test_lirc_mode2_user xdping test_cpp runqslower bench
> > > > bpf_testmod.ko \
> > > >       xskxceiver xdp_redirect_multi xdp_synproxy veristat
> > > > xdp_hw_metadata \
> > > > -    xdp_features bpf_test_no_cfi.ko
> > > > +    xdp_features bpf_test_no_cfi.ko mptcp_pm_nl_ctl
> > > On the BPF CI, we have such errors:
> > > 
> > >     mptcp_pm_nl_ctl.c:20:10: fatal error: 'linux/mptcp.h' file
> > > not found
> > >       20 | #include "linux/mptcp.h"
> > >          |          ^~~~~~~~~~~~~~~
> > > 
> > > On my side, I don't have any issue, because the compiler uses the
> > > mptcp.h file from the system: /usr/include/linux/mptcp.h
> > > 
> > > I suppose that's not OK on the BPF CI, as it looks like it
> > > doesn't have
> > > this file there, probably because it still uses Ubuntu 20.04 as
> > > base,
> > > which doesn't include this file in the linux-libc-dev package.
> > > 
> > > When I look at how this 'mptcp_pm_nl_ctl' tool -- and all the
> > > other
> > > programs from that list -- is compiled (V=1), I see that the
> > > following
> > > "-I" options are given:
> > > 
> > >    -I${PWD}/tools/testing/selftests/bpf
> > >    -I${BUILD}//tools/include
> > >    -I${BUILD}/include/generated
> > >    -I${PWD}/tools/lib
> > >    -I${PWD}/tools/include
> > >    -I${PWD}/tools/include/uapi
> > >    -I${BUILD}/
> > > 
> > > It will then not look at -I${PWD}/usr/include or the directory
> > > generated
> > > with:
> > > 
> > >    make headers_install INSTALL_HDR_PATH=(...)
> > 
> > It sounds like the tools/testing/selftests/net/mptcp/Makefile is
> > looking
> > at this include path, so it works?
> 
> Yes it does work.
> 
> > iiu the bpf/Makefile correctly, it has the bpftool "make" compiled
> > and
> > installed at tools/testing/selftests/bpf/tools/sbin/. May be
> > directly
> > compile the pm_nl_ctl by "make tools/testing/selftests/net/mptcp/"?
> 
> That could be an alternative, I didn't know it would be OK to add
> such
> dependence, good idea.
> 
> > > I guess that's why people have duplicated files in
> > > 'tools/include/uapi',
> > > but I also understood from Jakub that it is not a good idea to
> > > continue
> > > to do so.
> > > 
> > > What would be the best solution to avoid a copy? A symlink still
> > > looks
> > > like a workaround.
> > > 
> > > In the other selftests, KHDR_INCLUDES is used to be able to
> > > include the
> > > path containing the UAPI headers. So if someone built the headers
> > > in a
> > 
> > Meaning KHDR_INCLUDES should be used and -
> > I${PWD}/tools/include/uapi can
> > be retired?
> 
> That's the idea, yes, for "userspace programs". I mean: for BPF
> programs
> requiring vmlinux.h (BPF_CFLAGS), I guess you will still need the
> bpf.h
> file from tools/include/uapi, no?
> 
> > I haven't looked into the details. I quickly tried but it
> > fails in my environment.
> 
> Do you not have issues because some files have something like:
> 
>   #include <uapi/linux/(...).h>
> 
> On my side, I had a working version using this patch:
> 
> > diff --git a/tools/testing/selftests/bpf/Makefile
> > b/tools/testing/selftests/bpf/Makefile
> > index 7c5827d20c2e..112f14d40852 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -37,7 +37,7 @@ CFLAGS += -g $(OPT_FLAGS) -rdynamic            \
> >           -Wall -Werror -fno-omit-frame-pointer                  \
> >           $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)             \
> >           -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)   \
> > -         -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
> > +         -I$(TOOLSINCDIR) $(KHDR_INCLUDES) -I$(OUTPUT)
> >  LDFLAGS += $(SAN_LDFLAGS)
> >  LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread
> >  
> 
> But only after having removed these extra 'uapi/':
> 
>   $ git grep -l '<uapi/' -- tools/testing/selftests/bpf | \
>     xargs sed -i 's|#include <uapi/|#include <|g'
> 
> Is it not OK for you like that?
> 
> Note that I built the selftests using KHDR_INCLUDES=-
> I$INSTALL_HDR_PATH.

Do you need me to do anything here? This patchset seems to have been
waiting for several months.

Another option is to roll back to v2, not add this mptcp_pm_nl_ctl
tool, and continue to use "ip mptcp". I remember mentioning in the
comments of v2 that BPF CI systems will also be upgraded to new Ubuntu
system and iproute2 in the future. At this time now we can make a check
for "ip mptcp" and only run this test on systems that support "ip
mptcp", and skip the test with test__skip() for systems that do not
support it, so that CI can also pass.

WDYT?

Thanks,
-Geliang

> 
> > > seperated directory -- INSTALL_HDR_PATH=(...) -- KHDR_INCLUDES
> > > can be
> > > overridden to look there, instead of ${KERNEL_SRC}/usr/include.
> > > Would it
> > > be OK to do that? Would it work for the CI without extra changes?
> > > Or do
> > > you still prefer a copy/symlink to 'tools/include/uapi' instead?
> 
> Cheers,
> Matt


