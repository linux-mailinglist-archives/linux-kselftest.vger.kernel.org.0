Return-Path: <linux-kselftest+bounces-44417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1384FC20B33
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F261D4EA210
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 14:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892A92741AC;
	Thu, 30 Oct 2025 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="VUwF3M4u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zlRp8j8q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9905237A3D1;
	Thu, 30 Oct 2025 14:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835485; cv=none; b=PLOYSXh4/ByjMz0LpteS7/SbzU52th7AOhywrH8zxi3gpNfae1GRqlhW+uzOLyibzm5Ck5ZKKhPm52CyU3rtmdxsGFMGMrG+gqj8/hovpnYM2PF5YaQLQNqeY8QBQvd02PillPjSpaMFDtkVVbLCnLQ+v9pOvGu2XKKyZ0L63PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835485; c=relaxed/simple;
	bh=PwhvSRS21iSQKsJhK25OTYl2tdvfGAD7VreEQnbaHOk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pCG8+6xx+JHrowoKxq73Et1cC50atvnEIXYLnBAeSSWRdDTwUQAmgPDfzFOJwDYKYY50Rc6Z/kAbDk9jwClO/k2jzD3tSmmn+jKZE28qxCBfZMWRGi34n1ZCPq6nzfVPbkx6E/PbQKSAM37Oe+98hGbFI3dT0Ii4fLNL5E+Hi2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=VUwF3M4u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zlRp8j8q; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D0E031D00150;
	Thu, 30 Oct 2025 10:44:42 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 10:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761835482;
	 x=1761921882; bh=j5qEYgVH4pWiU2Tr7DUND8Q5SNv/MiazP211kOzoKqY=; b=
	VUwF3M4uRSYB2esjUnweUNbUoImTncZVLbkgPtUWfeArsQC9xt232iygjIwMrY/9
	mJzZIwk8Td2Qf2DrJkF/kh/RxQX4ZBTfJkTQCWbO0WTk3ScT1MDWyF1tTI8to9vd
	0B/x8yNgm9B40RCaDlhdh4yv1bT4pJvvOzohD6ZG+nfeY4+GHOsqqOBPIGEpgK2b
	ryY1mmks3sSDYKVyl8uDmZ38tZIm1xFkqU7vy6cf+DZxMOIMWM9Tgn7cvCTdWM6N
	J/kklkub4lAa9DLz4IPmocQ5AcxcqxsvUwlOQaxmra7EsGNHFOEFw3QM3Qcpcq+/
	UHLP8SeO7nWxVrBQqylqSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761835482; x=
	1761921882; bh=j5qEYgVH4pWiU2Tr7DUND8Q5SNv/MiazP211kOzoKqY=; b=z
	lRp8j8q1X+anPH5UpJGBcuTzI6WxnmYLBO7GWRvmOkor1zuDxFUyos4e4lwtxDxb
	IYn9psJxzN44jno4V2lL716X2cp+hxADg3UCfez6U6zUuQebn27Z1nnyw43CwoJe
	GKAnEeN3npXdOSeSVfhii3H8USuNB7/yklF3p/Ue5adC8T2MH/bHNHPd7WFDBcJJ
	Kg77brtWt1dHzM/qibRxiAAdXfCzC59EEXhKJmh9LoOw3ItBkRuVmXpQkAtol7M5
	rB3yTllcoi+AF3/f1LxPrH4zLCsay3b8U089X5lEqiKaIiW8NO/sWhtG8U1gF/Vv
	gAG8PlfLmIXw7CYj44l/Q==
X-ME-Sender: <xms:2nkDaaag2UPsRzRn8f5aosTHNomzao-YXLeP2mR3LTWiS_83cUsA3A>
    <xme:2nkDaYNelVJTaezHp3UuAIWOs4DdAW4gEmLyG0ToBcwV8v_rb1OniLu-AqduWZOcN
    yMiPiQXMto8AvUlfIWelVUBj8pu7yGBg2MSoQhUP_Opgzo4z_cLrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeikeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghr
    nhgusgdruggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvle
    ehvddvgeejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtth
    hopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifsedufihtrdgvuhdprhgt
    phhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugiesfigvihhsshhstghhuhhhrdhnvght
