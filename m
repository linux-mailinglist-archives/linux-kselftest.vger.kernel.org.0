Return-Path: <linux-kselftest+bounces-13737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372BA9318AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 18:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640431C20F1D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 16:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5171CAB8;
	Mon, 15 Jul 2024 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rh5GkW1B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9121CAA1;
	Mon, 15 Jul 2024 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721061867; cv=none; b=gWAIO9FFwKaX8d0dYEvoEsxDRwBhZ27t9aG7SslYaOQzv759TqUzdqZQpIBI1Fyh05U64McbHOfn587J1trTeqaLUJq6qGkG/HQmHtm0Riz4amrK9oEcCHrLKJbySgGe+NNRA+HitiB9B94Pbes3zKCIqinIeNyI9JpnGz0M8lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721061867; c=relaxed/simple;
	bh=N2yjfoVVb62B5YRNRRgSE+eSyRPzWjGNcXyKTqao2k8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXVoflXF6SHX/pzYewlr8tqB/M3MDTHAR9WvZ6P6X9zZcXJP6GoxaDSnrk96ucNPXtLxc9RBrza/gTQ5NA2b0hy1xxJo+TUGGQ0gLGrSMoLCTBKLElYDfuQjXCeqz3nXe7y11B3WpAHWUuMe98i/8/+nTAFNHdPLKgQeoxcvvsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rh5GkW1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0D7C32782;
	Mon, 15 Jul 2024 16:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721061867;
	bh=N2yjfoVVb62B5YRNRRgSE+eSyRPzWjGNcXyKTqao2k8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rh5GkW1BZoh2ss+IFJ49QjqjRtf+ebEO5f23Veo6G1DfLHD3/6HyYMAM4Bt7Ffxt1
	 SSGgJt8hDW2Gn0sIFnfSUv8ue+uKNgHx1ZD1MiXL2chwDyI5Wq00v67f5YqJ/xObS2
	 YbY82b7f4ETwGfGaeNBy2bwOSRWz73jI+tEvsNP3fPHUjOQFJQkTzCwF2RUSxSzCm7
	 fbemzLiUzicOWj3qCPmnRPkhgJzqHbiBLN+/6jvxPyyH6SH7B3AkxtAaKN9h99rZbX
	 nyRABrToW6OVrc6XZvHZUPZ8v1Q/kDAtA4sric+NyBxV9AynO/zAOJymdVO1Bhj7Gr
	 xGdftpOLJ1/XQ==
Date: Mon, 15 Jul 2024 09:44:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: mptcp: lib: fix shellcheck errors
Message-ID: <20240715094425.73738ca0@kernel.org>
In-Reply-To: <7a1fea0c-1389-4867-aaec-0c0db01cb6c0@kernel.org>
References: <20240712-upstream-net-next-20240712-selftests-mptcp-fix-shellcheck-v1-1-1cb7180db40a@kernel.org>
	<20240713154614.653f30ce@kernel.org>
	<7a1fea0c-1389-4867-aaec-0c0db01cb6c0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jul 2024 11:07:26 +0200 Matthieu Baerts wrote:
> > Speaking of MPTCP tests - I added the connect test to ignored today.
> > Too many failures :(  
> 
> Sorry for that, and thank you for having ignore it for the 'dbg' runner.
> 
> This sudden regression looks strange. Our CI didn't catch this issue so
> far. It is only happening with the debug kernel config.
> 
> Do you know if anything has changed recently -- around the 11th of July
> -- on NIPA's config side that is not documented? e.g. more jobs in
> parallel, new kernel config? I didn't see anything that could cause the
> new issues when looking at NIPA's git log and the CI change log sheet.

The usual suspect on Thursdays is that we pull in changes from Linus,
it'd be surprising if there were major changes there the week of the
release but maybe..

> I will try to reproduce the issue locally, maybe it is caused by a patch
> that is in patchwork, but not in net or net-next yet.

I was going to mention Kuniyuki's patch but you discovered it already :)

