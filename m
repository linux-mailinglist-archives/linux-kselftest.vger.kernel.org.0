Return-Path: <linux-kselftest+bounces-41184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E03B51E6D
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 19:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8115622F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 17:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4A5292B54;
	Wed, 10 Sep 2025 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ev2rm1TQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F3826F280
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Sep 2025 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757523623; cv=none; b=X1ldt1BJpqJMXlCnmhMX55sreps6gDrpm3y8IBgudYQyApi/xRRySubdkXpNqT8pxpfCGg1gAprM3T6T6wko9Gk8iofTQRLYksFaPr8CotE7MInLOZG84iqMfvkeYLyQHouptEFStNmJPrIDBsTtDllkl7rEblzSEdAnN32oh+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757523623; c=relaxed/simple;
	bh=RhfvkF6XGUNDBOcDD2XXe70eUDZ5PlTeYGlXg7wROy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iTduoJJILTpU29uqrG0n1vTPU/NBG1FvzobyU1t4w+PFqCzbNEWhh7mfCwHr04n69OpO3McOhuPthq8PiBeIo5vxLEnRjuFexrsGqKhlS50GqhiH+xIZ4XdnhQAESJdzifSZfgLtImEq6BGt9AR9TUKhJYsjXbfC9DU2dse9Fuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ev2rm1TQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757523619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FvizIHu59rp6upCtuZbBawOd7faEij62QkVXwUqHPIc=;
	b=Ev2rm1TQUfkdNDEsQVZ/Zwaa1zTIPsW8D3gWNc8PiIBo43RxaAe06B4ZPYBg/dOvOU7pDb
	pleZ4L65dSb2Kwta0QbAZ/5vngTjTybDZgD17wpW6H6/Um8O0opmlpXKffIDtoswJvuFpM
	9YhBl/aD50abSmamcTD6PRRGzSOehYs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-qS1aApQlNCaYjZGsIl4Ggg-1; Wed,
 10 Sep 2025 13:00:16 -0400
X-MC-Unique: qS1aApQlNCaYjZGsIl4Ggg-1
X-Mimecast-MFC-AGG-ID: qS1aApQlNCaYjZGsIl4Ggg_1757523614
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FB3918002C4;
	Wed, 10 Sep 2025 17:00:14 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.22.10])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F3D21956095;
	Wed, 10 Sep 2025 17:00:06 +0000 (UTC)
From: Gabriele Paoloni <gpaoloni@redhat.com>
To: shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-mm@kvack.org,
	safety-architecture@lists.elisa.tech,
	acarmina@redhat.com,
	kstewart@linuxfoundation.org,
	chuckwolber@gmail.com,
	Gabriele Paoloni <gpaoloni@redhat.com>
Subject: [RFC PATCH v2 0/3] Add testable code specifications
Date: Wed, 10 Sep 2025 18:59:57 +0200
Message-ID: <20250910170000.6475-1-gpaoloni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

[1] was an initial proposal defining testable code specifications for
some functions in /drivers/char/mem.c.
However a Guideline to write such specifications was missing and test
cases tracing to such specifications were missing.
This patchset represents a next step and is organised as follows:
- patch 1/3 contains the Guideline for writing code specifications
- patch 2/3 contains examples of code specfications defined for some
  functions of drivers/char/mem.c
- patch 3/3 contains examples of selftests that map to some code
  specifications of patch 2/3

[1] https://lore.kernel.org/all/20250821170419.70668-1-gpaoloni@redhat.com/
---
Changes from v1:
1) Added a Guideline to write code specifications in the Linux Kernel
Documentation
2) Addressed Greg KH comments in /drivers/char/mem.c
3) Added example of test cases mapping to the code specifications in
/drivers/char/mem.c
---
Alessandro Carminati (1):
  selftests/devmem: initial testset

Gabriele Paoloni (2):
  Documentation: add guidelines for writing testable code specifications
  /dev/mem: Add initial documentation of memory_open() and mem_fops

 .../doc-guide/code-specifications.rst         | 208 +++++++
 Documentation/doc-guide/index.rst             |   1 +
 drivers/char/mem.c                            | 231 ++++++-
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/devmem/Makefile       |  13 +
 tools/testing/selftests/devmem/debug.c        |  25 +
 tools/testing/selftests/devmem/debug.h        |  14 +
 tools/testing/selftests/devmem/devmem.c       | 200 ++++++
 tools/testing/selftests/devmem/ram_map.c      | 250 ++++++++
 tools/testing/selftests/devmem/ram_map.h      |  38 ++
 tools/testing/selftests/devmem/secret.c       |  46 ++
 tools/testing/selftests/devmem/secret.h       |  13 +
 tools/testing/selftests/devmem/tests.c        | 569 ++++++++++++++++++
 tools/testing/selftests/devmem/tests.h        |  45 ++
 tools/testing/selftests/devmem/utils.c        | 379 ++++++++++++
 tools/testing/selftests/devmem/utils.h        | 119 ++++
 16 files changed, 2146 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/doc-guide/code-specifications.rst
 create mode 100644 tools/testing/selftests/devmem/Makefile
 create mode 100644 tools/testing/selftests/devmem/debug.c
 create mode 100644 tools/testing/selftests/devmem/debug.h
 create mode 100644 tools/testing/selftests/devmem/devmem.c
 create mode 100644 tools/testing/selftests/devmem/ram_map.c
 create mode 100644 tools/testing/selftests/devmem/ram_map.h
 create mode 100644 tools/testing/selftests/devmem/secret.c
 create mode 100644 tools/testing/selftests/devmem/secret.h
 create mode 100644 tools/testing/selftests/devmem/tests.c
 create mode 100644 tools/testing/selftests/devmem/tests.h
 create mode 100644 tools/testing/selftests/devmem/utils.c
 create mode 100644 tools/testing/selftests/devmem/utils.h

-- 
2.48.1


