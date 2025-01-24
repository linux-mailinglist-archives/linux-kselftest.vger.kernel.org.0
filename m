Return-Path: <linux-kselftest+bounces-25115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1830A1B9E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 17:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DCE77A5886
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 16:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5E6189B83;
	Fri, 24 Jan 2025 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0toZ8F/1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6741E15B115;
	Fri, 24 Jan 2025 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737734563; cv=none; b=PKhDTbeUNexePdRyDs8NwmLGALBhBIgADD9TjHnd1AEN+XRM83ykxABaG/GuUuZzLZbLSmtQMUIbszFoE6fCDgk1SbrV5Qq/Q0Mi+zPSllV34mbaXtoiCmuuq2Djg0bNOz0j8+kzWXOHOCtrK5KI/KxZVNo5GPMhU4v16BRuOn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737734563; c=relaxed/simple;
	bh=0ki71HxVvSCZSv1mIBzD69znXugceEh1G+MwysoDmbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxxGCB01/UbO6lW0rr1G8eQfMyDLQjbwyiwcFzJSEulgeyWTAnJDLaO7XDgEBRigNbxkW1oa454X4jDZwyMSlikDXXsbfujUh64271Lzx7PDC3n6o3wJv1+Uk99uOdmREQUiOvxbWRY9EKkk7bVpQLPhAXVktA5tQZV9dmFts0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0toZ8F/1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h62wqjEGq/7EU5tZEbQtH/JsvhXqkKnKFjv59bZ1QFA=; b=0toZ8F/1+goTt2Kbe6EwtKyzE5
	mKbPFKSj59MVFKY7wCO5r2B4ghKOShuJmJWTyGYzFnVTFkdAe5QLNCoaxsP9EAl2bALsq1kHe+U3F
	EnikPXWJ5lFIHRkFLW5wDAHMTjX9ejNimpEi8yo0U9erpSaTKISiq8LoJBu+eghiKjiQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tbM8Z-007dvC-01; Fri, 24 Jan 2025 17:02:27 +0100
Date: Fri, 24 Jan 2025 17:02:26 +0100
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
Subject: Re: [PATCH RFC net-next v3 0/8] netconsole: Add support for CPU
 population
Message-ID: <d441f627-1686-40fa-80cb-e84c590b8b02@lunn.ch>
References: <20250124-netcon_cpu-v3-0-12a0d286ba1d@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124-netcon_cpu-v3-0-12a0d286ba1d@debian.org>

On Fri, Jan 24, 2025 at 07:16:39AM -0800, Breno Leitao wrote:
> The current implementation of netconsole sends all log messages in
> parallel, which can lead to an intermixed and interleaved output on the
> receiving side. This makes it challenging to demultiplex the messages
> and attribute them to their originating CPUs.
> 
> As a result, users and developers often struggle to effectively analyze
> and debug the parallel log output received through netconsole.

I know very little about consoles and netconsle, so this is probably a
silly question:

Why is this a netconsole problem, and not a generic console problem?

Can other console types also send in parallel? Do they have the same
issue of intermixing?

	Andrew
 

