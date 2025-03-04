Return-Path: <linux-kselftest+bounces-28186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FE6A4D5C0
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 09:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E6A3ADD5C
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CE11F8BAC;
	Tue,  4 Mar 2025 08:07:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076BF1EDA04;
	Tue,  4 Mar 2025 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075626; cv=none; b=ryOuqockGe49ydEInKI/tEOyjxoIB+IbUPg8Y06LhTt/aUL/lj8+eEJun5vUb97//WrtsxUScnkl6taihw95rT7slHbU1J3UBxBAje/kEU/m18jK+Zb7Tn97OB9d8MCYrdTZG2yLtfM5HkkAG0XWyuq5lLYKbnXvoazix/FtUZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075626; c=relaxed/simple;
	bh=pvGE4ls4yWHii0KYd69+xmdVGEiN9WOekxGD7T3b3mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHAJGLhiimcU11UkY834BUU4JaUUhWQtwHI+xpbuAP2E4UYE+6s1FY9nJsJcjSIcRRYa3AEU/hX2b2ow/Xh43LWORuGv2PEO7MKYXul076JtKs2A3+AdZqpNM+hBAY/4Wqmqee653QTmPcjH6gk07N21KCMuPZtNMSAuCxVvO0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 52486utX010241;
	Tue, 4 Mar 2025 09:06:56 +0100
Date: Tue, 4 Mar 2025 09:06:56 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/32] kselftest harness and nolibc compatibility
Message-ID: <20250304080656.GF9911@1wt.eu>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas,

On Tue, Mar 04, 2025 at 08:10:30AM +0100, Thomas Weißschuh wrote:
> Nolibc is useful for selftests as the test programs can be very small,
> and compiled with just a kernel crosscompiler, without userspace support.
> Currently nolibc is only usable with kselftest.h, not the more
> convenient to use kselftest_harness.h
> This series provides this compatibility by adding new features to nolibc
> and removing the usage of problematic features from the harness.
> 
> The first half of the series are changes to the harness, the second one
> are for nolibc. Both parts are very independent and can go through
> different trees.
> The last patch is not meant to be applied and serves as test that
> everything works correctly.
> 
> Based on the next branch of the nolibc tree:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git/log/?h=next

Really nice work, thank you, particularly for making the waitpid() and
printf() families more standard. Please accept my Acked-by on all the
nolibc parts. As usual, proceed as you see fit for the ones I commented
and assume the Acked-by for adjustments following the same spirit ;-)

Cheers,
Willy

