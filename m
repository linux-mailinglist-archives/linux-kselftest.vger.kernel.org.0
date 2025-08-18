Return-Path: <linux-kselftest+bounces-39183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCD2B2970B
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 04:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2AF17A59D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 02:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE6C253355;
	Mon, 18 Aug 2025 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY4iLyx6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341932356BA
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755484164; cv=none; b=TMgeX9lj4Ca/AM/wBsoIwyJcFffJk0ds4K8SJrbiF6+sQyPOeetlP0n0ae7r8k81trvuGwyDEyMs4/ioue4wP+d8btkJLNepolajESy+c+1bk05QUbq5qTOmHGe1MXU32LWaH+O9ufzK9cK8hAOn+rIE5uZAGzKfMwDFrQVzQHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755484164; c=relaxed/simple;
	bh=JMvMdpfCHBOzBRt67EPxrE3AkgTe5+5Lyz5dCy3IKJM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=l8c7m3X3D5eTRoBx/ulw4PqePx/Cqis6zzNgtkR3H0DmcMuzfKu+P2A8kfTKrteHMqEZRvQxoaJZF7LaVW4cDW222jyzHES+JciCHEPJsHIHuHYXT6bIC/Hyh2+voIc33ynOu4MJhT8fzP465GHMbfpyuWo3jx2p0qcOlRmVQFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hY4iLyx6; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7a8dd3dso512377366b.3
        for <linux-kselftest@vger.kernel.org>; Sun, 17 Aug 2025 19:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755484161; x=1756088961; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyadSzPggH+QxJnbb3GNFcdkcjBsgL4zL6XHtASMwYE=;
        b=hY4iLyx6M9ePPp+kYY0s5xZ2vvyK8asIzschJpK+dPvAgpo94DKGRH1xa6lCGPSBNc
         67jTH8RNo7dH41rrPsVu1WZ1hlSdu3v5gU5tURtOI/2Ic8laGmr6ey5afb6t4xtSN0de
         sQhrA3lsvtjiupyaWHzeO4EI3T0vXhz/jghbjyXbJs25LGJIFiU0EDOtqh/bqCf5acOx
         /6Qj0tt4FR/DfIFgvgr+1liWLThf9ArGQwabqrPa8YZeKbMvL9gbcZ7PY8PAH6Oz3qsb
         vyljrUjiJcOjcsceRYm7wr3Gr2iuHX7+H/DW0QGrOwvtB/fKIjoELQDFmu4NTXAwKCNr
         akJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755484161; x=1756088961;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyadSzPggH+QxJnbb3GNFcdkcjBsgL4zL6XHtASMwYE=;
        b=LJO6rchv3kT9Fvi6I4/t5McMp8qkHiO/0N5iN1Vjn9x775w/p+USsN39mcYFLLdTgh
         Du9ouJsFdvxXsHWOFCexnAHVPyMLFaRneeUPatAypSY3TCb1b7MoUQh28xLoxkzZ3lfE
         IBaE0xhqfeBB9NiLmt4GVOdCcWHJSk3SiLTnq0nwEEpvmCtI5nSTq5ruH5dlTB/vrkOR
         XZlRsz5XCuHWRAu6uWhkKJTgfGV04y4Fi+QJtFh31QDQO66Dx1VxATPWrbeyGAdPfPec
         p+qmD3vGPoGNDkUV01MeCtPF2USMSWiUDIEvl7dM646ufbrGymQCjM5WiDLx0oRyXXXY
         92ug==
X-Forwarded-Encrypted: i=1; AJvYcCW5d2HSptOtzZK0jsLl4GS9b2qC+uvvRfKPAjL8T8vc6Fpg/wYTqPqr6lRCNqMQ6iQ2b5KFjmTQ0zrUnTCd5Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP+SuHNjUR58kjI+EE9hI4rKSf1z0IZMSuRpANytU+rklz6qD0
	HUvrWKxJACrjceCwt61JvrstNC+YULW5qybfWLNZ2WvpoGav8bXtY+Fz
X-Gm-Gg: ASbGncvrWR/focWgl9aMw8OHditozr+VOakKVkxwzmN7KzHEZE+cqwDvx6BRRlRJFUG
	LkuSKUaXk6PZhHmDC0vKMVO785KKzmNIpj593J1ebpkqBqBjf7Sa3EgKau4uqlMJ/5/4HpxomYG
	t9jDo51nvAYa7KqX+TtW3o2IxaPyXMraZEgnE82ajAMYuypXznviyXhLjFYjzAzk1oHaT2pIOM9
	0+0Gxe2n6HluxXvo9zMpdkvewcYMiD/CcXrIX73QxTRx9c2rVFzZK7v5AyjR251xWYHd20Hd2TD
	6mgDOGUd3Y5H6ZAl3ETMxbI28Und69q4kTf51x0CRVmycJjc2by/cfs/1GhnkyQtGrUVZzQJ99/
	HL2zuW6hbckW3G+fa07cEfw==
X-Google-Smtp-Source: AGHT+IG0DQYHvuG+jv2TVvSxVZaWrasuSFWynHFmIf7vi6UCBqFuHpzcZHuqCKx/cPPqnwv9gL9fiQ==
X-Received: by 2002:a17:907:9727:b0:ae0:d08b:e85 with SMTP id a640c23a62f3a-afcdc3e9a06mr861203666b.61.1755484161361;
        Sun, 17 Aug 2025 19:29:21 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd0104a4sm702355166b.87.2025.08.17.19.29.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Aug 2025 19:29:20 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	riel@surriel.com,
	harry.yoo@oracle.com
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v3 0/2] assert rmap behaves as expected
Date: Mon, 18 Aug 2025 02:29:03 +0000
Message-Id: <20250818022905.15428-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

As David suggested, currently we don't have a high level test case to
verify the behavior of rmap. This patch set introduce the verification
on rmap by migration.

Patch 1 is a preparation to move ksm related operations into vm_util.
Patch 2 is the new test case for rmap.

Currently it covers following four scenarios:

  * anonymous page
  * shmem page
  * pagecache page
  * ksm page

v2->v3:
  * handle ksm error return in worker
  * rebase on current mm-unstable
v1->v2:
  * do check on file opening in init_global_file_handlers()
  * factor out ksm_merge() and ksm_unmerge() instead of partial of it
  * align the return value of helpers: 0 on success, -errno on error
  * skip instead of assert if numa not available
  * check ksm sys file before continue
  * use private anonymous map instead of shared map
  * check pfn instead of content
  * retry migrate
  * fault in region for each process by FORCE_READ()

RFC->v1:
  * open file in function itself instead of pass fd as parameter
  * fault in the region by accessing it instead of print content

Wei Yang (2):
  selftests/mm: put general ksm operation into vm_util
  selftests/mm: assert rmap behave as expected

 MAINTAINERS                                   |   1 +
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   3 +
 .../selftests/mm/ksm_functional_tests.c       | 134 +-----
 tools/testing/selftests/mm/rmap.c             | 433 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   4 +
 tools/testing/selftests/mm/vm_util.c          | 123 +++++
 tools/testing/selftests/mm/vm_util.h          |   7 +
 8 files changed, 595 insertions(+), 111 deletions(-)
 create mode 100644 tools/testing/selftests/mm/rmap.c

-- 
2.34.1


