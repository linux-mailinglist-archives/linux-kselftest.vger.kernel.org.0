Return-Path: <linux-kselftest+bounces-32265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE46EAA7DDA
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 03:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402B59A53D6
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 01:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C223B1AB;
	Sat,  3 May 2025 01:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfAb8EcB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22DF2904;
	Sat,  3 May 2025 01:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746234801; cv=none; b=qCj/8ORxekAxHTGmCwKoP/DNxbuUyxSSPKLbz2mAoerp2fzJqd4QQKo+WVHLa7By1OkSIQX3CiNpLYk6IxhlMGoHFRCd9W2QoyL6ZlperdgSgnmntK+aizD476tKn4dmPeBCukZ5m7nK3QjbA0hQ4g09cIriNieH9Puz2ZRa2Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746234801; c=relaxed/simple;
	bh=MgdWlydLvqM1y0twYide0cMV6Jk01ckZOrrmNw6pAtE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0IFlSrcx3NP1bqE3bQVl7Pq9HAeI/BiYenKdMS6F4fCLGiMR33pWfRqSyHOrUz/HpbwLbzhmSbHlI/Z6bzgID24QAXcxvM4Y4pA4Ns7+WbMkSZqO+BQACTyS/Ho4CXxAkvCxfs0pq66FrCRxwkFsR9t+xF55b7pxjZvI5p+5c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfAb8EcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E907AC4CEE4;
	Sat,  3 May 2025 01:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746234801;
	bh=MgdWlydLvqM1y0twYide0cMV6Jk01ckZOrrmNw6pAtE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XfAb8EcBUkbo75El1h4q26NirjD014lSZ9M92nXljip+z5h94+/I0cEVnkf4iTiMY
	 ClXI4nzsIBmRUFDA7C8oWiTRu0aD93ay9TSkYE7w4lgj6RFNstSzJJMkRfnYViRQtF
	 VPc9HQnUVsq/kth4ZaYz4YO0oU0DXK6UlPQCHOguVFNMCHd2d8zbxxjgWbE6EpbxLW
	 S/WlqfNAzs+ns4N9rC9lVWoKv4NF6Q3ad6smf0HOkn6FnFJoTjQANbKkVzSklOrao6
	 TY4S+uAltk3/q5icNhUN1gtVfkzAtyBjPgeHhg2KUA90pC5lx+rpWQSCiASMVBGDdn
	 2y6Af9tU5uEgA==
Date: Fri, 2 May 2025 18:13:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, petrm@nvidia.com, willemb@google.com, sdf@fomichev.me,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2] selftests: net: exit cleanly on SIGTERM /
 timeout
Message-ID: <20250502181320.562940c0@kernel.org>
In-Reply-To: <f94dc055-6c3b-4fae-868a-723f9dc63db5@redhat.com>
References: <20250429170804.2649622-1-kuba@kernel.org>
	<2e16fc73-e272-4277-b232-b912c84f5d4b@gmail.com>
	<f94dc055-6c3b-4fae-868a-723f9dc63db5@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 May 2025 15:05:48 +0200 Paolo Abeni wrote:
> >> @@ -229,11 +249,12 @@ KSFT_DISRUPTIVE = True
> >>              cnt_key = 'xfail'
> >>          except BaseException as e:
> >>              stop |= isinstance(e, KeyboardInterrupt)
> >> +            stop |= isinstance(e, KsftTerminate)  
> > 
> > The first isinstance() will return True for a KsftTerminate as it's a
> >  subclass of KeyboardInterrupt, and thus the second line isn't needed.  
> 
> @Jakub: I'm using the selftests code to refresh my rather rusty python
> skills, I think it would be good to address the above and keep the
> codebase clean.

Right, right, I was just distracted the last 3 days, wasn't trying 
to ignore :) Will respin shortly, good catch indeed.

