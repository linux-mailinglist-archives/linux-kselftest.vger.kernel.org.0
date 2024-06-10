Return-Path: <linux-kselftest+bounces-11607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF36A902AA7
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 23:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7493C1F229FD
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 21:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F2B143896;
	Mon, 10 Jun 2024 21:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iahLFaeL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A658E12F397;
	Mon, 10 Jun 2024 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718055211; cv=none; b=SUa1w6Dyt3hZHjV/LWM8txhEYaEMQBMjPvTj+ZBhwafmht4w8GhNro2g9n4q2YmohTsbxqHzYEB5f1epeDw6/fy4AvXz4YTPhw5BgYbEYDwRUWqz2REBLcCvk7DlMzPj9Yhl8A8GTCfL9pc6cHVw7mNyPbTAgGAGKcROu2dPJfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718055211; c=relaxed/simple;
	bh=XPx0rmN+NH+FmEXC4Z+jCfXaZ8koqHbIlm9JMTURkx8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=chhYGgNiH6knJ2O7PAUYYVwkqxU/P5sTiuJ9whjxBpRf0SDfur/vGwMd//7hkDuZACTF9DKHkmdfCfu3Y82x9K1kaYjVSBf+5o59Bybtyyhg8Bp+I5ZutvoPSfu6t0rmFk0HhDs19sc99W+8JuiyN2yBnAGFb51gbjDwMVx8tts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iahLFaeL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD81C32789;
	Mon, 10 Jun 2024 21:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718055210;
	bh=XPx0rmN+NH+FmEXC4Z+jCfXaZ8koqHbIlm9JMTURkx8=;
	h=From:To:Cc:Subject:Date:From;
	b=iahLFaeL/QvRnZZ/5MQxpU2xiqVSB05y1OO9SfOHdXuorym9HiI7sPIPzawFPU0jk
	 vlzih771hAX3X2PGzMHh7swO07fjc2tfKidaEidcELXggxS8Vp5D6IOKha0NJpfjOt
	 hZI60LjXYUpbJNTFazAo9hV1DgUQJ1+MQCsR+5Q0Ea96wTxsr3kA5CiOlUgfNilJl4
	 LTGzhEIipVkl+H6lXxVhotjvl2tu2roFttttOBxQ7qGkGJy3MFoIds8fPYXE8yELXU
	 WVDokUTHua+y94sJ5YKvC0mIbdw0qz5ZGw46POMi9MesUvA8KVAlaiM+1qgAXPFAIm
	 DnPFg0W6xywxg==
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
Subject: [PATCH v2 0/2] usercopy: Convert test_user_copy to KUnit test
Date: Mon, 10 Jun 2024 14:33:27 -0700
Message-Id: <20240610213055.it.075-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1403; i=kees@kernel.org; h=from:subject:message-id; bh=XPx0rmN+NH+FmEXC4Z+jCfXaZ8koqHbIlm9JMTURkx8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmZ3EoI9WoPzclRKQH8XMmBe8Ku4Tti3wnvezox 2qv+Nr7LGmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZmdxKAAKCRCJcvTf3G3A JtEbD/0X+ED6dGsrEyB8GE48JR5GcmGeV0tbv7UwZBvf3HUsYmcSkodib03FeGPYJWaQZ1YBNSs kLR7ghAIFqIF21eMaRLRoG822cMUX5wxgw3gaEecJFs6dDRqVMAr7pQ6OJGZ/5RaR5Yg7nzd4bD pqMR3bVLx6pIJerONCx5hvwozJU9WDJszuqUovq7BXA4C5tpl+/b2jAyqb26+MP5uLn7zMksjoe 1oqtB9gZ+Tvi/ZQOA9isG8PMRMbJ/QpNwXBDWz4ftT6iOtokYafyT7NBIshA+O3xYo1yEIvFepk hnhjLGWhATMzIhjTDgWlqrhR5BkbfVgwMT6ID7Gza8JX0LdB+t12H1oz1LMYd3kDWHwap+IrLvo 5h++Bly7efjDvd1G9zt+bZuCMR6qpuMuEQbfBT+VBWt3FQb5qmxREvK0zO3+kUFg9o+36JdItW0 LkprMtPR8SG3GiV2irvnQx830myp+xZOVgDHHTnXKaOUjqPVpurjg/zxhQ/9AQ0/2sX/rF5200a bHD4DYFyH4XiO4fK1suQb9sXFLgHK5Gy+4vAM6Ihlb2qIDZQDMhuVSomf9omNF7VlGhAAlX5zBw enM5LRebfpBNEdrzGujI0UmtWw+QLkhXT2EQ1yc2YEBVocLFycWx3HGO8UREOscv5c+86OYjLQh GoQP6jsqLAafn
 FQ==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

This builds on the proposal[1] from Mark and lets me convert the
existing usercopy selftest to KUnit. Besides adding this basic test to
the KUnit collection, it also opens the door for execve testing (which
depends on having a functional current->mm), and should provide the
basic infrastructure for adding Mark's much more complete usercopy tests.

 v2:
 - dropped "initial VMA", turns out it wasn't needed (Mark)
 - various cleanups in the test itself (Vitor)
 - moved new kunit resource to a separate file (David)
 v1: https://lore.kernel.org/all/20240519190422.work.715-kees@kernel.org/

-Kees

[1] https://lore.kernel.org/lkml/20230321122514.1743889-2-mark.rutland@arm.com/

Kees Cook (2):
  kunit: test: Add vm_mmap() allocation resource manager
  usercopy: Convert test_user_copy to KUnit test

 MAINTAINERS                                |   1 +
 include/kunit/test.h                       |  17 ++
 lib/Kconfig.debug                          |  21 +-
 lib/Makefile                               |   2 +-
 lib/kunit/Makefile                         |   1 +
 lib/kunit/user_alloc.c                     | 111 +++++++++
 lib/{test_user_copy.c => usercopy_kunit.c} | 273 ++++++++++-----------
 7 files changed, 271 insertions(+), 155 deletions(-)
 create mode 100644 lib/kunit/user_alloc.c
 rename lib/{test_user_copy.c => usercopy_kunit.c} (47%)

-- 
2.34.1


