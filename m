Return-Path: <linux-kselftest+bounces-35642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0B5AE4E19
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 22:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650081888F5A
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 20:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8211FCFEF;
	Mon, 23 Jun 2025 20:24:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5311DDA31;
	Mon, 23 Jun 2025 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750710292; cv=none; b=ohgpg864F3KlshVy6CCRll4PAKmgQRlNsOJeIEkknEvJCogKWjs4viLW/06I/mpCxpupeEdnQdSULEajpR+DPmKJ9bi1ofmD94KM690iaAnnVHnU3Ldlw4h7xej08uTgHjo6JVfgr2rLXV8uOn7mTOrrxNOFljmCR+Rs6Kh4XlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750710292; c=relaxed/simple;
	bh=138x1mqWMUb+JBsCOaeXzkalzNvIx8qivTb237BPDzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcGgmq1RZyAsz3QPM+7l0/ZHppkrrD5jlyRE/9uzLPnWJ4uKOdjLY3VhZCGg8fGpkI1+corFuZ030xovaQLgxHGg6Z5nPkeOXVqCoJz+hfHKljJaVnln5m8ly60t1hNb0+6ULWwTWPLQoakGBQDBGFskh1+WXamcipfMMyr5UIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 55NKOgqf030320;
	Mon, 23 Jun 2025 22:24:42 +0200
Date: Mon, 23 Jun 2025 22:24:42 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] selftests/nolibc: rename Makefile
Message-ID: <20250623202442.GA30317@1wt.eu>
References: <20250620-nolibc-selftests-v1-0-f6b2ce7c5071@weissschuh.net>
 <20250620-nolibc-selftests-v1-3-f6b2ce7c5071@weissschuh.net>
 <20250621041421.GA26603@1wt.eu>
 <20db87b0-05ff-476b-a58f-d0945bfacf20@t-8ch.de>
 <20250621084739.GC26934@1wt.eu>
 <0084290f-49b5-4599-953e-0db6bf46e32c@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0084290f-49b5-4599-953e-0db6bf46e32c@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas,

On Mon, Jun 23, 2025 at 10:18:19PM +0200, Thomas Weißschuh wrote:
(...)
> > I hadn't thought about this, but that could indeed make sense. Let's see
> > later how it goes and let's not add burden about this for now. Please just
> > keep your patch as-is.
> 
> Sounds good. Could you give a formal Ack for the patch/series?

Sure, as usual, for the relevant parts of the series:

Acked-by: Willy Tarreau <w@1wt.eu>

Cheers,
Willy

