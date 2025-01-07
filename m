Return-Path: <linux-kselftest+bounces-23985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350B0A0410E
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 14:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F7016474C
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 13:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B8815854F;
	Tue,  7 Jan 2025 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TO6kOY+n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7DB2940F
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Jan 2025 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257487; cv=none; b=GCtipFXlr0XbE2PlronoUs5bgMRXdIw2P3uPqfirt9w1aLDmSDrCxMJZNwexQ5h/YZElGK9i6D9FQ0oVDYicLdPPYU3+V+g9L9qcaIIWpUaFAznWrYwgJ6sVcqhGpZwrgJ6hmlyCzohjqZvfKr1f81KgBSanj5UiuTFKcOJtLOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257487; c=relaxed/simple;
	bh=yOre5U85FQMTEBDgahAtx7E5JX5dIUIDyPIVQUv3kBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kevEeIapjQVNnWXrErU0bLu0AWb/9xByjsjYoeCivOWJbCRe7//UewjnDkBWnKxSkkBpP6N7cUH6g2d3cVXLqvL2+ctzP/BJRQlt/5OITW1bIOfte5wTj+kva018s5jDg56DEFW+QJDbnB88kB6HcnYphuuJ6O7MzuNFmRD5uvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TO6kOY+n; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4368a293339so123168955e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Jan 2025 05:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736257482; x=1736862282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4caYOgQXcOiPrxRQmDlaKWXEd7Nz/FZinWaIJ6ZAtLw=;
        b=TO6kOY+noUGg1FB0H9oIaJmP12zxFqnz21FbBv1yOMqANrKSFKXaMbTTuKdZkA8FG7
         jZOdYTIye7Qbf/8SwOPs3XcD4BR5UBOgn63dOvcCqw23ho/rhitvv1SaMC3yWgukNnJ2
         tHqfHg4sPBZh5AKroMJzlGbrWYZ+KIQnyuWtzOHD8s0Qtg8tE3QSrxpy2rYTqsjalVdY
         6eWkZztS+kCf5GLN8T9qSkYEEmKjgSTzbpkML3j3ZA58s41Lvd8QfmPmhpGQK5M0O7XD
         NdBqKCCX5xTG+EcMeoLTocPnDswzePNrXSr88wv5NSvJABKjEJK//7shvHdSTN7yVjW+
         ZV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736257482; x=1736862282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4caYOgQXcOiPrxRQmDlaKWXEd7Nz/FZinWaIJ6ZAtLw=;
        b=P3BXGabgBkwDAEOGsXKhRn1Pm26BmYLW+FZa+kaToWnZdRqcJLoFDHYvvsYz0Syiaw
         s9eDcKw4jcDIt7jwFjnY9FncaugiIlKN0HS2gvLzaGK64ITsS8pRt6LueNmJaQJ5lD8C
         e46+sCwRFNYjGwValXwD+q/hGEG9e0J2GNGNR1x4hOspIBO4T98BaFvCZGCsjt4uCJ0+
         Ku71ZurHsDZuGINApvGbNSdDuCt3In5nw3FDe3pxs+CnfC+HTUA1vtbcix1jQmr025n1
         OcZ0hWL7/y/501M1dPhP3TpsuYpjVp4/wlRpuJLmv8Mnw0TNUk0Q+9J5MLWQxf0nuq/6
         BSVg==
X-Forwarded-Encrypted: i=1; AJvYcCWPn6jZf+ukieH/4cE7WMSj1vHgdeNrdF+kwj3d2SvAyjhOw9nWO4iCTlsZ403iBiiIBHmAjZ1wmxgWaNVbPaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlQMbvMq2TRFuBYsWp9E6E29G1PY+vqrtf/zZIognvh50Cy3se
	8sOAhrRftXCkFO4lPnyVq7hlgZlvoM3khvtxRm2kzKRL2Jc7DYbZ/+6SyTtO104=
X-Gm-Gg: ASbGnctFR8wlH203bkLpssApZf3G8QuaoUEYfdDx4JvHYCZs3n3go2Wy7fUznMF20ka
	fEcak0175mqOEuTCjQP4+pOeHnkuRIVtopX4yr6PKBjS0XZmvdZBGbBOm4xRVvTf1hgkPM+hgat
	ogjdCeulZs34c3z9pTbnPWOqvCtfVb1eKslcg73Ouamb2JP/dlnklReZpvm1xhoJzeOeAORIUNP
	W1begxTAeglk/FBeQY7tSTpbxrFB3CKD1mI96FlpjteEhLbiuHNkRuu9A==
X-Google-Smtp-Source: AGHT+IGBXhODxQaIk1vniBb+j8WnEfZqUjO84yZEBezp8sThToCc9nHmtGJdKCD1kH17o/9/UOaQEQ==
X-Received: by 2002:a05:600c:524c:b0:434:edcf:7474 with SMTP id 5b1f17b1804b1-43668b93c61mr424584365e9.33.1736257482089;
        Tue, 07 Jan 2025 05:44:42 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a412f778esm36275665f8f.4.2025.01.07.05.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 05:44:41 -0800 (PST)
Date: Tue, 7 Jan 2025 14:44:39 +0100
From: Petr Mladek <pmladek@suse.com>
To: Siddharth Menon <simeddon@gmail.com>
Cc: shuah@kernel.org, skhan@linuxfoundation.org, mbenes@suse.cz,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] selftests: Introduce script to validate required
 configs
Message-ID: <Z30vxyUi7NYbo4EG@pathway.suse.cz>
References: <20241220193536.13781-1-simeddon@gmail.com>
 <20241220193536.13781-2-simeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220193536.13781-2-simeddon@gmail.com>

