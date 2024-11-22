Return-Path: <linux-kselftest+bounces-22438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CEA9D5AAF
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 09:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B58282DBC
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 08:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04C118595E;
	Fri, 22 Nov 2024 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYbNtLZs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55EB22075;
	Fri, 22 Nov 2024 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732262894; cv=none; b=SCBtDEPjH7L75HsRZP8fKA0XKTCbMGdVI8DWr9R5+uIoBRNdx+TNZvkQgSTAhnSOyKTjWypV3AlFjdHiaBa59j6esq0CcqItlE6YILRGotlw7LPXgOjwY8uNI3KwzbnK3y4lt9mPe+cBPOdHn9MtxbtNqW3aXVNmsZNxwZuiMWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732262894; c=relaxed/simple;
	bh=CRENlCeFjKp1teSVPje6LNVRkZym23xDWUnz2g4s93Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=VvznNauShGo/Y9Q+Wvc70t/1r2SmkMsSS77BZKBIJ9Mmt/GG/bLYmftn4WYOSUmMec4TChGoy7YCoBYc+DNtgqsfwX1tSSdlT3oXSVoIIalo2IkZ5xh/tj4cOT/6YIT//h5Fw9xAZQsPIACluq1h8cLLVbFibV7Aij0tYUUTUgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYbNtLZs; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4319399a411so16512485e9.2;
        Fri, 22 Nov 2024 00:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732262891; x=1732867691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CRENlCeFjKp1teSVPje6LNVRkZym23xDWUnz2g4s93Y=;
        b=lYbNtLZsm1AdtQLgWjQyEm2SycerIRHd5gk48toPfKOAiLuRFtvDiMla50CO4wWKLr
         qAjWX5hLOWxPGqRGtUfpBbvYwNGdFj0dD2Rwjz154hrn7LV35+PDfkSvntdlyMqAvcZz
         Z36lMwwq40hashh6pzt4/0FpI7+thte625Za8DPO3b+j/aUGPuhwToSbZPZOFlk3nc1Z
         IcKutwtBRlkrgKgz167s2HmM8u0840AmejxcVoagokn5137HNyvcuciNfxtQkgpcabDa
         4hMwLZlATtHJVGPKV/X8urEXEj9R71UrwPYHPvtnMqzeSzYkkdWhC0JLwM7g0Nts5ieL
         ksJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732262891; x=1732867691;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CRENlCeFjKp1teSVPje6LNVRkZym23xDWUnz2g4s93Y=;
        b=bLCo/xqvSMMneZaUytxgYvEJB9mzle7lZZU79niJo0T/flOunZm1JsCw5+utRQvroH
         3AgWopmi7CpXsvMxRGfguhLRwBAizwZy0c1CyIdYvFqxKSFprafBEZgbljOYmFMqghJ/
         OZpc+rh4SoIKw/aBNc04+801St0oicrA3D3uTrpjB+jTS5rm09vBUYmmw0JQut6WBfHE
         cyi/G3FfBeCcAfqW70cR93Ox9QhEQiP+AbI6w8imRaRRV1Km7yM/IAwHoajwNMJwZXEN
         9LHeUsvWj0iK4wITOpE3YuabUnleWICZfRXWPq1+ETZgSOhmCOCg5+FIdZnUHlryiRJc
         Ht9g==
X-Forwarded-Encrypted: i=1; AJvYcCU7J2BiAbg2H7Cjm/epWSwScp/SIrrhCUSaHFeiJE3vVQ13M1+orWaKzTIlwOawqriIDa2j+gEyV/dihsk=@vger.kernel.org, AJvYcCX0/GU46J89OzS/PPkEg2pcetH1+U7+Ob/to8UpycFxucoyyAovqWidX9qRE2WYzc6WAAeK2P5w@vger.kernel.org, AJvYcCXBHU2AgF4OV+o7xeZr97q29ySrUiCm8RiChNGUHnRleJOqmIDA+JojmRIc3VsBF+xL9eKPlNP53vuua9w/gEll@vger.kernel.org
X-Gm-Message-State: AOJu0YwH8qph7Y5+z14cFL1tEFokWY1Y7kvPhDeZ3UB4pdORwhs02anS
	e5oXMJkddFrIAIgnFMoe3OFtN9/URJcIaPsTm8c/48mzsu8vOW7w
X-Gm-Gg: ASbGncvV2ytftYxPLXNCkcIN5kJ+MDtLwXMAaRcgWgYBCpiw3OHEGi8NfkCVT0RKD9Z
	2PTcv6mlpqlmbIazkm8k8K8bUxIsFwGFFeRauwo8WPpEpNUJlM3Xz5i5YCEvBlYQ+qgpvYVR2w+
	Pov1YvKEhFM7zPb9mhur66N+DFNeUvS8WeTgetbHEIYPCOk1D/j0lEx5DgniZb33i3x7tla4OOd
	U+jh1HdRdQ4YcGeYX17qCPFa7PDtliRPPM9AfIMlUN1+y5/17s=
