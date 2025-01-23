Return-Path: <linux-kselftest+bounces-24981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0EAA19F22
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 08:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75920188A7F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 07:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EF420C013;
	Thu, 23 Jan 2025 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="M6HLJaOM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A3B201100;
	Thu, 23 Jan 2025 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737617926; cv=none; b=jb9ELQtZ8BKx+tg+tr6g1ZJCTJlIRSQg6tAXVUR6ns063n5nIomR5rbRiaDDbYZ+MGvb5PGpE0nLx18TAioOdpR6lsV3Pp9L4pwbC+kguYdU+E1baYP2xH9syMKsG9oFXezMxTMawdYjP7FVjHaoKpVw6OoDQA/vqdrlRFJfATk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737617926; c=relaxed/simple;
	bh=BDZSegwL8V6HPgs4dSD3q/X+eWbMIZMmdPM0w5xABVU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Hqtbf6b9FtIpqlZSTAcX7sOUtZesl9V0f1ZcM/g0Ic3veqfh6E25ZfK7KbC9+ciwqhrJJQRu9LW9d3NPFOYg1UKfE2JspoxEDeykLzidf4sJcSrORDANtUzVxTfvDCOYreVBHyFsG+G8QPHHxwxyHIA3EqXiUvu78yNtlnB73F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=M6HLJaOM; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737617921;
	bh=BDZSegwL8V6HPgs4dSD3q/X+eWbMIZMmdPM0w5xABVU=;
	h=From:Subject:Date:To:Cc:From;
	b=M6HLJaOMSviyRYcbo6jPbOukuFOrpqmhkoe/hk5XJkz9dZbwfglVjOQyweumNDQDq
	 WFvST3gwouCWe4QIpkMX4sy87RrLKQwA9bJ+6cJs3zCudGPhZNEUqnkJwQG5umLVMq
	 X+C+m3+AZxtoWoXxM0Zotw+7lT3LWUI/FaVvXoZ0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/5] selftests/nolibc: test kernel configuration
 cleanups
Date: Thu, 23 Jan 2025 08:37:36 +0100
Message-Id: <20250123-nolibc-config-v2-0-5701c35995d6@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMDxkWcC/3XMQQ7CIBCF4as0sxZTqKK48h6mi0KnZRIDhqmoa
 bi72L3L/yXvW4ExETJcmhUSZmKKoYbaNeD8EGYUNNYG1apjK5USId7JOuFimGgWo+4MSi2VMx3
 UzyPhRO/Nu/W1PfES02fjs/yt/6QsRSsGbU6jNfpsD+b6QmJm559+H3CBvpTyBQnWSQmvAAAA
X-Change-ID: 20250122-nolibc-config-d639e1612c93
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737617921; l=1026;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=BDZSegwL8V6HPgs4dSD3q/X+eWbMIZMmdPM0w5xABVU=;
 b=TujjqVDz7mHVuxqA5RPae4m2fBZy/hxD+vuNrmOKa4LTGpf6e4jg1JU01/ANg5UpTGpUVrUmi
 V5wStvw0hKYCjBI/NZyrxtUFEgF/Rw2eLEddap8xq+d0JZiya3bKcrm
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

A few cleanups and optimizations for the management of the kernel
configuration.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Rebase on current torvalds/master
- Call "make defconfig" separately
- Link to v1: https://lore.kernel.org/r/20250122-nolibc-config-v1-0-a697db968b49@weissschuh.net

---
Thomas Weißschuh (5):
      selftests/nolibc: drop custom EXTRACONFIG functionality
      selftests/nolibc: drop call to prepare target
      selftests/nolibc: drop call to mrproper target
      selftests/nolibc: execute defconfig before other targets
      selftests/nolibc: always keep test kernel configuration up to date

 tools/testing/selftests/nolibc/Makefile     | 17 +++++------------
 tools/testing/selftests/nolibc/run-tests.sh |  7 +++----
 2 files changed, 8 insertions(+), 16 deletions(-)
---
base-commit: 21266b8df5224c4f677acf9f353eecc9094731f0
change-id: 20250122-nolibc-config-d639e1612c93

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


