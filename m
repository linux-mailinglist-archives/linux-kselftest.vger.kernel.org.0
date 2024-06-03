Return-Path: <linux-kselftest+bounces-11128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742FF8D8937
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 21:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD94287B9B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 19:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D4D130492;
	Mon,  3 Jun 2024 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Na5chPc0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD0A1369A5
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Jun 2024 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717441217; cv=none; b=I8c8ZQK+MTnO6vX4DszpAERNEY9Mz+XcTIjebKGXtcgwWWH7ie3jqaMSAtkRRhUfTLbVXIToiG1RDo2bj66Bh6EfzP8JLLzxJ9toI6OvVlEb4k2WvOnlsi9HeKmV4H9tRevaqU6Sp66v/BDNNzV6JIZb/zohwHwjn+AMH5aLrdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717441217; c=relaxed/simple;
	bh=AwMHxY3k75m7h3r41XCGVG8OXkNNH18sWo3dk32O0n8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eWn0mVTd6WbDJIRSOOptoN9I/OnuZZZOldUGoVbaIw+kb/PRqshu6Ntxiyg/Se/MQ7ENmKstLANxAqt9wIHtHjCNHPXhQ7pLrl3Pk/WMy5fdQB+YEDePwnw2Cec2+6fSeXC0fDJQXW2YLTR7TbcQBdL1ixH0GIGRskQ0jO7TrV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Na5chPc0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717441210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ChfCqFN0nqpXyobaCbZBOpsrLFEiiX0rTZd/s7etRxo=;
	b=Na5chPc0EIA2wqMZm7QIfsdi2RhNl4E+zPZ/Xz5EuRODB4nr59+jD96MuCHL2uRd3hRYOe
	/irjAAK3W+4IejA+SE7tcHzCZeTzhPPagx8deJlQ8GMTzk+V3WqeywsfN6Mv32d645eBVC
	i4f2/lDiWt1D/U84KEymnmasN9StCbU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-8md3RB_4ORq9sC23YHIvsA-1; Mon,
 03 Jun 2024 15:00:06 -0400
X-MC-Unique: 8md3RB_4ORq9sC23YHIvsA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5B663C025B5;
	Mon,  3 Jun 2024 19:00:04 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.16.249])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A4EFC15C0C;
	Mon,  3 Jun 2024 19:00:03 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  Pravin B Shelar <pshelar@ovn.org>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Shuah Khan
 <shuah@kernel.org>,  dev@openvswitch.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org, Simon
 Horman <horms@verge.net.au>
Subject: Re: [PATCH net-next 1/2] selftests: openvswitch: fix action formatting
In-Reply-To: <20240603183121.2305013-1-amorenoz@redhat.com> (Adrian Moreno's
	message of "Mon, 3 Jun 2024 20:31:19 +0200")
References: <20240603183121.2305013-1-amorenoz@redhat.com>
Date: Mon, 03 Jun 2024 15:00:03 -0400
Message-ID: <f7ta5k126oc.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Adrian Moreno <amorenoz@redhat.com> writes:

> In the action formatting function ("dpstr"), the iteration is made over
> the nla_map, so if there are more than one attribute from the same type
> we only print the first one.
>
> Fix this by iterating over the actual attributes.
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---
>  .../selftests/net/openvswitch/ovs-dpctl.py    | 48 +++++++++++--------
>  1 file changed, 27 insertions(+), 21 deletions(-)
>
> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> index 1dd057afd3fb..b76907ac0092 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -437,40 +437,46 @@ class ovsactions(nla):
>      def dpstr(self, more=False):
>          print_str = ""
>  
> -        for field in self.nla_map:
> -            if field[1] == "none" or self.get_attr(field[0]) is None:
> +        for attr_name, value in self["attrs"]:
> +            attr_desc = next(filter(lambda x: x[0] == attr_name, self.nla_map),
> +                             None)
> +            if not attr_desc:
> +                raise ValueError("Unknown attribute: %s" % attr)
> +
> +            attr_type = attr_desc[1]
> +
> +            if attr_type == "none":

