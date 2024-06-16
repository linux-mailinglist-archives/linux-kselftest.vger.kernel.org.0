Return-Path: <linux-kselftest+bounces-12020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E0C909E82
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jun 2024 18:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B1A1F212A7
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jun 2024 16:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD7617C98;
	Sun, 16 Jun 2024 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtU4siUg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC9C1AAA5;
	Sun, 16 Jun 2024 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718555117; cv=none; b=TGs6/2yvBn3yVsEhteQMrRUYpmQH+Y+voSlhm0pNqbUMeZ/tEuak2/oKlNNrNU5ahpSXmebB1OmU3p6lrqFR494y8PmzXQ5jBDGMHSRTiAmNUwbLekyAua0f3Wnt4I3xG4JwK5OL6hEkaGdgFPN98ViDkqfCQL8jaNl/4fyS7V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718555117; c=relaxed/simple;
	bh=IAA25bVUfugWLKT8yOolq51oSIsgsh6QCEoZg0kbHcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4OSi8TW1nP4AH+Eqthyw7lXgfsxehljbMO0Q5QC6dpPMNiP2C6v9QRzoDYEaOuo27QL505sdlttmT6VDB1G1U+1nx5nvsu+YKAgLrsym9V/WphXlkDS8GNaeY7lh1XSTAkkHnAtYT8WRm/QRkDub4PR/wz0xp0YGWLOoKhLBQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtU4siUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3708C2BBFC;
	Sun, 16 Jun 2024 16:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718555117;
	bh=IAA25bVUfugWLKT8yOolq51oSIsgsh6QCEoZg0kbHcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QtU4siUgad2apY9IwFI+x5JZnP73+OV5Zg+7zCVxkKVQvHdTRscNrLqStgxgFM+yR
	 CGbgHfg6sBZn7dgdMq/nCJejhnnD+GfCdtjSI7W7kvCPn6+zwQYp0uIuJbEXQLXLeA
	 /Hoh+wngOdjx9Z5hCyA7FGxogFqPyDMsxZfiMn0RivTNxX1iJGG3O8h6npZYdXWI4X
	 3WOWzv1j/m021OAdNwxY+bVHduMq/60DMXSHnl31fxzw89a8ll7pQmJVA2MIJtcdor
	 MPPNyVxaG53Ap+S1PkW3Rv/gPYtzx5aPpm03Y62BtLwVL0HhYYZ++72IYc0CanlXD9
	 6iWpDwnje3afg==
Date: Sun, 16 Jun 2024 17:25:12 +0100
From: Simon Horman <horms@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
	linux-kernel@vger.kernel.org, Ilya Maximets <i.maximets@ovn.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [RFC net-next 1/7] selftests: openvswitch: Support
 explicit tunnel port creation.
Message-ID: <20240616162512.GI8447@kernel.org>
References: <20240613181333.984810-1-aconole@redhat.com>
 <20240613181333.984810-2-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613181333.984810-2-aconole@redhat.com>

On Thu, Jun 13, 2024 at 02:13:27PM -0400, Aaron Conole wrote:
> The OVS module can operate in conjunction with various types of
> tunnel ports.  These are created as either explicit tunnel vport
> types, OR by creating a tunnel interface which acts as an anchor
> for the lightweight tunnel support.
> 
> This patch adds the ability to add tunnel ports to an OVS
> datapath for testing various scenarios with tunnel ports.  With
> this addition, the vswitch "plumbing" will at least be able to
> push packets around using the tunnel vports.  Future patches
> will add support for setting required tunnel metadata for lwts
> in the datapath.  The end goal will be to push packets via these
> tunnels, and will be used in an upcoming commit for testing the
> path MTU.
> 
> Signed-off-by: Aaron Conole <aconole@redhat.com>

...

> @@ -1702,12 +1711,43 @@ class OvsVport(GenericNetlinkSocket):
>          msg["dpifindex"] = dpindex
>          port_type = OvsVport.str_to_type(ptype)
>  
> -        msg["attrs"].append(["OVS_VPORT_ATTR_TYPE", port_type])
>          msg["attrs"].append(["OVS_VPORT_ATTR_NAME", vport_ifname])
>          msg["attrs"].append(
>              ["OVS_VPORT_ATTR_UPCALL_PID", [self.upcall_packet.epid]]
>          )
>  
> +        TUNNEL_DEFAULTS = [("geneve", 6081),
> +                           ("vxlan", 4798)]

Hi Aaron,

It is corrected as part of another patch in this series, but
the correct port for vxlan is 4789 (i.e. 89 rather than 98).

With that fixed, feel free to add:

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org>

..

