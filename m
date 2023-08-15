Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291CF77D253
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 20:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbjHOSrj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 14:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239482AbjHOSrg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 14:47:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B13A1FFE;
        Tue, 15 Aug 2023 11:46:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7A7365F40;
        Tue, 15 Aug 2023 18:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2618CC433C8;
        Tue, 15 Aug 2023 18:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692125103;
        bh=4Jomr4gCrNnqnTuj8pTVmvP64aKJyUUZ7vwOR+18rjU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VD3qmRekk+HzxKL9MktxzoZ1sfcLvMSf1bODMvYKn1K4gcWdmjHajk+ami5nItuCT
         fE4VhnqWFFJVrVcBPgqD2rxBAWfc5e0YRuAz6F6Txv+eAKiweydeEUUSMX031qvCd+
         Qem+if1zN+UDWYo12A3st6vYSfnLCBA4okzDaYoXK6mgDiNiyTa2uLdvQj43842qaj
         lZtILyZWk94uicqs7o+h3KkvBDpsgEfnvhcTwo6bYecpwGyzZ+PIJ0VkaFu4Lt09VT
         dx9AOd4o+OfaGNTFmJB6CaOsQ4lKIF84iTKe/NBzxx9VE/Yx4DKsVg0pw7VgCZo90D
         bMl3er/pAUhQA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AFD46CE09C4; Tue, 15 Aug 2023 11:45:02 -0700 (PDT)
Date:   Tue, 15 Aug 2023 11:45:02 -0700
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
Message-ID: <0e4ddb9b-5dbd-4138-ab90-c87904764775@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230813203602.GA696907@google.com>
 <8f952ce7-2122-45a4-82a3-a4e4dcd85ff4@paulmck-laptop>
 <CAEXW_YSr2Pg8cw2zrYaoRn8DQgSzM=7DhsPeO8=MMdsA6tN0zg@mail.gmail.com>
 <5bc1a075-db78-4ecd-af06-77555f4184bc@paulmck-laptop>
 <20230815021439.GA2320449@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230815021439.GA2320449@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 15, 2023 at 02:14:39AM +0000, Joel Fernandes wrote:
> Hi Paul,
> 
> On Mon, Aug 14, 2023 at 03:27:33PM -0700, Paul E. McKenney wrote:
> > On Mon, Aug 14, 2023 at 06:03:24PM -0400, Joel Fernandes wrote:
> > > On Mon, Aug 14, 2023 at 5:27 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Sun, Aug 13, 2023 at 08:36:02PM +0000, Joel Fernandes (Google) wrote:
> > > > > From: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > >
> > > > > Often times during debugging, it is difficult to jump to the ftrace dump
> > > > > in the console log and treat it independent of the result of the log file.
> > > > > Copy the contents of the buffers into its own file to make it easier to refer
> > > > > to the ftrace dump. The original ftrace dump is still available in the
> > > > > console log if it is desired to refer to it there.
> > > > >
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > >
> > > > Queued, thank you!  I did the usual wordsmithing, please see below.
> > > >
> > > > I also fixed up the indentation and spacing.  I don't know about you,
> > > > but the initial format made that a bit hard for me to read.  ;-)
> > > >
> > > > If there are multiple ftrace dumps in a given console.log file, this
> > > > will concatenate them.  Is that the intent?
> > > 
> > > How would you have multiple dumps, do you mean from subsequent
> > > (re)boots? If so, yes I am OK with that. I usually look at the latest
> > > boot attempt.
> > 
> > Fair, but how would you separate out the ftrace dump for the most
> > recent kernel boot?  (Though please see below.)
> 
> It will print the same markers in console.log which can be used. I posted an
> updated diff below.
> 
> > 
> > > I was also thinking of us stopping boot loops. For example, if there
> > > is a kernel issue and the system keeps rebooting, it will run forever
> > > in the boot loop silently. It would be good for monitoring of
> > > console.log and kill the test if the console.log is acting 'weird'.
> > > Also it would be good if the console.log had a huge timestamp gap in
> > > it like the TREE04 issue. Would such changes be good to make? I can
> > > attempt something.
> > 
> > Boot loops can indeed be irritating.  So I created this commit:
> > 
> > 10f84c2cfb50 ("torture: Avoid torture-test reboot loops")
> > 
> > This passes -no-reboot to qemu, which causes qemu to just stop when
> > it would otherwise reboot.  Much nicer!
> > 
> > The multiple-ftrace-dump issue could still appear should some torture
> > test decide to turn tracing back on at some point, perhaps in response
> > to a yet-as-unthought-of module parameter.
> > 
> > Should this ever be a problem, one approach would be to leave the
> > beginning/end markers and/or number them.
> 
> Thanks for doing this! I'll add it to all my trees.
> 
> Also let us replace the diff with the below [3] to properly label potential
> multiple dumps?  Example for a file like [1], it will extract as [2].
> 
> [1]:
> 
> foo
> foo
> Dumping ftrace buffer:
> ---------------------------------
> blah
> blah
> ---------------------------------
> more
> bar
> baz
> Dumping ftrace buffer:
> ---------------------------------
> blah2
> blah2
> ---------------------------------
> bleh
> bleh
> 
> [2]:
> 
> Ftrace dump 1:
> blah
> blah
> 
> Ftrace dump 2:
> blah2
> blah2

Sounds good to me!

Could you please take the version of your patch that I have queued
on -rcu, apply these changes (adding the above to the commit log)
and officially re-send?

							Thanx, Paul

> ---8<-----------------------
> [3]
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
> old mode 100644
> new mode 100755
> index b8e2ea23cb3f..a5c74e508e41
> --- a/tools/testing/selftests/rcutorture/bin/functions.sh
> +++ b/tools/testing/selftests/rcutorture/bin/functions.sh
> @@ -331,3 +331,30 @@ specify_qemu_net () {
>  		echo $1 -net none
>  	fi
>  }
> +
> +# Extract the ftrace output from the console log output
> +# The ftrace output in the original logs look like:
> +# Dumping ftrace buffer:
> +# ---------------------------------
> +# [...]
> +# ---------------------------------
> +extract_ftrace_from_console() {
> +        awk '
> +        /Dumping ftrace buffer:/ {
> +        buffer_count++
> +        print "Ftrace dump " buffer_count ":"
> +        capture = 1
> +        next
> +    }
> +    /---------------------------------/ {
> +        if(capture == 1) {
> +            capture = 2
> +            next
> +        } else if(capture == 2) {
> +            capture = 0
> +            print ""
> +        }
> +    }
> +    capture == 2
> +    ' "$1";
> +}
> diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
> index 9ab0f6bc172c..e3d2f69ec0fb 100755
> --- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
> +++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
> @@ -182,3 +182,10 @@ if ! test -s $file.diags
>  then
>  	rm -f $file.diags
>  fi
> +
> +# Call extract_ftrace_from_console function, if the output is empty,
> +# don't create $file.ftrace. Otherwise output the results to $file.ftrace
> +extract_ftrace_from_console $file > $file.ftrace
> +if [ ! -s $file.ftrace ]; then
> +	rm -f $file.ftrace
> +fi
> -- 
> 2.41.0.694.ge786442a9b-goog
> 
