Return-Path: <linux-kselftest+bounces-23702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAFA9F9A9B
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 20:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF2E1884C81
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 19:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5168D2210FF;
	Fri, 20 Dec 2024 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTPpAuxF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91946220694
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734723445; cv=none; b=u3B7GqOIuGiOJN7kle/BGpYC6mWb80JViDbJGDmZelBpzx7g/nE9ZTxR/9TIXa0NPKy9rBkU+lIckwNE4iOV/yaxtuCO/g/2nQ/qrYItsjVh/Cn70VQD71CL31PEoY2fK1T8tDZMJR9kVy+8I8PS4C3DA7YoxW6rJBg+WtdQOF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734723445; c=relaxed/simple;
	bh=wPPMGD/Y+Ku7662J0HTdVsnnY/F/h8+6kZs7AobTU48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JJJiEYKFj0ZVvWu/Y4r+kxcpJSVgOwT8o/e+j4OfZWAfmn0ggLI6SXIigHWil5avQegrbyVE57Bsjse2AVX54s6Q3Meg7roLWng4I8TODzIazUWHgXlFOySX6ozQWaHnMOfdULnoN9gDTMEIRPnKAL5ngFGQQ3PtMl1VSez4a+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTPpAuxF; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso1848021a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 11:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734723443; x=1735328243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVzXk/euw75c72myAQZ4X8aeAOsNecDya69b0DzjfKc=;
        b=hTPpAuxFc+RF70Hwg3QCzaOTwc7izi0x+7A7ngRYi9NNx80g93odMxOFumIpyfp1ag
         JQWdOufrXZeiJIxs2g4yYnlXnyUqAZAFUzbmT8OAISMPJWSSCUqoZnZpIJN4eD5qSggo
         PvXUY+2ZQqFo0SV/4ojvlpeE3WLQ7Zj98scs/U4F/kSa03yop4H3LmEuJ5N16o9ZHalS
         4nfYo8lHzQa15TGvjFyStAS/wwClpe+27VxqhcR5D8wJyyKqQlrtpOlt8H4Xc0ITL+s+
         OE03f0NOfWDQUjDQ926aiX8sN1Psl6kdZwcMeKF/e8uv86lWzHRMsgKiiAFF1AyDc73x
         lcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734723443; x=1735328243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVzXk/euw75c72myAQZ4X8aeAOsNecDya69b0DzjfKc=;
        b=RD4V6+uh8w9MOTsF/nDG/7+j0MMoS+JPBu044Lckx8KcurpbKgadSQPTTgEYHIiucH
         WZso2bVDYtnn/meH86XLa3luJqTgM0Dg5cNUjeu/uo/VwHc10Tm571Cci7z7+KEyRjnl
         pAdeaidJmw/NN7U5VgdW0Rt1IviN3XFXGnpOp4qsNIqXJXSpurmfYCKUNai2pqlEH4I5
         EU1askL3fMhL6ToGX4/kAeqh57oVvsofR0QW0rRyHVo47tKbbn4CC8Bku/wABx+uGwl6
         LsOGVHj72sw9GcdCcsBZR5zwwTi4urOZjLD4UDTcWwfagBWeNe2JrPoJrUTFCJNJu6Md
         LddA==
X-Forwarded-Encrypted: i=1; AJvYcCXRS5ceBNIe4dNblBe2ZdLLL8x33GA2LVrZkwhfWQ9Fmu+VhmMUIyFRTsPuI5zaEvRg2HnQKkuiB2PylFGuYLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSVGTBRkGdRM7f70CHNZl7zTAO7Q8nLZGGaOI+tEHEBWyLaiH6
	GbMK8ywDdKaQuZaWMRn3yalQzUdULXoYY3ivdQifUQxFd1X2mtYWZKaqMha3BxbNMw==
X-Gm-Gg: ASbGncve6mONWDcgI11c/dx1c1GhQtzl4WHdMuRPkcYFu38ghRmK6+2hH3LfbdepRNk
	L3kxgwD3yWSRP1+SLV2dB0xzjgp1JN8skTWpu+ooU4/I+fJaRFsAHTISBGHM9AYvY4YI6ITpl3X
	qoYb23GHq1e2BrNxr5vqmvEnWlPJ276l6Vy5te+WL6n1gT4npoK8MRw1WG4ott8CzwPZvNE5x9B
	jghzJjJCQi3y8iTUVUptm/1jVks5/jHq6/ofyERdlY2REawG0pFkhERZho4mtONoAjsGO89ZHhF
	4sDHLv2RiPk=
X-Google-Smtp-Source: AGHT+IHj906krwAWz7XUjbA04ryYXEHC+FhYCZEf32IXssM2QnPHJGO4AEBOpRhPvsQIxc2RD5njdQ==
X-Received: by 2002:a17:90b:2545:b0:2ee:a76a:820 with SMTP id 98e67ed59e1d1-2f452e3eebamr5810043a91.18.1734723442816;
        Fri, 20 Dec 2024 11:37:22 -0800 (PST)
Received: from BiscuitBobby.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4477ef3d9sm3680917a91.26.2024.12.20.11.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 11:37:22 -0800 (PST)
From: Siddharth Menon <simeddon@gmail.com>
To: simeddon@gmail.com,
	shuah@kernel.org
Cc: skhan@linuxfoundation.org,
	pmladek@suse.com,
	mbenes@suse.cz,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/2] selftests: Introduce script to validate required configs