On Sat 2024-12-21 01:05:35, Siddharth Menon wrote:
> This patch adds a script to validate that the current kernel configuration
> satisfies the requirements for selftests. The script compares the current
> kernel configs against the required selftest configs.
> 
> A config mismatch exits with error value 1 while matching configs or missing
> config files exit with value 0.In order to get debug output, set the
                                ^
				missing space before the next sentence

> environment variable LOCALMODCONFIG_DEBUG=1.

I would prefer to print the missing dependencies by default.
Otherwise, it is far from clear why the test was skipped.

Also LOCALMODCONFIG_DEBUG looks like a pretty non-standard way to get
debug output. People will have troubles to discover this way
and memorize the long name.

> diff --git a/tools/testing/selftests/mktest.pl b/tools/testing/selftests/mktest.pl
> new file mode 100755
> index 000000000000..60462f323bde
> --- /dev/null
> +++ b/tools/testing/selftests/mktest.pl

I would give it a more meaningful name.

For example, using the same name as for the makefile target
just with .pl suffix. I mean "check_config_deps.pl".

That said, I have just realized that that there already was
"kselftest_deps.sh". It seems to check missing compile dependencies
by scanning various variants of LDLIBS variables.

It seems that "kselftest_deps.sh" should be called separately.
I mean that it is not integrated with the make files.

It is a bit strange to handle two types of dependencies differently.
It would be nice somehow consolidate the two check scripts
so that they behave similar way and use a similar name.
I personally like the integration with the Makefile.


> @@ -0,0 +1,138 @@
> +#!/usr/bin/env perl
> +# SPDX-License-Identifier: GPL-2.0
> +use warnings;
> +use strict;
> +use Getopt::Long;
> +use File::Spec;
> +
> +# set the environment variable LOCALMODCONFIG_DEBUG to get
> +# debug output.
> +my $debugprint = 0;
> +$debugprint = 1 if (defined($ENV{LOCALMODCONFIG_DEBUG}));
> +
> +sub dprint {
> +    return if (!$debugprint);
> +    print STDERR @_;
> +}
> +
> +my $uname = `uname -r`;
> +chomp $uname;
> +
> +my @searchconfigs = (
> +    {
> +        "file" => ".config",
> +        "exec" => "cat",

Nit: I would prefer to use a tab instead of 8 spaces. At least, the 8 spaces
     are considered a bad formatting in the kernel .c sources.

> +    },
> +    {
> +        "file" => "/proc/config.gz",
> +        "exec" => "zcat",
> +    },
> +    {
> +        "file" => "/boot/config-$uname",
> +        "exec" => "cat",
> +    },
> +    {
> +        "file" => "/boot/vmlinuz-$uname",
> +        "exec" => "scripts/extract-ikconfig",
> +        "test" => "scripts/extract-ikconfig",
> +    },
> +    {
> +        "file" => "vmlinux",
> +        "exec" => "scripts/extract-ikconfig",
> +        "test" => "scripts/extract-ikconfig",
> +    },
> +    {
> +        "file" => "/lib/modules/$uname/kernel/kernel/configs.ko",
> +        "exec" => "scripts/extract-ikconfig",
> +        "test" => "scripts/extract-ikconfig",
> +    },
> +    {
> +        "file" => "/lib/modules/$uname/build/.config",
> +        "exec" => "cat",
> +    },
> +    {
> +        "file" => "kernel/configs.ko",
> +        "exec" => "scripts/extract-ikconfig",
> +        "test" => "scripts/extract-ikconfig",
> +    },
> +    {
> +        "file" => "kernel/configs.o",
> +        "exec" => "scripts/extract-ikconfig",
> +        "test" => "scripts/extract-ikconfig",
> +    },
> +);
> +
> +sub read_config {
> +    foreach my $conf (@searchconfigs) {
> +    my $file = $conf->{"file"};
> +
> +    next if (! -f "$file");
> +    

Nit: There are 4 spaces on the above empty line. "git am" complains
     about it.

     I guess that also ./scripts/checkpatch.pl would complain about it.

> +    if (defined($conf->{"test"})) {
> +        `$conf->{"test"} $conf->{"file"} 2>/dev/null`;
> +        next if ($?);
> +    }
> +    

same here

> +    my $exec = $conf->{"exec"};
> +    

and here

> +    dprint "Kernel config: '$file'\n";
> +    

and here.

> +    open(my $infile, '-|', "$exec $file") || die "Failed to run $exec $file";
> +    my @x = <$infile>;
> +    close $infile;
> +    return @x;
> +    }
> +    dprint "Unable to find kernel config file, skipping check\n";
> +    exit 0;
> +}
> +
> +# Check if selftest path is provided
> +die "Usage: $0 <selftest_path>\n" unless @ARGV == 1;
> +
> +my $file_path = $ARGV[0];
> +
> +my @config_file = read_config();
> +
> +my %kern_configs;
> +my $valid = "A-Za-z_0-9";
> +foreach my $line (@config_file) {
> +    chomp $line;
> +    next if $line =~ /^\s*$/ || $line =~ /^#/;
> +    

another spaces on empty line


> +    if ($line =~ /^(CONFIG_\w+)=(.+)$/) {
> +        $kern_configs{$1} = $2;
> +    }
> +}
> +
> +my %test_configs;
> +# Continue as normal if /config file does not exist 

trailing space on the above line.

> +open(my $fh, '<', $file_path) or exit 0;
> +
> +while (my $line = <$fh>) {
> +    chomp $line;
> +    next if $line =~ /^\s*$/ || $line =~ /^#/;
> +    

spaces on empty line

> +    if ($line =~ /^(CONFIG_\w+)=(.+)$/) {
> +        $test_configs{$1} = $2;
> +    }
> +}
> +close $fh;
> +

Best Regards,
Petr

