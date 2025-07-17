Return-Path: <linux-kselftest+bounces-37505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A340B08FB8
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 16:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE941C424CA
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 14:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159662F85DE;
	Thu, 17 Jul 2025 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0A267dBE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ADA2F85D9;
	Thu, 17 Jul 2025 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763311; cv=none; b=mP7XivaYWCsYaOBphHhESk5p+C5Il3SOMrLtHWDSZujcX5pVBHldiX6+syT8PXMdXR5fK4r8R6ZLrBXIrulhgPcM4QPZZeXXTQPLN79Ff5sEg5fFzVisAyXtGMAHDuDC6Q/aKqMUMldEEmEaMGirLiacw0T/DJqyvgImEfFQb5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763311; c=relaxed/simple;
	bh=shl5mc+3pjEn+7EjPopOq97cnbcU6JoJvh0tPIFrgEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Grsv274b6tgee4v/t8Md9FWnk4rlq/I7cynhaKeL5/7dRsJJh2jr4BDRFIyRwvT+tbBu4fGdsriB9fpgaMlQXgQcWQ6fKS2uz5MJIH4GuGXIA7eoVNQsMaWdaFkt7rK54ZCAkFDf+4RCpsC3XwtLVeVQzy9G7TO5E7PiZOwgWPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0A267dBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E46C4CEE3;
	Thu, 17 Jul 2025 14:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752763310;
	bh=shl5mc+3pjEn+7EjPopOq97cnbcU6JoJvh0tPIFrgEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0A267dBE7vemZhiEPHosuJpsNBvM32d8XRhSjmFdg9idvCFxpCzUedDDQYwJkWU3x
	 /XVIZAWlmvtPTdZkmYcO66xPSKS+JqKD5pUDpRXFFRybwOha4QByybhQx6bPRHu+fM
	 LhCihJPlY57XN7BS3CqE/pYDOcZKVBMSNHshhRu0=
Date: Thu, 17 Jul 2025 16:41:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, keescook@google.com,
	kernel-team@android.com,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH v4 0/6] binder: Set up KUnit tests for alloc
Message-ID: <2025071718-sharper-rubble-0441@gregkh>
References: <20250717011011.3365074-1-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717011011.3365074-1-ynaffit@google.com>

On Wed, Jul 16, 2025 at 06:10:03PM -0700, Tiffany Yang wrote:
> Hello,
> 
> binder_alloc_selftest provides a robust set of checks for the binder
> allocator, but it rarely runs because it must hook into a running binder
> process and block all other binder threads until it completes. The test
> itself is a good candidate for conversion to KUnit, and it can be
> further isolated from user processes by using a test-specific lru
> freelist instead of the global one. This series converts the selftest
> to KUnit to make it less burdensome to run and to set up a foundation
> for unit testing future binder_alloc changes.

As these were already in my trees, can you just send a follow-on fixup
for the difference between this and the previous version?

thanks,

greg k-h

