Return-Path: <linux-kselftest+bounces-3562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4D183C11C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 12:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4411F249BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 11:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7D233CCD;
	Thu, 25 Jan 2024 11:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aRPsuEp/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EEB2CCBA
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182714; cv=none; b=JIVE7gsEnyzgcWyOs1QklKyNOO41vZtAIO30iIzXAoX+eQkl/mj9UO2Yz/hMVhPY3kX1qFTPK7yq2psYxzqU5LUqmKnYPBTLukWyQFw3U0OzRnT8E8kghv7tlx7mA28zXqIQQ/s5uudznM+eLsQJbvESDbpTJdLl1oYVWR9fTaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182714; c=relaxed/simple;
	bh=drA+12YZq+Mq5k6GI7zl2FZfOMAsg0hH/VF9nCe4F6g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VYE97PDiwq8/qQIlF1txBm/A/QmILPu7VDWaCz2qUovELKeAWXJziSBgccKHGuXlfdjqX9RUEdDUm7yhMTH+CRKWZcySVr1iCk+6DIiYrTi52vSXfxWGkmUkzYCYXmQhsvowW+9s4WR1EFPwhlUceczqOjXJ8a/mJ82CpikHf5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aRPsuEp/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706182711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FlztVln5G2ZA6SW7QM94JaPv1tWGirGxChPs5cJk/fY=;
	b=aRPsuEp/ISV1csfFXj2c1ivG+3pNA7XtqvaTeuLiNdq1ZV1EeifyDRHaR62G1twy0zJ4Zb
	n4EiLlaw/gwo+jC3TBO6UWw9IBVGE0fWU6qifshGNgflzUQljDYrRu8SA6+y7WGYHpXNGk
	hpLwD6diYlMc+5Zw2eu1f4oOsT+QzEU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-kuNa-c4dMNOYQHhoPJ5w7w-1; Thu, 25 Jan 2024 06:38:29 -0500
X-MC-Unique: kuNa-c4dMNOYQHhoPJ5w7w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e476c518eso14248555e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 03:38:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706182709; x=1706787509;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FlztVln5G2ZA6SW7QM94JaPv1tWGirGxChPs5cJk/fY=;
        b=firklXthZmIfQkx9xe59Mgxlb44nBvPQOkTmAiurV9h4WmQB8SJJxBHK7oqoVXNP6Y
         BVkQz54CSV77vnFvD0IRi9e4uJo2Cht9N1689ciOnO8j32yeDfRJ23aaNlsudrSVFYbP
         p63T81Pcfc9UnCtkQKyF45187j3LvAEnuCeqE77g5RQTXasDLVOG2ys+Y2zAaNph/W/8
         ESEDzeEegUAIRdYnt3+jbZYM/w0p8FyG6NBumbSwMb3gubxDFKmWUvlFofKjLuJivJ7v
         Hj/2yFZT3pAbVcoEQnAar0FBlMRgAyNnijRiPtyVwdcPIFcA3SFZUi9IfYGu546X+hWJ
         l31Q==
X-Gm-Message-State: AOJu0YwlRijXMnQAhRgaBVl6KBJcXXzZ1p3173YrYUyhCXYg4IY5wEam
	onw2A/+NUVmVkkjG542vDhjFi7+5Rqh3kfvk3F2/QIhJVatA1ALoiyYeAhjuNHh6P+BzRebQtFj
	B4IkIcClUJ0hbFXnX+qhiWXIJ2RJPYyly5X3NIIe0Q7f115ydUkOh0vieM4yIkGVhpQ==
X-Received: by 2002:a05:600c:3b24:b0:40e:8e43:4995 with SMTP id m36-20020a05600c3b2400b0040e8e434995mr1007104wms.0.1706182708745;
        Thu, 25 Jan 2024 03:38:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKN6At1vwCXC1PPYJPkSEfsNDLNk+lchULgOmczO3Z3bmzgp6eXnNNa1dWFzhWrG0jTw+gEw==
X-Received: by 2002:a05:600c:3b24:b0:40e:8e43:4995 with SMTP id m36-20020a05600c3b2400b0040e8e434995mr1007089wms.0.1706182708366;
        Thu, 25 Jan 2024 03:38:28 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-244-75.dyn.eolo.it. [146.241.244.75])
        by smtp.gmail.com with ESMTPSA id v3-20020a05600c444300b0040ebfbff33csm2311266wmn.36.2024.01.25.03.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 03:38:27 -0800 (PST)
Message-ID: <ecf42dd37e90fec22edd16f64b55189a24147b21.camel@redhat.com>
Subject: Re: [PATCH net] selftests: net: add missing required classifier
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, Maciej
 enczykowski <maze@google.com>,  Lina Wang <lina.wang@mediatek.com>,
 linux-kselftest@vger.kernel.org
Date: Thu, 25 Jan 2024 12:38:26 +0100
In-Reply-To: <CANn89iKqShowy=xMi2KwthYB6gz9X5n9kcqwh_5-JBJ3-jnK+g@mail.gmail.com>
References: 
	<7c3643763b331e9a400e1874fe089193c99a1c3f.1706170897.git.pabeni@redhat.com>
	 <CANn89iKqShowy=xMi2KwthYB6gz9X5n9kcqwh_5-JBJ3-jnK+g@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-25 at 09:48 +0100, Eric Dumazet wrote:
> On Thu, Jan 25, 2024 at 9:23=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >=20
> > the udpgro_fraglist self-test uses the BPF classifiers, but the
> > current net self-test configuration does not include it, causing
> > CI failures:
> >=20
> >  # selftests: net: udpgro_frglist.sh
> >  # ipv6
> >  # tcp - over veth touching data
> >  # -l 4 -6 -D 2001:db8::1 -t rx -4 -t
> >  # Error: TC classifier not found.
> >  # We have an error talking to the kernel
> >  # Error: TC classifier not found.
> >  # We have an error talking to the kernel
> >=20
> > Add the missing knob.
> >=20
> > Fixes: edae34a3ed92 ("selftests net: add UDP GRO fraglist + bpf self-te=
sts")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>=20
> FYI, while looking at the gro test, I found that using strace was
> making it failing as well.

It looks like the gro.sh (large) tests send the to-be-aggregate
segments individually and relay on the gro flush timeout being large
enough to fit all the relevant write operations. I suspect/hope
something alike:

---
diff --git a/tools/testing/selftests/net/setup_veth.sh b/tools/testing/self=
tests/net/setup_veth.sh
index a9a1759e035c..1f78a87f6f37 100644
--- a/tools/testing/selftests/net/setup_veth.sh
+++ b/tools/testing/selftests/net/setup_veth.sh
@@ -11,7 +11,7 @@ setup_veth_ns() {
        local -r ns_mac=3D"$4"
=20
        [[ -e /var/run/netns/"${ns_name}" ]] || ip netns add "${ns_name}"
-       echo 100000 > "/sys/class/net/${ns_dev}/gro_flush_timeout"
+       echo 1000000 > "/sys/class/net/${ns_dev}/gro_flush_timeout"
        ip link set dev "${ns_dev}" netns "${ns_name}" mtu 65535
        ip -netns "${ns_name}" link set dev "${ns_dev}" up
---=20
should solve the sporadic issues.

> Not sure about this one...

All the udpgro* test should write a single UDP GSO packet and let the
veth segmenting it, hopefully slowing down either ends should not
impact them - but I did not check yet!

Perhaps even the gro.sh tests could be modified alike?

Cheers,

Paolo


