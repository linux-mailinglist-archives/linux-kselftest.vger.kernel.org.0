Return-Path: <linux-kselftest+bounces-7119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1CE897B05
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 23:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F13282833
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 21:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132F715687D;
	Wed,  3 Apr 2024 21:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogLfqsFc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED1813665F;
	Wed,  3 Apr 2024 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712180899; cv=none; b=E3x9HlVagiWOP7ZUiJmzWOEp8iosZNHsS1VrE8rTCAyKqtDWFQPgU9041Kgakm86/ZMjl7jKk7bC6xoZsXr3ZI2oWiz4fWR7BahWRFLI5UCXVtQlv8RSj8jzeJOMcqEwcIBh1RY785pPmx9gaSFPz2E7gVA1pYHBrY8Qurt1bOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712180899; c=relaxed/simple;
	bh=7bQULIDBWKi6DJdvIXLjx9vhZMnYUGOPgV6mbEm/aac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ODp1XnOTJj+VxykJrrAdrmG7Mk5pImGIanrPq5In0f7pBPpIqnMqkQRJZopOrlwHciJOz48ftCQFtYIuhxGLgt418dXM5cBDqWQiM25NFJl33kb9Q4pLyImnVD+SJ1Ge1SKqp6WKQOqQ/78quyYLkA4Z3lgyRRfO2P7IJ6yJQh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogLfqsFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34895C433F1;
	Wed,  3 Apr 2024 21:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712180898;
	bh=7bQULIDBWKi6DJdvIXLjx9vhZMnYUGOPgV6mbEm/aac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ogLfqsFc33/N3q0ZlFS3pB2+zPxEC3Gw6K07APMkcYuyJKiei96/zNPUWbknPKBaz
	 73XhnSc4NqqQ58ugqIaRB65kcuJ0FlbskuU952/Clmn8OeoAzmJV3DpeJRgkYqdFQ/
	 oYfazeySgydIESeErZjcH2L+WLGemrzJiB8/7ifDw85vLZHF632RmaEiW8jmfPJ/dd
	 9nlxvz2CzncTjb1QGZm4RpyOsT2gnPFd0OxUCev9V2elUKnSIy66k3hFY6jMj9g2O0
	 nR2O9xSpdhoHqvzy8mkD2O4TOdWB28H0hqZbNRwgn7cPOAYjbSWS9CQf97pxbtlyfJ
	 D1Ab1Lt81BxuA==
Date: Wed, 3 Apr 2024 14:48:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <shuah@kernel.org>, <sdf@google.com>,
 <donald.hunter@gmail.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 7/7] testing: net-drv: add a driver test for
 stats reporting
Message-ID: <20240403144817.2c86ff36@kernel.org>
In-Reply-To: <87ttkigynz.fsf@nvidia.com>
References: <20240402010520.1209517-1-kuba@kernel.org>
	<20240402010520.1209517-8-kuba@kernel.org>
	<87bk6rit8f.fsf@nvidia.com>
	<20240402103111.7d190fb1@kernel.org>
	<8734s3idys.fsf@nvidia.com>
	<20240402163649.4fdc2d3b@kernel.org>
	<87y19uhhhx.fsf@nvidia.com>
	<20240403065532.1f2a072d@kernel.org>
	<87ttkigynz.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Apr 2024 18:52:50 +0200 Petr Machata wrote:
> > Nothing wrong with that. I guess the question in my mind is whether
> > we're aiming for making the tests "pythonic" (in which case "with"
> > definitely wins), or more of a "bash with classes" style trying to
> > avoid any constructs people may have to google. I'm on the fence on
> > that one, as the del example proves my python expertise is not high.
> > OTOH people who prefer bash will continue to write bash tests,
> > so maybe we don't have to worry about non-experts too much. Dunno.  
> 
> What I'm saying is, bash is currently a bit of a mess when it comes to
> cleanups. It's hard to get right, annoying to review, and sometimes
> individual cases add state that they don't unwind in cleanup() but only
> later in the function, so when you C-c half-way through such case, stuff
> stays behind.
> 
> Python has tools to just magic all this away.

Understood, just to be clear what I was saying is that +/- bugs 
in my example it is possible to "attach" the lifetime of things
to a test object or such. Maybe people would be less likely to remember
to do that than use "with"? Dunno. In any case, IIUC we don't have to
decide now, so I went ahead with the v2 last night.

