Return-Path: <linux-kselftest+bounces-3644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEE883E4FC
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 23:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC774B26A8B
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 22:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB61B2555E;
	Fri, 26 Jan 2024 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RmGvwOMt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79808250F1
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Jan 2024 22:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307339; cv=none; b=WVRf+pmKja2Yqp3NwYZAUSGQevaA5z0pNtSxOSoYfI6AcM00pMqzl0avLxmGm56YWcMLalJ6mwSy3+DQm29gMiNDhS6epcXUfuDnwUOzAUVhZcEBEiAVhHEsEb6vJz7xUkVUNSHIYJD07YuK0466gMLkGm9Nd3SUQ6lMGFuKIng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307339; c=relaxed/simple;
	bh=T02XmBJDADvKcZTilAObNi55rEWmd0jbEWH/a/5XHYo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BWs3a7n1LrO2vVuVP7Qagkjmhojy3wGjpPXWGaGfjqeCfonKOqUPNl2VaeFnWqI0FOV0YfLyCENVsvpa/BB/zb7heUWlcwUBfOtUwSUmHt83Hl4WeB2bTv2dDufohSjzOx0BS+pD9rZZDKWN4e5dAi4603OW63Pw/pkq+91tv8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RmGvwOMt; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6029c85922dso16376847b3.3
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jan 2024 14:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706307336; x=1706912136; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wfOq9kvoZ78MTfE+CrR6Nj3VpN/I/l27htej84EdWP4=;
        b=RmGvwOMtmHKzcpqKp5qcbkfxgrIlZ9w1Ja5U0BjEHDeGORA55k9prG2jHWGUMuyR1n
         iKCsSYT+c1ePB7KO4fH9x7WTYFktZszFjjFbDrrcdAqUJPbMo165IbPg8nX7wjE6PY4y
         eEhpJg8zsVxhKnkab5aAr+lJkK/TEnqFLZMvYXjh2Z0LlndWNhMl8skp/vGhyFGAYM8O
         R/lVgmPn+4S56F5VZPLwi8gTFsklLNMTXBfb235cDQjkBsgmMID6x3/vis7C//iXio9S
         eQGn/wFyaANJvgJHzgH6lL+mE1tIH0s+8OiD8eBXmrOk29DLHU9JQYbaVQiSgLEnzxnz
         UL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706307336; x=1706912136;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wfOq9kvoZ78MTfE+CrR6Nj3VpN/I/l27htej84EdWP4=;
        b=hX+K/nDKdi5LM9FzkOL/vMDC/1x7qEaPd1wB+nssj7itJLEyI3N7by4nJ+lHhuuX8c
         fGsDWfbQDuHqoh/8rt7aegmxcPIN2TyLYFS0Ciq4aovJyqcTKKUTJ8nRaqsbH4OBTQxS
         AKtFuLTuqAQIEWWl/YfkphvbOmuvWOz7f/a2K+FM8P5E8uswo6v9pbDjbsJ3aCsABdYb
         1heC8P9XTcPKCcCmFN4fXn9uyYWlkmB1Mj2CAjbprWWJ3pjtvl6GGg33Yz0Fv+a/vWC6
         Y30V2LMGVntlk3xv8wF0HxqFpuczJhiChRz//iUQq3EQA3a3C+Ny2U/0gvPbSav9N+0F
         HslQ==
X-Gm-Message-State: AOJu0YzNfaandmtO0KW6ZBO92t+5d2TCwBvFVMDH39/LbeQQ+MuTS/rL
	5xGtVZuRj4dNxzPSY9er7CvUnRecTuABi8740hn6fKY1QxFvK2XWiHCkAtigJ6fvw7rvDFp/hw=
	=
X-Google-Smtp-Source: AGHT+IE6htndHGdPTl+G+lmUHLoJ75Z4eKrFu6nBmvxCp4uHri9nfyOa4lYFJnuF5baBpwP0Uw21cH4rVA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a81:9a16:0:b0:600:2501:19b8 with SMTP id
 r22-20020a819a16000000b00600250119b8mr211259ywg.2.1706307336515; Fri, 26 Jan
 2024 14:15:36 -0800 (PST)
Date: Fri, 26 Jan 2024 22:14:26 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240126221426.4173112-1-rmoar@google.com>
Subject: [KTAP V2 PATCH v2] ktap_v2: add test metadata
From: Rae Moar <rmoar@google.com>
To: frowand.list@gmail.com, davidgow@google.com, keescook@chromium.org, 
	Tim.Bird@sony.com, shuah@kernel.org, brendanhiggins@google.com, 
	dlatypov@google.com
Cc: tytso@google.com, gustavo.padovan@collabora.com, 
	ricardo.canuelo@collabora.com, guillaume.tucker@collabora.com, corbet@lwn.net, 
	kernelci@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Add specification for test metadata to the KTAP v2 spec.

