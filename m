Return-Path: <linux-kselftest+bounces-12046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A8590ADCD
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 14:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172172851F9
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 12:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36981953A7;
	Mon, 17 Jun 2024 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/wW7sfA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084FA2F32
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 12:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718626731; cv=none; b=KjW93sWxfJuymbyPzMGpdc70qzow4mkER/dwnnrZd1DnoLBIvJfIqhVMrJlD7cbGPqEftO4PHLvfZ+T/nFefeRMrxXPaA9MRpX6xINk07dYfiBcJjLLgqJ4PdBgqMPqovo+eX4KhGCa1DOJUxiu4ug2e7OpXzuix7GCMU76qWbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718626731; c=relaxed/simple;
	bh=KvunzI4WddNbzqx07uzoYcKYuD+zv2l3SfAVCfDgcos=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3o9HUIKje5r9AbGN9e/O2sMuQKP9lrBeFj/Aig7IzbpuS7TO6/QhQrzNj79UTRRVRmmG0wfJ3nfdh9rg0aHb7El7J/aMm9fiZS2DpZnmTX1s9RRQBcQ83mmUpz2HLN1L92LjHo/c1fbXrcazZKIbAXtjza7rARcDctoJaxm+cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J/wW7sfA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718626727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tunX5zHKdUC3AI9UXbpm7ZTTyILRGRESycSxcecMcRU=;
	b=J/wW7sfATPIByg5PHH65D3rWmuQ0jyIpNHD75jtQDTJ6OkhhaxLG+JCA5Wae+CH7QCBVKG
	zSb1JRhd/Eqd/a+l7uSjgCIgW7siTyYCh2qfhLt1v8z65BdTg3vJJYCbqDmFxIkGMjmxU8
	+ax82n1h+9DAUKu72QTuqwfjyDW8F+w=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-ApmTZtzrNb21oEEGRIriUw-1; Mon, 17 Jun 2024 08:18:46 -0400
X-MC-Unique: ApmTZtzrNb21oEEGRIriUw-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6f9393f5bebso4713544a34.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 05:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718626726; x=1719231526;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tunX5zHKdUC3AI9UXbpm7ZTTyILRGRESycSxcecMcRU=;
        b=T56SJbfZygnk5zAqcUihIiShz5CHPJ1tqsIvKKbs549Dl3PnVjGDh0BP0DRXltnFjo
         mkKIrnUDQU+f/bb2WEukCFSrG6Rv4xBKVY8ucxUMnRjCFtStM4sxyZSdiClEl75/huFr
         Ubc6XvMkP0/OSdWrtCunli258OEwRSeKAKp1ahGQ03fETGptB1kXNv2lcUsK20f9mi78
         S9bQ1cMy4RCjyai9WWqneHoF6uv3nww/fJBeyMO6RFKx/k5oPI4LCl0b++kcTOtyjlxz
         CDkkjX32/ijB/WJyQPU+56XXDR8CBzwz9V9MJ0pGhyOLmGHHZgcHF3UkLVL4A60IDoJR
         5kjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ4A3lDxOwtTbZ9R7wW0To3q5k0AdvPJBb4bLNE20DHAwhvq5cIPu+Gbkg2Mag4ESuAw1ZmLMSLjxQLccCWzp0X1hxZbLgJJbcO2F4i1m9
X-Gm-Message-State: AOJu0Yz7a8yEmlooqSfX+3/8df9+9/EhoCdua4lhZd3ZJF2PfrVWPrNQ
	dwt3QjzU2Dequ6fMOrk1wfdo8463XZzDUFLzi2BZCivFQ8Vw+3T/925bJXPQOAEA3HP0cBTiXI3
	XEUJ2YQEb+0YiG+ZgCTCS/tNNewzawTXcG/WtsrLoTLtaFccr6dJWNBVAe9aJBq7bojbQLMmuWD
	nePLyTxkE6rRcW6GojpWlDpxrGEeCPzUkJmhyQntgj
X-Received: by 2002:a05:6830:ed3:b0:6f9:5973:f8a9 with SMTP id 46e09a7af769-6fb9350becfmr9976819a34.15.1718626726045;
        Mon, 17 Jun 2024 05:18:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8X+Za17I50Yv6y0RBTKSevi/gJ0mG8u7aZJi4dWAzQeI1Az78m6u18o0HaIn0rByznMj0/F6LcjBvczbAIRs=
X-Received: by 2002:a05:6830:ed3:b0:6f9:5973:f8a9 with SMTP id
 46e09a7af769-6fb9350becfmr9976804a34.15.1718626725697; Mon, 17 Jun 2024
 05:18:45 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 17 Jun 2024 12:18:44 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240613181333.984810-1-aconole@redhat.com> <20240613181333.984810-4-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240613181333.984810-4-aconole@redhat.com>
