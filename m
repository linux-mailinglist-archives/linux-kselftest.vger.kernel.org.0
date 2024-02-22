Return-Path: <linux-kselftest+bounces-5319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2FC86058F
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 23:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FBFB289CD8
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 22:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C43612D21A;
	Thu, 22 Feb 2024 22:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rJsWt/14"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB39B14B81E
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Feb 2024 22:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708640306; cv=none; b=O6eeXOX5FQ0N8gb9cOkGM6f8I5QI3MB6bGLueyvT36/ysOIUsYJ7G3SzuFgvZaLt1pXKyQy3tNx7ISp2B2GSmajGOY//j+hDzQgzSppSd8b3OqC2TqaLLnwqincEdZU1pgNRPaABxeblc7edHFWL4yfpUE7+aKBTO0FcwUf2wXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708640306; c=relaxed/simple;
	bh=GySJPqsa46qjefpa40BPSAtIQnwOgTHwplk+ekXDzDE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Gxk5+LIhK4yDMmv11jDU0oskLlcHC1OUZWAKUB6qNlGtuBwXVFS2rQYd3xbopCKpuYvD0cNctHQXSvrNXuPRnxPGpXBGkqDSlt7mVIkSfgpBdqNxqxXGlQQwDsCwsOlYzzAHDSM6pQZgXINaeI6Cuj0Rs7MnQR6SJDTyD7W4BVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rJsWt/14; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608ac8c5781so4495047b3.3
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Feb 2024 14:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708640304; x=1709245104; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jUpDAbHl4PhD0AQm18/km5kyUpNrcIzm2UavY3bA4II=;
        b=rJsWt/14Ooh9gkTpYqJaWE+BHDdlSxNCjv+72F2ypfWwGHeImntlVsbnrmD/lHZ0cl
         e9NhdKM8n1uGZ7Dxj3YYL0eFmoiDwkValG/EgjcboX9Ig+5PCLJYnNyCdnfGga/ZgAQs
         IPoOSKOygR4iEqcyRJn8RXlYMX6UVNV/KcB1TxFsZHNi2wJzxi1TTkTrGI19qKfv0aHM
         lXjfEY6HRyo8DZeQh5RyvyyXjBrfmExJetxAEdvqdN0hBmXCXqmvaR+92IB8m8LMsqFa
         FRc+BKaH0TnWphuHLUo9oYPUePfNt2DyFi7A5UyPQef2byfX9ohR6Zq7QBkgnWEMsGSU
         YcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708640304; x=1709245104;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUpDAbHl4PhD0AQm18/km5kyUpNrcIzm2UavY3bA4II=;
        b=lYsPeuLCE9EkT45dDhG9Rqu1EoGp5bdct5cH0e7oBZAaoZnzjV1Q7r7ohsnzGmmTv3
         KoXwuGU23xMjqenYl0gVLWT3n9l03E6GaLtnQ8BQ3wCWG35fHYnOjiajsMbF5a/S1YVr
         MExjYaP1XauEAb9CVZtAphlb3ZDSM+1KPHWIdLUZ41UI3Nk8TEpWSsX+P5eE11/S0tCQ
         VnYeKe3c+8rPVtPlTKGp2fDmKoqwn9Z7/vxPC1xsbgKgwhVZI2OsVwAiLE53Z3y8lkDl
         s0tet0pUiXr5gL9eC2UTp8Cty4EQLBJuze3l6PzSZfgt3RfYFVYr+9XBk2UTKK6cU0pn
         TeOg==
X-Gm-Message-State: AOJu0YyJdlfK2aUX/xOua6xjHBGXHsYUmB8vIxerCWkcIydeIHFz+HZu
	9XZ5CrP3bU+eteQBF705t68TBrO4+1pYu54ETPZ0IGkD+Nqwokj69s8MOISr6JqaTYZxrJerbQ=
	=
X-Google-Smtp-Source: AGHT+IFExReO3c4IzKQGndU5Mktj19q0+l1b3yNa4AC256uF/PSrXSms4ghCI5J9w09x/QJbDNAG34ZKqQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:690c:fcb:b0:608:406d:6973 with SMTP id
 dg11-20020a05690c0fcb00b00608406d6973mr118080ywb.5.1708640303929; Thu, 22 Feb
 2024 14:18:23 -0800 (PST)
Date: Thu, 22 Feb 2024 22:18:14 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240222221814.3572215-1-rmoar@google.com>
Subject: [PATCH] kunit: tool: add parsing of all files in directory
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com, dlatypov@google.com, 
	brendan.higgins@linux.dev, kevko@google.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Add ability to parse all files within a directory. Additionally add the
ability to parse all results in the KUnit debugfs repository.

How to parse all files in directory:

./tools/testing/kunit/kunit.py parse [directory path]

How to parse KUnit debugfs repository:

./tools/testing/kunit/kunit.py parse debugfs

For each file, the parser outputs the file name, results, and test
summary. At the end of all parsing, the parser outputs a total summary
line.

This feature can be easily tested on the tools/testing/kunit/test_data/
directory.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 tools/testing/kunit/kunit.py | 45 ++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index bc74088c458a..827e6dac40ae 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -511,19 +511,40 @@ def exec_handler(cli_args: argparse.Namespace) -> None:
 
 
 def parse_handler(cli_args: argparse.Namespace) -> None:
-	if cli_args.file is None:
+	parsed_files = []
+	total_test = kunit_parser.Test()
+	total_test.status = kunit_parser.TestStatus.SUCCESS
+	if cli_args.file_path is None:
 		sys.stdin.reconfigure(errors='backslashreplace')  # type: ignore
 		kunit_output = sys.stdin  # type: Iterable[str]
-	else:
-		with open(cli_args.file, 'r', errors='backslashreplace') as f:
+	elif cli_args.file_path == "debugfs":
+		for (root, _, files) in os.walk("/sys/kernel/debug/kunit"):
+			for file in files:
+				if file == "results":
+					parsed_files.append(os.path.join(root, file))
+	elif os.path.isdir(cli_args.file_path):
+		for (root, _, files) in os.walk(cli_args.file_path):
+			for file in files:
+				parsed_files.append(os.path.join(root, file))
+	elif os.path.isfile(cli_args.file_path):
+		parsed_files.append(cli_args.file_path)
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
@@ -569,8 +590,8 @@ def main(argv: Sequence[str]) -> None:
 					    help='Parses KUnit results from a file, '
 					    'and parses formatted results.')
 	add_parse_opts(parse_parser)
-	parse_parser.add_argument('file',
-				  help='Specifies the file to read results from.',
+	parse_parser.add_argument('file_path',
+				  help='Specifies the file path to read results from.',
 				  type=str, nargs='?', metavar='input_file')
 
 	cli_args = parser.parse_args(massage_argv(argv))

base-commit: 08c454e26daab6f843e5883fb96f680f11784fa6
-- 
2.44.0.rc0.258.g7320e95886-goog


