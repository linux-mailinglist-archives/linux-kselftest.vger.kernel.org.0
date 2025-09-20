Return-Path: <linux-kselftest+bounces-41991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 988C5B8C49A
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 11:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E9F188F1E8
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 09:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD6C267AF1;
	Sat, 20 Sep 2025 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="JNMArAeh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144312D12F3;
	Sat, 20 Sep 2025 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758360627; cv=none; b=psPXwkGxAitao2l9+bTWqWScpQT+/ATxnwB8EvboHI4Sc26D8pAesmt2/AHowOwTjIl93VleduCYF226+O8HrSepC2zvRVqLHGPF0gRuQDk3HgV3AUyuTvJkqyUf0OBobDg6c6EcfCa+hIW+3YpWYeFt/4MAGEpX4/WTcmcY4yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758360627; c=relaxed/simple;
	bh=GLnIwTogMt9dz1kwCxTGJ3RmHIApQIH7+X2LKzdBoFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1/ZdE/hQPooFXbQ62G5qaoitiEX1scVbDefegIgtIZudxAtqXi+pmyeLc/b/MIAaQFKZ0NV+JCHeiqlbevKO3U1WPfuJB/K48M6PsZ7VlH1ZKtdX68jR245BW7TGrVEaERPEIljoK4vYzMHbFHCRtetpPcwBVtA+udyYfT9SQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=JNMArAeh; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758360623;
	bh=GLnIwTogMt9dz1kwCxTGJ3RmHIApQIH7+X2LKzdBoFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JNMArAehsQkJD49jzRd4dSNYcBLiTNkKtK3kTL/PixpbKul1oD8tMB2gZjYtMoZYi
	 FAQxOha3OSw2WSN6O2R386SbcJlJ5coR2yFAFfTbLyxGvl5RYVdBqq6IAhUiA6HvjP
	 Y5m0rDPtT8HrHlXUx2WKHEUM3Zjf1E8qGNsdblZI=
Date: Sat, 20 Sep 2025 11:30:18 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v2 00/11] Start porting UML to nolibc
Message-ID: <07b0f2d0-5dfe-49b0-9f86-28f90512dd4e@t-8ch.de>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919153420.727385-1-benjamin@sipsolutions.net>

On 2025-09-19 17:34:09+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> This patchset is an attempt to start a nolibc port of UML. The goal is
> to port UML to use nolibc in smaller chunks to make the switch more
> manageable.
> 
> There are three parts to this patchset:
>  * Two patches to use tools/include headers instead of kernel headers
>    for userspace files.
>  * A few nolibc fixes and a new NOLIBC_NO_STARTCODE compile flag for it
>  * Finally nolibc build support for UML and switching two files while
>    adding the appropriate support in nolibc itself.
> 
> v1 of this patchset was
>   https://lore.kernel.org/all/20250915071115.1429196-1-benjamin@sipsolutions.net/
> 
> Changes in v2:
> - add sys/uio.h and sys/ptrace.h to nolibc
> - Use NOLIBC_NO_RUNTIME to disable nolibc startup code
> - Fix out-of-tree build
> - various small improvements and cleanups
> 
> Should the nolibc changes be merged separately or could everything go
> through the same branch?

Both work for me. But only for the next cycle.

> Also, what about tools/include/linux/compiler.h? It seems that was added
> for the tracing code, but it is not clear to me who might ACK that fix.

Some files in tools/ are orphaned. In the past I got some reviews, included
the change in my tree and mentioned it to Linus in my regular pull request.

(...)


Thomas