Date: Sat, 21 Dec 2024 01:05:35 +0530
Message-Id: <20241220193536.13781-2-simeddon@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220193536.13781-1-simeddon@gmail.com>
References: <20241220193536.13781-1-simeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a script to validate that the current kernel configuration
satisfies the requirements for selftests. The script compares the current
kernel configs against the required selftest configs.

A config mismatch exits with error value 1 while matching configs or missing
config files exit with value 0.In order to get debug output, set the
environment variable LOCALMODCONFIG_DEBUG=1.

The code for extracting the current kernel configs is adapted from
scripts/kconfig/streamline_config.pl.

Suggested-by: Petr Mladek <pmladek@suse.com>
Suggested-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 v1->v2: created this perl script instead of checking directly in lib.mk
 tools/testing/selftests/mktest.pl | 138 ++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100755 tools/testing/selftests/mktest.pl

diff --git a/tools/testing/selftests/mktest.pl b/tools/testing/selftests/mktest.pl
new file mode 100755
index 000000000000..60462f323bde
--- /dev/null
+++ b/tools/testing/selftests/mktest.pl
@@ -0,0 +1,138 @@
+#!/usr/bin/env perl
+# SPDX-License-Identifier: GPL-2.0
+use warnings;
+use strict;
+use Getopt::Long;
+use File::Spec;
+
+# set the environment variable LOCALMODCONFIG_DEBUG to get
+# debug output.
+my $debugprint = 0;
+$debugprint = 1 if (defined($ENV{LOCALMODCONFIG_DEBUG}));
+
+sub dprint {
+    return if (!$debugprint);
+    print STDERR @_;
+}
+
+my $uname = `uname -r`;
+chomp $uname;
+
+my @searchconfigs = (
+    {
+        "file" => ".config",
+        "exec" => "cat",
+    },
+    {
+        "file" => "/proc/config.gz",
+        "exec" => "zcat",
+    },
+    {
+        "file" => "/boot/config-$uname",
+        "exec" => "cat",
+    },
+    {
+        "file" => "/boot/vmlinuz-$uname",
+        "exec" => "scripts/extract-ikconfig",
+        "test" => "scripts/extract-ikconfig",
+    },
+    {
+        "file" => "vmlinux",
+        "exec" => "scripts/extract-ikconfig",
+        "test" => "scripts/extract-ikconfig",
+    },
+    {
+        "file" => "/lib/modules/$uname/kernel/kernel/configs.ko",
+        "exec" => "scripts/extract-ikconfig",
+        "test" => "scripts/extract-ikconfig",
+    },
+    {
+        "file" => "/lib/modules/$uname/build/.config",
+        "exec" => "cat",
+    },
+    {
+        "file" => "kernel/configs.ko",
+        "exec" => "scripts/extract-ikconfig",
+        "test" => "scripts/extract-ikconfig",
+    },
+    {
+        "file" => "kernel/configs.o",
+        "exec" => "scripts/extract-ikconfig",
+        "test" => "scripts/extract-ikconfig",
+    },
+);
+
+sub read_config {
+    foreach my $conf (@searchconfigs) {
+    my $file = $conf->{"file"};
+
+    next if (! -f "$file");
+    
+    if (defined($conf->{"test"})) {
+        `$conf->{"test"} $conf->{"file"} 2>/dev/null`;
+        next if ($?);
+    }
+    
+    my $exec = $conf->{"exec"};
+    
+    dprint "Kernel config: '$file'\n";
+    
+    open(my $infile, '-|', "$exec $file") || die "Failed to run $exec $file";
+    my @x = <$infile>;
+    close $infile;
+    return @x;
+    }
+    dprint "Unable to find kernel config file, skipping check\n";
+    exit 0;
+}
+
+# Check if selftest path is provided
+die "Usage: $0 <selftest_path>\n" unless @ARGV == 1;
+
+my $file_path = $ARGV[0];
+
+my @config_file = read_config();
+
+my %kern_configs;
+my $valid = "A-Za-z_0-9";
+foreach my $line (@config_file) {
+    chomp $line;
+    next if $line =~ /^\s*$/ || $line =~ /^#/;
+    
+    if ($line =~ /^(CONFIG_\w+)=(.+)$/) {
+        $kern_configs{$1} = $2;
+    }
+}
+
+my %test_configs;
+# Continue as normal if /config file does not exist 
+open(my $fh, '<', $file_path) or exit 0;
+
+while (my $line = <$fh>) {
+    chomp $line;
+    next if $line =~ /^\s*$/ || $line =~ /^#/;
+    
+    if ($line =~ /^(CONFIG_\w+)=(.+)$/) {
+        $test_configs{$1} = $2;
+    }
+}
+close $fh;
+
+# Check if all selftest configs match kernel config
+my $all_match = 1;
+my @missing_or_mismatched;
+
+foreach my $key (keys %test_configs) {
+    if (!exists $kern_configs{$key} || $kern_configs{$key} ne $test_configs{$key}) {
+        push @missing_or_mismatched, "Required: $key=$test_configs{$key}";
+        $all_match = 0;
+    }
+}
+
+
+if ($all_match) {
+    exit 0;
+} else {
+    dprint "$_\n" for @missing_or_mismatched;
+    exit 1;
+}
-- 
2.39.5


