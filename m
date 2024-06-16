Return-Path: <linux-kselftest+bounces-12021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C28D909E86
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jun 2024 18:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9A01C20912
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jun 2024 16:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9BE19BA6;
	Sun, 16 Jun 2024 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LA3B5bnZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9D718AED;
	Sun, 16 Jun 2024 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718555268; cv=none; b=nboXCiZrSIXVrKTknRXar+biV7D1zcbHzMq3ULIix/YkmEf6rw8QjOYz9Qyt905isT0jo0yYtkEr28qkBvbNWUojsmP0vimahEvJ9dv6MxkH4KBU7GO0Oe19A/FiayJZG1TI5NC4s5BeO92XK/kk2VcxQTtUvrWoA9f8qhaGv0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718555268; c=relaxed/simple;
	bh=R4ughozVT56QCbPR51GSfnBUh8L1i351yEtjuk8UNIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOzhvxfkE2Kt4YymjPi0tpcj+z7VQrhZApR9zpWjByw/NNEHIMBx+zX5N+vY5wDTF69GbLzeOHo7jr5UV9p4o59EKf2mKELPF2PzPBIVJ43CAeYSdp4iDurPMkbUPolMMbIDI9TIeTjsxrxahzEQQHGHcoeTCpmLiepFPgKL5CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LA3B5bnZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425C3C2BBFC;
	Sun, 16 Jun 2024 16:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718555267;
	bh=R4ughozVT56QCbPR51GSfnBUh8L1i351yEtjuk8UNIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LA3B5bnZp8sRuESh5T6rV0Lb3WVsJGx8mJqLoGG1VEh8OmYcGW6EAJI91cQ88sCw6
	 LL/hfr/rOZvYey8LbyixBcim0/iVJGn2TqXcNnDy25aeEITH3Oe1PshlUCHWNe/WDE
	 6NDKkekhaxGnrBf69hypXbRtL0nPBCQwIUrPGfNuCfJZJoBX6HW8hM3mkNN0rNhRWx
	 Hmrn/FDS2dHGGHC5PtN7cNexPRYKxduDv4GnoiskspaBS4KZWzt6io+DjHoTslOKaS
	 /GyKgwhHkb6WK8S+QhNKHR1puBuRQWINnQkT9HSUQDZuC/aNZW+ifOT3CJkwAkJvom
	 1uz+ZDI+bMZiw==
Date: Sun, 16 Jun 2024 17:27:43 +0100
From: Simon Horman <horms@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
	linux-kernel@vger.kernel.org, Ilya Maximets <i.maximets@ovn.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [RFC net-next 4/7] selftests: openvswitch: Add support
 for tunnel() key.
Message-ID: <20240616162743.GJ8447@kernel.org>
References: <20240613181333.984810-1-aconole@redhat.com>
 <20240613181333.984810-5-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613181333.984810-5-aconole@redhat.com>

On Thu, Jun 13, 2024 at 02:13:30PM -0400, Aaron Conole wrote:
> This will be used when setting details about the tunnel to use as
> transport.  There is a difference between the ODP format between tunnel():
> the 'key' flag is not actually a flag field, so we don't support it in the
> same way that the vswitchd userspace supports displaying it.
> 
> Signed-off-by: Aaron Conole <aconole@redhat.com>

...

