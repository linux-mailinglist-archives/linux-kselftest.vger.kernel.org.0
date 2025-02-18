Return-Path: <linux-kselftest+bounces-26899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A0FA3A72C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 20:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AABA16F5BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 19:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B1127128E;
	Tue, 18 Feb 2025 19:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSGZJa4v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E05271265;
	Tue, 18 Feb 2025 19:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905879; cv=none; b=JWnuHVqEQ+JQpdgA6u67kvjqFlomSks09oJ+p8O1StDTj5aWh9izE+yXDdi5vlqTuvcqdVpmZJ+WXheMoEfeqw6tUV+JGgrY6/OocaplLb9ZEUW3laNfMWH3/eb96eZFk9DHngslHrBjKTejQA6/BoCQehkFVCXMcyf343d/2Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905879; c=relaxed/simple;
	bh=HAhbVYY0BFTrXeNHjiE12Hv0whhqsPdEA7Z/cepHjdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIP5Ighbnk/a8kPH5R59Cm7O2QgMkNW4/YcdFYphZRPTJtI5J0wbCYrnw9YBaK7mXadyqhGB6tba+2v6joaARa0Ual2Nlx65BejyZ7mFNmcZApraO2QwfoehlduNO3gsarUz/Xp0if5cjJZ7W7tAH5sljUeXGY234p4FCp9UcNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSGZJa4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95CAC4CEE2;
	Tue, 18 Feb 2025 19:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739905876;
	bh=HAhbVYY0BFTrXeNHjiE12Hv0whhqsPdEA7Z/cepHjdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HSGZJa4vmZo8KPPtt7ObQktcqNcxi/x/SlIp3NJC2JkgA2dKYg4o3yKvykS28TJ15
	 CB4z3E2c616rmn1e+KNqe+srNCiDHJlxjOpCLD59DK0B1BnofPoT89A1AL8QXSPecU
	 nnM295/8jhdbBvNPVxKg0Qmds9c+zHQLj+YV87ZPis3ChtApnLQPXkYsGrIYwHZ/Bq
	 dbVdfzzbNY3eybrLBEtzEahE2nKu8mLg5fJASUXCMtHP1Rj7lCN/lFa4Qw6kHrEm/M
	 JI4s31DmT5LIY4o0hLHat6Z+MAIuKIt5PIXnT+ZHnE+Je04QyTUeZSSuFu44k2jvwZ
	 rAnFrsTwJVRbQ==
Date: Tue, 18 Feb 2025 20:11:13 +0100
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
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
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
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
Message-ID: <Z7TbUbs4nvuLF-rq@x1>
References: <20250203-quiet_tools-v1-0-d25c8956e59a@rivosinc.com>
 <CAADnVQKTqRBQBA-yxB9EYPMgayP3rOE4iDhg+QD++2d=jxfY=Q@mail.gmail.com>
 <Z6JdwSsAk1xCiSrn@ghost>
 <Z6JksXDRh8OSAh-u@google.com>
 <CAADnVQKmKf6wY3dg+PfAxtrrFWGO7D-m83dEndjWksPfWDt5wQ@mail.gmail.com>
 <Z6Khl1rHIAb7wOXw@ghost>
 <CAEf4Bza5nKk6_fVY2vmJjZgPb40zB+R3REy8==ZLc98eg1iHTA@mail.gmail.com>
 <Z6pF5pkH_bqvDwMK@ghost>
 <CAEf4BzYqOtfOiYcHWRP44rwkrdzi3aMkjgD1-Td5DVAOLV=2kA@mail.gmail.com>
 <Z7TT7Jw5QDx2G81v@x1>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7TT7Jw5QDx2G81v@x1>

On Tue, Feb 18, 2025 at 07:39:44PM +0100, Arnaldo Carvalho de Melo wrote:
> On Mon, Feb 10, 2025 at 04:23:49PM -0800, Andrii Nakryiko wrote:
> > On Mon, Feb 10, 2025 at 10:31 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > On Wed, Feb 05, 2025 at 05:28:19PM -0800, Andrii Nakryiko wrote:
> > > > On Tue, Feb 4, 2025 at 3:24 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > > So, can you please check and fix?

> > > I think I am misunderstanding what you are saying. The patch that we are
> > > discussing on is the patch to fix this? You are showing the output from
> > > the patch that is being fixed in this series.

> > Ah, it's me getting confused. It was the earlier perf commit that
> > broke all this, makes sense. I just double-checked with your patches
> > applied locally. It indeed fixes the issue, LGTM.

> > Acked-by: Andrii Nakryiko <andrii@kernel.org>

> Thanks, b4 didn't pick this one, probably because you provided the Ack
> for a previous version of this series, but the patch in it is the same
> as in v2, so I'm keeping it, ok?

> Also since you applied the patches and tested it, can I promote the tag
> to Tested-by you?

> Humm, there is a slight difference, checking that in the e-mails
> thread...

> +  quiet = quiet_
> +  Q = @
> 
> The above doesn´t  have spaces surrounding the = sign, lemme see...

Got it, the comment about consistency, etc.

Can I use the Tested-by: for the v3 series?

- Arnaldo

