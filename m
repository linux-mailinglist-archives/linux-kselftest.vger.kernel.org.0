Return-Path: <linux-kselftest+bounces-43279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFCCBE187E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 07:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B8A424978
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 05:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077AE23BD1A;
	Thu, 16 Oct 2025 05:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdAVMJ1v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CF2FC0A;
	Thu, 16 Oct 2025 05:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760593372; cv=none; b=FpIEKpuJTauXdWRcnJI9uFdmWpJWDUqZsE6ybJY77NTRSp73HSGZgaGVQQ9WsDgk4f7yzy5rzEZkZk4zDbU4I7i31FBOHbHGTYZ7sYe2UzDcJu1uVrsWDWydunaahYCW3kDPSx3cXHzVTmJdOF1MwniRviATOVzProY8lsZI9Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760593372; c=relaxed/simple;
	bh=LIPgLcnDoKwiJT3fL31O5/TGn+k0lyGm30zywB5UpaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V3ldJ6Hn/PQB22tHH8yZvL1RbHQDTbVFXvKSWjm19iwR5ugSYgtR2WGY+qaaS8kg1sS8F/LVtJH6mk4rrhEkCecFjamjH+0T/qayIVTAvCs3/Ndg+hmdgaszxXgSg7RvodS2AOMcoDaIgSqTMZusxZvf1pXcQhWEM59oYPtSbEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdAVMJ1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C154CC4CEFB;
	Thu, 16 Oct 2025 05:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760593372;
	bh=LIPgLcnDoKwiJT3fL31O5/TGn+k0lyGm30zywB5UpaI=;
	h=From:To:Cc:Subject:Date:From;
	b=YdAVMJ1vVeElNdBHu8jK1la4d3L5qiBX7aqIl+vGhie2FLfVESNYtuEur9/6lCc+P
	 E8rvVtB4DKEgAXq8TcD+tSSas0JtWi86DoYpv0NDuvNzo2M8bgi0aS6NdK/yMOLIuL
	 6oaxpXH2eywY9j6izvqEaUsdRIron/chS6l9DQKoFqr7T2vo8kT+mAF5IXG8XXqQp0
	 6IjQJHNV7GvRDb3yOuSJ+av+VSEpdfwTIWDl+ksWvwcY7MxOIVaoQ7rnVdSUchrAP2
	 XLyhRJl+NZRrJ8Vgt3dCwfnKhFUBj4eDEoPG4kX28Xyoma3Vqod5/Wvk22Bw28xBMC
	 GlrgA163xTvlA==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	tzungbi@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 0/7] platform/chrome: Fix a possible UAF via revocable
Date: Thu, 16 Oct 2025 05:41:57 +0000
Message-ID: <20251016054204.1523139-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up series of [1].  It tries to fix a possible UAF in the
fops of cros_ec_chardev after the underlying protocol device has gone by
using revocable.

The 1st patch introduces the revocable which is an implementation of ideas
from the talk [2].

The 2nd and 3rd patches add test cases for revocable in Kunit and selftest.

The 4th patch converts existing protocol devices to resource providers
of cros_ec_device.

The 5th - 7th are PoC patches for showing the use case of "Replace file
operations" below.

---

I came out with 2 possible usages of revocable.

1. Use primitive APIs

Use the primitive APIs of revocable directly.

The file operations make sure the resources are available when using them.

This is what the series original proposed[3][4].  Even though it has the
finest grain for accessing the resources, it makes the user code verbose.
Per feedback from the community, I'm looking for some subsystem level
helpers so that user code can be simlper.

2. Replace file operations

Replace filp->f_op to revocable-aware warppers.

The warppers make sure the resources are available in the file operations.

The user code needs to provide a callback .try_access() to tell the wrappers
where/how to *save* the pointers of resources.

Known drawback:
- The warppers reserve the resources for all file operations even if they
  might be unused.
- The user code still needs to be revocable-aware.
- The whole file operation becomes a SRCU read-side critical section.  Are
  there any functions can't be called in the critical section?  If there is,
  the file operations may not be awared of that.

