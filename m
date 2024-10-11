Return-Path: <linux-kselftest+bounces-19546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C121299A639
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 16:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23043B22200
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 14:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208FC212F10;
	Fri, 11 Oct 2024 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdxXXWlw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6041D184;
	Fri, 11 Oct 2024 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728656668; cv=none; b=ksjpn3A8PhJeeWJhInqtdsQn5780ptfgazK6wSTtB4ZzEjg4q9c332Qxfteg8V+2fVcxygBszDvuWVSGx5DWC/BXXk9XM75/o5WpI8q+KIx1CMGYEaCTlRbyTSayyywwoPh2NYfTwQvozAkoxU65bIBzivwvTrBu0bGokAptu/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728656668; c=relaxed/simple;
	bh=LtXyNM62NkXZLB9weGY2cVYVmMXFoznksfl71Jgc2iU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WgaN/9PFKPQlSfgfXfNGdM9wv48OOhaSrNtsDVyK2jyvBuTeWPlgbETrdEdwzxDcymQwEJYoR86I9HoaIRpea99sw5jpJUqJzinL1h+EzjHeYAdRwt06KE2zDARvBUt0F2YF7dX7Iy6nwOKk5aDTl5tl24Xrkhc7em8AhGNjhkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdxXXWlw; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7ac83a98e5eso177728185a.0;
        Fri, 11 Oct 2024 07:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728656665; x=1729261465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3Ndp/aqxMw2Ywk3XYR8tBpw5H/Z8ESJM53gLyI3x8c=;
        b=LdxXXWlwTkvTHUwUWlTnrN2Z9qqCsaezf33ullQDoyuLSP4M7UY8I0myG+c3TB9lCE
         ePjNNUmeYux1pCVlXHwrakrj8wKk5kSel+jkR/hydET6cAXFMZlTLZPj7OJwk48F0GLB
         XKxfLMfTksRVauVtKD57ip0IwT8Rw4LtMDimEhkABVf5aOqLT2DcOra+eRoSgy/N9YPz
         QA2q7wACSwgCWJ5Nt9GZ8dFNIKyJ2QaUpPYCHjXfrYEv8hJeCS8kbVnUE+SjNXU2dinR
         1GG0vV6rEvcoqgZXZYy9qdAsey/5fa98yE5E9dh0br6UU9OfrKBJH41qzb2kOs5aCUZ2
         79Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728656665; x=1729261465;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e3Ndp/aqxMw2Ywk3XYR8tBpw5H/Z8ESJM53gLyI3x8c=;
        b=FPmEsqxC8apUHruSSPWhsLo7iXnLT56WdHnRS/w+OuoTjOdyx7Mgzwx32wtAA6ErF7
         BdZJosmxNEHDm8TvcXKgqxyZm7e/2sAFiaIBdg/kf20vKI3JWCXJSselShi5jhKNHQYb
         cBGrEi+nFIGfCDRtTWR+7lIJ42TrjRsR9yvbtZHEynitrqI6shfrW9UvaO3K1TiUAxEo
         nW37y6oh42FCkor0noVaHyrYbgmBydGJq8ORCeNsa+Cjvqsquqi+k3wEI+l1sTeLva1p
         I710p+bhEk1GhuhgwNRNTqYMxuCGoIGPWp8hqQRhf5+xM1yjYE/2BvKdQFRTTLwrUoY4
         Lj8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnMT/eyzL8pJcWfcYoSgMoMZD+a1C9on1PiMSSFJDIrO5371d0bJ8fhAYSiTmBRwBlmB362Rrj8wRj3wj5rWns@vger.kernel.org, AJvYcCVZ7x45xoAU4mIFQfBW58cUlFdapDbH4t70t1Gr3oWYtZAfQt8mWQ0oCGDO2U6iN2HyMGdbh9BM@vger.kernel.org, AJvYcCVnSUUfLktIJsJ/+cdGUAW1K2mXrf32c1ygpZSL9No0uz2fx5K7bFEIKpTrAtEC9xrhDBztWIiZmi9SqM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzvlBvE67R/vuzNGJt+BNf4ZJkVwgn+NJfO6g3leesI5RCi7pF
	BzMd/Bz4h8dc12gdaoUXSUQQ99I801M2J3+FT+PIPL2MoAlaqow4
