Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC60721E45D
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jul 2020 02:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgGNANL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jul 2020 20:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgGNANK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jul 2020 20:13:10 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBE6C061794
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jul 2020 17:13:10 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 1so6764143pfn.9
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jul 2020 17:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iIGjOOcrG6YH/TItPZmLMnrrNFuue6zZLABbTH5Rg5w=;
        b=Wpkm4yyv9/VEYsbu9Qx6r1Qz5R2rJk1rmljMB6Y61NRCuVdDpbYfsQc+axqgabK8ka
         QoFPnsLugs42jR9TUnqjML74uRvSnJx/DJrivzvM4gHuAumJxGRnOuQpL03vYAEcTSua
         KTjs2DHwrQ6+sgEDQFILB9ruoCpdi49EVfHNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iIGjOOcrG6YH/TItPZmLMnrrNFuue6zZLABbTH5Rg5w=;
        b=mR5HmRLSeyF4CQN8/QXtRcblJ4pjBROyP5AXkW1752Q6+kC87/rsZBy/yMRcGNz/Ju
         P4pl1x/AIf7YEQncn1ICUzUqrqeSXOsXRxHv+qBTIgnrX013EdrU9ylEa9Rsz7zI9dJP
         8OUR1He+rwXxtyGlXTX+6nl+h8ZXVJgvQuoWXezFigYt5gIz/LUzm180i8nrblfYitZa
         Qec+C2sXxMOouJtoJ2oWP19yapTDCTsgyymu6VIwSCNdivIRL4dpkRUbOsbWFhUy1kPr
         TknV5VMv2qJOaxPccC3EsT56juOWqxG/f8e0ACdUrkRV6Y+SzjSWpbaCz9aG9+fTBSt4
         CvtA==
X-Gm-Message-State: AOAM5310Cjmi4nYcRuxlWyAg2m+Dp7/prdtZUOST89OW92E0irTlwBVD
        hg6+bMlwcn8Z87J02LV3LCq83g==
X-Google-Smtp-Source: ABdhPJyOZiD2PxWSpJhmWCPmd45sNOcbmUN0o7IUu8siomP5nQOdHLhqW6cBw+3ARS7c7bbS5JWupw==
X-Received: by 2002:a65:448c:: with SMTP id l12mr1303444pgq.234.1594685589739;
        Mon, 13 Jul 2020 17:13:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i21sm15538735pfa.18.2020.07.13.17.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 17:13:08 -0700 (PDT)
Date:   Mon, 13 Jul 2020 17:13:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] selftests/harness: Refactor XFAIL into SKIP
Message-ID: <202007131705.D17464CA16@keescook>
References: <20200622181651.2795217-1-keescook@chromium.org>
 <20200622181651.2795217-7-keescook@chromium.org>
 <90fa90dc-7155-6096-678d-b6c103c1b0a6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90fa90dc-7155-6096-678d-b6c103c1b0a6@nvidia.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 13, 2020 at 12:08:08PM -0700, Ralph Campbell wrote:
> 
> On 6/22/20 11:16 AM, Kees Cook wrote:
> > Plumb the old XFAIL result into a TAP SKIP.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >   tools/testing/selftests/kselftest_harness.h   | 64 ++++++++++++++-----
> >   tools/testing/selftests/seccomp/seccomp_bpf.c |  8 +--
> >   2 files changed, 52 insertions(+), 20 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> > index f8f7e47c739a..b519765904a6 100644
> > --- a/tools/testing/selftests/kselftest_harness.h
> > +++ b/tools/testing/selftests/kselftest_harness.h
> > @@ -112,22 +112,22 @@
> >   			__FILE__, __LINE__, _metadata->name, ##__VA_ARGS__)
> >   /**
> > - * XFAIL(statement, fmt, ...)
> > + * SKIP(statement, fmt, ...)
> >    *
> > - * @statement: statement to run after reporting XFAIL
> > + * @statement: statement to run after reporting SKIP
> >    * @fmt: format string
> >    * @...: optional arguments
> >    *
> > - * This forces a "pass" after reporting a failure with an XFAIL prefix,
> > + * This forces a "pass" after reporting why something is being skipped
> >    * and runs "statement", which is usually "return" or "goto skip".
> >    */
> > -#define XFAIL(statement, fmt, ...) do { \
> > +#define SKIP(statement, fmt, ...) do { \
> >   	if (TH_LOG_ENABLED) { \
> > -		fprintf(TH_LOG_STREAM, "#      XFAIL     " fmt "\n", \
> > +		fprintf(TH_LOG_STREAM, "#      SKIP     " fmt "\n", \
> >   			##__VA_ARGS__); \
> >   	} \
> > -	/* TODO: find a way to pass xfail to test runner process. */ \
> >   	_metadata->passed = 1; \
> > +	_metadata->skip = 1; \
> >   	_metadata->trigger = 0; \
> >   	statement; \
> >   } while (0)
> > @@ -777,6 +777,7 @@ struct __test_metadata {
> >   	struct __fixture_metadata *fixture;
> >   	int termsig;
> >   	int passed;
> > +	int skip;	/* did SKIP get used? */
> >   	int trigger; /* extra handler after the evaluation */
> >   	int timeout;	/* seconds to wait for test timeout */
> >   	bool timed_out;	/* did this test timeout instead of exiting? */
> > @@ -866,17 +867,31 @@ void __wait_for_test(struct __test_metadata *t)
> >   		fprintf(TH_LOG_STREAM,
> >   			"# %s: Test terminated by timeout\n", t->name);
> >   	} else if (WIFEXITED(status)) {
> > -		t->passed = t->termsig == -1 ? !WEXITSTATUS(status) : 0;
> >   		if (t->termsig != -1) {
> > +			t->passed = 0;
> >   			fprintf(TH_LOG_STREAM,
> >   				"# %s: Test exited normally instead of by signal (code: %d)\n",
> >   				t->name,
> >   				WEXITSTATUS(status));
> > -		} else if (!t->passed) {
> > -			fprintf(TH_LOG_STREAM,
> > -				"# %s: Test failed at step #%d\n",
> > -				t->name,
> > -				WEXITSTATUS(status));
> > +		} else {
> > +			switch (WEXITSTATUS(status)) {
> > +			/* Success */
> > +			case 0:
> > +				t->passed = 1;
> > +				break;
> > +			/* SKIP */
> > +			case 255:
> > +				t->passed = 1;
> > +				t->skip = 1;
> > +				break;
> > +			/* Other failure, assume step report. */
> > +			default:
> > +				t->passed = 0;
> > +				fprintf(TH_LOG_STREAM,
> > +					"# %s: Test failed at step #%d\n",
> > +					t->name,
> > +					WEXITSTATUS(status));
> > +			}
> >   		}
> >   	} else if (WIFSIGNALED(status)) {
> >   		t->passed = 0;
> > @@ -906,6 +921,7 @@ void __run_test(struct __fixture_metadata *f,
> >   {
> >   	/* reset test struct */
> >   	t->passed = 1;
> > +	t->skip = 0;
> >   	t->trigger = 0;
> >   	t->step = 0;
> >   	t->no_print = 0;
> > @@ -918,15 +934,31 @@ void __run_test(struct __fixture_metadata *f,
> >   		t->passed = 0;
> >   	} else if (t->pid == 0) {
> >   		t->fn(t, variant);
> > -		/* return the step that failed or 0 */
> > -		_exit(t->passed ? 0 : t->step);
> > +		/* Make sure step doesn't get lost in reporting */
> > +		if (t->step >= 255) {
> > +			ksft_print_msg("Too many test steps (%u)!?\n", t->step);
> > +			t->step = 254;
> > +		}
> 
> I noticed that this message is now appearing in the HMM self tests.
> I haven't quite tracked down why ->steps should be 255 after running
> the first test. I did notice that ASSERT*() calls __INC_STEP() but
> that doesn't explain it.
> Separately, maybe __INC_STEP() should check for < 254 instead of < 255?
> 
>     Set CONFIG_HMM_TESTS=m, build and install kernel and modules.
>     cd tools/testing/selftests/vm
>     make
>     ./test_hmm.sh smoke
>     Running smoke test. Note, this test provides basic coverage.
>     [  106.803476] memmap_init_zone_device initialised 65536 pages in 7ms
>     [  106.810141] added new 256 MB chunk (total 1 chunks, 256 MB) PFNs [0x3ffff0000 0x400000000)
>     [  106.823703] memmap_init_zone_device initialised 65536 pages in 4ms
>     [  106.829968] added new 256 MB chunk (total 1 chunks, 256 MB) PFNs [0x3fffe0000 0x3ffff0000)
>     [  106.838655] HMM test module loaded. This is only for testing HMM.
>     TAP version 13
>     1..20
>     # Starting 20 tests from 3 test cases.
>     #  RUN           hmm.open_close ...
>     #            OK  hmm.open_close
>     ok 1 hmm.open_close
>     #  RUN           hmm.anon_read ...
>     # Too many test steps (255)!?
>     #            OK  hmm.anon_read

Oooh:

#define NTIMES          256

Yes, that's a lot of steps. :)

I agree,__ INC_STEP() needs adjustment, though it should be 253. Does
this work for you?

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 935029d4fb21..4f78e4805633 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -680,7 +680,8 @@
 			__bail(_assert, _metadata->no_print, _metadata->step))
 
 #define __INC_STEP(_metadata) \
-	if (_metadata->passed && _metadata->step < 255) \
+	/* Keep "step" below 255 (which is used for "SKIP" reporting). */	\
+	if (_metadata->passed && _metadata->step < 253) \
 		_metadata->step++;
 
 #define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
@@ -976,12 +977,6 @@ void __run_test(struct __fixture_metadata *f,
 		t->passed = 0;
 	} else if (t->pid == 0) {
 		t->fn(t, variant);
-		/* Make sure step doesn't get lost in reporting */
-		if (t->step >= 255) {
-			ksft_print_msg("Too many test steps (%u)!?\n", t->step);
-			t->step = 254;
-		}
-		/* Use 255 for SKIP */
 		if (t->skip)
 			_exit(255);
 		/* Pass is exit 0 */

-- 
Kees Cook
