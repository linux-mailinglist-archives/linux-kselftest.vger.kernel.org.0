Return-Path: <linux-kselftest+bounces-45058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B61BC3E825
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 06:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02F1E4E25A2
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 05:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12FE261B70;
	Fri,  7 Nov 2025 05:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2fe+DTWa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A8A1DC985
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 05:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762493391; cv=none; b=UfKIQWFNIpQVmJWOp/sv2smcud3Nkq0l6zS4M032T7kcP+n3UmQOW7R0zUy45PVO8m2Gv6tthshadZw90FLYlPl6YkNcTfW4dKTZvUAweozgprDuc517hnbpwpnN8O8wVxnz6IiLhqtZRmyhY1WGwKh5vdg/u/XlUurazLT21fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762493391; c=relaxed/simple;
	bh=RV9zvylkghKN55Hz0b0NOWqbwRthFQ9z21H6uAqwdwo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=G8K/Rv5CkLC47rOkf1Q37vQaHcyNieRqb4unmtrjf1xuuIjaLFtToz7uFfFVILZEr0JJAS2y5N2fEM7Y/ZaDI2UTmpJPqLmDTKf9dTG65Mt5A6hzZav4sejo2cDlY/4nYHrS/7z/d8KBFiHOmtLT8mctmZGdpDDs8WkaCfKlU4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2fe+DTWa; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-79a3c16b276so9426306d6.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 21:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762493389; x=1763098189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=njV6Z7e8AHZ3jv7SEHiGiHSYJwXRJtYkycrQltatJm8=;
        b=2fe+DTWa4ByZxAPi4XredV038SRctmSxKdmDPjYS3uJ+yrEncknUPk0tZw8HGFGdnd
         OX080qcaIsim+s4xxUWhLN3HQFmxcT92SnSQcBhf9H+AY1tZ51h+Vcp3mrN5TVFuhpmD
         Qme00bpEvBVBgR1QDy+k2pa9U74T5aQ54Akk7CqyTlTNCEDtHZDKNggk1EtrwgxE4Y0G
         D/qSfiHwp2HcbuAECEyM2io00DBRQ+K9ZOtDB0ypNMjUCgJ4E26sU4+yq9gaic8Rx66q
         KU7ID8YNQRxQ2PS2pBMqGoiRRli9HGCPMdLFuh4YtSzEoMsX5DFsbwj5o99EAWr6FV3w
         M3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762493389; x=1763098189;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=njV6Z7e8AHZ3jv7SEHiGiHSYJwXRJtYkycrQltatJm8=;
        b=TKUG2hohT/GWpwfieRVcTNuX3YefJPcbtDw1neNX6Xs95KOMY8Taeafl3xNTdGVpFP
         stpwhMUj2rKomu97eVoX56Wau+5iWLzU/B16jhJEDQ1MFJpTL+0FILUy8drG3qEQs2Hj
         4pM98VgsU8fG564CJRZZHngUOWRpHgaPOTiNmpNKoPPoaKJdTbUxFU/1RyEXCxeDG6JH
         8l8soGQERjCtZ81DIrosN9yqxS5WTTBdPBCUENd0j66F4jJwdDA4jJpm6DeN/y27qBAV
         SPrss4QAMr/mxCmfES+oC9WWrNDpuTQ5vqvC8gLejFtjIJPNGPr0aS3esExuDnI91UKT
         Y0VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQOVZ1EboO8s/XEd4mm1N3Gj5Q5DCehLw7G38I8702xo4hr5X7x2OOg6O/5Vrw4HOu2rtq1Me/eg/Ficb1pfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXdIM8lpDrDTj9wihfUDcAVSa2hlQcBPYcpyZ0yuU6eUtarbqm
	8juoitNJtWxR9miJEMiiVq6/awZIEE+V9NWYAyyin+QEEQjWEqan4F+cX1kJ2hoVrEHTLXeo4iE
	ymA==
X-Google-Smtp-Source: AGHT+IEcveD+OrmGuHXxDDibGvZt08sbWYuxuP0sLlsVz06qCZqoaz8Zfmbg2vG1rZ8pO+UwsxKrjpQ2Jg==
X-Received: from qvag28.prod.google.com ([2002:a0c:f09c:0:b0:880:65e3:ffd7])
 (user=rmoar job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6214:5009:b0:87c:2559:fa28
 with SMTP id 6a1803df08f44-881767567f2mr25885676d6.43.1762493388956; Thu, 06
 Nov 2025 21:29:48 -0800 (PST)
Date: Fri,  7 Nov 2025 05:29:21 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107052926.3403265-1-rmoar@google.com>
Subject: [PATCH RESEND 0/5] release of KTAP version 2
From: Rae Moar <rmoar@google.com>
To: frowand.list@gmail.com, davidgow@google.com, keescook@chromium.org, 
	raemoar63@gmail.com, Tim.Bird@sony.com, shuah@kernel.org
Cc: tytso@google.com, gustavo.padovan@collabora.com, 
	ricardo.canuelo@collabora.com, corbet@lwn.net, kernelci@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi all! I wanted to resend out this series to respark the discussion
on KTAP version 2. Many of the features proposed are already in use by
KUnit. This would add these features to the KTAP documentation. Note
that all the features of KTAP v2 are backwards compatible. Also, today
is my last day at Google so I will be responding with my personal
email afterwards.

--

This patch series represents the final release of KTAP version 2.

There have been open discussions on version 2 for just over 2
years. This patch series marks the end of KTAP version 2 development
and beginning of the KTAP version 3 development.

The largest component of KTAP version 2 release is the addition of test
metadata to the specification. KTAP metadata could include any test
information that is pertinent for user interaction before or after the
running of the test. For example, the test file path or the test speed.

Example of KTAP Metadata:

 KTAP version 2
 #:ktap_test: main
 #:ktap_arch: uml
 1..1
     KTAP version 2
     #:ktap_test: suite_1
     #:ktap_subsystem: example
     #:ktap_test_file: lib/test.c
     1..2
     ok 1 test_1
     #:ktap_test: test_2
     #:ktap_speed: very_slow
     # test_2 has begun
     #:custom_is_flaky: true
     ok 2 test_2
 # suite_1 has passed
 ok 1 suite_1

The release also includes some formatting fixes and changes to update
the specification to version 2.

Frank Rowand (2):
  ktap_v2: change version to 2-rc in KTAP specification
  ktap_v2: change "version 1" to "version 2" in examples

Rae Moar (3):
  ktap_v2: add test metadata
  ktap_v2: formatting fixes to ktap spec
  ktap_v2: change version to 2 in KTAP specification

 Documentation/dev-tools/ktap.rst | 273 +++++++++++++++++++++++++++++--
 1 file changed, 257 insertions(+), 16 deletions(-)


base-commit: 9de5f847ef8fa205f4fd704a381d32ecb5b66da9
-- 
2.51.2.1041.gc1ab5b90ca-goog


