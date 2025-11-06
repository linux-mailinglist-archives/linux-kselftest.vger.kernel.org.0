Return-Path: <linux-kselftest+bounces-44992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8D8C3C07B
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 16:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E471AA25E5
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 15:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAC9270540;
	Thu,  6 Nov 2025 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8XVxY9S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03A526D4F6;
	Thu,  6 Nov 2025 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442781; cv=none; b=BF/WrRChlDB45AF15tltXACDpQmsKXaWOoDtMIKt9qHF7PgtmhgBU6GiXeqrk6uVtd5/+vfqbx8Jjh+scRMquFyQvHIr1A2uBhTtwY2ktTnWp1NCgR1pOPlguDHEK2ihf8I4eVW2+MrOzq+dzyYYkT/7JXryAOD4f3CM1itgL6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442781; c=relaxed/simple;
	bh=Bg5TNBLbU4fqYCTkqedh59J1G/6Od+ePdvYH6FmWM3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IjKZr7ufDspZX4l2d86hrsMz5Y0Pm0Io5FmPWtGh8lyGJEOC7CXCu6c/Adk6OQRc0RHu7EEwtoUPPl1m23IfcmwWeA6pQXoE1SvtFiDyO15Qvbq6lQVEj+f+GYs2JLUuw81Lkal9BD/jV6e3vcdhfwkxrJoZ+shwar19qysGNTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8XVxY9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEECC4AF09;
	Thu,  6 Nov 2025 15:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762442780;
	bh=Bg5TNBLbU4fqYCTkqedh59J1G/6Od+ePdvYH6FmWM3g=;
	h=From:To:Cc:Subject:Date:From;
	b=S8XVxY9SqNl3msPDUb/ZE+zP68w38SZZjfP9QpfkJm3p07m3KK5gDd2gOZn2WvZiI
	 7EeOSUWIOGef9abRdjNOinbbN98pxLZpj3EX0ARScT5qbEA3OaTh0vwRpqSW8YhuU/
	 5ruOXxifBK714xYcf0tKDYqYPcI99VveWWr8pkQn4qi3qMkwUL/zQHR24LKYE8R+73
	 uEg16afT4O3RXR5bjnnZoKZYzT8T/xN8CPfeJ5ies4pA+/d7T8kR0IJjw2QjRUXtNK
	 2eiHwvHSvpvASClQmfuWRu+575qVrIHzwV0e+X1hqIjZD6oYa8jhz5Ywi9mcqOt0Bg
	 nPl4QFIL1nS9Q==
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
Subject: [PATCH v6 0/2] platform/chrome: Fix an UAF via revocable primitive APIs
Date: Thu,  6 Nov 2025 23:26:00 +0800
Message-ID: <20251106152602.11814-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series is separated from [1] to show the independency and compare
potential use cases easier.  This use case uses the primitive revocable
APIs directly.  It relies on the revocable core part [2].

It tries to fix an UAF in the fops of cros_ec_chardev after the
underlying protocol device has gone by using revocable.

The file operations make sure the resources are available when using them.

Even though it has the finest grain for accessing the resources, it makes
the user code verbose.  Per feedback from the community, I'm looking for
some subsystem level helpers so that user code can be simlper.

The 1st patch converts existing protocol devices to resource providers
of cros_ec_device.

The 2nd patch converts cros_ec_chardev to a resource consumer of
cros_ec_device to fix the UAF.

[1] https://lore.kernel.org/chrome-platform/20251016054204.1523139-1-tzungbi@kernel.org
[2] https://lore.kernel.org/chrome-platform/20251106152330.11733-1-tzungbi@kernel.org/

v6:
- New, separated from an existing series.

Tzung-Bi Shih (2):
  platform/chrome: Protect cros_ec_device lifecycle with revocable
  platform/chrome: cros_ec_chardev: Consume cros_ec_device via revocable

 drivers/platform/chrome/cros_ec.c           |  5 ++
 drivers/platform/chrome/cros_ec_chardev.c   | 71 ++++++++++++++++-----
 include/linux/platform_data/cros_ec_proto.h |  4 ++
 3 files changed, 65 insertions(+), 15 deletions(-)

-- 
2.48.1


