Return-Path: <linux-kselftest+bounces-13306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4929F929E79
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 10:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21A3284EE4
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 08:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80F62EAF9;
	Mon,  8 Jul 2024 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8wn0ECa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F15C2B9D4;
	Mon,  8 Jul 2024 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720428408; cv=none; b=c/me+CjEAdUPHU5+lZGflAZGh7DcZu/Ou/t+WACJBatSHuGUfAAIempdxGj5Ppq1Wfd/y9DEOhH8Lw24PsLP8NjlUH7cnSfBNsVomVZ5CEdZK8BisXKg52ee2mvbGIpiRFDPLHzXq+W7uQ1meXkEcz3ldEHuWryuu0VFz/ET1yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720428408; c=relaxed/simple;
	bh=3d1MaV9M6W1yQpOw1wuUN8WmjJJZTqkDCGfmbYHtZfU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PnzVjNaC4JHC/IP4OmsWAYk7LD4RUi/XIvfSELh4tSQ6ce9PTIHNCNKhWRGihNv8dTsqPs0rsotMZVA/WKykK5fAUYtkDCl2PL1bJg35UYEzo2t+cAhvsKcpmNBybWTj1kgh8Gh9QnF64DPaoLSU81QC7nYlejJ/riFKTXU1nHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8wn0ECa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FA9C116B1;
	Mon,  8 Jul 2024 08:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720428408;
	bh=3d1MaV9M6W1yQpOw1wuUN8WmjJJZTqkDCGfmbYHtZfU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=P8wn0ECat6e4jHWXxu93t9OqCOgoymKNUtqkCaaE/BrSMjy7WNP3o/arjQ7mCS7jp
	 STXScS1DsuP7x7vkg171oYfBstLCD6zwRdR9PwfI8+BzcmYw2aBEwmuvI6wr4XHNKj
	 OHH9OcBTwUaAW/J+uktJahJygC49zmuZJl1r4DHoU4EgsNJ95+dU1yfrBgBRWfd+U2
	 6BZiosOuCAw2WRT2RM3l3NiWrRPwloHPvgW/0BFFMo1r+h7zPYoULDN8hvu7G77CWa
	 bk/pba6131pCeJgfCVBp4SttCQG4IcCzd2YEO8/Ksx2oiPwarLcDfB9egFG1390mmL
	 z8UDOVrBP/d1w==
Message-ID: <1e918911cbf31175d2ac6e466fa5b1a46be26b97.camel@kernel.org>
Subject: Re: [PATCH bpf-next v10 02/12] selftests/bpf: Use start_server_str
 in sockmap_ktls
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Mon, 08 Jul 2024 16:46:34 +0800
In-Reply-To: <52e84e1325b977c971d1745f8056a1cf9b5add17.1720405046.git.tanggeliang@kylinos.cn>
References: <cover.1720405046.git.tanggeliang@kylinos.cn>
	 <52e84e1325b977c971d1745f8056a1cf9b5add17.1720405046.git.tanggeliang@kylinos.cn>
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

On Mon, 2024-07-08 at 10:29 +0800, Geliang Tang wrote:
> > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > > 
> > > > Include network_helpers.h in prog_tests/sockmap_ktls.c, use
> > > > public
> > > > network
> > > > helper start_server_str() instead of local defined function
> > > > tcp_server().
> > > > This can avoid duplicate code.
> > > > 
> > > > Technically, this is not a one-for-one replacement, as
> > > > start_server_str()
> > > > also does bind(). But the difference does not seem to matter.

I'd like to add a "nobind" flag in network_helper_opts to handle this.

And another flag "nolisten" to allow to use start_server_str() in
test_sockmap_ktls_update_fails_when_sock_has_ulp() too.

These two flags are also useful for later commits such as "use
start_server_str() in test_insert_bound()" in
prog_tests/sockmap_listen.c.

I changed the states of patches 2-4 (for sockmap_ktls) as "Changes
Requested".

Other 9 patches for sk_lookup in this set are still valid, and no
conflict.

Thanks,
-Geliang

> > > > 
> > > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > > > ---
> > > >  .../selftests/bpf/prog_tests/sockmap_ktls.c   | 23
> > > > +++++--------------
> > > >  1 file changed, 6 insertions(+), 17 deletions(-)
> > > > 
> > > > diff --git
> > > > a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
> > > > b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
> > > > index 2d0796314862..32be112967a5 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
> > > > @@ -6,25 +6,11 @@
> > > >  
> > > >  #include <netinet/tcp.h>
> > > >  #include "test_progs.h"
> > > > +#include "network_helpers.h"
> > > >  
> > > >  #define MAX_TEST_NAME 80
> > > >  #define TCP_ULP 31
> > > >  
> > > > -static int tcp_server(int family)
> > > > -{
> > > > - int err, s;
> > > > -
> > > > - s = socket(family, SOCK_STREAM, 0);
> > > > - if (!ASSERT_GE(s, 0, "socket"))
> > > > - return -1;
> > > > -
> > > > - err = listen(s, SOMAXCONN);
> > > > - if (!ASSERT_OK(err, "listen"))
> > > > - return -1;
> > > > -
> > > > - return s;
> > > > -}
> > > > -
> > > >  static int disconnect(int fd)
> > > >  {
> > > >   struct sockaddr unspec = { AF_UNSPEC };
> > > > @@ -35,12 +21,15 @@ static int disconnect(int fd)
> > > >  /* Disconnect (unhash) a kTLS socket after removing it from
> > > > sockmap.
> > > > */
> > > >  static void test_sockmap_ktls_disconnect_after_delete(int
> > > > family,
> > > > int map)
> > > >  {
> > > > + struct network_helper_opts opts = {
> > > > + .backlog = SOMAXCONN,
> > > > + };
> > > >   struct sockaddr_storage addr = {0};
> > > >   socklen_t len = sizeof(addr);
> > > >   int err, cli, srv, zero = 0;
> > > >  
> > > > - srv = tcp_server(family);
> > > > - if (srv == -1)
> > > > + srv = start_server_str(family, SOCK_STREAM, NULL, 0, &opts);
> > > > + if (!ASSERT_GE(srv, 0, "start_server_str"))
> > > >   return;
> > > >  
> > > >   err = getsockname(srv, (struct sockaddr *)&addr, &len);


