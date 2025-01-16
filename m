Return-Path: <linux-kselftest+bounces-24673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5429AA1429E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 20:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31333A3F58
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 19:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F6822FAF8;
	Thu, 16 Jan 2025 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJcUbHKD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383DD14AD2B;
	Thu, 16 Jan 2025 19:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737057107; cv=none; b=iNHKOirU+mxSYOLpfMzzlYu81EusEd/8uwExE9RD2Bb52MQ88fTXCUsia8/kTfl4NfBzpgBwW3iPV+xd6ZJhWOMb4057hrOl8ZxVPhEXf4Vm67py7N0XH0AG5qZ6OAnzAVZwHcCaQ0wLHAfww6NYXTUdnJ9rhcRQXrgxaC0dH8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737057107; c=relaxed/simple;
	bh=hXSC3NdDi6CPKa51r/65A3hXVe7WBQu+dtP9f3eeOcI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e+x/wZHOqCVo0piw6GlNY5zrJES1/mg7d980DKoEOL2ZtsNgIj+AQ1F2H6pJf78+R0d+Sf8T/wvSLFCN0mn6voj4Wfxm46PAWpOaTZHkkAtie8gn+y8ZVD43CW63l/5t8uzQvEZf7GVNbnvRp+ow+W3RX1+7RoWdevkLuJSAAPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJcUbHKD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2166651f752so30587945ad.3;
        Thu, 16 Jan 2025 11:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737057105; x=1737661905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E6528WfRiWpcuhroEMUieWun3syVAbmuvVQX7u7L0P4=;
        b=KJcUbHKDlO3AHo0HxZjRVd6o24rfWVcWWACJHQKvn003hKELBA9j7dtyk3TyfNdwVf
         P+qcslVl2AdJJDqUgkOGhTw2N7jukSaEuVbR+WDNr4WOMkaFcMmwDpCj5I62dCaLNpBs
         hRWUsL2d+xOO9tCvACXJ/lCUfvvohOmPRu1DASO7sJan6R6IfKrrbD3Gh8kCU7NMcWVb
         PBJfsCAGIv96mzxz4xlNji6l2aEQRrTGlHUWokltZlsPqaEW95uJT27iF1ED3I6X7jdh
         4pYjk/d1p2FL5d3EIMajN5EYtTfeQH4ZSQBSNGYYSRhzR6d0xRMl2LfhQEKCfaxrEU+q
         4+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737057105; x=1737661905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6528WfRiWpcuhroEMUieWun3syVAbmuvVQX7u7L0P4=;
        b=PlTSC7q1ryNiW9gbqN73Nl4XM6m9GPmszahaa+nRMIn6yTtuwfd7ycWzUk5tUD4LXA
         cccFX0SLGX02fmjIjCTakB3qM5M8JgbrjocuXUo6GytsOweq4MKYXBsupikgLV5pKynk
         6MKW9z9DYe1+UpDjzW4ceBDC7Aw5Qwbxk/8+CjB27WGry55iNlCWDo4RVTgrW/ZaE0lr
         8sIuxjU3j1S34I2M7bplO40486OdUSBVkyep4DhUy0+bnQYJZ1ByELbx9/Y7LUMFD6id
         EgNfepbYgxKK3B/4AW40kSMKTV56lf3o1gZhYRsYEODW4ayQBP8yITIm7Z7jOSV/LrZf
         CaUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKu5tkAk81g2u4CJhLaIYZ2kepYM37wSSEYFYtSOgc8DGeWGMVjt54EeTt72K0mXwcMV2PrQ45tMmScOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5BDZlcGmwlImzbEOoHdxpXt+LFbQBSpl1Nk6RwEIs8WPQLRqh
	0Yj8zTfGnzyrzQUDlIcvG2YuUxoIy2tSa4N7BqAKTUq8qWBjfd0yLtt/nHmnX+I=
