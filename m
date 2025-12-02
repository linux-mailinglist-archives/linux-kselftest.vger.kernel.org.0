Return-Path: <linux-kselftest+bounces-46895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63493C9C344
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 17:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA01334977F
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 16:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FC5298CDC;
	Tue,  2 Dec 2025 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="fpwHH3EZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A92285C80
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764692929; cv=none; b=SValtwbJaYBDKcY7b/aZASseCC/hQn0StRTp5/VNdm5y5ro134xeXgzdVLA0WlVMRSmEfD+nM6xthnieD+P4uaH/KcooNiE0BWm3m1wYDJy5XnMy9DaWgXDTa3KcGU3QtNkmbU2Eh1j8AoKoqUmQGoJXOowvWuycgept5UYR2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764692929; c=relaxed/simple;
	bh=kD390ooNLHbN4Jmys4fVkXFaVLOirI49yf1vt9Pc7mc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jqszoYLsRob5Nsyv5ywZWcK1RcebJjlamyZMDbAh8Xcmss5nPZeeuyrerRgal0b9rni7hsifQFCOHFtHi9pbwpPgp7Y22OoHK+1YnfQaPVgs/FlbhG0egVh4VvkfCpKJzmulj95VUvCU7QKoWpdTN7SIKu9zadYk1yAH/GKaeR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=fpwHH3EZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so65547885e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 08:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1764692926; x=1765297726; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B4N4egFc7xMOL4K643AEqRGrz/gWrW82OctMBiQ+vKY=;
        b=fpwHH3EZqwiM+FzWbWGlU/D2UMJ+2XB7RMPG7mtXF5RhcQmuUyk3KXSKMO8E54NnYi
         fNw6qY9TaJzYiNazHjZh2mW4wLMoaaCkt4CLs8iBR07fdMcg9RuQH8Kq3/Bh3StJAp2G
         FYRedz/eGbJTRhobAAFGkxWU2/99kEfCmAxfXjYeHhMSnaf+59l4ffxsRCEU9R3PX5qW
         PF0akTKsonKwo1fIkHOvbJb7BZgKd24RhRRv+u9E+CPw1VdzAGhauK1TKsFO19e04/cp
         ziaRxJFXtQbvHB03yMtZP2J4ut3c+Ke51QL91tsAG+l1tz6Qv9xTO4o81g4A3bVCconR
         J03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764692926; x=1765297726;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4N4egFc7xMOL4K643AEqRGrz/gWrW82OctMBiQ+vKY=;
        b=VvXhsW3NMbUmuXqeU/+gCE4LTb04HzhefOC4wVQp/l2S9ni1XxSBr142YOhgUsfrj9
         CpN/hXIGy3C6yDSZDVubz71T2wSiuSU9H/Gk+lLEU4RsCAbKzbJLveqcdrgIboh41VAt
         uVcFBkNFBJLbHBnsgLFF5MRc2lp9cnID1ag+VsuTopttxkamTvqEl8sBV8n36xlqCC3l
         mOtG83XQQoQNv19no1DxZmu+13uYlvvi7Odavd+7ZieA3BR76FJNT3powdpxcoKQqL1Z
         ppcjG/76GwDDLtXhl8TmQMn1A2NtcUOUAbqs8aT6iEeI+OPkS+uUcrEKcT281CJepSUn
         OuIA==
X-Forwarded-Encrypted: i=1; AJvYcCWb7nb53In2R0YaZFPt2OGTmJrRWExVslPfg/0ZaHd+h4au9x03W9jzAWdGkV38tXq9f6wiG8M+GKYvrKyfLJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAmbQxLWayl/uGQXM9TidOu6VPEWnSEA0wbdy3epm/eCZLqmbg
	L891VFq54/PSEsmoOUaVCiLyAMZEEh2UlGxfdnmYFIpOKBT0p4sm8fkaYUzMi3YkvAw=
