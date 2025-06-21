Return-Path: <linux-kselftest+bounces-35537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576AAAE2806
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 10:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA35E3B3733
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 08:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDAA1C8629;
	Sat, 21 Jun 2025 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="fq9yjymJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2AA7FD;
	Sat, 21 Jun 2025 08:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750494883; cv=none; b=RKNOAUQX+aoE191Mc3PA6Bpk910EukZcWhmq1V/axu6w7AHXCMoGGGsoEjkJsyov5o1GzSRvnKsBzgOi5Mn8msQXv8lWvbIJk3AbrENzjDSS2rRjMsdAa96Shy1sv7Kd+d5HUJ/0Bb6szHapK2iLg+Rj+5dqUShQTBKdiEbsf2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750494883; c=relaxed/simple;
	bh=Sfdtifw6Zrv9FX17DlIP1vQunnFlVczaidXMG3mD3gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUJ5/CV5gSgexA75VUSNZKi0gae1n2PXDtj9rgKsExNlIbJ5ZDzumb29wsBPwz/gkeY6iB4VNA2sUgtzOfVJYIGqAZpmS7M274pzFZMJL9GShwSnPl54sQUIC1Xyhnr0jGapPprLkJydWMwLcsZFFd8AUfabhQLcATwKVWQIiHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=fq9yjymJ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1750494879;
	bh=Sfdtifw6Zrv9FX17DlIP1vQunnFlVczaidXMG3mD3gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fq9yjymJNwx/Sphq17qhiOjRbQ01MKOFX6gcnryqmrjPieV7i2e9YBx6PM9kOVhT3
	 B2Sym51+mV4MKaHcQhf3bCbtdYFbBQ+PMZQXTBawGkkvts5izu2X1PcA4TKtlY/l8O
	 Uj/uHVmUHM94pCzLW9QgXOhaUE6YR5wCgUoAgzlI=
Date: Sat, 21 Jun 2025 10:34:38 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] selftests/nolibc: rename Makefile
Message-ID: <20db87b0-05ff-476b-a58f-d0945bfacf20@t-8ch.de>
References: <20250620-nolibc-selftests-v1-0-f6b2ce7c5071@weissschuh.net>
 <20250620-nolibc-selftests-v1-3-f6b2ce7c5071@weissschuh.net>
 <20250621041421.GA26603@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250621041421.GA26603@1wt.eu>

On 2025-06-21 06:14:21+0200, Willy Tarreau wrote:
> Hi Thomas,
> 
> On Fri, Jun 20, 2025 at 11:39:32PM +0200, Thomas Weißschuh wrote:
> > The nolibc tests are not real kselftests, they work differently and
> > provide a different interface. Users trying to use them like real
> > selftests may be confused and the tests are not executed by CI systems.
> > 
> > To make space for an integration with the kselftest framework, move the
> > custom tests out of the way.
> > The custom tests are still useful to keep as they provide functionality
> > not provided by kselftests.
> 
> I'm wondering, what prevents us from merging the new rules into the
> current makefile instead of renaming it, especially considering the
> fact that we initially took care of not confiscating the "all" target ?

We'll have conflicts around CFLAGS, the nolibc-test target and probably
other things. It will also make everything harder to understand and may
break unexpectedly in the future.

> I'm asking because: 
> 
>   $ make -f Makefile.nolibc help
> 
> is clearly less convenient and intuitive than:
> 
>   $ make help

Is your issue specifically with the help target?
We should be able to show the help message from the main Makefile with a
hint to the Makefile.nolibc.

Another, more general, possibility would be to move the special Makefile
to tools/testing/nolibc/ and keep only the selftest parts in
tools/testing/selftests/nolibc/.

