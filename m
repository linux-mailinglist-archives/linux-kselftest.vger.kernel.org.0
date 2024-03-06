Return-Path: <linux-kselftest+bounces-6014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92038742C8
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 23:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B791C219F4
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 22:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C89639;
	Wed,  6 Mar 2024 22:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SAkTirlS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C5C14F98
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Mar 2024 22:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709764261; cv=none; b=IZ7RGnsfTs367C5QUE7VnbTS4GCE6j6heWR8yLy1U/8DluvGaV8RfbG0nc+lrRrUV4lE1TdgfzWDBKyV5zKJcjjJywEAfBDGcYKGqhk5h4CutkGHBtg0slAoZNZomLijL3I+El0Its0zNxxeC1+qYTzFr0hHyLfqcwMon6ZzSrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709764261; c=relaxed/simple;
	bh=lK/a+UW2iqYrSft0qZc8gZiAODZfN0e4TWyPvAGbCBQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OLCzV1YNeCC0eLj2+yo7i3RCdqG3q0B/ZZARTzSOwRFw4s6r6XOYILWM4WnDu2usxlEpXe2TPuK832w/6PCWOX2ztvmxqcjnY+SNuNhsUJ9UoqKzgV1RbjXe6Bq3HqescRu8rGxVFV7C2RRtOf93ZFOZWkxNvY5Wisvn1X/giS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SAkTirlS; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dced704f17cso354476276.1
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Mar 2024 14:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709764259; x=1710369059; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t/bvsMxpmGUk/de5zo1mkM3uxtDnlir1VqeH2uLCc5M=;
        b=SAkTirlStmGR/43PTS1GFDwzZHiRLKdIjORwcxqApfj00S4bu2rHNEhfdQVeIPvguN
         O7EjEmBcRnWEjWIiXZ4rn1KlxlRKPFxesIXnMzdPtQQkX7XgHvuDAbGKDjD52g6JUibv
         Jr2cKuOY2Ay4sVP/W1AIY2NQVVTJf7UAB33/dQgMhNZxx+UIMd6/extJMHykA74p9jIH
         hbvXM+J862NTRXtfTVOIeLeAX7auLp8tzrJ0IoQPn6mC0/LGo3zELZua2cxOraSrvpCb
         /idbIxL0EqM2x27iYnnbzXeT7hzG8lNYbePrJsCOzXcUei2CKdsRwoBAC69qKBTrvjrh
         NREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709764259; x=1710369059;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t/bvsMxpmGUk/de5zo1mkM3uxtDnlir1VqeH2uLCc5M=;
        b=p6k2I7P8OtL7rLhLh/MxgQCunK7bLH1sUmzvmGYiqTZ3C4RJfwTDEQzbpAyzSQaj+A
         96vImtY7MPb7/x0lRpUgquSwXJ6O/nDHQy44yzY6TC8oWRUIVOX3sfFeWced4UNkSkNI
         1MVYflL7X+2LFLrdA4SUQFlDJhOQNvFN3/oTcxGJyL/ds1VV86rFUeSFwvY0SrwVwi3/
         nvzL2mgKCsNJjXnkYXxa38ToYnlJojeHdqz0E9yxVsjeWEnsPNbA1HCCqWoi4mmOxYs2
         v6MtHIw4oQNwA7cTA3fY05XC+hMieI7DrvCGSxWzSPV2vXJSJKzuzQrlffsO9tv/cZxp
         CYpg==
X-Gm-Message-State: AOJu0YyZDmyOja/xlNlHDriq5BokZ2O85qJeQnggla8bEUb9PFRR7jeQ
	jOKPdV785fVMSi9UCJz67eYe+IELY76A9omL+0o4Jrel8TAo/tde0DkBOQ/ejSO6LM5NF6RH0A=
	=
X-Google-Smtp-Source: AGHT+IGyamNCZigG0HsVlujxHmVGogCiuk1hBEFD3c7kz4ZcZj/+UiDou6mQry67mxqdeJSfQcOnenjmgg==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:6902:726:b0:dcd:b593:6503 with SMTP id
 l6-20020a056902072600b00dcdb5936503mr660480ybt.2.1709764258897; Wed, 06 Mar
 2024 14:30:58 -0800 (PST)
Date: Wed,  6 Mar 2024 22:30:55 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306223056.226518-1-rmoar@google.com>
Subject: [PATCH v2] kunit: tool: add ability to parse multiple files
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
Changes since v1:
- Annotate type of parsed_files
- Add ability to input file name from stdin again
- Make for loops a bit terser
- Add no output warning
- Change feature to take in multiple fields rather than a directory.
  Currently nonrecursive. Let me know if people would prefer this as
  recursive.

 tools/testing/kunit/kunit.py | 45 +++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index bc74088c458a..df804a118aa5 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -511,19 +511,37 @@ def exec_handler(cli_args: argparse.Namespace) -> None:
 
 
 def parse_handler(cli_args: argparse.Namespace) -> None:
-	if cli_args.file is None:
+	parsed_files = [] # type: List[str]
+	total_test = kunit_parser.Test()
+	total_test.status = kunit_parser.TestStatus.SUCCESS
+	if cli_args.files is None:
 		sys.stdin.reconfigure(errors='backslashreplace')  # type: ignore
-		kunit_output = sys.stdin  # type: Iterable[str]
+		parsed_files.append(sys.stdin)
+	elif cli_args.files[0] == "debugfs" and len(cli_args.files) == 1:
+		for (root, _, files) in os.walk("/sys/kernel/debug/kunit"):
+			parsed_files.extend(os.path.join(root, f) for f in files if f == "results")
 	else:
-		with open(cli_args.file, 'r', errors='backslashreplace') as f:
+		parsed_files.extend(f for f in cli_args.files if os.path.isfile(f))
+
+	if len(parsed_files) == 0:
+		print("No output found.")
+
+	for file in parsed_files:
+		print(file)
+		with open(file, 'r', errors='backslashreplace') as f:
 			kunit_output = f.read().splitlines()
-	# We know nothing about how the result was created!
-	metadata = kunit_json.Metadata()
-	request = KunitParseRequest(raw_output=cli_args.raw_output,
-					json=cli_args.json)
-	result, _ = parse_tests(request, metadata, kunit_output)
-	if result.status != KunitStatus.SUCCESS:
-		sys.exit(1)
+		# We know nothing about how the result was created!
+		metadata = kunit_json.Metadata()
+		request = KunitParseRequest(raw_output=cli_args.raw_output,
+						json=cli_args.json)
+		_, test = parse_tests(request, metadata, kunit_output)
+		total_test.subtests.append(test)
+
+	if len(parsed_files) > 1: # if more than one file was parsed output total summary
+		print('All files parsed.')
+		stdout.print_with_timestamp(kunit_parser.DIVIDER)
+		kunit_parser.bubble_up_test_results(total_test)
+		kunit_parser.print_summary_line(total_test)
 
 
 subcommand_handlers_map = {
@@ -569,9 +587,10 @@ def main(argv: Sequence[str]) -> None:
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


