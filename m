Return-Path: <linux-kselftest+bounces-11795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 499E2905C68
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 21:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F358B1F2202E
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 19:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DEF84A36;
	Wed, 12 Jun 2024 19:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdZ0ef3s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F8783CD7;
	Wed, 12 Jun 2024 19:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718222362; cv=none; b=dnrenxnhZLiXVtdA295dBGkfcGqCCr5dlhFITYevvnvCKYdIWmmwRJV8ZbcOEWKgz7PEfpvLkShVzTYpkyl6ZNNkfHFjReES+RZxT0OdeZd8J3s7KSyTtuhiD0MkdZ/zWchckLIVKt75jE2zt7KvzG6+uU8KjE+QDLcqnbBPX+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718222362; c=relaxed/simple;
	bh=ywb3uiBG2wy3W42HC/zKfdSwk5lSiUjJmg2WrX2ndXU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fh/GtxsAV2TxQHrlDXQFXIdjqcCauPcuhuYwAiXah//qyP4rz5z3aFutbxoIcG+q/hRW9MpBp2AgcCpyoK4WXZx5MioJSrygU6e+8geAd6DnGhN39N7CtFTg85ieJydD4IgpzlBThUv4C8KNnw8AsC0sglmnQKesS4lTEWkgUYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdZ0ef3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C4BC4AF1C;
	Wed, 12 Jun 2024 19:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718222361;
	bh=ywb3uiBG2wy3W42HC/zKfdSwk5lSiUjJmg2WrX2ndXU=;
	h=From:To:Cc:Subject:Date:From;
	b=gdZ0ef3swbOtu4F1HBTAPQa2DzYdERqCN34g33CXEgeljn2/5A/haffsVyUg/tYWR
	 LCMfDwCvEj1TJ9phJbS1CZ77BY3DR/CZcChUJBnU1zAWSyMIMoW4HK5Qpr+6a+nrG8
	 68b1H5hyFBuLWtjh7J7Q+MJR/bQ2Iv1K7XPH5aSnR4nMJlM5+jeywtEeVvqJ5BrOZA
	 +Wmv6Rhv2Tmg+0cqattKws4UN32cG3Yw72GJj0rLd5VUzYF7G7ez4k+hHShDOUqaaK
	 N/aONIMtabnXL9D/MebPj0W2APDB0OZbpdMrQ4KHQiY49AaKFX6r/ul7I7r3MbaFHr
	 Ks3CbTVPu4sIA==
From: Kees Cook <kees@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <kees@kernel.org>,
	Vitor Massaru Iha <vitor@massaru.org>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 0/2] usercopy: Convert test_user_copy to KUnit test
Date: Wed, 12 Jun 2024 12:59:17 -0700
Message-Id: <20240612195412.make.760-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1667; i=kees@kernel.org; h=from:subject:message-id; bh=ywb3uiBG2wy3W42HC/zKfdSwk5lSiUjJmg2WrX2ndXU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmaf4XEwSV7IuaeeCDHXmAIPUInE1HVQWFespdR wraZVkQQGuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZmn+FwAKCRCJcvTf3G3A JqH9D/9txSQCi1FIJJQ1Ag5Xwl/86L58GRfBVKTS7JD15KOFdocuGu52/CNwtYotA7DPcEheBXh oFDx8vdj5N4pRHTTDUYAHDcEhlPjZ/1ddI8SH5RJJgdNV8hv+RPVhe96Q1q2WFSKXPPsOdQ6iD8 qQQ131S6g/B3hqKD3DjNi6ypugExxOAR+7j8x8JTxONfQDjBuSWgvM+vanCM1XPHBNwBAztqfY+ nPECZuj3ZP9ulqjCe6tMhN93aSAe1UaFk6oO0utpnnMEC++sPTfMY3Xk8DH1WQ3yzTyJ6gg2XJO BjF5k3uAvtLU+mmRDzS/XvCWzsLTnFRrs568HlUPRB7uL9pdFM9NYdeiyDbokbmY1SMM4A147Cd cBs89TcwDjz6XBRwjL5Tc5a3gE+hu/wqWGVSa9+PBOIZLM6oCBqhpa34XqxRkx8vyUdlU2/P90L ZqC1gEYRVog8cZDSOXiYeD/D+MfMa3g1ZJ6qcazC27OjXrHN/avdgm0Bqq0Gh6AfBDe3+C8tNSt 5+axJO5e2tDqVwwSJ/5E2/b2Qw48tVaNuq9vhR1DQf/g96fJnt4JktzDR7cgaB6fHtGEDyX2I1y sE+iNvtFaffCjonvPp1iIUbRkns4sbrCPzQU8uBk8fiua3TT7y6vyg8jab5+DmYTlNw/qxFt8cS f/U9LEWdteKKV
 5g==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

This builds on the proposal[1] from Mark and lets me convert the
existing usercopy selftest to KUnit. Besides adding this basic test to
the KUnit collection, it also opens the door for execve testing (which
depends on having a functional current->mm), and should provide the
basic infrastructure for adding Mark's much more complete usercopy tests.

 v3:
  - use MEMEQ KUnit helper (David)
  - exclude pathological address confusion test for systems with separate
    address spaces, noticed by David
  - add KUnit-conditional exports for alloc_mm() and arch_pick_mmap_layout()
    noticed by 0day
 v2: https://lore.kernel.org/lkml/20240610213055.it.075-kees@kernel.org/
 v1: https://lore.kernel.org/lkml/20240519190422.work.715-kees@kernel.org/

-Kees

[1] https://lore.kernel.org/lkml/20230321122514.1743889-2-mark.rutland@arm.com/

Kees Cook (2):
  kunit: test: Add vm_mmap() allocation resource manager
  usercopy: Convert test_user_copy to KUnit test

 MAINTAINERS                                |   1 +
 include/kunit/test.h                       |  17 ++
 kernel/fork.c                              |   3 +
 lib/Kconfig.debug                          |  21 +-
 lib/Makefile                               |   2 +-
 lib/kunit/Makefile                         |   1 +
 lib/kunit/user_alloc.c                     | 113 +++++++++
 lib/{test_user_copy.c => usercopy_kunit.c} | 282 ++++++++++-----------
 mm/util.c                                  |   3 +
 9 files changed, 288 insertions(+), 155 deletions(-)
 create mode 100644 lib/kunit/user_alloc.c
 rename lib/{test_user_copy.c => usercopy_kunit.c} (46%)

-- 
2.34.1