KTAP v1 only specifies the output format of very basic test information:
test result and test name. Any additional test information either gets
added to general diagnostic data or is not included in the output at all.

The purpose of KTAP metadata is to create a framework to include and
easily identify additional important test information in KTAP.

KTAP metadata could include any test information that is pertinent for
user interaction before or after the running of the test. For example,
the test file path or the test speed.

Since this includes a large variety of information, this specification
will recognize notable types of KTAP metadata to ensure consistent format
across test frameworks. See the full list of types in the specification.

Example of KTAP Metadata:

 KTAP version 2
 # ktap_test: main
 # ktap_arch: uml
 1..1
     KTAP version 2
     # ktap_test: suite_1
     # ktap_subsystem: example
     # ktap_test_file: lib/test.c
     1..2
     ok 1 test_1
     # ktap_test: test_2
     # ktap_speed: very_slow
     # custom_is_flaky: true
     ok 2 test_2
 ok 1 test_suite

The changes to the KTAP specification outline the format, location, and
different types of metadata.

Here is a link to a version of the KUnit parser that is able to parse test
metadata lines for KTAP version 2. Note this includes test metadata
lines for the main level of KTAP.

Link: https://kunit-review.googlesource.com/c/linux/+/5889

Signed-off-by: Rae Moar <rmoar@google.com>
---
 Documentation/dev-tools/ktap.rst | 163 ++++++++++++++++++++++++++++++-
 1 file changed, 159 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
index ff77f4aaa6ef..4480eaf5bbc3 100644
--- a/Documentation/dev-tools/ktap.rst
+++ b/Documentation/dev-tools/ktap.rst
@@ -17,19 +17,20 @@ KTAP test results describe a series of tests (which may be nested: i.e., test
 can have subtests), each of which can contain both diagnostic data -- e.g., log
 lines -- and a final result. The test structure and results are
 machine-readable, whereas the diagnostic data is unstructured and is there to
-aid human debugging.
+aid human debugging. One exception to this is test metadata lines - a type
+of diagnostic lines. Test metadata is used to identify important supplemental
+test information and can be machine-readable.
 
 KTAP output is built from four different types of lines:
 - Version lines
 - Plan lines
 - Test case result lines
-- Diagnostic lines
+- Diagnostic lines (including test metadata)
 
 In general, valid KTAP output should also form valid TAP output, but some
 information, in particular nested test results, may be lost. Also note that
 there is a stagnant draft specification for TAP14, KTAP diverges from this in
-a couple of places (notably the "Subtest" header), which are described where
-relevant later in this document.
+a couple of places, which are described where relevant later in this document.
 
 Version lines
 -------------
@@ -166,6 +167,154 @@ even if they do not start with a "#": this is to capture any other useful
 kernel output which may help debug the test. It is nevertheless recommended
 that tests always prefix any diagnostic output they have with a "#" character.
 
