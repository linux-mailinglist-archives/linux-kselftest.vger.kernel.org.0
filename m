Return-Path: <linux-kselftest+bounces-27751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863C6A47FD8
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 14:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6851E1893FAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 13:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D341323371B;
	Thu, 27 Feb 2025 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="LCHhE1yp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE67523315A;
	Thu, 27 Feb 2025 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663832; cv=none; b=ce9ngD1M/+FwfQ0hmryeNOcidCsoxJOPV1Xsj19s2vCtZHbpKAmJRZAopwNAs7blceI35nB4NxJHDlAZ9yJs5Kf3PLYdlk0PeUq2EBFEzrL2bfJKNGWRB7ecHCPxx09rJV+YizWA5FluKKcJTEVQNX0PJzBYiIimZfq/uthn+tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663832; c=relaxed/simple;
	bh=EnaYxEWNVhiFd2VwNTO/O1KVXGEdkXwFWZgqg0p8524=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QaYM0Ev6TzIamFBEQWove9z4pESDfP2AKjeiKpZhZTFgn43ekfjt1ovEys1HMUZ/q+HstnKuwuTVUIx0poPotRzS9X1eAMLJrJAbwRXlVSCC+tJp9GSeFkg0WrxzehwzHIR98aq0aise2sU0bTeRkh3070elAPdeSfzXmk22QcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=LCHhE1yp; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1740663816; x=1741268616; i=ps.report@gmx.net;
	bh=R5lsuEL3fy+5WqWDG/oNetmCKrc6oS9esNqoBlre/so=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LCHhE1ypB0Y/4QiWnOiNTpNKaQpFrxF/zOeH9BKO9Nlyd3W9qnvqqpqywV9ZBSjA
	 vcs+DljMpHsjNPNWAOSTiiBrH1WxBEOFg4Ung0RRz849Wah8oEyONRvuNSOhIGCd7
	 BfXsvgh58EEJPvo9hSCOS4OCqoOB9YASbKV6dAhwC6lP8sMJpO/4Lshj8LI271QAU
	 NsLXVU9+DWB4rzQIhcF4Ad6btJeVd0yUsEEZZZkxqpU8ELbb1mr53Oy9gD23bc6WJ
	 xE5Zsd21jH5RfI+5I6BZoxXhIdWnc8Rn2y7kuD6xXHT/i75us/cTIPe85uYT30Poh
	 xYfltYFv5yIojOKPbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.151]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIdeR-1u2CVx3LCH-00CzJU; Thu, 27
 Feb 2025 14:43:36 +0100
Date: Thu, 27 Feb 2025 14:43:35 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Artem Chernyshev <artem.chernyshev@red-soft.ru>,
 Frederic Weisbecker <frederic@kernel.org>, Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH net-next v7 6/8] net: pktgen: fix mpls reset parsing
