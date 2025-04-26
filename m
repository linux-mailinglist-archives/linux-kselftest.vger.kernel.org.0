Return-Path: <linux-kselftest+bounces-31703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B6CA9DA46
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 13:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22FE07B2CCF
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 11:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19C91A3145;
	Sat, 26 Apr 2025 11:01:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A428F6F;
	Sat, 26 Apr 2025 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745665271; cv=none; b=MlDD15ivHZfbDr6ec25bgpwts5sz87ILjZUTVL7WjbBlhU68fY010wzv0cHbLWkfDZUkaxtDgNwXYcUMIYp/3MDPa5GRTk/NbAJ5WlIfPgu8wBqwaZGNpMcJRnMDnGVb9MBUsT7bxj0//0WlF4ahmaXWOHj8CyL6W6K1ohAwl84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745665271; c=relaxed/simple;
	bh=WFSvkB9karM+lRXK/R8Tpp6vD/UvYdCIcKFGodqbfmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRP2GlInqznSc4cz42ksU4nH1nSrNi1u2unvtdwxa/WjLHGHGZmctT2FHqcHG6zB2hz8JagolV1+dwwxbPjxkgNDbcjCJj9iaJOSJd9sAkfPQseSLJDB1y1GN/iEvXtJsFQAHjLPE6g8YfkvpZjAFc3OOoE3tH56gDMn5j2pQNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 53QB15Nk018858;
	Sat, 26 Apr 2025 13:01:05 +0200
Date: Sat, 26 Apr 2025 13:01:05 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/15] tools/nolibc: various new functions
Message-ID: <20250426110105.GG17549@1wt.eu>
References: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas,

On Wed, Apr 23, 2025 at 05:01:30PM +0200, Thomas Weißschuh wrote:
> A few functions used by different selftests.
> Adding them now avoids later conflicts between different selftest serieses.
> 
> Also add full support for nolibc-test.c on riscv32.
> All unsupported syscalls have been replaced.

As usual, the series looks overall good to me (and I expect it to be
quite useful). I sent a few reminders about not forgetting to include
"nolibc.h" from the other series into the newly added files, though I
guess you have these in mind anyway.

Regardless of the small comments, you can take my ack for the whole
series: Acked-by: Willy Tarreau <w@1wt.eu>

Thanks!
Willy

