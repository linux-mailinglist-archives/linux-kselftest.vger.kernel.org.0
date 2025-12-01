Return-Path: <linux-kselftest+bounces-46779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D18FEC960B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 08:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB21E4E14BF
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 07:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001EF2D1907;
	Mon,  1 Dec 2025 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Imtjlb65";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rtCOe3YQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD5A23EA88;
	Mon,  1 Dec 2025 07:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764575124; cv=none; b=pKIfmSdUbVu6lGcoO33AsN1SejofitkxoNfHnPO1kqfrNvW6BFEQN80iGy8zXd0ddCuAg9Ydiy8PLpWMUKfqOZABGKfXg0qegLT49B+WzZODfruymgROABsqM0INQNZer2FnwWchrFnm3oqysOINa9VRIVIoeOzoB/rtonSqCXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764575124; c=relaxed/simple;
	bh=GBUGtKYwRwExyTl1p4q/ucqgy2VljRXPMtIc8z5zNyw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Rpy8yzlUkOqhHypfF7BT87k7nATwVha+TdPwGT4xT162oLXlHQNMf7lHjfx05aJJBg71XtXgjMXv59gWHOFZu5tUTkbBPF//xgFszFJVJhtBDi10hE38tmIjWYDkehB70FHQ3CChWs8fAEI6gyWkCQ8hjOZG+ZlrmUk5Kps5HVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Imtjlb65; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rtCOe3YQ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E620714001EF;
	Mon,  1 Dec 2025 02:45:20 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Mon, 01 Dec 2025 02:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1764575120;
	 x=1764661520; bh=V+VtHjpFIggTY5a4W6+5PNPiBiYU67RSG0Fw16B8tB4=; b=
	Imtjlb65F6aNGxQSqiacHGLD3G+WGURe08XiupPmYvEs0TDEJQJEsYicEpouU7r4
	m2YzbD+g08+QhnFoseMnDBd6rs4G2nAdRhdKBSMpRxFZke4giypD1Typ/O4FkASd
	WSV7IskUQnqATxg1kdqf0MvuWQV15M9K3MeV+6jA04LNzHxKlAyVxdTQFk2KkWYj
	18qGVjzLH5mZzdd2EYraVI38gOXD9iCvsSA3+Ab7iD6jyDEt0YbH4H7qdFbXsMK6
	B4j/N8YJCJZCJ/vskiv5ys+gIRiZYRgLfZ/EMSVKR7BY8P1NIvaW8jv3MJyqyGQ2
	xHapjTgQ5UeGCYAO+29sJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764575120; x=
	1764661520; bh=V+VtHjpFIggTY5a4W6+5PNPiBiYU67RSG0Fw16B8tB4=; b=r
	tCOe3YQWzoGavFq6z1jiSXe0Z381fhL+e6nZ980l+ms/8zcaB2d6E60vchQLiuQr
	hBV1NjiO5DMLHWsFwJsXDXjrx8lecnRH4s97kQBc1hNpKugv/eTgT94Wy40MZVbj
	SGXFzew5+SM8yIbnc2vFpmP8juH7ro97MCGwttffi6+lAz9q9V5XwtJDZI+ZnrI/
	5SR6mjSDVhlX4EPgck6iP6tLNBVUPGmugt0UdPtaRlrEFp5Q+qOqcSsiwzRujkW4
	jBKa2gpgxVf0GUjvOyqaivm2GWDdl47VcKlH4OiD2rCroS8tzcV+03JMLA1KVcoB
	6NqP+wNWfu7nuWQUhA+qw==
X-ME-Sender: <xms:kEctaeuSCbn4ZTg0wkyNXZpF5i7wBsDpnb88v78JA38ajsxIeOs6Nw>
    <xme:kEctaeSDRXm-G34tfFmT20RhdVTHhhtLb9tsc1rBZVC-0ZS0gq42-rnE4KkauUV6C
    onj7G_T6UXXop6gSx2xJQs5wMN4juniydEXLvqEaY877SYejJSMxfqb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghr
    nhgusgdruggvqeenucggtffrrghtthgvrhhnpedutddvudfftdffkeeuudehhfejkeekie
    eiudejfefgffehveeiudeuudffleffveenucffohhmrghinhepohhpvghnghhrohhuphdr
    ohhrghdptghpphhrvghfvghrvghntggvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfiesudifthdrvg
    hupdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigseifvghishhsshgthhhuhhdrnhgvth
