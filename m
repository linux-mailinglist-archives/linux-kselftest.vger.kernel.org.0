Return-Path: <linux-kselftest+bounces-25118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5681A1BA16
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 17:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C4E3ACF0B
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 16:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE33915573D;
	Fri, 24 Jan 2025 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rzos2lAh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F042DF58;
	Fri, 24 Jan 2025 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737735325; cv=none; b=Q5M4pmAj+SpwykbaoaYAAwudItlEi64DLwhp4Vp8XzDM6Z5uTOF3t2v+ygrMoayzfwc0RHV9GmoLHqTnpDR/1u2AsDolD/Pa2G/jiSWIV19DlBsZte76D6ZixF7L2A2pAXPufvc1oEqf+53QgZl7WEiB/B7kutcqZZuwOJan70E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737735325; c=relaxed/simple;
	bh=XKk921iT1ycJCAi72HAP/IDhPFC6FiidIqzy3Ma0iPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oejpoJdpi6MC0lOsxOZH+q4/s/yYTgvbWClABw6xDwXTT9Cv7VdtP/urkfTX9VuHX1GxbpRsr1ZbDh/ZAeYLmMxMdt77g4Os56yIUbXqIvV6Me1nIpJ5JMMXtx4RCRfVHtM0CrSxA7Nvz3EB99IIlcvL/7DWqi9WIa0oybbnFuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rzos2lAh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NYdZwc1mEFGgygecAgeJfpAi9eNP9tSUM87S4YHIDEY=; b=rzos2lAh10ygFsSNG+qEqBIW4m
	00uHthUmvsEl+mn2xYdeM6q50MFvUSEzcCfTfRXJZaI5FGcOI2c3pMPoyz67VpsGdDys0NDayJnVz
	Qn7e9gmBQqltYyMBFt8lA8VVPQ1PXLz+DRk55qGexUgjW7mtwzeS1gOfIQxCr46T+Pvg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tbMKs-007eBG-EG; Fri, 24 Jan 2025 17:15:10 +0100
Date: Fri, 24 Jan 2025 17:15:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, rdunlap@infradead.org,
	kernel-team@meta.com
Subject: Re: [PATCH RFC net-next v3 8/8] netconsole: docs: Add documentation
 for CPU number auto-population
Message-ID: <57392381-497c-49d8-9ad7-4b50c4939448@lunn.ch>
References: <20250124-netcon_cpu-v3-0-12a0d286ba1d@debian.org>
 <20250124-netcon_cpu-v3-8-12a0d286ba1d@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124-netcon_cpu-v3-8-12a0d286ba1d@debian.org>

> +CPU number auto population in userdata
> +--------------------------------------
> +
> +Inside the netconsole configfs hierarchy, there is a file called
> +`cpu_nr` under the `userdata` directory. This file is used to enable or disable
> +the automatic CPU number population feature. This feature automatically
> +populates the CPU number that is sending the message.

Biking shedding a bit, but to me `cpu_nr` is the number of a
CPU. However, you want this to be an enable/disable feature. Would
`cpu_nr_enable`, or `cpu_nr_auto_populate` be clearer?

	Andrew

