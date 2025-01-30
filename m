Return-Path: <linux-kselftest+bounces-25421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28037A22BD4
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 11:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC721641B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 10:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FA31BD9D2;
	Thu, 30 Jan 2025 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdxOvKJj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D481BBBCA;
	Thu, 30 Jan 2025 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738233544; cv=none; b=t44WNsLo5omw6O59mE4lAjd8qx0uJclUILJfhnOFp7MXwqKdWp61nTrCNA3sr7Iy7gW85mYl2VWKbQ/kr33PPSacWS+ZnRyeiNTAWAeFmQXaXaMivHuhYHUOf4EL8mkQUsdjQfcKhn2y+YqJYK7GRmzHN8sUs0Tc6PNlHghs3Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738233544; c=relaxed/simple;
	bh=LvSII04X7zOMuP6J608LzW2neZRowR1nu/QbLKMxKBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaoJsIuMpVlslUv7n9qasKLelXXz/aWpUGIR4eZeOLQ/+c/X/Q9U+Z1pv0kpz+j5R9ykgdknjrU1JOrZmr2Hj0G9S90Zf9lE4tKUhHfYdp0r60cNjYvR4vvIn9zQONixz2NfwyORfpZM84xLSuRBoTGt4evzkwBVj/BGx3gs5IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdxOvKJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F14C4CED2;
	Thu, 30 Jan 2025 10:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738233544;
	bh=LvSII04X7zOMuP6J608LzW2neZRowR1nu/QbLKMxKBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mdxOvKJjm+ivGqcQgf0OdZdjqWu3Q5/HaXlqaIJY1drO9VxWVL0IbU1lLfiU/g0wN
	 rsM2n3rxSICw8SGdhuTMottVWOX2NCPObSCSQsNnZ/gwph52kHghx0idEOhStloCy+
	 +SAUF6JHEmvdSDhpduv///cRU5bG+JMAjkQyJB323jl4Dvla7jQg9ZAT7mmSvYeeq9
	 BED5DRAXGevi08H7f98LtWqJJPfRo/qya3HuqMvcs4EaSJfaruOQEz0ap9bxy3tnRY
	 kXWHf2O1UB8bengX7GlUrYQxDB85ZAtN3E0MbSeXCONNvJFgUx4Nj9ELJqPTStwCfG
	 aQHCMQs2lowrA==
Date: Thu, 30 Jan 2025 10:38:59 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	rdunlap@infradead.org, kernel-team@meta.com
Subject: Re: [PATCH RFC net-next v3 7/8] netconsole: selftest: test for
 sysdata CPU
Message-ID: <20250130103859.GK113107@kernel.org>
References: <20250124-netcon_cpu-v3-0-12a0d286ba1d@debian.org>
 <20250124-netcon_cpu-v3-7-12a0d286ba1d@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124-netcon_cpu-v3-7-12a0d286ba1d@debian.org>

On Fri, Jan 24, 2025 at 07:16:46AM -0800, Breno Leitao wrote:
> Add a new selftest to verify that the netconsole module correctly
> handles CPU runtime data in sysdata. The test validates three scenarios:
> 
> 1. Basic CPU sysdata functionality - verifies that cpu=X is appended to
>    messages
> 2. CPU sysdata with userdata - ensures CPU data works alongside userdata
> 3. Disabled CPU sysdata - confirms no CPU data is included when disabled
> 
> The test uses taskset to control which CPU sends messages and verifies
> the reported CPU matches the one used. This helps ensure that netconsole
> accurately tracks and reports the originating CPU of messages.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


