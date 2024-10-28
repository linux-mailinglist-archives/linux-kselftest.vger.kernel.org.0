Return-Path: <linux-kselftest+bounces-20829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB819B38E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 19:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709A22830F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 18:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392431DF266;
	Mon, 28 Oct 2024 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="K84pRsMA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C8863B9;
	Mon, 28 Oct 2024 18:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139417; cv=none; b=EpYFltXhFFMpNkgpFWtli0mCSFc6gRWfquLec31bO1qurBdP1NfP5NpEWtMVxZIbCKRTQmMUlhgELsKu0bYD15jK7IVYtHgwmWaTpnR9t9K6b6zARpeAFKZFNVioioxIzzvvDAGZqCjoVe77fNY4KBMt/QaNJ2kpYtGaxmgriC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139417; c=relaxed/simple;
	bh=21Gr/zI9x8LsSQ5eNIX5ikEJIYFfIMNxCsblj6I7lqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqX2G32nHkN0lVO5Nna/Z70JZAhxJk9FI7PyN0xLzM1/BIYG4eIqkdrygV5SF/vhcS/G2ukOs57uirSDZskUiivuEkJ6BjJYDQxLlnXVcv6Hc7Qq5N9EByjijB3s7pLUX02KEgarsNGKXaHP07cXRl87jpkjMWFH2JXRAQzvFfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=K84pRsMA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id C1496211F5ED;
	Mon, 28 Oct 2024 11:16:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C1496211F5ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730139414;
	bh=RZ7qeYFAVjUZDQN0watSSOiugMyzyFTjkpQSGiv31s8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K84pRsMAMFZhYu5Z/cYY2OMmrR66LHiLFH0yjcFbFr1C3syWMVja8bgjvBgMNtoHI
	 DEPeyV1tkdb2xeRBFZ1oSji3TxhXkaVDoShSME5Oy/8yzNFraolImoWt/7sfMEAbhQ
	 UaoO9XrMeY+/123mPuHcjG/dwUD+m5zKFKhdapY0=
Date: Mon, 28 Oct 2024 11:16:52 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Rae Moar <rmoar@google.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: Introduce autorun option
Message-ID: <20241028181652.GA825@skinsburskii.>
References: <172920085854.4578.9203147717033046574.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <CA+GJov4Kfo5EwjXRe8vufhMetsYzHG7bJS6VERaE8+1rNL69Vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+GJov4Kfo5EwjXRe8vufhMetsYzHG7bJS6VERaE8+1rNL69Vg@mail.gmail.com>

On Tue, Oct 22, 2024 at 05:16:31PM -0400, Rae Moar wrote:
> > diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> > index 34b7b6833df3..340723571b0f 100644
> > --- a/lib/kunit/executor.c
> > +++ b/lib/kunit/executor.c
> > @@ -29,6 +29,22 @@ const char *kunit_action(void)
> >         return action_param;
> >  }
> >
> > +/*
> > + * Run KUnit tests after initialization
> > + */
> > +#ifdef CONFIG_KUNIT_AUTORUN_ENABLED
> > +static bool autorun_param = true;
> > +#else
> > +static bool autorun_param;
> > +#endif
> > +module_param_named(autorun, autorun_param, bool, 0);
> > +MODULE_PARM_DESC(autorun, "Run KUnit tests after initialization");
> > +
> > +bool kunit_autorun(void)
> > +{
> > +       return autorun_param;
> > +}
> > +
> >  static char *filter_glob_param;
> >  static char *filter_param;
> >  static char *filter_action_param;
> > @@ -266,7 +282,7 @@ void kunit_exec_run_tests(struct kunit_suite_set *suite_set, bool builtin)
> >                 pr_info("1..%zu\n", num_suites);
> 
> When using this feature, I still see some KTAP output that are printed
> from this function (kunit_exec_run_tests). I think it would be great
> if we could remove this output as to not clutter the kernel log.
> 
> At first, I was confused as to why we needed to call this function and
> initialize the tests but I realized the debugfs suites need to be
> created.
> 
> So instead, could we check for kunit_autorun() here instead as a
> condition before printing the output?
> 

Sure, I'll address it in the next revision.

Thanks,
Stanislav

