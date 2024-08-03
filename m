Return-Path: <linux-kselftest+bounces-14760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A899468D3
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 11:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE30D281E4A
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 09:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1926214C58E;
	Sat,  3 Aug 2024 09:29:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B571ABEA7;
	Sat,  3 Aug 2024 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722677375; cv=none; b=JmVVoL9LfkGz078uvq1KgHqCI+ODGcTTe4FoVNO0GnXUwqCLZrCyBCwaqPO+VbWD+y9lmsWKOZQlqq/rRamw5HJUSogZ21xO3LQ/6h/tBaK8XlLwrgl0jExxJC0Nkapm81HkuLY7CTohN9yO4KtcLdCw2hZyEETeFqLKLsgtQp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722677375; c=relaxed/simple;
	bh=qPM8oCDn+ln0YXoMJjsFhYAfen13wAxUB5YdnMDPjDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2Tdn2CtOw7D+/5fM5E3xktmn4IJZlzfxzoPtxF6uTI/Yvxn57SMh2OP3jqfv2nAz/SDrjCGq6fw74ROyY1Cf87TIAmdkm4GfvSqAhIoZfD1f/ATMjyeySHeEmlmySCmCw8BllMiOqshPDgJnSw+V7OJeQtn55kUZXIHDvMwQ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 4739M4bY029195;
	Sat, 3 Aug 2024 11:22:04 +0200
Date: Sat, 3 Aug 2024 11:22:04 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 03/12] tools/nolibc: move entrypoint specifics to
 compiler.h
Message-ID: <20240803092204.GA29127@1wt.eu>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
 <20240728-nolibc-llvm-v1-3-bc384269bc35@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240728-nolibc-llvm-v1-3-bc384269bc35@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas,

On Sun, Jul 28, 2024 at 12:09:57PM +0200, Thomas Weißschuh wrote:
> The specific attributes for the _start entrypoint are duplicated for
> each architecture.
> Deduplicate it into a dedicated #define into compiler.h.
> This make the code shorter and will make it easier to adapt for clang
> compatibility.
> 
> For clang compatibility, the epilogue will also need to be adapted, so
> move that one, too.

I'm fine with the general approach, however I think that if we start to
add specific attributes and macros like this, we should prefix them with
"nolibc" to make sure they won't collide with userland.

Thanks,
willy

