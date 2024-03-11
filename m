Return-Path: <linux-kselftest+bounces-6211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F0B8784FD
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 17:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9899B2847EE
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 16:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5066858210;
	Mon, 11 Mar 2024 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCVnqZyH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BA158ADB;
	Mon, 11 Mar 2024 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173873; cv=none; b=Ox8GfD0gN9LaClF1e1Q3S+j4A9yI2jZ+BANnodeH+BP7US07zPL5YpPe/zJcj1C9hI3HKgHix8MsZXfAJHFmPOg69AweF4TGjhkvDU3C2sjEyJ4EcqkwMzegyTeWtWqmnXyD8DwFK49Q2d+uuGt6+2uzYPSm5mAyLHer0sQZsgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173873; c=relaxed/simple;
	bh=fxy8Bas3XPLuH2tOB6qbRr0HANQEqxNF3SMRFOMH+dg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=espqDREoeOQ+/cTUFB42agvbwFfwz9c/vNsF9WgMobLo/+Chirb+f3dpnoanthU5AiNXWoJiCbWp24DJfzrLAo5cY+wUAbMnOOy+Fzp4NckWmz24HxWOIhOoDPtM8SAkMo+raa889MnmxrESUc93bIQF08Zz96Cp2aTTH4cQYIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCVnqZyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64910C433C7;
	Mon, 11 Mar 2024 16:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710173872;
	bh=fxy8Bas3XPLuH2tOB6qbRr0HANQEqxNF3SMRFOMH+dg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hCVnqZyHStwcshm/LpUyPhbvatBuvyPQK9rm3Txg85kF7gcBsFm8XKMnNQ++/RZoE
	 f30dL32Jyl7+53Z6wH4eDEiIaLZJ9FJpPhBI7FKAd76FK3ZHcAbYzYFrdk5sf9oBdv
	 UH0zC+SioWzSid4v8ScQbf8FAEIpZdsjGQ/Nk29xiGcbcMe5+d1+oAyZ4e0vFfn2BN
	 yN0DXXm4P4d5copcRKxfvV7d8Ec8cfGwb36aIYlG86VOJV9bMyJlV/tJqI2PiLkV+4
	 yGOlnClLluJi99aJCcAK13nTImM5GDayxsgG7TROBeq6dNlFhnpdo/GRqL8YDl5fa9
	 wOKKxB7DA2sGQ==
Date: Mon, 11 Mar 2024 09:17:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: netdev@vger.kernel.org, Guillaume Nault <gnault@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, David Ahern
 <dsahern@gmail.com>
Subject: Re: [BUG net-next] fcnal-test.sh: 4 (four) tests FAIL
Message-ID: <20240311091751.5c4f2947@kernel.org>
In-Reply-To: <9f24a9c3-4813-4518-9cc4-3923c11981cd@alu.unizg.hr>
References: <9f24a9c3-4813-4518-9cc4-3923c11981cd@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 Mar 2024 19:45:15 +0100 Mirsad Todorovac wrote:
> In the vanilla net-next tree build of v6.8-rc7-2348-g75c2946db360, with up-to-date
> iproute2 built tools, fcnal-test.sh reports certain failures:
> 
> --------------------------------------------------------------------------------------
> # TEST: ping local, VRF bind - VRF IP                                           [FAIL]
> # TEST: ping local, device bind - ns-A IP                                       [FAIL]
> # TEST: ping local, VRF bind - VRF IP                                           [FAIL]
> # TEST: ping local, device bind - ns-A IP                                       [FAIL]
> --------------------------------------------------------------------------------------

Adding David A to CC.

It rings a bell. We also build ping from source when running the tests
locally, I have in my notes "AWS iputils are buggy, use iputils.git"
but unfortunately I didn't make a note which tests were failing without
it. David might remember..

