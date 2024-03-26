Return-Path: <linux-kselftest+bounces-6626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD76688C4DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 15:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C5F320E52
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 14:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3371C12E1DF;
	Tue, 26 Mar 2024 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDUvXvv2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E43012E1D7
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462396; cv=none; b=A01sSqcauu8KvKpVX6BWZ08qHYzdmt3j4khP46lct0biDAARPbu0jAVSYVtUfnsDRd180NGZlv6TeppKg+3eMXAnWvjV7ZQneSkZTVKlupTJXW0/lLJWHMFslRFQJHkJ4CxXWx1Oy51SzLb9NYvmo0gnLSMHqv0rDZTd/QYO2MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462396; c=relaxed/simple;
	bh=Ww70idLh85KwhvV1sVUV1m9h2mGelthI31b/OdUF/6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=saxb9W+oOnqnjTJzbMQsvIzQiWJYHK6usd0NIswYNoE12Ke7FwqtIERec927FUs1qHuaZds0K0AR9veAlszwESkUb4Okqjf5MfJue1h6xBbiA/LwpNaCVLoW+nB7fVyguEeTLiPzeV5cwMrNh6yy2K35hr2uF4BZ0VlNXo4pCGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDUvXvv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE90C43142;
	Tue, 26 Mar 2024 14:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711462395;
	bh=Ww70idLh85KwhvV1sVUV1m9h2mGelthI31b/OdUF/6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KDUvXvv2688CsCjE1NpB6KM5rPT7KT1OJ9Z9bdo4Evp1F8ustlpV1FU5RVG4I3ASF
	 sIgVnx1ojTa3UdCAQqFUNHoAhQB2fJ2xE4TkrvPcqVbXTWNhCL/4+7bhHU5Dv6p1i3
	 d1l6AbdEL/tLZSMHUbUDRumOlVfRL88pDrjBpfae7yg2OqgAn3w6Dt7/N5M+r2Hpoo
	 xSzig117YfrCjpBFENsE5FSBZxDDLrb5LWDL8QORlCugY1ibfMgqgKnpVGu17T9RYO
	 XLmTE52L8TNuJX3Xl8dlR0u5zBA/1XzPR+YRozd/F9wjtE/22hS0y61Ktw5+bGxnyk
	 9v8Ukty4ZpwgA==
Date: Tue, 26 Mar 2024 07:13:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <nbu-linux-internal@nvidia.com>, Shuah Khan <shuah@kernel.org>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, Hangbin Liu <liuhangbin@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Benjamin Poirier
 <bpoirier@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH net-next mlxsw 03/14] selftests: forwarding: README:
 Document customization
Message-ID: <20240326071313.64287229@kernel.org>
In-Reply-To: <87cyrhjim4.fsf@nvidia.com>
References: <cover.1711385795.git.petrm@nvidia.com>
	<e819623af6aaeea49e9dc36cecd95694fad73bb8.1711385795.git.petrm@nvidia.com>
	<20240325173417.1a79b631@kernel.org>
	<87cyrhjim4.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 11:31:31 +0100 Petr Machata wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> 
> > On Mon, 25 Mar 2024 18:29:10 +0100 Petr Machata wrote:  
> >> +The forwarding selftests framework uses a number of variables that
> >> +influence its behavior and tools it invokes, and how it invokes them, in
> >> +various ways. A number of these variables can be overridden. The way these
> >> +overridable variables are specified is typically one of the following two
> >> +syntaxes:
> >> +
> >> +	: "${VARIABLE:=default_value}"
> >> +	VARIABLE=${VARIABLE:=default_value}
> >> +
> >> +Any of these variables can be overridden. Notably net/forwarding/lib.sh and
> >> +net/lib.sh contain a number of overridable variables.
> >> +
> >> +One way of overriding these variables is through the environment:
> >> +
> >> +	PAUSE_ON_FAIL=yes ./some_test.sh  
> >
> > I like this conversion a lot. Makes me want to propose that we make this  
> 
> Convention you mean?

Yes, sorry

> Nothing was converted, this has always worked.

Right, for forwarding and perhaps net.

> > a standard feature of kselftest. If "env" file exists in the test
> > directory kselftest would load its contents before running every test.
> >
> > That's more of a broader question to anyone reading on linux-kselftest@
> > if there's no interest more than happy to merge as is :)
> >  
> >> +The variable NETIFS is special. Since it is an array variable, there is no
> >> +way to pass it through the environment. Its value can instead be given as
> >> +consecutive arguments to the selftest:
> >> +
> >> +	./some_test.sh swp{1..8}  
> >
> > Did you consider allowing them to be defined as NETIF_0, NETIF_1 etc.?
> > We can have lib.sh convert that into an array with a ugly-but-short
> > loop, it's a bit tempting to get rid of the exception.  
> 
> The exception is a bit annoying, yeah. But it works today, should stay,
> and therefore should be documented, so the paragraph won't go away. I
> use it all the time, too. I basically don't use the config file, I just
> use the env overrides and the argv interface names. It's very handy.
> 
> The alternative is also very verbose:
> 
> 	NETIF_1=swp1 NETIF_2=swp2 NETIF_3=swp3 [...] ./some_test.sh.
> 
> Maybe we could do this though?
> 
> 	NETIFS="swp1 swp2 swp3 swp4 swp5 swp6 swp7 swp8" ./some_test.sh
> 
> And like this it won't make you want to pull your hair from all the
> repetition:
> 
> 	NETIFS=$(echo swp{1..8}) ./some_test.sh
> 
> But NETIFS is going to be a special case one way or another. That you
> need to specify it through several variables, or a variable with a
> special value, means you need to explain it as a special case in the
> documentation. At which point you have two exceptions, and an
> interaction between them, to describe.

I think there's some value in passing all inputs in the same way (thru
env rather than argv). I guess it's subjective, you're coding it up, 
so you can pick.

