Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3692B0506
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Nov 2020 13:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgKLMhS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Nov 2020 07:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbgKLMhQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Nov 2020 07:37:16 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2537AC0613D1
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Nov 2020 04:37:15 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id 33so5829513wrl.7
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Nov 2020 04:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AJPY4X2n7sUHyd0/0AvO8iz6nLZ/ZY0li47ksop/27U=;
        b=Iohk9hDVrksazz7Kla+dRdxez8y+/jJS2eu8CXL0/Y157xUOfpSd0TcMYJ2S6tlhip
         cpnZpTCXz8xxM3pz3TLMi8C9HrlN7yM4jbgM0FRe7wsKN5JJ5fE0/twCtlpH5rwF+/jm
         4jTSkjDefS0nAB9D3RWfIYAsftHhClMeDi5D7z/Hnh9wW66GG+3n1YoNCaM01kmDZV+6
         nyX0hMWbAKiszz7fddfnchTTYUpLXZ0mFh5ANqNJ1XMePmSH8RW1ET5rk5QAw2exPNVb
         y+lQJe2mVVtm/PykerJ1BqD8JuqJMFJAfxzQV27hB3X57XNJXGPf1OtZwNofNkrAZa5T
         ccyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AJPY4X2n7sUHyd0/0AvO8iz6nLZ/ZY0li47ksop/27U=;
        b=XWo/+VRy4ZxgEmLy0Eh4KmugDmnGJeSrYSWWOc1THt3ta7egUXGjZ+zlK96OdY7b1H
         IUx0PcMqyIEYDN3pDxZ8DnUmicTvkKw5wWusVgitSheiujTVT2EjGCPJ1bEmQKAeOxGZ
         QQBqgOqQp6Vv4Appw/0swIFUYDaW/cnYUALygKs6AwLmaMvsLtShlb6z7E6z2xZLl4ft
         qTLt+kioELxyfNwfH7ORFgvjNYVHJTXr18+UNG+Ts6ZxAw4isITvjBsPBqYdwdWAenhD
         i1UJpXeFal/KWDe464J66yugrqsuApAIimmagN6iYxLzyYGhi3Vs2N8UeMn0dh1v/vOj
         fRyQ==
X-Gm-Message-State: AOAM530OCIJiBdFXRg127r0QOuSvH1JUUzD90nsteLssiKOE6faG5j48
        FeB3Uvm5cw1XTvD0l6ozlqTH9A==
X-Google-Smtp-Source: ABdhPJxg2H7GGqSxuA2j7nQ+3KCx6bncjtF6F/b+SnJo/kTX3c7GQ+K+m1Zw8H7mY4XBhk5WNZuQ2w==
X-Received: by 2002:a5d:474b:: with SMTP id o11mr17934314wrs.235.1605184633495;
        Thu, 12 Nov 2020 04:37:13 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id 71sm6877305wrm.20.2020.11.12.04.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 04:37:11 -0800 (PST)
Date:   Thu, 12 Nov 2020 13:37:06 +0100
From:   Marco Elver <elver@google.com>
To:     David Gow <davidgow@google.com>
Cc:     "Bird, Tim" <Tim.Bird@sony.com>,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] kunit: Support for Parameterized Testing
Message-ID: <20201112123706.GA2457520@elver.google.com>
References: <20201106192154.51514-1-98.arpi@gmail.com>
 <CABVgOSkQ6+y7OGw2494cJa2b60EkSjncLNAgc9cJDbS=X9J3WA@mail.gmail.com>
 <CANpmjNNp2RUCE_ypp2R4MznikTYRYeCDuF7VMp+Hbh=55KWa3A@mail.gmail.com>
 <47a05c5a-485d-026b-c1c3-476ed1a97856@gmail.com>
 <CABVgOSkZ9k6bHPp=LVATWfokMSrEuD87jOfE5MiVYAEbZMmaQQ@mail.gmail.com>
 <BY5PR13MB29336C5BE374D69939DCADABFDE90@BY5PR13MB2933.namprd13.prod.outlook.com>
 <CABVgOSnJAgWvTTABaF082LuYjAoAWzrBsyu9sT7x4GGMVsOD6Q@mail.gmail.com>
 <BY5PR13MB293305FE7ED35EC2B2C81AF1FDE80@BY5PR13MB2933.namprd13.prod.outlook.com>
 <CABVgOSn0vUvHFTPPnFGCmg0pEotwr6TQXQieRV=EMqs1QmFYUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSn0vUvHFTPPnFGCmg0pEotwr6TQXQieRV=EMqs1QmFYUw@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 12, 2020 at 04:18PM +0800, David Gow wrote:
