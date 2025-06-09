Return-Path: <linux-kselftest+bounces-34522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F89AD2905
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 23:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 990F87A7890
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 21:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B72222570;
	Mon,  9 Jun 2025 21:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiR2EBbx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A1119E992;
	Mon,  9 Jun 2025 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749506372; cv=none; b=AYEhP8PwSrCQwwtvF+wfSAWpI/f190vKlwnJNlClVkmVxf7dFDm+N2JaNLPW2ru/TLZQMekf8HccvsCf6EOUzZf4QoHTMmgosuWjCeAJictDol9589L5oMb294+gVotk40KEoyKO+XRcU/55iZHvYWrcPdgXs39gzu7rtOQl4ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749506372; c=relaxed/simple;
	bh=n3Z1ZQMAO9NraVCRE5x8t+QaCYLmuLEY6KV8qMZWOPo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mUCcLT3KZNsOkLdeyj9xfV57vrKT43Br5Jgf9+yM22NqxkmBU9YwXE5JJTBtqgwmIjCJUh7aFSMmqDNtibFyCiM5OIjoFoIHTEdYf4jF7RXhD4HLo+Swy5FHC8I9Q5Cw44yiJiCbrrS5lUlW6FH5u2XSgDx6QdfVJiHN25WGykM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiR2EBbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31778C4CEEB;
	Mon,  9 Jun 2025 21:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749506371;
	bh=n3Z1ZQMAO9NraVCRE5x8t+QaCYLmuLEY6KV8qMZWOPo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WiR2EBbxHhpZIfdbKe3mYOmRR78gmnAsvcYjJJc32H5oCxq+ER09bD0IVydvU//vh
	 gq8rJA9cQpqCserjwOmfJqn0XSmaCg6RjR04qJq6JVbmV2cEC321BsPVBLTLP9NP/F
	 24rebBlciVAIjpMr4A+W+bH625MG8VsDQUAJyyUev0tp3HGPMAxvev9RSEiY0iG8rT
	 yjhY9fjfBIKhEIgp/Aplr79/q8/jip2Tkxfa2RKVqE06HBPmKiUJmNGyW6ijMVAa8z
	 1s/wym+yON/e41GzOaPKWYgLjkSgnyKQ7xyL4BvHEZs1IHE65Z2F1iUdwh/oY4BMuw
	 pzigiTdf52HRg==
Date: Mon, 9 Jun 2025 14:59:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?= <maze@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, Daniel Borkmann
 <daniel@iogearbox.net>, martin.lau@linux.dev, john.fastabend@gmail.com,
 eddyz87@gmail.com, sdf@fomichev.me, haoluo@google.com, willemb@google.com,
 william.xuanziyang@huawei.com, alan.maguire@oracle.com,
 bpf@vger.kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 yonghong.song@linux.dev
Subject: Re: [PATCH net v2] net: clear the dst when changing skb protocol
Message-ID: <20250609145928.014a72c6@kernel.org>
In-Reply-To: <CANP3RGcUbSG3dQQbDrsYq9YSMStXbmEsq6U34jcieA_45H4_JQ@mail.gmail.com>
References: <20250607204734.1588964-1-kuba@kernel.org>
	<CANP3RGcUbSG3dQQbDrsYq9YSMStXbmEsq6U34jcieA_45H4_JQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 7 Jun 2025 23:33:39 +0200 Maciej =C5=BBenczykowski wrote:
> 1 meta question: as this is a fix and will thus be backported into
> 5.4+ LTS, should this be split into two patches? Either making the
> test a follow up, or even going with only the crash fix in patch 1 and
> putting the 4-in-4 and 6-in-6 behavioural change in patch 2?  We'd end
> up in the same state at tip of tree... but it would affect the LTS
> backports.  Honestly I'm not even sure what's best.

:) Did we go from wondering if we can strip dst unconditionally to
wondering if stripping it on encap/decap may introduce regressions?

I suppose it may be useful to split, just to make it clear which
portion of the change is the crash fix and which one is just because
we think it's more consistent.
--=20
pw-bot: cr

