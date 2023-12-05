Return-Path: <linux-kselftest+bounces-1189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A612805DE6
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 19:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2301FB20DD8
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 18:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A674CA6C;
	Tue,  5 Dec 2023 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LV2Zye/o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7C81A1
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Dec 2023 10:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701801931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eXB6/JKbV4tlSKi16BxWQoAzgHXel/eAulm+zLLiiB4=;
	b=LV2Zye/oFCOlUAQNqWGNxBN4C8o0MK+xuMMLpx2X0YC/Z9z9UVSS4RKa23fXN93IAcIilq
	Tm6EcctD2/vciKVzi8KdnsyKw/G2t2cjEBsYajk1KSbJ68oQNbyhwwM3Jzs5HfdP59CaQ+
	pmXRU9nbok42dpeli1kh0+sQITWxpno=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-upjkIcedOdq1iCOpH_d0uw-1; Tue, 05 Dec 2023 13:45:28 -0500
X-MC-Unique: upjkIcedOdq1iCOpH_d0uw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87F2584AEA0;
	Tue,  5 Dec 2023 18:45:27 +0000 (UTC)
Received: from ruby.redhat.com (unknown [10.39.192.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C2107492BE6;
	Tue,  5 Dec 2023 18:45:24 +0000 (UTC)
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
To: workflows@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Joe Perches <joe@perches.com>,
	Andy Whitcroft <apw@canonical.com>,
	Theodore Ts'o <tytso@mit.edu>,
	David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Cc: kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	Veronika Kabatova <vkabatov@redhat.com>,
	CKI <cki-project@redhat.com>,
	kernelci@lists.linux.dev
Subject: [RFC PATCH v2 00/10] MAINTAINERS: Introduce V: entry for tests
Date: Tue,  5 Dec 2023 20:02:56 +0200
Message-ID: <20231205184503.79769-1-Nikolai.Kondrashov@redhat.com>
In-Reply-To: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Alright, here's a second version, attempting to address as many concerns as
possible. It's likely I've missed something, though.

Changes from v1:

* Make scripts/get_maintainer.pl survive querying missing files, giving a
  warning instead. This is necessary to enable scripts/checkpatch.pl to query
  MAINTAINERS about files being deleted.
* Start with the minimal change just documenting the V: entry, which accepts
  test commands directly, and tweaking the tools to deal with that.
* However, require the commands accept the -h/--help option so that users have
  an easier time getting *some* help. The run_checks.py missing that is the
  reason why the patch proposing it for kunit subsystem is marked "DONOTMERGE"
  in this version. We can drop that requirement, or soften the language, if
  there's opposition.
* Have a *separate* patch documenting 'Tested-with:' as the next (early)
  change. Mention that you can add a '#' followed by a results URL, on the
  end. Adjust the V: docs/checks to exclude '#'.
* Have a *separate* patch making scripts/checkpatch.pl propose the execution
  of the test suite defined in MAINTAINERS whenever the corresponding
  subsystem is changed.
* However, use 'CHECK', instead of 'WARNING', to allow submitters specify the
  exact (and potentially slightly different) command they used, and not have
  checkpatch.pl complain too loudly that they didn't run the (exact
  MAINTAINERS-specified) command. This unfortunately means that unless you use
  --strict, you won't see the message. We'll try to address that in a new
  change at the end.
* Have a *separate* patch introducing the test catalog and accepting
  references to that everywhere, with a special syntax to distinguish them
  from verbatim/direct commands. The syntax is prepending the test name with a
  '*' (just like C pointer dereference). Make checkpatch.pl handle that.
* Drop the recommendation to have the "Docs" and "Sources" fields in test
  descriptions, as the description text should focus on giving a good
  introduction and not prompt the user to go somewhere else immediately. They
  both can be referenced in the text where and how is appropriate.
* Generally keep the previous changes adding V: entries and test suite docs,
  and try to accommodate all the requests, but refine the "Summary" fields to
  fit the checkpatch.pl messages better.
* Have a separate patch cataloguing the complete kunit suite.
* Finally, add a patch introducing the "proposal strength" keywords
  (SUGGESTED/RECOMMENDED/REQUIRED) to the syntax of V: entries, which directly
  affect which level of checkpatch.pl message missing 'Tested-with:' tags
  would generate: CHECK/WARNING/ERROR respectively. This allows subsystems to
  disable checkpatch.pl WARNINGS/ERRORS, and keep their test proposals
  inobtrusive, if they so wish. E.g. if they expect people to change their
  commands often. At the same time allow stricter workflows for subsystems
  with more uniform testing. Or e.g. for subsystems which expect the tests to
  explain their parameters in their output, and the submitters to upload and
  link their results in their 'Tested-with:' tags.

That seems to be all, but I'm sure I forgot something :D

Anyway, send me more corrections and I'll try to address them, but it's likely
going to happen next year only.

Nick
---
Nikolai Kondrashov (9):
      get_maintainer: Survive querying missing files
      MAINTAINERS: Introduce V: entry for tests
      MAINTAINERS: Propose kunit core tests for framework changes
      docs: submitting-patches: Introduce Tested-with:
      checkpatch: Propose tests to execute
      MAINTAINERS: Support referencing test docs in V:
      MAINTAINERS: Propose kvm-xfstests smoke for ext4
      docs: tests: Document kunit in general
      MAINTAINERS: Add proposal strength to V: entries

Mark Brown (1):
      MAINTAINERS: Propose kunit tests for regmap

 Documentation/process/index.rst              |   1 +
 Documentation/process/submitting-patches.rst |  46 +++++++
 Documentation/process/tests.rst              |  96 +++++++++++++++
 MAINTAINERS                                  |  17 +++
 scripts/checkpatch.pl                        | 174 ++++++++++++++++++++++++++-
 scripts/get_maintainer.pl                    |  23 +++-
 scripts/parse-maintainers.pl                 |   3 +-
 7 files changed, 355 insertions(+), 5 deletions(-)
---



