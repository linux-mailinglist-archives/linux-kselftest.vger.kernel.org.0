Return-Path: <linux-kselftest+bounces-169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1847C7EC9E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 18:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484811C20832
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 17:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BA82FC36;
	Wed, 15 Nov 2023 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4cOO5bt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF5418E
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 09:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700070736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P9P/4kWIh/+LckNZQkng2McbTBVZQ+x8Uch1J3tGPx4=;
	b=U4cOO5btHjZDg6ddTX5YNGB8To2Tswsd5C7vtbUCDY/+WtF4z7PSJlJdwnxuMlmsMZTstr
	6J9d+YP4U3Iy6kXD7eZSs0xvCibRHgibnM5jD1c0Mm93slB2XI1c+qVxiFyVYlsbJ2fUOd
	fhZOUrJ5i4yS0fOywuFQ3z/dgq1TBRM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-3HKLi1t6NoyOaew_TGi1aw-1; Wed, 15 Nov 2023 12:52:13 -0500
X-MC-Unique: 3HKLi1t6NoyOaew_TGi1aw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 142BC811E7E;
	Wed, 15 Nov 2023 17:52:12 +0000 (UTC)
Received: from ruby.redhat.com (unknown [10.39.192.56])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5EC7B1121306;
	Wed, 15 Nov 2023 17:52:09 +0000 (UTC)
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
To: workflows@vger.kernel.org,
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
Subject: [RFC PATCH 0/3] MAINTAINERS: Introduce V: field for required tests
Date: Wed, 15 Nov 2023 19:43:48 +0200
Message-ID: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

The idea of this RFC is to introduce a way to catalogue and document any tests
that should be executed for changes to a subsystem, as well as to make
checkpatch.pl require a tag in commit messages certifying they were, plus
hopefully make it easier to discover and run them.

This is following a discussion Veronika Kabatova started with a few
(addressed) people at the LPC last year (IIRC), where there was a good deal of
interest for something like this.

Apart from implementing basic support (surely to be improved), two sample
changes are added on top, adding a few test suites (roughly) based on what the
maintainers described earlier. I'm definitely not qualified for describing
them adequately, and don't have the time to dig deeper, but hopefully they
could serve as illustrations, and shouldn't be merged as is.

I would defer to maintainers of the corresponding subsystems and tests to
describe their tests and requirements better. Although I would accept
amendments too, if they prefer it that way.

One bug I know that's definitely there is handling removed files. The
scripts/get_maintainer.pl chokes on non-existing files, failing to output the
required test suites (I'm sure there's a good reason, but I couldn't see it).
My first idea is to only check for required tests upon encountering the '+++
<file>' line, and ignore the '/dev/null' file, but I hope the checkpatch.pl
maintainers could recommend a better way.

Anyway, tell me what you think, and I'll work on polishing this.

Thank you!
Nick
---
Nikolai Kondrashov (3):
      MAINTAINERS: Introduce V: field for required tests
      MAINTAINERS: Require kvm-xfstests smoke for ext4
      MAINTAINERS: Require kunit core tests for framework changes

 Documentation/process/submitting-patches.rst |  19 +++++
 Documentation/process/tests.rst              |  80 ++++++++++++++++++
 MAINTAINERS                                  |   8 ++
 scripts/checkpatch.pl                        | 118 ++++++++++++++++++++++++++-
 scripts/get_maintainer.pl                    |  17 +++-
 scripts/parse-maintainers.pl                 |   3 +-
 6 files changed, 241 insertions(+), 4 deletions(-)
---



