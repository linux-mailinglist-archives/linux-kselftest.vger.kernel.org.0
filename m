Return-Path: <linux-kselftest+bounces-27981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F87A4B432
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 19:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E5A16C997
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 18:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477361E9B32;
	Sun,  2 Mar 2025 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fa24pm6H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB5612B93;
	Sun,  2 Mar 2025 18:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740941462; cv=none; b=qlJjmVfVVbaKN58dhfzGqp2c4q9P2O6OD2blf+oIuLUhWktrb58/T62O76AGSg9fdhz9ADDVLUpCjn4AA7j3Bm8qeL2G7TGp53anFJjHANDepmOBK5AcfdptHDZX9+lEjO0gqa9SSdBVqh3yOfoNhIhMdzZANU+666jgRz3zGVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740941462; c=relaxed/simple;
	bh=WZtBeODplm5GUGD8QRqFOv2/tB9nkdyCL2v9FGAFync=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hs0nLlOCEqZV2a473+1HPyFXIhvt3qwNHXO5HjrEZG3gB7d1T0Vfmy6I+BLEgZEHgcfIbk1rkFHSGOUUlVrqli5wtmyqWJ/JtEW3oj3vit7EUPBvr5Crb4Iv0NKxTzdAsAfPK5bW7X0qTVkTmFz54S+0FUQFqsljBI+4m5FH4Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fa24pm6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17628C4CED6;
	Sun,  2 Mar 2025 18:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740941461;
	bh=WZtBeODplm5GUGD8QRqFOv2/tB9nkdyCL2v9FGAFync=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fa24pm6HIjs7KDkcVqo4hAGUoR4frIjl/ui3RSD1RYYNTypyI6Z4joWX0vkSbW2CA
	 wJu8HtFWkbi6EJlmtyTa8t7qVRhztHFbl6ZTJcA0EmrizAP5dg1dHTrnjdG7RSwoof
	 2A8h3CmB0dIKFYonKLUApjj+A07qaFI0bTcViSerJ65949vEeRJc1grqYS6qvjrmEk
	 2NFPdJvAOC/EMV1rbR6JM5mFwCyeGLlsp/M8oY7Pxs3Fz9QhC9spX25aVv26C8A/XB
	 4Tpi/uDeS8qwLDVRxK77VPl2H/LHbIYb3cg83396Kzs7u48U905FlliQ/ipD8KLrGt
	 wvgxbGSfUEJMw==
Date: Sun, 2 Mar 2025 10:50:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, petrm@nvidia.com, willemb@google.com,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net: report output format as TAP 13
 in Python tests
Message-ID: <20250302105059.5f35fc3b@kernel.org>
In-Reply-To: <0f196026-02ec-4db0-90b0-10c1e720c345@kernel.org>
References: <20250228180007.83325-1-kuba@kernel.org>
	<0f196026-02ec-4db0-90b0-10c1e720c345@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Mar 2025 11:52:06 +0100 Matthieu Baerts wrote:
> On 28/02/2025 19:00, Jakub Kicinski wrote:
> > The Python lib based tests report that they are producing
> > "KTAP version 1", but really we aren't making use of any
> > KTAP features, like subtests. Our output is plain TAP.
> > 
> > Report TAP 13 instead of KTAP 1, this is what mptcp tests do,  
> 
> Indeed, and also TC tests, and all the ones using kselftest_harness.h I
> think.
> 
> > and what NIPA knows how to parse best. For HW testing we need
> > precise subtest result tracking.  
> 
> I guess the best would be to have the kselftests infrastructure fully
> supporting KTAP, and then have a way for each test to print subtests
> correctly, not nested in the comments like it is done for the moment.
> But that looks harder to put in place, and the current solution is used
> in a few areas.

Right. So for additional context for folks less familiar with selftests
the two minor inconveniences which made "supporting KTAP" a less
exciting option are: (a) we run make run_tests which wraps things
in an outer TAP, so we'd end up with a hybrid, anyway; (b) NIPA
only supports one level of subtests.

Thanks for the review!

