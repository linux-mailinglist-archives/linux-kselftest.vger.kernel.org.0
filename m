Return-Path: <linux-kselftest+bounces-27713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07336A47540
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 06:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D0D18868FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 05:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CA31EB5F8;
	Thu, 27 Feb 2025 05:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Crr1zbRG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F0921516A;
	Thu, 27 Feb 2025 05:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740634423; cv=none; b=rRNQ9cWvOondOgsGHVIYfnj75/7/OFCcQl+NJtLSyZX4AHlTHMdCpZzTZB1qOQGbzT4dbXpAAxVkS12u2r+QJ2xv+MkNtURX+ydt72DfRuU8xUFEmxMC0CznRvrQS/cLR5KygQ12GedMPEn5Yqu4kGYkrke4sKSjSXY6zirxyE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740634423; c=relaxed/simple;
	bh=sC4ubW5+4kwXtzdRZ2/gkUGH9C3VuwXIxvenwdxk2Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxDxAcxj3H0IdO9mttNBdZ95O/4jni2y1MGzffnpa2taDueXdaDeU0f7ZNguQ5KYahtpjijx2JP9KkSHffikro460veBhnozb22yM6UiN4LMBpNwxTbTwSLHV43/ejUQdv6YqUG5MJ8MpS3nmjE9ENF60bu86hZ0QrGyIpZ2aks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Crr1zbRG; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fea47bcb51so798474a91.2;
        Wed, 26 Feb 2025 21:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740634420; x=1741239220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6z2b2XULHZzaJQ7AgE9rinHdmnWflM2T2Agc5PlDtQ=;
        b=Crr1zbRG0gkcR5cLy8MTvh2B1QLP7PNU4CqvyRLMotU3hwMKL8zAGrJ3+VBSJLE8/H
         BY96/Q3NrYDXDBoBKqm84A826BvOYBuHto7vxADYjksWSsd1ASt1yUPH7IpRtpyd89bJ
         K9zlnEYFf5yXH7LYdXoc0jZ6ODPaUTpa3iTX6GNU5BjPeAsNRveAeXf5UKEzfQ3djh7B
         25InZhL6nYI8i3Tj6EkVnOjd/J8NmPDFpsb6aPSUAeOJP7adUJErPGHVkW0LbJTUsMCi
         vk9h5lI//qYMlBY0/2eNOx7NbRpNTDpGaCwHD8RrWx9NM+CGQok4kXAJzI8cfwla1B2b
         nZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740634420; x=1741239220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6z2b2XULHZzaJQ7AgE9rinHdmnWflM2T2Agc5PlDtQ=;
        b=uY+cwIPFf/RdetN5GXMrD0J58yeqRNQ2zv8BYLY05Pxv5bb6dvxFsOajf4KAwPdM7a
         rxRsYwefemumklfl5S8JCW9DNiLXGibxrgOygH2jgwO2R6Sz4pgaStKpPxSigAR81spD
         4thMaP7SypCyTZwlNV26HFUAaZv4Fdi7cL3BWI2jMoMC/nzDmQaJKB0QokevJvPVYFKp
         3b6RohVtoduyxzGwlyg/hDtaqyuVPHI8ADBMS0VCZ55hOSFZJw24FZ6fmwjqIm8SHkke
         a2578OissmTHWC+Hz0UGAq+VMa078HXqob5q1BAPafWd0FHfdaGslJmRGVbptyP3cwNH
         EYfw==
X-Forwarded-Encrypted: i=1; AJvYcCV/N0VB9ETuTyhOLDadmH0KmtsFwhXmPtnghKiIO8PnFD2PKDelq8AWsVJhpsbmvxiWPNMGJxZmpVjxw9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz5ZGkFoAbYTJgjAIZVLEVDvEIrFgZgIuOePGU+TIEpwVPyM6g
	43Ashw+j8PkGHZuIiWhIeFnsPUncSNXLywDOzkv/0lQ7Ziwa4Wggt6eYxVY9bn4=
X-Gm-Gg: ASbGncvMSvPEfw9L2HDnPTCC+TIjolBNPWtqKsMH11kuSbFHZdkTMoaoPCKwrrgZLEW
	TeU2MByWIyXxum6EL+RUf3HlxzeoWZ64EccjJriV0lNYDhUzpgSr5R+WLvDITGFL2ffFtYhkV8I
	fDfddB9jno72LIbHLZqQMOyghi2T+0RqMAmV9+3H5R/TSdMvmct4LZpfwx+KqgqRCg/0qmyN3Is
	iWFHzuhUkFDCDW5XA8KmuZ2QqL1tvTY7kEhPGCnV7xDlOD4LenJ5D5a/fcC3V47bxcHltybimf2
	2N6Ezxry8Op1aoRu/slrtq363RLReUVpbWVCJH7nDfI=
X-Google-Smtp-Source: AGHT+IEcq/QunsKuPH1Q3YVPdIlIf7+yGkD/KLS5diiz1gkkypvEoKGl1k0osNyRJJabEJm7/UPz4g==
X-Received: by 2002:a17:90b:4acf:b0:2fe:a614:5cf7 with SMTP id 98e67ed59e1d1-2fea6145e8fmr1937828a91.3.1740634420550;
        Wed, 26 Feb 2025 21:33:40 -0800 (PST)
Received: from fedora.am.students.amrita.edu ([123.63.2.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea6753143sm582407a91.4.2025.02.26.21.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 21:33:40 -0800 (PST)
From: Siddharth Menon <simeddon@gmail.com>
To: linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Cc: skhan@linuxfoundation.org,
	pmladek@suse.com,
	mbenes@suse.cz,
	linux-kernel@vger.kernel.org,
	Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH v3 1/2 RESEND] selftests: Introduce script to validate required dependencies
Date: Thu, 27 Feb 2025 10:59:26 +0530
Message-ID: <20250227053322.114215-2-simeddon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227053322.114215-1-simeddon@gmail.com>
References: <20250227053322.114215-1-simeddon@gmail.com>
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

A config mismatch exits with error value 1 while matching configs or
missing config files exit with value 0. In order to silence missing
dependency output, set the environment variable SILENCE=1.

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
index 000000000000..ef1a5fe8c321
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
2.48.1


