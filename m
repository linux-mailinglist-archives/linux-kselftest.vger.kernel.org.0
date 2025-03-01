Return-Path: <linux-kselftest+bounces-27969-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB659A4AC99
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 16:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C8C1897D6D
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 15:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995C81E5201;
	Sat,  1 Mar 2025 15:45:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74CE1E25E8;
	Sat,  1 Mar 2025 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740843903; cv=none; b=pGukdrS4629SY5OTgkKqRf56+Z9RgC5/aANTICmFHcamK9X88ULUPyjw9ggHTt4vkPUNvwJ3rczIbmfPf63Dz90aYopb7CLnCSofOQs56WyrwrczHulGLX371VWLFI55ImZtm+5IIYt4YEBDtL/c8XKDUiLsU9M+2U6EE3w73ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740843903; c=relaxed/simple;
	bh=AxCGcINpX2kj7bTQ/vHykT9MgArIaG7SUtRbc3myy0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmJvFwvHIFi6zIF3+VfEaDsLu1xz1LbggP4vcYsG9N4HF2s8JegHYMgTo6ZEq5YBqIGim02HJ/ZCTZDjZ9jpnhG7KwGQfCBQfUvgAJ/HwiMph4MefOkwsmH1tUlwy6EffiCdFcKtHozcpI+T9EZJGTR0GpQ+HmrCd6bIhO7Plik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 521BL2An019006;
	Sat, 1 Mar 2025 12:21:02 +0100
Date: Sat, 1 Mar 2025 12:21:02 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v2 0/4] tools/nolibc: MIPS: entrypoint cleanups and
 N32/N64 ABIs
Message-ID: <20250301112102.GB18621@1wt.eu>
References: <20250225-nolibc-mips-n32-v2-0-664b47d87fa0@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250225-nolibc-mips-n32-v2-0-664b47d87fa0@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas!

On Tue, Feb 25, 2025 at 06:02:34PM +0100, Thomas Weiﬂschuh wrote:
> Introduce support for the N32 and N64 ABIs. As preparation, the
> entrypoint is first simplified significantly. Thanks to Maciej for all
> the valuable information.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - Clean up entrypoint first
> - Annotate #endifs
> - Link to v1: https://lore.kernel.org/r/20250212-nolibc-mips-n32-v1-1-6892e58d1321@weissschuh.net

OK I tested this series on my glinet (MIPS 24Kc, XARCH=mips32be) and
it worked fine, confirming that the stack alignments were not needed
and that the cleanup is quite welcome!

Tested-by: Willy Tarreau <w@1wt.eu>

Willy