> On Thu, Nov 12, 2020 at 12:55 AM Bird, Tim <Tim.Bird@sony.com> wrote:
[...]
> > > kunit_tool has a bug when parsing the comments / diagnostic lines,
> > > which requires a ": " to be present. This is a bug, which is being
> > > fixed[1], so while it's _nice_ to not trigger it, it's not really an
> > > important long-term goal of the format. In any case, this kunit_tool
> > > issue only affects the comment lines: if the per-parameter result line
> > > is an actual result, rather than just a diagnostic, this shouldn't be
> > > a problem.
> > >
> > > In any case, I still prefer my proposed option for now -- noting that
> > > these per-parameter results are not actually supposed to be parsed --
> > > with then the possibility of expanding them to actual nested results
> > > later should we wish. But if the idea of having TAP-like lines in
> > > diagnostics seems too dangerous (e.g. because people will try to parse
> > > them anyway), then I think the options we have are to stick to the
> > > output format given in the current version of this patch (which
> > > doesn't resemble a TAP result), make each parameterised version its
> > > own test (without a "container test", which would require a bit of
> > > extra work while computing test plans), or to hold this whole feature
> > > back until we can support arbitrary test hierarchies in KUnit.
> > It seems like you're missing a 4th option, which is just tack the parameter
> > name on, without using a colon, and have these testcases treated
> > as unique within the context of the super-test.  Is there some reason
> > these can't be expressed as individual testcases in the parent test?
> >
> 
> No: there's no fundamental reason why we couldn't do that, though
> there are some things which make it suboptiomal, IMHO.
>
> Firstly, there could be a lot of parameters, and that by not grouping
> them together it could make dealing with the results a little
> unwieldy. The other side of that is that it'll result in tests being
> split up and renamed as they're ported to use this, whereas if the
> whole test shows up once (with subtests or without), the old test name
> can still be there, with a single PASS/FAIL for the whole test.

Agree, it's suboptimal and having the parameterized not be absorbed by
the whole suite would be strongly preferred.

> (It also might be a little tricky with the current implementation to
> produce the test plan, as the parameters come from a generator, and I
> don't think there's a way of getting the number of parameters ahead of
> time. That's a problem with the sub-subtest model, too, though at
> least there it's a little more isolated from other tests.)

The whole point of generators, as I envisage it, is to also provide the
ability for varying parameters dependent on e.g. environment,
configuration, number of CPUs, etc. The current array-based generator is
the simplest possible use-case.

However, we *can* require generators generate a deterministic number of
parameters when called multiple times on the same system.

To that end, I propose a v7 (below) that takes care of getting number of
parameters (and also displays descriptions for each parameter where
available).

Now it is up to you how you want to turn the output from diagnostic
lines into something TAP compliant, because now we have the number of
parameters and can turn it into a subsubtest. But I think kunit-tool
doesn't understand subsubtests yet, so I suggest we take these patches,
and then somebody can prepare kunit-tool.

Or did I miss something else?

> > > Personally, I'd rather not hold this feature back, and prefer to have
> > > a single combined result available, so would just stick with v6 if
> > > so...
> > >
> > > Does that make sense?
> >
> > I understand what you are saying, but this seems like a step backwards.
> > We already know that having just numbers to represent a test case is not
> > very human friendly. The same will go for these parameter case numbers.
> > I admit to not following this kunit test parameterization effort, so I don't
> > know the background of how the numbers relate to the parameters.
> > But there must be some actual semantic meaning to each of the parameter
> > cases.  Not conveying that meaning as part of the test case name seems like
> > a missed opportunity.
> 
> Yeah: I'm not a big fan of just numbering the parameters either: the
> plan is to eventually support naming these. Basically, the goal is to
> be able to run the same test code repeatedly with different inputs
> (which may be programmatically generated): depending on the testcase /
> parameter generator in question, the numbers may mean something
> specific, but it's not necessarily the case. Certainly in most cases,
> the order of these parameters is unlikely to matter, so having the
> number be part of the test name isn't ideal there: it's unlikely to
> have semantic meaning, and worst-case could be unstable due to code
> changes.

We can name them. Probably a good idea to do it while we can, as I think
the best design is changing the generator function signature.

> > I'm at a little of a loss as to why, if you have valid testcase results, you would
> > shy away from putting them into a format that is machine-readable.  If it's because
> > the tooling is not there, then IMHO you should fix the tooling.
> 
> I think the real disconnect here is the ambiguity between treating
> each run-through with a different parameter as its own test case,
> versus an implementation detail of the single "meta testcase". Since
> parameters are not really named/ordered properly, (and the example is
> replacing a single test) it feels more like an implementation detail
> to me.
> 
> > I realize that perfect is the enemy of good enough, and that there's value for humans
> > to see these testcase results and manually interpret them, even if they are put into
> > a syntax that automated parsers will ignore.  However, I do think there's a danger that
> > this syntax will get canonicalized. Personally, I'd rather see the testcases
> > with parameters show up in the parsable results.  I'd rather sacrifice the hierarchy
> > than the results.
> 
> With the state of things at the moment, I don't think the individual
> results for given parameters are as useful as the overall result for
> the test (run over all parameters), so for me the hierarchy is more
> important than the actual results. There are certainly a lot of things
> we can do to make the results more useful (supporting named
> parameters, for one), and actually supporting the extra level of
> nesting in the tooling would make it possible to have both.

Named parameters are supported in my proposed v7 (see below). I think
it's now up to you what the format should be, as now it's just a matter
of changing 2 prints' formats to some non-diagnostic TAP compliant
output (but I have no idea what ;-)).

> There is of course another possibility -- to just not print the
> individual parameter results at all (the parameters will likely show
> up in the assertion messages of failures anyway -- especially if, as
> in the example, the _MSG() variants are used). That's probably
> slightly easier to read than a huge list of parameters which are all
> "ok" anyway...

To me this is not acceptable, as I'd like to see some progress feedback
for long tests.
 
> In any case, I'm happy to leave the final decision here to Arpitha and
> Marco, so long as we don't actually violate the TAP/KTAP spec and
> kunit_tool is able to read at least the top-level result. My
> preference is still to go either with the "# [test_case->name]:
> [ok|not ok] [index] - param-[index]", or to get rid of the
> per-parameter results entirely for now (or just print out a diagnostic
> message on failure). In any case, it's a decision we can revisit once
> we have support for named parameters, better tooling, or a better idea
> of how people are actually using this.

Right, so I think we'll be in a better place if we implement: 1)
parameter to description conversion support, 2) counting parameters. So
I decided to see what it looks like, and it wasn't too bad. I just don't
know how you want to fix kunit-tool to make these non-diagnostic lines
and not complain, but as I said, it'd be good to not block these
patches.

