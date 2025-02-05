Return-Path: <linux-kselftest+bounces-25850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65104A28BC6
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 14:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F101888A6C
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96284126C18;
	Wed,  5 Feb 2025 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3ALcNab"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6367486346;
	Wed,  5 Feb 2025 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762519; cv=none; b=eyltRFNcVrNyygD3WaWT8A3Jsm+1WycW/B/YDLzdPviwOG0Cnb/7jxuJMPtPBkmn6f6hlVW4M5BslFcXtUOAQYqtehHKWFtTQppOgEASib1XAYLtvONRYicmiQ9UunEov+qB81Lk+JTW+JWvOqhS9JA0alf+Zp0f/+dvn9+1fj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762519; c=relaxed/simple;
	bh=Eit4wpHTldmUz+hvBDLdl3fo9uBj5JwPUKrdvRp6X9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHFR2PqM5wZRWWNris5b1saKNqz5xncKjJkjd69NNinQhdf5+5IQQ/9V5lallSchQNhQoPJeP639/SXlpslu4MQmsFedfupfYaaMhcgmuD7cE+UHiZjMZ5NrN8n3Lm1E+mhhvkJKYHZ2xgDQtnApkJlkBdE95W+yWtzGVElqaPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3ALcNab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC38C4CED1;
	Wed,  5 Feb 2025 13:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738762518;
	bh=Eit4wpHTldmUz+hvBDLdl3fo9uBj5JwPUKrdvRp6X9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3ALcNabbSG9ZIEbD49AG0RdNF0aOKRljiID18bZUK6SQ4g7muTvqODsU9XofPmAK
	 8DbNyIinzS+/ixgQJ1DEbGX+i/eTbeNgy1uUTR4bF1S3jjTyv5Mm/vHY/0ZMMeFHM8
	 I8XSAq0H3Tj069JsVWHJfjHYxYc56tHV1jy8eNVQYgMy8N2JdePHqFN8M9+u0fSmza
	 U+oN5/e9mcyHGOpYCeAxZa8PJN1jQnO1S4LFx/+JwRie5lbZfQZd3Tq0TSyUip0DFg
	 So0/h4iLcJBvqovU0U1+Zy9F3ssy6kgxi6bbxiiKjINy/+0s6I/jc4Pk95KGpp7koX
	 1Imo1p5wtHx1A==
Date: Wed, 5 Feb 2025 13:35:14 +0000
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
Subject: Re: [PATCH net-next v4 8/8] netconsole: docs: Add documentation for
 CPU number auto-population
Message-ID: <20250205133514.GE554665@kernel.org>
References: <20250204-netcon_cpu-v4-0-9480266ef556@debian.org>
 <20250204-netcon_cpu-v4-8-9480266ef556@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204-netcon_cpu-v4-8-9480266ef556@debian.org>

On Tue, Feb 04, 2025 at 03:35:16AM -0800, Breno Leitao wrote:
> Update the netconsole documentation to explain the new feature that
> allows automatic population of the CPU number.
> 
> The key changes include introducing a new section titled "CPU number
> auto population in userdata", explaining how to enable the CPU number
> auto-population feature by writing to the "populate_cpu_nr" file in the
> netconsole configfs hierarchy.
> 
> This documentation update ensures users are aware of the new CPU number
> auto-population functionality and how to leverage it for better
> demultiplexing and visibility of parallel netconsole output.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


