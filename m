Return-Path: <linux-kselftest+bounces-9022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 683288B5BA9
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 16:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999E31C20CE1
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 14:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C32F7E110;
	Mon, 29 Apr 2024 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGfpQb7v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8808745C5;
	Mon, 29 Apr 2024 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401842; cv=none; b=IDcxqqztUvqSbLI/EHELcP+yASJHPXQrPlS9dHE16C68qsHK/DQqzW9+A3iLeoPeIQrCFtvPDMSeO6rBvjRERcVnuVzGVsU9YtxNtrZmI4qrtMgFreXRGW/XiBdTrWkQPBlOoYfnGMX7MVsZhC4n9Q7A1Y6LmV48TUbx0diJtEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401842; c=relaxed/simple;
	bh=f/zyuqvJRLxvBVtrVUlxyhOWWeOQsE75kQN96zoTaJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0lILbZCvluudjGxR+3QC7KkTJvMl5ESGGxgiZSTtkeablp2MaBathacUG2PkZNmraVXt6JoqN5B1QJwDo8NDOgqxGPESxciC9taUciW42ul36kI6B80tktdcPboF7vitzvBOw+g7fp4PLQ46i+1f1/Cq/nTSufZkzrOldTd+zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGfpQb7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FBDC113CD;
	Mon, 29 Apr 2024 14:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714401842;
	bh=f/zyuqvJRLxvBVtrVUlxyhOWWeOQsE75kQN96zoTaJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EGfpQb7vZ9U2rKRbIRKWRF6YBevcHWA+uDr7JMwTW10VoWgt2bBhIwZ2pOok8O2OG
	 9taHRx0njU88UEFMOpyFQgoT51GVYk3oTJz79r0IQwN2JTl5dxNnkt+xmUOZt9X5fk
	 xd5PrJTMqfA59l/VW0DC0aIjWgMgvVRGFgtmhVd6ePNaOg8tdCRdbRorBeOq/+QFJg
	 exZUA9YkijA8lMq6RjFxUiovhf69mln3jnVykyZQARAhEsVIU8lJX4TRJChPVWMYgW
	 AzDplzCt+soD6jtz4hIHe7ZFNioJki43/i8lizkQ8woyZVXmiNj0Pir6MvRJME7xq2
	 YK/HTYpi9cJPA==
Date: Mon, 29 Apr 2024 07:44:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 3/6] selftests: net: py: extract tool logic
Message-ID: <20240429074401.78610666@kernel.org>
In-Reply-To: <662d02c524ef7_28b985294cc@willemb.c.googlers.com.notmuch>
References: <20240426232400.624864-1-kuba@kernel.org>
	<20240426232400.624864-4-kuba@kernel.org>
	<662d02c524ef7_28b985294cc@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Apr 2024 09:51:01 -0400 Willem de Bruijn wrote:
> > +def ip(args, json=None, ns=None, host=None):
> > +    if ns:
> > +        args = '-netns ' + ns + " " + args  
> 
> Minor: inconsistent use of single and double comma strings. Maybe
> there's a reasoning that I'm just missing.

I also need to coerce ns to be a string, it may be class NetNS.
v2 coming in 3... 2... 1...

