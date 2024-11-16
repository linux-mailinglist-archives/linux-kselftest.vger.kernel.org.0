Return-Path: <linux-kselftest+bounces-22143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0129D0026
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 18:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C71528732E
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 17:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9C4194C8D;
	Sat, 16 Nov 2024 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="qx/57Eoq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0E118B492
	for <linux-kselftest@vger.kernel.org>; Sat, 16 Nov 2024 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731779969; cv=none; b=izJMwFJXedWHWtooCCuMorTRo4PQZO1ZSXHx4kduBGlsWHtyqgezBFV1dcop76G2mxyQdV0vA4ztJ45+cpsgxzv0jIb5GeiGAidfxyns1aEj2MsjrALhKp9Xf+SUZ6NPIxKiY22AOMEkdoWMNL7DHzYcfT1HAFR/09YmfiI1gtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731779969; c=relaxed/simple;
	bh=k6WhVuILcWU/thSQ+0eV73cWf0Sp/tBXO+i+GiCbh04=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=br6oOjaozeYcAwoMS3aTAFh/BQB/bu3SXSHUpV8K3oS4t0FcOWCHKDfOV/A6jEIYGdmVIycwoIlgMKHFN4aaSxoTjbH23oVaEmH1W59bb7oIo6PaCxHuqKVt1P6SBN4P+pu2jU5C/AdSvhm6eFQPiSFuB47uu8v4sThbKSTr+SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=qx/57Eoq; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6d4035f2d18so8959696d6.1
        for <linux-kselftest@vger.kernel.org>; Sat, 16 Nov 2024 09:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1731779966; x=1732384766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9/2cx8m5V2KkB1LkibOPMizZ7amfyQzK5oG3Ev3ZaAc=;
        b=qx/57Eoqde1LS1pnJFix7xy2vrCYFAhCETHHEv354y8jVjbNnBS94qtSP0hcVMjrS8
         YVJ2l9x7LBpecEW+FgB49wrL3hBmGVvkdUjf1i9hnQxlz5q41bd40280Je/UM3IE4zub
         pKLg2nQti26xmpVQwdg2nMk0mgYwwz0LY4Px4QucV13NfbYDRjhyYGNxLVwYkN5r8eH1
         fVupHzsxp4lJlH5PiozAyL79eRlO+sw5D2WdsA11bLuiNycTYl06/CKNqZrIIViT4hrm
         4SdzRfEw8xM51yIanZXoJZQ2choH9wki063AMog66QN7CBO2+qANxk8CmoEDfS6nLzYx
         +Isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731779966; x=1732384766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/2cx8m5V2KkB1LkibOPMizZ7amfyQzK5oG3Ev3ZaAc=;
        b=g1vZO/nnn5Dt4DrKGvGnCft+htQjnJODTWBpSsCNFFRL1ySJGN3M9WomBJt0FbyMMQ
         MWuJ/L08Valz/SQc00oIh+2WMRg+IJ4O5h6oVAzDt4KJeQaPY0xeE0fqUglFwj582TxZ
         puY59YnGvG9uE4a3lkPz4FWt9kxkezwK3R/KVEUWckVF/dXXCkho2FZg4IbjXt7gZGbn
         0WsVEf8pCK900YCpIR4LfswPoQfcbEvIM9fQNRwM6Ck9g7NDk9pEMMqBnvU5hXL2HIs0
         oeV9ie+R9P7N+uZXeEUirEgYDXMcSDA+27ValczuJvTRNX7mSheTuWLyyted5n2zqoiU
         ej7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUoyImNJU8Kd7u0Q8eQZGyOp8jWSo5/yFkb0BcnGkAV4rdlbPrUOW4wQnPbeQECfPMC055tkxxb4T+yYc9QwOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPmAzqP2AIXaan318FAauNnUMgHzhyiVhlkt0TffeMa6b7/AFv
	3b1WLSWbSHlNjjHMzdB+JQWlFzQ6Mx2OuteNmWYTwf+BxPP9IU4ILUy7HYGq6Ng=
