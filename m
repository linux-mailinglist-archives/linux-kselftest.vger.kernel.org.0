Return-Path: <linux-kselftest+bounces-14878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 360D0949861
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 21:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE19F1F21A2D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 19:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2C4823CE;
	Tue,  6 Aug 2024 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdZFIVKK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5608812C499;
	Tue,  6 Aug 2024 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972864; cv=none; b=KT8WHYnUbGXwIQfrY7ABYD8BDdqSP35sp3lAnY9bYLK0J1Qj9NRleQK8IDK4z4a+xY1wqaDlN24+PDsuK6aqngyhE8Ftpap2+bnU4VLfgoBjgcoDduFOPc9gTTbcOWv28kHL0jpEftcbRTMUQkB1QuysUIWPtTwoN78kuvhM/P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972864; c=relaxed/simple;
	bh=eTj0TWL2vBtXKJLs5erh4BI8TewdvBdBvOodO4DPvdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYFwidSCHURpt46EkOu6VEdcjLjJStvySUeP71C++0aZ6XC7ln05iGkUIMDwrDgx4NbJx96bkvEmoaW+GGVEzmD1rLQi8mNPokYKZb87Hcy8ZFxyOVZ2RqWkrbmb/gcciuUIX0WZN+jRqAjJ7ju2tTK282ecVv9fP+BYuzLPbJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdZFIVKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31499C32786;
	Tue,  6 Aug 2024 19:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722972864;
	bh=eTj0TWL2vBtXKJLs5erh4BI8TewdvBdBvOodO4DPvdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cdZFIVKKbK2oBPjIqsyRyOAMv+cG0btdr+BjgXqKHSZemwNZ8j6GsVHIw8HYxG1Zn
	 ieC81gIMp/VhRc0zHOBi5kUEQC79JTqcTPn29u/lZg71DZpqMThcq3MjvoTIniB6Pj
	 GlSd+L7UL84JgZYDBNs2PUHhpWbC4P9pfLYboUCanJi3Gnl9GgBeNmILPi3xlU0v6i
	 XrWaSy4I79FSiLzsxXwZ9WjJRP2T7QVkcVhAGYavMZhkn+IvsenJGzSV5ydA9nE0JL
	 0bzet8VAJgw+D6XtIGPnciACfAxzWhthRG2xmrOs4lLKSEuwpAE+Y/pNh4ThVH5zbE
	 qmAvQ9pduI+2g==
Date: Tue, 6 Aug 2024 12:34:23 -0700
From: Kees Cook <kees@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Vitor Massaru Iha <vitor@massaru.org>, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	brendanhiggins@google.com, davidgow@google.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3] lib: Convert test_user_copy to KUnit test
Message-ID: <202408061232.B6382B6DA0@keescook>
References: <20200721174654.72132-1-vitor@massaru.org>
 <a41ab091-42d3-4e03-b0e8-89af354faadc@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a41ab091-42d3-4e03-b0e8-89af354faadc@roeck-us.net>

On Tue, Aug 06, 2024 at 08:48:43AM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Tue, Jul 21, 2020 at 02:46:54PM -0300, Vitor Massaru Iha wrote:
> > This adds the conversion of the runtime tests of test_user_copy fuctions,
> > from `lib/test_user_copy.c`to KUnit tests.
> > 
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> 
> These tests are failing (at least) for arm-v7, loongarch, and mips
> qemu emulations; see below for failure logs.

Oh my. Good thing this got added to KUnit, then -- the core of the tests
haven't actually changed. I will see what I can uncover.

> Any idea if those might be architecture problems, problems with qemu,
> or problems with the test ?

The last two look like NULL derefs (??) and the first seems like maybe a
test problem (the failure looks kind of like the CONFIG_MMU=n cases that
were fixed earlier).

-- 
Kees Cook

