Return-Path: <linux-kselftest+bounces-49333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D33D3A0C8
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 08:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD2A83011B34
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 07:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02721338931;
	Mon, 19 Jan 2026 07:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XRg16ZZf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c0Qk6iqp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3CA338F40;
	Mon, 19 Jan 2026 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768809428; cv=none; b=WHnBJFdvcaN30W7yOicykNXf+7sWFH4kFI6gA29GZLkSPOMdAzgvt9zXf3Be5se+ZU4ZL9CmHjimxLGiOUW6GhXGtrQjhKzwDYeujJrE759xszAGtP7RDvrKK5lmBvzb0oMFA/eof3H31URJ/JOwkbsa6IDPGi+Kt8dDCcS2hbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768809428; c=relaxed/simple;
	bh=NztPib06nclfFem4eRTpqDbIL3ybDXgAG+mG7CiAWNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7u0Y3DUwmXsvZ5/4qqCrU+JEDYDsFPDNCxui/ChyGGsxK4ifaIczu9uXQeSOUeLCvbW/lApSJXwEJkQMpa/g048b2NyLGSuy4ZH+7bQ83bGhh58iW3uUhheAPRQ8QNyrygQGbd/AhgTK9oO1oPr98HqTWVax1zKQwjy5uD51Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XRg16ZZf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c0Qk6iqp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Jan 2026 08:57:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768809424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=luXPqZVw+Gc8X8LE4fJpodEB0HTi8FZWENyyEYXSJUc=;
	b=XRg16ZZfDJhfN9VFYdh5zA5CZVLkUM+2JTiA3tu8I8qKOWuX64folP+2xFZXrUXP6KrF0F
	p9dpkuZ8BEiSq+g+jME6OsEZIeS1+p+3hxi3VKPa5QFXL4k1YAd6BYHXVFiyXQffSint3M
	TKp0/ZusMRi7Q3PuRmjp/CbISLQA+T5nPUH6nunv8ZBoSqJVaJn69+nAEybahKDllwb7JQ
	fiBlrw8VD2nqPl8Oze3X1KV2R0IbTCARuqNDHZhcRAsfp2xmCrGyQz3DPNLHEPP4gi/3fA
	3XAT8yDgckyXVfdWqxe8CX0QxKD4tNjSLg4gQjoilSuglkRljv7/qzT2xumk+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768809424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=luXPqZVw+Gc8X8LE4fJpodEB0HTi8FZWENyyEYXSJUc=;
	b=c0Qk6iqpDIopcOq4c0g5vA9zNVQRAHd8nL8Te9NelDG61LDGOBTHBRGKfqBcOoq67VYqu1
	I7WN+fMLmUKQNxCw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <raemoar63@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kselftest@vger.kernel.org, workflows@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kunit-dev@googlegroups.com
Subject: Re: [PATCH] kunit: tool: Add (primitive) support for outputting
 JUnit XML
Message-ID: <20260119085229-a89b3a97-a283-4417-ac09-13240c39c9fc@linutronix.de>
References: <20260119073426.1952867-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119073426.1952867-1-davidgow@google.com>

On Mon, Jan 19, 2026 at 03:34:24PM +0800, David Gow wrote:
> This is used by things like Jenkins and other CI systems, which can
> pretty-print the test output and potentially provide test-level comparisons
> between runs.
> 
> The implementation here is pretty basic: it only provides the raw results,
> split into tests and test suites, and doesn't provide any overall metadata.
> However, CI systems like Jenkins can injest it and it is already useful.
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  Documentation/dev-tools/kunit/run_wrapper.rst |  3 ++
>  tools/testing/kunit/kunit.py                  | 25 +++++++++++-
>  tools/testing/kunit/kunit_junit.py            | 36 +++++++++++++++++
>  tools/testing/kunit/kunit_tool_test.py        | 40 +++++++++++++++++--
>  4 files changed, 100 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/kunit/kunit_junit.py

(...)

> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index e3d82a038f93..0698d27c3629 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -21,6 +21,7 @@ from enum import Enum, auto
>  from typing import Iterable, List, Optional, Sequence, Tuple
>  
>  import kunit_json
> +import kunit_junit
>  import kunit_kernel
>  import kunit_parser
>  from kunit_printer import stdout, null_printer
> @@ -49,6 +50,7 @@ class KunitBuildRequest(KunitConfigRequest):
>  class KunitParseRequest:
>  	raw_output: Optional[str]
>  	json: Optional[str]
> +	junit: Optional[str]
>  	summary: bool
>  	failed: bool
>  
> @@ -261,6 +263,17 @@ def parse_tests(request: KunitParseRequest, metadata: kunit_json.Metadata, input
>  			stdout.print_with_timestamp("Test results stored in %s" %
>  				os.path.abspath(request.json))
>  
> +	if request.junit:
> +		junit_str = kunit_junit.get_junit_result(
> +					test=test)

Unnecessary linebreak?

> +		if request.junit == 'stdout':
> +			print(junit_str)
> +		else:
> +			with open(request.junit, 'w') as f:
> +				f.write(junit_str)
> +			stdout.print_with_timestamp("Test results stored in %s" %
> +				os.path.abspath(request.junit))
> +
>  	if test.status != kunit_parser.TestStatus.SUCCESS:
>  		return KunitResult(KunitStatus.TEST_FAILURE, parse_time), test
>  

(...)

> diff --git a/tools/testing/kunit/kunit_junit.py b/tools/testing/kunit/kunit_junit.py
> new file mode 100644
> index 000000000000..58d482e0c793
> --- /dev/null
> +++ b/tools/testing/kunit/kunit_junit.py
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Generates JSON from KUnit results according to
> +# KernelCI spec: https://github.com/kernelci/kernelci-doc/wiki/Test-API
> +#
> +# Copyright (C) 2025, Google LLC.
> +# Author: David Gow <davidgow@google.com>
> +
> +
> +from kunit_parser import Test, TestStatus
> +
> +def escape_xml_string(string : str) -> str:
> +	return string.replace("&", "&amp;").replace("\"", "&quot;").replace("'", "&apos;").replace("<", "&lt;").replace(">", "&gt;")
> +
> +def get_test_suite(test: Test) -> str:
> +	xml_output = '<testsuite name="' + escape_xml_string(test.name) + '" tests="' + str(test.counts.total()) + '" failures="' + str(test.counts.failed) + '" skipped="' +str(test.counts.skipped) + '">\n'
> +
> +	for subtest in test.subtests:
> +		if subtest.subtests:
> +			xml_output += get_test_suite(subtest)
> +			continue
> +		xml_output += '<testcase name="' + escape_xml_string(subtest.name) + '" >\n'
> +		if subtest.status == TestStatus.FAILURE:
> +			xml_output += '<failure>Test Failed</failure>\n'
> +		xml_output += '<system-out><![CDATA[' + "\n".join(subtest.log) + ']]></system-out>\n'
> +		xml_output += '</testcase>\n'
> +
> +	xml_output += '</testsuite>\n\n'
> +
> +	return xml_output
> +
> +def get_junit_result(test: Test) -> str:
> +	xml_output = '<?xml version="1.0" encoding="UTF-8" ?>\n\n'
> +
> +	xml_output += get_test_suite(test)
> +	return xml_output

Did you look into the Python stdlib XML serializer?
https://docs.python.org/3/library/xml.sax.utils.html#xml.sax.saxutils.XMLGenerator
https://docs.python.org/3/library/xml.sax.handler.html#contenthandler-objects

With that there should be no need to mess around with low-level XML syntax.

(...)


Thomas

