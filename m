Return-Path: <linux-kselftest+bounces-6073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EA8875A4B
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 23:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B58DB217D2
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 22:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CECB13F00A;
	Thu,  7 Mar 2024 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GzJbUmmp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DDB13BAEE
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Mar 2024 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709850590; cv=none; b=Zv9HMqjm1f5XTEAcSS9JFan60bsTSvUuHOHRt+zxLkVav/o2S8XZOOnJITK+PcIySN4+9Fkais4lpggfYColP67fG0+OkLtZ993rJtuUerRgf+Ksv37jfuHRmLmuZG85AbnCDf/pOyDWx7ReKxNhUSzDMsCgAOi6ZjpHKjjNERA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709850590; c=relaxed/simple;
	bh=gEmG11jU0L7/ddzfdMaATL9VRx/BYQhg0RXSHynkAZA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qeMz2ZGUFOvsuxjzpAzXpLy+kDpg5sBM+mUZz/3+qpYsxan69B8hqQ8vT9iIB7JRjb5Z2zvV8alXeVqtzwvogfqJPl1PoPXDXnwQznVpcoQRjR/xT38jn62uj76fG3EixN7RceOxAFlXRzoBfaEDgtTQD9Fy9dDOz4JJ4GqPyOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GzJbUmmp; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609ea26233dso26890537b3.0
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Mar 2024 14:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709850588; x=1710455388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5jvYerSg2y6b3uNWs7YolhL0thmeXUJ/864qWYJlblM=;
        b=GzJbUmmpZ1nIgSdl2QZ66vG5iTLfZQkAaIc7xcX7S6XgTzI5iTg3h5jCzdUOrpQSPM
         3GKutkKTTAkKxFwCvoxiYf77eC5lc7Q3iDQ5VZg2s7ivUHAfjPZWvriLGYm5A0bTcnMU
         FBChdwd8XW1qGRIorLsQqmJWVLfMm9QbkApNEQbi6NbIZTERu703yK8jiOlbCq9jKnSD
         ppr88hbpzrqQCTbOrD7CN9q5CqlEmVJ0j0asE42mBA/64x4vyWbNf4ge6k5j6hIIBVED
         khG1frTeIzvLvvcpJNcpb7gph2lijIV43YpiLvdQ894ya16iTQ3u6O1L+634u52B+4Am
         n1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709850588; x=1710455388;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jvYerSg2y6b3uNWs7YolhL0thmeXUJ/864qWYJlblM=;
        b=gsq7MGI7fHcNArpOWImNokaUDY1bD/ZBmIL8RC39zcj2FGkcoXyb0VH1b97IMWnoaU
         OOEV9UDHActl7/vn47z4hQlPopDgJ4pszeOgpQiNBy7p60K+OfwV52F6q+aLbmjdJrV8
         l1S5YDgZ/sH2FcpUB+nZhQOUMAGf1JqwQPPA5fZluH9IZsiNxP4WbF4/GxRQGK8ks4gb
         qmcX7onnrZwc5AsyN4dyMsCkSBfcaGeFS0HoV1HlShrq8+FJHkkq/8VTZPMxbOZ5asQT
         /G7lEw424pSa89WjiDlfUJYyc+O9Q/+e+a+9IGMnCroHOouj5h27MfDMS8zrYe2F8LJD
         wDKg==
X-Gm-Message-State: AOJu0YwqJewPTfZIs04e4SdYAQ+XxnWeN0PKhn28fd7kE856JuSSLqsw
	NL2wQYwC63wVXi3MgKd4zK6Dvp0Ig0qwvYBixXLGzxzbbJMpjDZD+NlVHpeKpjA42vKs4quXDA=
	=
X-Google-Smtp-Source: AGHT+IH1qNdUaKNafX1y9FCIwmCUwilKYGx+wx7m7D9QJnYBcO7J77K+9mttzPOp9XDZyxxx+RBvHnOx7A==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:690c:3385:b0:609:25d1:ea9a with SMTP id
 fl5-20020a05690c338500b0060925d1ea9amr5829472ywb.9.1709850587771; Thu, 07 Mar
 2024 14:29:47 -0800 (PST)