+KTAP metadata lines
+-------------------
+
+KTAP metadata lines are a subset of diagnostic lines that are used to include
+and easily identify important supplemental test information in KTAP.
+
+.. code-block:: none
+
+	# <prefix>_<metadata type>: <metadata value>
+
+The <prefix> indicates where to find the specification for the type of
+metadata. The metadata types listed below use the prefix "ktap" (See Types of
+KTAP Metadata).
+
+Types that are instead specified by an individual test framework use the
+framework name as the prefix. For example, a metadata type documented by the
+kselftest specification would use the prefix "kselftest". Any metadata type
+that is not listed in a specification must use the prefix "custom". Note the
+prefix must not include spaces or the characters ":" or "_".
+
+The format of <metadata type> and <value> varies based on the type. See the
+individual specification. For "custom" types the <metadata type> can be any
+string excluding ":", spaces, or newline characters and the <value> can be any
+string.
+
+**Location:**
+
+The first KTAP metadata entry for a test must be "# ktap_test: <test name>",
+which acts as a header to associate metadata with the correct test.
+
+For test cases, the location of the metadata is between the prior test result
+line and the current test result line. For test suites, the location of the
+metadata is between the suite's version line and test plan line. See the
+example below.
+
+KTAP metadata for a test does not need to be contiguous. For example, a kernel
+warning or other diagnostic output could interrupt metadata lines. However, it
+is recommended to keep a test's metadata lines together when possible, as this
+improves readability.
+
+**Here is an example of using KTAP metadata:**
+
+::
+
+        KTAP version 2
+        # ktap_test: main
+        # ktap_arch: uml
+        1..1
+          KTAP version 2
+          # ktap_test: suite_1
+          # ktap_subsystem: example
+          # ktap_test_file: lib/test.c
+          1..2
+          ok 1 test_1
+          # ktap_test: test_2
+          # ktap_speed: very_slow
+          # custom_is_flaky: true
+          ok 2 test_2
+        # suite_1 passed
+        ok 1 suite_1
+
+In this example, the tests are running on UML. The test suite "suite_1" is part
+of the subsystem "example" and belongs to the file "lib/example_test.c". It has
+two subtests, "test_1" and "test_2". The subtest "test_2" has a speed of
+"very_slow" and has been marked with a custom KTAP metadata type called
+"custom_is_flaky" with the value of "true".
+
+**Types of KTAP Metadata:**
+
+This is the current list of KTAP metadata types recognized in this
+specification. Note that all of these metadata types are optional (except for
+ktap_test as the KTAP metadata header).
+
+- ``ktap_test``: Name of test (used as header of KTAP metadata). This should
+  match the test name printed in the test result line: "ok 1 [test_name]".
+
+- ``ktap_module``: Name of the module containing the test
+
+- ``ktap_subsystem``: Name of the subsystem being tested
+
+- ``ktap_start_time``: Time tests started in ISO8601 format
+
+  - Example: "# ktap_start_time: 2024-01-09T13:09:01.990000+00:00"
+
+- ``ktap_duration``: Time taken (in seconds) to execute the test
+
+  - Example: "ktap_duration: 10.154s"
+
+- ``ktap_speed``: Category of how fast test runs: "normal", "slow", or
+  "very_slow"
+
+- ``ktap_test_file``: Path to source file containing the test. This metadata
+  line can be repeated if the test is spread across multiple files.
+
+  - Example: "# ktap_test_file: lib/test.c"
+
+- ``ktap_generated_file``: Description of and path to file generated during
+  test execution. This could be a core dump, generated filesystem image, some
+  form of visual output (for graphics drivers), etc. This metadata line can be
+  repeated to attach multiple files to the test.
+
+  - Example: "# ktap_generated_file: Core dump: /var/lib/systemd/coredump/hello.core"
+
+- ``ktap_log_file``: Path to file containing kernel log test output
+
+  - Example: "# ktap_log_file: /sys/kernel/debugfs/kunit/example/results"
+
+- ``ktap_error_file``: Path to file containing context for test failure or
+  error. This could include the difference between optimal test output and
+  actual test output.
+
+  - Example: "# ktap_error_file: fs/results/example.out.bad"
+
+- ``ktap_results_url``: Link to webpage describing this test run and its
+  results
+
+  - Example: "# ktap_results_url: https://kcidb.kernelci.org/hello"
+
+- ``ktap_arch``: Architecture used during test run
+
+  - Example: "# ktap_arch: x86_64"
+
+- ``ktap_compiler``: Compiler used during test run
+
+  - Example: "# ktap_compiler: gcc (GCC) 10.1.1 20200507 (Red Hat 10.1.1-1)"
+
+- ``ktap_respository_url``: Link to git repository of the checked out code.
+
+  - Example: "# ktap_respository_url: https://github.com/torvalds/linux.git"
+
+- ``ktap_git_branch``: Name of git branch of checked out code
+
+  - Example: "# ktap_git_branch: kselftest/kunit"
+
+- ``ktap_kernel_version``: Version of Linux Kernel being used during test run
+
+  - Example: "# ktap_kernel_version: 6.7-rc1"
+
+- ``ktap_commit_hash``: The full git commit hash of the checked out base code.
+
+  - Example: "# ktap_commit_hash: 064725faf8ec2e6e36d51e22d3b86d2707f0f47f"
+
+**Other Metadata Types:**
+
+There can also be KTAP metadata that is not included in the recognized list
+above. This metadata must be prefixed with the test framework, ie. "kselftest",
+or with the prefix "custom". For example, "# custom_batch: 20".
+
 Unknown lines
 -------------
 
@@ -206,6 +355,7 @@ An example of a test with two nested subtests:
 	KTAP version 2
 	1..1
 	  KTAP version 2
+	  # ktap_test: example
 	  1..2
 	  ok 1 test_1
 	  not ok 2 test_2
@@ -219,6 +369,7 @@ An example format with multiple levels of nested testing:
 	KTAP version 2
 	1..2
 	  KTAP version 2
+	  # ktap_test: example_test_1
 	  1..2
 	    KTAP version 2
 	    1..2
@@ -254,6 +405,7 @@ Example KTAP output
 	KTAP version 2
 	1..1
 	  KTAP version 2
+	  # ktap_test: main_test
 	  1..3
 	    KTAP version 2
 	    1..1
@@ -261,11 +413,14 @@ Example KTAP output
 	    ok 1 test_1
 	  ok 1 example_test_1
 	    KTAP version 2
+        # ktap_test: example_test_2
+        # ktap_speed: slow
 	    1..2
 	    ok 1 test_1 # SKIP test_1 skipped
 	    ok 2 test_2
 	  ok 2 example_test_2
 	    KTAP version 2
+	    # ktap_test: example_test_3
 	    1..3
 	    ok 1 test_1
 	    # test_2: FAIL

base-commit: 906f02e42adfbd5ae70d328ee71656ecb602aaf5
-- 
2.43.0.429.g432eaa2c6b-goog


