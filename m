Return-Path: <linux-kselftest+bounces-30880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE56A8A249
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 17:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742B13BF8D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 15:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41392BCF7D;
	Tue, 15 Apr 2025 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUMwfFQM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28912BCF78;
	Tue, 15 Apr 2025 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744729099; cv=none; b=XEETXohG+9tOXNh5sMjkx12lI1jj/n1Eb1FBMvULmMAWLTrJ24kotsdTU00QK3qrSfdnUgbJlZO9DPgtg2JaOFs+3kZE1B0zsKuEKTeGAQpNCZdhpy6BLDoKIsQaNwqkh7Cn3ngkrWhZdMIsi0Dv4doB2Fg0/UMJOIHNz1a8HWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744729099; c=relaxed/simple;
	bh=i/1iowM4EWgHXIVmePDA5yseMSSqi0+ioDg3Ey0+4BU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZyXr6NpsCo/Z09lhtPCnx6Jb8EA3flwzyzR4Zq5MleBfGdEAWBO5pqxwwVQoTyjuDtndgVHzFaWcloqfjFaH8d4lktD1cnCZG4n1ZfGKhcyKxjQLo3QKH+/fly+/+M3c6BjXRE8xOsxCpnh+DthpWbMq3iQ4psBLkZfhxAlffR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUMwfFQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480DCC4CEEB;
	Tue, 15 Apr 2025 14:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744729098;
	bh=i/1iowM4EWgHXIVmePDA5yseMSSqi0+ioDg3Ey0+4BU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XUMwfFQM+CRgGE455BG1k9FeeYBqfszmJDEc61MVt7Vnk0aNxecOgL58LDv3IGN75
	 GaO4UZ1FtOADKrHfX6CQB4n004vgl3v9HnHrxQzjc76GLsmr4VC/vvRsQHXkbxNpMk
	 ebO1V7QyWyrGN1amiuVIlJgcrpunW0G2dimsH6w0k94yEGWscsBeoEgQIdzNniX8ld
	 Z+pQgeK6J+pp1bCN5W9DBecqjZv4mt7a6malbLTOEV5rJOd2xjjZrtqUMOknbnzmZ6
	 Kkfmzf6qwK7wNRK2hvrPlLc52dGmmdB3XvtTgOlSf6NyBFRELImsbwAeJEJkPLu+Sc
	 dpdVj4n3c/gDA==
Date: Tue, 15 Apr 2025 07:58:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: xandfury@gmail.com, netdev@vger.kernel.org, dave.taht@gmail.com,
 pabeni@redhat.com, jhs@mojatatu.com, stephen@networkplumber.org,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
Subject: Re: [PATCH v11 net-next 0/5] DUALPI2 patch
Message-ID: <20250415075814.5b182f04@kernel.org>
In-Reply-To: <20250415124317.11561-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250415124317.11561-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 14:43:12 +0200 chia-yu.chang@nokia-bell-labs.com
wrote:
>   Please find the reposted DualPI2 patch v11.

24 hours means 24 hours, not 23, especially when you're reposting
because your previous version did not build!

Our infra is severely behind on testing, such sloppiness is
impacting our ability to process patches :|