X-Google-Smtp-Source: AGHT+IGGDBpr0GaG5nVh2SzB5lHjKYWK/2Fhvu/GT5FBEKLjUcVVAGYcNI8DAScaKZtT+Ix7wMFUWg==
X-Received: by 2002:a05:620a:3f85:b0:7a9:b80b:81e with SMTP id af79cd13be357-7b11a37976amr542462085a.10.1728656665080;
        Fri, 11 Oct 2024 07:24:25 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1147aec68sm137462685a.0.2024.10.11.07.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 07:24:24 -0700 (PDT)
Date: Fri, 11 Oct 2024 10:24:24 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gur Stavi <gur.stavi@huawei.com>, 
 'Willem de Bruijn' <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 shuah@kernel.org
Message-ID: <6709351831a93_234aca294c6@willemb.c.googlers.com.notmuch>
In-Reply-To: <000201db1b9c$db32f6c0$9198e440$@huawei.com>
References: <67054127bb083_18b21e2943f@willemb.c.googlers.com.notmuch>
 <20241009065837.354332-1-gur.stavi@huawei.com>
 <67068a44bff02_1cca3129431@willemb.c.googlers.com.notmuch>
 <002201db1a75$9a83b420$cf8b1c60$@huawei.com>
 <67072012c983a_1e805629421@willemb.c.googlers.com.notmuch>
 <002701db1ae3$368d9b70$a3a8d250$@huawei.com>
 <6707e3028d844_20573a294f0@willemb.c.googlers.com.notmuch>
 <000101db1b2f$7410c2f0$5c3248d0$@huawei.com>
 <67085135e4fe2_21530629429@willemb.c.googlers.com.notmuch>
 <000201db1b9c$db32f6c0$9198e440$@huawei.com>
