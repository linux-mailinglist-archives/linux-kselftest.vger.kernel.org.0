Return-Path: <linux-kselftest+bounces-34123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C65D1ACAA34
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 09:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00659189C0A1
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 07:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B26C70805;
	Mon,  2 Jun 2025 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ahVR6kUD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43102C3255;
	Mon,  2 Jun 2025 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748851051; cv=none; b=fnfayUEh2H65UKryK0jr1HtdZnfzP2b47xeyPzB9b9AXKM3vdSQyb2U2bX6dhRhaIjCnzU0ken0aMVcmhTAEWwqD0EZTXkn1YMtflAsQM2CcJqzhaOaooEsdYky6QunrBmENgLCiepPkeBmBnlcWEJYJy6o+rX8vwXtTFmGqvM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748851051; c=relaxed/simple;
	bh=x2N8/3IgmL2UzD7fyelcMMdDZAZcgyGD+CjcmBSBNxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxsccxVSW5H44opkPXpUeA7A3vWI1bV/wxgrqg8I+pfqYfY5QFXVNOBctHWUWOEIlItmEFYuKJVWLGogcG5FfCHWScwAflXnkaTXOTcjTiIdAxgLwPQReENFU2KohJWht4+nr8BknKeAs6O2EvTWpiJ1zdbml8RkbqKzU3EIm7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ahVR6kUD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x2N8/3IgmL2UzD7fyelcMMdDZAZcgyGD+CjcmBSBNxc=; b=ahVR6kUDW4IX/VYgbJMSYH4nGh
	94pje5KJ+LraDhD0TFQ7pZm4b3D0he0tKGcK6Dk7ZMh+nEv9JTpYfbgdY8z1A8Ra+871Yal9ZEUJM
	Ba6CMJjym/T3VTT6K6WUjpqaZErX1Izh6hPuv5veOm+fJjQqjw44t5LfqrdtjlMjF6wcBcmcIbJTA
	wtD73U7MXyXeXxK8ojnMvkQKjCDVlJylOrMaqnBoCFaSIXqkPelLeH2iRLmP4Udy5FBrveGQ0N6BY
	FZMlWDnSKMrwR/nziZ35wCzY7NQffyZyuKqfueZiiTW6GnfnMthg3010manTyM3d5CZ8Lvh3Ecbc7
	i1tKfBhg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uM02e-00000000bol-2ZLq;
	Mon, 02 Jun 2025 07:57:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B19173005AF; Mon,  2 Jun 2025 09:57:07 +0200 (CEST)
Date: Mon, 2 Jun 2025 09:57:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Alessandro Carminati <acarmina@redhat.com>,
	linux-kselftest@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ville Syrjala <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>, Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 1/5] bug/kunit: Core support for suppressing warning
 backtraces
Message-ID: <20250602075707.GI21197@noisy.programming.kicks-ass.net>
References: <20250526132755.166150-1-acarmina@redhat.com>
 <20250526132755.166150-2-acarmina@redhat.com>
 <20250529090129.GZ24938@noisy.programming.kicks-ass.net>
 <CAGegRW76X8Fk_5qqOBw_aqBwAkQTsc8kXKHEuu9ECeXzdJwMSw@mail.gmail.com>
 <20250530140140.GE21197@noisy.programming.kicks-ass.net>
 <202505301037.D816A49@keescook>
 <20250531102304.GF21197@noisy.programming.kicks-ass.net>
 <8C5E309E-03E5-4353-8515-67A53EC6C9E3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8C5E309E-03E5-4353-8515-67A53EC6C9E3@kernel.org>

On Sat, May 31, 2025 at 06:51:50AM -0700, Kees Cook wrote:

> It's not for you, then. :) I can't operate ftrace, but I use kunit
> almost daily. Ignoring WARNs makes this much nicer, and especially for
> CIs.

I'm thinking you are more than capable of ignoring WARNs too. This
leaves the CI thing.

So all this is really about telling CIs which WARNs are to be ignored,
and which are not? Surely the easiest way to achieve that is by
printing more/better identifying information instead of suppressing
things?