Message-ID: <20250227144335.6e3af335@gmx.net>
In-Reply-To: <02e13783-1f87-46a7-9396-96bf17e36a9f@redhat.com>
References: <20250224092242.13192-1-ps.report@gmx.net>
	<20250224092242.13192-7-ps.report@gmx.net>
	<02e13783-1f87-46a7-9396-96bf17e36a9f@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+Ztxo+GrUJYyVZhX+OnkbPgV2ht0yZ5uRxFD7snG/hFp5of1rre
 jatBeqzu2XfW0vjdWweSwBDvOkVExDh7nl24N6pzNIuP3YMnm5mOsCQiTgHZpYwrVU8bxOt
 6R9avd1lAsoKIxpTae8I1JUohvRDLIgJpSYIjvqt5Di75kgSbuIhkxpihrzgZpFK0sskQRH
 09kSpT9nrinD3xh8X/9zQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:22gMgeXLusM=;QEzdzt+ltYk8UIsghpU4FNh1kxs
 QVFuVJa4x6bzDcOW7AYh23h2owGM1tQPg9uNWNOIybZOyKJTKZkZxV68j2IBLyhvZd93AlJcW
 yQsedKkMqowh0V6u3lBwM0yKyvEXnbi1GKMNiV2gbVBJ3zHd4gABLuyeOewcSj4oFGgzFSy/d
 lM33E7QY6IjIY5jKnUIv8kSHPAMqeBuSsUJJbTjsl9FteqWXDZglsgWYHjWvLzPHFeuwnVG4S
 kfe6jbEmcXccq70sJwVUOZKryH+9ZfL2d8AxiHIqQFWdrzb3QZaU4CreGuZzmkblrpcTiFkN/
 fa3FaXqCvkotD3PCf7g54EyXdBYuikdcAsFyAE4qGjzhggpbcCYOyGB5UwPyhFmsIwshyJiZO
 uJGPah6/7WC5rntpF+jwsgBw5eUcFEoGvfE2AWtsDPPWEvI75kCNWmL3ea4SkIDCLpAcEKetK
 aDDSvMypLoQhRLP3MlxiXB4KUfZpeGD3w4DjhWu652qV6j+ufPqT8rTEIGzHNeHlor8wbkPaW
 IRVNa9esf0CAThhZf1VxC62Bl6j2HSNmlG76Q2XqWmMA5lrTeOzG2cxmX+mb9e05TA9OpHtGW
 qgtGt4JbZBjir4k8HVyQ1l8FlyngONwV0nWU+qKEjvN1uBYJrJwYQFFESE33iIcRlnXeYRBix
 J8ZuIoaIqsQ8yvuaj+n0OXLSAydAbm58M4eqT5BQAX5Br6o8D9O06+QERauEn7ZfOIPc105x2
 K34DTSYbnoBD+O+BpM43PVLH3ICYULeNQy6t6RBUVppOGYHU03omFURlpUmVIkj51F0KTFd5k
 HTbE6HZ3DqA/gvEXO6TdEzUnUdoCes6R32Y8utfYOGMPTfm70cafALKOFtOihcwxHXODGiFgS
 ToCfQObqERzxBlteDf+F318lI679ibBsnsIYZjRr4d4R3/EKVttMIHbnDKH3PCy7AbwzGhLHU
 nne8PYAp9DDGB7WUYOSH6cMBXFqWQZHZrKzZNXEa2Fbn+G5Gkn13Fy235mlhy3clYG9nHARtU
 Rhn3ksG2RJ/+5KsU/hhRnuQaClZTXh4JkXxGExoV57ZmkKZW+4nLS4r3/ycLkJd6/tr/zNy8p
 I664AryV0JdqMdaczyR24gEKObpdFw8LIuBPqtwO73XvcU9mSFcICmTCSZtQzB+1N2/WLWK9q
 PwdQXzODfdOq1SIYShBioDcRLDTd5y9HncTOIXepR8VKYREPNvRi1BdrDKixYrCAyzjuY0O1g
 SLg6vh/XG9MlugYwtaDSQqF6MYHYIK1F683MPAq+wSlYXQcjiXX0wpIU4zX5yICAHkuTVx3J9
 WCd1UV7nQD9cZXlqY4rIfsc4qE7HmJOt6wOuZc5KQswK/SQc4CR0lDYGYRP4hqQB6E1AYQ1BE
 c6AgnTl44jEUGC19FzzzM7UziLpB0Y7ZJsetd4OyxJC3zPfg9mdnO1dZAJ

On Thu, 27 Feb 2025 11:19:33 +0100, Paolo Abeni <pabeni@redhat.com> wrote:

> On 2/24/25 10:22 AM, Peter Seiderer wrote:
> > diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> > index ae5e81e62733..bb13a4591709 100644
> > --- a/net/core/pktgen.c
> > +++ b/net/core/pktgen.c
> > @@ -915,8 +915,13 @@ static ssize_t get_labels(const char __user *buff=
er,
> >
> >  		max =3D min(8, maxlen - i);
> >  		len =3D hex32_arg(&buffer[i], max, &tmp);
> > -		if (len <=3D 0)
> > +		if (len < 0)
> >  			return len;
> > +
> > +		// return empty list in case of invalid input and/or zero value
>
> I'm sorry for nit picking, but C-99 comments should be avoided

O.k., will change on next patch iteration, thanks for review!

Regards,
Peter

>
> Thanks,
>
> Paolo
>


