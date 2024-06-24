Return-Path: <linux-kselftest+bounces-12576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4739159E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 00:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB65282553
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 22:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0083A1420B0;
	Mon, 24 Jun 2024 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeGCPk+n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C674A45C1C;
	Mon, 24 Jun 2024 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719268224; cv=none; b=g51kl5y9hji+GGpoafnJ1L4L5OIEoBNiCcGqti2jfdMagjNi/jZyVcrgpKOkdNjtbUre37WPTVgS6E5HGiQ3YVomzGXLquODe3RC+QoFSymAb8cqPMCcW0EqsBV3QtVDj5mL8C4OJ25m+g++cY5cXgOt4D9S+kVX0yIVa0x+dAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719268224; c=relaxed/simple;
	bh=2arpIBMsaGBDFcWMlj/bcfBvS51IHtb8fwvNCwO1pLI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ay1P4wTc4l9/ro3lg7W3xEr7KEf5pxynBVd0nGvHc8mVWzwNyfv8B4/fANnv5ivH9ytqm9AHOSQQDD7PuZ2HnTV/MQ0lxQaAN/BJmvipGm76Et3LS5pHSKVFSpK8kWVpDJvMNqewSpSVpNKRfAojC88KLSAFoYTb1X3LXpGFOmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeGCPk+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F85C2BBFC;
	Mon, 24 Jun 2024 22:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719268224;
	bh=2arpIBMsaGBDFcWMlj/bcfBvS51IHtb8fwvNCwO1pLI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AeGCPk+nxKe2Eopto8yw/oF7EqMFZvHj6ROeHju+povaRuDiNqp7QsISvqe0p/O51
	 lbYgR/VjwF5cm/dDmr4CneG0k9tP98/RjX65Km38pAgOwSFuAGhiaeTDspPzaqxQZ0
	 vSi8Xa2f/ICfMHYQPbJk9OaaHpfXAOCfKyUISYQ5azx5sZo4Owh8WePLKvg5HioWO1
	 /G2FW/Erldp/NYcTdkpSP8KYpdb6EJBRlPnzUtFiSTBpBoPHD4yT+3P81Ox/qOukDm
	 nn9e2o7yMJE7ofZJv7DZcoU9kfzH0PvCAcPeEq9/wA6czlQVsWsbx24z191JSqLY9O
	 d9oogWl5UYoQA==
Date: Mon, 24 Jun 2024 15:30:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Pravin B
 Shelar <pshelar@ovn.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, =?UTF-8?B?QWRy?=
 =?UTF-8?B?acOhbg==?= Moreno <amorenoz@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH v2 net-next 0/7] selftests: net: Switch pmtu.sh to use
 the internal ovs script.
Message-ID: <20240624153023.6fabd9f1@kernel.org>
In-Reply-To: <f7tpls6gu3q.fsf@redhat.com>
References: <20240620125601.15755-1-aconole@redhat.com>
	<20240621180126.3c40d245@kernel.org>
	<f7ttthjh33w.fsf@redhat.com>
	<f7tpls6gu3q.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 12:53:45 -0400 Aaron Conole wrote:
> Additionally, the "Cannot find device ..." text comes from an iproute2
> utility output.  The only place we actually interact with that is via
> the call at pmtu.sh:973:
> 
> 	run_cmd ip link set ovs_br0 up
> 
> Maybe it is possible that the link isn't up (could some port memory
> allocation or message be delaying it?) yet in the virtual environment.

Depends on how the creation is implemented, normally device creation
over netlink is synchronous. Just to be sure have you tried to repro
with vng:

https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

? It could be the base OS difference, too, but that's harder to confirm.

> To confirm, is it possible to run in the constrained environment, but
> put a 5s sleep or something?  I will add the following either as a
> separate patch (ie 7/8), or I can fold it into 6/7 (and drop Stefano's
> ACK waiting for another review):
> 
> 
> wait_for_if() {
>    if ip link show "$2" >/dev/null 2>&1; then return 0; fi
> 
>    for d in `seq 1 30`; do
>       sleep 1
>       if ip link show "$2" >/dev/null 2>&1; then return 0; fi
>    done
>    return 1
> }
> 
> ....
>  	setup_ovs_br_internal || setup_ovs_br_vswitchd || return $ksft_skip
> +	wait_for_if "ovs_br0"
>  	run_cmd ip link set ovs_br0 up
> ....
> 
> Does it make sense or does it seem like I am way off base?

sleep 1 is a bit high (sleep does accept fractional numbers!)
but otherwise worth trying, if you can't repro locally.

