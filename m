Return-Path: <linux-kselftest+bounces-13459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D322D92D24D
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 15:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88FA2288A5B
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 13:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A672A19246A;
	Wed, 10 Jul 2024 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvzwQK0C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF9F191497;
	Wed, 10 Jul 2024 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720616870; cv=none; b=boa/77bpwDZyBbHq+eVVVen5iYkOm/6THtdyI0w8YDfzer4zX9wFIN2LgZrCZ7dz/wBy1Gw0cajX2smWFptXk/7H7th7gmxw2Q2YXvvY++Rqt/l5wVkqKxkY/iUwE9UnU/l4kOy029Q8VYFitBoK0M7tfvCrTe3AgfoPuyMHyxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720616870; c=relaxed/simple;
	bh=J8mipCQFsml7hLv9Hy4KgqaW+arquWr56Wk5Ph5gVHI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HipuFXN8FhYZqPO9H6YIlkanLc15gCcbS2CsXzib/7AP23f2lUo7FQdza/qWK5TZKM65U/CmIofNexvrsP1TqXWxfdHEyMrs1M4XXFt5aYx5xvWt8diuEiVLgzEGdCq+8mpvNBU8sibJTPOEdHWyKOqYIuSasuqXjEXnYQinkfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvzwQK0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E6EC32781;
	Wed, 10 Jul 2024 13:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720616870;
	bh=J8mipCQFsml7hLv9Hy4KgqaW+arquWr56Wk5Ph5gVHI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pvzwQK0CfJCJyrl+w7DvVlnhuxghnWL6i6oZ4J63GzONEhrQWLhRUebkv/XZkgODA
	 3PPQe3EtZ2+TvNKAWXB2DIEJgpC0yoP2+UKCgEvA21HM/Ks7B7+uJau6Iyz3BdMeSL
	 ZQKK1fTfhN1Is0BOUeHLVTqFId/s+htIGyuKaasTWijtt+JK/XcPCXi9oj4dUFrZ+Z
	 KEyVx9EIxUdsmX/yMTIKB5Opgkj5tifoxxHmyTjjX/6FIr2H8MB9HpUbNLe3ZxlXNl
	 cUJprvM9xChIBOqr2LxCKyEk58RRGm2aGsQ8CQymI0ev6kgeT0nmehTcGcUXiuqzWc
	 99PnrcS7EHhKA==
Message-ID: <e04d98fcde8276aced7c9d16a76693566912e53e.camel@kernel.org>
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Null checks for links in
 bpf_tcp_ca
From: Geliang Tang <geliang@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>, Andrii Nakryiko
 <andrii@kernel.org>,  Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko
 <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Wed, 10 Jul 2024 21:07:40 +0800
In-Reply-To: <2f6ee147-2868-493f-bf2e-09d771d2e259@oracle.com>
References: <cover.1720521482.git.tanggeliang@kylinos.cn>
	 <3ac5d24825bdf666eae4089a8c69d8e97a6194d2.1720521482.git.tanggeliang@kylinos.cn>
	 <2f6ee147-2868-493f-bf2e-09d771d2e259@oracle.com>
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

On Wed, 2024-07-10 at 12:25 +0100, Alan Maguire wrote:
> On 09/07/2024 11:45, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Run bpf_tcp_ca selftests (./test_progs -t bpf_tcp_ca) on a
> > Loongarch
> > platform, some "Segmentation fault" errors occur:
> > 
> > '''
> >  test_dctcp:PASS:bpf_dctcp__open_and_load 0 nsec
> >  test_dctcp:FAIL:bpf_map__attach_struct_ops unexpected error: -524
> >  #29/1    bpf_tcp_ca/dctcp:FAIL
> >  test_cubic:PASS:bpf_cubic__open_and_load 0 nsec
> >  test_cubic:FAIL:bpf_map__attach_struct_ops unexpected error: -524
> >  #29/2    bpf_tcp_ca/cubic:FAIL
> >  test_dctcp_fallback:PASS:dctcp_skel 0 nsec
> >  test_dctcp_fallback:PASS:bpf_dctcp__load 0 nsec
> >  test_dctcp_fallback:FAIL:dctcp link unexpected error: -524
> >  #29/4    bpf_tcp_ca/dctcp_fallback:FAIL
> >  test_write_sk_pacing:PASS:open_and_load 0 nsec
> >  test_write_sk_pacing:FAIL:attach_struct_ops unexpected error: -524
> >  #29/6    bpf_tcp_ca/write_sk_pacing:FAIL
> >  test_update_ca:PASS:open 0 nsec
> >  test_update_ca:FAIL:attach_struct_ops unexpected error: -524
> >  settcpca:FAIL:setsockopt unexpected setsockopt: \
> > 					actual -1 == expected -1
> >  (network_helpers.c:99: errno: No such file or directory) \
> > 					Failed to call
> > post_socket_cb
> >  start_test:FAIL:start_server_str unexpected start_server_str: \
> > 					actual -1 == expected -1
> >  test_update_ca:FAIL:ca1_ca1_cnt unexpected ca1_ca1_cnt: \
> > 					actual 0 <= expected 0
> >  #29/9    bpf_tcp_ca/update_ca:FAIL
> >  #29      bpf_tcp_ca:FAIL
> >  Caught signal #11!
> >  Stack trace:
> >  ./test_progs(crash_handler+0x28)[0x5555567ed91c]
> >  linux-vdso.so.1(__vdso_rt_sigreturn+0x0)[0x7ffffee408b0]
> >  ./test_progs(bpf_link__update_map+0x80)[0x555556824a78]
> >  ./test_progs(+0x94d68)[0x5555564c4d68]
> >  ./test_progs(test_bpf_tcp_ca+0xe8)[0x5555564c6a88]
> >  ./test_progs(+0x3bde54)[0x5555567ede54]
> >  ./test_progs(main+0x61c)[0x5555567efd54]
> >  /usr/lib64/libc.so.6(+0x22208)[0x7ffff2aaa208]
> >  /usr/lib64/libc.so.6(__libc_start_main+0xac)[0x7ffff2aaa30c]
> >  ./test_progs(_start+0x48)[0x55555646bca8]
> >  Segmentation fault
> > '''
> > 
> > This is because BPF trampoline is not implemented on Loongarch yet,
> > "link" returned by bpf_map__attach_struct_ops() is NULL. test_progs
> > crashs when this NULL link passes to bpf_link__update_map(). This
> > patch adds NULL checks for all links in bpf_tcp_ca to fix these
> > errors.
> > If "link" is NULL, goto the newly added label "out" to destroy the
> > skel.
> > 
> > v2:
> >  - use "goto out" instead of "return" as Eduard suggested.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> 
> Maybe I'm missing it, but I'm not seeing this series on
> patchwork.kernel.org/project/netdevbpf, so we don't have an
> associated
> CI run (the series is in the kselftest patchwork however). Is there
> some
> patchwork bot magic that will do this?

