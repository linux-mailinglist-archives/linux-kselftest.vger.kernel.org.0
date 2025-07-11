Return-Path: <linux-kselftest+bounces-37061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0849B01265
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 06:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D548761014
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 04:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE6272618;
	Fri, 11 Jul 2025 04:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ZzqJq1pb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB06A59
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 04:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752209454; cv=none; b=MT4fi1QA/WuFOVd5k4hZ9hO3upGC0az3176QeZXnhLUHUtJBu7ketbIhQUjMlzOFQqdTdSYo8TxvRTtJiPhhlBQ+Z1cwbvX468yAPlILHwSJualPCsuiwcmxSW6sUjCBa5A9iM0cUchZr4Z1cEInrE23OvKwJ3EaqliUHtg+sug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752209454; c=relaxed/simple;
	bh=RMqT2MkLdBrNxpkx2hujvdCJEeHGoiJG5wl9GcwKOKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjypgrDyJaO/+MwP5mxt/3pEOv0/XGNUr/aWrEvLScjrmn29/Qz31JB9uvTwjh2f282UOYOpOBTpBpO7Ld6KVHfPxNdgjAJtsYSuuNccGFVWfTPjr/1GHwwFevVIeX5dgU4qjpqbUAG8IBdKjoXI3LnZAgU2FLqL3ANGdZgUHnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ZzqJq1pb; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1752209449;
	bh=RMqT2MkLdBrNxpkx2hujvdCJEeHGoiJG5wl9GcwKOKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZzqJq1pbekRQaNaElPxzeVPorwPVlc4inlhIC0KBNdij3aQ56oEpOy0RbhI8Qe1h1
	 wvNqCgiCRDPEM3Cn+aB+9/sXQTX0MOvQS571UEIP/BP6Vv9M165yQ7AJNSXZbFHUYU
	 kUgUj9B162NPCVX6/LAcUuBaJeXsdXafmbCgnQ1M=
Date: Fri, 11 Jul 2025 06:50:48 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: Willy Tarreau <w@1wt.eu>, linux-kselftest@vger.kernel.org, 
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v2 2/4] selftests/nolibc: validate order of constructor
 calls
Message-ID: <0704a213-5ce4-4f65-a5f0-500b1c7b6fdd@t-8ch.de>
References: <20250710103950.1272379-1-benjamin@sipsolutions.net>
 <20250710103950.1272379-3-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710103950.1272379-3-benjamin@sipsolutions.net>

On 2025-07-10 12:39:48+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> Add new helpers to track multiple steps as bits in an integer. Store
> each step in a bit and use the lowest bit to store whether all steps
> occurred in the correct order and only once.
> 
> Use this for the constructor tests.

We actually stopped validating the constructor execution order in
commit a782d45c867c ("selftests/nolibc: stop testing constructor order")
Sorry for my misinformation.

I think we can keep the scheme for the signal tests.
but I would prefer a function instead of a macro.

(...)

