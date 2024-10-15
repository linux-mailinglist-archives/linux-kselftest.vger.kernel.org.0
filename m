Return-Path: <linux-kselftest+bounces-19767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E8A99F47C
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 19:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44C72840EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 17:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C2A22737B;
	Tue, 15 Oct 2024 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRwj6O7a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1DB212D0A;
	Tue, 15 Oct 2024 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729014865; cv=none; b=FpR/ZcwauabyBeFPzO9uKd/VEjf+raDZrhka0pvko36ZWzt5ZgQBxx40udaEzpfAlBoGPHTZnC0TlLeC+8FIy8kUemDClMU2o669d1m4THOXW0+/DWhHqQL/TQI1slIkYxB3CY+xC4DrMJLSII2H9pNjyt79QqjrD33jl+mejsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729014865; c=relaxed/simple;
	bh=7oF79jn9lmm7ZWBErpi45JOkdTnxIklx6KgFpgZJtWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hhT8xwZKyjFP2k42xK+Ss+Akv5N+LfbzGAvPJhUcHqC4HdaG90JIdiQDqjVGCtJ213f0qxZcWDfL+Ex6Km0Wtdut3f8FmnxwrtIEzEch2CPaWHfPgRGErvNJ3Z/YBKr8HkpPxPWSPGIETzdZqXS561sIbD9gzgWSTjMB2Jqrd74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRwj6O7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A90C4CEC6;
	Tue, 15 Oct 2024 17:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729014865;
	bh=7oF79jn9lmm7ZWBErpi45JOkdTnxIklx6KgFpgZJtWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZRwj6O7az1k0rfe6QUN4UubDGCnxPfRgD/fFV9O7VgOyvZFYeHAmHatrF8iS2c48M
	 HM+HZ3n/9fe5ENK+9k3PjOB51b+jiHU20qYQG04hYhGRJpLLxf4dt/C0KEt9i4vRUK
	 i3Ez5U6z09AFYIGB9vOPBbM8mSMIgGvnpWOoIJnsVzJWeG3RvUAFJlwZ9dGplaiXGS
	 4hyo7A4iwzGUkeq6Pt1SAVXXvWRH4zKaiI9gLAGimKhGYoxVtYcOCTLry+rbQ8sx/d
	 SFBVntz5401F/cpYK0Qm2uvufvwIZpjWtnXsYrBU9/NrLjYEtNmv3rD/ImYBlmhgE0
	 azYvLs6q6ND8w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/7] selftests/damon/config: remove configs for DAMON debugfs interface selftests
Date: Tue, 15 Oct 2024 10:54:08 -0700
Message-Id: <20241015175412.60563-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015175412.60563-1-sj@kernel.org>
References: <20241015175412.60563-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's time to remove DAMON debugfs interface, which has deprecated long
before in February 2023.  Read the cover letter of this patch series for
more details.

Remove configs for selftests of it from DAMON selftests config file, to
prevent unnecessary noises from the tests.

[1] https://lore.kernel.org/20230209192009.7885-1-sj@kernel.org

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/damon/config b/tools/testing/selftests/damon/config
index 0daf38974eb0..a68a9fead5dc 100644
--- a/tools/testing/selftests/damon/config
+++ b/tools/testing/selftests/damon/config
@@ -1,6 +1,5 @@
 CONFIG_DAMON=y
 CONFIG_DAMON_SYSFS=y
-CONFIG_DAMON_DBGFS=y
 CONFIG_DAMON_PADDR=y
 CONFIG_DAMON_VADDR=y
 CONFIG_DAMON_RECLAIM=y
-- 
2.39.5


