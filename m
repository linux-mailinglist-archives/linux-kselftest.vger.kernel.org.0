Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4019F426741
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Oct 2021 11:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239488AbhJHKAa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Oct 2021 06:00:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239500AbhJHKA3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Oct 2021 06:00:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8F1161027;
        Fri,  8 Oct 2021 09:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633687114;
        bh=Ge0KFntgmaorR+WsCHlz8rTezlNr2HAtrr8kJB7JuZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=ZPlbLfHRXU2CF7Y6wMr+HxDCxiW/aG/52LfZaeCYGBMTmWvzjk22NzntDUhqIqCbX
         7+8I3B+qPGXX6yq87cGoRepHSvjaOWF5+fB9qxp68CtioRUE9rU5ULFjyAW8t1H2Do
         sXdgVw804HdoPITrsEU/LB392Ttt++4Mq+mIx79goo1DzQwbEmiiWGRiLb6Zmq1nYD
         5vWGWB32RR0cWSDc00XRUG83uaWrTa3TVcHBYuCJpid7Zuys771mM9GCABx7wQTgiE
         8xVMI9b01Zrso22jlrbI+AITxxR8Oe85SabmiaFXTVS9YEFgB96MPFWYfyWrkBQ3vz
         c5Ytr/pf5+66A==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     shuah@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH v2] selftests/kselftest/runner/run_one(): Allow running non-executable files
Date:   Fri,  8 Oct 2021 09:58:28 +0000
Message-Id: <20211008095828.1796-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210913112442.1659-1-sjpark@amazon.de>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Shuah,


I was wondering if you had a chance to read this patch.

Without this patch, DAMON selftest fails as below:

    $ make -C tools/testing/selftests/damon/ run_tests
    make: Entering directory '/home/sjpark/linux/tools/testing/selftests/damon'
    TAP version 13
    1..1
    # selftests: damon: debugfs_attrs.sh
    # Warning: file debugfs_attrs.sh is not executable, correct this.
    not ok 1 selftests: damon: debugfs_attrs.sh
    make: Leaving directory '/home/sjpark/linux/tools/testing/selftests/damon'

If you disagree in the approach, please also take a look in this one:
https://lore.kernel.org/linux-kselftest/20210810112050.22225-1-sj38.park@gmail.com/


Thanks,
SJ


On Mon, 13 Sep 2021 11:24:42 +0000 SeongJae Park <sj38.park@gmail.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> Hello Shuah,
> 
> 
> Could you I ask your comment for this patch?
> 
> 
> Thanks,
> SJ
> 
> On Tue, 10 Aug 2021 16:45:34 +0000 SeongJae Park <sj38.park@gmail.com> wrote:
> 
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > When running a test program, 'run_one()' checks if the program has the
> > execution permission and fails if it doesn't.  However, it's easy to
> > mistakenly missing the permission, as some common tools like 'diff'
> > don't support the permission change well[1].  Compared to that, making
> > mistakes in the test program's path would only rare, as those are
> > explicitly listed in 'TEST_PROGS'.  Therefore, it might make more sense
> > to resolve the situation on our own and run the program.
> > 
> > For the reason, this commit makes the test program runner function to
> > still print the warning message but try parsing the interpreter of the
> > program and explicitly run it with the interpreter, in the case.
> > 
> > [1] https://lore.kernel.org/mm-commits/YRJisBs9AunccCD4@kroah.com/
> > 
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> > Changes from v1
> > (https://lore.kernel.org/linux-kselftest/20210810140459.23990-1-sj38.park@gmail.com/)
> > - Parse and use the interpreter instead of changing the file
> > 
> >  tools/testing/selftests/kselftest/runner.sh | 28 +++++++++++++--------
> >  1 file changed, 18 insertions(+), 10 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> > index cc9c846585f0..a9ba782d8ca0 100644
> > --- a/tools/testing/selftests/kselftest/runner.sh
> > +++ b/tools/testing/selftests/kselftest/runner.sh
> > @@ -33,9 +33,9 @@ tap_timeout()
> >  {
> >  	# Make sure tests will time out if utility is available.
> >  	if [ -x /usr/bin/timeout ] ; then
> > -		/usr/bin/timeout --foreground "$kselftest_timeout" "$1"
> > +		/usr/bin/timeout --foreground "$kselftest_timeout" $1
> >  	else
> > -		"$1"
> > +		$1
> >  	fi
> >  }
> >  
> > @@ -65,17 +65,25 @@ run_one()
> >  
> >  	TEST_HDR_MSG="selftests: $DIR: $BASENAME_TEST"
> >  	echo "# $TEST_HDR_MSG"
> > -	if [ ! -x "$TEST" ]; then
> > -		echo -n "# Warning: file $TEST is "
> > -		if [ ! -e "$TEST" ]; then
> > -			echo "missing!"
> > -		else
> > -			echo "not executable, correct this."
> > -		fi
> > +	if [ ! -e "$TEST" ]; then
> > +		echo "# Warning: file $TEST is missing!"
> >  		echo "not ok $test_num $TEST_HDR_MSG"
> >  	else
> > +		cmd="./$BASENAME_TEST"
> > +		if [ ! -x "$TEST" ]; then
> > +			echo "# Warning: file $TEST is not executable"
> > +
> > +			if [ $(head -n 1 "$TEST" | cut -c -2) = "#!" ]
> > +			then
> > +				interpreter=$(head -n 1 "$TEST" | cut -c 3-)
> > +				cmd="$interpreter ./$BASENAME_TEST"
> > +			else
> > +				echo "not ok $test_num $TEST_HDR_MSG"
> > +				return
> > +			fi
> > +		fi
> >  		cd `dirname $TEST` > /dev/null
> > -		((((( tap_timeout ./$BASENAME_TEST 2>&1; echo $? >&3) |
> > +		((((( tap_timeout "$cmd" 2>&1; echo $? >&3) |
> >  			tap_prefix >&4) 3>&1) |
> >  			(read xs; exit $xs)) 4>>"$logfile" &&
> >  		echo "ok $test_num $TEST_HDR_MSG") ||
> > -- 
> > 2.17.1
> > 
