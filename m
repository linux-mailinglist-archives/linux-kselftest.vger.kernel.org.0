Return-Path: <linux-kselftest+bounces-38001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDF9B122E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 19:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2263188A0C7
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 17:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0AA2EF2B7;
	Fri, 25 Jul 2025 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lzka3lbI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAA02749C0;
	Fri, 25 Jul 2025 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753464020; cv=none; b=UdLkaq8BjlkoKSSgWH5h/TtnCRbOsdEx1+7co/C9worbNqWidwieX4OvWXgR240+cAxJ20cITicQRaKpwvE2RN21Ss7H3umcVZi8mroR2DqOe80k2SUvHB5KMJGnCg7qBp3h6SBviaxFgFFyXxE5EadAtceso6t2KvFbBbkXfYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753464020; c=relaxed/simple;
	bh=hcYktODWynW3pJe6g3nLXywa3l7J+E0nqS4ffULCqdc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rg/dHMEuZVWz1ZPHjdCdUSZS7ALvbr2z+EYO3fHL0A38BkgljCpQbGnowI5uYFTzYdlzAvnHz/gWAKccmj9XCZcBoXqrYBXSA3UewZIRqk4RKNP7avJqnQukvGouPUAsnZDQopC/fi8RP4Ew1pO7P9YKvBh9b/4zkQnHdkSaaDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lzka3lbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6CBC4CEE7;
	Fri, 25 Jul 2025 17:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753464019;
	bh=hcYktODWynW3pJe6g3nLXywa3l7J+E0nqS4ffULCqdc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lzka3lbIp1F86Z9OvLVzuIJ2ABNh0nDCVNn4G8lhuB6OPxh2h2DY1PEd3Gc0Vyn74
	 qcSk04i5SUbaoYyG5OdBKIVVJD39X9R5RFc4Aha6+vXT6QvsWzbOlCHJqh7XQkz/3z
	 FusJ7oUVgXo8pTuZnu+IGA4JKSC9ZLrr2sG9yVURQIyVIj4XO2zQtWM5jKiD61JAJa
	 RzyK2YGoyjcXUdHvlM2Cqad2bRPknStRsmFs7c38P0OXHi1VjCwdTahAK5i5sBo+5B
	 4Jc9ghphvJu796LnbL36V/w+k+r0VI6SwJdsE4fGGOP3JztUUushlvDTnF4ZEEEE3v
	 rV9PVUvpwiVoA==
Date: Fri, 25 Jul 2025 10:20:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <dan.j.williams@intel.com>
Cc: <workflows@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: Crediting test authors
Message-ID: <20250725102019.7add0be0@kernel.org>
In-Reply-To: <6883b3046b640_134cc7100ad@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250725080023.6425488c@kernel.org>
	<6883b3046b640_134cc7100ad@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Jul 2025 09:38:28 -0700 dan.j.williams@intel.com wrote:
> Jakub Kicinski wrote:
> > Hi!
> > 
> > Does anyone have ideas about crediting test authors or tests for bugs
> > discovered?  We increasingly see situations where someone adds a test
> > then our subsystem CI uncovers a (1 in a 100 runs) bug using that test.
> > 
> > Using reported-by doesn't feel right. But credit should go to the
> > person who wrote the test. Is anyone else having this dilemma?  
> 
> Is that not a "credit in the changelog" situation?
> 
> "Big thanks to DeveloperX for their recent TestY added with CommitZ for
>  catching this case."

That's what we do usually, but I'm a strong believer in (LWN) statistics
to help people justify the work they do upstream. Feels even more
important for testing than feature development in a way.

So a tag would be ideal. But it's a hard nut to crack. Best I can come
up with would be:

Reproducer: test.case.path # 001122aabb (optimal) commit of the test case

? Could potentially be useful for backporters?

> Reported-by: Some CI Bot

I guess we'd need something like:

Reported-by: subsystem CI # Person Who <developed@the.test> ?

