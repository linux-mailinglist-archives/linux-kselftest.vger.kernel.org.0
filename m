Return-Path: <linux-kselftest+bounces-25154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D721CA1C058
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 02:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 523EE7A117E
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 01:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A962045AD;
	Sat, 25 Jan 2025 01:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOrRYdoo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEEF157A72;
	Sat, 25 Jan 2025 01:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737769624; cv=none; b=q+tmvcqxrqqZb3YWJ4DNBURBIdSYlCMcs7yxfeQtuDbI2ddcgRRH2Ku8oNKXOWaqV1mmtOTQr3NsEif5+fyBLYOrbVB+mkpJvl51aFI6pZybSR0rtWLH4hmRMId5JlZqaImZceTQQVnj2s27Or3OD1nzuIWth/VuVrYm5q1hTpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737769624; c=relaxed/simple;
	bh=ZT6UxDBvwU2uW6R/61Z6wjqJ83bFy9oW/BsavLj4Nuc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GCqZMKQc8YNuTdAXdQlCPe75At4jmvMrrcCP6mb3MdKmnycbqrGPErRccx1lJqGBkQj4Ex901Xb1NWnWnBvysLDjeozr+eUBdA6mbaL+hpkquG7aBP7jvbXMj5FlTZJOvoel12+DcI/7AspqV7TDanxVpvMeaA3HAIaWBjVzHtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOrRYdoo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC2FC4CED2;
	Sat, 25 Jan 2025 01:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737769623;
	bh=ZT6UxDBvwU2uW6R/61Z6wjqJ83bFy9oW/BsavLj4Nuc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZOrRYdooZv2tWag03dg1wQLXNbDs5iC9WK9JFoL7ARofBk2TdMPmM/cVCnQ80UFrZ
	 TkEJ9GOddoX4hjaj4TuO49phHNzN8SxBAM885h+FbCscOD1wtfzQjlZhtGS6ud59Yz
	 18VJBaO3LA6p3ArqJ/KTs3gL1vBym3M6kEPqkUDWdH6irq7x2bqLlBM5ixwUfnS0/t
	 0++bLwEeW01P5uH1JXWSkQ3B2pn+27M2uIbTcpgUwF2Iv2BG2rNBE+/kBONFPU4ejb
	 xukta35nZ7rWBF72xWOuX5YNn0NkroitWne2UaqmuL7kPfWDQsmOD+4Ip7XrbxauQX
	 m7uRYh87Hz3mA==
Date: Fri, 24 Jan 2025 17:47:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "liuhangbin@gmail.com"
 <liuhangbin@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, Tariq
 Toukan <tariqt@nvidia.com>, "linux-kselftest@vger.kernel.org"
 <linux-kselftest@vger.kernel.org>, "razor@blackwall.org"
 <razor@blackwall.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "liali@redhat.com" <liali@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "jv@jvosburgh.net" <jv@jvosburgh.net>,
 "edumazet@google.com" <edumazet@google.com>, "horms@kernel.org"
 <horms@kernel.org>, Jianbo Liu <jianbol@nvidia.com>, Boris Pismenny
 <borisp@nvidia.com>
Subject: Re: [PATCHv2 net] Bonding: Fix support for gso_partial_features
Message-ID: <20250124174702.59c4b16b@kernel.org>
In-Reply-To: <b702b3c1caaa913905009296fa82e36fae264691.camel@nvidia.com>
References: <20250122135218.183578-1-liuhangbin@gmail.com>
	<40707a0ed22fa87dbe6b5e28d22fad586158675e.camel@nvidia.com>
	<fc63c005a8f2fd6a34a055c1ac484bc36869f8a8.camel@nvidia.com>
	<20250124073833.2b2e2f4c@kernel.org>
	<b702b3c1caaa913905009296fa82e36fae264691.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jan 2025 16:03:32 +0000 Cosmin Ratiu wrote:
> On Fri, 2025-01-24 at 07:38 -0800, Jakub Kicinski wrote:
> > On Thu, 23 Jan 2025 15:24:37 +0000 Cosmin Ratiu wrote:  
> > > I've sent another patch to suggest these changes.  
> > 
> > FTR this is not the normal way to proceed in code review,
> > please try to share your feedback rather than taking over
> > the submission (unless the original author explicitly asks
> > you to).  
> 
> Apologies, I didn't want to take over the submission, both me and
> Hangbin were simultaneously looking to fix this issue. I was about to
> send my fix when I saw his proposed one (this thread) and in the
> interest of expediting the solution, I decided to send mine in addition
> to commenting here.
> 
> Given that we were both fixing the same thing, would adding Signed-off-
> by with both of us be ok?

That's up to you, but keep in mind for the future that the discussion
on how to proceed has to happen before you post your own version.