Date: Mon, 17 Jun 2024 12:18:44 +0000
Message-ID: <CAG=2xmM_z28JA1hm_PxATrUxB96miqpVRT4-WO+MHfFeaYZwPg@mail.gmail.com>
Subject: Re: [RFC net-next 3/7] selftests: openvswitch: Add set() and
 set_masked() support.
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pravin B Shelar <pshelar@ovn.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, Jun 13, 2024 at 02:13:29PM GMT, Aaron Conole wrote:
> These will be used in upcoming commits to set specific attributes for
> interacting with tunnels.  Since set() will use the key parsing routine, we
> also make sure to prepend it with an open paren, for the action parsing to
> properly understand it.
>
> Signed-off-by: Aaron Conole <aconole@redhat.com>
> ---
>  .../selftests/net/openvswitch/ovs-dpctl.py    | 39 +++++++++++++++++--
>  1 file changed, 35 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> index 73768f3af6e5..fee64c31d4d4 100644
> --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> @@ -284,7 +284,7 @@ class ovsactions(nla):
>          ("OVS_ACTION_ATTR_UNSPEC", "none"),
>          ("OVS_ACTION_ATTR_OUTPUT", "uint32"),
>          ("OVS_ACTION_ATTR_USERSPACE", "userspace"),
> -        ("OVS_ACTION_ATTR_SET", "none"),
> +        ("OVS_ACTION_ATTR_SET", "ovskey"),
>          ("OVS_ACTION_ATTR_PUSH_VLAN", "none"),
>          ("OVS_ACTION_ATTR_POP_VLAN", "flag"),
>          ("OVS_ACTION_ATTR_SAMPLE", "none"),
> @@ -292,7 +292,7 @@ class ovsactions(nla):
>          ("OVS_ACTION_ATTR_HASH", "none"),
>          ("OVS_ACTION_ATTR_PUSH_MPLS", "none"),
>          ("OVS_ACTION_ATTR_POP_MPLS", "flag"),
> -        ("OVS_ACTION_ATTR_SET_MASKED", "none"),
> +        ("OVS_ACTION_ATTR_SET_MASKED", "ovskey"),
>          ("OVS_ACTION_ATTR_CT", "ctact"),
>          ("OVS_ACTION_ATTR_TRUNC", "uint32"),
>          ("OVS_ACTION_ATTR_PUSH_ETH", "none"),
> @@ -469,6 +469,14 @@ class ovsactions(nla):
>                      print_str += "clone("
>                      print_str += datum.dpstr(more)
>                      print_str += ")"
> +                elif field[0] == "OVS_ACTION_ATTR_SET" or \
> +                     field[0] == "OVS_ACTION_ATTR_SET_MASKED":
> +                    print_str += "set"
> +                    if field[0] == "OVS_ACTION_ATTR_SET_MASKED":
> +                        print_str += "_masked"
> +                    print_str += "("
> +                    print_str += datum.dpstr(more)
> +                    print_str += ")"
>                  else:
>                      try:
>                          print_str += datum.dpstr(more)
> @@ -547,6 +555,25 @@ class ovsactions(nla):
>                  self["attrs"].append(("OVS_ACTION_ATTR_CLONE", subacts))
>                  actstr = actstr[parsedLen:]
>                  parsed = True
> +            elif parse_starts_block(actstr, "set(", False):
> +                parencount += 1
> +                k = ovskey()
> +                actstr = actstr[len("set("):]
> +                actstr = k.parse(actstr, None)
> +                self["attrs"].append(("OVS_ACTION_ATTR_SET", k))
> +                if not actstr.startswith(")"):
> +                    actstr = ")" + actstr
> +                parsed = True
> +            elif parse_starts_block(actstr, "set_masked(", False):
> +                parencount += 1
> +                k = ovskey()
> +                m = ovskey()
> +                actstr = actstr[len("set_masked("):]
> +                actstr = k.parse(actstr, m)
> +                self["attrs"].append(("OVS_ACTION_ATTR_SET_MASKED", [k, m]))
> +                if not actstr.startswith(")"):
> +                    actstr = ")" + actstr
> +                parsed = True
>              elif parse_starts_block(actstr, "ct(", False):
>                  parencount += 1
>                  actstr = actstr[len("ct(") :]
> @@ -1312,7 +1339,7 @@ class ovskey(nla):
>                  mask["attrs"].append([field[0], m])
>              self["attrs"].append([field[0], k])
>
> -            flowstr = flowstr[strspn(flowstr, "),") :]
> +            flowstr = flowstr[strspn(flowstr, "), ") :]
>
>          return flowstr
>
> @@ -1898,7 +1925,11 @@ class OvsFlow(GenericNetlinkSocket):
>              ):
>                  print_str += "drop"
>              else:
> -                print_str += actsmsg.dpstr(more)
> +                if type(actsmsg) == "list":

nit: I belive the recommended way of comparing types is using
"isinstance":

https://www.flake8rules.com/rules/E721.html

Also, I don't see what can make actmsg be a list. It should always be an
instance of "ovsactions", right?


> +                    for act in actsmsg:
> +                        print_str += act.dpstr(more)
> +                else:
> +                    print_str += actsmsg.dpstr(more)
>
>              return print_str
>
> --
> 2.45.1
>


