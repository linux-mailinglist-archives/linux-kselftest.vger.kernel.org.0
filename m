Return-Path: <linux-kselftest+bounces-25417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A48BA22BBA
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 11:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34E1C7A15C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 10:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA651BDA97;
	Thu, 30 Jan 2025 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUQz8W6g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E115C1BD9D2;
	Thu, 30 Jan 2025 10:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738233430; cv=none; b=RvL/paUmdDmaaf8tM8QxraOxctJfZdervjVO1ax7/NlVmbvdylas9u4S+QtIDK3kresNzCPXQPBzt+ptoI0cO9lSaFWpX6jqWz5M+rL9RMYOBBq9kcapCb5HUSrb3h8dC/qHNSJzqAMICZNEcTzfSan2eCXUBFMm5Yg2JcC5n94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738233430; c=relaxed/simple;
	bh=MmH+VIE6qePemyo2ut8bYbZthYoH4Ai/Zl6om9YqxAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5lotLCZA4r6MDcNnGRjFxPA1PZrTCsVChphV0NboQJrmOOEIVNgNdBLHzT43Dt29sJ/MPG1rxaaT5k8HXMOzGUSIbRCSCr+pDWGPEoaYMrKyqCUPkWCcxrbNx1NWQnlIIeImbvUVShvmpeBuJ5MP0ak9X5PvNg221Hs27K0LTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUQz8W6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EB3C4CED2;
	Thu, 30 Jan 2025 10:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738233429;
	bh=MmH+VIE6qePemyo2ut8bYbZthYoH4Ai/Zl6om9YqxAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SUQz8W6gJBLpJ8DhAPHXt/Rc4rwdgFj1nKnOk6IuHb7oN6VQHTMYliGOGpyGLvr0y
	 iZZOWim0/P8AEF4T2JeaMiTXuZDC+6ApmBskbuN1hY1gT4XNZh/Ss0ZjFlokVbE85Z
	 dq3QExwNBKpsI1oUDMm0tykKdvHU9NvPkJkCd2HHaavUtg5tTEj1+Pm1j4xd1w4LOF
	 g3iynj1ZuQLK1sJcHNKBksSouz/5ADE7CGJ1B7dYxavbExiSFHH7hxtwLn8/OMGWda
	 d5RaW7Hvgiqr5x0R7uRCLsSFnnctFOrnzslP4i9xExYjhP1S7VVTXu7jwqBUHzd5uF
	 QeHL1A1sk2R7Q==
Date: Thu, 30 Jan 2025 10:37:05 +0000
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
Subject: Re: [PATCH RFC net-next v3 3/8] netconsole: Helper to count number
 of used entries
Message-ID: <20250130103705.GG113107@kernel.org>
References: <20250124-netcon_cpu-v3-0-12a0d286ba1d@debian.org>
 <20250124-netcon_cpu-v3-3-12a0d286ba1d@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124-netcon_cpu-v3-3-12a0d286ba1d@debian.org>

On Fri, Jan 24, 2025 at 07:16:42AM -0800, Breno Leitao wrote:
> Add a helper function nr_extradata_entries() to count the number of used
> extradata entries in a netconsole target. This refactors the duplicate
> code for counting entries into a single function, which will be reused
> by upcoming CPU sysdata changes.
> 
> The helper uses list_count_nodes() to count the number of children in
> the userdata group configfs hierarchy.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


