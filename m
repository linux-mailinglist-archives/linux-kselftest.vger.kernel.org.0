Return-Path: <linux-kselftest+bounces-34478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07066AD220C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 17:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8CA164948
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 15:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECAD1A841A;
	Mon,  9 Jun 2025 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIuxA6Js"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248A9194094;
	Mon,  9 Jun 2025 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481755; cv=none; b=RybEqH1FW6tVQrUrkeAdLnz3Eadh7ohV7fBOoC7Px6XW+Y2d8huypt43aruFuJ1h4e0b+R2BjP2/S5XkGPhniG9byhwtQMZ+wUBdY9b2lBJcV9ytdc7roUbYQqBzjEhjLs9YIE9e6FUfwlIo+38oyxu/NoTDYb0kHwqms8JC5Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481755; c=relaxed/simple;
	bh=eClMNWML6Y/hLG8/cwfFv+FCtdOhBVyY4h0efWqdOBY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c2Tral7ck2MC9Uqd/WP6jFLLHq/R8HP71419rbRLjrM/IuexvN5/hqRgbmjUZefeptB9xOo+ibOH2w0+w2hDYZQE19bgQKrkkyG9+ZtyDpxPNY8GLbK2RnvVX9x15ynb/gqDzhUJY09GB2uDvF58ERFr19rGiqn1A7jROeb21i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIuxA6Js; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8899C4CEF0;
	Mon,  9 Jun 2025 15:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749481754;
	bh=eClMNWML6Y/hLG8/cwfFv+FCtdOhBVyY4h0efWqdOBY=;
	h=From:Subject:Date:To:Cc:From;
	b=qIuxA6JsKHs5ZsWyGlYTrRi7eNPVuS+mChWpMoal8f0WP6u8MnG9bSdhoO+yTSalI
	 riE83kJ4zX8GSV/mmMVlrwQy4drZbxWPo3J4Jkd6pKzuBSgQT+SacY2XLpuLqtFWan
	 AD2fqrlqQe4jA0D7AUh8rSXci1PoVcTsKv4ishssvAlF1LWUlJ7UL8I3kwk9tzgNxk
	 VyHrOsSE/xmFOHkN+sScStmoJUZ6rUVHhHm+2Vmzzckl0QeKLfDgytFXIN4GT8ozjA
	 75kEKLV0UDL7RXJhqtQD9bzEQehIbcV7+V7GfmUBynLrHX0wVzqmqMNKSe+ylNr/CA
	 hqfLW/4pM9FJw==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] kselftest/arm64: Add coverage for the interaction of
 vfork() and GCS
Date: Mon, 09 Jun 2025 16:08:55 +0100
Message-Id: <20250609-arm64-gcs-vfork-exit-v1-0-baad0f085747@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAj5RmgC/x3MTQqAIBBA4avErBsw0YquEi3ExhqiH8YIIbx70
 vJbvPdCJGGKMFQvCD0c+TwKmroCv7pjIeS5GLTSVlndo5O9Nbj4iE84ZUNKfKNx3exC11pNBCW
 9hAKnfztOOX/Wt8ayZgAAAA==
X-Change-ID: 20250528-arm64-gcs-vfork-exit-4a7daf7652ee
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Christian Brauner <brauner@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=755; i=broonie@kernel.org;
 h=from:subject:message-id; bh=eClMNWML6Y/hLG8/cwfFv+FCtdOhBVyY4h0efWqdOBY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoRvkWgecmvwJzw4HRD4Q2aISRm6dDnAH28UBSuH1d
 anVzhXCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaEb5FgAKCRAk1otyXVSH0HVGB/
 9C8iwAnAzqpZPAUPfvh8yQpJEFixX6V6KPlCHaUeYfnk7PvXWIwngIZcKjWPtm7lfr8+Ys0Lm2ykVy
 /ETfy52WPocHwviAyIlUFHMotpMwuZwdTRIfJsaQ2U5yKbSkguMDo/md3poFQ7yOM3bYgnKqmei/86
 encNkBplGqtIt4yL2fMmJud/nm91/rN/7Uv1suHNliEXvuYtpFyO4R9qTVX9Cz5helbmjPxEPBfWQl
 +OpU5FdMobCKuAWOVSzE4C+TDDbMjz6zUjgQKBkVrKNnQEjRrUe5uqlib2wib0yAuiKA5ic757BSnf
 L0L2gnv+vfjluquq8QRkX/4yNwJx4H
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

I had cause to look at the vfork() support for GCS and realised that we
don't have any direct test coverage, this series does so by adding
vfork() to nolibc and then using that in basic-gcs to provide some
simple vfork() coverage.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      tools/nolibc: Provide vfork()
      kselftest/arm64: Add a test for vfork() with GCS

 tools/include/nolibc/sys.h                    | 29 ++++++++++++
 tools/testing/selftests/arm64/gcs/basic-gcs.c | 63 +++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250528-arm64-gcs-vfork-exit-4a7daf7652ee

Best regards,
-- 
Mark Brown <broonie@kernel.org>