X-ME-Proxy: <xmx:2nkDaTzQjT52IICjAWgTRYkMHN6ZHk_YrA1LPY9kc4zshzcVoVq6CA>
    <xmx:2nkDaZPZAGE6ocQQ1lsnZL6Y3pOFuqa46cZUvxb3wv8w5haNB7rMiA>
    <xmx:2nkDafr2yxVwOfsGbNQbsVlZqDbBoHMK29hFJtQvvbMR04uYmGYffA>
    <xmx:2nkDaSEf-EoL_N2-Q_vS8wJxPUhUs8xRFnil8RAgi6MZSrVRb7eRag>
    <xmx:2nkDaf0co3dnRV918FUjASKEaXyaq52V-4Onyhc1ONoD8ImZfSfyZySh>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1CEA0700065; Thu, 30 Oct 2025 10:44:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ALgYOFaxVfwk
Date: Thu, 30 Oct 2025 15:44:21 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "Willy Tarreau" <w@1wt.eu>, shuah <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-Id: <fbca1d3e-12e4-4c4e-8091-87464035fe39@app.fastmail.com>
In-Reply-To: <20251029-nolibc-uapi-types-v1-7-e79de3b215d8@weissschuh.net>
References: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
 <20251029-nolibc-uapi-types-v1-7-e79de3b215d8@weissschuh.net>
Subject: Re: [PATCH 07/12] tools/nolibc: prefer explicit 64-bit time-related system
 calls
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025, at 17:02, Thomas Wei=C3=9Fschuh wrote:
> Make sure to always use the 64-bit safe system calls
> in preparation for 64-bit time_t on 32-bit architectures.
>
> Also prevent issues on kernels which disable CONFIG_COMPAT_32BIT_TIME
> and therefore don't provide the 32-bit system calls anymore.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Thanks for working on this!

> -#if defined(__NR_ppoll)
> -	struct timespec t;
> +#if defined(__NR_ppoll_time64)
> +	struct __kernel_timespec t;
>=20
>  	if (timeout >=3D 0) {
>  		t.tv_sec  =3D timeout / 1000;
>  		t.tv_nsec =3D (timeout % 1000) * 1000000;
>  	}
> -	return my_syscall5(__NR_ppoll, fds, nfds, (timeout >=3D 0) ? &t : NU=
LL,=20
> NULL, 0);
> +	return my_syscall5(__NR_ppoll_time64, fds, nfds, (timeout >=3D 0) ? =
&t=20

This looks good to me.

> -#elif defined(__NR_ppoll_time64)
> -	struct __kernel_timespec t;
> : NULL, NULL, 0);
> +#elif defined(__NR_ppoll)
> +	struct timespec t;
>=20
>  	if (timeout >=3D 0) {
>  		t.tv_sec  =3D timeout / 1000;
>  		t.tv_nsec =3D (timeout % 1000) * 1000000;
>  	}

This is not wrong, but for consistency, I would use
__kernel_old_timespec with the old syscall macros, rather
than the nolibc-defined type.

A different approach would be to rely on timespec/timeval/time_t
to always use the 64-bit types and then just pick the time64
macros on 32-bit vs the old macros on 64-bit builds.

> -	return my_syscall5(__NR_ppoll_time64, fds, nfds, (timeout >=3D 0) ? =
&t=20
> : NULL, NULL, 0);
> +	return my_syscall5(__NR_ppoll, fds, nfds, (timeout >=3D 0) ? &t : NU=
LL,=20
> NULL, 0);
>  #else
>  	return my_syscall3(__NR_poll, fds, nfds, timeout);
>  #endif

I would think that we can remove the final #else clause here
and just use the __NR_ppoll case as #else. It would also make
sense to change the first #if to check for a 32-bit ABI.

> diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> index e91b7d947161..10c517a38f86 100644
> --- a/tools/include/nolibc/sys.h
> +++ b/tools/include/nolibc/sys.h
> @@ -772,22 +772,22 @@ int sys_select(int nfds, fd_set *rfds, fd_set=20
> *wfds, fd_set *efds, struct timeva
>  	return my_syscall5(__NR__newselect, nfds, rfds, wfds, efds, timeout);
>  #elif defined(__NR_select)
>  	return my_syscall5(__NR_select, nfds, rfds, wfds, efds, timeout);
> -#elif defined(__NR_pselect6)
> -	struct timespec t;
> +#elif defined(__NR_pselect6_time64)
> +	struct __kernel_timespec t;

These probably need to be flipped around, so that
__NR_pselect6_time64/__NR_pselect6 comes first because the other
ones use the wrong type on 32-bit targets.

Probably also do the same thing here with the #ifdef checking
the architecture instead of the syscall macro.

       Arnd

