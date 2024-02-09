Return-Path: <linux-kselftest+bounces-4466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD6184FCB2
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 20:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10ED2873B6
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 19:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6DC82863;
	Fri,  9 Feb 2024 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ikk19bAT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA51324A18;
	Fri,  9 Feb 2024 19:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707506252; cv=none; b=l121sjxXyLMj9QxS2TtzpY12ufbC2YtxnCvJPVNbnlCPo3ejv2rEzumI5XNAS+mBfPQ+Le13ayIn2XzFdPalRT0tBP5NOiLiaM2vQS22mfZzn+QeWhHPR375AgK6wGHR26ZdFt4Q2kHUbxEcJDH5sY1gYu9bCxBBGC0IWF1AbPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707506252; c=relaxed/simple;
	bh=zaVJSnrROIb9+4Q970mflzhbcd1oZPVJap1y18HAbRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAajjpLPdjWYuWwC2E10Ep6KdNofDuUI0n+PhlLcT8P9Gv/t61BpoItEmJqmzqBZ3NWxU9a2ALaEeE6wurCtpzTPHXHhqQyabUUESsq+g331iu5fd9JOSgLqHTtgEhexPHvuX9SSkGQntdLHcqydp2TBgbSQaBpbGbabPLKNvq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ikk19bAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB2DC433C7;
	Fri,  9 Feb 2024 19:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707506251;
	bh=zaVJSnrROIb9+4Q970mflzhbcd1oZPVJap1y18HAbRs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ikk19bATF1B9VStsRKFpK+k5XF2U7gO+DK3ar7XWVue539ebhU6PfBcKlRmvlZdOn
	 IE02UeWr7hP+zfgaQEa30Cgww2/nz5Oe9XaWwhwItsF0sN+UCKVTciN5I+i4rnR9So
	 8j2NVO+rrCrLkX0Ot8JgccIPlZa1I5RQHneVZn++eZLrYDPorkyaGl9+VaO0m0zddq
	 QVbBFIBXHCWVnsWv9C0y7VUj77vdWFvG4rfUmzf7AmUGSggtl3vf3rktOzipinw70N
	 uuBFzb8yECqX0ffddOrn2WB1+4oCXIEpF8/ap0SHdQwCR+ygCoho7oGDptTi9+jvrJ
	 Ac6+x038YmWtw==
Date: Fri, 9 Feb 2024 11:17:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Shuah Khan
 <shuah@kernel.org>, Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] selftests: net: wait for receiver startup in
 so_txtime.sh
Message-ID: <20240209111730.5e67d9ac@kernel.org>
In-Reply-To: <ee9d2e224d063dc66070b060f716219c976759cd.camel@redhat.com>
References: <53a7e56424756ef35434bc15a90b256bcf724651.1707407012.git.pabeni@redhat.com>
	<5b768c89eb2992c22ca7016de9f90ff7d4eecd5f.camel@redhat.com>
	<ee9d2e224d063dc66070b060f716219c976759cd.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 09 Feb 2024 17:45:28 +0100 Paolo Abeni wrote:
> But I'm pretty sure that even with that there will be sporadic failures
> in slow enough environments.
> 
> When the host-induced jitter/delay is high enough, packets are dropped
> and there are functional failures. I'm wondering if we should skip this
> test entirely when KSFT_MACHINE_SLOW=yes.

By skip do you mean the same approach as to the gro test?
Ignore errors? Because keeping the code coverage for KASAN etc.
would still be good (stating the obvious, sorry).