Thanks for your review. I want to do a small update for this patch, so
I changed this set as "Changes Requested". So they are not showed in
patchwork. v2 will be sent soon. I will add your "reviewed-by" tag in
it.

Thanks,
-Geliang

> 
> > ---
> >  .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 21 +++++++++++++--
> > ----
> >  1 file changed, 15 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> > b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> > index d842ff64bc2a..efc1bf2ff7de 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> > @@ -411,7 +411,8 @@ static void test_update_ca(void)
> >  		return;
> >  
> >  	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
> > -	ASSERT_OK_PTR(link, "attach_struct_ops");
> > +	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
> > +		goto out;
> > 
> >  	do_test(&opts);
> >  	saved_ca1_cnt = skel->bss->ca1_cnt;
> > @@ -425,6 +426,7 @@ static void test_update_ca(void)
> >  	ASSERT_GT(skel->bss->ca2_cnt, 0, "ca2_ca2_cnt");
> >  
> >  	bpf_link__destroy(link);
> > +out:
> >  	tcp_ca_update__destroy(skel);
> >  }
> >  
> > @@ -447,7 +449,8 @@ static void test_update_wrong(void)
> >  		return;
> >  
> >  	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
> > -	ASSERT_OK_PTR(link, "attach_struct_ops");
> > +	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
> > +		goto out;
> >  
> >  	do_test(&opts);
> >  	saved_ca1_cnt = skel->bss->ca1_cnt;
> > @@ -460,11 +463,13 @@ static void test_update_wrong(void)
> >  	ASSERT_GT(skel->bss->ca1_cnt, saved_ca1_cnt,
> > "ca2_ca1_cnt");
> >  
> >  	bpf_link__destroy(link);
> > +out:
> >  	tcp_ca_update__destroy(skel);
> >  }
> >  
> >  static void test_mixed_links(void)
> >  {
> > +	struct bpf_link *link = NULL, *link_nl = NULL;
> >  	struct cb_opts cb_opts = {
> >  		.cc = "tcp_ca_update",
> >  	};
> > @@ -473,7 +478,6 @@ static void test_mixed_links(void)
> >  		.cb_opts	= &cb_opts,
> >  	};
> >  	struct tcp_ca_update *skel;
> > -	struct bpf_link *link, *link_nl;
> >  	int err;
> >  
> >  	skel = tcp_ca_update__open_and_load();
> > @@ -481,10 +485,12 @@ static void test_mixed_links(void)
> >  		return;
> >  
> >  	link_nl = bpf_map__attach_struct_ops(skel-
> > >maps.ca_no_link);
> > -	ASSERT_OK_PTR(link_nl, "attach_struct_ops_nl");
> > +	if (!ASSERT_OK_PTR(link_nl, "attach_struct_ops_nl"))
> > +		goto out;
> >  
> >  	link = bpf_map__attach_struct_ops(skel->maps.ca_update_1);
> > -	ASSERT_OK_PTR(link, "attach_struct_ops");
> > +	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
> > +		goto out;
> >  
> >  	do_test(&opts);
> >  	ASSERT_GT(skel->bss->ca1_cnt, 0, "ca1_ca1_cnt");
> > @@ -492,6 +498,7 @@ static void test_mixed_links(void)
> >  	err = bpf_link__update_map(link, skel->maps.ca_no_link);
> >  	ASSERT_ERR(err, "update_map");
> >  
> > +out:
> >  	bpf_link__destroy(link);
> >  	bpf_link__destroy(link_nl);
> >  	tcp_ca_update__destroy(skel);
> > @@ -536,7 +543,8 @@ static void test_link_replace(void)
> >  	bpf_link__destroy(link);
> >  
> >  	link = bpf_map__attach_struct_ops(skel->maps.ca_update_2);
> > -	ASSERT_OK_PTR(link, "attach_struct_ops_2nd");
> > +	if (!ASSERT_OK_PTR(link, "attach_struct_ops_2nd"))
> > +		goto out;
> >  
> >  	/* BPF_F_REPLACE with a wrong old map Fd. It should fail!
> >  	 *
> > @@ -559,6 +567,7 @@ static void test_link_replace(void)
> >  
> >  	bpf_link__destroy(link);
> >  
> > +out:
> >  	tcp_ca_update__destroy(skel);
> >  }
> >  


