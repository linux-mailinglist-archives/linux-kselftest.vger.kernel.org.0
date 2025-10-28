Return-Path: <linux-kselftest+bounces-44199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5222BC161FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 18:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072071C22C75
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 17:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FDB34B185;
	Tue, 28 Oct 2025 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqfXOpiD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220D3346E59;
	Tue, 28 Oct 2025 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672199; cv=none; b=oWENCxogkVo4suXd9RvCz9adVoB06Fzma5sEy/uPasrzwuvhNZJ7c9145zK+7+ryKH+MVOpV3+kQI6JskZ07ahA60N0LBUvS2n97bsiSx3MzPlCXxNxo1AvA0vauGyIQBOyNNJk0IyT76qVgfUwckn29ahjYMewVERd6xK36v8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672199; c=relaxed/simple;
	bh=oq3KFS5X77ckLv/fJl0ngTNLD/Vl72fwrFWYVkUHMkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ad5NVUYyzzVt7Th59bZmUXftxTty8/KHNEwreWJbu2276jWlSeEOQMliyWuMcXTSfHgy5bCjF8H49O6t0Ic99oJGuVUyNi4lGXaMFrPymTMz+bo5rrZkHoCRDJeoE3o9u7Xtl+AgBomUROCGbsoxcZpuRGblZ3r87zNfiVDSFL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqfXOpiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AAEC4CEE7;
	Tue, 28 Oct 2025 17:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761672198;
	bh=oq3KFS5X77ckLv/fJl0ngTNLD/Vl72fwrFWYVkUHMkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZqfXOpiDY4STCngagg2sv2k2rnFpK+UWPbUHIK+dt8P6MzgS4DRgV25YaNKgOCvve
	 Su0UFGLsd+uEPyE+EMVYtj3KRlBQ3746NCyOKBlHZA5VOHo+FB9MDNBVPyOsJcdH7Y
	 dmeMlaTfoCur0kM4I/jj3GKPVeJjJD1sKIoBbAXe9UQKijP1UQEMkXuDv5+2oDzb6P
	 jo9MMAPBmcRcehVNk5L78uU/j94UjeZyHVCwR/oZiXkcNtYrPYQg48MBB6Ea7aw+ku
	 zLaTNLHz/KJscNIjbGcBxHkv6MFdywDsloOJ8QOBqfrqZ1a8U/lSLMNqyl3SMrnscg
	 ybFljRk2p5xmQ==
Date: Tue, 28 Oct 2025 17:23:12 +0000
From: Simon Horman <horms@kernel.org>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Xing <kernelxing@tencent.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftest: net: fix variable sized type not at the end of
 struct warnings
Message-ID: <aQD8AOZduY4Fit3k@horms.kernel.org>
References: <20251027050856.30270-1-ankitkhushwaha.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027050856.30270-1-ankitkhushwaha.linux@gmail.com>

On Mon, Oct 27, 2025 at 10:38:56AM +0530, Ankit Khushwaha wrote:
> Some network selftests defined variable-sized types defined at the end of
> struct causing -Wgnu-variable-sized-type-not-at-end warning.
> 
> warning:
> timestamping.c:285:18: warning: field 'cm' with variable sized type 
> 'struct cmsghdr' not at the end of a struct or class is a GNU 
> extension [-Wgnu-variable-sized-type-not-at-end]
>   285 |                 struct cmsghdr cm;
>       |                                ^
> 
> ipsec.c:835:5: warning: field 'u' with variable sized type 'union 
> (unnamed union at ipsec.c:831:3)' not at the end of a struct or class 
> is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
>   835 |                 } u;
>       |                   ^
> 
> This patch move these field at the end of struct to fix these warnings.
> 
> Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>

Hi Ankit,

I don't believe this change is correct.

I think that the intention of the code is the char arrays (buf and control)
provide the buffer space for the variable-length trailing field
of the preceding structure. Where we basically have a header followed
by data. But your patch would place the before the header.

-- 
pw-bot: cr

