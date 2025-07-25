Return-Path: <linux-kselftest+bounces-38000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6CBB122D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 19:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC551CC6795
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 17:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC7924503C;
	Fri, 25 Jul 2025 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/9Gmykh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA024A3E;
	Fri, 25 Jul 2025 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753463733; cv=none; b=kPGJucrYgSD38NqgSG1tM40rz+RUWk9bq/QMklQ5EpLcPTKaZVgDGxwsxCzRB/IO7YBwVZrAc7+XYF5nyC9Vtjio3gDQCM0IfERZc8gMPxP5q9XCUjaHPchFUYCFahoBU9XZ93Cl2QuW5sQOSK84CmaBEhpXHV+LWTw9n8cdNvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753463733; c=relaxed/simple;
	bh=YkAOTwkgSU8S5IAf/JPYEqkhQz8KoTsyAO4vK1HXBds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HUgIzL49/rcI/DggpBWItr3qgAwiXJRJPrAQoQVpHtMhLU6KvR5g4LzwXRt1jN3xseAvzQOWitcyVrx8iKyZKtqueTd5M9oaK8F0TyrRKXd3Q5z2gtjIk8NXA455eE/SPyqtffJbVG+nl+tFpiHehnvW4TqI2d0aFlkQrF686KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/9Gmykh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D84C4CEE7;
	Fri, 25 Jul 2025 17:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753463733;
	bh=YkAOTwkgSU8S5IAf/JPYEqkhQz8KoTsyAO4vK1HXBds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y/9GmykhCX26z2zIwt6ix4XZJenoSHpcqKNqlThVly+zB853nSKkE+WDom6X6G1GQ
	 hSr8U6RScke1aosl9R1/lmfRQcAxIhUMszWKMCD2qf6Rd5fN0Ws4kPH6tyLU2CzXFf
	 LB1ewMTSJCpja5jucAZqAbFbVbf9N6WkT+sqh+xIxyOjZdITrlk/a1akI/i6JlXsur
	 cmQKmkgjW83bwko9jotycB1IAZhhrlR/j2xL/eh1EwZRVS85Q3gj+UrToy7mocKNVq
	 2ExVE2gPBxqjy+T+oW/mK6eAZG4PcWD8bRuRyRPE+QLBmbAiE0Ac8ZTN4/0flcD4BF
	 wz35foTC3jY8A==
Date: Fri, 25 Jul 2025 10:15:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: Crediting test authors
Message-ID: <20250725101532.5a3bf75b@kernel.org>
In-Reply-To: <aIOzMLPiC8gN5t2Y@finisterre.sirena.org.uk>
References: <20250725080023.6425488c@kernel.org>
	<aIOzMLPiC8gN5t2Y@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Jul 2025 17:39:12 +0100 Mark Brown wrote:
> On Fri, Jul 25, 2025 at 08:00:23AM -0700, Jakub Kicinski wrote:
> 
> > Does anyone have ideas about crediting test authors or tests for bugs
> > discovered?  We increasingly see situations where someone adds a test
> > then our subsystem CI uncovers a (1 in a 100 runs) bug using that test.  
> 
> > Using reported-by doesn't feel right. But credit should go to the
> > person who wrote the test. Is anyone else having this dilemma?  
> 
> Usually I'd do a reported-by for whoever actually looked at the test
> system, triaged the issue and reported it.  Trying to credit test
> authorship separately to the testsuite gets cumbersome over time, tests
> get updated over time for a range of reasons (toolchain updates, adding
> more coverage, improvements in the testsuite's frameworks...) so it's
> often not just a single person.  Hopefully the testsuite is keeping
> track of things well enough so mentioning the test will point people in
> the right direction.

Ack, it does get murky overtime. Also with pre-commit testing there
usually wouldn't even be a bug in the tree to credit fixing. 

I guess we just had a lucky(?) string of very clear cut cases where
a good selftest led the maintainer noticing a crash in the CI, and 
fixing something.

