Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B37218FD8D
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Mar 2020 20:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgCWTXs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 15:23:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37148 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbgCWTXs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 15:23:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id x1so2309744plm.4
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Mar 2020 12:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RbHAkwySW+SjMg5aoo3S5bq2JsPjA+qlnGgom9Gml2U=;
        b=NZO6kIIU6XdWgPNFf7gf7/1ozS9LSCLf84YqVYQhql4HqDD4IdLiCi9TIKY344rCvB
         Zoy7iLopJVuXHBh+li0Fh01/HjKrQ6vl/M02+YQ9mPLJWYA0UWGlf2O5H9PeBSb7xKIm
         oV8eDJixx4a4ddaZRZYlf+xgWc8w7cV6S8ex4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RbHAkwySW+SjMg5aoo3S5bq2JsPjA+qlnGgom9Gml2U=;
        b=Pf5mlt8Szs6NpHRGq0ov0WJvESnytDOvMEYkCPXYCrSohSfCyKfke7iDYVmjSADMh3
         J/6Es8IDwTTzQMNozhkMWYuUmrv6mK6bNcAz9PYwmEZmS0IxRSPydIXp7+exvjv2fafl
         6D21x3OVy6fzHSOOv2qLJKdMtazLIrOrGSWu1AXl7MW7fdOYadi1IqdveKYykuMYIkJ+
         RxiUl4FNZDphY1ck4gUL71AQd20tsFENWaaX5sQbR2OSJ8NiIEZFoMV3pkuwoT0jAnVZ
         f4EN93htFZYm5/NCsBUYOLjJJt8LfwuDAmrSi2WTbpZ3y9JSU7J06zBMoQ9DksnFJ2HR
         dbdA==
X-Gm-Message-State: ANhLgQ2jTWIH3n6lweicLD7E7w6QfNmLzjjBXdeH8fMl+dkWfFpFr81h
        ORcW4j9ws4pE7J5Xork3MXhmCQ==
X-Google-Smtp-Source: ADFU+vt+BA0dpGMNm1Mhwu63M++OXFp0EGRD0FVnEVO+IMYkZxRYTY2rkHIb1guWH6E2+ljzvMqD3Q==
X-Received: by 2002:a17:902:598e:: with SMTP id p14mr21666696pli.276.1584991427052;
        Mon, 23 Mar 2020 12:23:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 144sm12956585pgc.25.2020.03.23.12.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 12:23:46 -0700 (PDT)
Date:   Mon, 23 Mar 2020 12:23:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     shuah <shuah@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] selftests/harness: Move test child waiting logic
Message-ID: <202003231220.97A7ABD49@keescook>
References: <20200313231252.64999-1-keescook@chromium.org>
 <20200313231252.64999-2-keescook@chromium.org>
 <0df3a446-cbdf-ed6b-9567-b137ec2138f7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0df3a446-cbdf-ed6b-9567-b137ec2138f7@kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 23, 2020 at 12:08:13PM -0600, shuah wrote:
> Hi Kees,
> 
> On 3/13/20 5:12 PM, Kees Cook wrote:
> > In order to better handle timeout failures, rearrange the child waiting
> > logic into a separate function. This is mostly a copy/paste with an
> > indentation change. To handle pid tracking, a new field is added for
> > the child pid. Also move the alarm() pairing into the function.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Sorry for the delay. I was on vacation all of last week
> and totally trying to stay away from checking email.

Indeed; that's what vacation is for! :)

> My commit scripts falied on checkpatch warnings.

All the macros in this file tend to anger checkpatch. ;)

