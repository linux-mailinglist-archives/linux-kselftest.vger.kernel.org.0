Return-Path: <linux-kselftest+bounces-31642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE4CA9C8E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 14:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605B31BC00BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 12:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EF2248861;
	Fri, 25 Apr 2025 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DducLYH6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56D721CC46;
	Fri, 25 Apr 2025 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745584058; cv=none; b=ls7hDZgQjYg4zBO7k281NkuIbb/rUtSXVBXVJgyr6xHco1A+Mx46/esoZSGK0++8/dnyNE5SL3sisZTA7swxfzMWnukiGoJToja1BM4TWG4ot58fseEqwiN1gbSvEWp2f+zv2u187h2Z1LcaZOq22CCRxTYPrrOzLwuIROaJnlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745584058; c=relaxed/simple;
	bh=1q/8Z0J+uxA4a3nHceJwqLaKct7h70mNRGxQRrVpxT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZCN0aEEvZ+kgOYx/jqFEjC9rf36sWnq8vGzzYnLwGLZ3uFYvBdQsu4YycnwxM8sIMmHDjrNWkIjnuS5zGdUr/faBU09/KXzmGkQX1rDDAMyIRsK0vLCFs13IX4XH7IWhS2dr6nrlWZaJcALVwvqSQvZoTZBzp69mBm+Yf4tfSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DducLYH6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1q/8Z0J+uxA4a3nHceJwqLaKct7h70mNRGxQRrVpxT8=; b=DducLYH6ztS5Yh/t/Y2u4p78zx
	5BK2jpexk1qc90qvF1LPpFrnJmht/g0NtGbcAr/ORj2+DT43Xjt05H9XnyFw9x3LTO0oB9uriakjt
	bZIT5kA8pTOd+E+dYU++W2fvFrMFQLp6pER9vhBl9zu3D6Wdd5aXtsZ5j3cFr4kC/U67cnDeoDvmK
	uQ9FwDdvOOG7uk2/0609BQBjSLFYahvZMdPEAoOer3ox0YzoCTOQLZjpMV4poEuPC4DpYUtWWDM6j
	t9AzB1Dg94/Bq9T5gFNfsZg2UJ87P5wC8M1LQU2P1TjPFNF4fLMbyMRdVsCveBz44CZDmXWCF70FJ
	XCc4dTQA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8I9N-0000000EUEK-00tZ;
	Fri, 25 Apr 2025 12:27:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 642ED3003C4; Fri, 25 Apr 2025 14:27:24 +0200 (CEST)
Date: Fri, 25 Apr 2025 14:27:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Mingwei Zhang <mizhang@google.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com,
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Yongwei Ma <yongwei.ma@intel.com>,
	Xiong Zhang <xiong.y.zhang@linux.intel.com>,
	Jim Mattson <jmattson@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Zide Chen <zide.chen@intel.com>,
	Eranian Stephane <eranian@google.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Subject: Re: [PATCH v4 00/38] Mediated vPMU 4.0 for x86
Message-ID: <20250425122724.GA22125@noisy.programming.kicks-ass.net>
References: <20250324173121.1275209-1-mizhang@google.com>
 <16d8265b-750d-4e3c-aeb1-772d28b6c79c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16d8265b-750d-4e3c-aeb1-772d28b6c79c@linux.intel.com>

On Wed, Apr 16, 2025 at 03:22:02PM +0800, Mi, Dapeng wrote:
> Kindly ping... Any comments on this patch series? Thanks.

I suppose its mostly okay, just a few nits.

