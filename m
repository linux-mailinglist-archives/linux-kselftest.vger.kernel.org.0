Return-Path: <linux-kselftest+bounces-40402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C9CB3DB98
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 09:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59017189C8F3
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 07:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0FA2EDD5E;
	Mon,  1 Sep 2025 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ay1qEhOq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EDF2EDD53;
	Mon,  1 Sep 2025 07:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756713433; cv=none; b=RrNfkCJG2W7/9o0SpcCxwxd2xZtmDz7rcyPQP1DElqnth9JO3t9UfYuEbsbnuGxJf7xnFy6zLLQpJ8b/BxQ5EByksO0uxGodScs22LQ1LyQtAAdPIUM8VAIvXq5iIkM0C9bPUTPulyBYAVP0stfESiql9jHamdwqhAPYa7YLso8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756713433; c=relaxed/simple;
	bh=6cf6IP3Zyu1K8Nz0C795sQp5Ekxuv1v5U19u2AtF0Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5SjAOmYVTfDa915xFzvfbsGzQUyz/qsXK4jfb+SepPHH9C0NEtDOcq9wLzEGYYRupwzk2SodLyFQux8yj3vq1ZOmS+QwXKvfjDU+kZno6lixPjwiLvrEEpTtU+oUnB6/e5/+twAf3ipoivuFFf+R5Qan7w25sMMRdbWgghFhuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ay1qEhOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B774C4CEF0;
	Mon,  1 Sep 2025 07:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756713432;
	bh=6cf6IP3Zyu1K8Nz0C795sQp5Ekxuv1v5U19u2AtF0Mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ay1qEhOqJl1chGeEzlvrxLvyH0AGc2YoqIWlKtLJF5EMJwbDSJYaNBCEjxRn3iROt
	 n0Eb+SeWq747Noh/t8m7YK0tnGYhRUB5lNSTtft9X2ooJwbb+FrLICsD7vb93VDSgQ
	 Ji2CP7IvnOUnCdUccPH/ktqgUsnYlxantdVOWCORGOH/Lsude3RGRkWq8P5y18SeOE
	 UzyWLm7RjzBab8QRoDzzKtGXVmzi9Otli8nk8oHtHY4RI1AwZZLHmRCd25s+BVabLp
	 osfA0RbQGqceXFwzVEg9uVvCT0zIwNYDWCIUz3m7dBocWnwc6drDH5cD8tLTbxgpc+
	 0kbSEKm/J/egw==
Date: Mon, 1 Sep 2025 00:57:07 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Ian Rogers <irogers@google.com>, Blake Jones <blakejones@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
	ihor.solodrai@linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH v3 1/2] libbpf: add support for printing BTF character
 arrays as strings
Message-ID: <aLVR0-CUGgwHvFpF@google.com>
References: <20250603203701.520541-1-blakejones@google.com>
 <174915723301.3244853.343931856692302765.git-patchwork-notify@kernel.org>
 <CAP-5=fWJQcmUOP7MuCA2ihKnDAHUCOBLkQFEkQES-1ZZTrgf8Q@mail.gmail.com>
 <466d45ae-ce97-4256-9444-9f25f3328c51@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <466d45ae-ce97-4256-9444-9f25f3328c51@linux.dev>

Hello,

On Sun, Aug 31, 2025 at 09:17:34PM -0700, Yonghong Song wrote:
> 
> 
> On 8/29/25 10:19 PM, Ian Rogers wrote:
> > On Thu, Jun 5, 2025 at 2:00 PM <patchwork-bot+netdevbpf@kernel.org> wrote:
> > > Hello:
> > > 
> > > This series was applied to bpf/bpf-next.git (master)
> > > by Andrii Nakryiko <andrii@kernel.org>:
> > > 
> > > On Tue,  3 Jun 2025 13:37:00 -0700 you wrote:
> > > > The BTF dumper code currently displays arrays of characters as just that -
> > > > arrays, with each character formatted individually. Sometimes this is what
> > > > makes sense, but it's nice to be able to treat that array as a string.
> > > > 
> > > > This change adds a special case to the btf_dump functionality to allow
> > > > 0-terminated arrays of single-byte integer values to be printed as
> > > > character strings. Characters for which isprint() returns false are
> > > > printed as hex-escaped values. This is enabled when the new ".emit_strings"
> > > > is set to 1 in the btf_dump_type_data_opts structure.
> > > > 
> > > > [...]
> > > Here is the summary with links:
> > >    - [v3,1/2] libbpf: add support for printing BTF character arrays as strings
> > >      https://git.kernel.org/bpf/bpf-next/c/87c9c79a02b4
> > >    - [v3,2/2] Tests for the ".emit_strings" functionality in the BTF dumper.
> > >      https://git.kernel.org/bpf/bpf-next/c/a570f386f3d1
> > > 
> > > You are awesome, thank you!
> > I believe this patch is responsible for segvs occurring in v6.17 in
> > various perf tests when the perf tests run in parallel. There's lots
> 
> Could you share the command line to reproduce this failure?
> This will help debugging. Thanks!

My reproducer is below:

terminal 1: run perf trace in a loop.

  $ while true; do sudo ./perf trace true; done