> 
> A couple of comments below:
> 
> 
> > ---
> >   tools/testing/selftests/kselftest_harness.h | 93 +++++++++++----------
> >   1 file changed, 49 insertions(+), 44 deletions(-)
> >  > diff --git a/tools/testing/selftests/kselftest_harness.h
> b/tools/testing/selftests/kselftest_harness.h
> > index 5336b26506ab..c7b67e379219 100644
> > --- a/tools/testing/selftests/kselftest_harness.h
> > +++ b/tools/testing/selftests/kselftest_harness.h
> > @@ -635,6 +635,7 @@
> >   struct __test_metadata {
> >   	const char *name;
> >   	void (*fn)(struct __test_metadata *);
> > +	pid_t pid;	/* pid of test when being run */
> >   	int termsig;
> >   	int passed;
> >   	int trigger; /* extra handler after the evaluation */
> > @@ -695,64 +696,68 @@ static inline int __bail(int for_realz, bool no_print, __u8 step)
> >   	return 0;
> >   }
> > -void __run_test(struct __test_metadata *t)
> > +void __wait_for_test(struct __test_metadata *t)
> >   {
> > -	pid_t child_pid;
> >   	int status;
> > +	alarm(t->timeout);
> > +	waitpid(t->pid, &status, 0);
> > +	alarm(0);
> > +
> > +	if (WIFEXITED(status)) {
> > +		t->passed = t->termsig == -1 ? !WEXITSTATUS(status) : 0;
> > +		if (t->termsig != -1) {
> > +			fprintf(TH_LOG_STREAM,
> > +				"%s: Test exited normally "
> > +				"instead of by signal (code: %d)\n",
> > +				t->name,
> > +				WEXITSTATUS(status));
> 
> This one isn't an error and gets printed to stderr? Except for
> this one message, all other messages in this routine are indeed
> errors. It makes sense to print this out to stdout instead.

No, this is an error. A signal was _expected_ in this case, but the
program exited without a signal. i.e. the test case failed, and the
error is reported to stderr.

(This portion, btw, is just moved from below.)

> 
> > +		} else if (!t->passed) {
> > +			fprintf(TH_LOG_STREAM,
> > +				"%s: Test failed at step #%d\n",
> > +				t->name,
> > +				WEXITSTATUS(status));
> > +		}
> > +	} else if (WIFSIGNALED(status)) {
> > +		t->passed = 0;
> > +		if (WTERMSIG(status) == SIGABRT) {
> > +			fprintf(TH_LOG_STREAM,
> > +				"%s: Test terminated by assertion\n",
> > +				t->name);
> > +		} else if (WTERMSIG(status) == t->termsig) {
> > +			t->passed = 1;
> > +		} else {
> > +			fprintf(TH_LOG_STREAM,
> > +				"%s: Test terminated unexpectedly "
> > +				"by signal %d\n",
> > +				t->name,
> > +				WTERMSIG(status));
> > +		}
> > +	} else {
> > +		fprintf(TH_LOG_STREAM,
> > +			"%s: Test ended in some other way [%u]\n",
> > +			t->name,
> > +			status);
> > +	}
> > +}
> > +
> > +void __run_test(struct __test_metadata *t)
> > +{
> >   	t->passed = 1;
> >   	t->trigger = 0;
> >   	printf("[ RUN      ] %s\n", t->name);
> > -	alarm(t->timeout);
> > -	child_pid = fork();
> > -	if (child_pid < 0) {
> > +	t->pid = fork();
> > +	if (t->pid < 0) {
> >   		printf("ERROR SPAWNING TEST CHILD\n");
> >   		t->passed = 0;
> > -	} else if (child_pid == 0) {
> > +	} else if (t->pid == 0) {
> >   		t->fn(t);
> >   		/* return the step that failed or 0 */
> >   		_exit(t->passed ? 0 : t->step);
> >   	} else {
> > -		/* TODO(wad) add timeout support. */
> > -		waitpid(child_pid, &status, 0);
> > -		if (WIFEXITED(status)) {
> > -			t->passed = t->termsig == -1 ? !WEXITSTATUS(status) : 0;
> > -			if (t->termsig != -1) {
> > -				fprintf(TH_LOG_STREAM,
> > -					"%s: Test exited normally "
> > -					"instead of by signal (code: %d)\n",
> > -					t->name,
> > -					WEXITSTATUS(status));
> > -			} else if (!t->passed) {
> > -				fprintf(TH_LOG_STREAM,
> > -					"%s: Test failed at step #%d\n",
> > -					t->name,
> > -					WEXITSTATUS(status));
> > -			}
> > -		} else if (WIFSIGNALED(status)) {
> > -			t->passed = 0;
> > -			if (WTERMSIG(status) == SIGABRT) {
> > -				fprintf(TH_LOG_STREAM,
> > -					"%s: Test terminated by assertion\n",
> > -					t->name);
> > -			} else if (WTERMSIG(status) == t->termsig) {
> > -				t->passed = 1;
> > -			} else {
> > -				fprintf(TH_LOG_STREAM,
> > -					"%s: Test terminated unexpectedly "
> > -					"by signal %d\n",
> > -					t->name,
> > -					WTERMSIG(status));
> > -			}
> > -		} else {
> > -			fprintf(TH_LOG_STREAM,
> > -				"%s: Test ended in some other way [%u]\n",
> > -				t->name,
> > -				status);
> > -		}
> > +		__wait_for_test(t);
> >   	}
> >   	printf("[     %4s ] %s\n", (t->passed ? "OK" : "FAIL"), t->name);
> > -	alarm(0);
> >   }
> >   static int test_harness_run(int __attribute__((unused)) argc,
> > 
> 
> thanks,
> -- Shuah

Hopefully that clears it up. I don't see anything to change for a v2?
Did I miss anything?

Thanks!

-Kees

-- 
Kees Cook