Subject: RE: [PATCH net-next v02 1/2] af_packet: allow fanout_add when socket
 is not RUNNING
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Gur Stavi wrote:
> > Gur Stavi wrote:
> > > > Gur Stavi wrote:
> > > > > > Gur Stavi wrote:
> > > > > > > > Gur Stavi wrote:
> > > > > > > > > >> @@ -1846,21 +1846,21 @@ static int fanout_add(struct
> > sock
> > > > *sk,
> > > > > > > > struct fanout_args *args)
> > > > > > > > > >>  	err = -EINVAL;
> > > > > > > > > >>
> > > > > > > > > >>  	spin_lock(&po->bind_lock);
> > > > > > > > > >> -	if (packet_sock_flag(po, PACKET_SOCK_RUNNING) &&
> > > > > > > > > >> -	    match->type == type &&
> > > > > > > > > >> +	if (match->type == type &&
> > > > > > > > > >>  	    match->prot_hook.type == po->prot_hook.type &&
> > > > > > > > > >>  	    match->prot_hook.dev == po->prot_hook.dev) {
> > > > > > > > > >
> > > > > > > > > > Remaining unaddressed issue is that the socket can now be
> > > > added
> > > > > > > > > > before being bound. See comment in v1.
> > > > > > > > >
> > > > > > > > > I extended the psock_fanout test with unbound fanout test.
> > > > > > > > >
> > > > > > > > > As far as I understand, the easiest way to verify bind is
> > to
> > > > test
> > > > > > that
> > > > > > > > > po->prot_hook.dev != NULL, since we are under a bind_lock
> > > > anyway.
> > > > > > > > > But perhaps a more readable and direct approach to test
> > "bind"
> > > > > > would be
> > > > > > > > > to test po->ifindex != -1, as ifindex is commented as
> > "bound
> > > > > > device".
> > > > > > > > > However, at the moment ifindex is not initialized to -1, I
> > can
> > > > add
> > > > > > such
> > > > > > > > > initialization, but perhaps I do not fully understand all
> > the
> > > > > > logic.
> > > > > > > > >
> > > > > > > > > Any preferences?
> > > > > > > >
> > > > > > > > prot_hook.dev is not necessarily set if a packet socket is
> > bound.
> > > > > > > > It may be bound to any device. See dev_add_pack and
> > ptype_head.
> > > > > > > >
> > > > > > > > prot_hook.type, on the other hand, must be set if bound and
> > is
> > > > only
> > > > > > > > modified with the bind_lock held too.
> > > > > > > >
> > > > > > > > Well, and in packet_create. But setsockopt PACKET_FANOUT_ADD
> > also
> > > > > > > > succeeds in case bind() was not called explicitly first to
> > bind
> > > > to
> > > > > > > > a specific device or change ptype.
> > > > > > >
> > > > > > > Please clarify the last paragraph? When you say "also succeeds"
> > do
> > > > you
> > > > > > > mean SHOULD succeed or MAY SUCCEED by mistake if "something"
> > > > happens
> > > > > > ???
> > > > > >
> > > > > > I mean it succeeds currently. Which behavior must then be
> > maintained.
> > > > > >
> > > > > > > Do you refer to the following scenario: socket is created with
> > non-
> > > > zero
> > > > > > > protocol and becomes RUNNING "without bind" for all devices. In
> > > > that
> > > > > > case
> > > > > > > it can be added to FANOUT without bind. Is that considered a
> > bug or
> > > > > > does
> > > > > > > the bind requirement for fanout only apply for all-protocol (0)
> > > > > > sockets?
> > > > > >
> > > > > > I'm beginning to think that this bind requirement is not needed.
> > > > >
> > > > > I agree with that. I think that is an historical mistake that
> > socket
> > > > > becomes implicitly bound to all interfaces if a protocol is defined
> > > > > during create. Without this bind requirement would make sense.
> > > > >
> > > > > >
> > > > > > All type and dev are valid, even if an ETH_P_NONE fanout group
> > would
> > > > > > be fairly useless.
> > > > >
> > > > > Fanout is all about RX, I think that refusing fanout for socket
> > that
> > > > > will not receive any packet is OK. The condition can be:
> > > > > if (po->ifindex == -1 || !po->num)
> > > >
> > > > Fanout is not limited to sockets bound to a specific interface.
> > > > This will break existing users.
> > >
> > > For specific interface ifindex >= 1
> > > For "any interface" ifindex == 0
> > > ifindex is -1 only if the socket was created unbound with proto == 0
> > > or for the rare race case that during re-bind the new dev became
> > unlisted.
> > > For both of these cases fanout should fail.
> > 
> > The only case where packet_create does not call __register_prot_hook
> > is if proto == 0. If proto is anything else, the socket will be bound,
> > whether to a device hook, or ptype_all. I don't think we need this
> > extra ifindex condition.
> > 
> 
> Even though "unbound" is an unlikely state for such a socket the code
> Should still address this state consistently. If do_bind sets ifindex
> to -1 on the unlikely unlisted scenario so should packet_create on the
> more likely proto == 0 scenario.

do_bind sets it to -1 for unlisted probably to copy existing behavior
in packet_notifier on NETDEV_DOWN.

But as far as I can tell nothing that uses po->ifindex differentiates
between 0 and -1. It just means that no actual device ifindex matches.

> > > >
> > > > Binding to ETH_P_NONE is useless, but we're not going to slow down
> > > > legitimate users with branches for cases that are harmless.
> > > >
> > >
> > > With "branch", do you refer to performance or something else?
> > > As I said in other mail, ETH_P_NONE could not be used in a fanout
> > > before as well because socket cannot become RUNNING with proto == 0.
> > 
> > Good point.
> > 
> > > For performance, we removed the RUNNING condition and added this.
> > > It is not like we need to perform 5M fanout registrations/sec. It is a
> > > syscall after all.
> > 
> > It's as much about code complexity as performance. Both the patch and
> > resulting code should be as small and self-evident as possible.
> > 
> > Patch v3 introduces a lot of code churn.
> 
> Did you look at a side by side comparison?

Obviously

> There is really very little
> extra code.

 1 file changed, 21 insertions(+), 14 deletions(-)

vs

 1 file changed, 5 insertions(+), 5 deletions(-)

for v2.

> > 
> > If we don't care about opening up fanout groups to ETH_P_NONE, then
> > patch v2 seems sufficient. If explicitly blocking this, the ENXIO
> > return can be added, but ideally without touching the other lines.
> > 
> 
> I am not the one to decide if opening it is a good idea but it will be
> ironic if a patch with the intention to remove the only-RUNNING
> restriction will end up allowing never-RUNNING sockets into a fanout
> group.

It's fine to catch that, seem to just be this change?

        spin_lock(&po->bind_lock);
-       if (po->running &&
+       if (po->num != ETH_P_NONE &&
            match->type == type &&
            match->prot_hook.type == po->prot_hook.type &&
            match->prot_hook.dev == po->prot_hook.dev) {
 