X-Gm-Gg: ASbGncuZFne6bZiWoqGQLgxHWuKHGfPgKKiMsGB4fnRbqX62za7srzxWFKgKV9h4MBy
	n9PM7uRBp36avP2RL3Q2abNO6lKBOVnuyBg5EJ/60YYAvOem788aE6aqlACV3WWCJxHxPFeUT3t
	hUoEnSMD9WsET5Up84ga5qnISyi2Jh5Lbjd+iD123g/dDhc89UkxSEpJhMl88o8nPqIjFR+PUXQ
	EWyRiGX6wdmQSWBFjAbWU+1D4NMwnRPvFCGuAbhl2JQbEezPy9OLUO+AowruTpE+R7xKOk=
X-Google-Smtp-Source: AGHT+IHsx9LhLzvQhUahdir75DqW5699fw19QV097PfMfEWSd3+0uyd2p+ozuPpbBLwviC4h5zf8tg==
X-Received: by 2002:a17:902:dac6:b0:216:668d:690c with SMTP id d9443c01a7336-21a83f70f04mr621471685ad.28.1737057105004;
        Thu, 16 Jan 2025 11:51:45 -0800 (PST)
Received: from localhost.localdomain ([2405:201:f022:f804:ca0a:f615:5d6e:f4e1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d4017e8sm3671175ad.208.2025.01.16.11.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 11:51:44 -0800 (PST)
From: Siddharth Menon <simeddon@gmail.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	skhan@linuxfoundation.org,
	pmladek@suse.com,
	mbenes@suse.cz,
	linux-kernel@vger.kernel.org,
	Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH v3 1/2] selftests: Introduce script to validate required dependencies
Date: Fri, 17 Jan 2025 01:21:20 +0530
Message-Id: <20250116195120.104420-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a script to validate that the current kernel configuration
satisfies the requirements for selftests by comparing the current
kernel configs against the required selftest configs.

The script also runs kselftest_deps.sh to check for any missing libraries
required by the selftest.

A config mismatch exits with error value 1 while matching configs or missing
config files exit with value 0. In order to silence missing dependency output,
set the environment variable SILENCE=1.

The code for extracting the current kernel configs is adapted from
scripts/kconfig/streamline_config.pl.

Suggested-by: Petr Mladek <pmladek@suse.com>
Suggested-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 v1->v2:
 - check selftest/config directly rather than a separate set in the test
   makefile
 v2->v3:
 - Integrate kselftest_deps.sh to check for missing libraries (I have not
   set it to skip the tests here, as it sometimes throws outputs such as
   missing $(LIB) or $(MNL_LDLIBS))
 - Replaced spaces with tabs, removed trailing spaces and other minor
   formatting changes
 - Introduced flag to silence the missing dependencies debug statements
 - Rename script to a more meaningful name
 
 .../testing/selftests/check_kselftest_deps.pl | 170 ++++++++++++++++++
 1 file changed, 170 insertions(+)
 create mode 100755 tools/testing/selftests/check_kselftest_deps.pl

diff --git a/tools/testing/selftests/check_kselftest_deps.pl b/tools/testing/selftests/check_kselftest_deps.pl
new file mode 100755
index 000000000000..5d2298e3ffea
--- /dev/null
+++ b/tools/testing/selftests/check_kselftest_deps.pl
@@ -0,0 +1,170 @@
+#!/usr/bin/env perl
+# SPDX-License-Identifier: GPL-2.0
+use warnings;
+use strict;
+use Getopt::Long;
+use File::Spec;
+use File::Basename;
+
+# set the environment variable SILENCE to silence
+# debug output.
+
+# Check if required arguments are provided
+die "Usage: $0 <selftest_path> <compiler>\n" unless @ARGV >= 2;
+
+my $test_path = $ARGV[0];
+my $cc = join(' ', @ARGV[1..$#ARGV]);
+my $script_dir = dirname(__FILE__);
+
+my $silenceprint;
+$silenceprint = 1 if (defined($ENV{SILENCE}));
+
+sub dprint {
+	return if ($silenceprint);
+	print STDERR @_;
+}
+
+my $uname = `uname -r`;
+chomp $uname;
+
+my @searchconfigs = (
+	{
+		"file" => ".config",
+		"exec" => "cat",
+	},
+	{
+		"file" => "/proc/config.gz",
+		"exec" => "zcat",
+	},
+	{
+		"file" => "/boot/config-$uname",
+		"exec" => "cat",
+	},
+	{
+		"file" => "/boot/vmlinuz-$uname",
+		"exec" => "scripts/extract-ikconfig",
+		"test" => "scripts/extract-ikconfig",
+	},
+	{
+		"file" => "vmlinux",
+		"exec" => "scripts/extract-ikconfig",
+		"test" => "scripts/extract-ikconfig",
+	},
+	{
+		"file" => "/lib/modules/$uname/kernel/kernel/configs.ko",
+		"exec" => "scripts/extract-ikconfig",
+		"test" => "scripts/extract-ikconfig",
+	},
+	{
+		"file" => "/lib/modules/$uname/build/.config",
+		"exec" => "cat",
+	},
+	{
+		"file" => "kernel/configs.ko",
+		"exec" => "scripts/extract-ikconfig",
+		"test" => "scripts/extract-ikconfig",
+	},
+	{
+		"file" => "kernel/configs.o",
+		"exec" => "scripts/extract-ikconfig",
+		"test" => "scripts/extract-ikconfig",
+	},
+);
+
+sub read_config {
+	foreach my $conf (@searchconfigs) {
+		my $file = $conf->{"file"};
+
+		next unless -f $file;
+
+	if (defined $conf->{"test"}) {
+		`$conf->{"test"} $file 2>/dev/null`;
+		next if $?;
+	}
+
+	my $exec = $conf->{"exec"};
+
+	# dprint "Kernel config: '$file'\n";
+
+	open(my $infile, '-|', "$exec $file") or die "Failed to run $exec $file";
+	my @config_content = <$infile>;
+	close $infile;
+
+	return @config_content;
+	}
+
+	dprint "Unable to find kernel config file, skipping check\n";
+	exit 0;
+}
+
+sub check_libs {
+	my $command = "cd $script_dir && ./kselftest_deps.sh \"$cc\" $test_path";
+	my $lib_test = `$command 2>&1`;
+	my $exit_code = $? >> 8;
+
+	if ($exit_code != 0) { 
+		die "Error: Failed to run kselftest_deps.sh with exit code $exit_code\n";
+	}
+
+	return $lib_test;
+}
+
+# Check for missing libraries
+my $lib_test = check_libs();
+my $fail_libs;
+
+if ($lib_test =~
+/(--------------------------------------------------------\s
+*Missing libraries system.*?
+--------------------------------------------------------)/s) {
+	$fail_libs = $1;
+}
+
+dprint("$fail_libs\n") if $fail_libs;
+
+# Read and parse kernel config
+my @config_file = read_config();
+my %kern_configs;
+foreach my $line (@config_file) {
+	chomp $line;
+	next if $line =~ /^\s*$/ || $line =~ /^#/;
+
+	if ($line =~ /^(CONFIG_\w+)=(.+)$/) {
+	$kern_configs{$1} = $2;
+	}
+}
+
+# Read and parse test config
+my %test_configs;
+open(my $fh, '<', "$test_path/config") or exit 0;
+
+while (my $line = <$fh>) {
+	chomp $line;
+	next if $line =~ /^\s*$/ || $line =~ /^#/;
+
+	if ($line =~ /^(CONFIG_\w+)=(.+)$/) {
+		$test_configs{$1} = $2;
+	}
+}
+close $fh;
+
+# Compare selftest configs with kernel configs
+my $all_match = 1;
+my @missing_or_mismatched;
+
+foreach my $key (keys %test_configs) {
+	if (!exists $kern_configs{$key} || $kern_configs{$key} ne $test_configs{$key}) {
+		push @missing_or_mismatched, "Required: $key=$test_configs{$key}";
+		$all_match = 0;
+	}
+}
+
+if ($all_match && !$fail_libs) {
+	exit 0;
+} else {
+	dprint("--------------------------------------------------------\n") unless $fail_libs;
+	dprint("$_\n") for @missing_or_mismatched;
+	dprint("--------------------------------------------------------\n") if @missing_or_mismatched;
+
+	exit 1;
+}
-- 
2.39.5


