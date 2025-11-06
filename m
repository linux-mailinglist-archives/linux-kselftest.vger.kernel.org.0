Return-Path: <linux-kselftest+bounces-44995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 364B9C3C09D
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 16:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9031AA68BD
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 15:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88988275AE3;
	Thu,  6 Nov 2025 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7RbJLvA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A37826C3A5;
	Thu,  6 Nov 2025 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442841; cv=none; b=EvQL1rmnsgya+9TOvADnwkoiTOduM2UVH4/GhwIvKyUcA1wJvzpW1Z35TXoppnab4eRVF0o282CwYnHKSDHaXSVYWE4X3JbGHnYXpoSGxkWulxhOz3BaK25WbyRoOrW0zH7YVQl1KW2iCI1oEpEQim7PWmeN14LJfNYSvtoGKio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442841; c=relaxed/simple;
	bh=olheF5+/7HYlkTMggHyK4GMbLMwpDTKaQpV2K5mNhx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uIN7ryvnJLrowwCOTPKy6PZryL7LJBAnQGsOPrpII3dPoqfqaNwaKmmBn6Zf8OHlUlkWhqKi+jQ1sCOJUeEJTATqa96oaC9R8R1Z9+lAq222K9+Yt7PD/vM6UOj3j5dwCLxvqPG4WKt93gfmChk12ZWwGBvg0stpEJB/O6kylNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7RbJLvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B950BC4CEFB;
	Thu,  6 Nov 2025 15:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762442840;
	bh=olheF5+/7HYlkTMggHyK4GMbLMwpDTKaQpV2K5mNhx0=;
	h=From:To:Cc:Subject:Date:From;
	b=P7RbJLvAXby3M4M6WdSkq/JTcC8s0srojIagLAcPK2W5m5Jdz+n3ZagSHjK6QsKsT
	 5R5BPphAX+DJeTlAB0JtzNWQkmg02+D/+4fu7aC5vFRZP0ZtEVSJbstWuy+3Jn8dMc
	 bbIVu2YYWSdV4V9i9cn1IbVjuhcSQ4L2yJ/oVeBqZHLWTa6fmd5OBUanm64fDHK/a4
	 BuYsXK3ZhRI1Mt3Wq5FI/hj37RbFsB5gnkUp8KV1eGQatB1NVcDu+FrvW1GNJIkUZN
	 4IqY5HE3Abui3onT7Se5GzFZiXkD9tSGqYY89ndYxu/Co9aDfCOTkaDQDu9djRbKaZ
	 TwB+ifXQcCKnQ==
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
Subject: [PATCH v6 0/3] platform/chrome: Fix an UAF via replacing fops
Date: Thu,  6 Nov 2025 23:27:09 +0800
Message-ID: <20251106152712.11850-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series is separated from [1] to show the independency and compare
potential use cases easier.  This use case replaces filp->f_op to
revocable-aware warppers.  It relies on the revocable core part [2].

It tries to fix an UAF in the fops of cros_ec_chardev after the
underlying protocol device has gone by using revocable.

The warppers make sure file operations in drivers won't be called if the
resource has been revoked.

The 1st patch introduces revocable fops replacement.

The 2nd patch supports the fops replacement in miscdevice.

The 3rd patch uses the support from miscdevice to fix the UAF.

[1] https://lore.kernel.org/chrome-platform/20251016054204.1523139-1-tzungbi@kernel.org
[2] https://lore.kernel.org/chrome-platform/20251106152330.11733-1-tzungbi@kernel.org/

v6:
- New, separated from an existing series.

Tzung-Bi Shih (3):
  revocable: Add fops replacement
  char: misc: Leverage revocable fops replacement
  platform/chrome: cros_ec_chardev: Secure cros_ec_device via revocable

 drivers/char/misc.c                       |  18 ++-
 drivers/platform/chrome/cros_ec_chardev.c |   1 +
 fs/Makefile                               |   2 +-
 fs/fs_revocable.c                         | 156 ++++++++++++++++++++++
 include/linux/fs_revocable.h              |  14 ++
 include/linux/miscdevice.h                |   2 +
 6 files changed, 190 insertions(+), 3 deletions(-)
 create mode 100644 fs/fs_revocable.c
 create mode 100644 include/linux/fs_revocable.h

-- 
2.48.1


