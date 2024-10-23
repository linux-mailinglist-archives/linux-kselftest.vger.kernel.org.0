Return-Path: <linux-kselftest+bounces-20513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 504109AD5B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 22:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FEE61C21BC9
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 20:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D46200BB0;
	Wed, 23 Oct 2024 20:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxNgiSR+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E0E2003DC;
	Wed, 23 Oct 2024 20:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715993; cv=none; b=q66SfD4Q9aTuHI+jxJEu96RtR5VPQBrTLAqvZym/qR6xlOx4ge8EiKX0DibI5ab3F7PjLWfp/7MTDaH6/V4YOn+MYq35otMIet0WXXujMsxmoYgToFiGX5aIoEa7eRdYLYkdO0SKa0OlZw95g09Ka7aJrejLq5L3JSd7SVvl0bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715993; c=relaxed/simple;
	bh=fVAM10zHyP6GG1K9/Odp1Yp4otIM0+Fw+7dp79I2hf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MOH81p9l4oAEByLHtHN69gNxS+FsMFKgxWRmxIeJ7WEF4k6fD8oo7iO9cxh5vgG/hYS9NCJjtahPj9fXEMj/a7uysCyBvU9xWBtoZn+ZqSldVpd8qBlwlEOuhL8dr+1dMFF3lfXR5zMZf5CsxX/7el3Gfxq656L7FGWS3ozFDe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxNgiSR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839AAC4CECD;
	Wed, 23 Oct 2024 20:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729715993;
	bh=fVAM10zHyP6GG1K9/Odp1Yp4otIM0+Fw+7dp79I2hf8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kxNgiSR+Wp1mt3SId9CP2ql3ho0BI8q99db+wRWSjZ3R/LkgGZpJe81d40QYGrvvd
	 FzRFy9z0nlSJhtigrWi5JJNCGYwhCv/pNJu0RRMwfgJbs3rvjUKbeBmeAcZGeKDd44
	 SLpL0jyCRhQCHGXJA6bSChvSp7A/C7ACk+VfwQUfP6IhA4QiuSqBYHKkHHgcokqmLn
	 WV4M9CVU1D0qBo7LrIq8ebO5cfa0zzRTIckZgiv1KkfW6f3fw2a8qU6VyAnjYqGXzT
	 7nV4EC+vphQGdjcgIdgEN3Gg2mRDWS8xfoSBiP6WrbhJGYmdMW900OU5ygoLXJLmhZ
	 0FohyD/Ua+NdA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 23 Oct 2024 21:38:34 +0100
Subject: [PATCH 6/6] kselftest/arm64: Test signal handler state
 modification in fp-stress
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-arm64-fp-stress-irritator-v1-6-a51af298d449@kernel.org>
References: <20241023-arm64-fp-stress-irritator-v1-0-a51af298d449@kernel.org>
In-Reply-To: <20241023-arm64-fp-stress-irritator-v1-0-a51af298d449@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1298; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fVAM10zHyP6GG1K9/Odp1Yp4otIM0+Fw+7dp79I2hf8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnGV8Kfm83OfpsWup68vNgZGsjfwOxMdRatu9MK/EX
 EdADtWGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZxlfCgAKCRAk1otyXVSH0NdBB/
 4ovaIlGKNe94pSK3mKdh49lKzuMNLJ2f8VGtLwmXBVXGhnglT2HKySG/zPktYrphwp93qyS5YYsieP
 myhszUgkF3kQX80vnQRsEzta0e6Ycs/Q3GhttYo2upy2rIKC8ZV6jCDaLY9XFrJIRk4/B1BtRvlJe3
 dOQGO9MEcDOZ/l59v0sholBFfq+j8jcfk3OUPXQnyNXpKFJymV5+3YZcy53rSRRVCQ22KShEx+P7ju
 Y9bP9QzD6cszgI5i6WM+Ibl7hzFdvjuo/wTlkGBd1Iy+h3h3/W7RnpRt6CHtbpuNIXZBrlnMRj0+cx
 lU2usTwPpNX6XrRhSkWlnQgrE4rBCa
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently in fp-stress we test signal delivery to the test threads by
sending SIGUSR2 which simply counts how many signals are delivered. The
test programs now also all have a SIGUSR1 handler which for the threads
doing userspace testing additionally modifies the floating point register
state in the signal handler, verifying that when we return the saved
register state is restored from the signal context as expected. Switch over
to triggering that to validate that we are restoring as expected.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-stress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index faac24bdefeb9436e2daf20b7250d0ae25ca23a7..3d477249dee0632b662b48582433d39323d18e18 100644
--- a/tools/testing/selftests/arm64/fp/fp-stress.c
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -221,7 +221,7 @@ static void child_output(struct child_data *child, uint32_t events,
 static void child_tickle(struct child_data *child)
 {
 	if (child->output_seen && !child->exited)
-		kill(child->pid, SIGUSR2);
+		kill(child->pid, SIGUSR1);
 }
 
 static void child_stop(struct child_data *child)

-- 
2.39.2


