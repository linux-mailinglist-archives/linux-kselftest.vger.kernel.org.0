Return-Path: <linux-kselftest+bounces-18399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D32987662
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 17:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7078DB23E32
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 15:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864DB14F126;
	Thu, 26 Sep 2024 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PySqf4Kw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C403714A616
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2024 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727364059; cv=none; b=gpkAesR5/bUmRcAh+zx7jnt4MssGMaUxg3HNZ3sBdna2q2kVDsvREBspnTsiL5dGPHgnP6jV8FVjwU64670PLr2ikEnJ2Oeg10zhmigsE+uqdVvu8/IrS5j13pbrUh2f3KpRui2L5ZzFoVrmn+457n2Emo3lqhxKJzmAeQuBH8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727364059; c=relaxed/simple;
	bh=+GJPPD5ZtW/Oi0ZF8Ps9WdAIHQlBgLy6M+P2ozpdJRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I0nTkQvrPpsY4GhwuvRYnF5p/pD/3uphaBFiEE3xyH2qP/WFMe7f0YcKh60Pu7BIR2RdAQ2tThNhi19kIwr7CB7YtKS9SJLDLPWyz3fC60h+Cvmi1Z/1NILyDzl6AC7m5UAe+ETbRxl6Dfvb0s4JDwKoRPz/6e8siCUe3F4Ixuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PySqf4Kw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727364056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=24W2Vy8tMG+bVES5yzO+Q7EW6dw4UyHcoadjZ8DmOEQ=;
	b=PySqf4KwYOoKIab6DXPtelUzTBVHEhSOm2k4UgkXUIPKETWOUiil0vLajuBFd+2npyzsN7
	AqVHc/MLXd8ahwtMxh/tN3b2g4Kf2IDe+YwMromCZnmms28YyAQCikYUUoXRBa/cpZVdBn
	CCEYg3DVaYt6oXazk25c5tNPP9eL02Q=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-QdkgA1axMr2WkSp4sv0ZWQ-1; Thu,
 26 Sep 2024 11:20:51 -0400
X-MC-Unique: QdkgA1axMr2WkSp4sv0ZWQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 571E31944D38;
	Thu, 26 Sep 2024 15:20:50 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.16.71])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1D1151944D16;
	Thu, 26 Sep 2024 15:20:45 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Mario Casquero <mcasquer@redhat.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH v1 0/2] selftests/mm: hugetlb_fault_after_madv improvements
Date: Thu, 26 Sep 2024 17:20:42 +0200
Message-ID: <20240926152044.2205129-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Mario brought to my attention that the hugetlb_fault_after_madv test
is currently always skipped on s390x.

Let's adjust the test to be independent of the default hugetlb page size
and while at it, also improve the test output.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Mario Casquero <mcasquer@redhat.com>
Cc: Breno Leitao <leitao@debian.org>

David Hildenbrand (2):
  selftests/mm: hugetlb_fault_after_madv: use default hguetlb page size
  selftests/mm: hugetlb_fault_after_madv: improve test output

 .../selftests/mm/hugetlb_fault_after_madv.c   | 48 ++++++++++++++++---
 1 file changed, 42 insertions(+), 6 deletions(-)

-- 
2.46.1


