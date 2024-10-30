Return-Path: <linux-kselftest+bounces-21059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA839B5824
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 01:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AD6B1C25D7C
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 00:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2800410A1E;
	Wed, 30 Oct 2024 00:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGabhJiW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EE6F4E2;
	Wed, 30 Oct 2024 00:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730246537; cv=none; b=irFPPWEciMZsdq5rQ8vb6DgO5I32/5YUVhaOcVmX6D0x5jf8mmXQZ0/cGsD0JC8Xhzr1G1KKkjoqrSm72eihJjUISKo6+k2g6R1atoXJSrViFU5dQmmDlZRes3WgtW9w+Y32u9lgdS6Kc1uhVskl+NZFe7ncZGvmP/YaTQQISrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730246537; c=relaxed/simple;
	bh=vfX4nbW4kowy7IUtSJ8IaSqrtLKsP7rLoMKjBgXuBGg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Nq9nG/j4Y8OEQfHiZrdHHQHimqsNAPlk4HxDnIABTb53fgQUbCFRoqjv5pXApzmaXx9umrT+FyMZ2oQkWUcPVzfmoMp6w15D+xSS3xirpyxiPA85z/MqNJ9hObrcPgawRUW8ktc6zilX54xvt+EzpVWH7A+w6T1p6qDuzenVGgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGabhJiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42770C4CEE3;
	Wed, 30 Oct 2024 00:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730246536;
	bh=vfX4nbW4kowy7IUtSJ8IaSqrtLKsP7rLoMKjBgXuBGg=;
	h=From:Subject:Date:To:Cc:From;
	b=mGabhJiWp2yr+cfAuEkEMIOVXMD5r3xovvjDIeNhn2eh4AAkJ+KYxmHZyWeACZht5
	 Ifa9eu7Upu+sKHSZZuWA61YaufGHR6uQNQUS0kyV3ZfHSYxlrvL3Ap29Q4+3krw5MT
	 9RRYadhEJN5Np2L/AwPGTxgSWzdbNChzWY6UriSLzKyccTll2qblJINT5Hn4Ut3qxG
	 000XFXC6Tq9wKElRGX3Yv9xxHtW8cJb/gjHXAA+xsAg+P3FsxN8QXdNx0yyNw/h6ez
	 tN8Ly/AFCV3Y0PsJi3JVov580ZoWc1oxA1S2zdnT6R2ko+X9+GGTWh9Ui1CX9X7wpt
	 G0QzO27WicusQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/2] kselftest/arm64: fp-stress signal delivery interval
 improvements
Date: Wed, 30 Oct 2024 00:02:01 +0000
Message-Id: <20241030-arm64-fp-stress-interval-v2-0-bd3cef48c22c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHl3IWcC/3WNQQqDMBBFryJZd0oSNNiueo/iIpqJDrVRJiG0i
 HdvKnTZ5Xvw399ERCaM4lptgjFTpCUU0KdKDJMNIwK5wkJLXSupW7D8NDX4FWJijBEoJORsZ2h
 9g0YP0qDSosxXRk+vI33vCk8U08Lv4ymrr/1FL/+jWYEE1ze1tL03zjW3B3LA+bzwKLp93z/OA
 AytwQAAAA==
X-Change-ID: 20241028-arm64-fp-stress-interval-8f5e62c06e12
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1244; i=broonie@kernel.org;
 h=from:subject:message-id; bh=vfX4nbW4kowy7IUtSJ8IaSqrtLKsP7rLoMKjBgXuBGg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnIXeEQX3ZnpyxHhcbEA+5T7ZncKjnsWPSGQng27oY
 QhNxq8yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyF3hAAKCRAk1otyXVSH0JTxB/
 9GTxbnEKrWGh2epcF+v4WIllG00TQeqlIs6DOZ7YsmXiF6C2wQ8+A11TnS+xsQin8dNyb4Dy5dhAc9
 HTq0yXhY9o96J4qY6cZ7EojkCXuPp5j0V8c1BfbV9hp/pfH6RFkpEev5//vbh+1uqpU2ANqV627Byv
 xIcQ9Q69xjWf+y9SXduHqnVRRZmejm54CAaSY15zgZfQejQDaGDeeqLrTtk5vawxvWZca4NvtoydFM
 1UD6Zwcr+Fa1dQuzkywYFK4ONqDJ7Z5/AihGQbRIRqE4YbY4zjrrSpoBuM/+08UYanz9b4zAt5ud/2
 EOKnq45ZKuAuirtIG9bsRMiKhG8I4/
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

One of the things that fp-stress does to stress the floating point
context switching is send signals to the test threads it spawns.
Currently we do this once per second but as suggested by Mark Rutland if
we increase this we can improve the chances of triggering any issues
with context switching the signal handling code.  Do a quick change to 
increase the rate of signal delivery, trying to avoid excessive impact
on emulated platforms, and a further change to mitigate the impact that
this creates during startup.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Minor clarifications in commit message and log output.
- Link to v1: https://lore.kernel.org/r/20241029-arm64-fp-stress-interval-v1-0-db540abf6dd5@kernel.org

---
Mark Brown (2):
      kselftest/arm64: Increase frequency of signal delivery in fp-stress
      kselftest/arm64: Poll less often while waiting for fp-stress children

 tools/testing/selftests/arm64/fp/fp-stress.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)
---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241028-arm64-fp-stress-interval-8f5e62c06e12

Best regards,
-- 
Mark Brown <broonie@kernel.org>


