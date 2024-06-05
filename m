Return-Path: <linux-kselftest+bounces-11255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A578FD6AC
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 21:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D628AB226BB
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 19:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51781527A9;
	Wed,  5 Jun 2024 19:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKaN2IFJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F99314EC56;
	Wed,  5 Jun 2024 19:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717616600; cv=none; b=cUWfsP0Ij+nD/CQ4akf1cGsQcNAusInooZ7geKp0cueu1APzxT2r72yaA5OXVq6vhXIawiv4LZVajRS8pPjLJlV3nI7czodvRGgyOLG1vCsGUlaeANiPPL/VZg2iVmGB1pPWf1no0PGQa8nbpSSRQTKBBkKOcQhObU98hX15Pvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717616600; c=relaxed/simple;
	bh=KIGvffMFmtiF6JY2kPrxSLeoIMqNOQ0IhOPnWoh89qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmQADH7JhkeLHgrSVCmfhl21f1n2MheQ2A5uSsSIcRRZYUU2kIbWPaiqzFWdHAUilx/YfZYBsmldwxvC5P5ihB5ssFbQWasMvhkN5LDiIM8xl6AORqvD+1st1wYk+Rnmw1eeqfLwHi2aUtO5whGZhJfcQnfL8Ev9bpeR4n7NKr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKaN2IFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A240C2BD11;
	Wed,  5 Jun 2024 19:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717616600;
	bh=KIGvffMFmtiF6JY2kPrxSLeoIMqNOQ0IhOPnWoh89qY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kKaN2IFJMH56DTxD6b+6O+4kWa3g6aTqMvBPs6i1mT30xPAXQPUWafP+1Jx1JdDsC
	 62zCdOLvk+B+4F47V9wIoc4DqvdEWSHFK+QqmcbTq0LZ0D5jYCqLP8ob+kf6OYoYoR
	 SYmUAgt2Tw+bgeAonl4E6Pf3lnr23fao+Y7cuT/IYfMYYQsuw4WLnkmJ5fTGuHESzo
	 9v/9c4r9cjc1eD+pKoGANyTxd6Te+w5st6/Od/mlfu1aWfdjQZraJX/bo0Sgu7BAlz
	 ScrGVKjA/5dCdATM/KN94ntYghEYAx5Wi7+NwWJFDzrmyX6yh6T/S40w6t4URGkR94
	 nbYzdHe8ST2dw==
Date: Wed, 5 Jun 2024 20:43:14 +0100
From: Simon Horman <horms@kernel.org>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
	i.maximets@ovn.org, dev@openvswitch.org,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 9/9] selftests: openvswitch: add emit_sample
 test
Message-ID: <20240605194314.GX791188@kernel.org>
References: <20240603185647.2310748-1-amorenoz@redhat.com>
 <20240603185647.2310748-10-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603185647.2310748-10-amorenoz@redhat.com>

On Mon, Jun 03, 2024 at 08:56:43PM +0200, Adrian Moreno wrote:
> Add a test to verify sampling packets via psample works.
> 
> In order to do that, create a subcommand in ovs-dpctl.py to listen to
> on the psample multicast group and print samples.
> 
> In order to also test simultaneous sFlow and psample actions and
> packet truncation, add missing parsing support for "userspace" and
> "trunc" actions.
> 
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

...

> @@ -803,6 +819,25 @@ class ovsactions(nla):
>                  self["attrs"].append(["OVS_ACTION_ATTR_EMIT_SAMPLE", emitact])
>                  parsed = True
>  
> +            elif parse_starts_block(actstr, "userspace(", False):
> +                uact = self.userspace()
> +                actstr = uact.parse(actstr[len("userpsace(") : ])

nit: userspace

     Flagged by checkpatch.pl --codespell

> +                self["attrs"].append(["OVS_ACTION_ATTR_USERSPACE", uact])
> +                parsed = True
> +
> +            elif parse_starts_block(actstr, "trunc", False):
> +                parencount += 1
> +                actstr, val = parse_extract_field(
> +                    actstr,
> +                    "trunc(",
> +                    r"([0-9]+)",
> +                    int,
> +                    False,
> +                    None,
> +                )
> +                self["attrs"].append(["OVS_ACTION_ATTR_TRUNC", val])
> +                parsed = True
> +
>              actstr = actstr[strspn(actstr, ", ") :]
>              while parencount > 0:
>                  parencount -= 1

