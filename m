Return-Path: <linux-kselftest+bounces-14921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43F694AA28
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 16:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8016928382E
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 14:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7B078C92;
	Wed,  7 Aug 2024 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JE/7Wz8r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F5877115;
	Wed,  7 Aug 2024 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041139; cv=none; b=hpUYN4SftpRNS+nKDTg+bv8JS4xJKuj1o6lMRRFzvQac2Dvjus6zmzwXKcRE8W35/6xFOMoPWYGT75NOkLCwbAjOUWNIJ7wLvHJ/uDbPtBrc983n5r/dCTqKQNDbvstjea9W5NhfkbxX2JZoiy5xV2wLOPGfuzvuHKoJNAG1tSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041139; c=relaxed/simple;
	bh=C2BR5vrTejxjK2wU5ItbvspQ/Ev/EstrJaxCSihoe+w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QtCo2RshPwjme1Dcovld4egdnIdM/iwUwNuTX+g+q2d0GWmYDu9IOWEMw3hKudAZD5hvh9qs3tj8sQHHRSiu9/iDVAaIn6tbGQyxuQVSiamkFjmyvtGlUEVQ2WLDB+wmPbLu/3vOEL/pEUEXuNPv2lfg9fHSL5qSmq3buxW4Z0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JE/7Wz8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2E1C4AF0F;
	Wed,  7 Aug 2024 14:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723041138;
	bh=C2BR5vrTejxjK2wU5ItbvspQ/Ev/EstrJaxCSihoe+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JE/7Wz8rtJTmfu4oWxjRzBhKmYgbWFLati+8R3F1l1FOoWHfJzjLM5IuZw4VLWfK6
	 NCtmPKsnn2ImIESy1Gif04e49wEo3S8h/tbV73zH6yyQKEXOcWH0B+ydsejFFQQBlJ
	 0rJhVKrC7Ju7lcVtTGsQjjQGd8zCFTMWGO1WEIL2nEtvuNOwLN0P3bpg0bAsvLLp5A
	 uB3Tann/ALx5GyFWP1lZ0udPj1pbKBgAUXQY2jrs+Epl0oTvTiIZvxnFMnG3DIsAQb
	 MNFKvSPxHOBMr7SO8plCRXdIubd0glg2LlgfW0zbgHSoG9S5vb+dGerlzNk9Ga4E5T
	 LjYy+l2HrWroA==
Date: Wed, 7 Aug 2024 07:32:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: Ido Schimmel <idosch@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Petr Machata
 <petrm@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>, Benjamin Poirier
 <bpoirier@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Geliang Tang <tanggeliang@kylinos.cn>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: forwarding: lib.sh: ignore "Address
 not found"
Message-ID: <20240807073217.7d4f3412@kernel.org>
In-Reply-To: <a22d9e0eb835e40000bc1955b57ae115ae44353c.camel@kernel.org>
References: <764585b6852537a93c6fba3260e311b79280267a.1722917654.git.tanggeliang@kylinos.cn>
	<ZrHTafNilRs6dx6E@shredder.mtl.com>
	<a22d9e0eb835e40000bc1955b57ae115ae44353c.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 07 Aug 2024 12:08:15 +0800 Geliang Tang wrote:
> I did get these errors with the latest net-next and iproute2-next. For
> example, I got these errors of "bridge_mdb_port_down.sh":
> 
> $ sudo ./bridge_mdb_port_down.sh 
> TEST: MDB add/del entry to port with state down                  [ OK ]
> Error: ipv4: Address not found.
> Error: ipv6: address not found.
> Error: ipv4: Address not found.
> Error: ipv6: address not found.

FWIW netdev CI runs with iproute2 as of 2cb1a656e99 plus Petr's 16b
weight patches, and I don't see "address not found".

