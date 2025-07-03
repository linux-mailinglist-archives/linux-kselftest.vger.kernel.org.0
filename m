Return-Path: <linux-kselftest+bounces-36463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED4CAF7D46
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 18:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86CBB7BC127
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC0D2EF66D;
	Thu,  3 Jul 2025 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/Af3uuJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6667119DF4A;
	Thu,  3 Jul 2025 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558766; cv=none; b=qXURDVvbogwuG+PUCb9ek0q3QmETvkl8lYlV/bczd9G36WzBXgD29/+KUhFi6UUGnUvg/CvYwKkHRGahAl6tpnyYm/VpgUOYCKCwnWQRTte8y4vWgLiKdAPostNshNkGI2ILfWfohNK1KJsvlFtjB5XWXv54BVDJl1K2Xbtk6IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558766; c=relaxed/simple;
	bh=jscWpusFJ8+GtruSvYfX4sZd6NM08wNAfoGwbX7hARg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mVS0Z5/qm3Sn3pJKC4itiDegRGAwlERnV/WkGkFEihSJ0c/AjG5Y4U03MhvAU8whxbcNicKYd8p6uBb58LBE2xBIRVJ5MB1OMSQtLuzjK7yooYY/xA5y7MEf7XD11JPk1T6u/W4NCLkcIoA1haU7waeQLNH1pDtf6YZz0LiWD+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/Af3uuJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C7EC4CEE3;
	Thu,  3 Jul 2025 16:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751558766;
	bh=jscWpusFJ8+GtruSvYfX4sZd6NM08wNAfoGwbX7hARg=;
	h=From:Subject:Date:To:Cc:From;
	b=A/Af3uuJ9Rb75VKRKFSZpo60tgELsxvze3GiO+tvgALR45Oc5FnwaW/s3gWVHnHno
	 wtAnMK7Pkra9/9GYykEEyE8V+UhVKgcP7+V4M2CWr1dFcEB5CVRThgoG2K1lZKOGIP
	 JuHT2Sgx4tuhuRZ4rp9yGtzYDfd0NprhQJE3DZBz0Hma+AkkBMWtdAcMlWybx1EXwf
	 i1rB2XIUb8705skRmHvXftKvYcB8wmtO2LUGtO0FtWBCvRdHV8VsYVSZJmz1D/j6gG
	 5CjIkOlGam5P3PrDGrs5MlMX2pPniYTBI8x7oiJFTUZ3GAYPUNqWKyozoY6wp8tjLU
	 KWxeyDdIUnV2g==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 0/4] kselftest/arm64: Add coverage for the interaction
 of vfork() and GCS
Date: Thu, 03 Jul 2025 17:00:14 +0100
Message-Id: <20250703-arm64-gcs-vfork-exit-v3-0-1e9a9d2ddbbe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA+pZmgC/3XNTQ6CMBCG4auYrq0pQ8uPK+9hXFQ6hQalZkoaD
 OHuFtxoosv3S+aZmQUkh4EddzMjjC44P6TI9zvWdHpokTuTmoEAJRRUXNO9kLxtAo/WU89xciO
 XujTaloUCRJZOH4TWTRt7vqTuXBg9PbcvMVvXN1iI+jcYMy74VWsjrKhUKctTjzTg7eCpZasY4
 UPJxB8FklJDLWVubGMr+FKWZXkB/NBjL/8AAAA=
X-Change-ID: 20250528-arm64-gcs-vfork-exit-4a7daf7652ee
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Christian Brauner <brauner@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jscWpusFJ8+GtruSvYfX4sZd6NM08wNAfoGwbX7hARg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoZqpmO/tREkuh6QDv6tS66hUZmiy2srI0RMbDv
 H6NfA3zhpuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaGaqZgAKCRAk1otyXVSH
 0M82B/9IWr8jKeogcUOCsJ29Xy4yksQCrWaixdsv+ivWdPhePEkOF9in+1wur5EfZ+l2qgCdWnn
 8lactjzxDDZuFpkZe0h1SMXCtoObhDKFuM31t8VM6KNYLWabWIlXEMPU5htK8AbqSvo1d++HisJ
 7kLjvw+KTyve9tcNgFDQfngnC1Alzo+W09LmmJgwB7ec08acaKrt4OXMAjVuuhLOxtlsgyMp+7M
 W+u2R9eWldITBx70d4VkUHHNhhItxoeLqKCEowCoV9KBQyaFArUms2R3RkrOzKuN9T/8sGPWKUV
 sjwz9ZOtVwG0eB+L21KEsnsEhxjdV8s50e0yNhmiuEyGEDfM
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

I had cause to look at the vfork() support for GCS and realised that we
don't have any direct test coverage, this series does so by adding
vfork() to nolibc and then using that in basic-gcs to provide some
simple vfork() coverage.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v3:
- Stylistic nits in the GCS vfork() test.
- SPARC has a non-standard vfork() ABI which needs handling.
- Link to v2: https://lore.kernel.org/r/20250610-arm64-gcs-vfork-exit-v2-0-929443dfcf82@kernel.org

Changes in v2:
- Add replacement of ifdef with if defined() in nolibc since the code
  doesn't reflect the coding style.
- Remove check for arch specific vfork().
- Link to v1: https://lore.kernel.org/r/20250609-arm64-gcs-vfork-exit-v1-0-baad0f085747@kernel.org

---
Mark Brown (4):
      tools/nolibc: Replace ifdef with if defined() in sys.h
      tools/nolibc: Provide vfork()
      kselftest/arm64: Add a test for vfork() with GCS
      selftests/nolibc: Add coverage of vfork()

 tools/include/nolibc/arch-sparc.h             | 16 +++++++
 tools/include/nolibc/sys.h                    | 59 ++++++++++++++++++-------
 tools/testing/selftests/arm64/gcs/basic-gcs.c | 63 +++++++++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c  | 23 ++++++++--
 4 files changed, 142 insertions(+), 19 deletions(-)
---
base-commit: 86731a2a651e58953fc949573895f2fa6d456841
change-id: 20250528-arm64-gcs-vfork-exit-4a7daf7652ee

Best regards,
--  
Mark Brown <broonie@kernel.org>