X-Gm-Gg: ASbGncv0Qn9cWcGoJIZvKVDgvSbByZlJ2HKZNSMHQdbe+i26jlBL7FRFXzpRQr2Dxyh
	jf5WVD72fFflEt7xYhnYDiOX5/CcHe5MoQNaQJJqjTucq6MLS3u6hDHtTwUOO1Im7xL0EfAnNB/
	qNbcQBLRXwiluajYnyfIOrj57Q+/c0GtjBvhM3xky4f7lcvfCSGw6XMioWGEPknCYG210RsDvqY
	/U6J1An1dFuMXR+7AGy4ecz/ew1EFUQtWTVkfpZWC38sR1FrohKiGR+3XZmSpioj5YtoVcagDO+
	DgqiBRBQt2hHHjiB7bMOP6Hx1EPZpjqFQEW043/M8gMFsnFqUtZH5PPqdt3BZAslJU5e7vTxyVO
	e5QMeiDr2rOjmTT5Wv/enaplC22/7AJs3+3UspCRGvcULiSlyGS+2JI/Gj6gw4lGz8k05pv69Ew
	IZ4vGO+LWNKghK8NUbdblZp+G2d4IUm9Aaho1pOYg6wGuKmdBuBTxGtGGhUQ==
X-Google-Smtp-Source: AGHT+IHEohgWVxrJC3wUv+1UfUF+h+k1su5DH7oY04hLernsePLI1x0ZeQB/gl1hU6F3ciGyD0yOMw==
X-Received: by 2002:a05:600c:c8c:b0:471:1435:b0ea with SMTP id 5b1f17b1804b1-47904b242eemr320424965e9.24.1764692926009;
        Tue, 02 Dec 2025 08:28:46 -0800 (PST)
