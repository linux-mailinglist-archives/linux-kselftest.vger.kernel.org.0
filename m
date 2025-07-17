Return-Path: <linux-kselftest+bounces-37510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC045B09183
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 18:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC29A44A47
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 16:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A732FA62F;
	Thu, 17 Jul 2025 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkdQ8OmX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFAE2F94BA;
	Thu, 17 Jul 2025 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768897; cv=none; b=UJjVsgkQr8tBV6b8nuijOGjwMWCoLE+AYAmF08GNfzq8kHWAhElolBWL0sa+XmA0jM6W/z7qypvmLtLxncBgbYlZjyxSqRnjetkfVl56WqTKmSkP3qvLwxzfECUAa3xwjQ8t4Wadz9wb+GycRAEn5LBSCj4C+4YoEvwTi0q+TWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768897; c=relaxed/simple;
	bh=5IcsonFb86uUyqMHv9JdUoJ9pJrYwbDo0+ddHS1jofM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kSeJ8CnC/A0e6t5oVJcPu0XRuQvCDp9lZ54PkdE0xht5HGlzHCFHsEjlHF8E2G1DJYjSn+EyOOrLNhexvI0j2ogLygyvdMIqt1s89/CQm8nEsvheMTwCy0LwdQKnggFQ4MJgIMG7dRrJ9GYU+MWzJkaKxBUgA8J6sz0RpgCH6FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkdQ8OmX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E63C4CEE3;
	Thu, 17 Jul 2025 16:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752768897;
	bh=5IcsonFb86uUyqMHv9JdUoJ9pJrYwbDo0+ddHS1jofM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kkdQ8OmX06WKvymsNEyCLhOd3QjBiOamtoRblYB11i5vp2oYgso1a72NJOAoxjfYk
	 I3bqN8zohfQqsJWuqkRFUrpRg3k5CyDrJDzkURkhXKC1iIf3S+HDUNP9ou7jRrfEKB
	 6lbjkv1AJ82jeugEo6R2Qcxh0Kc/IuUOJdhytv8t4Y7d7hRTlamNCoZCdKP+GZus+f
	 pPvF6WJma9OTZJy2qGeu8b5rhaNN0yx3JdfHd0WDM4dqmxRlgplKx/eBm8Xee56blb
	 jfmiFqShHuEkQ+m2wsSiPPOwVkzA91YJQI/OyUOrBpOB1y0ThEhn5wmyLRW1qople2
	 gP5dQ5h5K4mAg==
From: SeongJae Park <sj@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Enze Li <lienze@kylinos.cn>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	enze.li@gmx.com
Subject: Re: [PATCH] selftests/damon: introduce _common.sh to host shared function
Date: Thu, 17 Jul 2025 09:14:54 -0700
Message-Id: <20250717161454.62245-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250717135433.2113596-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joshua,

On Thu, 17 Jul 2025 06:54:32 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> On Thu, 17 Jul 2025 17:19:02 +0800 Enze Li <lienze@kylinos.cn> wrote:
> 
> Hi Enze,
> 
> Thank you for the patch! I just have a few comments about the patch.
> 
> > The current test scripts contain duplicated root permission checks
> > in multiple locations.  This patch consolidates these checks into
> > _common.sh to eliminate code redundancy.
> 
> Is there a reason we named the file _common.sh? IIRC there are no other files
> that begin with an underscore, so it might be confusing for users. Maybe
> remaining it to damon_common.sh might fit better with the convention used
> by other selftests. 

This is my personal pattern that I sometimes use, to distinguish files that
aimed to be only indirectly be used.  We already have a file of the pattern,
namely _damon_sysfs.py.

I don't think this pattern is particularly good, but not making something
worse, so I'm ok with current file name.

> 
> [...snip...]
> 
> > diff --git a/tools/testing/selftests/damon/_common.sh b/tools/testing/selftests/damon/_common.sh
> > new file mode 100644
> > index 000000000000..3920b619c30f
> > --- /dev/null
> > +++ b/tools/testing/selftests/damon/_common.sh
> > @@ -0,0 +1,14 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +# Kselftest frmework requirement - SKIP code is 4.
> > +ksft_skip=4
> > +
> > +check_dependencies()
> > +{
> > +	if [ $EUID -ne 0 ]
> > +	then
> > +		echo "Run as root"
> > +		exit $ksft_skip
> > +	fi
> > +}
> > diff --git a/tools/testing/selftests/damon/lru_sort.sh b/tools/testing/selftests/damon/lru_sort.sh
> > index 61b80197c896..0d128d809fd3 100755
> > --- a/tools/testing/selftests/damon/lru_sort.sh
> > +++ b/tools/testing/selftests/damon/lru_sort.sh
> > @@ -1,14 +1,9 @@
> >  #!/bin/bash
> >  # SPDX-License-Identifier: GPL-2.0
> >  
> > -# Kselftest framework requirement - SKIP code is 4.
> > -ksft_skip=4
> 
> Hm, I think factoring out check_dependencies() is a good idea, but maybe we
> should keep ksft_skip in here since other checks in the script use the value?
> My 2c is that it might make it unnecessarily opaque for others.
> Same comment applies for the other files as well. 
> 
> But I will let SJ comment on this more ;)

I agree Joshua's point.  I'd prefer keeping ksft_skip definition here.

> 
> Thank you for your patch, I hope you have a great day!

Thank you for your valuable comments, Joshua :)


Thanks,
SJ

[...]

