Return-Path: <linux-kselftest+bounces-22657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 100989DFB75
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 08:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D892B2159A
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 07:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A54D1F941C;
	Mon,  2 Dec 2024 07:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="11577U3J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15661F8EF0
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Dec 2024 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733126155; cv=none; b=BVqvgO3ZjNszSbb1Ub6/LYOdijTAIFEJuV4nT6keMcYscT1xHxdEoRkCfHnnZ+iNVQ5s8/BfT/YTHP9LD8gXbXZ5o0VHMASoo8X0z9FETqdqW8kLst96OW+5kH42KcGjBTJpojOhotdG5nHkf76bu3my/w1RP9HibhdYL9ySQPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733126155; c=relaxed/simple;
	bh=aTiHyTGNRnn9fKQksjqazR5FDe9KhkQaj8DcU2ZtoQA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LgD3CuNFBiZknFsRXkXXdIthsc3Aqa2L5393g9wk2BFoj+DDbxyun67tWCilbIN6RTyVyQJZMcIoQZaBKFbCeg4+F4rzbAD5OjQCad2RdmmQYN/B1b4XxqJE2lOXwq7Y1QV4s/mvg4IyUIXHN+fNvcXj3M/L066uIulAtX05fk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=11577U3J; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2157b83f656so15119345ad.0
        for <linux-kselftest@vger.kernel.org>; Sun, 01 Dec 2024 23:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733126153; x=1733730953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X5I1xtc0fgXB6XkdcM9boYYvRZD6i0JLsMvJN9yMsjQ=;
        b=11577U3JNLuD9OSrZ96SW6cxCs0+seqNRKdG3w6BGRSjt7C+tkBCPb8e9C1dYanOAc
         iAKJPe3t6GBnuRcfGakPaB+2S0eoyobavz8z0+KkmL9SM2leyxbcC9sACHA5eeYQzG7s
         7tWE/3uAB3Y7iIOjTqVlKwck1+RM5Jg3y1FcEOpF1/hElPQfHLnwfM2EWkcDj5890VpJ
         2NNBhT4/3bk7lTL2rfLvvHHoPupXubWHoDj3XEmiA+PSAqEQmIgL+qCZ3GZfkJCIDWX9
         3/0lWQrO5ejcXp82rJHESt/7q0HeClsTAFBFf21Gu+73GlB8EO9cyOBYkdKVbYvHgWxW
         mrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733126153; x=1733730953;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5I1xtc0fgXB6XkdcM9boYYvRZD6i0JLsMvJN9yMsjQ=;
        b=TvtIdGdxhC2T5b9HfhplRna0Lv/XbkiBRGUf1Nj75sHynqJh/HYuLj8Dk7DrsOr+Ok
         Rn6QkZRTJ4uFubcoKLTKUTSXUiks8KBNxBPaaCJK77C6qpR8fjtbnwrOXYtm/6CSyLfT
         clMc31fzj06w+mWnvJKq4vfkaxtHm4j/KM1xNW5p6H5IwahTrLHdRQUA+vpp4NJFblj7
         mQdTWWaWdkRZKP6K7kv5ERdjEVMacCS7JRI6d7Eo06ps8dmZgEImQeHd0nMHwuj4kQ5u
         2//6ov1MdT2OSqYnw50BoZ/pbH+AFK8XqTUcPq2YPlbqqf1tuCL/2BGIl5JJqdbkg9G8
         1/jw==
X-Forwarded-Encrypted: i=1; AJvYcCVPFIwl5xBmCLfMtSB4ueCmvZqssMRH7m6aYrGlweHotE+T3a/VYGFfyMfTAQjFYMN+kHTnsZNwh8x207yXE90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9t6eau2ZA+7vOVrBcQWTCpY85/eeXLLMHtdPlSe46U1zGZkqA
	HW8T/1ceHLKvseWIvc7+D6X+UHSmHec3JynCKC+yZl04h2X94yreFL8kgrCRhwMP7vumAZ3Dnni
	GJ00dD5qdMg==
X-Google-Smtp-Source: AGHT+IGmDgW5uv9K7xfh8ZOARl6qX/eyD5maBkO485zr6D3D0+8rjVENNz5dhdZZ6GSTGc+LBUpkbW0z8hTk6A==
X-Received: from pldt6.prod.google.com ([2002:a17:903:40c6:b0:215:7433:45b1])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e843:b0:215:5f17:42b2 with SMTP id d9443c01a7336-2155f1743bfmr123356895ad.43.1733126153305;
 Sun, 01 Dec 2024 23:55:53 -0800 (PST)
Date: Mon,  2 Dec 2024 15:55:37 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241202075545.3648096-1-davidgow@google.com>
Subject: [PATCH v2 0/6] [PATCH 0/6] KUnit test moves / renames
From: David Gow <davidgow@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Rae Moar <rmoar@google.com>, Kees Cook <kees@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Andy Shevchenko <andy@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As discussed in [1], the KUnit test naming scheme has changed to avoid
name conflicts (and tab-completion woes) with the files being tested.
These renames and moves have caused a nasty set of merge conflicts, so
this series collates and rebases them all on top of v6.13-rc1, to be
applied minimising any further conflicts. [2,3]

Thanks to everyone whose patches appear here, and everyone who reviewed
on the original series. I hope I didn't break them too much during the
rebase!

Link: https://lore.kernel.org/lkml/20240720165441.it.320-kees@kernel.org/ [=
1]
Link: https://lore.kernel.org/lkml/CABVgOSmbSzcGUi=3DE4piSojh3A4_0GjE0fAYbq=
KjtYGbE9beYRQ@mail.gmail.com/ [2]
Link: https://lore.kernel.org/linux-kselftest/CABVgOSkhD6=3D5K72oL_n35CUeMh=
bsiQjZ6ds+EuQmJggBtVTFVg@mail.gmail.com/ [3]

