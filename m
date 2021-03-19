Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13473425E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Mar 2021 20:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhCSTMF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Mar 2021 15:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhCSTLl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Mar 2021 15:11:41 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AD7C06174A
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Mar 2021 12:11:41 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l1so3403802plg.12
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Mar 2021 12:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8+dj9XdsQigirosGIEMIHcITvWVWyXmBGTduGwQLkwQ=;
        b=SMFAohEOg1b0SvUCrqANnZ14nWX3kYufAeHLUH1T4fip5oY60hqPpZPYYdIwxuM5Go
         +6zNXws6SgckWc+bIn46xfilkhShdmMK8VAZSDFVmdPEMJYX5aVVTSfR5JljwADmLJTu
         fa4+TfL/+RgVxnoewR/Gnyf24K/AHGmZxK9sI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8+dj9XdsQigirosGIEMIHcITvWVWyXmBGTduGwQLkwQ=;
        b=SPHR80m3QsCLDpQZXmuVGOq0VfUB6LDZyKrcCrkop8KGrCIhDjEMbBsnbscq2IRw0J
         6PwjiCvb4mtiNcQ1UwATGwB8SkC4e5f6mcPIs+/UCLOdBFkV31ADc9EeqPbaoFLYoQT1
         lY+3nLgSJgUTAjqkePadlPv5hPNmlOkYlptPSj3oBW6JSCFFKTFUWWK52vH4+eu5jELZ
         u5TOhmI2gVc6Hr50gbLsokQu2sxjzgx7+QPbcHloYzXi2V+zba+UpTfvmwDraiUow4lE
         n4QnJlryYvOWhDdp9wZ2oq9fDh440ZTrj9XG9RFoV0lE1pA4tosONhM+5lUyQT1fD6e0
         y0zw==
X-Gm-Message-State: AOAM532jSlytCrrXFzo6/hLRZirF71Nt/RXnJd5OAMT+AW8DGXbKdzQG
        J1INaZsXlDDkfPhsciZEnrkRRA==
X-Google-Smtp-Source: ABdhPJw77NJBXyie+CZaWQgxVAqktzOswabCGYKmJ35fViYrJhan5H46f0mY2WOpg1a64hwApsbuNg==
X-Received: by 2002:a17:90a:c207:: with SMTP id e7mr11982pjt.188.1616181101020;
        Fri, 19 Mar 2021 12:11:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 22sm6148625pjl.31.2021.03.19.12.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 12:11:40 -0700 (PDT)
Date:   Fri, 19 Mar 2021 12:11:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v30 10/12] selftests/landlock: Add user space tests
Message-ID: <202103191207.E12FD4E51@keescook>
References: <20210316204252.427806-1-mic@digikod.net>
 <20210316204252.427806-11-mic@digikod.net>
 <202103191026.D936362B@keescook>
 <e98a1f48-4c35-139d-af88-b6e65fbb5c3f@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e98a1f48-4c35-139d-af88-b6e65fbb5c3f@digikod.net>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 19, 2021 at 07:41:00PM +0100, Micka�l Sala�n wrote:
> 
> On 19/03/2021 18:56, Kees Cook wrote:
> > On Tue, Mar 16, 2021 at 09:42:50PM +0100, Micka�l Sala�n wrote:
> >> From: Micka�l Sala�n <mic@linux.microsoft.com>
> >>
> >> Test all Landlock system calls, ptrace hooks semantic and filesystem
> >> access-control with multiple layouts.
> >>
> >> Test coverage for security/landlock/ is 93.6% of lines.  The code not
> >> covered only deals with internal kernel errors (e.g. memory allocation)
> >> and race conditions.
> >>
> >> Cc: James Morris <jmorris@namei.org>
> >> Cc: Jann Horn <jannh@google.com>
> >> Cc: Kees Cook <keescook@chromium.org>
> >> Cc: Serge E. Hallyn <serge@hallyn.com>
> >> Cc: Shuah Khan <shuah@kernel.org>
> >> Signed-off-by: Micka�l Sala�n <mic@linux.microsoft.com>
> >> Reviewed-by: Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>
> >> Link: https://lore.kernel.org/r/20210316204252.427806-11-mic@digikod.net
> > 
> > This is terrific. I love the coverage. How did you measure this, BTW?
> 
> I used gcov: https://www.kernel.org/doc/html/latest/dev-tools/gcov.html
> 
> > To increase it into memory allocation failures, have you tried
> > allocation fault injection:
> > https://www.kernel.org/doc/html/latest/fault-injection/fault-injection.html
> 
> Yes, it is used by syzkaller, but I don't know how to extract this
> specific coverage.
> 
> > 
> >> [...]
> >> +TEST(inconsistent_attr) {
> >> +	const long page_size = sysconf(_SC_PAGESIZE);
> >> +	char *const buf = malloc(page_size + 1);
> >> +	struct landlock_ruleset_attr *const ruleset_attr = (void *)buf;
> >> +
> >> +	ASSERT_NE(NULL, buf);
> >> +
> >> +	/* Checks copy_from_user(). */
> >> +	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, 0, 0));
> >> +	/* The size if less than sizeof(struct landlock_attr_enforce). */
> >> +	ASSERT_EQ(EINVAL, errno);
> >> +	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, 1, 0));
> >> +	ASSERT_EQ(EINVAL, errno);
> > 
> > Almost everywhere you're using ASSERT instead of EXPECT. Is this correct
> > (in the sense than as soon as an ASSERT fails the rest of the test is
> > skipped)? I do see you using EXPECT is some places, but I figured I'd
> > ask about the intention here.
> 
> I intentionally use ASSERT as much as possible, but I use EXPECT when an
> error could block a test or when it could stop a cleanup (i.e. teardown).

