Return-Path: <linux-kselftest+bounces-1194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9E7805DEC
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 19:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D8A1F213F3
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 18:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEFE3F8C0;
	Tue,  5 Dec 2023 18:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvGvneXL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A46A1A1
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Dec 2023 10:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701801952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rjhrwHCnUnW3xEcFO0R6168TiBh6hDOTsbDJmlfNr2Q=;
	b=RvGvneXLJpYg32yDdN1NGsUIdF6cZUTEItD9VJeSEb3BQezxrPwiIbBua6RekIbB4KblLR
	cSXHPU0LwIxSFwUZ4BPZvVVfJzpQtzSzAKYfZ1cO41MGawHNkoUQy7pSVZjbHXk2z5lges
	YFAf1PSALg+IH3LfavMyfWCNS/CcfLQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-jnUKdMb5NAmkd4cd6c8jwQ-1; Tue, 05 Dec 2023 13:45:48 -0500
X-MC-Unique: jnUKdMb5NAmkd4cd6c8jwQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BE2485A589;
	Tue,  5 Dec 2023 18:45:47 +0000 (UTC)
Received: from ruby.redhat.com (unknown [10.39.192.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CA33E492BE6;
	Tue,  5 Dec 2023 18:45:44 +0000 (UTC)
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
Subject: [RFC PATCH v2 05/10] checkpatch: Propose tests to execute
Date: Tue,  5 Dec 2023 20:03:01 +0200
Message-ID: <20231205184503.79769-6-Nikolai.Kondrashov@redhat.com>
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

Make scripts/checkpatch.pl output a 'CHECK' advertising any test suites
proposed for the changed subsystems, and prompting their execution.

Using 'CHECK', instead of 'WARNING', or 'ERROR', because test suite
commands executed for testing can generally be off by an option/argument
or two, depending on the situation, while still satisfying the
maintainer requirements, but failing the comparison with the V: entry
and raising alarm unnecessarily.

However, see the later patch adding the proposal strength to the V:
entry and allowing raising the severity of the message for those who'd
like that.

Signed-off-by: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
---
 scripts/checkpatch.pl | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index bea602c30df5d..1da617e1edb5f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1144,6 +1144,29 @@ sub is_maintained_obsolete {
 	return $maintained_status{$filename} =~ /obsolete/i;
 }
 
+# Test suites proposed per changed file
+our %files_proposed_tests = ();
+
+# Return a list of test suites proposed for execution for a particular file
+sub get_file_proposed_tests {
+	my ($filename) = @_;
+	my $file_proposed_tests;
+
+	return () if (!$tree || !(-e "$root/scripts/get_maintainer.pl"));
+
+	if (!exists($files_proposed_tests{$filename})) {
+		my $command = "perl $root/scripts/get_maintainer.pl --test --multiline --nogit --nogit-fallback -f $filename";
+		# Ignore warnings on stderr
+		my $output = `$command 2>/dev/null`;
+		# But regenerate stderr on failure
+		die "Failed retrieving tests proposed for changes to \"$filename\":\n" . `$command 2>&1 >/dev/null` if ($?);
+		$files_proposed_tests{$filename} = [grep { !/@/ } split("\n", $output)]
+	}
+
+	$file_proposed_tests = $files_proposed_tests{$filename};
+	return @$file_proposed_tests;
+}
+
 sub is_SPDX_License_valid {
 	my ($license) = @_;
 
@@ -2689,6 +2712,9 @@ sub process {
 	my @setup_docs = ();
 	my $setup_docs = 0;
 
+	# Test suites which should not be proposed for execution
+	my %dont_propose_tests = ();
+
 	my $camelcase_file_seeded = 0;
 
 	my $checklicenseline = 1;
@@ -2907,6 +2933,17 @@ sub process {
 				}
 			}
 
+			# Check if tests are proposed for changes to the file
+			foreach my $test (get_file_proposed_tests($realfile)) {
+				next if exists $dont_propose_tests{$test};
+				CHK("TEST_PROPOSAL",
+				    "Running the following test suite is proposed for changes to $realfile:\n" .
+				    "$test\n" .
+				    "Add the following to the tested commit's message, IF IT PASSES:\n" .
+				    "Tested-with: $test\n");
+				$dont_propose_tests{$test} = 1;
+			}
+
 			next;
 		}
 
@@ -3233,6 +3270,12 @@ sub process {
 			}
 		}
 
+# Check and accumulate executed test suites (stripping URLs off the end)
+		if (!$in_commit_log && $line =~ /^\s*Tested-with:\s*(.*?)\s*#.*$/i) {
+			# Do not propose this certified-passing test suite
+			$dont_propose_tests{$1} = 1;
+		}
+
 # Check email subject for common tools that don't need to be mentioned
 		if ($in_header_lines &&
 		    $line =~ /^Subject:.*\b(?:checkpatch|sparse|smatch)\b[^:]/i) {
-- 
2.42.0


