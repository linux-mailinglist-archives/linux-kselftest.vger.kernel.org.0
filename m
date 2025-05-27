Return-Path: <linux-kselftest+bounces-33879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B798EAC52BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 18:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D9253AF1D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 16:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9568127E1C3;
	Tue, 27 May 2025 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ga0EdbsB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2C92CCC0;
	Tue, 27 May 2025 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748362398; cv=none; b=k6gT52nE5fydjUpoUhU5odMvXDxWF8uD3IWhN7HIiLYfUI2ZQp9PJQzGJzatLhtJ/eQLiHnP7Q+Lx0a5hrWLA34AoFjTqu8sFuS5UWT32/4Cegux8kL8Mi8yeRSJJlyXZ1OnAek0goKZcoRQcRbhu5dX8Wiqmy0CaXX+TzheN4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748362398; c=relaxed/simple;
	bh=IcBMxirkEMJCcf5JrNYvZntkt5fOQpVsCyuwtJrNgX8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NuqjeaCkD3Zj5Td2mzwwa3A8ET9572hqmNJAhRPr7aBgV3XACC3z3NVnTmOuugmNXbjSOdHkS7vUGSEfa+kG0s0/mLyjQL1wDSyzoAuU52Xk40OKeSvh5ssOv2UgDnpVO+Yur7xZxYX66EOOEBEnjM2hdEnGMS5Adl3u1R9GzX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ga0EdbsB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7559BC4CEE9;
	Tue, 27 May 2025 16:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748362397;
	bh=IcBMxirkEMJCcf5JrNYvZntkt5fOQpVsCyuwtJrNgX8=;
	h=From:Subject:Date:To:Cc:From;
	b=ga0EdbsBHshXltiBaJBUxOYih6egjCQAJBE1gVeT4DTy5CUIab4yJNxVsEsUx3Lg6
	 JQvzwQ9sHCnRp59PxMxWyOShd6TL7v7TEbqoQUv8n0gEXECzEhh1d19lNgmHumIp3j
	 19aAkt5JghF8WTYCMfq3D2l+ZDO9NE+nJ8E1dAhNwtDfhJig3Z4bziOWe4nxcdogZs
	 iy2+kFT8p3wIfY5zGzZlhyGJ4rwDTzywqco7AJ1CZ1zFzaLMk+puFYAj8MEweF1vvg
	 UI/5ZyBbzOoByS8/SjERpZHkUMkgZwGOThb4T/OM74OyNdPwBz0TKxIX7fKbBSxu+3
	 1fN70OKlKzgvA==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/4] selftests/mm: cow and gup_longterm cleanups
Date: Tue, 27 May 2025 17:04:44 +0100
Message-Id: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJziNWgC/3WNyw6CMBBFf4XM2jF9WDWu/A/DAjsDNCIlHUQN4
 d+tJC5dnpPcc2cQToEFTsUMiacgIfYZzKYA31Z9wxgoMxhlnHJGo3BXjyyj4P2OPj6RmB4Do7X
 kq6uyO+eOkNdD4jq81vKlzNwGGWN6r0eT/tpf0/xtThoVHrT1zKYm2tP5xqnnbhtTA+WyLB+Ob
 nU8vwAAAA==
X-Change-ID: 20250521-selftests-mm-cow-dedupe-33dcab034558
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2000; i=broonie@kernel.org;
 h=from:subject:message-id; bh=IcBMxirkEMJCcf5JrNYvZntkt5fOQpVsCyuwtJrNgX8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoNeSYTfgEVZ8w6cB9jqFXTUNxbBZagS9VFQD8GR9X
 oPqIfkyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaDXkmAAKCRAk1otyXVSH0LtlB/
 9LRN6dVU9hnQM1fYo2dOl7n449s6V8aeALjhlDifkhqyTiKGarwYLDlqWDNrKqofd5HND/Qu/Tq5hy
 ubBBa0hRV5LLnM5rK0A4vsYtncrak8mFqIIfU9l7vHMs75IMZIriXzFifeM/V9DgYgnh2f0PwhiAmt
 U21HzMvvrgKSLFI2pS4+OX94BEhB1inxQf2pXYv3dkUsXPRuObsmIKaiVkh+Rab6obde00rNEZKpn7
 WCGW+qwckZRwO4WseTjHEh5539IRCRVBvFRop1vveU8gvradgqsTFp0f7Wq3SiLYqEIdS77dg/KMTK
 wxh3nd99H9UHRMzpC9wlAUbSc4i+Dw
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The bulk of these changes modify the cow and gup_longterm tests to
report unique and stable names for each test, bringing them into line
with the expectations of tooling that works with kselftest.  The string
reported as a test result is used by tooling to both deduplicate tests
and track tests between test runs, using the same string for multiple
tests or changing the string depending on test result causes problems
for user interfaces and automation such as bisection.

It was suggested that converting to use kselftest_harness.h would be a
good way of addressing this, however that really wants the set of tests
to run to be known at compile time but both test programs dynamically
enumarate the set of huge page sizes the system supports and test each.
Refactoring to handle this would be even more invasive than these
changes which are large but straightforward and repetitive.

A version of the main gup_longterm cleanup was previously sent
separately, this version factors out the helpers for logging the start
of the test since the cow test looks very similar.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Typo fixes.
- Link to v1: https://lore.kernel.org/r/20250522-selftests-mm-cow-dedupe-v1-0-713cee2fdd6d@kernel.org

---
Mark Brown (4):
      selftests/mm: Use standard ksft_finished() in cow and gup_longterm
      selftests/mm: Add helper for logging test start and results
      selftests/mm: Report unique test names for each cow test
      selftests/mm: Fix test result reporting in gup_longterm

 tools/testing/selftests/mm/cow.c          | 340 +++++++++++++++++++-----------
 tools/testing/selftests/mm/gup_longterm.c | 158 ++++++++------
 tools/testing/selftests/mm/vm_util.h      |  20 ++
 3 files changed, 334 insertions(+), 184 deletions(-)
---
base-commit: a5806cd506af5a7c19bcd596e4708b5c464bfd21
change-id: 20250521-selftests-mm-cow-dedupe-33dcab034558

Best regards,
-- 
Mark Brown <broonie@kernel.org>