> @@ -1265,6 +1265,165 @@ class ovskey(nla):
>                  init=init,
>              )
>  
> +    class ovs_key_tunnel(nla):
> +        nla_flags = NLA_F_NESTED
> +
> +        nla_map = (
> +            ("OVS_TUNNEL_KEY_ATTR_ID", "be64"),
> +            ("OVS_TUNNEL_KEY_ATTR_IPV4_SRC", "ipaddr"),
> +            ("OVS_TUNNEL_KEY_ATTR_IPV4_DST", "ipaddr"),
> +            ("OVS_TUNNEL_KEY_ATTR_TOS", "uint8"),
> +            ("OVS_TUNNEL_KEY_ATTR_TTL", "uint8"),
> +            ("OVS_TUNNEL_KEY_ATTR_DONT_FRAGMENT", "flag"),
> +            ("OVS_TUNNEL_KEY_ATTR_CSUM", "flag"),
> +            ("OVS_TUNNEL_KEY_ATTR_OAM", "flag"),
> +            ("OVS_TUNNEL_KEY_ATTR_GENEVE_OPTS", "array(uint32)"),
> +            ("OVS_TUNNEL_KEY_ATTR_TP_SRC", "be16"),
> +            ("OVS_TUNNEL_KEY_ATTR_TP_DST", "be16"),
> +            ("OVS_TUNNEL_KEY_ATTR_VXLAN_OPTS", "none"),
> +            ("OVS_TUNNEL_KEY_ATTR_IPV6_SRC", "ipaddr"),
> +            ("OVS_TUNNEL_KEY_ATTR_IPV6_DST", "ipaddr"),
> +            ("OVS_TUNNEL_KEY_ATTR_PAD", "none"),
> +            ("OVS_TUNNEL_KEY_ATTR_ERSPAN_OPTS", "none"),
> +            ("OVS_TUNNEL_KEY_ATTR_IPV4_INFO_BRIDGE", "flag"),
> +        )
> +
> +        def parse(self, flowstr, mask=None):
> +            if not flowstr.startswith("tunnel("):
> +                return None, None
> +
> +            k = ovskey.ovs_key_tunnel()
> +            if mask is not None:
> +                mask = ovskey.ovs_key_tunnel()
> +
> +            flowstr = flowstr[len("tunnel("):]
> +
> +            v6_address = None
> +
> +            fields = [
> +                ("tun_id=", r"(\d+)", int, "OVS_TUNNEL_KEY_ATTR_ID",
> +                 0xffffffffffffffff, None, None),
> +
> +                ("src=", r"([0-9a-fA-F\.]+)", str,
> +                 "OVS_TUNNEL_KEY_ATTR_IPV4_SRC", "255.255.255.255", "0.0.0.0",
> +                 False),
> +                ("dst=", r"([0-9a-fA-F\.]+)", str,
> +                 "OVS_TUNNEL_KEY_ATTR_IPV4_DST", "255.255.255.255", "0.0.0.0",
> +                 False),
> +
> +                ("ipv6_src=", r"([0-9a-fA-F:]+)", str,
> +                 "OVS_TUNNEL_KEY_ATTR_IPV6_SRC",
> +                 "ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff", "::", True),
> +                ("ipv6_dst=", r"([0-9a-fA-F:]+)", str,
> +                 "OVS_TUNNEL_KEY_ATTR_IPV6_DST",
> +                 "ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff", "::", True),
> +
> +                ("tos=", r"(\d+)", int, "OVS_TUNNEL_KEY_ATTR_TOS", 255, 0,
> +                 None),
> +                ("ttl=", r"(\d+)", int, "OVS_TUNNEL_KEY_ATTR_TTL", 255, 0,
> +                 None),
> +
> +                ("tp_src=", r"(\d+)", int, "OVS_TUNNEL_KEY_ATTR_TP_SRC",
> +                 65535, 0, None),
> +                ("tp_dst=", r"(\d+)", int, "OVS_TUNNEL_KEY_ATTR_TP_DST",
> +                 65535, 0, None),
> +            ]
> +
> +            forced_include = ["OVS_TUNNEL_KEY_ATTR_TTL"]
> +
> +            for prefix, regex, typ, attr_name, mask_val, default_val, v46_flag in fields:
> +                flowstr, value = parse_extract_field(flowstr, prefix, regex, typ, False)
> +                if not attr_name:
> +                    raise Exception("Bad list value in tunnel fields")
> +
> +                if value is None and attr_name in forced_include:
> +                    value = default_val
> +                    mask_val = default_val
> +
> +                if value is not None:
> +                    if v6_address is None and v46_flag is not None:
> +                        v6_address = v46_flag

By my reading, at this point v6_address will only be None if v46_flag is
not None.  IF so, the condition below seems excessive.

> +                    if v6_address is not None and v46_flag is not None \
> +                       and v46_flag != v6_address:
> +                        raise ValueError("Cannot mix v6 and v4 addresses")

I wonder if we can instead express this as (completely untested!):

                    if v46_flag is not None:
                        if v6_address is None:
                            v6_address = v46_flag
                        if v46_flag != v6_address:
                            raise ValueError("Cannot mix v6 and v4 addresses")

> +                    k["attrs"].append([attr_name, value])
> +                    if mask is not None:
> +                        mask["attrs"].append([attr_name, mask_val])
> +                else:
> +                    if v6_address is not None and v46_flag is not None \
> +                       and v46_flag != v6_address:
> +                        continue
> +                    if v6_address is None and v46_flag is not None:
> +                        continue

And I wonder if this is a bit easier on the eyes (also completely untested):

                    if v46_flag is not None:
                        if v6_address is None or v46_flag != v6_address:
                            continue

> +                    if mask is not None:
> +                        mask["attrs"].append([attr_name, default_val])
> +
> +            if k["attrs"][0][0] != "OVS_TUNNEL_KEY_ATTR_ID":
> +                raise ValueError("Needs a tunid set")

...

> @@ -1745,7 +1905,7 @@ class OvsVport(GenericNetlinkSocket):
>          )
>  
>          TUNNEL_DEFAULTS = [("geneve", 6081),
> -                           ("vxlan", 4798)]
> +                           ("vxlan", 4789)]
>  
>          for tnl in TUNNEL_DEFAULTS:
>              if ptype == tnl[0]:

As noted in my response to PATCH 1/7, I think that the
change in the hunk above belongs there rather than here.

