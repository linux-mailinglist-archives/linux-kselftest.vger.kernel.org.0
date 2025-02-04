Return-Path: <linux-kselftest+bounces-25721-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 283B7A27ACD
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 20:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A6B1884EB0
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 19:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC7A219A8E;
	Tue,  4 Feb 2025 19:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qm55WJ7V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD78216E19;
	Tue,  4 Feb 2025 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738695861; cv=none; b=auX9Xr00e/O6lHt6kQ7UhoNFsu6OybPxgpBbBb6Fr71DpPo2qxAm4ZznOjQMoLXru2d5/wgzvj8eGopcMsPRQZt1fUYjQHPCGGFifT6jMD5/31Sfj7Skc9ZG+BKaPcrct+HyfAuUMQiuXeIZWjKOyVlgYH+umKPfcCBkeqsaUoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738695861; c=relaxed/simple;
	bh=v8r4gg3IpnzC66jwjrXxr6aYUfmgZLy5LJ4cFgHuXWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufimIT3VUUQIrjmwRAP5ttDJCcKCey/XnGxlKmNKF9an6qSh2i+GDR3A8GlKrkyU7I4ubBCJ4NIe8zUeaa0uTVHWK5Dc7p/DFJ/uAeoe4ezE+xMBxhgMhGi1cLHKIW90OWOrTIIFk4lZomre968Nts1G1GITAWhQrb0wMMz5bUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qm55WJ7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A038BC4CEE6;
	Tue,  4 Feb 2025 19:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738695860;
	bh=v8r4gg3IpnzC66jwjrXxr6aYUfmgZLy5LJ4cFgHuXWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qm55WJ7V++ofH+9NdJIp2TUVPrgUBOq3LYr0DXa0rfxPMshEJdxIA1e6+0WNngOo6
	 g0wvmw5eeQJyGSGZxqCw76SPDx2aEaYvrlfDdhRqVaIQrs37h09DmmdUHHfoUky1NE
	 eyA+BL6k7iwn8iXkhIWfL8nQCgrqUR4a34o90tjkKmqHJbyYZLf9R/lNjTMl0K7jVR
	 OoZtK/QrD7Pb3ftUogY/lomBj+fMekVJ/wvBTMc2xiuQe69zrLYHMFhV09OIlxNvmf
	 NFVy+myPKj4Hh8ktc1Fk/Cup/FIQ4BSfTdzd17nViB1zBZ2b6r3EtZ84FQOj/xmJKg
	 TNKfxMx0CGclg==
Date: Tue, 4 Feb 2025 11:04:17 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Quentin Monnet <qmo@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-perf-use." <linux-perf-users@vger.kernel.org>,
	Linux Power Management <linux-pm@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] tools: Unify top-level quiet infrastructure
Message-ID: <Z6JksXDRh8OSAh-u@google.com>
References: <20250203-quiet_tools-v1-0-d25c8956e59a@rivosinc.com>
 <CAADnVQKTqRBQBA-yxB9EYPMgayP3rOE4iDhg+QD++2d=jxfY=Q@mail.gmail.com>
 <Z6JdwSsAk1xCiSrn@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6JdwSsAk1xCiSrn@ghost>

Hello,

On Tue, Feb 04, 2025 at 10:34:41AM -0800, Charlie Jenkins wrote:
> On Tue, Feb 04, 2025 at 05:18:42PM +0000, Alexei Starovoitov wrote:
> > On Tue, Feb 4, 2025 at 12:10 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > >
> > > The quiet infrastructure was moved out of Makefile.build to accomidate
> > > the new syscall table generation scripts in perf. Syscall table
> > > generation wanted to also be able to be quiet, so instead of again
> > > copying the code to set the quiet variables, the code was moved into
> > > Makefile.perf to be used globally. This was not the right solution. It
> > > should have been moved even further upwards in the call chain.
> > > Makefile.include is imported in many files so this seems like a proper
> > > place to put it.
> > >
> > > To:
> > >
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > > Charlie Jenkins (2):
> > >       tools: Unify top-level quiet infrastructure
> > >       tools: Remove redundant quiet setup
> > >
> > >  tools/arch/arm64/tools/Makefile           |  6 -----
> > >  tools/bpf/Makefile                        |  6 -----
> > >  tools/bpf/bpftool/Documentation/Makefile  |  6 -----
> > >  tools/bpf/bpftool/Makefile                |  6 -----
> > >  tools/bpf/resolve_btfids/Makefile         |  2 --
> > >  tools/bpf/runqslower/Makefile             |  5 +---
> > >  tools/build/Makefile                      |  8 +-----
> > >  tools/lib/bpf/Makefile                    | 13 ----------
> > 
> > Nack.
> > libbpf and bpftool are synced independently to github
> > and released from there.
> > This change breaks it.

Sorry, I overlooked this part and merged a change that touched the
common files into the perf tree.

f2868b1a66d4f40f ("perf tools: Expose quiet/verbose variables in Makefile.perf")

Unfortunately, it's already in v6.14-rc1.

> 
> Can you explain how it breaks it? Currently bpftool and resolve_btfids
> don't build quietly so this was an attempt to fix that.

So I think you will need something like this for v6.14.  Again, sorry
about the trouble.

Thanks,
Namhyung