Okay. Does the test suite run sanely when landlock is missing from the
kernel?

> > 
> >> +/*
> >> + * TEST_F_FORK() is useful when a test drop privileges but the corresponding
> >> + * FIXTURE_TEARDOWN() requires them (e.g. to remove files from a directory
> >> + * where write actions are denied).  For convenience, FIXTURE_TEARDOWN() is
> >> + * also called when the test failed, but not when FIXTURE_SETUP() failed.  For
> >> + * this to be possible, we must not call abort() but instead exit smoothly
> >> + * (hence the step print).
> >> + */
> > 
> > Hm, interesting. I think this should be extracted into a separate patch
> > and added to the test harness proper.
> 
> I agree, but it may require some modifications to fit nicely in
> kselftest_harness.h . For now, it works well for my use case. I'll send
> patches once Landlock is merged. In fact, I already made
> kselftest_harness.h available for other users than seccomp. ;)

Fair points.

> > 
> > Could this be solved with TEARDOWN being called on SETUP failure?
> 
> The goal of this helper is to still be able to call TEARDOWN when TEST
> failed, not SETUP.
> 
> > 
> >> +#define TEST_F_FORK(fixture_name, test_name) \
> >> +	static void fixture_name##_##test_name##_child( \
> >> +		struct __test_metadata *_metadata, \
> >> +		FIXTURE_DATA(fixture_name) *self, \
> >> +		const FIXTURE_VARIANT(fixture_name) *variant); \
> >> +	TEST_F(fixture_name, test_name) \
> >> +	{ \
> >> +		int status; \
> >> +		const pid_t child = fork(); \
> >> +		if (child < 0) \
> >> +			abort(); \
> >> +		if (child == 0) { \
> >> +			_metadata->no_print = 1; \
> >> +			fixture_name##_##test_name##_child(_metadata, self, variant); \
> >> +			if (_metadata->skip) \
> >> +				_exit(255); \
> >> +			if (_metadata->passed) \
> >> +				_exit(0); \
> >> +			_exit(_metadata->step); \
> >> +		} \
> >> +		if (child != waitpid(child, &status, 0)) \
> >> +			abort(); \
> >> +		if (WIFSIGNALED(status) || !WIFEXITED(status)) { \
> >> +			_metadata->passed = 0; \
> >> +			_metadata->step = 1; \
> >> +			return; \
> >> +		} \
> >> +		switch (WEXITSTATUS(status)) { \
> >> +		case 0: \
> >> +			_metadata->passed = 1; \
> >> +			break; \
> >> +		case 255: \
> >> +			_metadata->passed = 1; \
> >> +			_metadata->skip = 1; \
> >> +			break; \
> >> +		default: \
> >> +			_metadata->passed = 0; \
> >> +			_metadata->step = WEXITSTATUS(status); \
> >> +			break; \
> >> +		} \
> >> +	} \
> > 
> > This looks like a subset of __wait_for_test()? Could __TEST_F_IMPL() be
> > updated instead to do this? (Though the fork overhead might not be great
> > for everyone.)
> 
> Yes, it will probably be my approach to update kselftest_harness.h .

It seems like this would be named better as TEST_DROPS_PRIVS or something,
which describes the reason for the fork.

-- 
Kees Cook
