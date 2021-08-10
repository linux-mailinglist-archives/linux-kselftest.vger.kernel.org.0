Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BE13E7DA9
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Aug 2021 18:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbhHJQo1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Aug 2021 12:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbhHJQo0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Aug 2021 12:44:26 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D25C0613C1;
        Tue, 10 Aug 2021 09:44:04 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id y9so5631053qtv.7;
        Tue, 10 Aug 2021 09:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=uzsoSEmiVX7S0Aao/0yXYwtOaxOrUpaLtaWhXnBU8Q8=;
        b=TFbLEroVCi7Xwu/9RNIWTgW557ZSy3ujWeuaYQ4oSV12nCqioONgFIHKadcYnyz/rQ
         qgnRmr28m+cqbBL2zy6pWhxmS/z7p56EvRm3CO9uRkx7jLiKhlaq2Nud+N6QCTcXxi90
         h2/S9YxrpdcXcnUwuQjDg7oOZRnj61SV7Ty/pDaV3gBB8mxj42NcHqlXL6zQ0KCddbdp
         8vG2SdfGVWxyPaMQaaDczfMxhVqtDkEnjsrSiLu/flpzbOg5KT3RahDne1SGJsl35zRH
         urMB7qUw40cbrnFEMSEBUJCST3bQvHrh9h1LSFHI3jHR4K0p70TKp7BOt58qYfLvPhaz
         48TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=uzsoSEmiVX7S0Aao/0yXYwtOaxOrUpaLtaWhXnBU8Q8=;
        b=dvKAwmaTo2vShK8g4p01OG/5pRimcwDWw/19CqDIatrqr3wa/EfvnpCKpEUIKZwKni
         zXGl2n8BvWeSVG4ZqG/vbD3C1ste312H5iqzJdPTAM0kpY6DeRQOcf6sHiZmviQHPuzo
         s/XJBulJOQi2n4BePLkUznBFE+N0Yll0mIQlXBtt7k73bTsPIe067VLqvMAUbk6c6qXS
         zNkeT7j50zNhL4+pMbNmMyvLDbHijQ/E2wLtD/YpXxrmBUcHQjEABuIZz3az9YT0V8sD
         u1d9kCvhXriMycpNqfuZ7ECEcWgnv0hKWL3QeabLI5FPMkLkvAxlKdPk1HNc2wujR3fa
         +1Fw==
X-Gm-Message-State: AOAM531SF+sWLK5p0nFedrAceAqSC8T//E7D7FaSTt1oLAN01hC/WmFd
        te5yj/VLdY4AYu8H+JXA+MI=
X-Google-Smtp-Source: ABdhPJwM8CTl19BrJvTmfKTTovIw/abSMJdJzFt1rhULRRR454rhuP5dw8eITjh8MVEXAaVDVF/Niw==
X-Received: by 2002:ac8:6a10:: with SMTP id t16mr13906179qtr.329.1628613843478;
        Tue, 10 Aug 2021 09:44:03 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id 62sm5838825qkf.76.2021.08.10.09.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 09:44:03 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     SeongJae Park <sj38.park@gmail.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH] selftests/kselftest/runner/run_one(): Allow running non-executable files
Date:   Tue, 10 Aug 2021 16:43:57 +0000
Message-Id: <20210810164357.25833-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YRKWMOElFHKy8DVp@kroah.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Tue, 10 Aug 2021 17:07:28 +0200 Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Aug 10, 2021 at 02:04:59PM +0000, SeongJae Park wrote:
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
> > still print the warning message but run the program after giving the
> > execution permission in the case.  To make nothing corrupted, it also
> > restores the permission after running it.
> > 
> > [1] https://lore.kernel.org/mm-commits/YRJisBs9AunccCD4@kroah.com/
> > 
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >  tools/testing/selftests/kselftest/runner.sh | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> > index cc9c846585f0..2eb31e945709 100644
> > --- a/tools/testing/selftests/kselftest/runner.sh
> > +++ b/tools/testing/selftests/kselftest/runner.sh
> > @@ -65,15 +65,16 @@ run_one()
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
> > +		permission_added="false"
> > +		if [ ! -x "$TEST" ]; then
> > +			echo "# Warning: file $TEST is not executable"
> > +			chmod u+x "$TEST"
> > +			permission_added="true"
> 
> No, why would you change the permission of a test?  What happens if this
> is on a read-only filesystem?  You should not be modifying it as it will
> end up causing changes when not needed.

Agreed.  I will parse the shebang line and use the interpreter explicitly in
the next spin.


Thanks,
SeongJae Park

> 
> thanks,
> 
> greg k-h
