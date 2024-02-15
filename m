Return-Path: <linux-kselftest+bounces-4715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8C685589D
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 02:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366B3286105
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 01:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6229EEDE;
	Thu, 15 Feb 2024 01:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNf3knmj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A51EC7;
	Thu, 15 Feb 2024 01:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707959592; cv=none; b=ieX2NCRR0EJrZ2j0mGABCLczXo8iqfqjBVwVK2UZq+3rPSgAg3CRAzxcz3BZNM3RfwswgyGmzElmbXesbM/Ma0qksh3w1egjvpva7XUKUz96HUlCCH48OqmYtQbsY0upoyXwvdFPYl2KSVyrdPECVQzfSDArrP/36NsTZ+gb+t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707959592; c=relaxed/simple;
	bh=6Fvew3KxJaGM3fb9agCmZ550noF0y3Fp5qAHW2xmNbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HN0NYQos4VjgLqVpPMBzRGK9wM5IPWrWKoIj2t0XaTdWZxknsQULo2RoA/cy/yDmLnKvTsLRR//xb9QRkvwY5VVAF/fsxLPUCdGWXwE1QOOqzDG2wSZVLOeMaKQwdsMN4JLOpD04j1e+jRABm+6HYkdOOHqNNKPVeZwMDs9xvH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNf3knmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E064BC433C7;
	Thu, 15 Feb 2024 01:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707959591;
	bh=6Fvew3KxJaGM3fb9agCmZ550noF0y3Fp5qAHW2xmNbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JNf3knmjmXHHW5aEVNENEk9TJV42ADi/aBcOQ7Z3lhxz0YkeNiWFpMSD9G9XN9/F9
	 mc1iCppHJu6Mwi/Q9s3ycCA9OQU7u1fd76fuOr1V6pbygOOgenqEkSZso/EW93c4SD
	 UdItBxK1TXZwQaTw0Y5XUh6GrwSCqsCL/xbqVNAo4XR6fUyaW3NfKl0eHNorUKzGJf
	 8WB3xEk5g2Ai/couhGhgBcDftmmhiGcbFXdbgbQ30WwmlG+40KDB20ntrywcPn6wvb
	 lTTGo2f3DU9q97OKbVKNk7RywDDTkRlhDuUNbMHcZbS9qcbkvl/Y1UwLr5Aa1pc5te
	 /25WV/0f3LNNQ==
From: SeongJae Park <sj@kernel.org>
To: shuah@kernel.org
Cc: "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
	SeongJae Park <sj@kernel.org>,
	keescook@chromium.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vijaikumar_Kanagarajan@mentor.com,
	brauner@kernel.org,
	jlayton@kernel.org,
	jack@suse.cz
Subject: Re: [PATCH] selftests/mqueue: Set timeout to 100 seconds
Date: Wed, 14 Feb 2024 17:13:09 -0800
Message-Id: <20240215011309.73168-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209174243.74220-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A gentle reminder.


Thanks,
SJ

On Fri, 9 Feb 2024 09:42:43 -0800 SeongJae Park <sj@kernel.org> wrote:

> On Fri, 9 Feb 2024 10:30:38 +0000 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com> wrote:
> 
> > On 08/02/2024 21:29, SeongJae Park wrote:
> > > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > > 
> > > 
> > > 
> > > While mq_perf_tests runs with the default kselftest timeout limit, which
> > > is 45 seconds, the test takes about 60 seconds to complete on i3.metal
> > > AWS instances.  Hence, the test always times out.  Increase the timeout
> > > to 100 seconds.
> > > 
> > > Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
> > > Cc: <stable@vger.kernel.org> # 5.4.x
> > > Signed-off-by: SeongJae Park <sj@kernel.org>
> > > ---
> > >   tools/testing/selftests/mqueue/setting | 1 +
> > >   1 file changed, 1 insertion(+)
> > >   create mode 100644 tools/testing/selftests/mqueue/setting
> > > 
> > > diff --git a/tools/testing/selftests/mqueue/setting b/tools/testing/selftests/mqueue/setting
> > > new file mode 100644
> > > index 000000000000..54dc12287839
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/mqueue/setting
> > > @@ -0,0 +1 @@
> > > +timeout=100
> > > --
> > > 2.39.2
> > > 
> > >
> > 
> > Added Vijai Kumar to CC
> > 
> > This looks similar to [PATCH] kselftest: mqueue: increase timeout 
> > https://lore.kernel.org/lkml/20220622085911.2292509-1-Vijaikumar_Kanagarajan@mentor.com/T/#r12820aede6bba015b70ae33323e29ae27d5b69c7 
> > which was increasing the timeout to 180 however it's not clear why this 
> > hasn't been merged yet.
> 
> Thank you.  I don't care who's patch would be picked, but hope any of those be
> merged.  For more eyes, I'm Cc-ing contacts from
> `./scripts/get_maintainer.pl ipc/mqueue.c` output.
> 
> > I have seen the same issue on v5.15.y so it's 
> > very likely that we will need to apply this on all LTS branches not just 
> > 5.4 as mentioned in Cc: <stable@vger.kernel.org> # 5.4.x
> 
> Yes, that's the intent of the Fixes: and Cc: <stable@vger.kernel.org> lines.  I
> hope the lines to be added to Vijai's patch if it is picked instead of this.
> 
> 
> Thanks,
> SJ
> 
> > 
> > Hazem
> >

