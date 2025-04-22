Return-Path: <linux-kselftest+bounces-31282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF48AA96373
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 11:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E996E19E2AB4
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 08:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7359F1EF0BE;
	Tue, 22 Apr 2025 08:52:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24854190472;
	Tue, 22 Apr 2025 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311939; cv=none; b=tdHM/iXk0rXh5wr4q5Cz8k57e+VDlzf1JwEtpj2dCIQklU7Uu+OhhmwlfVyaUVkZCvpcX9t4pO9I2w2mftGSw63xl8k5nt7Cve8KYf8lenXAPY3SQQnK1g42vWpKyWXs7t97WrX8LgWGbZ1GwhWGTojECzVawzs9daTojjsTyVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311939; c=relaxed/simple;
	bh=MZ5VMK4SGWmA78u7/Eat5+osBUM2c/eqyHuqbe5cqQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grF3GyU2Mrm906F7JblddJd1mprtizt4eQZaKPkTsWE11DFlqQLdfOLp54ydBcx0+mKp9Jeh/eKhHGGrJ9jYqVTNbvjuwO4/1dsvK7Hj2cfMxfJmPbi4V1JCPB6/wNrJpiNY7DyTB4yxK86nvZ9a+182LZ0deCme9E3Id3r6JRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 53M8pjgi015153;
	Tue, 22 Apr 2025 10:51:45 +0200
Date: Tue, 22 Apr 2025 10:51:45 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 00/32] kselftest harness and nolibc compatibility
Message-ID: <20250422085145.GB14589@1wt.eu>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
 <20250422103612-64ea71dd-d51d-487e-b387-508c372af07c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250422103612-64ea71dd-d51d-487e-b387-508c372af07c@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas,

On Tue, Apr 22, 2025 at 10:48:28AM +0200, Thomas Weißschuh wrote:
> Hi,
> 
> On Fri, Apr 11, 2025 at 11:00:24AM +0200, Thomas Weißschuh wrote:
> > Nolibc is useful for selftests as the test programs can be very small,
> > and compiled with just a kernel crosscompiler, without userspace support.
> > Currently nolibc is only usable with kselftest.h, not the more
> > convenient to use kselftest_harness.h
> > This series provides this compatibility by adding new features to nolibc
> > and removing the usage of problematic features from the harness.
> > 
> > The first half of the series are changes to the harness, the second one
> > are for nolibc. Both parts are very independent and should go through
> > different trees.
> 
> I need a few nolibc bits of this series (snprintf() and prep patches) to base
> further patches on. For that I'd like to pick up all the nolibc patches from
> this series through the nolibc tree. They got Acks from Willy.
> 
> Any objections?

No objection on my side!

Willy

