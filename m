Return-Path: <linux-kselftest+bounces-26541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C72CA33EAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 13:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC976188E97F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 12:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FD7221554;
	Thu, 13 Feb 2025 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TyFt7NBM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD9823A9B1;
	Thu, 13 Feb 2025 11:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739448000; cv=none; b=gOo2UJ+INiZ4JBFb/zJ4nCrO3NjXjrlGjKQ2UTLnPsBa5SCosaIEZCOg5IXlKktFIOAkhkrHM1tZN5Zn2vzPOZNgIbS/TjXgV7fNLQF6wjP5MVbM5PCk/lthCB9ppiFOTqCmfo/r0PXfwxAiOKmG+6Kxt61rYA8S3EMuxNgfgfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739448000; c=relaxed/simple;
	bh=tHokHA+R/K+81u9HnafZobZMDVtLSE+pPxttTZO+tUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQApSBdAyMFYq8M1amjDTc2g3j466yvqeqclmq7XAG+EZjzxFR8SCYk1+C1M2hBXmc0SHKM6T+RHPpZm64qGMULVXWNc9kwCb1Mr+GGr+tUjOXSM8Z31dTze4aytQZ/OlVY9SfOI3bBzB1vGftrx1BRs3fir8F56Y/oL7vXUFbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TyFt7NBM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tHokHA+R/K+81u9HnafZobZMDVtLSE+pPxttTZO+tUo=; b=TyFt7NBMvQ4lL0oU5PguO+cqjA
	v/KgR1YXRka9r06Jv65NbCb/SQXasBBlES4xhlKa3aQ/l72+slSTgHll3AcuYYR9DYmXc4UkWrDC4
	xYrFlWwQ23AbzocnITa7H/riJYhqD1z2JxdEpU1Q2ra8UKlMxbVkNuyGzU2TanjyQzVbXluy4TAaB
	V9WWq4C843YW/2oCavurhGKvtj6G4+K/Dbqgme5lzoArZLMXN77uTnVBxPING0nbx1ZUjUudBki71
	hk4HYC/EDDR92dYSKEmLQoio4HFzEdg6QfVm61kf7eVQIDGR2zQvmedSCHsAuMWf13IpFMF304UWB
	LhLVIGOw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tiXsl-00000008Bpw-3J8d;
	Thu, 13 Feb 2025 11:59:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5FDE13001AC; Thu, 13 Feb 2025 12:59:51 +0100 (CET)
Date: Thu, 13 Feb 2025 12:59:51 +0100
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
Message-ID: <20250213115951.GF28068@noisy.programming.kicks-ass.net>
References: <20250213-ww_mutex-kunit-convert-v2-1-4a60be9d5aae@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-ww_mutex-kunit-convert-v2-1-4a60be9d5aae@gmail.com>

On Thu, Feb 13, 2025 at 06:40:20AM -0500, Tamir Duberstein wrote:
> Convert this unit test to a KUnit test. This allows the test to benefit
> from the KUnit tooling. Note that care is taken to avoid test-ending
> assertions in worker threads, which is unsafe in KUnit (and wasn't done
> before this change either).

So this was something simple, and now I need to know how to operate this
kunit nonsense :-(

How is that an improvement?

