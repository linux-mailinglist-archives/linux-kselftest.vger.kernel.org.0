Return-Path: <linux-kselftest+bounces-911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF77F7FFD28
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 21:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1621C20F04
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 20:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E5C53805;
	Thu, 30 Nov 2023 20:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kU2DXMYA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5349A10E4;
	Thu, 30 Nov 2023 12:57:27 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-daf7ed42ea6so1339747276.0;
        Thu, 30 Nov 2023 12:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701377846; x=1701982646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzmDf72q+PIr46nq4RCKd2VPzq1SXfgspI/h2bERP68=;
        b=kU2DXMYAqZ9SOBbB7tiNxwUQQtUNpRgvIy535hmyRL7PV2wIzqkgkPATYZnGmzDRHU
         pxg9nWLduRhj6l0l7tt7k020Acq5jzA2fjO+I5GdE7B/iexQQARN5Ni4PA2YItzDU7xZ
         CWGAIU2+OOX0fIuzuoSg9seloDgq0sGYxuGOdcte5Nyn7+0cq0HiSt+Ei8p9JrbniZvo
         pbWqGcO2xKn6xDaxj1zoyV87L/3f4PciXahgwDm4utYD6C4sbUTUaP5EvfcpMqOBRqhL
         Ei9sGISTihrkBd3hWLAtADBm6kiN1vRHZ3OgqgZtmFqJR3XnyMqiZBKefUHBPbl0kGIh
         u4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701377846; x=1701982646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzmDf72q+PIr46nq4RCKd2VPzq1SXfgspI/h2bERP68=;
        b=Te4eMLZVnyyYiMcLdzIlDq6A3WlXVwsSS69n8Qfvnh7NoXwtCHcke99VIsRWw98Hg9
         nIq4xwLZLMioFKKXMj7B/jF+2INLpNQhSJRnAnj+moI6bchmHXGNRRFUhRyR787CZtvs
         2mbTTp4gHOuQ4g/c2MFL0XkLSovdkT1T7UrwMEJg5IXkyDDp/fTfbMI7cyFrTw/cIMJw
         9WVwSnAWHo/PWfluPZ53gj8I17yLCC4QBsF0frHMw3weDIWsAE2ipQOsv2qIcjRMVBzk
         uzkc1Fqkqktl/hVHT1JYL7/lP+8LypzDn4EPvXcHtFHqSluXS/dUPAQNEN5V7Eemsb2t
         UXXg==
X-Gm-Message-State: AOJu0YyA15VFAHIV+m4ru0OqcF2vCqWfQ+52337ErhPvPudB8oGp2yAH
	mZcY4E2jnSJsOJLigUKPJ1vGhpgOJIrhsNNw188MF/RXc1ryjw==
X-Google-Smtp-Source: AGHT+IFqxL3jbDZE3+iV2R5pR7fvKiNOH6lIlVOMr9vFsJcxBpfnMqq+yOmaoyTW+BaPn/mhUtsM3zHo5GnAOMGAbcs=
X-Received: by 2002:a25:f0a:0:b0:da0:442f:988e with SMTP id
 10-20020a250f0a000000b00da0442f988emr21617223ybp.19.1701377846438; Thu, 30
 Nov 2023 12:57:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130040105.1265779-1-liuhangbin@gmail.com> <20231130040105.1265779-14-liuhangbin@gmail.com>
In-Reply-To: <20231130040105.1265779-14-liuhangbin@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 30 Nov 2023 15:57:15 -0500
Message-ID: <CADvbK_eXR0NkRi+WuZJbzxa6RNU0uPm2bY=-yAS7UkX7MkK45g@mail.gmail.com>
Subject: Re: [PATCHv2 net-next 13/14] selftests/net: convert sctp_vrf.sh to
 run it in unique namespace
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, David Ahern <dsahern@kernel.org>, linux-kselftest@vger.kernel.org, 
	Po-Hsu Lin <po-hsu.lin@canonical.com>, Guillaume Nault <gnault@redhat.com>, 
	Petr Machata <petrm@nvidia.com>, James Prestwood <prestwoj@gmail.com>, 
	Jaehee Park <jhpark1013@gmail.com>, Ido Schimmel <idosch@nvidia.com>, 
	Francesco Ruggeri <fruggeri@arista.com>, Justin Iurman <justin.iurman@uliege.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 11:02=E2=80=AFPM Hangbin Liu <liuhangbin@gmail.com>=
 wrote:
>
> Here is the test result after conversion.
>
> ]# ./sctp_vrf.sh
> Testing For SCTP VRF:
> TEST 01: nobind, connect from client 1, l3mdev_accept=3D1, Y [PASS]
> ...
> TEST 12: bind vrf-2 & 1 in server, connect from client 1 & 2, N [PASS]
> ***v6 Tests Done***
>
> Acked-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  tools/testing/selftests/net/sctp_vrf.sh | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/tools/testing/selftests/net/sctp_vrf.sh b/tools/testing/self=
tests/net/sctp_vrf.sh
> index c721e952e5f3..c854034b6aa1 100755
> --- a/tools/testing/selftests/net/sctp_vrf.sh
> +++ b/tools/testing/selftests/net/sctp_vrf.sh
> @@ -6,13 +6,11 @@
>  #                                                  SERVER_NS
>  #       CLIENT_NS2 (veth1) <---> (veth2) -> vrf_s2
>
> -CLIENT_NS1=3D"client-ns1"
> -CLIENT_NS2=3D"client-ns2"
> +source lib.sh
>  CLIENT_IP4=3D"10.0.0.1"
>  CLIENT_IP6=3D"2000::1"
>  CLIENT_PORT=3D1234
>
> -SERVER_NS=3D"server-ns"
>  SERVER_IP4=3D"10.0.0.2"
>  SERVER_IP6=3D"2000::2"
>  SERVER_PORT=3D1234
> @@ -20,9 +18,7 @@ SERVER_PORT=3D1234
>  setup() {
>         modprobe sctp
>         modprobe sctp_diag
> -       ip netns add $CLIENT_NS1
> -       ip netns add $CLIENT_NS2
> -       ip netns add $SERVER_NS
> +       setup_ns CLIENT_NS1 CLIENT_NS2 SERVER_NS
>
>         ip net exec $CLIENT_NS1 sysctl -w net.ipv6.conf.default.accept_da=
d=3D0 2>&1 >/dev/null
>         ip net exec $CLIENT_NS2 sysctl -w net.ipv6.conf.default.accept_da=
d=3D0 2>&1 >/dev/null
> @@ -67,9 +63,7 @@ setup() {
>
>  cleanup() {
>         ip netns exec $SERVER_NS pkill sctp_hello 2>&1 >/dev/null
> -       ip netns del "$CLIENT_NS1"
> -       ip netns del "$CLIENT_NS2"
> -       ip netns del "$SERVER_NS"
> +       cleanup_ns $CLIENT_NS1 $CLIENT_NS2 $SERVER_NS
>  }
>
>  wait_server() {
> --
> 2.41.0
>
Reviewed-by: Xin Long <lucien.xin@gmail.com>

