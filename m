Return-Path: <linux-kselftest+bounces-30954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C62DA9056A
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 16:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91C3464D8A
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 14:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9030420A5E5;
	Wed, 16 Apr 2025 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZM0t9cra"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689AD189902;
	Wed, 16 Apr 2025 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811545; cv=none; b=ON27EedPi2mLDrPmsRb5OOyjHKQ4DOSwYJsUvfVwJ+s1tMXxU4VwByw25tS2t/Ktj2EbMd67OVLnlhK42rT39F3NRhmvtqd+eixQdTV3w2HoHY+jTiAD/BcRQDiBr2E4D2uMPPX31sA7fKCJ1YKC762Gn36KB5hpIXBR0yF0m0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811545; c=relaxed/simple;
	bh=ZNzLfgoiBUiPnmURwe4l4gQiwwhubz5ct6+dOt32x84=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LoA/fvmPYMH0vc4ZruyuPQ1ouWJ+OXSv/19/hanAosl+2JFhFimjsiQvxQ1szp/J+HrNvLbluKu0KiHnn1ra6YTVe/8EgrQLitbkFDmrzutQI04xgUCuK76l1KzcM1uD6nc6/yBuext9wetyouoHNvQfH4vWTUqBybfQ96JWwr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZM0t9cra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055FEC4CEE2;
	Wed, 16 Apr 2025 13:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744811544;
	bh=ZNzLfgoiBUiPnmURwe4l4gQiwwhubz5ct6+dOt32x84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZM0t9craahWfrtAir/7j7qxa/8AjgwSvbdJ7Lk1+5ZYVqsiMyXvHBUs7DnQGJuFwS
	 oMVAEsUYajOE1LWAbSidFy+KsssuKv8k9VwRUQE+fTXorDXTIIK1ORHj0Y+NEof9v3
	 uKKX6625d0MGTdg4u6WebXNRcA1TWUfiZMOkDESJ1q7goPsnKMjNTFIs9btTP7lXFC
	 3MZlg0gyQp0LVQo9jKW/BzNWFEWfm8z5CXdRGFwVpgG2Kb9yCb/68saTcJ2r2WSKxN
	 7JJv5wQ3BPkl2C1TP03pDSxwi7esowEvCAtICS8mysNpXYU6VX1ka+2PdzWXmrtCBf
	 DeqfP67eHW1yQ==
Date: Wed, 16 Apr 2025 06:52:23 -0700
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
Subject: Re: [PATCH v11 net-next 2/5] selftests/tc-testing: Add selftests
 for qdisc DualPI2
Message-ID: <20250416065223.4e4c4379@kernel.org>
In-Reply-To: <20250415124317.11561-3-chia-yu.chang@nokia-bell-labs.com>
References: <20250415124317.11561-1-chia-yu.chang@nokia-bell-labs.com>
	<20250415124317.11561-3-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 14:43:14 +0200 chia-yu.chang@nokia-bell-labs.com
wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Update configuration of tc-tests and preload DualPI2 module for self-tests,
> and add folloiwng self-test cases for DualPI2:
> 
>   Test a4c7: Create DualPI2 with default setting
>   Test 2130: Create DualPI2 with typical_rtt and max_rtt
>   Test 90c1: Create DualPI2 with max_rtt
>   Test 7b3c: Create DualPI2 with any_ect option
>   Test 49a3: Create DualPI2 with overflow option
>   Test d0a1: Create DualPI2 with drop_enqueue option
>   Test f051: Create DualPI2 with no_split_gso option

it appears applying this causes the tdc test runner to break,
could you take a look?

https://github.com/p4tc-dev/tc-executor/blob/storage/artifacts/79725/1-tdc-sh/stdout

