Return-Path: <linux-kselftest+bounces-12158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0599690D81B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 18:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0255C1C242AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 16:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108C44D8A2;
	Tue, 18 Jun 2024 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTtQeW2Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDB946B91
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726693; cv=none; b=ZxNQtFPe1Tzj41yq7FexSBzTV/VxuZwA/xZNATiX1zCpj0j0wYIm2+hDe/36hCIFjkgu1G9HpaSVoRSz9Gl8CHpGY3Kx1U9PhKjODTSAkz2SjOx7gnBJ3oh1DaGr7JCuNaKbexa9WpmrWcRudPRfgNQUlfN8tooGtwpYyLidYKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726693; c=relaxed/simple;
	bh=GP0uR3tvQbzcrtWs6IScgA94dZLZ1PgMYu17zBOgD/E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GbrLPYltg74+E+7zcG240hVC+qPjzwpMg1UHCHbIIqgv8e6fERw0Mvh8VphvXaSWKOMDY17GMDzC6i17XwnNCgt3fR8fW8dwP7vfKY3lUecfM2gVMf1fD4Cnhar+xGwQNZA2pzUAdr68u6RML9k/U1GdN9Nzaz5fxkhUxs+pvaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hTtQeW2Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718726690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EkKajcuHyi0uetV3u4rjxeb0Qgka5tO9IJGy0qxthnw=;
	b=hTtQeW2Y+Y6D4GaJ85881o0i1wKWukBXoSqS1B47RN/CvKT4cdDBTs8V8TJvd0oRaSUDNT
	xQgiS8JGbNd6NP6H3Nau8MZ9pybkcOZrU6SLuBFUuwFVz0G/37izo9t7IE+ZA5CK7MVeoO
	C9t1wHcr/Ah2hieMeYElAdZJwRQKZUo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-gL5KrjedPw-grVOatKz9IQ-1; Tue,
 18 Jun 2024 12:04:42 -0400
X-MC-Unique: gL5KrjedPw-grVOatKz9IQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 701BF19560BF;
	Tue, 18 Jun 2024 16:04:40 +0000 (UTC)
Received: from RHTRH0061144 (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 877C13000218;
	Tue, 18 Jun 2024 16:04:38 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,  Simon Horman <horms@kernel.org>,
  linux-kernel@vger.kernel.org,  Stefano Brivio <sbrivio@redhat.com>,  Eric
 Dumazet <edumazet@google.com>,  linux-kselftest@vger.kernel.org,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Shuah Khan
 <shuah@kernel.org>,  "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next 5/7] selftests: openvswitch: Support
 implicit ipv6 arguments.
In-Reply-To: <20240617180218.1154326-6-aconole@redhat.com> (Aaron Conole's
	message of "Mon, 17 Jun 2024 14:02:16 -0400")
References: <20240617180218.1154326-1-aconole@redhat.com>
	<20240617180218.1154326-6-aconole@redhat.com>
Date: Tue, 18 Jun 2024 12:04:36 -0400
Message-ID: <f7tr0cujkyz.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Aaron Conole <aconole@redhat.com> writes:

> The current iteration of IPv6 support requires explicit fields to be set
> in addition to not properly support the actual IPv6 addresses properly.
> With this change, make it so that the ipv6() bare option is usable to
> create wildcarded flows to match broad swaths of ipv6 traffic.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Aaron Conole <aconole@redhat.com>
> ---
>  .../selftests/net/openvswitch/ovs-dpctl.py    | 42 ++++++++++++-------
>  1 file changed, 27 insertions(+), 15 deletions(-)
>
> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> index 2f16df2fb16b..2062e7e6e99e 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -200,6 +200,18 @@ def convert_ipv4(data):
>  
>      return int(ipaddress.IPv4Address(ip)), int(ipaddress.IPv4Address(mask))
>  
> +def convert_ipv6(data):
> +    ip, _, mask = data.partition('/')
> +
> +    if not ip:
> +        ip = mask = 0
> +    elif not mask:
> +        mask = 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff'
> +    elif mask.isdigit():
> +        mask = ipaddress.IPv6Network("::/" + mask).hostmask
> +
> +    return ipaddress.IPv6Address(ip).packed, ipaddress.IPv6Address(mask).packed
> +
>  def convert_int(size):
>      def convert_int_sized(data):
>          value, _, mask = data.partition('/')
> @@ -941,21 +953,21 @@ class ovskey(nla):
>                  "src",
>                  "src",
>                  lambda x: str(ipaddress.IPv6Address(x)),
> -                lambda x: int.from_bytes(x, "big"),
> -                lambda x: ipaddress.IPv6Address(x),
> +                lambda x: ipaddress.IPv6Address(x).packed if x else 0,
> +                convert_ipv6,
>              ),
>              (
>                  "dst",
>                  "dst",
>                  lambda x: str(ipaddress.IPv6Address(x)),
> -                lambda x: int.from_bytes(x, "big"),
> -                lambda x: ipaddress.IPv6Address(x),
> +                lambda x: ipaddress.IPv6Address(x).packed if x else 0,
> +                convert_ipv6,
>              ),
> -            ("label", "label", "%d", int),
> -            ("proto", "proto", "%d", int),
> -            ("tclass", "tclass", "%d", int),
> -            ("hlimit", "hlimit", "%d", int),
> -            ("frag", "frag", "%d", int),
> +            ("label", "label", "%d", lambda x: int(x) if x else 0),
> +            ("proto", "proto", "%d", lambda x: int(x) if x else 0),
> +            ("tclass", "tclass", "%d", lambda x: int(x) if x else 0),
> +            ("hlimit", "hlimit", "%d", lambda x: int(x) if x else 0),
> +            ("frag", "frag", "%d", lambda x: int(x) if x else 0),
>          )
>  
>          def __init__(
> @@ -1152,8 +1164,8 @@ class ovskey(nla):
>              (
>                  "target",
>                  "target",
> -                lambda x: str(ipaddress.IPv6Address(x)),
> -                lambda x: int.from_bytes(x, "big"),
> +                lambda x: ipaddress.IPv6Address(x).packed,

This (and the following str() calls) shouldn't have been changed.  I'll
send a v2.  Sorry about the noise.  It isn't visible in this test, but
when doing some additional ipv6 test development for a future series, I
caught it.

> +                convert_ipv6,
>              ),
>              ("sll", "sll", macstr, lambda x: int.from_bytes(x, "big")),
>              ("tll", "tll", macstr, lambda x: int.from_bytes(x, "big")),
> @@ -1237,14 +1249,14 @@ class ovskey(nla):
>              (
>                  "src",
>                  "src",
> -                lambda x: str(ipaddress.IPv6Address(x)),
> -                lambda x: int.from_bytes(x, "big", convertmac),
> +                lambda x: ipaddress.IPv6Address(x).packed,
> +                convert_ipv6,
>              ),
>              (
>                  "dst",
>                  "dst",
> -                lambda x: str(ipaddress.IPv6Address(x)),
> -                lambda x: int.from_bytes(x, "big"),
> +                lambda x: ipaddress.IPv6Address(x).packed,
> +                convert_ipv6,
>              ),
>              ("tp_src", "tp_src", "%d", int),
>              ("tp_dst", "tp_dst", "%d", int),


