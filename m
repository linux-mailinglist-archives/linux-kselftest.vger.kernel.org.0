Return-Path: <linux-kselftest+bounces-27205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE263A3FD6B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 18:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A7B189BFA9
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 17:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0852500D0;
	Fri, 21 Feb 2025 17:28:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CBB24E4CF;
	Fri, 21 Feb 2025 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158896; cv=none; b=pe3yMQ6wnt3oqM3wRQF+GcoVLh+FAtnm3VXbDQa3ISlCdD3V6i8UXLIyae49U0jQ71ngArmj6boYG4OwDupqd9IOetSO+8btm7rAHhV0NQ0hvFO8dIl+QNPtVec8TSbgTUx6JgTw5tTuru6zZcmfImIFOBtQL2f7z//QmnONCCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158896; c=relaxed/simple;
	bh=TCTjfuF7hFlEFq4vuVBpdDGQghbQzmxUrWm+FF+HsIg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Et2S6t1uksGX3CyoWHp7vf2BMFFpEfAWeNnU3a95gKtGiSSsBaFSi03HlDNfUK68NiDVXBXnbOA9TasFaTSiBtxswg4oAw5sXgSAVMRcmTtf3RPZvvd3lNnldXBTC5T/6S0xKqHR0QeDiczfXzw04s5StqPGFLjzazY+/iWdh0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3D4C4CED6;
	Fri, 21 Feb 2025 17:28:14 +0000 (UTC)
Date: Fri, 21 Feb 2025 12:28:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: realxxyq@163.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yiqian Xun <xunyiqian@kylinos.cn>, Beau
 Belgrave <beaub@linux.microsoft.com>
Subject: Re: [PATCH v1] selftests/user_events: Fix failures caused by test
 code
Message-ID: <20250221122842.379198f9@gandalf.local.home>
In-Reply-To: <b62b6dbf-eeb1-495d-a86b-38f05a17d60e@linuxfoundation.org>
References: <20250221033555.326716-1-realxxyq@163.com>
	<b62b6dbf-eeb1-495d-a86b-38f05a17d60e@linuxfoundation.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Feb 2025 08:46:31 -0700
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 2/20/25 20:35, realxxyq@163.com wrote:
> > From: Yiqian Xun <xunyiqian@kylinos.cn>
> >=20
> > In parse_abi function,the dyn_test fails because the
> > enable_file isn=E2=80=99t closed after successfully registering an even=
t.
> > By adding wait_for_delete(), the dyn_test now passes as expected.
> >=20
> > Signed-off-by: Yiqian Xun <xunyiqian@kylinos.cn>
> > ---
> >   tools/testing/selftests/user_events/dyn_test.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >=20
> > diff --git a/tools/testing/selftests/user_events/dyn_test.c b/tools/tes=
ting/selftests/user_events/dyn_test.c
> > index bdf9ab127488..54c9412f8dee 100644
> > --- a/tools/testing/selftests/user_events/dyn_test.c
> > +++ b/tools/testing/selftests/user_events/dyn_test.c
> > @@ -127,6 +127,8 @@ static int parse_abi(int *check, const char *value)
> >  =20
> >   	close(fd);
> >  =20
> > +	wait_for_delete();
> > +
> >   	return ret;
> >   }
> >    =20
>=20
> Adding Steve for review.
>=20
> Steve, please review the patch. If you are happy with it
> give me Ack or Reviewed-by if you want to take this through
> my tree.

Actually, Beau should review it.

Beau?

Here's the patch: https://lore.kernel.org/all/20250221033555.326716-1-realx=
xyq@163.com/

-- Steve