Received: from ?IPv6:2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8? ([2a01:e11:600c:d1a0:3dc8:57d2:efb7:51a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d613esm34377742f8f.11.2025.12.02.08.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 08:28:45 -0800 (PST)
Message-ID: <b7c7ee0c95241155dfa5f461d58b1bfd072a901b.camel@mandelbit.com>
Subject: Re: [RFC net-next 11/13] selftests: ovpn: add test for bound device
From: Ralf Lici <ralf@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>, Antonio Quartulli
	 <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Date: Tue, 02 Dec 2025 17:28:45 +0100
In-Reply-To: <aSg2L5eAAEhyHMxM@krikkit>
References: <20251121002044.16071-1-antonio@openvpn.net>
	 <20251121002044.16071-12-antonio@openvpn.net> <aSg2L5eAAEhyHMxM@krikkit>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-27 at 12:29 +0100, Sabrina Dubroca wrote:
> 2025-11-21, 01:20:42 +0100, Antonio Quartulli wrote:
> > From: Ralf Lici <ralf@mandelbit.com>
> >=20
> > Add a selftest to verify that when a socket is bound to a device,
> > UDP
> > traffic from ovpn is correctly routed through the specified
> > interface.
> >=20
> > The test sets up a P2P session between two peers in separate network
> > namespaces, connected via two veth pairs. It binds to both veth
> > interfaces and uses tcpdump to confirm that traffic flows through
> > the
> > expected paths.
>=20
> The current setup doesn't really test that, since it would also work
> without SO_BINDTODEVICE (traffic still flows through the expected veth
> if I pass "any" instead of veth1/veth2 to the new_peer commands).

Thanks for catching this. I see the issue and will try a different
approach in the next version of the patch.

> [...]
> > diff --git a/tools/testing/selftests/net/ovpn/common.sh
> > b/tools/testing/selftests/net/ovpn/common.sh
> > index d926413c9f16..c802e4e50054 100644
> > --- a/tools/testing/selftests/net/ovpn/common.sh
> > +++ b/tools/testing/selftests/net/ovpn/common.sh
> > @@ -66,9 +66,11 @@ setup_listener() {
> > =C2=A0}
> > =C2=A0
> > =C2=A0add_peer() {
> > +	dev=3D${2:-"any"}
>=20
> nit: no user of add_peer is patched to pass this extra argument

Yes, I initially considered using this function for test-bind.sh but
later abandoned the idea. I'll remove the argument since it's not
needed.

> > diff --git a/tools/testing/selftests/net/ovpn/test-bind.sh
> > b/tools/testing/selftests/net/ovpn/test-bind.sh
> > new file mode 100755
> > index 000000000000..fd7c3c8fdf63
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/ovpn/test-bind.sh
> > @@ -0,0 +1,103 @@
> [...]
> > +run_bind_test() {
> > +	dev1=3D${1}
> > +	dev2=3D${2}
> > +	raddr4_peer1=3D${3}
> > +	raddr4_peer2=3D${4}
> > +
> > +	touch /tmp/ovpn-bind1.log
> > +	touch /tmp/ovpn-bind2.log
> > +
> > +	ip netns exec peer1 ${OVPN_CLI} del_peer tun1 1 2>/dev/null
> > || true
> > +	ip netns exec peer2 ${OVPN_CLI} del_peer tun2 10
> > 2>/dev/null || true
> > +
> > +	# close any active socket
> > +	killall $(basename ${OVPN_CLI}) 2>/dev/null || true
> > +
> > +	ip netns exec peer1 ${OVPN_CLI} new_peer tun1 ${dev1} 1 10
> > 1 ${raddr4_peer1} 1
> > +	ip netns exec peer1 ${OVPN_CLI} new_key tun1 1 1 0 ${ALG} 0
> > data64.key
> > +	ip netns exec peer2 ${OVPN_CLI} new_peer tun2 ${dev2} 10 1
> > 1 ${raddr4_peer2} 1
> > +	ip netns exec peer2 ${OVPN_CLI} new_key tun2 10 1 0 ${ALG}
> > 1 data64.key
> > +
> > +	ip netns exec peer1 ${OVPN_CLI} set_peer tun1 1 60 120
> > +	ip netns exec peer2 ${OVPN_CLI} set_peer tun2 10 60 120
> > +
> > +	timeout 2 ip netns exec peer1 tcpdump -i veth1 "${PROTO,,}"
> > port 1 -n -q > /tmp/ovpn-bind1.log &
>=20
> Maybe add
> 2> /dev/null
> to clean up a bit the script output?

ACK.

> > +	tcpdump1_pid=3D$!
> > +	timeout 2 ip netns exec peer1 tcpdump -i veth2 "${PROTO,,}"
> > port 1 -n -q > /tmp/ovpn-bind2.log &
> > +	tcpdump2_pid=3D$!
> > +	sleep 0.5
> > +
> > +	ip netns exec peer1 ping -qfc 50 -w 1 5.5.5.2
> > +
> > +	wait ${tcpdump1_pid} || true
> > +	wait ${tcpdump2_pid} || true
> > +}
> > +
> > +run_bind_test veth1 any 10.10.10.2 10.10.10.1
> > +[ "$(grep -c -i udp /tmp/ovpn-bind1.log)" -ge 100 ]
> > +[ "$(grep -c -i udp /tmp/ovpn-bind2.log)" -eq 0 ]
> > +
> > +run_bind_test veth2 any 20.20.20.2 20.20.20.1
> > +[ "$(grep -c -i udp /tmp/ovpn-bind2.log)" -ge 100 ]
> > +[ "$(grep -c -i udp /tmp/ovpn-bind1.log)" -eq 0 ]
> > +
> > +run_bind_test any veth1 10.10.10.2 10.10.10.1
> > +[ "$(grep -c -i udp /tmp/ovpn-bind1.log)" -ge 100 ]
> > +[ "$(grep -c -i udp /tmp/ovpn-bind2.log)" -eq 0 ]
> > +
> > +run_bind_test any veth2 20.20.20.2 20.20.20.1
> > +[ "$(grep -c -i udp /tmp/ovpn-bind2.log)" -ge 100 ]
> > +[ "$(grep -c -i udp /tmp/ovpn-bind1.log)" -eq 0 ]
> > +
> > +cleanup
>=20
> And also clean up the log files? (maybe via "trap <function> EXIT" so
> that they get removed as well if the test fails)

ACK.

--=20
Ralf Lici
Mandelbit Srl

