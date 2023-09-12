Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB9979C23E
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 04:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbjILCID (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 22:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237183AbjILCCB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 22:02:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570E41A39B8;
        Mon, 11 Sep 2023 18:32:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CD1C116A5;
        Tue, 12 Sep 2023 00:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694480101;
        bh=pk394n9RtIV5qTD4mKk5bHTM+hf+h7snLfIbE7KM/6Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fbhx40yjmI9aSaMuOfkOZ/nES/j3HkFuxKqsUdZDt5STPKSQ4eRujsa1C8TXEDwCU
         dvsMG6cxtUGCGooNAgAF2Zx/VEB7i35uEq12leuTMatfnbQUUMKBacDQoO3rpIp3CR
         o2zwaXUR2HwSXNWy6XfOBoPTTSdJy8Z+WrikoV7SgIsQhHVjZ/Ot5t0GrxHxZi8Afr
         vNofE8mOcRXp1ecpLyKfmP956PsNMSouyBmlaQHp342hO3EeSlFM2J7aC3gYHqzbZH
         AU9+D36vr0tt3mEfrj4oK2OYQPjiSScwjdYpDWf9zllvOJYdCedXQaqKHIGLVhhvUn
         hHzHfp5GwUe8A==
Date:   Tue, 12 Sep 2023 09:54:57 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [FIX PATCH] selftests: tracing: Fix to unmount tracefs for
 recovering environment
Message-Id: <20230912095457.e5b89f84e168ed06072ea3d5@kernel.org>
In-Reply-To: <20230911130909.6d3054af@gandalf.local.home>
References: <169425219871.184380.8584599358250186540.stgit@devnote2>
        <20230911130909.6d3054af@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 11 Sep 2023 13:09:09 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat,  9 Sep 2023 18:36:39 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Fix to unmount the tracefs if the ftracetest mounted it for recovering
> > system environment. If the tracefs is already mounted, this does nothing.
> > 
> > Suggested-by: Mark Brown <broonie@kernel.org>
> > Link: https://lore.kernel.org/all/29fce076-746c-4650-8358-b4e0fa215cf7@sirena.org.uk/
> > Fixes: cbd965bde74c ("ftrace/selftests: Return the skip code when tracing directory not configured in kernel")
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  tools/testing/selftests/ftrace/ftracetest |    8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> > index cb5f18c06593..89c212d82256 100755
> > --- a/tools/testing/selftests/ftrace/ftracetest
> > +++ b/tools/testing/selftests/ftrace/ftracetest
> > @@ -31,6 +31,9 @@ err_ret=1
> >  # kselftest skip code is 4
> >  err_skip=4
> >  
> > +# umount required
> > +UMOUNT_DIR=""
> > +
> >  # cgroup RT scheduling prevents chrt commands from succeeding, which
> >  # induces failures in test wakeup tests.  Disable for the duration of
> >  # the tests.
> > @@ -45,6 +48,9 @@ setup() {
> >  
> >  cleanup() {
> >    echo $sched_rt_runtime_orig > $sched_rt_runtime
> > +  if [ "${UMOUNT_DIR}" ]; then
> 
> Shouldn't the above be:
> 
>      if [ ! -z "${UNMOUNT_DIR}" ]; then
> 
> ?

I think both are good.
What about using '-n' explictly?

[ -n "${UNMOUNT_DIR}" ]

Thanks,

> 
> -- Steve
> 
> > +    umount ${UMOUNT_DIR} ||:
> > +  fi
> >  }
> >  
> >  errexit() { # message
> > @@ -160,11 +166,13 @@ if [ -z "$TRACING_DIR" ]; then
> >  	    mount -t tracefs nodev /sys/kernel/tracing ||
> >  	      errexit "Failed to mount /sys/kernel/tracing"
> >  	    TRACING_DIR="/sys/kernel/tracing"
> > +	    UMOUNT_DIR=${TRACING_DIR}
> >  	# If debugfs exists, then so does /sys/kernel/debug
> >  	elif [ -d "/sys/kernel/debug" ]; then
> >  	    mount -t debugfs nodev /sys/kernel/debug ||
> >  	      errexit "Failed to mount /sys/kernel/debug"
> >  	    TRACING_DIR="/sys/kernel/debug/tracing"
> > +	    UMOUNT_DIR=${TRACING_DIR}
> >  	else
> >  	    err_ret=$err_skip
> >  	    errexit "debugfs and tracefs are not configured in this kernel"
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
