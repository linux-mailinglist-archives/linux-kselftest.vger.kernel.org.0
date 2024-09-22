Return-Path: <linux-kselftest+bounces-18200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9980F97E274
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Sep 2024 18:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D88992812BF
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Sep 2024 16:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AECF1C695;
	Sun, 22 Sep 2024 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFyb9MGT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE95ABA2E;
	Sun, 22 Sep 2024 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727022214; cv=none; b=e2pmoAcJ6Jg0XhkOgnhFJu2oCD4H54nSyCA45CaQTL5NxJhgoHcTLCyUmjiiP+VC3d8m4VvsYlkPv5vcz4N7AFd7NwmCiMJZ0w+T780ytyPYpTm+6hpAFKzLXLhYSYqkf8TzP09QG8/tvBBSvMDjqpYfemDwpeOjUVGe+dmXnYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727022214; c=relaxed/simple;
	bh=dgbk0GepYMfUAgep3wFQBc6FfyQBzJrgxVP1kPHTNks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AtQ14gCjziQr9+D3769c11hb5izrYtcgzbX3JxIgqvkgLW8NaJ2dDt1IVfAltAy4VMVURFy7YKpNYf0QA524+gmIvJClpArvAIeykTNc8knZvk1s/NGi8nzaGZq4Q3E0qLChJQeo+TgrGjosOOifE52S5j5hWaPILcBPuB16nxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFyb9MGT; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e1a819488e3so2777366276.3;
        Sun, 22 Sep 2024 09:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727022211; x=1727627011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEHQZ7aV2v97Y8TR3PMXm+WQO/EG3K5hYw1BGfIK/c4=;
        b=PFyb9MGTGQCVlFSmFzEDKsVu7QugHHEql6MGbr9FHZsWgT7AGW9AzUxcydY2H3JTz0
         T7y9RG7Ly/7cp8LN3e9LxKyH3FCVOHtoftcssiYBeKEDRH7yWb74TPUtelZQ16mqi+yx
         rXOVwuXmyklDL2vJkyi3w5PFcfwnkuvEhQmc4vHhpm7NUS7IOgCRqLIVgy1MOg8WurWC
         jskL4Z4hkn3vxrvcARWP/GtA4LTLr05295cPBE3J0Ia4G+YFibSCm0QGaPT72JoWbOsB
         6j0x2Mmdn2w203Lds0LsxqBZZJ4fZFUf8ciiPocJk/6lKsBrLK4WGTXB7tcBVP5mT5Sm
         XjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727022211; x=1727627011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEHQZ7aV2v97Y8TR3PMXm+WQO/EG3K5hYw1BGfIK/c4=;
        b=UQE8fum0RcGQ/O2+M9quIRoIRy0+NQjaPRoexO/MTkQdSX5f8xIT3ncub1KzK4YFvJ
         t/UannrelNYQ+CPhDMlvxbqzZnnaSSqICNKECtsQi+v+QZsH4NhgEhWqGV75Zet9YnnP
         zCvlqkfDoI7kshdVPYnn+3R8NsATEOxJPDPQNV2Mas/2JY3fD5toOFoRRKRvxShvxVRo
         hceKH/Bug6FGoiSUMD8bU9B3RGf8BvrgIb+rx6C4nsx2f8yMNWnDwpkv3Ec6jXMlihY+
         QyG8NGtdm6QsVTVFJE2K+WhfJciVtIA6qv1gFLIyh60BpbtjRdQzxjwN50EzZJpfeW8x
         17/A==