It currently looks like this:

| TAP version 14
| 1..6
|     # Subtest: ext4_inode_test
|     1..1
|     # inode_test_xtimestamp_decoding: Test with 1..16 params
|     # inode_test_xtimestamp_decoding: ok 1 - [1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits]
|     # inode_test_xtimestamp_decoding: ok 2 - [1969-12-31 Upper bound of 32bit < 0 timestamp, no extra bits]
|     # inode_test_xtimestamp_decoding: ok 3 - [1970-01-01 Lower bound of 32bit >=0 timestamp, no extra bits]
|     # inode_test_xtimestamp_decoding: ok 4 - [2038-01-19 Upper bound of 32bit >=0 timestamp, no extra bits]
|     # inode_test_xtimestamp_decoding: ok 5 - [2038-01-19 Lower bound of 32bit <0 timestamp, lo extra sec bit on]
|     # inode_test_xtimestamp_decoding: ok 6 - [2106-02-07 Upper bound of 32bit <0 timestamp, lo extra sec bit on]
|     # inode_test_xtimestamp_decoding: ok 7 - [2106-02-07 Lower bound of 32bit >=0 timestamp, lo extra sec bit on]
|     # inode_test_xtimestamp_decoding: ok 8 - [2174-02-25 Upper bound of 32bit >=0 timestamp, lo extra sec bit on]
|     # inode_test_xtimestamp_decoding: ok 9 - [2174-02-25 Lower bound of 32bit <0 timestamp, hi extra sec bit on]
|     # inode_test_xtimestamp_decoding: ok 10 - [2242-03-16 Upper bound of 32bit <0 timestamp, hi extra sec bit on]
|     # inode_test_xtimestamp_decoding: ok 11 - [2242-03-16 Lower bound of 32bit >=0 timestamp, hi extra sec bit on]
|     # inode_test_xtimestamp_decoding: ok 12 - [2310-04-04 Upper bound of 32bit >=0 timestamp, hi extra sec bit on]
|     # inode_test_xtimestamp_decoding: ok 13 - [2310-04-04 Upper bound of 32bit>=0 timestamp, hi extra sec bit 1. 1 ns]
|     # inode_test_xtimestamp_decoding: ok 14 - [2378-04-22 Lower bound of 32bit>= timestamp. Extra sec bits 1. Max ns]
|     # inode_test_xtimestamp_decoding: ok 15 - [2378-04-22 Lower bound of 32bit >=0 timestamp. All extra sec bits on]
|     # inode_test_xtimestamp_decoding: ok 16 - [2446-05-10 Upper bound of 32bit >=0 timestamp. All extra sec bits on]
|     ok 1 - inode_test_xtimestamp_decoding
| ok 1 - ext4_inode_test

Changing the format of the 2 prints to something else TAP-compliant
should be easy enough once kunit-tool supports subsubtests. :-)

I hope this is a reasonable compromise for now.

[Arpitha: I suggest waiting a day or two and see what further comments
 we get, and then take the 2 patches and send the v7 if we decide this is
 what we want.]

Thanks,
-- Marco

------ >8 ------

