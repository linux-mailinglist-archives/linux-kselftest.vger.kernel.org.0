Return-Path: <linux-kselftest+bounces-48134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A935CF1265
	for <lists+linux-kselftest@lfdr.de>; Sun, 04 Jan 2026 17:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB2813005FCB
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jan 2026 16:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708C8276058;
	Sun,  4 Jan 2026 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="O3kNMWk2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0803E225416;
	Sun,  4 Jan 2026 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767545005; cv=none; b=DLuvOQ69BV9ZKiXQmMdUPBQf0AXJ5U79IWm86p6CYaFW8zFEdKs1zQbmJPw4sbxkJ7tLdfTK2mC74K2Bc8zCTEEbkx2Z3F2GzooGzIWHHmuFdvIsM7Vdprpki/sIpP2edMUjgAeGrMqduPhaoeCJIlL9n1OzjSUvmzfQtWc6aNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767545005; c=relaxed/simple;
	bh=RJtPj82cLrhAo/WE4qPkxx84AjITt/kMQ1OcmbMqIfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVWSKOiHkwDk/6yxWXUmbnS6Wh7sHvA2YK/6G63L1ry8CtN03YLwoxIC3nOLki3Rn4e+TDC2yYn+WsKL5BA7rGfblA+9MqMfrrfCnlm3YLLh4tnijTRbk78pQcDhRMOz3MwFcnYhJXdVoHu77G0tcVsih4Wc5Cjh8OziyDXNgPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=O3kNMWk2; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1767544998; bh=IN6eADgVnrbtPfjJtvD68rBKBtu9ik/eYLye05j8PyQ=;
	h=From:Message-ID:From;
	b=O3kNMWk2v84QpiHSlhbybbO6rLa9jgDlZ7qURQ/ubxeaXwEe046/9IWe97Y/AFk+E
	 bVwky8dP3LseQSW4A3VtwK4raP+FmqcRB2Uj99cnBHGp6fbk5mIhPtP93hErFqIOCr
	 +O7+0x6lZg3x6EcXgFUBmtYReULPhZk/B4rAE/k4=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 34EEFC0943;
	Sun, 04 Jan 2026 17:43:18 +0100 (CET)
Date: Sun, 4 Jan 2026 17:43:17 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: drop NOLIBC_SYSROOT=0 logic
Message-ID: <aVqYpdCpD8jAAA2X@1wt.eu>
References: <20260104-nolibc-nolibc_sysroot-v1-1-98025ad99add@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260104-nolibc-nolibc_sysroot-v1-1-98025ad99add@weissschuh.net>

On Sun, Jan 04, 2026 at 03:57:51PM +0100, Thomas Weiﬂschuh wrote:
> This logic was added in commit 850fad7de827 ("selftests/nolibc: allow
> test -include /path/to/nolibc.h") to allow the testing of -include
> /path/to/nolibc.h. As it requires as special variable to activate, this
> code is nearly never used. Furthermore it complicates the logic a bit.
> 
> Since commit a6a054c8ad32 ("tools/nolibc: add target to check header
> usability") and commit 443c6467fcd6 ("selftests/nolibc: always run
> nolibc header check") the usability of -include /path/to/nolibc.h is
> always checked anyways, making NOLIBC_SYSROOT=0 pointless.
> 
> Drop the special logic.

I think that it was historically needed when we used to build by doing
-include nolibc.h but now that we've adopted most of the common headers,
we no longer build that way and instead use the sysroot, so yes, let's
drop this.

> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Acked-by: Willy Tarreau <w@1wt.eu>

Willy