X-Google-Smtp-Source: AGHT+IG9khClVQZaK5gJiOlSuiW+HiW7mbHelDE5mIQzNETjqXaEChD5Y6UapjcY1u5FRRsYiVlDuQ==
X-Received: by 2002:ad4:5c4d:0:b0:6d4:1a42:8efa with SMTP id 6a1803df08f44-6d41a4295admr9228036d6.0.1731779966175;
        Sat, 16 Nov 2024 09:59:26 -0800 (PST)
Received: from soleen.c.googlers.com.com (51.57.86.34.bc.googleusercontent.com. [34.86.57.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35ca309d6sm280530085a.94.2024.11.16.09.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 09:59:25 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pasha.tatashin@soleen.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	derek.kiernan@amd.com,
	dragan.cvetic@amd.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	vbabka@suse.cz,
	jannh@google.com,
	shuah@kernel.org,
	vegard.nossum@oracle.com,
	vattunuru@marvell.com,
	schalla@marvell.com,
	david@redhat.com,
	willy@infradead.org,
	osalvador@suse.de,
	usama.anjum@collabora.com,
	andrii@kernel.org,
	ryan.roberts@arm.com,
	peterx@redhat.com,
	oleg@redhat.com,
	tandersen@netflix.com,
	rientjes@google.com,
	gthelen@google.com
Subject: [RFCv1 0/6] Page Detective
Date: Sat, 16 Nov 2024 17:59:16 +0000
Message-ID: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Page Detective is a new kernel debugging tool that provides detailed
information about the usage and mapping of physical memory pages.

It is often known that a particular page is corrupted, but it is hard to
extract more information about such a page from live system. Examples
are:

- Checksum failure during live migration
- Filesystem journal failure
- dump_page warnings on the console log
- Unexcpected segfaults

Page Detective helps to extract more information from the kernel, so it
can be used by developers to root cause the associated problem.

It operates through the Linux debugfs interface, with two files: "virt"
and "phys".

The "virt" file takes a virtual address and PID and outputs information
about the corresponding page.

The "phys" file takes a physical address and outputs information about
that page.

The output is presented via kernel log messages (can be accessed with
dmesg), and includes information such as the page's reference count,
mapping, flags, and memory cgroup. It also shows whether the page is
mapped in the kernel page table, and if so, how many times.

Pasha Tatashin (6):
  mm: Make get_vma_name() function public
  pagewalk: Add a page table walker for init_mm page table
  mm: Add a dump_page variant that accept log level argument
  misc/page_detective: Introduce Page Detective
  misc/page_detective: enable loadable module
  selftests/page_detective: Introduce self tests for Page Detective

 Documentation/misc-devices/index.rst          |   1 +
 Documentation/misc-devices/page_detective.rst |  78 ++
 MAINTAINERS                                   |   8 +
 drivers/misc/Kconfig                          |  11 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/page_detective.c                 | 808 ++++++++++++++++++
 fs/inode.c                                    |  18 +-
 fs/kernfs/dir.c                               |   1 +
 fs/proc/task_mmu.c                            |  61 --
 include/linux/fs.h                            |   5 +-
 include/linux/mmdebug.h                       |   1 +
 include/linux/pagewalk.h                      |   2 +
 kernel/pid.c                                  |   1 +
 mm/debug.c                                    |  53 +-
 mm/memcontrol.c                               |   1 +
 mm/oom_kill.c                                 |   1 +
 mm/pagewalk.c                                 |  32 +
 mm/vma.c                                      |  60 ++
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/page_detective/.gitignore       |   1 +
 .../testing/selftests/page_detective/Makefile |   7 +
 tools/testing/selftests/page_detective/config |   4 +
 .../page_detective/page_detective_test.c      | 727 ++++++++++++++++
 23 files changed, 1787 insertions(+), 96 deletions(-)
 create mode 100644 Documentation/misc-devices/page_detective.rst
 create mode 100644 drivers/misc/page_detective.c
 create mode 100644 tools/testing/selftests/page_detective/.gitignore
 create mode 100644 tools/testing/selftests/page_detective/Makefile
 create mode 100644 tools/testing/selftests/page_detective/config
 create mode 100644 tools/testing/selftests/page_detective/page_detective_test.c

-- 
2.47.0.338.g60cca15819-goog


