Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51326676994
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 22:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjAUV1a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 Jan 2023 16:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjAUV13 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 Jan 2023 16:27:29 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFCE22A2D;
        Sat, 21 Jan 2023 13:27:25 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id d30so12865545lfv.8;
        Sat, 21 Jan 2023 13:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GRBpu/QXCPP1smq+cAeJAyWgMRFxOYpFTobQbXYAxuE=;
        b=oS7S1BXeJsr/2x90RQ8q0ZycUPH/r/RRdx/S6eQNRun7z22Fv/car7B5PQFwoHlejJ
         nNfRnyEN6G0+E/CIdhCz/rtgp8/QEv6293kNjfv6MV4KAajrck8TwnPRV8DDRaLM/WXy
         CcbYj9wZCezXswGIi64U0pjtUscDqM4GL+wAsYLAM0CuvBxOj6bGGHCJxtXymGkV5Zxm
         q7eCP9/qqfcKTd9rZTrmKaAkcoQu9JaKeAoNcd+46GOCAV/0TajHRGFJEsNRbuRwD3la
         XiTuTN+dNePDs/SrfkbPgRZEBOxWdWNGzPUQ5avU+ooIIqs95uAX6RspFIgDoAWeneRY
         wUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRBpu/QXCPP1smq+cAeJAyWgMRFxOYpFTobQbXYAxuE=;
        b=csey/ct3OIyovIvILcScq7JGD1SD+vdPG0KHiLJoPpPoG9YxdVUCdySz10tsBrzbXD
         r5GCaa1w0gRpJwnk60dj8t4g2KpnWGOvLaefXSbH6T4LF3wIL40rllFvnEyjQk7V18QJ
         RrHgeEfLLoZDvTytCDeZdaFpL8Y2XiZrQcG2ugUQmZaGijiW6ZXPy/kEPNWpx3vd+C8o
         36x584R2Ulf9zDk3aohCjdM9+QVFFdr6w2qZQgJueiVVDaA4cazp11L0WMMtHc8jo7ya
         ejRGkDi7ErWGYkXOcK6LomXBPTjyUlP5XGrnIlxkG9nrXZbaSe5KmZCFqLVHFhn1C5IP
         zwMg==
X-Gm-Message-State: AFqh2kqs/WxSRkVtIO85DAQ7FW73ZWJZXBwQ74vSAINUOfp/7Bf8zx8I
        FKOfOxHEDLmQ75A/mdSPsj4G2A036k/FVQ==
X-Google-Smtp-Source: AMrXdXsWvsMpsWOIwOIqIGOa6PWeRM7p3Dfu71VNEtWeUx8kqjdKB8KFAMkjrthA0TTfRtrv6rhpvg==
X-Received: by 2002:ac2:4c97:0:b0:4b6:fdc3:a668 with SMTP id d23-20020ac24c97000000b004b6fdc3a668mr4475578lfl.31.1674336443892;
        Sat, 21 Jan 2023 13:27:23 -0800 (PST)
Received: from localhost.localdomain ([46.147.136.0])
        by smtp.gmail.com with ESMTPSA id s10-20020a2e98ca000000b0028837c7a7b7sm3721789ljj.128.2023.01.21.13.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 13:27:23 -0800 (PST)
From:   Alexander Pantyukhin <apantykhin@gmail.com>
To:     davidgow@google.com
Cc:     dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Alexander Pantyukhin <apantykhin@gmail.com>
Subject: [PATCH] tools/testing/kunit/kunit.py extract handlers
Date:   Sun, 22 Jan 2023 02:27:17 +0500
Message-Id: <20230121212717.10187-1-apantykhin@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The main function contains a wide if-elif block that handles different
subcommands. It's possible to make code refactoring to extract
subcommands handlers. 

Signed-off-by: Alexander Pantyukhin <apantykhin@gmail.com>
---
 tools/testing/kunit/kunit.py | 167 ++++++++++++++++++++---------------
 1 file changed, 96 insertions(+), 71 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 43fbe96318fe..8cd818867504 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -395,6 +395,95 @@ def tree_from_args(cli_args: argparse.Namespace) -> kunit_kernel.LinuxSourceTree
 			extra_qemu_args=qemu_args)
 
 
