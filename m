Return-Path: <linux-kselftest+bounces-25512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 209A0A2483B
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 11:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C2B1886FEC
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 10:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5478713D619;
	Sat,  1 Feb 2025 10:19:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B267A935;
	Sat,  1 Feb 2025 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738405180; cv=none; b=UW3uWQYUle66GTypdb5RpMT9ruvzq1iVtp5bKl+m2RIGxI9MedzM9UJbE+8mVBGNbxNMG3JsDg+s/F8DPbKfl3WCR4pK5CihL08ShWwFa/KQ9YKcsdHNPAIAyoLHXsS+rlzGw44TYLEU11XmZK8uTK5KFpIiRfz5MLpRmGoFl/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738405180; c=relaxed/simple;
	bh=q8cvhYNBUGB+d+tGMp1fbYRWE3o9K7gtRqNzUW84DuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCNTIwYWnYGdLk5bem+RxN3mvt4az/AjiIe70vgJHVhAhGgd9tB3CqPCuFGg1Cxl/o4HEeP7Z690lJTnmHMN+VaOJYLWnlvuUoFpUmlHqHs9Ppwxn5Rb49A34n9hBcBOPDNUoNLY0SsybxHsjw3+feBbfxlO3zL1ljY4l86Y6NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 511AJVEa006617;
	Sat, 1 Feb 2025 11:19:31 +0100
Date: Sat, 1 Feb 2025 11:19:31 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH 0/2] tools/nolibc: support for 32-bit s390
Message-ID: <20250201101931.GF5849@1wt.eu>
References: <20250122-nolibc-s390-v1-0-8c765f00e871@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250122-nolibc-s390-v1-0-8c765f00e871@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jan 22, 2025 at 07:43:44PM +0100, Thomas Weiﬂschuh wrote:
> Support for 32-bit s390 is very easy to implement and useful for
> testing. For example I used to test some generic compat_ptr() logic,
> which is only testable on 32-bit s390.
> 
> The series depends on my other series
> "selftests/nolibc: test kernel configuration cleanups".
> (It's not a hard dependency, only a minor diff conflict)
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

I'm generally fine with the series from the nolibc perspective. I've
added Sven in Cc in case he wants to double-check anything, given that
he initially contributed the s390 support.

Acked-by: Willy Tarreau <w@1wt.eu>

Thanks!
Willy

