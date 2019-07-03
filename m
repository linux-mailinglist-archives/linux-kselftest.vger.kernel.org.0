Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD7FE5DA42
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2019 03:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfGCBHe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jul 2019 21:07:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfGCBHe (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jul 2019 21:07:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AA5C20673;
        Wed,  3 Jul 2019 01:07:32 +0000 (UTC)
Date:   Tue, 2 Jul 2019 21:07:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     shuah <shuah@kernel.org>, Po-Hsu Lin <po-hsu.lin@canonical.com>,
        mingo@redhat.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: skip ftrace test if FTRACE was not
 enabled
Message-ID: <20190702210730.2c041882@gandalf.local.home>
In-Reply-To: <20190703091147.064029248fed5066ea5e5d2b@kernel.org>
References: <20190702062358.7330-1-po-hsu.lin@canonical.com>
        <4a44dd22-be88-ce5b-5c9b-6a3759b6c2eb@kernel.org>
        <20190703091147.064029248fed5066ea5e5d2b@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 3 Jul 2019 09:11:47 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Po-Hsu Lin,
> 
> On Tue, 2 Jul 2019 13:22:26 -0600
> shuah <shuah@kernel.org> wrote:
> 
> > Hi Po-Hsu Lin,
> > 
> > On 7/2/19 12:23 AM, Po-Hsu Lin wrote:  
> > > The ftrace test will need to have CONFIG_FTRACE enabled to make the
> > > ftrace directory available.
> > > 
> > > Add an additional check to skip this test if the CONFIG_FTRACE was not
> > > enabled.  
> 
> Sorry, NAK for config check.

Agreed, as  my test boxes do not hold the source code of the kernel
they are running.

> 
> > > 
> > > This will be helpful to avoid a false-positive test result when testing
> > > it directly with the following commad against a kernel that does not
> > > have CONFIG_FTRACE enabled:  
> 
> Would you know tools/testing/selftests/ftrace/config (and other config files
> in each tests) ?
> 
> Since each selftest depends specific configurations, those configs are
> written in config file, and tester must enable it using 
> "scripts/kconfig/merge_config.sh".
> 
> We can not check the kernel config in some cases, e.g. distro kernel,
> cross-build kernel, remote build kernel etc. Also, the .config file
> can be a config file for another kernel build.
> 
> So please take care of your kernel configuration. If you find any test
> failed even if you enable configs in config file under that test, please
> report it, since that is a bug.
> 
> 
> Thank you,
> 
> > >      make -C tools/testing/selftests TARGETS=ftrace run_tests
> > > 
> > > The test result on an Ubuntu KVM kernel will be changed from:
> > >      selftests: ftrace: ftracetest
> > >      ========================================
> > >      Error: No ftrace directory found
> > >      not ok 1..1 selftests: ftrace: ftracetest [FAIL]
> > > To:  
> > 
> > Thanks for the patch.
> > 
> > Check patch fails with the above To:
> > 
> > WARNING: Use a single space after To:
> > #107:
> > To:
> > 
> > ERROR: Unrecognized email address: ''
> > #107:
> > To:
> > 
> > total: 1 errors, 1 warnings, 23 lines checked
> > 
> > 
> > Please fix and send v2.
> >   
> > >      selftests: ftrace: ftracetest
> > >      ========================================
> > >      CONFIG_FTRACE was not enabled, test skipped.
> > >      not ok 1..1 selftests: ftrace: ftracetest [SKIP]
> > > 
> > > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> > > ---
> > >   tools/testing/selftests/ftrace/ftracetest | 11 ++++++++++-
> > >   1 file changed, 10 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> > > index 6d5e9e8..6c8322e 100755
> > > --- a/tools/testing/selftests/ftrace/ftracetest
> > > +++ b/tools/testing/selftests/ftrace/ftracetest
> > > @@ -7,6 +7,9 @@
> > >   #  Written by Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> > >   #  
> > 
> > Hmm. You havem't cc'ed Masami on this. Adding Masami.
> > 
> > I would think Masami should be on the Signed-off-by as well,
> > since he is the author.
> >   
> > >   
> > > +# Kselftest framework requirement - SKIP code is 4.
> > > +ksft_skip=4
> > > +
> > >   usage() { # errno [message]
> > >   [ ! -z "$2" ] && echo $2
> > >   echo "Usage: ftracetest [options] [testcase(s)] [testcase-directory(s)]"
> > > @@ -139,7 +142,13 @@ parse_opts $*
> > >   
> > >   # Verify parameters
> > >   if [ -z "$TRACING_DIR" -o ! -d "$TRACING_DIR" ]; then

I'm thinking if we didn't find the TRACING_DIR (-z "$TRACING_DIR"
returns true), then we exit with the skip. I don't believe we should be
testing ftrace if tracefs isn't even loaded. Or something like:

	err_ret=1
	err_skip=4

	errexit() {
	  echo "Error: $1" 1>&2
	  exit $err_ret
	}

	[..]

	if [ -z "$TRACING_DIR" ]; then
	  save_err=$err_ret
	  err_ret=$err_skip
	  mount -t tracefs nodev /sys/kernel/tracing ||
	    errexit "kernel does not have tracefs"
	  err_ret=$save_err
	  TRACING_DIR="/sys/kernel/tracing"
	fi
	if [ ! -d "$TRACING_DIR" ]; then
	  errexit "tracefs is not a directory?"
	fi

Would something like that work?

-- Steve


> > > -  errexit "No ftrace directory found"
> > > +  ftrace_enabled=`grep "^CONFIG_FTRACE=y" /lib/modules/$(uname -r)/build/.config`
> > > +  if [ -z "$ftrace_enabled" ]; then
> > > +    echo "CONFIG_FTRACE was not enabled, test skipped."
> > > +    exit $ksft_skip
> > > +  else
> > > +    errexit "No ftrace directory found"
> > > +  fi
> > >   fi
> > >   
> > >   # Preparing logs
> > >   
> > 
> > thanks,
> > -- Shuah  
> 
> 

