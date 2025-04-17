Return-Path: <linux-kselftest+bounces-31040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9457A91858
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 11:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7BE8445B70
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 09:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B96227E9C;
	Thu, 17 Apr 2025 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="NsQlRhYl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34F5189B8C;
	Thu, 17 Apr 2025 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883494; cv=none; b=ua1uwutDl+h8/S4UDpcxxcFzSHfuEveACypg5UrUtK45NhZgGO0hwqssAJvf/NZ+W2QYmJu4fVRUy/uqRuaHVQc7r3LRdrcuhOpSb0CHX6zBHqw8ByOb3BA5V/zQHUIxGuuRUpDfEIdLQC7CNHuU0l9V1jb47ezxTPg61iivzmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883494; c=relaxed/simple;
	bh=qV6wd0XaBpYUdHTNTl7eH/NcVPlbWBggaCBh21C9ZlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CI0oi/26L2aZvq/C+MHnS5YftVcpMepKU82R8qEfjT8dGk1jqE2UZnlIG/KORQ/Dumib+y1wGcRNllZl1pnlYlj+f2amhqxRUmGuwUJDK0T4fpYtLupzZP/59M24zfjtNjft/2oC8nYa5Y3QoVNlyAjZwBGpS1efCqOgTpFGrFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=NsQlRhYl; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [212.20.115.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 6ABE86166143;
	Thu, 17 Apr 2025 11:51:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1744883481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1LfRVlt70i3SJHIXIz6vqd3UAEcvnG03V8Mwe8AU5Ms=;
	b=NsQlRhYlqKCxV4QznBkgto1zEDuB/+M8fB4icn9zaktCGu5q8WTZB5fktMtbaVe7cpp3UO
	+1tyZOSiqj79j9B+3ovnRBTCQSSkh4hPCKoMuuD3PGCfN1mO/sOCLMw1CcnnJtycM5MOCY
	lQdqJo25hBY+miNGnK1Md6YWOzZxG9g=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>,
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Xiao Liang <shaw.leon@gmail.com>, steffen.klassert@secunet.com,
 antony.antony@secunet.com, willemdebruijn.kernel@gmail.com,
 David Ahern <dsahern@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Shuah Khan <skhan@linuxfoundation.org>
Subject:
 Re: [PATCH net-next v26 00/23] Introducing OpenVPN Data Channel Offload
Date: Thu, 17 Apr 2025 11:51:07 +0200
Message-ID: <5001537.31r3eYUQgx@natalenko.name>
In-Reply-To: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
References: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4642518.LvFx2qVVIh";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart4642518.LvFx2qVVIh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Thu, 17 Apr 2025 11:51:07 +0200
Message-ID: <5001537.31r3eYUQgx@natalenko.name>
In-Reply-To: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
References: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
MIME-Version: 1.0

Hello.

On =C3=BAter=C3=BD 15. dubna 2025 13:17:17, st=C5=99edoevropsk=C3=BD letn=
=C3=AD =C4=8Das Antonio Quartulli wrote:
> Notable changes since v25:
> * removed netdev notifier (was only used for our own devices)
> * added .dellink implementation to address what was previously
>   done in notifier
> * removed .ndo_open and moved netif_carrier_off() call to .ndo_init
> * fixed author in MODULE_AUTHOR()
> * properly indented checks in ovpn.yaml
> * switched from TSTATS to DSTATS
> * removed obsolete comment in ovpn_socket_new()
> * removed unrelated hunk in ovpn_socket_new()
>=20
> The latest code can also be found at:
>=20
> https://github.com/OpenVPN/ovpn-net-next

Thank you for this. I've backported the submission for my local v6.14-based=
 build (had to adjust for 69c7be1b903fca) and I'm using it now with [1] as =
you've suggested previously. So far so good. Feel free to add my:

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

A couple of notes if I may:

1. is it expected for then tun iface to stay after the connection is brough=
t down? If that matters, I'm using NetworkManager for managing my OpenVPN c=
onnections
2. a userspace nit probably not relevant to this submission: the daemon sti=
ll reports "DCO version:" but with "N/A" value because that version file un=
der /sys is not presented any more like it was with an out-of-tree v2 imple=
mentation

[1]: https://github.com/mandelbitdev/openvpn/tree/gianmarco/179-ovpn-support

>=20
> Thanks a lot!
> Best Regards,
>=20
> Antonio Quartulli
> OpenVPN Inc.
>=20
> ---
> Antonio Quartulli (23):
>       net: introduce OpenVPN Data Channel Offload (ovpn)
>       ovpn: add basic netlink support
>       ovpn: add basic interface creation/destruction/management routines
>       ovpn: keep carrier always on for MP interfaces
>       ovpn: introduce the ovpn_peer object
>       ovpn: introduce the ovpn_socket object
>       ovpn: implement basic TX path (UDP)
>       ovpn: implement basic RX path (UDP)
>       ovpn: implement packet processing
>       ovpn: store tunnel and transport statistics
>       ovpn: implement TCP transport
>       skb: implement skb_send_sock_locked_with_flags()
>       ovpn: add support for MSG_NOSIGNAL in tcp_sendmsg
>       ovpn: implement multi-peer support
>       ovpn: implement peer lookup logic
>       ovpn: implement keepalive mechanism
>       ovpn: add support for updating local or remote UDP endpoint
>       ovpn: implement peer add/get/dump/delete via netlink
>       ovpn: implement key add/get/del/swap via netlink
>       ovpn: kill key and notify userspace in case of IV exhaustion
>       ovpn: notify userspace when a peer is deleted
>       ovpn: add basic ethtool support
>       testing/selftests: add test tool and scripts for ovpn module
>=20
>  Documentation/netlink/specs/ovpn.yaml              |  367 +++
>  Documentation/netlink/specs/rt-link.yaml           |   16 +
>  MAINTAINERS                                        |   11 +
>  drivers/net/Kconfig                                |   15 +
>  drivers/net/Makefile                               |    1 +
>  drivers/net/ovpn/Makefile                          |   22 +
>  drivers/net/ovpn/bind.c                            |   55 +
>  drivers/net/ovpn/bind.h                            |  101 +
>  drivers/net/ovpn/crypto.c                          |  210 ++
>  drivers/net/ovpn/crypto.h                          |  145 ++
>  drivers/net/ovpn/crypto_aead.c                     |  383 ++++
>  drivers/net/ovpn/crypto_aead.h                     |   29 +
>  drivers/net/ovpn/io.c                              |  446 ++++
>  drivers/net/ovpn/io.h                              |   34 +
>  drivers/net/ovpn/main.c                            |  274 +++
>  drivers/net/ovpn/main.h                            |   14 +
>  drivers/net/ovpn/netlink-gen.c                     |  213 ++
>  drivers/net/ovpn/netlink-gen.h                     |   41 +
>  drivers/net/ovpn/netlink.c                         | 1258 +++++++++++
>  drivers/net/ovpn/netlink.h                         |   18 +
>  drivers/net/ovpn/ovpnpriv.h                        |   55 +
>  drivers/net/ovpn/peer.c                            | 1365 +++++++++++
>  drivers/net/ovpn/peer.h                            |  163 ++
>  drivers/net/ovpn/pktid.c                           |  129 ++
>  drivers/net/ovpn/pktid.h                           |   86 +
>  drivers/net/ovpn/proto.h                           |  118 +
>  drivers/net/ovpn/skb.h                             |   61 +
>  drivers/net/ovpn/socket.c                          |  233 ++
>  drivers/net/ovpn/socket.h                          |   49 +
>  drivers/net/ovpn/stats.c                           |   21 +
>  drivers/net/ovpn/stats.h                           |   47 +
>  drivers/net/ovpn/tcp.c                             |  598 +++++
>  drivers/net/ovpn/tcp.h                             |   36 +
>  drivers/net/ovpn/udp.c                             |  439 ++++
>  drivers/net/ovpn/udp.h                             |   25 +
>  include/linux/skbuff.h                             |    2 +
>  include/uapi/linux/if_link.h                       |   15 +
>  include/uapi/linux/ovpn.h                          |  109 +
>  include/uapi/linux/udp.h                           |    1 +
>  net/core/skbuff.c                                  |   18 +-
>  net/ipv6/af_inet6.c                                |    1 +
>  tools/testing/selftests/Makefile                   |    1 +
>  tools/testing/selftests/net/ovpn/.gitignore        |    2 +
>  tools/testing/selftests/net/ovpn/Makefile          |   31 +
>  tools/testing/selftests/net/ovpn/common.sh         |   92 +
>  tools/testing/selftests/net/ovpn/config            |   10 +
>  tools/testing/selftests/net/ovpn/data64.key        |    5 +
>  tools/testing/selftests/net/ovpn/ovpn-cli.c        | 2376 ++++++++++++++=
++++++
>  tools/testing/selftests/net/ovpn/tcp_peers.txt     |    5 +
>  .../testing/selftests/net/ovpn/test-chachapoly.sh  |    9 +
>  .../selftests/net/ovpn/test-close-socket-tcp.sh    |    9 +
>  .../selftests/net/ovpn/test-close-socket.sh        |   45 +
>  tools/testing/selftests/net/ovpn/test-float.sh     |    9 +
>  tools/testing/selftests/net/ovpn/test-tcp.sh       |    9 +
>  tools/testing/selftests/net/ovpn/test.sh           |  113 +
>  tools/testing/selftests/net/ovpn/udp_peers.txt     |    5 +
>  56 files changed, 9940 insertions(+), 5 deletions(-)
> ---
> base-commit: 23f09f01b495cc510a19b30b6093fb4cb0284aaf
> change-id: 20241002-b4-ovpn-eeee35c694a2
>=20
> Best regards,
>=20


=2D-=20
Oleksandr Natalenko, MSE
--nextPart4642518.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmgAzwsACgkQil/iNcg8
M0uluRAA57hH1FjxzJx2QU08priDGbP0JZH//2ZAYoYRNBkpfHrNoOagZwE9VZtQ
n87B06TbX32AX3B1agPIATdBYTm+2czKa70D3HIWW5kKzNCVzSjUjL7GhQzDMXSl
uIQblhdkbMLiJ86DLYDnHcfo+YiKnioz+0CK5xyjC/ddDQIpaVWc3PZq5xZoeQUx
KIc32o/cGirQXMVFCMD6prh6XWhwpXWPSvBcstQOpRUmgdiYm+ERuCr/M+/67SOp
7r8fjseLVL9E0Yb9awFcAzGratUKzeDn8MkJmAYiupWItNuV5gLiBkifBgwE0h2U
5PN3GOtkeJGh3isT6xqfRs2PjOi3GZirgSsdVDhjW9Zapc7zAJOJO6N2RGkT4KjE
YAthC8pe2uksRZbQf8FEHrOloSMqsVw+DgsOCp1EMFNvg668suxIgkpAup53csuD
GYDk1aoMGh+fU1lAFgZeTqvmsnC56cfpsfJwpLolpKMSpplBY7xLy/yBZK0RAJoW
sERhvjs4x64IJg8Q00DlqDfH12nT/Nqp32cIifPCfyzNiNQJkWF8YK65nGjvROyI
jBRXgy90GoCEcdbxCFBtlcDN1yXa6gxNHJSbh0aMPJYizH507zPKY5fO1Xw3sSsr
pXjuQRojYOGntfjeqCqHeT4EG6A+sUXPVQEI1fGKDDmWDabt0vY=
=KQn9
-----END PGP SIGNATURE-----

--nextPart4642518.LvFx2qVVIh--