From 31a77b18c874ed93f2d4f8b398b56f10e56bcfd9 Mon Sep 17 00:00:00 2001
From: Arpitha Raghunandan <98.arpi@gmail.com>
Date: Sat, 7 Nov 2020 00:51:54 +0530
Subject: [PATCH 1/2] kunit: Support for Parameterized Testing

Implementation of support for parameterized testing in KUnit. This
approach requires the creation of a test case using the
KUNIT_CASE_PARAM() macro that accepts a generator function as input.

This generator function should return the next parameter given the
previous parameter in parameterized tests. It also provides a macro to
generate common-case generators based on arrays. Generators may also
optionally provide a human-readable description of parameters, which is
displayed where available.

Note, currently the result of each parameter run is displayed in
diagnostic lines, and only the overall test case output summarizes
TAP-compliant success or failure of all parameter runs. In future, when
supported by kunit-tool, these can be turned into subsubtest outputs.

Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
Co-developed-by: Marco Elver <elver@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
Changes v6->v7:
- Clarify commit message.
- Introduce ability to optionally generate descriptions for parameters;
  if no description is provided, we'll still print 'param-N'.
- Change diagnostic line format to:
	# <test-case-name>: <ok|not ok> N - [<param description>]
- Before execution of parameterized test case, count number of
  parameters and display number of parameters. Currently also as a
  diagnostic line, but this may be used in future to generate a subsubtest
  plan. A requirement of this change is that generators must generate a
  deterministic number of parameters.

Changes v5->v6:
- Fix alignment to maintain consistency

Changes v4->v5:
- Update kernel-doc comments.
- Use const void* for generator return and prev value types.
- Add kernel-doc comment for KUNIT_ARRAY_PARAM.
- Rework parameterized test case execution strategy: each parameter is executed
  as if it was its own test case, with its own test initialization and cleanup
  (init and exit are called, etc.). However, we cannot add new test cases per TAP
  protocol once we have already started execution. Instead, log the result of
  each parameter run as a diagnostic comment.

Changes v3->v4:
- Rename kunit variables
- Rename generator function helper macro
- Add documentation for generator approach
- Display test case name in case of failure along with param index

Changes v2->v3:
- Modifictaion of generator macro and method

Changes v1->v2:
- Use of a generator method to access test case parameters
---
 include/kunit/test.h | 50 +++++++++++++++++++++++++
 lib/kunit/test.c     | 89 +++++++++++++++++++++++++++++++++++++-------
 2 files changed, 126 insertions(+), 13 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 9197da792336..5935efb7b533 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -94,6 +94,9 @@ struct kunit;
 /* Size of log associated with test. */
 #define KUNIT_LOG_SIZE	512
 
+/* Maximum size of parameter description string. */
+#define KUNIT_PARAM_DESC_SIZE 64
+
 /*
  * TAP specifies subtest stream indentation of 4 spaces, 8 spaces for a
  * sub-subtest.  See the "Subtests" section in
@@ -107,6 +110,7 @@ struct kunit;
  *
  * @run_case: the function representing the actual test case.
  * @name:     the name of the test case.
+ * @generate_params: the generator function for parameterized tests.
  *
  * A test case is a function with the signature,
  * ``void (*)(struct kunit *)``
@@ -141,6 +145,7 @@ struct kunit;
 struct kunit_case {
 	void (*run_case)(struct kunit *test);
 	const char *name;
+	const void* (*generate_params)(const void *prev, char *desc);
 
 	/* private: internal use only. */
 	bool success;
@@ -163,6 +168,27 @@ static inline char *kunit_status_to_string(bool status)
  */
 #define KUNIT_CASE(test_name) { .run_case = test_name, .name = #test_name }
 
+/**
+ * KUNIT_CASE_PARAM - A helper for creation a parameterized &struct kunit_case
+ *
+ * @test_name: a reference to a test case function.
+ * @gen_params: a reference to a parameter generator function.
+ *
+ * The generator function::
+ *
+ *	const void* gen_params(const void *prev, char *desc)
+ *
+ * is used to lazily generate a series of arbitrarily typed values that fit into
+ * a void*. The argument @prev is the previously returned value, which should be
+ * used to derive the next value; @prev is set to NULL on the initial generator
+ * call. When no more values are available, the generator must return NULL.
+ * Optionally write a string into @desc (size of KUNIT_PARAM_DESC_SIZE)
+ * describing the parameter.
+ */
+#define KUNIT_CASE_PARAM(test_name, gen_params)			\
+		{ .run_case = test_name, .name = #test_name,	\
+		  .generate_params = gen_params }
+
 /**
  * struct kunit_suite - describes a related collection of &struct kunit_case
  *
@@ -208,6 +234,10 @@ struct kunit {
 	const char *name; /* Read only after initialization! */
 	char *log; /* Points at case log after initialization */
 	struct kunit_try_catch try_catch;
