Return-Path: <linux-kselftest+bounces-19015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D74990207
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 13:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9438DB2188C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 11:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A09157472;
	Fri,  4 Oct 2024 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCmreWhS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC1F137903;
	Fri,  4 Oct 2024 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728040994; cv=none; b=C+vli1eocj+RWGytLH9LFmNcDL+Daa9bhy7L9uFAfKAwsKbiq5NfYW5TLfycXKK9c6gFhd80+KtH0ifb9Els8UW737jdF31zWrS2dRwZ9hqcc1ly0ezOOphc29sBkDVDm3oZo7VnzHAR+tiQPbZo9svYt781Ua0yBvAwWRX588c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728040994; c=relaxed/simple;
	bh=FPDeXS69RVVFOO6GElE3immQWcOn1hNA11DiG6YR6SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPU3pT+PxgcaX6D7G1VEBXPvo4ClNhlMc3DcXfN5dDTHa/l/KL2WBZw31iX34bWBGFXIEqDInyiaMfJgrA9kdVa5YdkHBZGYNUHi0hQueK3jElPc8nmOtbjUTI/SP8IH6f/fmXf89DSlgfWb8UJlisljoDfNmv1kQyrcRSU67ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCmreWhS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C61DC4CEC7;
	Fri,  4 Oct 2024 11:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728040994;
	bh=FPDeXS69RVVFOO6GElE3immQWcOn1hNA11DiG6YR6SM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kCmreWhS2rFa9uO79mNDHWA/QSLkAn6DrQpzcRfD5rgXFL2TuNGfARMPGZ8w6R2JD
	 QVlS45lADT4wVOW21pE5myD+W18R+n8eFQoQiSZtwV+RU1y6wm2YGIEYI6BJ1I2U0n
	 BqIxwFGvl+RhsuoqJS96inw0pPojmyPqYCXLJLMlP3n5+p7xJ37rTzRegCGmWyB2JS
	 8P/B3SYMHPiemASty47LmDTEnZ+EbTc2wX4X7XqTaBh+I2iKe9TQ/Zjt6J2B0OwEAb
	 2wFgfT7VX03CqkHK1LWYG1oudYbW0PH0NnGzVQ0r89eay0bcdHxdZiT4q5ezXT3zmd
	 i8EqcLzkRMa+g==
Date: Fri, 4 Oct 2024 12:23:09 +0100
From: Simon Horman <horms@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, alexis.lothore@bootlin.com
Subject: Re: [PATCH bpf-next] selftests, bpf: Skip MPLS test_tc_tunnel tests
 if MPLS is unavailable
Message-ID: <20241004112309.GB1545787@kernel.org>
References: <20240927-mpls-skip-v1-1-1bc38abf917e@kernel.org>
 <6c80ed1a-6b6f-4920-9b80-a25d8b40cca4@iogearbox.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c80ed1a-6b6f-4920-9b80-a25d8b40cca4@iogearbox.net>

On Wed, Oct 02, 2024 at 02:07:54PM +0200, Daniel Borkmann wrote:
> [ +Alexis ]
> 
> On 9/27/24 2:05 PM, Simon Horman wrote:
> > If MPLS is not available in the kernel then skip MPLS tests.
> > 
> > This avoids the test failing in situations where the test is not
> > supported by the underlying kernel.
> > 
> > In the case where all tests are run, just skip over the MPLS tests
> > without altering the exit code of the overall test run - there
> > is only one exit code in this scenario.
> > 
> > In the case where a single test is run, exit with KSFT_SKIP (4).
> > 
> > In both cases log an informative message.
> > 
> > Signed-off-by: Simon Horman <horms@kernel.org>
> 
> Are you running this as part of net selftests / CI which is why you
> need this? (And if yes, why excluding MPLS?)

Hi Daniel,

No, this was observed when running the test in a different harness.
I can find out why MPLS is excluded, but my assumption is because
it is not otherwise needed by the distro kernel that is being tested.

I entirely understand if that makes this patch out of scope for upstream.
Although having it upstream would be useful downstream.

> Alexis is working on converting tests like these into our BPF CI into
> test_progs, I'm not sure whether we need to make that more
> complex unless there is a compelling reason to exclude MPLS?

If the MPLS test(s) can somehow be excluded then that may meet the needs of
the test environment where this was observed, but I would need to check.

...