X-Google-Smtp-Source: AGHT+IFNYPiLHCvfwqauX65N922pYf9goUvBTiembEOBwYHJhpdRpvcKqXKj+RZ0TkoLvG3xeYPmbw==
X-Received: by 2002:a05:600c:3acb:b0:42c:b9c8:2bb0 with SMTP id 5b1f17b1804b1-433ce40ffc5mr15233765e9.4.1732262890899;
        Fri, 22 Nov 2024 00:08:10 -0800 (PST)
Received: from [127.0.0.1] ([82.102.65.185])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb4ecd8sm1692464f8f.60.2024.11.22.00.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 00:08:10 -0800 (PST)
Date: Fri, 22 Nov 2024 10:08:03 +0200
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Antonio Quartulli <antonio@openvpn.net>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v11 07/23] ovpn: introduce the ovpn_socket object
User-Agent: K-9 Mail for Android
In-Reply-To: <ece57745-183f-49cb-bfd5-76688f51f68b@openvpn.net>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net> <20241029-b4-ovpn-v11-7-de4698c73a25@openvpn.net> <62d382f8-ea45-4157-b54b-8fed7bdafcca@gmail.com> <1dffb833-1688-4572-bbf8-c6524cd84402@openvpn.net> <ca5c4c4b-bd9b-4ccc-9258-e78ec7684a85@gmail.com> <ece57745-183f-49cb-bfd5-76688f51f68b@openvpn.net>
Message-ID: <D477909D-C3F5-4736-A79F-BA9017AD7DE3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 21, 2024 11:36:19 PM, Antonio Quartulli <antonio@openvpn=2Enet>=
 wrote:
>On 21/11/2024 00:58, Sergey Ryazanov wrote:
>> On 15=2E11=2E2024 16:28, Antonio Quartulli wrote:
>>> On 10/11/2024 19:26, Sergey Ryazanov wrote:
>>>> On 29=2E10=2E2024 12:47, Antonio Quartulli wrote:
>>=20
>> [=2E=2E=2E]
>>=20
>>>>> +static bool ovpn_socket_hold(struct ovpn_socket *sock)
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0 return kref_get_unless_zero(&sock->refcount);
>>>>=20
>>>> Why do we need to wrap this kref acquiring call into the function=2E =
Why we cannot simply call kref_get_unless_zero() from ovpn_socket_get()?
>>>=20
>>> Generally I prefer to keep the API among objects consistent=2E
>>> In this specific case, it means having hold() and put() helpers in ord=
er to avoid calling kref_* functions directly in the code=2E
>>>=20
>>> This is a pretty simple case because hold() is called only once, but I=
 still like to be consistent=2E
>>=20
>> Make sense=2E The counterpart ovpn_socket_hold() function declared in t=
he header file=2E Probably that's why I missed it=2E Shall we move the hold=
ing routine there as well?
>
>I prefer not to, because that function is used only in socket=2Ec=2E Movi=
ng/declaring it in socket=2Eh would export a symbols that is not used anywh=
ere else=2E
>
>The _put() variant is instead use in peer=2Ec, thus it is exported=2E

Technically, inline function is not exported=2E On another hand, it makes =
sense to keep header file clean=2E Agree=2E

[=2E=2E=2E]
=20
>>>>> +int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct =
*ovpn)
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0 struct ovpn_socket *old_data;
>>>>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 /* sanity check */
>>>>> +=C2=A0=C2=A0=C2=A0 if (sock->sk->sk_protocol !=3D IPPROTO_UDP) {
>>>>=20
>>>> The function will be called only for a UDP socket=2E The caller makes=
 sure this is truth=2E So, why do we need this check?
>>>=20
>>> To avoid this function being copied/called somewhere else in the futur=
e and we forget about this critical assumption=2E
>>=20
>> Shall we do the same for all other functions in this file? E=2Eg=2E ovp=
n_udp_socket_detach/ovpn_udp_send_skb?
>
>Those functions work on a socket that is already owned, thus it already p=
assed this precheck, while _attach() is the one seeing the new socket for t=
he first time=2E
>
>If this check is triggered it would only be due to a bug=2E
>Hence the DEBUG_NET_WARN_ON_ONCE()=2E
>
>> And who is giving guarantee that the code will be copied together with =
the check?
>
>No guarantee is given :)
>
>>=20
>>> Indeed it's a just sanity check=2E
>>=20
>> Shall we check for pointers validity before dereferencing them?
>>=20
>> if (!ovpn || !sock || !sock->sk || !sock->sk->sk_protocol !=3D IPPROTO_=
UDP) {
>>=20
>> With the above questions I would like to show that it's endless number =
of possible mistakes=2E And no matter how much do we check, a creative engi=
neer will find a way to ruin the kernel=2E
>>=20
>> So, is it worth to spend code lines for checking socket for being UDP i=
nside a function that has '_udp_' in its name and is called only inside the=
 module?
>
>Are you suggesting we should drop any kind of check for functions called =
only within the module? I am not sure I follow=2E=2E

Sanity checks in the internal functions, yes=2E I'm afraid, they give a fa=
lse feel of safety=2E Short a clear code for me is more preferable, especia=
lly when I know in advance who and how going to call a function=2E

>Anyway, I am dropping the check at the beginning in the function=2E