+def run_handler(cli_args):
+	if not os.path.exists(cli_args.build_dir):
+		os.mkdir(cli_args.build_dir)
+
+	linux = tree_from_args(cli_args)
+	request = KunitRequest(build_dir=cli_args.build_dir,
+					make_options=cli_args.make_options,
+					jobs=cli_args.jobs,
+					raw_output=cli_args.raw_output,
+					json=cli_args.json,
+					timeout=cli_args.timeout,
+					filter_glob=cli_args.filter_glob,
+					kernel_args=cli_args.kernel_args,
+					run_isolated=cli_args.run_isolated)
+	result = run_tests(linux, request)
+	if result.status != KunitStatus.SUCCESS:
+		sys.exit(1)
+
+
+def config_handler(cli_args):
+	if cli_args.build_dir and (
+			not os.path.exists(cli_args.build_dir)):
+		os.mkdir(cli_args.build_dir)
+
+	linux = tree_from_args(cli_args)
+	request = KunitConfigRequest(build_dir=cli_args.build_dir,
+						make_options=cli_args.make_options)
+	result = config_tests(linux, request)
+	stdout.print_with_timestamp((
+		'Elapsed time: %.3fs\n') % (
+			result.elapsed_time))
+	if result.status != KunitStatus.SUCCESS:
+		sys.exit(1)
+
+
+def build_handler(cli_args):
+	linux = tree_from_args(cli_args)
+	request = KunitBuildRequest(build_dir=cli_args.build_dir,
+					make_options=cli_args.make_options,
+					jobs=cli_args.jobs)
+	result = config_and_build_tests(linux, request)
+	stdout.print_with_timestamp((
+		'Elapsed time: %.3fs\n') % (
+			result.elapsed_time))
+	if result.status != KunitStatus.SUCCESS:
+		sys.exit(1)
+
+
+def exec_handler(cli_args):
+	linux = tree_from_args(cli_args)
+	exec_request = KunitExecRequest(raw_output=cli_args.raw_output,
+					build_dir=cli_args.build_dir,
+					json=cli_args.json,
+					timeout=cli_args.timeout,
+					filter_glob=cli_args.filter_glob,
+					kernel_args=cli_args.kernel_args,
+					run_isolated=cli_args.run_isolated)
+	result = exec_tests(linux, exec_request)
+	stdout.print_with_timestamp((
+		'Elapsed time: %.3fs\n') % (result.elapsed_time))
+	if result.status != KunitStatus.SUCCESS:
+		sys.exit(1)
+
+
+def parse_handler(cli_args):
+	if cli_args.file is None:
+		sys.stdin.reconfigure(errors='backslashreplace')  # pytype: disable=attribute-error
+		kunit_output = sys.stdin
+	else:
+		with open(cli_args.file, 'r', errors='backslashreplace') as f:
+			kunit_output = f.read().splitlines()
+	# We know nothing about how the result was created!
+	metadata = kunit_json.Metadata()
+	request = KunitParseRequest(raw_output=cli_args.raw_output,
+					json=cli_args.json)
+	result, _ = parse_tests(request, metadata, kunit_output)
+	if result.status != KunitStatus.SUCCESS:
+		sys.exit(1)
+
+
+subcommand_handlers_map = {
+	'run': run_handler,
+	'config': config_handler,
+	'build': build_handler,
+	'exec': exec_handler,
+	'parse': parse_handler
+}
+
+
 def main(argv):
 	parser = argparse.ArgumentParser(
 			description='Helps writing and running KUnit tests.')
@@ -438,78 +527,14 @@ def main(argv):
 	if get_kernel_root_path():
 		os.chdir(get_kernel_root_path())
 
-	if cli_args.subcommand == 'run':
-		if not os.path.exists(cli_args.build_dir):
-			os.mkdir(cli_args.build_dir)
-
-		linux = tree_from_args(cli_args)
-		request = KunitRequest(build_dir=cli_args.build_dir,
-				       make_options=cli_args.make_options,
-				       jobs=cli_args.jobs,
-				       raw_output=cli_args.raw_output,
-				       json=cli_args.json,
-				       timeout=cli_args.timeout,
-				       filter_glob=cli_args.filter_glob,
-				       kernel_args=cli_args.kernel_args,
-				       run_isolated=cli_args.run_isolated)
-		result = run_tests(linux, request)
-		if result.status != KunitStatus.SUCCESS:
-			sys.exit(1)
-	elif cli_args.subcommand == 'config':
-		if cli_args.build_dir and (
-				not os.path.exists(cli_args.build_dir)):
-			os.mkdir(cli_args.build_dir)
-
-		linux = tree_from_args(cli_args)
-		request = KunitConfigRequest(build_dir=cli_args.build_dir,
-					     make_options=cli_args.make_options)
-		result = config_tests(linux, request)
-		stdout.print_with_timestamp((
-			'Elapsed time: %.3fs\n') % (
-				result.elapsed_time))
-		if result.status != KunitStatus.SUCCESS:
-			sys.exit(1)
-	elif cli_args.subcommand == 'build':
-		linux = tree_from_args(cli_args)
-		request = KunitBuildRequest(build_dir=cli_args.build_dir,
-					    make_options=cli_args.make_options,
-					    jobs=cli_args.jobs)
-		result = config_and_build_tests(linux, request)
-		stdout.print_with_timestamp((
-			'Elapsed time: %.3fs\n') % (
-				result.elapsed_time))
-		if result.status != KunitStatus.SUCCESS:
-			sys.exit(1)
-	elif cli_args.subcommand == 'exec':
-		linux = tree_from_args(cli_args)
-		exec_request = KunitExecRequest(raw_output=cli_args.raw_output,
-						build_dir=cli_args.build_dir,
-						json=cli_args.json,
-						timeout=cli_args.timeout,
-						filter_glob=cli_args.filter_glob,
-						kernel_args=cli_args.kernel_args,
-						run_isolated=cli_args.run_isolated)
-		result = exec_tests(linux, exec_request)
-		stdout.print_with_timestamp((
-			'Elapsed time: %.3fs\n') % (result.elapsed_time))
-		if result.status != KunitStatus.SUCCESS:
-			sys.exit(1)
-	elif cli_args.subcommand == 'parse':
-		if cli_args.file is None:
-			sys.stdin.reconfigure(errors='backslashreplace')  # pytype: disable=attribute-error
-			kunit_output = sys.stdin
-		else:
-			with open(cli_args.file, 'r', errors='backslashreplace') as f:
-				kunit_output = f.read().splitlines()
-		# We know nothing about how the result was created!
-		metadata = kunit_json.Metadata()
-		request = KunitParseRequest(raw_output=cli_args.raw_output,
-					    json=cli_args.json)
-		result, _ = parse_tests(request, metadata, kunit_output)
-		if result.status != KunitStatus.SUCCESS:
-			sys.exit(1)
-	else:
+	subcomand_handler = subcommand_handlers_map.get(cli_args.subcommand, None)
+
+	if subcomand_handler is None:
 		parser.print_help()
+		return
+
+	subcomand_handler(cli_args)
+
 
 if __name__ == '__main__':
 	main(sys.argv[1:])
-- 
2.25.1