Date: Thu,  7 Mar 2024 22:29:32 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307222932.584164-1-rmoar@google.com>
Subject: [PATCH v3] kunit: tool: add ability to parse multiple files
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com, dlatypov@google.com, 
	brendan.higgins@linux.dev, kevko@google.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Add ability to parse multiple files. Additionally add the
ability to parse all results in the KUnit debugfs repository.

How to parse multiple files:

./tools/testing/kunit/kunit.py parse results.log results2.log

How to parse all files in directory:

./tools/testing/kunit/kunit.py parse directory_path/*

How to parse KUnit debugfs repository:

./tools/testing/kunit/kunit.py parse debugfs

For each file, the parser outputs the file name, results, and test
summary. At the end of all parsing, the parser outputs a total summary
line.

This feature can be easily tested on the tools/testing/kunit/test_data/
directory.

Signed-off-by: Rae Moar <rmoar@google.com>
---
Changes since v2:
- Fixed bug with input from command line. I changed this to use
  input(). Daniel, let me know if this works for you.
- Add more specific warning messages

 tools/testing/kunit/kunit.py | 56 +++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index bc74088c458a..1aa3d736d80c 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -511,19 +511,42 @@ def exec_handler(cli_args: argparse.Namespace) -> None:
 
 
 def parse_handler(cli_args: argparse.Namespace) -> None:
-	if cli_args.file is None:
-		sys.stdin.reconfigure(errors='backslashreplace')  # type: ignore
-		kunit_output = sys.stdin  # type: Iterable[str]
-	else:
-		with open(cli_args.file, 'r', errors='backslashreplace') as f:
-			kunit_output = f.read().splitlines()
-	# We know nothing about how the result was created!
-	metadata = kunit_json.Metadata()
-	request = KunitParseRequest(raw_output=cli_args.raw_output,
-					json=cli_args.json)
-	result, _ = parse_tests(request, metadata, kunit_output)
-	if result.status != KunitStatus.SUCCESS:
-		sys.exit(1)
+	parsed_files = cli_args.files # type: List[str]
+	total_test = kunit_parser.Test()
+	total_test.status = kunit_parser.TestStatus.SUCCESS
+	if not parsed_files:
+		parsed_files.append(input("File path: "))
+
+	if parsed_files[0] == "debugfs" and len(parsed_files) == 1:
+		parsed_files.pop()
+		for (root, _, files) in os.walk("/sys/kernel/debug/kunit"):
+			parsed_files.extend(os.path.join(root, f) for f in files if f == "results")
+
+	if not parsed_files:
+		print("No files found.")
+
+	for file in parsed_files:
+		if os.path.isfile(file):
+			print(file)
+			with open(file, 'r', errors='backslashreplace') as f:
+				kunit_output = f.read().splitlines()
+			# We know nothing about how the result was created!
+			metadata = kunit_json.Metadata()
+			request = KunitParseRequest(raw_output=cli_args.raw_output,
+							json=cli_args.json)
+			_, test = parse_tests(request, metadata, kunit_output)
+			total_test.subtests.append(test)
+		elif os.path.isdir(file):
+			print("Ignoring directory ", file)
+		else:
+			print("Could not find ", file)
+
+	if len(parsed_files) > 1: # if more than one file was parsed output total summary
+		print('All files parsed.')
+		if not request.raw_output:
+			stdout.print_with_timestamp(kunit_parser.DIVIDER)
+			kunit_parser.bubble_up_test_results(total_test)
+			kunit_parser.print_summary_line(total_test)
 
 
 subcommand_handlers_map = {
@@ -569,9 +592,10 @@ def main(argv: Sequence[str]) -> None:
 					    help='Parses KUnit results from a file, '
 					    'and parses formatted results.')
 	add_parse_opts(parse_parser)
-	parse_parser.add_argument('file',
-				  help='Specifies the file to read results from.',
-				  type=str, nargs='?', metavar='input_file')
+	parse_parser.add_argument('files',
+				  help='List of file paths to read results from or keyword'
+				  		'"debugfs" to read all results from the debugfs directory.',
+				  type=str, nargs='*', metavar='input_files')
 
 	cli_args = parser.parse_args(massage_argv(argv))
 

base-commit: 806cb2270237ce2ec672a407d66cee17a07d3aa2
-- 
2.44.0.278.ge034bb2e1d-goog