Bruno Sobreira Fran=C3=A7a (1):
  lib/math: Add int_log test suite

Diego Vieira (1):
  lib/tests/kfifo_kunit.c: add tests for the kfifo structure

Gabriela Bittencourt (2):
  unicode: kunit: refactor selftest to kunit tests
  unicode: kunit: change tests filename and path

Kees Cook (1):
  lib: Move KUnit tests into tests/ subdirectory

Luis Felipe Hernandez (1):
  lib: math: Move kunit tests into tests/ subdir

 MAINTAINERS                                   |  19 +-
 fs/unicode/Kconfig                            |   5 +-
 fs/unicode/Makefile                           |   2 +-
 fs/unicode/tests/.kunitconfig                 |   3 +
 .../{utf8-selftest.c =3D> tests/utf8_kunit.c}   | 149 ++++++------
 fs/unicode/utf8-norm.c                        |   2 +-
 lib/Kconfig.debug                             |  27 ++-
 lib/Makefile                                  |  39 +--
 lib/math/Makefile                             |   4 +-
 lib/math/tests/Makefile                       |   4 +-
 lib/math/tests/int_log_kunit.c                |  75 ++++++
 .../rational_kunit.c}                         |   0
 lib/tests/Makefile                            |  41 ++++
 lib/{ =3D> tests}/bitfield_kunit.c              |   0
 lib/{ =3D> tests}/checksum_kunit.c              |   0
 lib/{ =3D> tests}/cmdline_kunit.c               |   0
 lib/{ =3D> tests}/cpumask_kunit.c               |   0
 lib/{ =3D> tests}/crc16_kunit.c                 |   0
 lib/{ =3D> tests}/fortify_kunit.c               |   0
 lib/{ =3D> tests}/hashtable_test.c              |   0
 lib/{ =3D> tests}/is_signed_type_kunit.c        |   0
 lib/tests/kfifo_kunit.c                       | 224 ++++++++++++++++++
 lib/{ =3D> tests}/kunit_iov_iter.c              |   0
 lib/{ =3D> tests}/list-test.c                   |   0
 lib/{ =3D> tests}/memcpy_kunit.c                |   0
 lib/{ =3D> tests}/overflow_kunit.c              |   0
 lib/{ =3D> tests}/siphash_kunit.c               |   0
 lib/{ =3D> tests}/slub_kunit.c                  |   0
 lib/{ =3D> tests}/stackinit_kunit.c             |   0
 lib/{ =3D> tests}/string_helpers_kunit.c        |   0
 lib/{ =3D> tests}/string_kunit.c                |   0
 lib/{ =3D> tests}/test_bits.c                   |   0
 lib/{ =3D> tests}/test_fprobe.c                 |   0
 lib/{ =3D> tests}/test_hash.c                   |   0
 lib/{ =3D> tests}/test_kprobes.c                |   0
 lib/{ =3D> tests}/test_linear_ranges.c          |   0
 lib/{ =3D> tests}/test_list_sort.c              |   0
 lib/{ =3D> tests}/test_sort.c                   |   0
 lib/{ =3D> tests}/usercopy_kunit.c              |   0
 lib/{ =3D> tests}/util_macros_kunit.c           |   0
 40 files changed, 459 insertions(+), 135 deletions(-)
 create mode 100644 fs/unicode/tests/.kunitconfig
 rename fs/unicode/{utf8-selftest.c =3D> tests/utf8_kunit.c} (64%)
 create mode 100644 lib/math/tests/int_log_kunit.c
 rename lib/math/{rational-test.c =3D> tests/rational_kunit.c} (100%)
 rename lib/{ =3D> tests}/bitfield_kunit.c (100%)
 rename lib/{ =3D> tests}/checksum_kunit.c (100%)
 rename lib/{ =3D> tests}/cmdline_kunit.c (100%)
 rename lib/{ =3D> tests}/cpumask_kunit.c (100%)
 rename lib/{ =3D> tests}/crc16_kunit.c (100%)
 rename lib/{ =3D> tests}/fortify_kunit.c (100%)
 rename lib/{ =3D> tests}/hashtable_test.c (100%)
 rename lib/{ =3D> tests}/is_signed_type_kunit.c (100%)
 create mode 100644 lib/tests/kfifo_kunit.c
 rename lib/{ =3D> tests}/kunit_iov_iter.c (100%)
 rename lib/{ =3D> tests}/list-test.c (100%)
 rename lib/{ =3D> tests}/memcpy_kunit.c (100%)
 rename lib/{ =3D> tests}/overflow_kunit.c (100%)
 rename lib/{ =3D> tests}/siphash_kunit.c (100%)
 rename lib/{ =3D> tests}/slub_kunit.c (100%)
 rename lib/{ =3D> tests}/stackinit_kunit.c (100%)
 rename lib/{ =3D> tests}/string_helpers_kunit.c (100%)
 rename lib/{ =3D> tests}/string_kunit.c (100%)
 rename lib/{ =3D> tests}/test_bits.c (100%)
 rename lib/{ =3D> tests}/test_fprobe.c (100%)
 rename lib/{ =3D> tests}/test_hash.c (100%)
 rename lib/{ =3D> tests}/test_kprobes.c (100%)
 rename lib/{ =3D> tests}/test_linear_ranges.c (100%)
 rename lib/{ =3D> tests}/test_list_sort.c (100%)
 rename lib/{ =3D> tests}/test_sort.c (100%)
 rename lib/{ =3D> tests}/usercopy_kunit.c (100%)
 rename lib/{ =3D> tests}/util_macros_kunit.c (100%)

--=20
2.47.0.338.g60cca15819-goog


