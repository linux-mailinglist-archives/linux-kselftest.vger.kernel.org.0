Return-Path: <linux-kselftest+bounces-21277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978299B8A3E
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 05:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A561C21407
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 04:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F25146A79;
	Fri,  1 Nov 2024 04:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gBHSe0EV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033F438FA3
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Nov 2024 04:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730435251; cv=none; b=hZAtau1uhXd0B6lWWjnMBgEjIryClYpQa0WjYPkLyi63UVnXkdpeIZvsAYzeNiQhbcfw3OKw3N8jxLcpEx0b3KnOw9nOdr0zV+tOzqjvrHjuYP8TRr7CUgR1YBO3T4ARCJWSF7s3GvJuvKU2bKO7+dcCGWQK1aGdoXdJQFMM2hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730435251; c=relaxed/simple;
	bh=hhZoxops4zA8llcUsHMuU1AOkiWSqyAB6cRUDvkzSrQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZyK+X90fdclUSrCxBoovRcsz21PCloxd6EqJ3vbtnlfULkS4SpO+x8UYzMybJ/VUVCHvV0PZnNvkV0CQheKne9ruX5EH01yZ8KJ/cc1f9dlIAm4AdWn0Y0F4MyKOt3wYjmtIE++3+j8DzowjGpqKbDINjhATw2DXpXcThd5PWnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gBHSe0EV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481F8C4CECD;
	Fri,  1 Nov 2024 04:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730435250;
	bh=hhZoxops4zA8llcUsHMuU1AOkiWSqyAB6cRUDvkzSrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gBHSe0EV10cklBjUg5DMrby74bXvhBuH1XlHoexxijs3vQoEUKIgMtWCtQ+EbFgrj
	 uK+EFyyeuEDS5J2LBQBiY/tE7U25bDg9ubCQVuY2EYert9wUQfbbUrgGHnA5eyLX0T
	 P94BrUYfPcA6I3pvamwOMno/t/k9nysz7IsAprfI=
Date: Thu, 31 Oct 2024 21:27:29 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
 brendan.higgins@linux.dev, davidgow@google.com,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 ricardo@marliere.net, linux-kernel-mentees@lists.linuxfoundation.org,
 andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v3] lib/math: Add int_sqrt test suite
Message-Id: <20241031212729.af140fc927ff8f764448f072@linux-foundation.org>
In-Reply-To: <388a8b6c-1acf-413c-bbf4-3b23156117f8@linuxfoundation.org>
References: <20241030134355.14294-1-luis.hernandez093@gmail.com>
	<c213dbcb-35de-4afd-9d4b-f42f6a9e3de6@linuxfoundation.org>
	<20241031173941.3487ccbfd7421d81d9b0cb97@linux-foundation.org>
	<388a8b6c-1acf-413c-bbf4-3b23156117f8@linuxfoundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 20:25:56 -0600 Shuah Khan <skhan@linuxfoundation.org> wrote:

> >>> --- a/lib/math/Makefile
> >>> +++ b/lib/math/Makefile
> >>> @@ -9,3 +9,4 @@ obj-$(CONFIG_INT_POW_TEST)  += tests/int_pow_kunit.o
> >>>    obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
> >>>    obj-$(CONFIG_TEST_MULDIV64)	+= test_mul_u64_u64_div_u64.o
> >>>    obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
> >>> +obj-y  += tests/
> > 
> > What's this change about?  It seems somewhat unrelated to adding a
> > single test.  I mean, there's an unrelated test listed in
> > lib/math/tests/Makefile so what change does this patch have upon that
> > one?
> > 
> 
> I think this is a new test. I can take this for 6.13-rc1
> 
> I thought the conflicts might persist in case you have any 6.13 material
> already in linux-next. Doesn't look like it if you could apply to 6.12-rc5
> 
> Sorry for the confusion.  I can take this for 6.13-rc1

x86_64 allmodconfig:

error: the following would cause module name conflict:
  lib/math/tests/int_pow_kunit.ko
  lib/math/tests/int_pow_kunit.ko


