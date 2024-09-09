Return-Path: <linux-kselftest+bounces-17555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3009725DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 01:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD28AB23131
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 23:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8F118E740;
	Mon,  9 Sep 2024 23:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FskxkQ0p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3B573440;
	Mon,  9 Sep 2024 23:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725925878; cv=none; b=snWrTjy+0gSwU+k/E/Th7dwxi4hCBK9rqccLixmL2B4L+iOzXMYcPrzEIZFa3KuhLfrt7rw8f0eQWdil7XDkcKPtoGm433A3vsmgTxxRdbQ/UNXv1n+WQANE0FFmII7Pl5VnaRhqDHxmPyuHw3nYEkWEkEFuPJ2lcbauBCPWWqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725925878; c=relaxed/simple;
	bh=Bf57Tu0bB6pnr8ksPMVcE0ThIaQWCNuSAh6WfkJ6Y/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OWkKW0Vc/Ojknzhy43PBA5rXDpSvLAjKcV9akvqivCC9GtlYHdkF7+2/FnEP5v2p9o2Iw8nUxprs+uqpu8KgccIDJErbR0oOs5OKSseyjErIUSOhNe8WmVvfhNCTGj5K0OsimHQehp5toIZMUy0OBXsfrzvmL4QGOXtDaNuJ11A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FskxkQ0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A19C4CEC5;
	Mon,  9 Sep 2024 23:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725925877;
	bh=Bf57Tu0bB6pnr8ksPMVcE0ThIaQWCNuSAh6WfkJ6Y/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FskxkQ0p1S2V4tcdZlRxr5cvGMtaMJbnffRDpvxcFKvx73cW3Cb6BJBUbC21dvcmM
	 hAH1azZpCXC9GKL9aFbgV1Hh0AML+cc8SsRL94LY36lWfjOwOyKMUXghhVjzG/Yb/P
	 EtqSSWb4TmSqezEi2lrUJVMVKjTjta6JNriC3AYWfzcdOgB2ei8jVUj+OCa2zZKNan
	 hhD3K6mA6y6d+PRt1xsStxzgDtgLT00s52OZ68OXpJLDBtZ1S7Xdc1myoPCibkOICH
	 oS7BvU48iF8ADZrBWQzGQ7IT5qEVCXOeM5CJ8DA4vz/NHdGBclxfir2bs+KjbrKylc
	 7stIeLFHf7pJQ==
Date: Mon, 9 Sep 2024 16:51:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Sean Anderson
 <sean.anderson@linux.dev>, "David S . Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Willem de Bruijn
 <willemb@google.com>, linux-kernel@vger.kernel.org, Shuah Khan
 <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: net: csum: Fix checksums for packets
 with non-zero padding
Message-ID: <20240909165116.1bdb4757@kernel.org>
In-Reply-To: <66df2fd2d6595_3bff929459@willemb.c.googlers.com.notmuch>
References: <20240906210743.627413-1-sean.anderson@linux.dev>
	<66dbb4fcbf560_2af86229423@willemb.c.googlers.com.notmuch>
	<9d5bf385-2ef0-435d-b6f9-1de55533653b@linux.dev>
	<CANn89iJaXgR6c+moGB5kX6ATbLX6fMP0mUBQN=SAsZfdz5ywNw@mail.gmail.com>
	<66df2fd2d6595_3bff929459@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 09 Sep 2024 13:26:42 -0400 Willem de Bruijn wrote:
> > This seems to be a bug in the driver.
> > 
> > A call to skb_put_padto(skb, ETH_ZLEN) should be added.  
> 
> In which case this test detecting it may be nice to have, for lack of
> a more targeted test.

IIUC we're basically saying that we don't need to trim because pad
should be 0? In that case maybe let's keep the patch but add a check 
on top which scans the pad for non-zero bytes, and print an informative
warning?

