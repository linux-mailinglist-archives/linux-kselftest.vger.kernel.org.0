Return-Path: <linux-kselftest+bounces-26645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02C0A35ACE
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 10:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8989416E9F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 09:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816C5253B46;
	Fri, 14 Feb 2025 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OPO8scuN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD68253F0A;
	Fri, 14 Feb 2025 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739526542; cv=none; b=sQu0IokPHbNWp7xKfdWMQJCc3oSAcdVbr5/cnm2AhysL6MmZFDAyoQb/4sOHzc5Oqd6ULuJqVMrk+Xu9d3fbnbqcJYPM3hyekQgnUORtffJ4knOwx9QmK9UtQCH/H0hALs4d3SrL5ArnN8Yi6nqweDrlbIhbMOgAnJyJueBMzs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739526542; c=relaxed/simple;
	bh=00sj+E3Q5oWwqUpdUJf7qVk9/n29myFEzCH8bm0KGr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2B7FIeYFG5AgohiJpb5ua4PRPO2BS+oPvBLdBY68u8xiIDClgPro9Ihy9F+wKKOmZbGwJ43ejOk1wpFlR/dJ4fWp9hA5eU/MCGojA/+1BdxmERUrPsFjyepA85UZ3D0QGj+nYIWSYdlcVYcXiSwK272vAsW2iB7LSDti8EeaQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OPO8scuN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=4Y5ny06wV2OrX31Zto/f4bDuO3ylRieeq2wUr180jA8=; b=OPO8scuN98RdFWul73hP73sU+N
	Hqna5iUjeQwNmnAJE96rBoEnob2kznP6Jvd2AvngAchelPQQ+HaA+c1eXBkF4sZome24zldERpRSf
	/o3NvsObhznBN/NC/iHJhYkVJWvGWx/zolhLFcGmoBupgIGAPyNSB6JlzK/lYKnmJ4KG03sWJuh+v
	MCtpLJp6M9Vwmt7gk/hDpssh6MhbTCrvkPRM4ZagZvNdnCAIYRXZ05kUPvnJYHscwjwSYdCNMmfuz
	cps+eRYT1XkCrs6+kwCACUNDdR/N0PgnEcw8rP/WBUWrDYq+GkATi/V9DoFUCzuIPGfVAmc3su4zz
	8JouRVjg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tisJd-0000000AuRL-2gdb;
	Fri, 14 Feb 2025 09:48:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EC5D030050D; Fri, 14 Feb 2025 10:48:56 +0100 (CET)
Date: Fri, 14 Feb 2025 10:48:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2] ww_mutex: convert self-test to KUnit
Message-ID: <20250214094856.GD21726@noisy.programming.kicks-ass.net>
References: <20250213-ww_mutex-kunit-convert-v2-1-4a60be9d5aae@gmail.com>
 <20250213115951.GF28068@noisy.programming.kicks-ass.net>
 <CAJ-ks9mzYWSvVD=PCvCBohXg77BdFODq4ePMNstkL+70tkU5RA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9mzYWSvVD=PCvCBohXg77BdFODq4ePMNstkL+70tkU5RA@mail.gmail.com>

On Thu, Feb 13, 2025 at 10:42:24AM -0500, Tamir Duberstein wrote:
> On Thu, Feb 13, 2025 at 6:59 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Feb 13, 2025 at 06:40:20AM -0500, Tamir Duberstein wrote:
> > > Convert this unit test to a KUnit test. This allows the test to benefit
> > > from the KUnit tooling. Note that care is taken to avoid test-ending
> > > assertions in worker threads, which is unsafe in KUnit (and wasn't done
> > > before this change either).
> >
> > So this was something simple, and now I need to know how to operate this
> > kunit nonsense :-(
> >
> > How is that an improvement?
> 
> Hi Peter,
> 
> David enumerated some of the benefits of KUnit in another
> thread: https://lore.kernel.org/all/CABVgOS=KZrM2dWyp1HzVS0zh7vquLxmTY2T2Ti53DQADrW+sJg@mail.gmail.com/.
> 
> My personal reason for preferring KUnit is that it's much easier to
> run from userspace; the tooling takes care of building, starting the
> VM, running the tests, and producing a human-friendly report.

Wait what -- you have to run a VM just to use Kunit? That's a hard pass.

If I can't simply run it natively on my test box, its a no go. And it
using python also don't help, you shouldn't be needing that to load a
module.

