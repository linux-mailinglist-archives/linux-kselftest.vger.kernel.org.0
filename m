Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF6E207CBA
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jun 2020 22:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406492AbgFXUNO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jun 2020 16:13:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22370 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406391AbgFXUNN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jun 2020 16:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593029590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4MbGz15Us31m2v0G89U7HCcGguCWLGU9ZCf1KLcZZdY=;
        b=dlEs2UehL1c1HUpSd2+pwnLisHLgdZ7gmuqcb5SGjz2Ws1nc+iUBJoR3C8t/7yZQGnARhK
        mcCch3yx0eOGJQd/K3PNJdDlev/7jCcQSHQwcCU+srQgmcgpMlZUFO31vdJ8Bhqhn1G/10
        6CZyIYv4FomRMEY8N1Ql7lD3A8BHmc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-tzqgQsbyNMWHVOpkxOH0Rw-1; Wed, 24 Jun 2020 16:12:53 -0400
X-MC-Unique: tzqgQsbyNMWHVOpkxOH0Rw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6276805EE1;
        Wed, 24 Jun 2020 20:12:50 +0000 (UTC)
Received: from redhat.com (ovpn-112-56.rdu2.redhat.com [10.10.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E23519D7D;
        Wed, 24 Jun 2020 20:12:49 +0000 (UTC)
Date:   Wed, 24 Jun 2020 16:12:47 -0400
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        lkft-triage@lists.linaro.org, Miroslav Benes <mbenes@suse.cz>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 1/2] selftests/lkdtm: Don't clear dmesg when running tests
Message-ID: <20200624201247.GA25319@redhat.com>
References: <20200508065356.2493343-1-mpe@ellerman.id.au>
 <CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com>
 <c5b77970-ecaf-24ad-c34d-134acc1a6063@redhat.com>
 <20200624083955.GF8444@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624083955.GF8444@alley>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 24, 2020 at 10:39:55AM +0200, Petr Mladek wrote:
> On Tue 2020-06-23 23:48:36, Joe Lawrence wrote:
> > On 6/22/20 4:51 AM, Naresh Kamboju wrote:
> > > On Fri, 8 May 2020 at 12:23, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > > > 
> > > > It is Very Rude to clear dmesg in test scripts. That's because the
> > > > script may be part of a larger test run, and clearing dmesg
> > > > potentially destroys the output of other tests.
> > > > 
> > > > We can avoid using dmesg -c by saving the content of dmesg before the
> > > > test, and then using diff to compare that to the dmesg afterward,
> > > > producing a log with just the added lines.
> > > >
> > > > > > > diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
> > > > index dadf819148a4..0b409e187c7b 100755
> > > > --- a/tools/testing/selftests/lkdtm/run.sh
> > > > +++ b/tools/testing/selftests/lkdtm/run.sh
> > > >   # Record and dump the results
> > > > -dmesg -c >"$LOG"
> > > > +dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" - > "$LOG" || true
> > > 
> > > We are facing problems with the diff `=%>` part of the option.
> > > This report is from the OpenEmbedded environment.
> > > We have the same problem from livepatch_testcases.
> > > 
> > > # selftests lkdtm BUG.sh
> > > lkdtm: BUG.sh_ #
> > > # diff unrecognized option '--changed-group-format=%>'
> > > unrecognized: option_'--changed-group-format=%>' #
> > > # BusyBox v1.27.2 (2020-03-30 164108 UTC) multi-call binary.
> > > v1.27.2: (2020-03-30_164108 #
> > > #
> > > : _ #
> > > # Usage diff [-abBdiNqrTstw] [-L LABEL] [-S FILE] [-U LINES] FILE1 FILE2
> > > diff: [-abBdiNqrTstw]_[-L #
> > > # BUG missing 'kernel BUG at' [FAIL]
> > > 
> > > Full test output log,
> > > https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200621/testrun/2850083/suite/kselftest/test/lkdtm_BUG.sh/log
> > > 
> > 
> > D'oh!  Using diff's changed/unchanged group format was a nice trick to
> > easily fetch the new kernel log messages.
> > 
> > I can't think of any simple alternative off the top of my head, so here's a
> > kludgy tested-once awk script:
> > 
> >  SAVED_DMESG="$(dmesg | tail -n1)"
> >  ... tests ...
> >  NEW_DMESG=$(dmesg | awk -v last="$SAVED_DMESG" 'p; $0 == last{p=1}')
> > 
> > I think timestamps should make each log line unique, but this probably won't
> > handle kernel log buffer overflow.
> 
> The test would fail anyway if there was log buffer overflow.
> 
> We could check if the last line was still there and
> suggest to increase the log buffer size in the error message.
> 

Hi Petr,

This is a good suggestion and I've worked it into the awk script I
wrote last night, check it out at the bottom ...

> > Maybe it would be easier to log a known unique test delimiter msg and then
> > fetch all new messages after that?
> 
> The timestamp should be enough to distinguish any message.
> 
> But some visual separator between each test is useful anyway. And
> it might include some random string...
> 

Ah yeah, you're right about those timestamps again. :)

As for separators, we've already added the "===== TEST: foo =====" for
the livepatch ones... so I think with the timestamp prefix, we're good
enough, no?


I did a bit more hacking to work that awk script into the livepatching
tests.  The changes aren't too bad and coding it ourselves lets us drop
the temporary dmesg file business.  If this looks good, I can send out
as a real patch, but then that raises a few questions:

  1 - f131d9edc29d ("selftests/lkdtm: Don't clear dmesg when running
      tests") has already merged, updating that file doesn't look too
      difficult, but will need a Fixes tag and should probably go
      through Shuah's tree.

  2 - We haven't actually merged the livepatch copy yet.  I can roll
      another version of that patchset, substituting a fix for the
      problematic patch, or we could just tack this one on at the end.
      In fine with either approach.

-- Joe

-->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8-- -->8--


From 892a651839ac6cdd398d6d9998c0d2e4214b72f7 Mon Sep 17 00:00:00 2001
From: Joe Lawrence <joe.lawrence@redhat.com>
Date: Wed, 24 Jun 2020 15:34:04 -0400
Subject: [PATCH] selftests/livepatch: support BusyBox diff

BusyBox diff doesn't support the GNU diff '--LTYPE-line-format' options
that were used in the selftests to filter older kernel log messages from
dmesg output.

Bite the bullet and code this into the selftest:

  - test start: remember the last dmesg entry (has unique [timestamp]
    prefix) in $SAVED_DMESG
  - test end: awk-filter dmesg output up to and including $SAVED_DMESG

Account for kernel log overflow in case awk doesn't find $SAVED_DMESG,
exit and fail the test with a recommendation that the user expand the
kernel log buffer.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 tools/testing/selftests/livepatch/functions.sh | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 36648ca367c2..365ce4110265 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -41,15 +41,16 @@ function die() {
 	exit 1
 }
 
-# save existing dmesg so we can detect new content
+# save last dmesg entry so we can detect new content
 function save_dmesg() {
-	SAVED_DMESG=$(mktemp --tmpdir -t klp-dmesg-XXXXXX)
-	dmesg > "$SAVED_DMESG"
+	SAVED_DMESG="$(dmesg | tail -n1)"
 }
 
-# cleanup temporary dmesg file from save_dmesg()
-function cleanup_dmesg_file() {
-	rm -f "$SAVED_DMESG"
+# filter all dmesg content before and including $SAVED_DMESG
+function new_dmesg() {
+	if ! dmesg | awk -v last="$SAVED_DMESG" 'p; $0 == last{p=1} END {exit !p}'; then
+		die "dmesg overflow, try increasing kernel log buffer size"
+	fi
 }
 
 function push_config() {
@@ -81,7 +82,6 @@ function set_ftrace_enabled() {
 
 function cleanup() {
 	pop_config
-	cleanup_dmesg_file
 }
 
 # setup_config - save the current config and set a script exit trap that
@@ -277,7 +277,7 @@ function check_result {
 	# help differentiate repeated testing runs.  Remove them with a
 	# post-comparison sed filter.
 
-	result=$(dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$SAVED_DMESG" - | \
+	result=$(new_dmesg | \
 		 grep -e 'livepatch:' -e 'test_klp' | \
 		 grep -v '\(tainting\|taints\) kernel' | \
 		 sed 's/^\[[ 0-9.]*\] //')
@@ -288,6 +288,4 @@ function check_result {
 		echo -e "not ok\n\n$(diff -upr --label expected --label result <(echo "$expect") <(echo "$result"))\n"
 		die "livepatch kselftest(s) failed"
 	fi
-
-	cleanup_dmesg_file
 }
-- 
2.21.3

