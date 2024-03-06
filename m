Return-Path: <linux-kselftest+bounces-6008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8440C87404B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 20:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31CA11F274B0
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 19:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8D513F004;
	Wed,  6 Mar 2024 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mngTw9HN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02081487AE;
	Wed,  6 Mar 2024 19:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709752897; cv=none; b=TcTjFECy3jZaDpxdMCkC2SpkWFfQ7bWkof14XKgbRSadaBkz/D5Lp4gco+pUm4Egy4jB6cfk/TVqj2WbDpugcJy1cxMTwGzHB+sDn34TJRspjs7SlovmPKo4vJBKf4HkhAn3adNKZcixLB/l5/hPobw34Jf5HvMjQ5XJu1VSZ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709752897; c=relaxed/simple;
	bh=THy+DO613wqEYRG+KJf/y8DpdmpYj0GtgL/Kwzh6GnU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=axCuizGl2Y5O1WaZ0KQI1322jN+jBpz8lFxjGgjmnI3nmriY9qbiZrgTAOCSusulR1BaE5wbzNrIYa0uVKvn5oxLCZfH28WP3Pd2qFPadTxlfzIGuo2B54/UzQS1QJeuXc448KdTM0l1iruRRCS2LzhNd+ymogMBUP9IstN2VqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mngTw9HN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3910C433C7;
	Wed,  6 Mar 2024 19:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709752896;
	bh=THy+DO613wqEYRG+KJf/y8DpdmpYj0GtgL/Kwzh6GnU=;
	h=From:Subject:Date:To:Cc:From;
	b=mngTw9HNtUjAOosLrwhKwOOxeGwVukXqq3hzRRdWi5/qDKxR6j8lQeddaJl01Evjz
	 cBFlSTGSizpC74Z2AFdzq9a3YisIge+qWEHYwQIOqUwqmH4LNXzMR33XHm3vcm1hVo
	 wi211AEhtw8hJky7ldzQ5FqiEjyYE1stjWi7AH454r2Qt3uRB9DBWq4EgbL3iYbk6O
	 S+nBVXR2ingPqtsfqXi4sgfU0qXKkIXSmnPEfZEqdDjdsuzSQ+2NKyvfNrv/DRQdPz
	 rG+6qdqpY+4IM+VSDt5ZTF3D6EbBBDkOoGNEwxHx9AMZpQJ/3ZVfMlQHHzwRv8PoEp
	 j9P77mt4go0Zw==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] kselftest/tty: Improve integration with automated
 systems
Date: Wed, 06 Mar 2024 19:21:24 +0000
Message-Id: <20240306-kselftest-tty-tname-v1-0-33505b31629e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADXC6GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYwNT3ezi1Jy0ktTiEt2SkkrdkrzE3FRdUxNDQxMTk+RUA2NzJaDOgqL
 UtMwKsKnRsbW1ABhzMCRlAAAA
To: Shuah Khan <shuah@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Michal Sekletar <msekleta@redhat.com>, linux-serial@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=983; i=broonie@kernel.org;
 h=from:subject:message-id; bh=THy+DO613wqEYRG+KJf/y8DpdmpYj0GtgL/Kwzh6GnU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBl6MI7SurFqoe74AEaRPeVCVLp6UWj2UQzcqcp9DdI
 Kb8qBl2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZejCOwAKCRAk1otyXVSH0DI1B/
 429b8kDiGDVUkT9tP0R52d1y4YXEr+3BN4nX3s8kiHpeH/BrDfxNgwfb+jPLcfjOtHTBBbGaR/S2h7
 7Iw793xdfEtecrO4dzPhrDdFYHDlRT2L0we90pFkoP+j4d70+LL8PGRcXLqSIvIez7wj0TRFYMhRWD
 fTnfDkTpa5c4kNIQXQ3WpAmsqCfORpCaY1pXD9m7iDJaCtf08cOh2/M/PsQH4mfeM+AfPVdaKwm8GY
 6Dn2JJQ5p7H1N7cOsSW2WSeIGgYMqGEWipkuFXpt4FiL6NDxhHNn5IBO76XSweJb5xdg4+11iEdBQN
 GLejzlnOv6upSxNVOv8cDpxFCCQAQy
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

This cleans up the output of the tty_tstamp_update selftest to play a
bit more nicely with automated systems parsing the test output.

To do this I've also added a new helper ksft_test_result() which takes a
KSFT_ code as a report, this is something I've wanted on other occasions
but restructured things to avoid needing it.  This time I figured I'd
just add it since it keeps coming up.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      kselftest: Add mechanism for reporting a KSFT_ result code
      kselftest/tty: Report a consistent test name for the one test we run

 tools/testing/selftests/kselftest.h             | 22 ++++++++++++
 tools/testing/selftests/tty/tty_tstamp_update.c | 48 +++++++++++++++++--------
 2 files changed, 55 insertions(+), 15 deletions(-)
---
base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
change-id: 20240305-kselftest-tty-tname-5411444ce037

Best regards,
-- 
Mark Brown <broonie@kernel.org>


