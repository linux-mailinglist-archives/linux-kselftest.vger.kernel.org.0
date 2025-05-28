Return-Path: <linux-kselftest+bounces-33938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9518AC6B04
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 15:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0593A45F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 13:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37A92874F5;
	Wed, 28 May 2025 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNur76GO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A532014E2F2;
	Wed, 28 May 2025 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748440298; cv=none; b=dW3ZboZUmTfFgLycoVA+DfAD6WmZl6TMncjVxG31eBnjCcbsdjPfnSgNJ6BQufj13QLPjVTBwgsHBncpNXZeEXbztunFbYuERH33ylL2mHz2l3cMUPbRcXIh1S7I7Lo8V5X+ftfobA5ZSqHMKIzstMzPOdTavuuDF5AEWl4k5So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748440298; c=relaxed/simple;
	bh=IyUnagWMTY5SZb2DJi6QqqYHDlcgl8CuOOKESJjMUKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCLL+0TM2iJdgEzvgH8t0gigLs0OFmO66tGhgrT9a1Rcdb1muTrd3HNkWMMJDvAKisHWbrP8PRhvNssjA5KG0ncDluTfOYQL6NFYjMvMj+Y7dbVYvJuq9HcW3n4+aNFzW7MTlJQt2IfIXY+Ql9aYebZ3KfCcrAQ+bJZgqvGrRNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNur76GO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF43BC4CEE3;
	Wed, 28 May 2025 13:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748440298;
	bh=IyUnagWMTY5SZb2DJi6QqqYHDlcgl8CuOOKESJjMUKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sNur76GODkMQtGVGYj5tKo2ZIGjq4ng3Yz9ArlQwegmbDTfT2R6m+1T3xCxPlwC/4
	 hdSBN9kU54Z2/Hj3qUJoNaEmxaJnzczmcYhwIK6tAXxpj8lLRh231notuOLRQkuw05
	 VjwEotsDhDNBcK3+jLFspYqvOMck2XUUWnNCKyCZmUxvUzFMwA2G+Q/gg5fXIoZ52B
	 fKpXNm8g/Pj96OlXk5ygerjZkjpErmQ5v6Bj0gAiblsRAKKArgomGjOIAiY4gC7yTm
	 WB6Tl4oqvpHxMglVCgWfl976As/v4pCGzuTNjg16syBd+jMcgmgiK+O9KLWBJ16FA5
	 GA9E23sGFUFxQ==
Date: Wed, 28 May 2025 10:51:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH RFC net-next v2] page_pool: import Jesper's page_pool
 benchmark
Message-ID: <aDcU51dx0N9d-aHz@x1>
References: <20250525034354.258247-1-almasrymina@google.com>
 <87iklna61r.fsf@toke.dk>
 <CAHS8izOSW8dZpqgKT=ZxqpctVE3Y9AyR8qXyBGvdW0E8KFgonA@mail.gmail.com>
 <87h615m6cp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h615m6cp.fsf@toke.dk>

On Wed, May 28, 2025 at 11:28:54AM +0200, Toke Høiland-Jørgensen wrote:
> Mina Almasry <almasrymina@google.com> writes:
> > On Mon, May 26, 2025 at 5:51 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> >> Back when you posted the first RFC, Jesper and I chatted about ways to
> >> avoid the ugly "load module and read the output from dmesg" interface to
> >> the test.

> > I agree the existing interface is ugly.

> >> One idea we came up with was to make the module include only the "inner"
> >> functions for the benchmark, and expose those to BPF as kfuncs. Then the
> >> test runner can be a BPF program that runs the tests, collects the data
> >> and passes it to userspace via maps or a ringbuffer or something. That's
> >> a nicer and more customisable interface than the printk output. And if
> >> they're small enough, maybe we could even include the functions into the
> >> page_pool code itself, instead of in a separate benchmark module?

> >> WDYT of that idea? :)

> > ...but this sounds like an enormous amount of effort, for something
> > that is a bit ugly but isn't THAT bad. Especially for me, I'm not that
> > much of an expert that I know how to implement what you're referring
> > to off the top of my head. I normally am open to spending time but
> > this is not that high on my todolist and I have limited bandwidth to
> > resolve this :(

> > I also feel that this is something that could be improved post merge.

agreed

> > I think it's very beneficial to have this merged in some form that can
> > be improved later. Byungchul is making a lot of changes to these mm
> > things and it would be nice to have an easy way to run the benchmark
> > in tree and maybe even get automated results from nipa. If we could
> > agree on mvp that is appropriate to merge without too much scope creep
> > that would be ideal from my side at least.
 
> Right, fair. I guess we can merge it as-is, and then investigate whether
> we can move it to BPF-based (or maybe 'perf bench' - Cc acme) later :)

