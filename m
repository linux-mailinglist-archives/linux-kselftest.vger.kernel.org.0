Return-Path: <linux-kselftest+bounces-28419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6C6A552F5
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 18:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF813AF800
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 17:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E966725D55E;
	Thu,  6 Mar 2025 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jIgvtXXD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DFC2116F2;
	Thu,  6 Mar 2025 17:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281769; cv=none; b=nv38yt/QQTtDrGhGB95zP+cbEGx12/5ffRUOS0Aeh//dskjowiI55ZGhqZUweDhvg4MO5IJw4r+qPJwzAF6fn8szxQwxqolG5YL47lVP82JlhTXbEORj80Ucev2SyC9gjTussim+DVck/9oeedePq0MVoZ0kqIHvAAbaYdibP1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281769; c=relaxed/simple;
	bh=Uw0AQGHDrWkbA7FKay0iF5OuHaVk3LcXuluJk7ArVxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0px//jRxGOozYqgIkySE7u+kVx6uOmZCOsiL3/rHGC9xGN/5LQRaiw7C/+LntmkqZiT4wopPQJ5cZTxhIPlUdfiluz5nrPq/yqEqFgsbByncL8r8szmQqurMnnx4sqjoWJEchnGB1tCADM7eSTolIyyWgi/Gu+ysPSsvi4ETQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=jIgvtXXD; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1741281766;
	bh=Uw0AQGHDrWkbA7FKay0iF5OuHaVk3LcXuluJk7ArVxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jIgvtXXDYtL6dSt+yGQAPZSRU+71PA9X9pXFBGz4jGqbinU6uhWgYiHksujbvRevn
	 iFFsQpCo+9cBzXj0adSPUYBuseBXAyJ5Ltjh4ypgIsUzUPqXw8XdTdVuUap2OkyqDW
	 New+I0IvwBEHibVZQKdU/A3j99cetgPjo1K5DuvU=
Date: Thu, 6 Mar 2025 18:22:45 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Louis Taylor <louis@kragniz.eu>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/5] tools/nolibc: add support for openat(2)
Message-ID: <598c8370-507b-4d6f-bf7e-ce17a3b5dca0@t-8ch.de>
References: <20250304075846.66563-1-louis@kragniz.eu>
 <20250304081116.GG9911@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304081116.GG9911@1wt.eu>

Hi Willy,

On 2025-03-04 09:11:16+0100, Willy Tarreau wrote:
> On Tue, Mar 04, 2025 at 07:58:15AM +0000, Louis Taylor wrote:
> > openat is useful to avoid needing to construct relative paths, so expose
> > a wrapper for using it directly.
> 
> Reviewed the whole series, no comments from me. Let's wait for Thomas
> to double-check but for me it's OK:
> 
> Acked-by: Willy Tarreau <w@1wt.eu>

Fairly happy with it, only some tiny nitpicks.

> Thomas, since you already have plenty of changes in queue, do you mind
> if I let you pick this series ?

Sure.

Also we need to send a PR to Shuah soon.
I have some patches I want to get into it.
In case you missed it:
https://lore.kernel.org/lkml/20250305-nolibc-asm-headers-v1-1-f2053def2ee7@linutronix.de/
Also the removal of the constructor order validation.
Will you send a patch or should I?


Thomas

