Return-Path: <linux-kselftest+bounces-42769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F85CBB902E
	for <lists+linux-kselftest@lfdr.de>; Sat, 04 Oct 2025 18:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DF424E333F
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Oct 2025 16:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73D327FD72;
	Sat,  4 Oct 2025 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWdo8JXm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA49262A6;
	Sat,  4 Oct 2025 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759596465; cv=none; b=Vmheci9PT2c5wv4O5tD8MrCKbo7D1yjlumyupXnI465ekSiX4QGk0h03fNa49wnVrh/x8KpxM3b4lV3Rh1+KY6OlEd5PEgGh3eEWWEh8JhbVWoxN5MaE12Y2+7GSfom8eBltFM2EgUJZ+DZKM8gLVPbfmCq5Tpf/t3Zvo/qS170=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759596465; c=relaxed/simple;
	bh=eJ8c0Nmkmrcpl0g1LaQmsdYWPAEaZnlyt5LVJhFmjcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRfPU1c+WNZEgTF9ABSWt5FuF6x8+QLGd7pqnwO3h7G6ID6uRaznpfJsV6EcJMuSM4TP2nVfTDpxRf0/gq92phLI97mD8RDZaBX1XCKqizMnuUAYllMbgSo+Nq3lJSHRqO0B+NeMhLf+gdorGWLwoIJlutjyvfzwg6C83aQxelo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWdo8JXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22FCC4CEF1;
	Sat,  4 Oct 2025 16:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759596465;
	bh=eJ8c0Nmkmrcpl0g1LaQmsdYWPAEaZnlyt5LVJhFmjcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CWdo8JXmgouc/6RXCRmp5UKjso9hYDRLZczuTCIajRc74DWnZaYT7ZnFvnCPrqIGF
	 mepy03Yzcu+Idrfax2F1mtxmB99joUn/DekLPvUlnJwa8MZ90Z6rkTZXy3M/IoCog3
	 054D3CytTFdXc7MJbz+5MrEodjUxYJquu2sYKueLFZOT4fXAXbd5VLZmizyKuz8/WY
	 a7WOK4u4sJNuOOU7bCj+7PVuOAIQo2raE1SEoHvqYFGWIFYBZ0042+xU0fFLmlnUol
	 dXyBa81lMeH1oke3c7aUki5wkHOvmXo0DZEoGQ8FEJ71KzVwIqFYMT333yJUu5w7f6
	 weu6RHoHVKb6w==
Date: Sat, 4 Oct 2025 17:47:40 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, bpf@vger.kernel.org,
	shuah@kernel.org, sdf@fomichev.me, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 5/9] selftests: drv-net: xdp: add test for interface
 level qstats
Message-ID: <20251004164740.GJ3060232@horms.kernel.org>
References: <20251003233025.1157158-1-kuba@kernel.org>
 <20251003233025.1157158-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003233025.1157158-6-kuba@kernel.org>

On Fri, Oct 03, 2025 at 04:30:21PM -0700, Jakub Kicinski wrote:
> Send a non-trivial number of packets and make sure that they
> are counted correctly in qstats. Per qstats specification
> XDP is the first layer of the stack so we should see Rx and Tx
> counters go up for packets which went thru XDP.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


