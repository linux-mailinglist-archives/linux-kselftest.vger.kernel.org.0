Return-Path: <linux-kselftest+bounces-34592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 427B5AD3AF9
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 16:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2CE418844E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 14:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E4F29ACE5;
	Tue, 10 Jun 2025 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMRb5GfW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6C522E406;
	Tue, 10 Jun 2025 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749565110; cv=none; b=cRWLpgVoyU0Dh4QhRH9a/WupkrSsGuAK1AcOCDSGndT17LOcZ5fu4JGcpTR63Mnijo5a9LyoVAS7CeA+U2u6rMocEGswH9AM9TtQIT/MLqs+Uh/2Q0u5cDYHEC6DS4p2R3xgarS/UyBVG0//r5shyl3s6ipde8h9M19w7gFyGkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749565110; c=relaxed/simple;
	bh=u8FNrxh7KLr6piF5dxxI2H71xzGyVTEMkyEYsDM9G28=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nuhBaW1kmQC+HUeJkvF6LmszXGm1ht2zO7XKx9PVOqyD8yqcOj23t8Wkmo/hBZ0ykNrlSqNrh4VyFaKc2fQ4mT1U66y+crsZa/sHhIqMKxdN8OfnxgqdqCf3VElQsHlc2QpCSx41f8GynF7CJr8K7qGF9cPaaGwNcNeR6/ql4Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMRb5GfW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D228EC4CEEF;
	Tue, 10 Jun 2025 14:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749565110;
	bh=u8FNrxh7KLr6piF5dxxI2H71xzGyVTEMkyEYsDM9G28=;
	h=From:Subject:Date:To:Cc:From;
	b=MMRb5GfWg5GNw4XvU3GHrpx8FM6LQ+qzQDfRrFvQ9oIy91BNFPXoOI2Rnr0Ik6kCU
	 agcIcYQU1G1L9nZ3E9AaEbYVRUGvqCiYV6BBXvlDkBify15EdFHleLYeaGnIWb5YCK
	 087LzXPaVnkZan1VXCm/rBZsWDvNf8D/AE3+SfYiHjCJhHP0QUzj55ZaK4/eaqVAlv
	 nOlk96v5FdZ6F2ZtXqfrU465Ftrg/kf89P7GlT6zttKF+k2FaBgtnYPrpt/62dQ51e
	 fsI+odjIMezhrInp3nWDj9Cw7urUWy7NgByDemRRQXJ6q/i5Z516puiQ2Wri08HD4V
	 LPnMuSsi2NvCA==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/4] selftests/mm: Tweaks to the cow test
Date: Tue, 10 Jun 2025 15:13:53 +0100
Message-Id: <20250610-selftest-mm-cow-tweaks-v1-0-43cd7457500f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKE9SGgC/x3MSwqDQBBF0a1IjVPQHxTMViQDbZ+mSPzQ1agg7
 t3G4Rnce5IiCpTexUkRm6gsc4Z9FRS+7TyCpc8mZ1xpKuNZ8R8SNPE0cVh2Tjvan7KxdR1K613
 nQTleIwY5nnHzua4bXfvzYWgAAAA=
X-Change-ID: 20250603-selftest-mm-cow-tweaks-0199c5132b3e
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=696; i=broonie@kernel.org;
 h=from:subject:message-id; bh=u8FNrxh7KLr6piF5dxxI2H71xzGyVTEMkyEYsDM9G28=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhgwPuw1G1d7aCTrZBpt4X815He+3jVsqxNQtLOuVSe6FkA0T
 ttd2MhqzMDByMciKKbKsfZaxKj1cYuv8R/NfwQxiZQKZwsDFKQATmbWN/b9Hrq/CQ0U93R0q2jZOCw
 q3afowpHn5e1r1+3hYT0y6obpX1qQuk+/g3p6M6/fW5lyd4dG6dr3TylClRpvTsp8k+eVeX2Hh2yNe
 HsRRv8hd8dBH3jdSrI8YOyfx/RH6v/Cx1vY9LwKuHwhIYgxq5Z5amMbTf8Po3U+GaUyzgz+1tObUyF
 om+wqlnyzSfrXZ+JXw7Tlv4xZ33NO6rLhRdKJs3Ny01ZOi9q/LV3q9VuSJ6+tps9aK5eYpPX07b6Pl
 I551nBL+gdMfyfVyXzcSy9ygNlvWT9VXev/qWC4WdvVD//6+qry/Y7HFm8D6dutdBg0sDlyXmL9pV1
 jVb2c53nYiaHbABRu+89ezxb39AA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

A collection of non-functional updates from David Hildenbrand's review.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (4):
      kselftest/mm: Clarify errors for pipe()
      selftests/mm: Convert some cow error reports to ksft_perror()
      selftests/mm: Don't compare return values to in cow
      selftests/mm: Add messages about test errors to the cow tests

 tools/testing/selftests/mm/cow.c | 44 +++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 16 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250603-selftest-mm-cow-tweaks-0199c5132b3e

Best regards,
-- 
Mark Brown <broonie@kernel.org>


