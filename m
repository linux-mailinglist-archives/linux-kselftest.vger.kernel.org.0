Return-Path: <linux-kselftest+bounces-7358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D2E89AFAB
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Apr 2024 10:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF26282F58
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Apr 2024 08:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0531118E;
	Sun,  7 Apr 2024 08:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmgqqQMP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25871747F;
	Sun,  7 Apr 2024 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712478581; cv=none; b=Z36P/oYcgqQOg+uRj5ozKFxqE4Z0pBAO6tPA+Tmz2fflBihQ6ChlFkjMRf3y1NGzzsfMffzH2x/zIXU87saYIoVbKOY1nz5LEgWsArTCJPTuv/++Uu3PhFppEDWPTVr9S/Dn9YI/E0jKw3RqRVL4EKlE5YzW7eYdplsPuKGHQno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712478581; c=relaxed/simple;
	bh=yJyWAHSZog1ChlZCttGqgfDm8sPy24O6dL4fe1Cqumw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dpd7lALd2jcNVF2a2tTk6UC+7r9kPdiiSXHIeaGAuildd7RgSUCL4L8Ot0x9aIT+uHmFcDxn/dxJQNAXP9CeA2ocHIwoGmuwkBW+hYGgNWGFIcEKHt9PLT761rQZ335SAJbc4jmurryylEKVLRQ0+QIwXU3smd2K+9IIQSnDjL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmgqqQMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88C8C433C7;
	Sun,  7 Apr 2024 08:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712478580;
	bh=yJyWAHSZog1ChlZCttGqgfDm8sPy24O6dL4fe1Cqumw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nmgqqQMPEviPm2sizxikzzOEh4Q/yexWx0HZ1MNex2H1lzxIe+SaJwqoW0kBrvI4v
	 eQtCCMW9jACIC+iWbCqFCBs+OisruoZI/HjZEAenv3t/Gl2qZ6r+/YWS8bdwej/Iiq
	 HzvjR6BHF1uz15hZY+2zifrorzLcpqjx14ld2vP+pDxeygho+FiuCwgXd4W7M2Bbs5
	 P2pgNMOqKEQHhCD+6I9/8KN1WSMi7l+SNc4DmrnN50xXvglEQ71DYwvDTGCyqrReT2
	 dO4aJ5/RRLhdnsFE3aiuTRy9EczHOwL5wfoMj0QjdInGroXr344meJxQ9ghUwTGf3c
	 1AK/su4NAwAMw==
Message-ID: <3a006357f78a07fdd558db827049307076ba6e23.camel@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add F_SETFL for fcntl
From: Geliang Tang <geliang@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki
	 <jakub@cloudflare.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,  bpf@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org
Date: Sun, 07 Apr 2024 16:29:31 +0800
In-Reply-To: <660f8268ddd8f_50b87208bb@john.notmuch>
References: 
	<b67101632c6858d281f105b5d4e1bc62dd6b7d27.1712133039.git.tanggeliang@kylinos.cn>
	 <878r1ubq8q.fsf@cloudflare.com> <660dd833358bd_2144820881@john.notmuch>
	 <74fec36278933bd0dd793875ac2343f528c9355d.camel@kernel.org>
	 <660f8268ddd8f_50b87208bb@john.notmuch>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-04 at 21:47 -0700, John Fastabend wrote:
> Geliang Tang wrote:
> > Hi Jakub,
> > =C2=A0
> > On Wed, 2024-04-03 at 15:29 -0700, John Fastabend wrote:
> > > Jakub Sitnicki wrote:
> > > > Hi Geliang,
> > > >=20
> > > > On Wed, Apr 03, 2024 at 04:32 PM +08, Geliang Tang wrote:
> > > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > > >=20
> > > > > Incorrect arguments are passed to fcntl() in test_sockmap.c
> > > > > when
> > > > > invoking
> > > > > it to set file status flags. If O_NONBLOCK is used as 2nd
> > > > > argument and
> > > > > passed into fcntl, -EINVAL will be returned (See do_fcntl()
> > > > > in
> > > > > fs/fcntl.c).
> > > > > The correct approach is to use F_SETFL as 2nd argument, and
> > > > > O_NONBLOCK as
> > > > > 3rd one.
> > > > >=20
> > > > > Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
> > > > > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > > > > ---
> > > > > =C2=A0tools/testing/selftests/bpf/test_sockmap.c | 2 +-
> > > > > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/tools/testing/selftests/bpf/test_sockmap.c
> > > > > b/tools/testing/selftests/bpf/test_sockmap.c
> > > > > index 024a0faafb3b..34d6a1e6f664 100644
> > > > > --- a/tools/testing/selftests/bpf/test_sockmap.c
> > > > > +++ b/tools/testing/selftests/bpf/test_sockmap.c
> > > > > @@ -603,7 +603,7 @@ static int msg_loop(int fd, int
> > > > > iov_count,
> > > > > int iov_length, int cnt,
> > > > > =C2=A0		struct timeval timeout;
> > > > > =C2=A0		fd_set w;
> > > > > =C2=A0
> > > > > -		fcntl(fd, fd_flags);
> > > > > +		fcntl(fd, F_SETFL, fd_flags);
> > > > > =C2=A0		/* Account for pop bytes noting each
> > > > > iteration
> > > > > of apply will
> > > > > =C2=A0		 * call msg_pop_data helper so we need to
> > > > > account for this
> > > > > =C2=A0		 * by calculating the number of apply
> > > > > iterations. Note user
> > > >=20
> > > > Good catch. But we also need to figure out why some tests
> > > > failing
> > > > with
> > > > this patch applied and fix them in one go:
> > > >=20
> > > > # 6/ 7=C2=A0 sockmap::txmsg test skb:FAIL
> > > > #21/ 7 sockhash::txmsg test skb:FAIL
> > > > #36/ 7 sockhash:ktls:txmsg test skb:FAIL
> > > > Pass: 42 Fail: 3
> >=20
> > Sorry, I didn't notice these fails in my testing before, they do
> > exist.
> > I'll try to fix them and sent a v2 soon.
>=20
> Not 100% sure but a hint. I would look into where the stream parser
> is waking up the sock here. I'm not sure there is an easy fix tbh.
> I can help look at this soon as well if you don't beat me to a fix.
>=20
> Thanks for looking into it.

I just sent a v2, please review it for me.

Thanks,
-Geliang

>=20
> >=20
> > Thanks,
> > -Geliang


