Return-Path: <linux-kselftest+bounces-38249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49439B1A870
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 19:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CC047AFB1E
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 17:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDF328F935;
	Mon,  4 Aug 2025 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="5+i0AKKG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B41828C5B3;
	Mon,  4 Aug 2025 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754327479; cv=none; b=f9ezAIW15FH0y0xHBJjSzI46bsOD3qC9V9hH9Fz7mtcBSWKQZ2MQZEwh9wbP7n/cdE++sv55AgbajWfZvwASsvKldvP1GcMmOiEQq3z15I3V4hlMPqW4j0iv+32JPeEIsoX8nQy7HNPYESf0AijtJ5tmBfmcik7Asp0OxgOZQaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754327479; c=relaxed/simple;
	bh=bqJNZ6FXD7sLTFxxkmnlwyVHFhwMpxAbTIKB2t8vN48=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kIXtEmWf7CZBJkWUugeV0Kx+OslF6j16P0SGvXtJVMDgoyKEtqS37bwDFlZGK8GWjesejQY0nhfJvuT8IH4lCXFi54ypCWYKCv5aCgkC8QngppaAGyig1eRDqq1WetU59fkDdlNAeK5ThKZ0Ku0fdJ3fAGdqb56/lrNm+wwS2V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=5+i0AKKG; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574GRKEK005802;
	Mon, 4 Aug 2025 19:11:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=8oEdtJH0sxcb9TaP1aUhhv
	r5KzVVzj8AyuY0n6doDvY=; b=5+i0AKKGVhWjEk9eGFthY2r5LtchP17Scxok/H
	qjN/4WXzi0h9ElM1skVGJ9YJOT9QAEN2A9g6hnfYUO/5+qp0N3fXxkl0xbcV0bXw
	rDrlFIC/N2RZYGJfJeEVkcCvbMx4NlVIQlWNNfl4usVqS5yeQefbwIgtv/3++c2B
	ilA0BnYfbITg+ZH9GC/tYGhc8LCiwKeuEkiimcaqF3Nq4MTKMCAxtKJw3bx52PQN
	xo6i+gj6xmvkXsi36GhR0FPoyEBODk/k8roVKO9XPk5be2NJdfZQs2JxQQLdxjXp
	Cu/chlUWz1Z47mvdHnmVD7/HgAvITBWSyBGCC+EHRwekt6Vw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48b0d483dh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 19:11:03 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B3ACC4004B;
	Mon,  4 Aug 2025 19:10:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 999B3B74708;
	Mon,  4 Aug 2025 19:09:30 +0200 (CEST)
Received: from localhost (10.130.77.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 19:09:30 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <mani@kernel.org>, <kwilczynski@kernel.org>, <kishon@kernel.org>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <shuah@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Christian Bruel
	<christian.bruel@foss.st.com>
Subject: [PATCH 0/3] Skip IRQ tests if irq legitimately is out of range
Date: Mon, 4 Aug 2025 19:09:13 +0200
Message-ID: <20250804170916.3212221-1-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_07,2025-08-04_01,2025-03-28_01

'pci_endpoint_test' fails for architectures allowing less than 32 MSI
registers and that doesnt support MSI-X, avoid reporting false errors
because of out-of-range irqs.

e.g for an EP configured with 8 msi_interrupts and no msix we can have

 ./pci_endpoint_test -t MSI_TEST

# PASSED: 1 / 1 tests passed.
# 1 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
# Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0

instead of

# FAILED: 0 / 1 tests passed
# Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0

An alternative could have been to implement VARIANTs so that the harness
runs only the supported tests, but that seems quite heavy considering the
huge number of possible interrupts.

Another alternative could also have been to use a new ioctl to get the
allocated number of irqs from the driver, but that doesn't seem to be
more efficient than just using -EINVAL when the
irq is out of range.

thank you for your feedback

Christian Bruel (3):
  misc: pci_endpoint_test: Skip IRQ tests if irq is out of range
  misc: pci_endpoint_test: Cleanup extra 0 initialization
  selftests: pci_endpoint: Skip IRQ test if irq is out of range.

 drivers/misc/pci_endpoint_test.c                   | 14 ++++++--------
 .../selftests/pci_endpoint/pci_endpoint_test.c     |  4 ++++
 2 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.34.1