I agree, this is an issue.  BUT I think it might be better to just
filter by field type up front.  See:

https://github.com/apconole/linux-next-work/commit/7262107de7170d44b6dbf6c5ea6f7e6c0bb71d36#diff-3e72e7405c6bb4e9842bed5f63883ca930387086bb40d4034e92ed83a5decb4bR441

That version I think ends up being much easier to follow.  If you want
to take it for your series, feel free.  If you disagree, maybe there's
something I'm not considering about it.

NOTE that version is just a bunch of independent changes that are
squashed together.  I have a cleaner version.

I can also bundle up the series I have so far and submit, but I didn't
want to do that until I got all the pmtu.sh support working.  Maybe it
makes sense to send it now though.  Simon, Jakub - wdyt?

>                  continue
>              if print_str != "":
>                  print_str += ","
>  
> -            if field[1] == "uint32":
> -                if field[0] == "OVS_ACTION_ATTR_OUTPUT":
> -                    print_str += "%d" % int(self.get_attr(field[0]))
> -                elif field[0] == "OVS_ACTION_ATTR_RECIRC":
> -                    print_str += "recirc(0x%x)" % int(self.get_attr(field[0]))
> -                elif field[0] == "OVS_ACTION_ATTR_TRUNC":
> -                    print_str += "trunc(%d)" % int(self.get_attr(field[0]))
> -                elif field[0] == "OVS_ACTION_ATTR_DROP":
> -                    print_str += "drop(%d)" % int(self.get_attr(field[0]))
> -            elif field[1] == "flag":
> -                if field[0] == "OVS_ACTION_ATTR_CT_CLEAR":
> +            if attr_type == "uint32":
> +                if attr_name == "OVS_ACTION_ATTR_OUTPUT":
> +                    print_str += "%d" % int(value)
> +                elif attr_name == "OVS_ACTION_ATTR_RECIRC":
> +                    print_str += "recirc(0x%x)" % int(value)
> +                elif attr_name == "OVS_ACTION_ATTR_TRUNC":
> +                    print_str += "trunc(%d)" % int(value)
> +                elif attr_name == "OVS_ACTION_ATTR_DROP":
> +                    print_str += "drop(%d)" % int(value)
> +            elif attr_type == "flag":
> +                if attr_name == "OVS_ACTION_ATTR_CT_CLEAR":
>                      print_str += "ct_clear"
> -                elif field[0] == "OVS_ACTION_ATTR_POP_VLAN":
> +                elif attr_name == "OVS_ACTION_ATTR_POP_VLAN":
>                      print_str += "pop_vlan"
> -                elif field[0] == "OVS_ACTION_ATTR_POP_ETH":
> +                elif attr_name == "OVS_ACTION_ATTR_POP_ETH":
>                      print_str += "pop_eth"
> -                elif field[0] == "OVS_ACTION_ATTR_POP_NSH":
> +                elif attr_name == "OVS_ACTION_ATTR_POP_NSH":
>                      print_str += "pop_nsh"
> -                elif field[0] == "OVS_ACTION_ATTR_POP_MPLS":
> +                elif attr_name == "OVS_ACTION_ATTR_POP_MPLS":
>                      print_str += "pop_mpls"
>              else:
> -                datum = self.get_attr(field[0])
> -                if field[0] == "OVS_ACTION_ATTR_CLONE":
> +                if attr_name == "OVS_ACTION_ATTR_CLONE":
>                      print_str += "clone("
> -                    print_str += datum.dpstr(more)
> +                    print_str += value.dpstr(more)
>                      print_str += ")"
>                  else:
> -                    print_str += datum.dpstr(more)
> +                    print_str += value.dpstr(more)
>  
>          return print_str


