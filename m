Return-Path: <linux-kselftest+bounces-33015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE81AB7C67
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 05:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B08A8634C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 03:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B08629346C;
	Thu, 15 May 2025 03:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+Vtrpjl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF9314A4DF
	for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 03:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747280438; cv=none; b=A0SZxwJi++Lllryb4j0aN5dqjBYpHtu7AiXZbBGZc0AVqGg9tnjBlgXqFTdtjw2qj6wiadxUYqJOhF2wv6S1jLdNNUzrsg9/eQlJicqonQboQRbFbG9akD1rhLaIFzy57E6BygGXvvRL1+zezw8UeavlGu+2fasGbnbra7qvzTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747280438; c=relaxed/simple;
	bh=ojvYh32c7Hy4vJTBL+DkaUPpFW/+kSsAeaxM9iD4T7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXwh9pk3gjvWCjB9pjj7wmpEgJkZbFFDpmSINyqGxlqaPF5cTIJse0qDbjPFwipjf44HWSvTL3782Tqde4OJl35tJJlvptB5PhwhVbdeZ2zaOeSXXHPNgxhd1jg5CFUN0jw+fJ8MYlj0kHjVwRVFRjlb0HFKeuaMntke10o3Aok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+Vtrpjl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747280435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5OpOeDWkKDKT63sqe7Ct3ueIe83ZxEVQ2GdgfA8/ZAk=;
	b=i+VtrpjlgJHzo3Ec4V/w4Xflz80OjcErPlrICrXN4lcgPnj5OKO10ugiEcygHAF372aqfQ
	+N92An2FgdqWbunheGkT9vH5XAlyQO001BZOI178ArSQHr0beJX8FYnB/ZTO3IiFWKbllr
	NRhNLb9JV4XC47MjgcmY2aOwRiRe7D8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-PfgWC-tvPuGK-zi7d_D3Vw-1; Wed,
 14 May 2025 23:40:32 -0400
X-MC-Unique: PfgWC-tvPuGK-zi7d_D3Vw-1
X-Mimecast-MFC-AGG-ID: PfgWC-tvPuGK-zi7d_D3Vw_1747280427
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13C401956046;
	Thu, 15 May 2025 03:40:27 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.116])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6EC2A1955F24;
	Thu, 15 May 2025 03:40:11 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: rientjes@google.com,
	hannes@cmpxchg.org,
	lorenzo.stoakes@oracle.com,
	rdunlap@infradead.org,
	mhocko@suse.com,
	Liam.Howlett@oracle.com,
	zokeefe@google.com,
	surenb@google.com,
	jglisse@google.com,
	cl@gentwo.org,
	jack@suse.cz,
	dave.hansen@linux.intel.com,
	will@kernel.org,
	tiwai@suse.de,
	catalin.marinas@arm.com,
	anshuman.khandual@arm.com,
	dev.jain@arm.com,
	raquini@redhat.com,
	aarcange@redhat.com,
	kirill.shutemov@linux.intel.com,
	yang@os.amperecomputing.com,
	thomas.hellstrom@linux.intel.com,
	vishal.moola@gmail.com,
	sunnanyong@huawei.com,
	usamaarif642@gmail.com,
	wangkefeng.wang@huawei.com,
	ziy@nvidia.com,
	shuah@kernel.org,
	peterx@redhat.com,
	willy@infradead.org,
	ryan.roberts@arm.com,
	baolin.wang@linux.alibaba.com,
	baohua@kernel.org,
	david@redhat.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	corbet@lwn.net,
	akpm@linux-foundation.org,
	npache@redhat.com
Subject: [PATCH v6 4/4] selftests: mm: add defer to thp setting parser
Date: Wed, 14 May 2025 21:38:57 -0600
Message-ID: <20250515033857.132535-5-npache@redhat.com>
In-Reply-To: <20250515033857.132535-1-npache@redhat.com>
References: <20250515033857.132535-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

add the defer setting to the selftests library for reading thp settings.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 tools/testing/selftests/mm/thp_settings.c | 1 +
 tools/testing/selftests/mm/thp_settings.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/mm/thp_settings.c b/tools/testing/selftests/mm/thp_settings.c
index ad872af1c81a..b2f9f62b302a 100644
--- a/tools/testing/selftests/mm/thp_settings.c
+++ b/tools/testing/selftests/mm/thp_settings.c
@@ -20,6 +20,7 @@ static const char * const thp_enabled_strings[] = {
 	"always",
 	"inherit",
 	"madvise",
+	"defer",
 	NULL
 };
 
diff --git a/tools/testing/selftests/mm/thp_settings.h b/tools/testing/selftests/mm/thp_settings.h
index fc131d23d593..0d52e6d4f754 100644
--- a/tools/testing/selftests/mm/thp_settings.h
+++ b/tools/testing/selftests/mm/thp_settings.h
@@ -11,6 +11,7 @@ enum thp_enabled {
 	THP_ALWAYS,
 	THP_INHERIT,
 	THP_MADVISE,
+	THP_DEFER,
 };
 
 enum thp_defrag {
-- 
2.49.0


