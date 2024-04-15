Return-Path: <linux-kselftest+bounces-8009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 632708A593B
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 19:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9362C1C21373
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 17:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A330E1339BA;
	Mon, 15 Apr 2024 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWsGgs3m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323101332A5;
	Mon, 15 Apr 2024 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713202589; cv=none; b=dm8hfJ/rj9v8LmgKXAJWwVBRMb3+tQr05UxNs649RBEHZfrWFjg2ky7p52gtacJOmt4so7nROgeHAtoCyKfXLGuKciYitobSWwKbbqXdvYL+csGwBh6XM3jKZ8gg1DQDh+4Y2uWCuhP29HYZzHOL4hfWcjca1XH+PPK/oocbu3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713202589; c=relaxed/simple;
	bh=9c/6nGsYpdyI3XDbSniQ/VFDcF/43P3Dw6RdPQhOE58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9bGEvk13rQGYsSxM5YEb+JrKZIH30klYqYlYCZXOkImps/MSFnzxE4kVd2H3eIR/uuosdlumPvh55ANPW8XqLDz+fYJlDtpUctlFR9E80ndSIhBVWzhAAwGQk6zX5eHx2itcHFid7kXa5pbmT9VK7hL7dLSucDr06re3dZvFS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWsGgs3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F208C2BD10;
	Mon, 15 Apr 2024 17:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713202588;
	bh=9c/6nGsYpdyI3XDbSniQ/VFDcF/43P3Dw6RdPQhOE58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HWsGgs3mUq83KcXhHcloMTfmK4hfvev01Mzs4fAiodFkacQwulOun+yFrD+OwbB3h
	 wvAgOUaN/ehfUIOxXWiKuUmY/DFT2xLKYn6BrZxgGsQ50FyTrjo3yeCTs/RIQQwau4
	 p3m3Mg/0kJCprHCKH3gQrtCFQRWwp5NGyTjF/7WDPx/6nhr5p8IhBlbOi3Xob1ckgZ
	 ECWe559ykp9bfIc0eeZ66iOzKDZhdhU/b6fujQjwIcCkcimE826bD/ZL41wssm9468
	 AyQKjG8O4fLO16XfrlnpY7g2ilXZtKxZ7fBl0RjtXSSjK7staL3eIYhlq81fo9jNkP
	 dkDwMaBYyc/5g==
Date: Mon, 15 Apr 2024 10:36:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, petrm@nvidia.com,
 linux-kselftest@vger.kernel.org, willemb@google.com
Subject: Re: [PATCH net-next 4/5] selftests: drv-net: construct environment
 for running tests which require an endpoint
Message-ID: <20240415103627.5de1281f@kernel.org>
In-Reply-To: <661d47afcc6a7_1073d2941a@willemb.c.googlers.com.notmuch>
References: <20240412233705.1066444-1-kuba@kernel.org>
	<20240412233705.1066444-5-kuba@kernel.org>
	<661c0837eb5a6_3e773229499@willemb.c.googlers.com.notmuch>
	<20240415073109.57629e54@kernel.org>
	<661d47afcc6a7_1073d2941a@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Apr 2024 11:28:47 -0400 Willem de Bruijn wrote:
> > If I have to (:
> > Endpoint isn't great.
> > But remote doesn't seem much better, and it doesn't have a nice
> > abbreviation :(  
> 
> It pairs well with local.
> 
> Since in some tests the (local) machine under test is the sender and
> in others it is the receiver, we cannot use SERVER/CLIENT or so.

Alright.

> > > Use FC00::/7 ULA addresses?  
> > 
> > Doesn't ULA have some magic address selection rules which IETF 
> > is just trying to fix now? IIUC 0100:: is the documentation prefix,
> > so shouldn't be too bad?  
> 
> RFC 6666 defines this as the "Discard Prefix".

Alright, let me use Paolo's suggestion of 2001:db8:

