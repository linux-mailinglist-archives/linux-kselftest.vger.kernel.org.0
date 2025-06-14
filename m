Return-Path: <linux-kselftest+bounces-34971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DD2AD9900
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 02:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B096A1897AF8
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 00:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931E51FDA;
	Sat, 14 Jun 2025 00:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFMXuQUf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6513C2F;
	Sat, 14 Jun 2025 00:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749860034; cv=none; b=t/hj2mSyYh/AcVJHNzRaUCtgfuOedwnD2fDkZQb4Bak+RwPs6uOOrrIMPFtpCUWT0mGdT/Vcc0qO9AF0UK7ezXapqqfxSDPM9OJJnNhw4eHZ97WR8ZjlmDugzNxVnovUaWcd9QzvEKRo4z+ujEZ8cgR/2/7dDJ3ZtcfbllBgvtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749860034; c=relaxed/simple;
	bh=uRQlko0hah6kL4rD1ODXUd7mdNxSP44ELC8W/fDL34k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+BrwXlKJITCuf7awBisYWiN3COzs4q1qAw0Sy+cb75Cp6Ulx6o1d3UDLhen83IBtxDicI+rEl4Fx9AU2oQtSFufmmwVYPMWWYa/jVCOeECXeotA9d0MALZkA+5LZZuv1yVdDWOFGyAMTKoAEwRiQ+HhLt28KrlW2H+d+SpRR6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFMXuQUf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F239C4CEE3;
	Sat, 14 Jun 2025 00:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749860034;
	bh=uRQlko0hah6kL4rD1ODXUd7mdNxSP44ELC8W/fDL34k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DFMXuQUfXXCyLx5OzckE2kGvTppETbavIB7HaQabjmLyZhHYGdIbaslO/O9xXI55w
	 Fc1Tt9XS7AH9POUSIVuLV0WGjbxDb8Leo6uwEbcC50TA2/F22jGEeKz+Xiv74HMTUP
	 MuzVx0tbHUMJwDnTpuhWLOdOAuPj+r+FrkDkjwb9zyzP0t7rvnZYQpW8Enhlc7aHLK
	 llLPWGqzeJRdDrUrpqMRWZB7XjKTrq5sf5kqOEZYF1S9pmV1kArBxh0dRGtdXCaR8J
	 EP0jYY5ZSb/TKjcZNS6TIIjYgXOKsnzFMSTJeBTSvRE67Y12JGZVqqRhVGJt9bvGCX
	 mS5EvYOKkC21g==
Date: Fri, 13 Jun 2025 17:13:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: horms@kernel.org, donald.hunter@gmail.com, xandfury@gmail.com,
 netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
 jhs@mojatatu.com, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 andrew+netdev@lunn.ch, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
Subject: Re: [PATCH v18 net-next 5/5] Documentation: netlink: specs: tc: Add
 DualPI2 specification
Message-ID: <20250613171352.310a7594@kernel.org>
In-Reply-To: <20250613153725.7983-6-chia-yu.chang@nokia-bell-labs.com>
References: <20250613153725.7983-1-chia-yu.chang@nokia-bell-labs.com>
	<20250613153725.7983-6-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 17:37:25 +0200 chia-yu.chang@nokia-bell-labs.com
wrote:
> +        name: step-packets
> +        type: flag
> +        doc: L4S Step marking threshold unit in packets (otherwise is in microseconds)
> +      -
> +        name: min-qlen-step
> +        type: u32
> +        doc: Packets enqueued to the L-queue can apply the step threshold when the queue length of L-queue is larger than this value. (0 is recommended)
> +      -
> +        name: coupling
> +        type: u8
> +        doc: Probability coupling factor between Classic and L4S (2 is recommended)
> +      -
> +        name: drop-overload
> +        type: u8
> +        doc: Control the overload strategy (drop to preserve latency or let the queue overflow)
> +        enum: dualpi2-drop-overload
> +      -
> +        name: drop-early
> +        type: u8
> +        doc: Decide where the Classic packets are PI-based dropped or marked
> +        enum: dualpi2-drop-early

please wrap the long lines. yamllint is your friend
-- 
pw-bot: cr

