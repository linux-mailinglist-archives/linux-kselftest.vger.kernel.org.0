Return-Path: <linux-kselftest+bounces-6402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F40F87F21B
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 22:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55324281C33
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 21:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9908958230;
	Mon, 18 Mar 2024 21:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FwuKAMEZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E350759B42
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Mar 2024 21:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797268; cv=none; b=TjgDncGwVXVxqP9MkrRmvG69/gdrakdwGT1KI0I2qzH6LyCymz06o5NKR3YbuOKxlj14xmstIU3Wuw9rdWk5MAkGaSYk1ceRszxZb5IzcUokLOKJxyO56r/8upzPT+toU3Af21l2AzdpD1yviHYnSQsVc2Lxq1MuR7rEPay/bow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797268; c=relaxed/simple;
	bh=vmXf9hen+ww7UwnjCyTyA1t3Yt4iiFW6uRFTYiKQPwA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AgSCDKZOjI7e122VKm9kkP94EChZsi3RvljJb5ripgzFcg0xdHUliwOwP3sEwad8VBEqcpK7j3SKQjM8ZyA/LVET9Fu3adiirX/LwL3iSLlCCDveNdOW2LGimuyzNELH0M4NFgQ40xCekp4HFr7BAcgXtCAJCaBmBef7Je+PVf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FwuKAMEZ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b2682870so7343644276.0
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Mar 2024 14:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710797266; x=1711402066; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qYYHZ4rmvHoUFOfsHiMEKzZLvI6O49Agsr51YnPkVVs=;
        b=FwuKAMEZwBYAxIzDEHwzNrcyVv786mfW6QCIq527jIWvE/z11ihc5D/0OC92gTCTb9
         xhs9ViU0OywPdFUqWwLdM6z4YdHC13wErVs9dJYzE2hOV96fpPJRPYtjI84A+EYgLBfz
         0rXKMkSRO3ix1RI/kLmcMLdQKLGoywpszInQrhJ6JzMpjpdtf3AB0BTmyE1Kfhy4iqiA
         0r9YD5dDSMD+o7O6IIcUnL9RJSYyQTdWd0Ywk4RPAyX1Fldn3ZEw245UqrXIY6+9YHtN
         fWMDmAg26zDvBN0/dMV+6VVPH4xCl7HkhQGofk4S0VbcuHC6lduBCpgdyUhHx0d/2W8E
         cFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710797266; x=1711402066;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qYYHZ4rmvHoUFOfsHiMEKzZLvI6O49Agsr51YnPkVVs=;
        b=mGe+MRDIhKJs4XjTQ0QdwXCb9o0e9qOty0Xu49HJPOfaAd1SRDzoubHr+hJACxJTiS
         c++fp5K4gG0CHS9tsYGCAGFfNq43zj1/ghHExSGQTvrf7FSTOxq02cqa1vc9I7U/jHtl
         vS3LCv+BP456o0ke3QWZlNZFm7ZZ0BQBJUit7vn4iHS223HVlKOnd/+t5/whVywF/A6a
         8GfwhtGMYCu/ODmgEckfdb96m40JaeTrhuI0ZOWMulWFH93wBgA/uFkG0NdLD4/0tKSQ
         FHE1p5JcJ03+uCkcrh7+tw4PlkXNOVrkpMZWTNlQsn43xGWlPjUoa2SpTjK2rZMWSTLx
         Bp+g==
X-Gm-Message-State: AOJu0YxpfkrggDAYceR1Pf/dHuECdIcWC7fC5CDmCNrm+I4dq/UOgoHM
	vjwcT03t85Uxxq4b7Ur2Rmg3GGpc1kH3YO1N73XBS+jysDtdxSe6aCV+ljeiHqCEMrDx16pjPQ=
	=
X-Google-Smtp-Source: AGHT+IGKAqFu3qBLUi9P18lamHu1iDSypU8dNxgfUULB9Qh8q8BdEz4QgtAmkzrUXqulzme+fpo8AePL1A==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:6902:2609:b0:dd9:3a6b:11f8 with SMTP id
 dw9-20020a056902260900b00dd93a6b11f8mr75071ybb.5.1710797266005; Mon, 18 Mar
 2024 14:27:46 -0700 (PDT)
Date: Mon, 18 Mar 2024 21:27:34 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240318212734.3508838-1-rmoar@google.com>
Subject: [PATCH v4] kunit: tool: add ability to parse multiple files
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
Changes since v3:
- Changing from input() to stdin
- Add checking for non-regular files
- Spacing fix
- Small printing fix

 tools/testing/kunit/kunit.py | 54 +++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index bc74088c458a..641b8ca83e3e 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -511,19 +511,40 @@ def exec_handler(cli_args: argparse.Namespace) -> None:
 
 
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
+		parsed_files.append('/dev/stdin')
+	elif len(parsed_files) == 1 and parsed_files[0] == "debugfs":
+		parsed_files.pop()
+		for (root, _, files) in os.walk("/sys/kernel/debug/kunit"):
+			parsed_files.extend(os.path.join(root, f) for f in files if f == "results")
+		if not parsed_files:
+			print("No files found.")
+
+	for file in parsed_files:
+		if os.path.isdir(file):
+			print(f'Ignoring directory "{file}"')
+		elif os.path.exists(file):
+			print(file)
+			with open(file, 'r', errors='backslashreplace') as f:
+				kunit_output = f.read().splitlines()
+			# We know nothing about how the result was created!
+			metadata = kunit_json.Metadata()
+			request = KunitParseRequest(raw_output=cli_args.raw_output,
+							json=cli_args.json)
+			_, test = parse_tests(request, metadata, kunit_output)
+			total_test.subtests.append(test)
+		else:
+			print(f'Could not find "{file}"')
+
+	if len(parsed_files) > 1: # if more than one file was parsed output total summary
+		print('All files parsed.')
+		if not request.raw_output:
+			stdout.print_with_timestamp(kunit_parser.DIVIDER)
+			kunit_parser.bubble_up_test_results(total_test)
+			kunit_parser.print_summary_line(total_test)
 
 
 subcommand_handlers_map = {
@@ -569,9 +590,10 @@ def main(argv: Sequence[str]) -> None:
 					    help='Parses KUnit results from a file, '
 					    'and parses formatted results.')
 	add_parse_opts(parse_parser)
-	parse_parser.add_argument('file',
-				  help='Specifies the file to read results from.',
-				  type=str, nargs='?', metavar='input_file')
+	parse_parser.add_argument('files',
+				  help='List of file paths to read results from or keyword'
+				  '"debugfs" to read all results from the debugfs directory.',
+				  type=str, nargs='*', metavar='input_files')
 
 	cli_args = parser.parse_args(massage_argv(argv))
 

base-commit: 806cb2270237ce2ec672a407d66cee17a07d3aa2
-- 
2.44.0.291.gc1ea87d7ee-goog


