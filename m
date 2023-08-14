Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A95D77C36C
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 00:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjHNW1v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 18:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbjHNW1j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 18:27:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5033172A;
        Mon, 14 Aug 2023 15:27:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6172564471;
        Mon, 14 Aug 2023 22:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD8EC433C7;
        Mon, 14 Aug 2023 22:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692052053;
        bh=0fnFycsp+cxrB4yPF5CY210ONMPigh/YYczjbzdoji8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RmLN0bNHD+2ykeS6cn0mPLDZE9N9QMJzDLjDISxEP5QrTkRRGBFtt9oqAO3mDEqZ+
         mqslxrr7nbuDccA8TA0rj9MT+48oc/DYy+fEaiZYNkaMwRYi4HpBl32NLv87FAda2/
         w6NAyYHbuAqZnbwErxOgtfwL/Id9A+O035FLWwyZfJZ4JxAVh+99DYM5HztnW/JEVQ
         QPzj04w9fhFMPCzVbOG8I+UW0czD1IRM9xDVjR7SoeJYg3E0j/Q4k0qF9xYLlOCzIk
         JSyVPz1bgPWr0/KV/0D2qDJJ7m6VnJ+MbVWZVRJDUPyNRatauUDZ+LmqDH7Vrl86i6
         hpr4uepHaswmw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 57368CE039C; Mon, 14 Aug 2023 15:27:33 -0700 (PDT)
Date:   Mon, 14 Aug 2023 15:27:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Joel <agnel.joel@gmail.com>,
        rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] rcutorture: Copy out ftrace into its own console file
Message-ID: <5bc1a075-db78-4ecd-af06-77555f4184bc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230813203602.GA696907@google.com>
 <8f952ce7-2122-45a4-82a3-a4e4dcd85ff4@paulmck-laptop>
 <CAEXW_YSr2Pg8cw2zrYaoRn8DQgSzM=7DhsPeO8=MMdsA6tN0zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YSr2Pg8cw2zrYaoRn8DQgSzM=7DhsPeO8=MMdsA6tN0zg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 14, 2023 at 06:03:24PM -0400, Joel Fernandes wrote:
> On Mon, Aug 14, 2023 at 5:27 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Sun, Aug 13, 2023 at 08:36:02PM +0000, Joel Fernandes (Google) wrote:
> > > From: Joel Fernandes (Google) <joel@joelfernandes.org>
> > >
> > > Often times during debugging, it is difficult to jump to the ftrace dump
> > > in the console log and treat it independent of the result of the log file.
> > > Copy the contents of the buffers into its own file to make it easier to refer
> > > to the ftrace dump. The original ftrace dump is still available in the
> > > console log if it is desired to refer to it there.
> > >
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >
> > Queued, thank you!  I did the usual wordsmithing, please see below.
> >
> > I also fixed up the indentation and spacing.  I don't know about you,
> > but the initial format made that a bit hard for me to read.  ;-)
> >
> > If there are multiple ftrace dumps in a given console.log file, this
> > will concatenate them.  Is that the intent?
> 
> How would you have multiple dumps, do you mean from subsequent
> (re)boots? If so, yes I am OK with that. I usually look at the latest
> boot attempt.

Fair, but how would you separate out the ftrace dump for the most
recent kernel boot?  (Though please see below.)

> I was also thinking of us stopping boot loops. For example, if there
> is a kernel issue and the system keeps rebooting, it will run forever
> in the boot loop silently. It would be good for monitoring of
> console.log and kill the test if the console.log is acting 'weird'.
> Also it would be good if the console.log had a huge timestamp gap in
> it like the TREE04 issue. Would such changes be good to make? I can
> attempt something.

Boot loops can indeed be irritating.  So I created this commit:

10f84c2cfb50 ("torture: Avoid torture-test reboot loops")

This passes -no-reboot to qemu, which causes qemu to just stop when
it would otherwise reboot.  Much nicer!

The multiple-ftrace-dump issue could still appear should some torture
test decide to turn tracing back on at some point, perhaps in response
to a yet-as-unthought-of module parameter.

Should this ever be a problem, one approach would be to leave the
beginning/end markers and/or number them.

> > commit ce1cf26540b96fc52aec6f6f8e365960ca79a0ad
> > Author: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Date:   Sun Aug 13 20:36:02 2023 +0000
> >
> >     rcutorture: Copy out ftrace into its own console file
> >
> >     When debugging it can be difficult to quickly find the ftrace dump
> >     withiin the console log, which in turn makes it difficult to process it
> 
> Nit: within.

Ouch, will fix on next rebase.

> >     independent of the result of the console output.  This commit therefore
> >     copies the contents of the buffers into its own file to make it easier
> >     to locate and process the ftrace dump. The original ftrace dump is still
> >     available in the console log in cases where it is more convenient to
> >     process it there, for example, when you have a script that processes
> >     console output as well as ftrace-dump data.
> >
> >     Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >
> > diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
> > old mode 100644
> > new mode 100755
> > index b8e2ea23cb3f..40bcddf5f197
> > --- a/tools/testing/selftests/rcutorture/bin/functions.sh
> > +++ b/tools/testing/selftests/rcutorture/bin/functions.sh
> > @@ -331,3 +331,27 @@ specify_qemu_net () {
> >                 echo $1 -net none
> >         fi
> >  }
> > +
> > +# Extract the ftrace output from the console log output
> > +# The ftrace output looks in the logs looks like:
> 
> My bad:  s/output looks/output/

Will fix on next rebase.

It is the "simple" ones that bite you!  ;-)

							Thanx, Paul

> Thanks,
> 
>  - Joel
> 
> 
> > +# Dumping ftrace buffer:
> > +# ---------------------------------
> > +# [...]
> > +# ---------------------------------
> > +extract_ftrace_from_console() {
> > +       awk '
> > +       /Dumping ftrace buffer:/ {
> > +               capture = 1
> > +               next
> > +       }
> > +       /---------------------------------/ {
> > +               if (capture == 1) {
> > +                       capture = 2
> > +                       next
> > +               } else if (capture == 2) {
> > +                       capture = 0
> > +               }
> > +       }
> > +       capture == 2
> > +       ' "$1";
> > +}
> > diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
> > index 9ab0f6bc172c..e3d2f69ec0fb 100755
> > --- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
> > +++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
> > @@ -182,3 +182,10 @@ if ! test -s $file.diags
> >  then
> >         rm -f $file.diags
> >  fi
> > +
> > +# Call extract_ftrace_from_console function, if the output is empty,
> > +# don't create $file.ftrace. Otherwise output the results to $file.ftrace
> > +extract_ftrace_from_console $file > $file.ftrace
> > +if [ ! -s $file.ftrace ]; then
> > +       rm -f $file.ftrace
> > +fi
