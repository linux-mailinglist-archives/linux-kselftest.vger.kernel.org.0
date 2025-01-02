Return-Path: <linux-kselftest+bounces-23813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8B59FF688
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 08:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D057A112D
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 07:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2718192D70;
	Thu,  2 Jan 2025 07:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="WjrOf/B5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64391192D63;
	Thu,  2 Jan 2025 07:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735801207; cv=none; b=UrPf9rJ8/CKBOpoPh7+RgpHo8nUCrSgPr7JDU+JL9q4WXjiiuf5lciVgRpBgl7SVhhUfUIXaoJ3YFkI5HKE1yz+NZTkEaGNNl9XBnW0j7fSrF6zHXKQwslnTwZbfoyJWKRZIv0DNZUyQ8jGJDbUcHoEvh5RrWnALMo4nJTS95VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735801207; c=relaxed/simple;
	bh=iEulqBp06YPe1A+snfV4DzFT5+AwnmIu4JZQM9WDpJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n4ptyCKndLgsHduvIZKYLLq9cYymZmzKSGIQF8WqBqr8D8I8bbLJZvwFSpLcCV8rZTGURBNPwOAJVgetiAljC5GHp5q14Hte1W616wr/eJwc3OWDOfsGISpbcT1zRyzoR7FRi5W+gRYp/E9JfeQFxXqHjNkOxcpxkw6wQPWuUEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=WjrOf/B5; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (2.general.phlin.uk.vpn [10.172.194.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 1860340276;
	Thu,  2 Jan 2025 06:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1735800717;
	bh=OEm3+ENwFw0h7ut6tDeo6HBg4ONfYf8IIeTewODb7eQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=WjrOf/B5YsFEkCoriBrJbPopYZ32V39OzoOVId8WlJFSW1t4j0odr3nR0vP2/nK3Y
	 QOhbR5BmiiBtQan1o3sgVFs3+MBGK7L4W8IdtOBg0vsIz0qf2+fvx3om7lrS6wusl/
	 50xdjp86/QO0KUHg7c/iw6GRm8uJ0Mbb2eJkowKygKDIsFWbT4FH7GDqB/TNAijjBn
	 R2TLRkDCr0stdhyhczTg9inqcRqmAJdP+Nmksia75eUd4QSV+jI7lUXHYcwvRmrisB
	 GDR2JITbU/6Q3WvX/SlpvLgoBk9mNJTtlhAz9bgInuJyDE/3Ie5v3sV/26iYRW5MRa
	 h3WFXI2cGlF1A==
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	po-hsu.lin@canonical.com
Subject: [PATCH 0/1] selftests/memfd: skip hugetlbfs test if it's not supported
Date: Thu,  2 Jan 2025 14:48:06 +0800
Message-Id: <20250102064807.404607-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle the case that hugetlbfs is not supported. To make it easier
for debugging.

On a system that does not support hugetlbfs. There will be no such
HugePages_Free entry in /proc/meminfo. And consequently freepgs will
be empty. The huge pages availability check will fail and the test
will be started anyway:
  ./run_hugetlbfs_test.sh: line 47: [: -lt: unary operator expected
  ./run_hugetlbfs_test.sh: line 60: 12577 Aborted
      (core dumped) ./memfd_test hugetlbfs
  Aborted (core dumped)

Po-Hsu Lin (1):
  selftests/memfd: skip hugetlbfs test if it's not supported

 tools/testing/selftests/memfd/run_hugetlbfs_test.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.34.1


