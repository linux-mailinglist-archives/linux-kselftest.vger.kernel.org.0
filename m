Return-Path: <linux-kselftest+bounces-36109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41DDAEE231
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 17:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E82F47A9B84
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 15:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4907628D8FF;
	Mon, 30 Jun 2025 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgoRlPs5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1807E131E49;
	Mon, 30 Jun 2025 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296344; cv=none; b=IWAnlXIGT+Q/SV4QtpZrEtw9/BcsJdWFtKbfYmtjD1Ynmv5mbg8y3HxZ4B0oXdB85Bd5KW0TFCl1CxAyqw2Bu+pjroOjDL9nqP0c1hKA+tJO2pCtBlwQehz2YoG0gWkZf7Gm3FijXLXFt86kJP4RX9H+fom8Ucr/EN79nbb/Ch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296344; c=relaxed/simple;
	bh=vQ7MLkyR5CPwGHiWJj2+NB7J2sHwL9h4ZGqLqdgQX6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G56+oBnnWerZaDOZq/F+zT9jTHc5xvPNa5285dftwb9R+2Lrv/f1IJJ9T6Msk+MTbalTiq2/is5s0q89JlmqtVpYjl++zTnjQ4l6+CD1U5xXrd4PyBXvO21klWT5axcvqSCbDGOVSSZiAuqDHQ39Zim4EIoxa42Qwyz1VTIhFkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgoRlPs5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D784EC4CEE3;
	Mon, 30 Jun 2025 15:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751296343;
	bh=vQ7MLkyR5CPwGHiWJj2+NB7J2sHwL9h4ZGqLqdgQX6k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OgoRlPs5/saSRuriCeNt2MIQA4qNengUU0m34QLwInAgDUceqpsgwYDW40B15vmkd
	 QRqrRJ/9DDucNM3IP8sgz9OLb5gmuscF9N7DzB0F3f4D3aVehl5XAphLSnAO5hz8ev
	 PpUb+QJsei5egQ7hHd087ywmXz2SyXdL0whpGnnxU8iURN9ITknbREDUTL8/CMR74f
	 perG+JHga0rXSSY9Dsddr+CUoy1Blr6oT8H95CX1yuyxKlvZ6Vj+3o7h+bpkc5kspo
	 OQcFl62PZtrC8R5F3m/aeDLAudMmaubzihSTdcFmIOiIqBcYQ2ku29b/EHyFbFrqPg
	 Y6F1UzWKbW+bQ==
Date: Mon, 30 Jun 2025 08:12:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: "alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
 "pctammela@mojatatu.com" <pctammela@mojatatu.com>, "horms@kernel.org"
 <horms@kernel.org>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "xandfury@gmail.com" <xandfury@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "jhs@mojatatu.com"
 <jhs@mojatatu.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "xiyou.wangcong@gmail.com"
 <xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "ast@fiberby.net" <ast@fiberby.net>, "liuhangbin@gmail.com"
 <liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
 <ncardwell@google.com>, "Koen De Schepper (Nokia)"
 <koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
 <g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
 <ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
 <mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
 "rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
 <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com"
 <vidhi_goel@apple.com>
Subject: Re: [PATCH v20 net-next 6/6] Documentation: netlink: specs: tc: Add
 DualPI2 specification
Message-ID: <20250630081222.528202d5@kernel.org>
In-Reply-To: <PAXPR07MB79842E86F802F227C79C05F6A347A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
	<20250621193331.16421-7-chia-yu.chang@nokia-bell-labs.com>
	<20250627161930.385554c0@kernel.org>
	<PAXPR07MB79842E86F802F227C79C05F6A347A@PAXPR07MB7984.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 29 Jun 2025 22:32:15 +0000 Chia-Yu Chang (Nokia) wrote:
> I was thinking could we keep the same strucutre? As we already have
> several rounds of review for both net-next and iproute2-next.

Not a valid argument, uAPI is forever.

