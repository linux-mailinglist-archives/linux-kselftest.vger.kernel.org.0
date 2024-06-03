Return-Path: <linux-kselftest+bounces-11129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 539E18D8947
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 21:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2571F2277B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 19:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675D613A256;
	Mon,  3 Jun 2024 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNl7k9Ua"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2871E130AD7
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Jun 2024 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717441374; cv=none; b=DPqi1Orye7QCq3Vz/+/viSqrgVKR/PZ0UH2ZMlQ+/+jmQZJ0iETm1zmp+FnR5oBwZ++kBfez6xIsnVGFgvFq33fU/glpWYHeymJPba/coDu4gDnd8Y3ydZIRlEUkwdPxRRsccpQCGUO2+hZNpusKvW3Gr3XOhhYSOhxG4DBf45I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717441374; c=relaxed/simple;
	bh=o1242Noh5DwPdRlCuDUUZfqQFqyeDP+F6RVt3zLnvi8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gEngBYcGLniPvR9ITjWPDzXZOs/O4vM0QV6W60BbTXiI/lji3Xlu6CyVPt9HMBpyqQpXotwGuAwu/gPpuwddsFBs315BKq/T0txqXLdcixJyoJTfrmvHd6BwBKWLLK1RMQ4/cdLyW/4XF37lQYUsg0TG2XEfWYbUv4p+/WK3OaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DNl7k9Ua; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717441371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TKPs5UyXdPWSkTr2LDWrvXdNXvQrucoVoL0neTHxTus=;
	b=DNl7k9Ua5i2REuCNbejuVUgqh/uVnw/LmvcjkfyDyLW+2Kd6Qa5l+GoTb+LaonD1xcwhKa
	yKhk7U5migcijeGFnwOIKW2mVgsrnUvmGvsXMI83l3HP4MxIo0FziOjYbjUS+TH95FezBV
	OdJ3HVztoQFDGPNwed7H3TXGHqFbLuE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-kKEZ1Yu9PGSd-Q2E547EFw-1; Mon,
 03 Jun 2024 15:02:47 -0400
X-MC-Unique: kKEZ1Yu9PGSd-Q2E547EFw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C1D43C025AD;
	Mon,  3 Jun 2024 19:02:47 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.16.249])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D141C1C0654B;
	Mon,  3 Jun 2024 19:02:46 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  Pravin B Shelar <pshelar@ovn.org>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Shuah Khan
 <shuah@kernel.org>,  dev@openvswitch.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] selftests: openvswitch: set value to nla
 flags
In-Reply-To: <20240603183121.2305013-2-amorenoz@redhat.com> (Adrian Moreno's
	message of "Mon, 3 Jun 2024 20:31:20 +0200")
References: <20240603183121.2305013-1-amorenoz@redhat.com>
	<20240603183121.2305013-2-amorenoz@redhat.com>
Date: Mon, 03 Jun 2024 15:02:46 -0400
Message-ID: <f7t5xup26jt.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Adrian Moreno <amorenoz@redhat.com> writes:

> Netlink flags, although they don't have payload at the netlink level,
> are represented as having a "True" value in pyroute2.
>
> Without it, trying to add a flow with a flag-type action (e.g: pop_vlan)
> fails with the following traceback:
>
> Traceback (most recent call last):
>   File "[...]/ovs-dpctl.py", line 2498, in <module>
>     sys.exit(main(sys.argv))
>              ^^^^^^^^^^^^^^
>   File "[...]/ovs-dpctl.py", line 2487, in main
>     ovsflow.add_flow(rep["dpifindex"], flow)
>   File "[...]/ovs-dpctl.py", line 2136, in add_flow
>     reply = self.nlm_request(
>             ^^^^^^^^^^^^^^^^^
>   File "[...]/pyroute2/netlink/nlsocket.py", line 822, in nlm_request
>     return tuple(self._genlm_request(*argv, **kwarg))
>                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "[...]/pyroute2/netlink/generic/__init__.py", line 126, in
> nlm_request
>     return tuple(super().nlm_request(*argv, **kwarg))
>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "[...]/pyroute2/netlink/nlsocket.py", line 1124, in nlm_request
>     self.put(msg, msg_type, msg_flags, msg_seq=msg_seq)
>   File "[...]/pyroute2/netlink/nlsocket.py", line 389, in put
>     self.sendto_gate(msg, addr)
>   File "[...]/pyroute2/netlink/nlsocket.py", line 1056, in sendto_gate
>     msg.encode()
>   File "[...]/pyroute2/netlink/__init__.py", line 1245, in encode
>     offset = self.encode_nlas(offset)
>              ^^^^^^^^^^^^^^^^^^^^^^^^
>   File "[...]/pyroute2/netlink/__init__.py", line 1560, in encode_nlas
>     nla_instance.setvalue(cell[1])
>   File "[...]/pyroute2/netlink/__init__.py", line 1265, in setvalue
>     nlv.setvalue(nla_tuple[1])
>                  ~~~~~~~~~^^^
> IndexError: list index out of range
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---

Acked-by: Aaron Conole <aconole@redhat.com>

I don't know which pyroute2 version I had used when I tested this
previously, but even on my current system I get this error now.  Thanks
for the fix.

>  tools/testing/selftests/net/openvswitch/ovs-dpctl.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> index b76907ac0092..a2395c3f37a1 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -537,7 +537,7 @@ class ovsactions(nla):
>              for flat_act in parse_flat_map:
>                  if parse_starts_block(actstr, flat_act[0], False):
>                      actstr = actstr[len(flat_act[0]):]
> -                    self["attrs"].append([flat_act[1]])
> +                    self["attrs"].append([flat_act[1], True])
>                      actstr = actstr[strspn(actstr, ", ") :]
>                      parsed = True


