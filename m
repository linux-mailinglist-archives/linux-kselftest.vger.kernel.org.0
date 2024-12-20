Return-Path: <linux-kselftest+bounces-23641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC499F8AD6
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 05:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426CB16B625
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 04:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8E241C6A;
	Fri, 20 Dec 2024 04:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPw2ilWr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8C93214;
	Fri, 20 Dec 2024 04:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734667344; cv=none; b=PEVBRZEtOYh81Ojs7xGT3lLC1lWGimqzF/lSbuyXeAsxrvnS6cg3Xs/oNd5NQO3swGrrlE5l2yuxYzDdN3GKqsM5TwXKzHZZzw2Gr0PVmKkMO9u8zThKAUZJwrAa6jnaQ0pupqJo669FcHwvaPwbzdr7gVRIYJOC6KXm1g9wa+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734667344; c=relaxed/simple;
	bh=tovxRnxjQlj8lEgfixNPTlrabRgasmc2xbA+Lj8vFG0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XdpELQx7DZ3jbJUoTbYr4YTz9vziIjPMocn/nxvDCFU5mj6V5JOju/z0auXVJ6/dXMwNaYMpcJ1xXa39YGgB2Xd0XdGqk0yde01ydI90I3QaZv+S9xwly6j0SuW8SGNuNBejL3uNFaetLI9DthKd1QOASBiSArdSeC7dfMyBW9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPw2ilWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DCAC4CECD;
	Fri, 20 Dec 2024 04:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734667343;
	bh=tovxRnxjQlj8lEgfixNPTlrabRgasmc2xbA+Lj8vFG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vPw2ilWr9102/hZv7byL26crmJSYUAaje9TY3utzotXwkR2QxCCbcLJxcMuVGvorg
	 h/uEiGj0ljWDT0OUrrel+6BPIFdFIOeVwu9GC2bdUPq7NyBSjdizawLvciuPwaaw0h
	 C6v7p6ZJStFSk65MZv96tfK020LAuQDwadVW/FzvYeaXM+Z+Xbp1LFkZ4LMYcL/oRw
	 nvBBDBCs/pne0SPPsQTu3X0zauynMjVtItIHuBGxDC7rX10OBTP/hZYXoXYRq91AAR
	 Dtsrp8MbNtVtgz1/J2hOWMsyD/T6np4Z7AEd155NzlF3oLb6+PN3m0bo98Q95y5L0e
	 JbaTJ0Gh19T0A==
Date: Thu, 19 Dec 2024 20:02:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Shuah Khan
 <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Xiao Liang
 <shaw.leon@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH net-next v16 26/26] testing/selftests: add test tool and
 scripts for ovpn module
Message-ID: <20241219200222.4b0365b7@kernel.org>
In-Reply-To: <20241219-b4-ovpn-v16-26-3e3001153683@openvpn.net>
References: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
	<20241219-b4-ovpn-v16-26-3e3001153683@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Dec 2024 02:42:20 +0100 Antonio Quartulli wrote:
> +uint64_t nla_get_uint(struct nlattr *attr)
> +{
> +	if (nla_len(attr) =3D=3D sizeof(uint32_t))
> +		return nla_get_u32(attr);
> +	else
> +		return nla_get_u64(attr);
> +}

Fedora 41 has: libnl3 3.11.0
which already defines nla_get_uint()

ovpn-cli.c:46:10: error: conflicting types for =E2=80=98nla_get_uint=E2=80=
=99; have =E2=80=98uint64_t(struct nlattr *)=E2=80=99 {aka =E2=80=98long un=
signed int(struct nlattr *)=E2=80=99}
   46 | uint64_t nla_get_uint(struct nlattr *attr)
      |          ^~~~~~~~~~~~
In file included from /usr/include/libnl3/netlink/msg.h:11,
                 from /usr/include/libnl3/netlink/genl/genl.h:10,
                 from ovpn-cli.c:26:
/usr/include/libnl3/netlink/attr.h:126:25: note: previous declaration of =
=E2=80=98nla_get_uint=E2=80=99 with type =E2=80=98uint64_t(const struct nla=
ttr *)=E2=80=99 {aka =E2=80=98long unsigned int(const struct nlattr *)=E2=
=80=99}
  126 | extern uint64_t         nla_get_uint(const struct nlattr *);
      |                         ^~~~~~~~~~~~

