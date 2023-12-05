Return-Path: <linux-kselftest+bounces-1193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9330805DEB
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 19:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9981F20FB8
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 18:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A545F1E6;
	Tue,  5 Dec 2023 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MECBrpVu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BEC1BD
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Dec 2023 10:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701801948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQBrrsVFSJUf5yblNEzw3jtgF+8KfPMfViCDC3QAM68=;
	b=MECBrpVuv3StiumtIvB7ATXtXiJ1MgWTIb3khaisDDxbdfc2BVaeM/IhX6hkCKV9rUvWfU
	c9PIf1fEst/ZkzOgsGXZYsnBgMGzhfclfrd3QPxMZqELCKrlJzjdsrTalZmhVSSy5f5vG7
	NrAC6Cn8WSv/FcqmC3A+9egiT86ZPpE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-p7DFPLn-PrqHkCgP5_2T_w-1; Tue, 05 Dec 2023 13:45:45 -0500
X-MC-Unique: p7DFPLn-PrqHkCgP5_2T_w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8712788B790;
	Tue,  5 Dec 2023 18:45:44 +0000 (UTC)
Received: from ruby.redhat.com (unknown [10.39.192.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EEEFD492BE6;
	Tue,  5 Dec 2023 18:45:41 +0000 (UTC)
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
	kernelci@lists.linux.dev,
	Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
Subject: [RFC PATCH v2 04/10] docs: submitting-patches: Introduce Tested-with:
Date: Tue,  5 Dec 2023 20:03:00 +0200
Message-ID: <20231205184503.79769-5-Nikolai.Kondrashov@redhat.com>
In-Reply-To: <20231205184503.79769-1-Nikolai.Kondrashov@redhat.com>
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231205184503.79769-1-Nikolai.Kondrashov@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Introduce a new tag, 'Tested-with:', documented in the
Documentation/process/submitting-patches.rst file.

The tag is expected to contain the test suite command which was executed
for the commit, and to certify it passed. Additionally, it can contain a
URL pointing to the execution results, after a '#' character.

Prohibit the V: field from containing the '#' character correspondingly.

Signed-off-by: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
---
 Documentation/process/submitting-patches.rst | 10 ++++++++++
 MAINTAINERS                                  |  2 +-
 scripts/checkpatch.pl                        |  4 ++--
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index f034feaf1369e..2004df2ac1b39 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -245,6 +245,16 @@ Execute the commands, if any, to test your changes.
 All commands must be executed from the root of the source tree. Each command
 outputs usage information, if an -h/--help option is specified.
 
+If a test suite you've executed completed successfully, add a ``Tested-with:
+<command>`` to the message of the commit you tested. E.g.::
+
+  Tested-with: tools/testing/kunit/run_checks.py
+
+Optionally, add a '#' character followed by a publicly-accessible URL
+containing the test results, if you make them available. E.g.::
+
+  Tested-with: tools/testing/kunit/run_checks.py # https://kernelci.org/test/2239874
+
 
 Select the recipients for your patch
 ------------------------------------
diff --git a/MAINTAINERS b/MAINTAINERS
index 68821eecf61cf..28fbb0eb335ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -63,7 +63,7 @@ Descriptions of section entries and preferred order
 	   executed to verify changes to the maintained subsystem.
 	   Must be executed from the root of the source tree.
 	   Must support the -h/--help option.
-	   Cannot contain '@' character.
+	   Cannot contain '@' or '#' characters.
 	   V: tools/testing/kunit/run_checks.py
 	   One test suite per line.
 
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a184e576c980b..bea602c30df5d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3686,9 +3686,9 @@ sub process {
 # check MAINTAINERS V: entries are valid
 			if ($rawline =~ /^\+V:\s*(.*)/) {
 				my $name = $1;
-				if ($name =~ /@/) {
+				if ($name =~ /[@#]/) {
 					ERROR("TEST_PROPOSAL_INVALID",
-					      "Test proposal cannot contain '\@' character\n" . $herecurr);
+					      "Test proposal cannot contain '\@' or '#' characters\n" . $herecurr);
 				}
 			}
 		}
-- 
2.42.0


