Return-Path: <linux-kselftest+bounces-48269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9526FCF656D
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 02:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 954493068DDA
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 01:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C065532824D;
	Tue,  6 Jan 2026 01:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCqur4U0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F711E0B9C;
	Tue,  6 Jan 2026 01:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767663883; cv=none; b=KryO/XElCmnHeZ27gFdmbEf12YzHgPm6wlGP8sGqxHL2Zg/d+5gSXhO8iDc62gZLUAcIaoM90Taz4I5xsMSRTcfljU8jKeRq93Bjx8BDym1c25LtGtKZKNJcNxYgvmKTHXzzmhlSytsP5wxyUPBm2udTAgH0U1dFunt7sZWako4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767663883; c=relaxed/simple;
	bh=r7h/E6pu39/bQDGTFo8XeGNce6Lh0fY3O0QRuQfOWUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPI1asGwigOKimaTAvb/M0zZTOvCi0SxxyVG9FjVYTjGIBZGjr4R067rH6479uJNfloiHjzzY301khUL+EHoWVF0QqB8cx0bHV/KZ6fLP33CHmT+ssOOisDr3Cqq/trqji8jHehoSCUyK6O+fF7bKnRdmHP+eTCVW3ze/ni7cuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCqur4U0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023CFC116D0;
	Tue,  6 Jan 2026 01:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767663883;
	bh=r7h/E6pu39/bQDGTFo8XeGNce6Lh0fY3O0QRuQfOWUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YCqur4U0Bcnwdi8bayphJimZoLJ5u1MRBcBJJ0m5Lj9AhIKezlUrBxPnW53nIxVUi
	 m+HtOIBFVxgeQpJLmDz6KPhemEXBeu8oV57LLLU9Jf9M29Er5w3EIoEg/UOwq1Mc+E
	 9vrrqw9R3xLb9tdWDSqYkjlsavSM3EH7xH3xcIEfqOpeC6bcr0soTxShDNrMPGGh2J
	 4DxoVda/HPaDWy37Hu0j9I7zReeHsI5C0y1I3TWdXrub6Ypf6URYiMA7lfY0GBEFCQ
	 yu7NPC26rI4SnfjVGGArtF8rKCRCKp57ZQdW3QnlcQ/dCBncH3YvTBrIZmkKK0EOFG
	 RCfqm1Lr2RQqQ==
Date: Mon, 5 Jan 2026 17:44:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Carolina Jubran
 <cjubran@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] selftests: drv-net: psp: Use first device
 when multiple are present
Message-ID: <20260105174442.055a67c5@kernel.org>
In-Reply-To: <20260105100424.2626542-2-cratiu@nvidia.com>
References: <20260105100424.2626542-1-cratiu@nvidia.com>
	<20260105100424.2626542-2-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Jan 2026 12:04:23 +0200 Cosmin Ratiu wrote:
> The PSP responder fails when multiple devices are detected. There's
> an option to select the device id to use (-d) but that's currently not
> used from the PSP self test.
> 
> Change the default behavior of psp_responder to pick the first
> device instead of giving up altogether.

We know what ifindex we expect to run against (cfg.remote_ifname)
we can resolve which PSP device it belongs to either in the C code
or in the Python script.

