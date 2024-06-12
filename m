Return-Path: <linux-kselftest+bounces-11779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370FB90581F
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 18:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE371C20D08
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 16:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506A1181D07;
	Wed, 12 Jun 2024 16:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMeJkFwC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2465B181BAF;
	Wed, 12 Jun 2024 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208315; cv=none; b=LPS9C6HKkCmbwNz+Db6nMjHMGz8u8tvReYUNO79+A6ZLqXmHHI+UutlXAwrAyEZfcz2co64mXcKpdL3WKb45jvJkKPqDxQNHsjMdjh2EscaqiB4nFohznMtn+e1NVdfSRzqJO6RtXxV3Ory497T4oQdx4zlTJrZz435YCz0IWKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208315; c=relaxed/simple;
	bh=Ny4Zo9sSjpAd2us+A20fiV+uPm/Io6ALD4EkL1KRJLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rU6iGPZb0gLl2KGW7PrAIjYhJYPt7o3rlqmgQz4x5yCPsduQXE6TrDsTmt9ALbcHWZAbY830+VGpzfpsvwv6YLCJtBgJ1FUrX3UsqiUaQLM3jgmVRV1PlCMdQUNqhRZSAcPVzRIdwssYxybaVFAhFqpxucrPxyW+seRPXoDHeA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMeJkFwC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9465AC116B1;
	Wed, 12 Jun 2024 16:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718208314;
	bh=Ny4Zo9sSjpAd2us+A20fiV+uPm/Io6ALD4EkL1KRJLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pMeJkFwCZ0WTDF4ljPjlGfDMyqVn+v64jg2pWTV/0ZblFt2n9uKbnTRBP/Yj7P8yw
	 8b+s8FesDan3H+w6UiNCQknu/4ogxBnU+JGARIQ6JPGzImR5qyingt2CvuB1HlNOWg
	 1Hip5h7QoNRv4zau38l6ho6RseBnXOrGPnHS/x9IIgx1CN5JoxcuhZi3t6LSDuZ71p
	 JSiyZlVIaCpotS3SV8sYW//MbhDZMbTsSugtkHLgFGSPB8OcLWtxy2+5jEkCsFW1O+
	 VfuJniHXFgVSh+lEcLmlgbtFvKUpcV9MjU83c74ym5qXQeH+l2/1UbZldnHBO0B7KC
	 3uSAYR4rnnXGg==
Date: Wed, 12 Jun 2024 09:05:14 -0700
From: Kees Cook <kees@kernel.org>
To: David Gow <davidgow@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Vitor Massaru Iha <vitor@massaru.org>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usercopy: Convert test_user_copy to KUnit test
Message-ID: <202406120903.D0EF1C6@keescook>
References: <20240610213055.it.075-kees@kernel.org>
 <20240610213330.1310156-2-kees@kernel.org>
 <CABVgOSmFL50_qYOBROkE9LZx__W6MLnHWahGnAVuLBDVO4k1zQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSmFL50_qYOBROkE9LZx__W6MLnHWahGnAVuLBDVO4k1zQ@mail.gmail.com>

On Wed, Jun 12, 2024 at 05:13:39PM +0800, David Gow wrote:
> On Tue, 11 Jun 2024 at 05:33, Kees Cook <kees@kernel.org> wrote:
> >
> > Convert the runtime tests of hardened usercopy to standard KUnit tests.
> >
> > Co-developed-by: Vitor Massaru Iha <vitor@massaru.org>
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > Link: https://lore.kernel.org/r/20200721174654.72132-1-vitor@massaru.org
> > Tested-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> 
> This looks good, particularly with the x86 fix applied.

Thanks!

> It's still hanging on m68k -- I think at the 'illegal reversed
> copy_to_user passed' test -- but I'll admit to not having tried to
> debug it further.

For my own future reference, I have reproduced this with:

$ sudo apt install gcc-m68k-linux-gnu
$ tools/testing/kunit/kunit.py run --arch m68k --make_option CROSS_COMPILE=m68k-linux-gnu- usercopy

I'll figure it out...

> One other (set of) notes below about using KUNIT_EXPECT_MEMEQ_MSG(),
> otherwise (assuming the m68k stuff isn't actually a regression, which
> I haven't tested but I imagine is unlikely),

I should really read all the API docs every few releases. :) I will
switch to KUNIT_EXPECT_MEMEQ_MSG!

-- 
Kees Cook