X-Forwarded-Encrypted: i=1; AJvYcCVi3sKTSk6FMlDc1eUG34OOO5r8uYLln24vy8E1iXrDZRY6SZKUnmEexwFVCeXslFCv4jrlB2foC6pG46z2VQEn@vger.kernel.org, AJvYcCVjg9iRK7g3wbX2TyAxX80bI549omt7JkPYcv3irGjVyGBp3JWkdVTjib5gLf5u6YG/Vrhk2pjzqAzpQcQq@vger.kernel.org, AJvYcCW2UKJxY4W/Dj35v8wFfCoJNyeWC1fgaSfBTd/k6T3O8W/KGUOkOTDCakI6bVNLRFG2KW4WMKmV@vger.kernel.org, AJvYcCWYXpaTClPBpycVFLzVpnnhwfku3/7dvqhqU5jBa4mELJWz4yPYQMrocGaNWS0AXvTYdKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymI5l2EsgISGdjAdU/4ikDK58b038RXTenoiTDze/IO2TbyrQs
	n41XlVfMyVRktSVgjIQ19NrQMz+SNN81PcJHqmY+GCJOmJ2NnqWFf1uakIFYEfLvvl+X2+PP72H
	Z3zmmYu+qJk/evLKVHHVCQBlCj50=
X-Google-Smtp-Source: AGHT+IF0UyOWjybQXZgWQIKE9WssLRn86JYKnQHBctQJAEy/AvR8IQWn2xGNT5sKqRgFleUnd1kKm56erKflXFLSF9k=
X-Received: by 2002:a05:6902:2609:b0:e1d:1746:52da with SMTP id
 3f1490d57ef6-e2252f34709mr5427596276.21.1727022210713; Sun, 22 Sep 2024
 09:23:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920-reverse-sk-lookup-v2-0-916a48c47d56@cloudflare.com> <20240920-reverse-sk-lookup-v2-1-916a48c47d56@cloudflare.com>
In-Reply-To: <20240920-reverse-sk-lookup-v2-1-916a48c47d56@cloudflare.com>
From: ericnetdev dumazet <erdnetdev@gmail.com>
Date: Sun, 22 Sep 2024 18:23:19 +0200
Message-ID: <CAHTyZGwm4pHZg1eSdF6bbk7_WcJ4k25YzWtRKbfWNC_e6gUNVQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] ipv4: Support setting src port in sendmsg().
To: Tiago Lam <tiagolam@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 20 sept. 2024 =C3=A0 19:03, Tiago Lam <tiagolam@cloudflare.com> a =
=C3=A9crit :
>
> sendmsg() doesn't currently allow users to set the src port from which
> egress traffic should be sent from. This is possible if a user wants to
> configure the src address from which egress traffic should be sent from
> - with the IP_PKTINFO ancillary message, a user is currently able to
>   specify a source address to egress from when calling sendmsg().
> However, this still requires the user to set the IP_TRANSPARENT flag
> using setsockopt(), which happens to require special privileges in the
> case of IPv4.
>
> To support users setting the src port for egress traffic when using
> sendmsg(), this patch extends the ancillary messages supported by
> sendmsg() to support the IP_ORIGDSTADDR ancillary message, reusing the
> same cmsg and struct used in recvmsg() - which already supports
> specifying a port.
>
> Additionally, to avoid having to have special configurations, such as
> IP_TRANSPARENT, this patch allows egress traffic that's been configured
> using (the newly added) IP_ORIGDSTADDR to proceed if there's an ingress
> socket lookup (sk_lookup) that matches that traffic - by performing a
> reserve sk_lookup. Thus, if the sk_lookup reverse call returns a socket
> that matches the egress socket, we also let the egress traffic through -
> following the principle of, allowing return traffic to proceed if
> ingress traffic is allowed in. In case no match is found in the reverse
> sk_lookup, traffic falls back to the regular egress path.
>
> This reverse lookup is only performed in case an sk_lookup ebpf program
> is attached and the source address and/or port for the return traffic
> have been modified using the (newly added) IP_ORIGDSTADDR in sendmsg.

Is it compatible with SO_REUSEPORT ?

Most heavy duty UDP servers use SO_REUSEPORT to spread incoming
packets to multiple sockets.

How is the reverse lookup going to choose the 'right' socket ?

