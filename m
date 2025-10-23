Return-Path: <linux-kselftest+bounces-43822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8283BFEC2A
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 02:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B7418C50CA
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 00:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94D482899;
	Thu, 23 Oct 2025 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3M3LFft"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCBC14286;
	Thu, 23 Oct 2025 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761180635; cv=none; b=XbZ4YrWAACwwvUIDwNZJx6j7E5j4Skw3s3u2np6KvfP1S1XK1TgEZ2m/8Rq5T1b/giqU2wGM0gw4zIjWIxlHVTkzWTrHaDmYHXFL44PYNP5o3VHGJXee4du1QQ12w/6+Ew2rElAMibBfyhnlTFYF4slkprVwdJVtcuIBsySVuYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761180635; c=relaxed/simple;
	bh=AeztyjM4bXsgEXDDu28JWWna7Y3Xvzrm+yByy1v+FhM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oECqQbcfjmugzXxB+o5hIyN0qWNKGP03MODI23G8hITKYOVgCra7e/qkfsrg8zbc53fjv5KoEe3R3usNj+2q22ALcd/63Z1YQhqD5RBoHAnLdTcDXNSif7Krfp00QhG+aRMDxMdVr7Mh/AQVDFS86thDEifIQjZfXPQ+OHCjbvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3M3LFft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F402C4CEE7;
	Thu, 23 Oct 2025 00:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761180635;
	bh=AeztyjM4bXsgEXDDu28JWWna7Y3Xvzrm+yByy1v+FhM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h3M3LFftBYioTjv3yi4hG8J8f9bFEp52AqHeS3tWzGOff3lENVPOdXcRVhQWZS91I
	 19PQuYGKi2WWkOWU1Q3naAd9RaDMtM0XsLzorBbdTseazwEwKKP+zwVLEVtdWTfH6/
	 1Tkv+RPy6+qSbm2UKDMmfdTYTJxpc5rLJLvrxOBtdDbpVlFVBCWBEZ0bBAQfkk7fay
	 fF8xUko3ZvD3Qa1D14Wy436K2cAeP1V8pzDxzbRnWLBZKvFLxkFboMNM35ZP1ssI8p
	 97yKGFLD503wf2xX+37tds/Z8F9YjPxsh7LKeee0/Q6Qv6OGJAHl3Y8/neSVuJ/xfv
	 y60MFVRgNa6XA==
Date: Wed, 22 Oct 2025 17:50:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wilder <wilder@us.ibm.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, pradeep@us.ibm.com,
 i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
 stephen@networkplumber.org, horms@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, edumazet@google.com, razor@blackwall.org,
 shuah@kernel.org, corbet@lwn.net, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v14 0/7] bonding: Extend arp_ip_target format
 to allow for a list of vlan tags.
Message-ID: <20251022175033.7daec7f6@kernel.org>
In-Reply-To: <20251022182721.2567561-1-wilder@us.ibm.com>
References: <20251022182721.2567561-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 11:25:27 -0700 David Wilder wrote:
> The current implementation of the arp monitor builds a list of vlan-tags by
> following the chain of net_devices above the bond. See bond_verify_device_path().
> Unfortunately, with some configurations, this is not possible. One example is
> when an ovs switch is configured above the bond.

Once again if anyone thinks this belongs in the kernel please speak up.
Otherwise let this be the last posting.

*If* someone does speak up in support you will need to find a less ugly
way to represent the attribute within Netlink. What you invent must work
in YNL and be added to the spec (Documentation/netlink/specs/rt-link.yaml)
-- 
pw-bot: cr