X-ME-Proxy: <xmx:kEctaY7Bwlsk9Yt2mk0s6AnWxVgoznTmOLZbePY_rqOuPU_hi28xXw>
    <xmx:kEctaS1XtqLrjGFAC-xOZ12fzO_5VQjgzu0hWpaJ4e7fPQnrKMwkFg>
    <xmx:kEctaTDUqtPswDvBQJ4PvKd8Mc95Gnie41vnuQ6ZXwRqTqA9sYORlg>
    <xmx:kEctadO5EM6dRiTUADz94KEQYQquzzLcHvZfbvFYpdB5QQ6cNya3NQ>
    <xmx:kEctaR_may3E3k-UlEUvoGME39REZxBrOcI7oZT5AyeXcDhPmUDYtUbM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4C5EDC40054; Mon,  1 Dec 2025 02:45:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AuglI0iV1DGV
Date: Mon, 01 Dec 2025 08:45:00 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Willy Tarreau" <w@1wt.eu>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Message-Id: <75e632e3-3353-414d-9b8a-8bf9ca46b5a4@app.fastmail.com>
In-Reply-To: <20251130105842.GD31522@1wt.eu>
References: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
 <20251122-nolibc-uapi-types-v2-9-b814a43654f5@weissschuh.net>
 <20251130105842.GD31522@1wt.eu>
Subject: Re: [PATCH v2 09/13] tools/nolibc: always use 64-bit time types
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025, at 11:58, Willy Tarreau wrote:
> On Sat, Nov 22, 2025 at 05:59:15PM +0100, Thomas Wei=C3=9Fschuh wrote:

>>  struct timespec {
>> -	__kernel_old_time_t	tv_sec;
>> -	long			tv_nsec;
>> +	time_t	tv_sec;
>> +	int64_t	tv_nsec;
>>  };
>>  #define _STRUCT_TIMESPEC
>> =20
>> +/* Never use with system calls */
>>  struct timeval {
>> -	__kernel_old_time_t	tv_sec;
>> -	__kernel_suseconds_t	tv_usec;
>> +	time_t	tv_sec;
>> +	int64_t	tv_usec;
>>  };
>
> It seems to me that glibc continues to make the effort of using a long
> for tv_usec and tv_nsec. At least I'm seeing how that can make a
> difference for application code given that these fields are constantly
> multiplied or divided, forcing them to 64-bit when we know they'll nev=
er
> be larger than 1 billion is extra burden for the application. Another
> reason might be that the definition really changed from long to suseco=
nds_t
> in timeval a while ago, it's possible that it's used as a long in vari=
ous
> APIs (or even just printf formats).
>
> IMHO it would be cleaner to keep it as a long here, or do you have a
> particular reason for wanting int64_t (which BTW already forced a cast
> in sys_gettimeofday()) ?

As far as I can tell, it's the other way round for suseconds_t,
which in glibc is defined as

#if __TIMESIZE =3D=3D 64 && __WORDSIZE =3D=3D 32
# define __TIME_T_TYPE          __SQUAD_TYPE
# define __SUSECONDS_T_TYPE     __SQUAD_TYPE
#else
# define __TIME_T_TYPE          __SLONGWORD_TYPE
# define __SUSECONDS_T_TYPE     __SLONGWORD_TYPE
#endif

so this one is explicitly the same width as tv_sec, which has all
the issues you listed, but avoids the need for padding.

As far as I remember, the one reason for having a 'long tv_nsec'
with complex padding in glibc and musl is that this is actually
required by both Unix[1] and C11/C11 [2] standards.

C23 has updated the definition and does allow int64_t tv_nsec.
I think it makes sense for nolibc to just follow the kernel's
definition here.

       Arnd

[1] https://pubs.opengroup.org/onlinepubs/009695399/basedefs/time.h.html
[2] https://en.cppreference.com/w/c/chrono/timespec.html

