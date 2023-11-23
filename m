Return-Path: <linux-kselftest+bounces-475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF627F5CC1
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 11:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CABC1C20D3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 10:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C8A21352;
	Thu, 23 Nov 2023 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MA8X9P7Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ECB184C
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 10:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2EFC433C8;
	Thu, 23 Nov 2023 10:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700736360;
	bh=78dMyxfgW9SIkx6hreURfLR8BhPoNmQF6uctLZQkwMs=;
	h=From:Subject:Date:To:Cc:From;
	b=MA8X9P7QDYSDbph9aIkRqqM+rLkpPAPvMiKYCHculd4A46VOIE+ikw70zIHCswVQs
	 GD3HxauUx2b8LGVc6AbElXXzJTvJ7zKUt9tAymHyEkiPOnhvB8bnyo7xwVacH2Ke3v
	 LZJF/KF+qlyX3X3Ql8Twa6T7iOFER/n6xxjpRhFsPz2WQzl2VR7JEYMcmZUFgcmW86
	 Q/+1+BgnqrIxhjldSaqiZradjQvSoOb1OK//n1NOlB6culDwA+n9Xx4VRRWl9PAjub
	 ZLmI8ZupKCYMsyvj4W8LahI0dZZzl3Qqt01/8zAaqVVUkX8M+MkdrOMDZU0AyysxwI
	 +o8vkCY/O6m8w==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/3] kselftest/vDSO: Output formatting cleanups for
 vdso_test_abi
Date: Thu, 23 Nov 2023 10:45:46 +0000
Message-Id: <20231123-kselftest-vdso-test-name-v1-0-1b30441c422b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFotX2UC/x2MwQqDMBAFf0X27EITpRZ/RTyE+FKX1ijZIIXgv
 zd4mznMFFIkgdLYFEo4RWWPVUzbkF9dfINlqU72YTtjrOWP4hsyNPO56M43RbeB+z54P8A8Xfe
 imh8JQX73epqv6w+CfjexagAAAA==
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=909; i=broonie@kernel.org;
 h=from:subject:message-id; bh=78dMyxfgW9SIkx6hreURfLR8BhPoNmQF6uctLZQkwMs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlXy1jEAq8ntpbFqgXxWFiBW/XyxqwjEc+evPP3
 UeJuKhm+2mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZV8tYwAKCRAk1otyXVSH
 0E1oB/9tCnaICuFXbG6wzPPDmRkNVyV/SQUia0MbBW5MKjsmK6HMOAtOXQcZyQYgjVaQ76HH9Oy
 K+LbB8cwwNSYlGaUbzq9FWvZMVv1n8D/v8lBsHTB0BLTMxp6CPLFZv/BnKW2CqlZwamJiYPylfM
 hoxo4DgGpx4Jzu3+WPaMC/l/gSMMiJ2LResSVNf50y6umkZMd8fmH3j6OnfkO6l7MvDWSe9BW5p
 7Z6+ONOncghKdRZM4NQ/Byxu+2mAl35wDKbgBReXtWLmHKQSeXY5QUjwUkux+5+I3nq+A5Bg3Vw
 3adpqhjWAKFfB+di8stp2CWfOV0YQox01Lb/JFHwKYZAOQOs
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

These patches update the output of the vdso_test_abi test program to
bring it into line with expected KTAP usage, the main one being the
first patch which ensures we log distinct test names for each reported
result making it much easier for automated systems to track the status
of the tests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (3):
      kselftest/vDSO: Make test name reporting for vdso_abi_test tooling friendly
      kselftest/vDSO: Fix message formatting for clock_id logging
      kselftest/vDSO: Use ksft_print_msg() rather than printf in vdso_test_abi

 tools/testing/selftests/vDSO/vdso_test_abi.c | 72 +++++++++++++++-------------
 1 file changed, 39 insertions(+), 33 deletions(-)
---
base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
change-id: 20231122-kselftest-vdso-test-name-44fcc7e16a38

Best regards,
-- 
Mark Brown <broonie@kernel.org>