terminal 2: run perf record in a loop until hit the segfault.

  $ while true; do sudo ./perf record true || break; done
  ...
  perf: Segmentation fault
      #0 0x560b2db790e4 in dump_stack debug.c:366
      #1 0x560b2db7915a in sighandler_dump_stack debug.c:378
      #2 0x560b2d973b1b in sigsegv_handler builtin-record.c:722
      #3 0x7f975f249df0 in __restore_rt libc_sigaction.c:0
      #4 0x560b2dca1ee6 in snprintf_hex bpf-event.c:39
      #5 0x560b2dca2306 in synthesize_bpf_prog_name bpf-event.c:144
      #6 0x560b2dca2d92 in bpf_metadata_create bpf-event.c:401
      #7 0x560b2dca3838 in perf_event__synthesize_one_bpf_prog bpf-event.c:673
      #8 0x560b2dca3dd5 in perf_event__synthesize_bpf_events bpf-event.c:798
      #9 0x560b2d977ef5 in record__synthesize builtin-record.c:2131
      #10 0x560b2d9797c1 in __cmd_record builtin-record.c:2581
      #11 0x560b2d97db30 in cmd_record builtin-record.c:4376
      #12 0x560b2da0672e in run_builtin perf.c:349
      #13 0x560b2da069c6 in handle_internal_command perf.c:401
      #14 0x560b2da06b1f in run_argv perf.c:448
      #15 0x560b2da06e68 in main perf.c:555
      #16 0x7f975f233ca8 in __libc_start_call_main libc_start_call_main.h:74
      #17 0x7f975f233d65 in __libc_start_main_alias_2 libc-start.c:128
      #18 0x560b2d959b11 in _start perf[4cb11]


I manually ran it with gdb to get some more hints.

  Thread 1 "perf" received signal SIGSEGV, Segmentation fault.
  0x00005555558e8ee6 in snprintf_hex (buf=0x5555562c1d79 "", size=503, data=0x40 <error: Cannot access memory at address 0x40>, len=8)
      at util/bpf-event.c:39
  39			ret += snprintf(buf + ret, size - ret, "%02x", data[i]);

The data is bpf_prog_info->prog_tags and it's called from
synthesize_bpf_prog_name().

  (gdb) bt
  #0  0x00005555558e8ee6 in snprintf_hex (buf=0x5555562c1d79 "", size=503, data=0x40 <error: Cannot access memory at address 0x40>, 
      len=8) at util/bpf-event.c:39
  #1  0x00005555558e9306 in synthesize_bpf_prog_name (buf=0x5555562c1d70 "bpf_prog_", size=512, info=0x55555665e400, btf=0x5555562c5630, 
      sub_id=0) at util/bpf-event.c:144
  #2  0x00005555558e9db5 in bpf_metadata_create (info=0x55555665e400) at util/bpf-event.c:403
  #3  0x00005555558ea85b in perf_event__synthesize_one_bpf_prog (session=0x555556178510, 
      process=0x5555555ba7ab <process_synthesized_event>, machine=0x555556178728, fd=25, event=0x5555561b73a0, 
      opts=0x5555560d33a8 <record+328>) at util/bpf-event.c:674
  #4  0x00005555558eadf8 in perf_event__synthesize_bpf_events (session=0x555556178510, 
      process=0x5555555ba7ab <process_synthesized_event>, machine=0x555556178728, opts=0x5555560d33a8 <record+328>)
      at util/bpf-event.c:799
  #5  0x00005555555beef5 in record__synthesize (rec=0x5555560d3260 <record>, tail=false) at builtin-record.c:2131
  #6  0x00005555555c07c1 in __cmd_record (rec=0x5555560d3260 <record>, argc=1, argv=0x7fffffffe2e0) at builtin-record.c:2581
  #7  0x00005555555c4b30 in cmd_record (argc=1, argv=0x7fffffffe2e0) at builtin-record.c:4376
  #8  0x000055555564d72e in run_builtin (p=0x5555560d63c0 <commands+288>, argc=6, argv=0x7fffffffe2e0) at perf.c:349
  #9  0x000055555564d9c6 in handle_internal_command (argc=6, argv=0x7fffffffe2e0) at perf.c:401
  #10 0x000055555564db1f in run_argv (argcp=0x7fffffffe0dc, argv=0x7fffffffe0d0) at perf.c:445
  #11 0x000055555564de68 in main (argc=6, argv=0x7fffffffe2e0) at perf.c:553
  
I seems bpf_prog_info is broken for some reason.

  (gdb) up
  #1  0x00005555558e9306 in synthesize_bpf_prog_name (buf=0x5555563305b0 "bpf_prog_", size=512, info=0x55555664e1d0, btf=0x55555637ad40, 
      sub_id=0) at util/bpf-event.c:144
  144		name_len += snprintf_hex(buf + name_len, size - name_len,
  
  (gdb) p *info
  $1 = {type = 68, id = 80, tag = "\\\000\000\000\214\000\000", jited_prog_len = 152, xlated_prog_len = 164, 
    jited_prog_insns = 824633721012, xlated_prog_insns = 1185410973912, load_time = 1305670058276, created_by_uid = 352, 
    nr_map_ids = 364, map_ids = 1975684956608, name = "\330\001\000\000\350\001\000\000$\002\000\0004\002\000", ifindex = 576, 
    gpl_compatible = 0, netns_dev = 2697239462496, netns_ino = 2834678416000, nr_jited_ksyms = 756, nr_jited_func_lens = 768, 
    jited_ksyms = 3418793968396, jited_func_lens = 3573412791092, btf_id = 844, func_info_rec_size = 880, func_info = 3934190044028, 
    nr_func_info = 928, nr_line_info = 952, line_info = 4294967296988, jited_line_info = 4449586119680, nr_jited_line_info = 1060, 
    line_info_rec_size = 1076, jited_line_info_rec_size = 1092, nr_prog_tags = 1108, prog_tags = 4861902980192, 
    run_time_ns = 5085241279632, run_cnt = 5257039971512, recursion_misses = 5360119186644, verified_insns = 1264, 
    attach_btf_obj_id = 1288, attach_btf_id = 1312}
  
Thanks,
Namhyung