tldr; I'd advise to merge it as-is, then kfunc'ify parts of it and use
it from a 'perf bench' suite.

Yeah, the model would be what I did for uprobes, but even then there is
a selftests based uprobes benchmark ;-)

The 'perf bench' part, that calls into the skel:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/bench/uprobe.c

The skel:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/bpf_skel/bench_uprobe.bpf.c

While this one is just to generate BPF load to measure the impact on
uprobes, for your case it would involve using a ring buffer to
communicate from the skel (BPF/kernel side) to the userspace part,
similar to what is done in various other BPF based perf tooling
available in:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/bpf_skel

Like at this line (BPF skel part):

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/bpf_skel/off_cpu.bpf.c?h=perf-tools-next#n253

The simplest part is in the canonical, standalone runqslower tool, also
hosted in the kernel sources:

BPF skel sending stuff to userspace:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/bpf/runqslower/runqslower.bpf.c#n99

The userspace part that reads it:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/bpf/runqslower/runqslower.c#n90

This is a callback that gets called for every event that the BPF skel
produces, called from this loop:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/bpf/runqslower/runqslower.c#n162

That handle_event callback was associated via:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/bpf/runqslower/runqslower.c#n153

There is a dissection I did about this process a long time ago, but
still relevant, I think:

http://oldvger.kernel.org/~acme/bpf/devconf.cz-2020-BPF-The-Status-of-BTF-producers-consumers/#/33

The part explaining the interaction userspace/kernel starts here:

http://oldvger.kernel.org/~acme/bpf/devconf.cz-2020-BPF-The-Status-of-BTF-producers-consumers/#/40

(yeah, its http, but then, its _old_vger ;-)

Doing it in perf is interesting because it gets widely packaged, so
whatever you add to it gets visibility for people using 'perf bench' and
also gets available in most places, it would add to this collection:

root@number:~# perf bench
Usage: 
	perf bench [<common options>] <collection> <benchmark> [<options>]

        # List of all available benchmark collections:

         sched: Scheduler and IPC benchmarks
       syscall: System call benchmarks
           mem: Memory access benchmarks
          numa: NUMA scheduling and MM benchmarks
         futex: Futex stressing benchmarks
         epoll: Epoll stressing benchmarks
     internals: Perf-internals benchmarks
    breakpoint: Breakpoint benchmarks
        uprobe: uprobe benchmarks
           all: All benchmarks

root@number:~#

the 'perf bench' that uses BPF skel:

root@number:~# perf bench uprobe baseline
# Running 'uprobe/baseline' benchmark:
# Executed 1,000 usleep(1000) calls
     Total time: 1,050,383 usecs

 1,050.383 usecs/op
root@number:~# perf trace  --summary perf bench uprobe trace_printk
# Running 'uprobe/trace_printk' benchmark:
# Executed 1,000 usleep(1000) calls
     Total time: 1,053,082 usecs

 1,053.082 usecs/op

 Summary of events:

 uprobe-trace_pr (1247691), 3316 events, 96.9%

   syscall            calls  errors  total       min       avg       max       stddev
                                     (msec)    (msec)    (msec)    (msec)        (%)
   --------------- --------  ------ -------- --------- --------- ---------     ------
   clock_nanosleep     1000      0  1101.236     1.007     1.101    50.939      4.53%
   close                 98      0    32.979     0.001     0.337    32.821     99.52%
   perf_event_open        1      0    18.691    18.691    18.691    18.691      0.00%
   mmap                 209      0     0.567     0.001     0.003     0.007      2.59%
   bpf                   38      2     0.380     0.000     0.010     0.092     28.38%
   openat                65      0     0.171     0.001     0.003     0.012      7.14%
   mprotect              56      0     0.141     0.001     0.003     0.008      6.86%
   read                  68      0     0.082     0.001     0.001     0.010     11.60%
   fstat                 65      0     0.056     0.001     0.001     0.003      5.40%
   brk                   10      0     0.050     0.001     0.005     0.012     24.29%
   pread64                8      0     0.042     0.001     0.005     0.021     49.29%
<SNIP other syscalls>

root@number:~#

- Arnaldo