See 5th - 7th patches for an example usage.

[1] https://lore.kernel.org/chrome-platform/20250721044456.2736300-6-tzungbi@kernel.org
[2] https://lpc.events/event/17/contributions/1627/
[3] https://lore.kernel.org/chrome-platform/20250912081718.3827390-5-tzungbi@kernel.org/
[4] https://lore.kernel.org/chrome-platform/20250912081718.3827390-6-tzungbi@kernel.org/

v5:
- Rebase onto next-20251015.
- Add more context about the PoC.
- Support multiple revocable providers in the PoC.

v4: https://lore.kernel.org/chrome-platform/20250923075302.591026-1-tzungbi@kernel.org
- Rebase onto next-20250922.
- Remove the 5th patch from v3.
- Add fops replacement PoC in 5th - 7th patches.

v3: https://lore.kernel.org/chrome-platform/20250912081718.3827390-1-tzungbi@kernel.org
- Rebase onto https://lore.kernel.org/chrome-platform/20250828083601.856083-1-tzungbi@kernel.org
  and next-20250912.
- The 4th patch changed accordingly.

v2: https://lore.kernel.org/chrome-platform/20250820081645.847919-1-tzungbi@kernel.org
- Rename "ref_proxy" -> "revocable".
- Add test cases in Kunit and selftest.

v1: https://lore.kernel.org/chrome-platform/20250814091020.1302888-1-tzungbi@kernel.org

Tzung-Bi Shih (7):
  revocable: Revocable resource management
  revocable: Add Kunit test cases
  selftests: revocable: Add kselftest cases
  platform/chrome: Protect cros_ec_device lifecycle with revocable
  revocable: Add fops replacement
  char: misc: Leverage revocable fops replacement
  platform/chrome: cros_ec_chardev: Secure cros_ec_device via revocable

 .../driver-api/driver-model/index.rst         |   1 +
 .../driver-api/driver-model/revocable.rst     |  87 +++++++
 MAINTAINERS                                   |   9 +
 drivers/base/Kconfig                          |   8 +
 drivers/base/Makefile                         |   5 +-
 drivers/base/revocable.c                      | 233 ++++++++++++++++++
 drivers/base/revocable_test.c                 | 110 +++++++++
 drivers/char/misc.c                           |   8 +
 drivers/platform/chrome/cros_ec.c             |   5 +
 drivers/platform/chrome/cros_ec_chardev.c     |  22 +-
 fs/Makefile                                   |   2 +-
 fs/fs_revocable.c                             | 154 ++++++++++++
 include/linux/fs.h                            |   2 +
 include/linux/fs_revocable.h                  |  21 ++
 include/linux/miscdevice.h                    |   4 +
 include/linux/platform_data/cros_ec_proto.h   |   4 +
 include/linux/revocable.h                     |  53 ++++
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/drivers/base/revocable/Makefile |   7 +
 .../drivers/base/revocable/revocable_test.c   | 116 +++++++++
 .../drivers/base/revocable/test-revocable.sh  |  39 +++
 .../base/revocable/test_modules/Makefile      |  10 +
 .../revocable/test_modules/revocable_test.c   | 188 ++++++++++++++
 23 files changed, 1086 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/driver-api/driver-model/revocable.rst
 create mode 100644 drivers/base/revocable.c
 create mode 100644 drivers/base/revocable_test.c
 create mode 100644 fs/fs_revocable.c
 create mode 100644 include/linux/fs_revocable.h
 create mode 100644 include/linux/revocable.h
 create mode 100644 tools/testing/selftests/drivers/base/revocable/Makefile
 create mode 100644 tools/testing/selftests/drivers/base/revocable/revocable_test.c
 create mode 100755 tools/testing/selftests/drivers/base/revocable/test-revocable.sh
 create mode 100644 tools/testing/selftests/drivers/base/revocable/test_modules/Makefile
 create mode 100644 tools/testing/selftests/drivers/base/revocable/test_modules/revocable_test.c

-- 
2.51.0.788.g6d19910ace-goog


