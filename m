Return-Path: <linux-kselftest+bounces-11963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C49908F71
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 17:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEF84B237C4
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 15:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411D416B720;
	Fri, 14 Jun 2024 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Goj4LckA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5244EB55
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718380464; cv=none; b=tb426WHTNdfcKq1dLrn9Mnmvd7oocEzQk+fESxhTYfTJuDGnaKCcA6QXKWvMm8REoWTHuoIkCqAKOgsuKuwE5cM/FGbb1XsD72sWV2i5oJaboz10CoYDLnRKjJhKAjOM7niF6fA9YzXDk+O5fhKrPivfMpNBWcqLlDDns66Lrwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718380464; c=relaxed/simple;
	bh=re2luL8iC9nwDSyqmpDwVK+KGaKcJDoncjJcQqFPp2I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fa4LvPdSHSZR1VRaQ2j0nAUWFu0Fguzgj87PJTFwflnKYPvilrQpo0/g59sLrxuG3C2mZpL4jqcjQnMq4Y03WpvyjVl4AT4j5TvK9C+hOi09tPEow/dD4iMjCeVLQUcE5umM+XvbOD5AY9vACAi1CDptl28zfLKfkjcFe+KmRy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Goj4LckA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718380461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXSISRWdLPH55gILPs1QDZPjGYmbQZf+3emJmLMYoF0=;
	b=Goj4LckAkAqfVUn6ZogzkgXHISRPKTtBzDpDwPS16rH7/NmXyAMuTxWTVglgQs4Snp2PJQ
	vx1Iofaahgwg5ow9a1pyRrLaK/krEamQZm3hjaRsLznR8KCg8gyAQR82R0UCC3aX69M//r
	2XHsiJINPC8xGuu+dAQGbh2IyPkiJiU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-03G28qcNMiCIIHnS0WSTbg-1; Fri,
 14 Jun 2024 11:54:18 -0400
X-MC-Unique: 03G28qcNMiCIIHnS0WSTbg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E598119560B9;
	Fri, 14 Jun 2024 15:54:16 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.16.41])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D35CA19560BF;
	Fri, 14 Jun 2024 15:54:13 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: =?utf-8?Q?Adri=C3=A1n?= Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  Pravin B Shelar <pshelar@ovn.org>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Shuah Khan
 <shuah@kernel.org>,  dev@openvswitch.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] selftests: openvswitch: set value to nla
 flags
In-Reply-To: <CAG=2xmN+fp5B_b1KQq2T9DKrTQ_+Kqr6WbmrY0Gk1j3zZnY1YA@mail.gmail.com>
	(=?utf-8?Q?=22Adri=C3=A1n?= Moreno"'s message of "Tue, 11 Jun 2024 15:03:45
 +0000")
References: <20240603183121.2305013-1-amorenoz@redhat.com>
	<20240603183121.2305013-2-amorenoz@redhat.com>
	<f7t5xup26jt.fsf@redhat.com>
	<CAG=2xmN+fp5B_b1KQq2T9DKrTQ_+Kqr6WbmrY0Gk1j3zZnY1YA@mail.gmail.com>
Date: Fri, 14 Jun 2024 11:54:11 -0400
Message-ID: <f7t7cerpljw.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Adri=C3=A1n Moreno <amorenoz@redhat.com> writes:

> On Mon, Jun 03, 2024 at 03:02:46PM GMT, Aaron Conole wrote:
>> Adrian Moreno <amorenoz@redhat.com> writes:
>>
>> > Netlink flags, although they don't have payload at the netlink level,
>> > are represented as having a "True" value in pyroute2.
>> >
>> > Without it, trying to add a flow with a flag-type action (e.g: pop_vla=
n)
>> > fails with the following traceback:
>> >
>> > Traceback (most recent call last):
>> >   File "[...]/ovs-dpctl.py", line 2498, in <module>
>> >     sys.exit(main(sys.argv))
>> >              ^^^^^^^^^^^^^^
>> >   File "[...]/ovs-dpctl.py", line 2487, in main
>> >     ovsflow.add_flow(rep["dpifindex"], flow)
>> >   File "[...]/ovs-dpctl.py", line 2136, in add_flow
>> >     reply =3D self.nlm_request(
>> >             ^^^^^^^^^^^^^^^^^
>> >   File "[...]/pyroute2/netlink/nlsocket.py", line 822, in nlm_request
>> >     return tuple(self._genlm_request(*argv, **kwarg))
>> >                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> >   File "[...]/pyroute2/netlink/generic/__init__.py", line 126, in
>> > nlm_request
>> >     return tuple(super().nlm_request(*argv, **kwarg))
>> >            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> >   File "[...]/pyroute2/netlink/nlsocket.py", line 1124, in nlm_request
>> >     self.put(msg, msg_type, msg_flags, msg_seq=3Dmsg_seq)
>> >   File "[...]/pyroute2/netlink/nlsocket.py", line 389, in put
>> >     self.sendto_gate(msg, addr)
>> >   File "[...]/pyroute2/netlink/nlsocket.py", line 1056, in sendto_gate
>> >     msg.encode()
>> >   File "[...]/pyroute2/netlink/__init__.py", line 1245, in encode
>> >     offset =3D self.encode_nlas(offset)
>> >              ^^^^^^^^^^^^^^^^^^^^^^^^
>> >   File "[...]/pyroute2/netlink/__init__.py", line 1560, in encode_nlas
>> >     nla_instance.setvalue(cell[1])
>> >   File "[...]/pyroute2/netlink/__init__.py", line 1265, in setvalue
>> >     nlv.setvalue(nla_tuple[1])
>> >                  ~~~~~~~~~^^^
>> > IndexError: list index out of range
>> >
>> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>> > ---
>>
>> Acked-by: Aaron Conole <aconole@redhat.com>
>>
>> I don't know which pyroute2 version I had used when I tested this
>> previously, but even on my current system I get this error now.  Thanks
>> for the fix.
>>
>
> Thanks Aaron. I'll resend as v2 with your ack as a stand-alone patch
> since the other patch of this series will be fixed by your soon-to-come
> series.

Thanks!

>> >  tools/testing/selftests/net/openvswitch/ovs-dpctl.py | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/to=
ols/testing/selftests/net/openvswitch/ovs-dpctl.py
>> > index b76907ac0092..a2395c3f37a1 100644
>> > --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> > +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
>> > @@ -537,7 +537,7 @@ class ovsactions(nla):
>> >              for flat_act in parse_flat_map:
>> >                  if parse_starts_block(actstr, flat_act[0], False):
>> >                      actstr =3D actstr[len(flat_act[0]):]
>> > -                    self["attrs"].append([flat_act[1]])
>> > +                    self["attrs"].append([flat_act[1], True])
>> >                      actstr =3D actstr[strspn(actstr, ", ") :]
>> >                      parsed =3D True
>>