+	/* param_value is the current parameter value for a test case. */
+	const void *param_value;
+	/* param_index stores the index of the parameter in parameterized tests. */
+	int param_index;
 	/*
 	 * success starts as true, and may only be set to false during a
 	 * test case; thus, it is safe to update this across multiple
@@ -1742,4 +1772,24 @@ do {									       \
 						fmt,			       \
 						##__VA_ARGS__)
 
+/**
+ * KUNIT_ARRAY_PARAM() - Define test parameter generator from an array.
+ * @name:  prefix for the test parameter generator function.
+ * @array: array of test parameters.
+ * @get_desc: function to convert param to description; NULL to use default
+ *
+ * Define function @name_gen_params which uses @array to generate parameters.
+ */
+#define KUNIT_ARRAY_PARAM(name, array, get_desc)						\
+	static const void *name##_gen_params(const void *prev, char *desc)			\
+	{											\
+		typeof((array)[0]) *__next = prev ? ((typeof(__next)) prev) + 1 : (array);	\
+		if (__next - (array) < ARRAY_SIZE((array))) {					\
+			void (*__get_desc)(typeof(__next), char *) = get_desc;			\
+			if (__get_desc) __get_desc(__next, desc);				\
+			return __next;								\
+		}										\
+		return NULL;									\
+	}
+
 #endif /* _KUNIT_TEST_H */
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 750704abe89a..1a728bfc4da7 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -325,39 +325,102 @@ static void kunit_catch_run_case(void *data)
  * occur in a test case and reports them as failures.
  */
 static void kunit_run_case_catch_errors(struct kunit_suite *suite,
-					struct kunit_case *test_case)
+					struct kunit_case *test_case,
+					struct kunit *test)
 {
 	struct kunit_try_catch_context context;
 	struct kunit_try_catch *try_catch;
-	struct kunit test;
 
-	kunit_init_test(&test, test_case->name, test_case->log);
-	try_catch = &test.try_catch;
+	kunit_init_test(test, test_case->name, test_case->log);
+	try_catch = &test->try_catch;
 
 	kunit_try_catch_init(try_catch,
-			     &test,
+			     test,
 			     kunit_try_run_case,
 			     kunit_catch_run_case);
-	context.test = &test;
+	context.test = test;
 	context.suite = suite;
 	context.test_case = test_case;
 	kunit_try_catch_run(try_catch, &context);
 
-	test_case->success = test.success;
-
-	kunit_print_ok_not_ok(&test, true, test_case->success,
-			      kunit_test_case_num(suite, test_case),
-			      test_case->name);
+	test_case->success = test->success;
 }
 
 int kunit_run_tests(struct kunit_suite *suite)
 {
+	char param_desc[KUNIT_PARAM_DESC_SIZE];
 	struct kunit_case *test_case;
 
 	kunit_print_subtest_start(suite);
 
-	kunit_suite_for_each_test_case(suite, test_case)
-		kunit_run_case_catch_errors(suite, test_case);
+	kunit_suite_for_each_test_case(suite, test_case) {
+		struct kunit test = { .param_value = NULL, .param_index = 0 };
+		bool test_success = true;
+		int num_params = 0;
+
+		if (test_case->generate_params) {
+			const void *val; /* Only for counting params. */
+
+			/*
+			 * Count number of params: requires that param
+			 * generators are deterministic in number of params
+			 * generated. Always execute at least 1 param:
+			 *   - 1 or more non-NULL params;
+			 *   - special case: 1 param which may be NULL.
+			 */
+			val = test_case->generate_params(NULL, param_desc);
+			for (num_params = val ? 0 : 1; val; num_params++) {
+				val = test_case->generate_params(val, param_desc);
+			}
+
+			kunit_log(KERN_INFO, &test,
+				  KUNIT_SUBTEST_INDENT
+				  "# %s: Test with 1..%d params",
+				  test_case->name, num_params);
+
+			/* Get initial param. */
+			param_desc[0] = '\0';
+			test.param_value = test_case->generate_params(NULL, param_desc);
+		}
+
+		do {
+			kunit_run_case_catch_errors(suite, test_case, &test);
+			test_success &= test_case->success;
+
+			if (test_case->generate_params) {
+				if (param_desc[0] == '\0') {
+					snprintf(param_desc, sizeof(param_desc),
+						 "param-%d", test.param_index);
+				}
+
+				kunit_log(KERN_INFO, &test,
+					  KUNIT_SUBTEST_INDENT
+					  "# %s: %s %d - [%s]",
+					  test_case->name,
+					  kunit_status_to_string(test.success),
+					  test.param_index + 1, param_desc);
+
+				/* Get next param. */
+				param_desc[0] = '\0';
+				test.param_value = test_case->generate_params(test.param_value, param_desc);
+				test.param_index++;
+
+				/* Assert deterministic number of params. */
+				num_params--;
+				if (!!test.param_value != !!num_params) {
+					kunit_log(KERN_INFO, &test,
+						  KUNIT_SUBTEST_INDENT
+						  "# %s: Non-deterministic number of params",
+						  test_case->name);
+					test_success = false;
+				}
+			}
+		} while (test.param_value);
+
+		kunit_print_ok_not_ok(&test, true, test_success,
+				      kunit_test_case_num(suite, test_case),
+				      test_case->name);
+	}
 
 	kunit_print_subtest_end(suite);
 
-- 
2.29.2.222.g5d2a92d10f8-goog


From 1705948e9d1e1095ee56737a6d7a5c6342cdb5ee Mon Sep 17 00:00:00 2001
From: Arpitha Raghunandan <98.arpi@gmail.com>
Date: Sat, 7 Nov 2020 00:52:49 +0530
Subject: [PATCH 2/2] fs: ext4: Modify inode-test.c to use KUnit parameterized
 testing feature

Modify fs/ext4/inode-test.c to use the parameterized testing
feature of KUnit.

Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
Signed-off-by: Marco Elver <elver@google.com>
---
Changes v6->v7:
- Introduce timestamp_expectation_to_desc() to convert param to
  description.
Changes v5->v6:
- No change to this patch of the patch series
Changes v4->v5:
- No change to this patch of the patch series
Changes v3->v4:
- Modification based on latest implementation of KUnit parameterized testing
Changes v2->v3:
- Marked hardcoded test data const
- Modification based on latest implementation of KUnit parameterized testing
Changes v1->v2:
- Modification based on latest implementation of KUnit parameterized testing
---
 fs/ext4/inode-test.c | 320 ++++++++++++++++++++++---------------------
 1 file changed, 164 insertions(+), 156 deletions(-)

diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
index d62d802c9c12..97390ab13681 100644
--- a/fs/ext4/inode-test.c
+++ b/fs/ext4/inode-test.c
@@ -80,6 +80,145 @@ struct timestamp_expectation {
 	bool lower_bound;
 };
 
+static const struct timestamp_expectation test_data[] = {
+	{
+		.test_case_name = LOWER_BOUND_NEG_NO_EXTRA_BITS_CASE,
+		.msb_set = true,
+		.lower_bound = true,
+		.extra_bits = 0,
+		.expected = {.tv_sec = -0x80000000LL, .tv_nsec = 0L},
+	},
+
+	{
+		.test_case_name = UPPER_BOUND_NEG_NO_EXTRA_BITS_CASE,
+		.msb_set = true,
+		.lower_bound = false,
+		.extra_bits = 0,
+		.expected = {.tv_sec = -1LL, .tv_nsec = 0L},
+	},
+
+	{
+		.test_case_name = LOWER_BOUND_NONNEG_NO_EXTRA_BITS_CASE,
+		.msb_set = false,
+		.lower_bound = true,
+		.extra_bits = 0,
+		.expected = {0LL, 0L},
+	},
+
+	{
+		.test_case_name = UPPER_BOUND_NONNEG_NO_EXTRA_BITS_CASE,
+		.msb_set = false,
+		.lower_bound = false,
+		.extra_bits = 0,
+		.expected = {.tv_sec = 0x7fffffffLL, .tv_nsec = 0L},
+	},
+
+	{
+		.test_case_name = LOWER_BOUND_NEG_LO_1_CASE,
+		.msb_set = true,
+		.lower_bound = true,
+		.extra_bits = 1,
+		.expected = {.tv_sec = 0x80000000LL, .tv_nsec = 0L},
+	},
+
+	{
+		.test_case_name = UPPER_BOUND_NEG_LO_1_CASE,
+		.msb_set = true,
+		.lower_bound = false,
+		.extra_bits = 1,
+		.expected = {.tv_sec = 0xffffffffLL, .tv_nsec = 0L},
+	},
+
+	{
+		.test_case_name = LOWER_BOUND_NONNEG_LO_1_CASE,
+		.msb_set = false,
+		.lower_bound = true,
+		.extra_bits = 1,
+		.expected = {.tv_sec = 0x100000000LL, .tv_nsec = 0L},
+	},
+
+	{
+		.test_case_name = UPPER_BOUND_NONNEG_LO_1_CASE,
+		.msb_set = false,
+		.lower_bound = false,
+		.extra_bits = 1,
+		.expected = {.tv_sec = 0x17fffffffLL, .tv_nsec = 0L},
+	},
+
+	{
+		.test_case_name = LOWER_BOUND_NEG_HI_1_CASE,
+		.msb_set = true,
+		.lower_bound = true,
+		.extra_bits =  2,
+		.expected = {.tv_sec = 0x180000000LL, .tv_nsec = 0L},
+	},
+
+	{
+		.test_case_name = UPPER_BOUND_NEG_HI_1_CASE,
+		.msb_set = true,
+		.lower_bound = false,
+		.extra_bits = 2,
+		.expected = {.tv_sec = 0x1ffffffffLL, .tv_nsec = 0L},
+	},
+
+	{
+		.test_case_name = LOWER_BOUND_NONNEG_HI_1_CASE,
+		.msb_set = false,
+		.lower_bound = true,
+		.extra_bits = 2,
+		.expected = {.tv_sec = 0x200000000LL, .tv_nsec = 0L},
+	},
+
+	{
+		.test_case_name = UPPER_BOUND_NONNEG_HI_1_CASE,
+		.msb_set = false,
+		.lower_bound = false,
+		.extra_bits = 2,
+		.expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 0L},
+	},
+
+	{
+		.test_case_name = UPPER_BOUND_NONNEG_HI_1_NS_1_CASE,
+		.msb_set = false,
+		.lower_bound = false,
+		.extra_bits = 6,
+		.expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 1L},
+	},
+
+	{
+		.test_case_name = LOWER_BOUND_NONNEG_HI_1_NS_MAX_CASE,
+		.msb_set = false,
+		.lower_bound = true,
+		.extra_bits = 0xFFFFFFFF,
+		.expected = {.tv_sec = 0x300000000LL,
+			     .tv_nsec = MAX_NANOSECONDS},
+	},
+
+	{
+		.test_case_name = LOWER_BOUND_NONNEG_EXTRA_BITS_1_CASE,
+		.msb_set = false,
+		.lower_bound = true,
+		.extra_bits = 3,
+		.expected = {.tv_sec = 0x300000000LL, .tv_nsec = 0L},
+	},
+
+	{
+		.test_case_name = UPPER_BOUND_NONNEG_EXTRA_BITS_1_CASE,
+		.msb_set = false,
+		.lower_bound = false,
+		.extra_bits = 3,
+		.expected = {.tv_sec = 0x37fffffffLL, .tv_nsec = 0L},
+	}
+};
+
+static void timestamp_expectation_to_desc(const struct timestamp_expectation *t,
+					  char *desc)
+{
+	strcpy(desc, t->test_case_name);
+}
+
+KUNIT_ARRAY_PARAM(ext4_inode, test_data, timestamp_expectation_to_desc);
+
 static time64_t get_32bit_time(const struct timestamp_expectation * const test)
 {
 	if (test->msb_set) {
@@ -101,166 +240,35 @@ static time64_t get_32bit_time(const struct timestamp_expectation * const test)
  */
 static void inode_test_xtimestamp_decoding(struct kunit *test)
 {
-	const struct timestamp_expectation test_data[] = {
-		{
-			.test_case_name = LOWER_BOUND_NEG_NO_EXTRA_BITS_CASE,
-			.msb_set = true,
-			.lower_bound = true,
-			.extra_bits = 0,
-			.expected = {.tv_sec = -0x80000000LL, .tv_nsec = 0L},
-		},
-
-		{
-			.test_case_name = UPPER_BOUND_NEG_NO_EXTRA_BITS_CASE,
-			.msb_set = true,
-			.lower_bound = false,
-			.extra_bits = 0,
-			.expected = {.tv_sec = -1LL, .tv_nsec = 0L},
-		},
-
-		{
-			.test_case_name = LOWER_BOUND_NONNEG_NO_EXTRA_BITS_CASE,
-			.msb_set = false,
-			.lower_bound = true,
-			.extra_bits = 0,
-			.expected = {0LL, 0L},
-		},
-
-		{
-			.test_case_name = UPPER_BOUND_NONNEG_NO_EXTRA_BITS_CASE,
-			.msb_set = false,
-			.lower_bound = false,
-			.extra_bits = 0,
-			.expected = {.tv_sec = 0x7fffffffLL, .tv_nsec = 0L},
-		},
-
-		{
-			.test_case_name = LOWER_BOUND_NEG_LO_1_CASE,
-			.msb_set = true,
-			.lower_bound = true,
-			.extra_bits = 1,
-			.expected = {.tv_sec = 0x80000000LL, .tv_nsec = 0L},
-		},
-
-		{
-			.test_case_name = UPPER_BOUND_NEG_LO_1_CASE,
-			.msb_set = true,
-			.lower_bound = false,
-			.extra_bits = 1,
-			.expected = {.tv_sec = 0xffffffffLL, .tv_nsec = 0L},
-		},
-
-		{
-			.test_case_name = LOWER_BOUND_NONNEG_LO_1_CASE,
-			.msb_set = false,
-			.lower_bound = true,
-			.extra_bits = 1,
-			.expected = {.tv_sec = 0x100000000LL, .tv_nsec = 0L},
-		},
-
-		{
-			.test_case_name = UPPER_BOUND_NONNEG_LO_1_CASE,
-			.msb_set = false,
-			.lower_bound = false,
-			.extra_bits = 1,
-			.expected = {.tv_sec = 0x17fffffffLL, .tv_nsec = 0L},
-		},
-
-		{
-			.test_case_name = LOWER_BOUND_NEG_HI_1_CASE,
-			.msb_set = true,
-			.lower_bound = true,
-			.extra_bits =  2,
-			.expected = {.tv_sec = 0x180000000LL, .tv_nsec = 0L},
-		},
-
-		{
-			.test_case_name = UPPER_BOUND_NEG_HI_1_CASE,
-			.msb_set = true,
-			.lower_bound = false,
-			.extra_bits = 2,
-			.expected = {.tv_sec = 0x1ffffffffLL, .tv_nsec = 0L},
-		},
-
-		{
-			.test_case_name = LOWER_BOUND_NONNEG_HI_1_CASE,
-			.msb_set = false,
-			.lower_bound = true,
-			.extra_bits = 2,
-			.expected = {.tv_sec = 0x200000000LL, .tv_nsec = 0L},
-		},
-
-		{
-			.test_case_name = UPPER_BOUND_NONNEG_HI_1_CASE,
-			.msb_set = false,
-			.lower_bound = false,
-			.extra_bits = 2,
-			.expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 0L},
-		},
-
-		{
-			.test_case_name = UPPER_BOUND_NONNEG_HI_1_NS_1_CASE,
-			.msb_set = false,
-			.lower_bound = false,
-			.extra_bits = 6,
-			.expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 1L},
-		},
-
-		{
-			.test_case_name = LOWER_BOUND_NONNEG_HI_1_NS_MAX_CASE,
-			.msb_set = false,
-			.lower_bound = true,
-			.extra_bits = 0xFFFFFFFF,
-			.expected = {.tv_sec = 0x300000000LL,
-				     .tv_nsec = MAX_NANOSECONDS},
-		},
-
-		{
-			.test_case_name = LOWER_BOUND_NONNEG_EXTRA_BITS_1_CASE,
-			.msb_set = false,
-			.lower_bound = true,
-			.extra_bits = 3,
-			.expected = {.tv_sec = 0x300000000LL, .tv_nsec = 0L},
-		},
-
-		{
-			.test_case_name = UPPER_BOUND_NONNEG_EXTRA_BITS_1_CASE,
-			.msb_set = false,
-			.lower_bound = false,
-			.extra_bits = 3,
-			.expected = {.tv_sec = 0x37fffffffLL, .tv_nsec = 0L},
-		}
-	};
-
 	struct timespec64 timestamp;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(test_data); ++i) {
-		timestamp.tv_sec = get_32bit_time(&test_data[i]);
-		ext4_decode_extra_time(&timestamp,
-				       cpu_to_le32(test_data[i].extra_bits));
-
-		KUNIT_EXPECT_EQ_MSG(test,
-				    test_data[i].expected.tv_sec,
-				    timestamp.tv_sec,
-				    CASE_NAME_FORMAT,
-				    test_data[i].test_case_name,
-				    test_data[i].msb_set,
-				    test_data[i].lower_bound,
-				    test_data[i].extra_bits);
-		KUNIT_EXPECT_EQ_MSG(test,
-				    test_data[i].expected.tv_nsec,
-				    timestamp.tv_nsec,
-				    CASE_NAME_FORMAT,
-				    test_data[i].test_case_name,
-				    test_data[i].msb_set,
-				    test_data[i].lower_bound,
-				    test_data[i].extra_bits);
-	}
+
+	struct timestamp_expectation *test_param =
+			(struct timestamp_expectation *)(test->param_value);
+
+	timestamp.tv_sec = get_32bit_time(test_param);
+	ext4_decode_extra_time(&timestamp,
+			       cpu_to_le32(test_param->extra_bits));
+
+	KUNIT_EXPECT_EQ_MSG(test,
+			    test_param->expected.tv_sec,
+			    timestamp.tv_sec,
+			    CASE_NAME_FORMAT,
+			    test_param->test_case_name,
+			    test_param->msb_set,
+			    test_param->lower_bound,
+			    test_param->extra_bits);
+	KUNIT_EXPECT_EQ_MSG(test,
+			    test_param->expected.tv_nsec,
+			    timestamp.tv_nsec,
+			    CASE_NAME_FORMAT,
+			    test_param->test_case_name,
+			    test_param->msb_set,
+			    test_param->lower_bound,
+			    test_param->extra_bits);
 }
 
 static struct kunit_case ext4_inode_test_cases[] = {
-	KUNIT_CASE(inode_test_xtimestamp_decoding),
+	KUNIT_CASE_PARAM(inode_test_xtimestamp_decoding, ext4_inode_gen_params),
 	{}
 };
 
-- 
2.29.2.222.g5d2a92d10f8-goog

