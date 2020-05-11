Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC0E1CD4E2
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 May 2020 11:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgEKJ15 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 May 2020 05:27:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728260AbgEKJ15 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 May 2020 05:27:57 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21A6B206E6;
        Mon, 11 May 2020 09:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589189277;
        bh=oqgSUGP9MR8xZApzgNfSSeMcrgiWYjklZNtwHFxto4M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zZ/MnKpipz2Wmf+CG2sWYdc/PG4RRutTEk8EEmhSnamy+IWovmhTb7USVthxrPZhZ
         FD4akhu3sVoZL21TND/PgEFvujvBLJVGdha/iLWAxQ25UqHh+wg0Ge2XSXLTfVseSd
         VoXNUv5FTEWNN017WQ69dU8FGDElRT5npNqAjWPM=
Date:   Mon, 11 May 2020 18:27:52 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>
Subject: Re: [PATCH 3/3] selftests/ftrace: Use /bin/echo instead of built-in
 echo
Message-Id: <20200511182752.c83f3454bcb3e205cf2bda4a@kernel.org>
In-Reply-To: <5EB8FD31.9020906@cn.fujitsu.com>
References: <158834025077.28357.15141584656220094821.stgit@devnote2>
        <158834028054.28357.398159034694277189.stgit@devnote2>
        <5EB3AE7C.5@cn.fujitsu.com>
        <20200507181505.3e8369ee39f14d9c74ec986b@kernel.org>
        <5EB8FD31.9020906@cn.fujitsu.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 11 May 2020 15:22:25 +0800
Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:

> On 2020/5/7 17:15, Masami Hiramatsu wrote:
> > On Thu, 7 May 2020 14:45:16 +0800
> > Xiao Yang<yangx.jy@cn.fujitsu.com>  wrote:
> >
> >> On 2020/5/1 21:38, Masami Hiramatsu wrote:
> >>> Since the built-in echo has different behavior in POSIX shell
> >>> (dash) and bash, we forcibly use /bin/echo -E (not interpret
> >>> backslash escapes) by default.
> >>>
> >>> This also fixes some test cases which expects built-in
> >>> echo command.
> >>>
> >>> Reported-by: Liu Yiding<yidingx.liu@intel.com>
> >>> Signed-off-by: Masami Hiramatsu<mhiramat@kernel.org>
> >>> ---
> >>>    tools/testing/selftests/ftrace/test.d/functions    |    3 +++
> >>>    .../test.d/trigger/trigger-trace-marker-hist.tc    |    2 +-
> >>>    .../trigger-trace-marker-synthetic-kernel.tc       |    4 ++++
> >>>    .../trigger/trigger-trace-marker-synthetic.tc      |    4 ++--
> >>>    4 files changed, 10 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> >>> index 5d4550591ff9..ea59b6ea2c3e 100644
> >>> --- a/tools/testing/selftests/ftrace/test.d/functions
> >>> +++ b/tools/testing/selftests/ftrace/test.d/functions
> >>> @@ -1,3 +1,6 @@
> >>> +# Since the built-in echo has different behavior in POSIX shell (dash) and
> >>> +# bash, we forcibly use /bin/echo -E (not interpret backslash escapes).
> >>> +alias echo="/bin/echo -E"
> >> Hi Masami, Steven
> >>
> >> It seems that only kprobe_syntax_errors.tc is impacted by the issue
> >> currently.  Is it necessary for all tests to use /bin/echo and could we
> >> just make kprobe_syntax_errors.tc use /bin/echo?
> >
> > Yes, I would like to unify the "echo"'s behavior among the testcases
> > instead of patching each failure in the future.
> > Or would you have any concern on it?
> Hi Masami,
> 
> Very sorry for the late reply.
> 
> We may not avoid fixing related failures after your change:
> 1) We have to reuse built-in echo (do alias echo=echo) if we want to 
> test common_pid for histogram.
> 2) We have to reuse built-in echo if some new tests want to interpret 
> backslash escapes in future.

1) yes, that's what I need to do for avoiding "pid" key histogram
  (but I think we should have better way to test it)
2) No, in that case you should use "/bin/echo -e" explicitly.
   dash's built-in echo doesn't support it.

> Is it simple to provide two implementations of echo?(built-in echo and 
> echo command?) and then just apply echo command for kprobe_syntax_errors.tc?

Hmm, OK, there might be another reason we reconsider this patch.

- Alisasing echo (this patch) can avoid dash related issues but
  this also makes "echo" running in another process implicitly.

- Using /bin/echo for backslash explicitly will be missed unless
  user runs it on dash, but it will keep "echo" in same process.

So both have pros/cons, but your idea will be locally effected.
OK, I'll retry it.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
