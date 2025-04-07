Return-Path: <linux-kselftest+bounces-30268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C78A7E699
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 18:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03C2443A50
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 16:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB1E20A5DE;
	Mon,  7 Apr 2025 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z9J0fhCp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F132066C0
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Apr 2025 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043014; cv=none; b=NpPk5MjXCoBVn6Lcq/Rxy/NZB+wicPOHWs7I8Ubva42uNcPy6Z53LjCAuaoxjPBIA0T+nqYcrKZ+1E28Uk+Diosh7uWn3jd58GDHN22wJVSlMX/rfV1RtGuBgwnxgjBCC6H22eb7kDMKjbkxOZsN0mYmDWO9XY+1SuCjHythhRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043014; c=relaxed/simple;
	bh=4BP9GWoYi7KUXI9KxaFtFbIG5JP+yhsfPJmiQgdFs8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GhvV38PZbM2m1mlDiz3NikILOkm44oWPnWB5QouHoBLGIwghZuNtG3CvEX8b7LahsB4+RMdi7CuvXrcaerjH4GBVg3fSJDajPUUoeK95XFWJ28pDGHKXHuMkVKil9Q4Z3WfBEFhOSd7r/2Vdoe+BN3n32KT9leTHmfapZGmOhv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z9J0fhCp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744043010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sHkVYaexMET2kVqCTXNoyYGk6gyC8HQIAaeFmdUzouU=;
	b=Z9J0fhCpVun6+vYiEFE/0woSeR0Ya+5OQ8NwcYMrgfQ4kcjmFGTYriLPrwq+Kahrv1tAnU
	9QRcEDnbOO/kwtc+VggqXSHPz3jZSn6YSTwYJYk7PuwGk+gmnFSqA7DwslJ/VrQSbC7b6r
	rijUeWrXxEsEvtI6GTy1UqegJ6hO1UA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-nAIU25_JPsS9A9dM_bD6Cw-1; Mon,
 07 Apr 2025 12:23:27 -0400
X-MC-Unique: nAIU25_JPsS9A9dM_bD6Cw-1
X-Mimecast-MFC-AGG-ID: nAIU25_JPsS9A9dM_bD6Cw_1744043005
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC02C19560B8;
	Mon,  7 Apr 2025 16:23:24 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.90.98])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A6F7180175B;
	Mon,  7 Apr 2025 16:23:21 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v5 0/2] memcg: Fix test_memcg_min/low test failures
Date: Mon,  7 Apr 2025 12:23:14 -0400
Message-ID: <20250407162316.1434714-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

v5:
 - Use mem_cgroup_usage() as originally suggested by Johannes.

v4:
 - Add "#ifdef CONFIG_MEMCG" directives around shrink_node_memcgs() to
   avoid compilation problem with !CONFIG_MEMCG configs.

The test_memcontrol selftest consistently fails its test_memcg_low
sub-test and sporadically fails its test_memcg_min sub-test. This
patchset fixes the test_memcg_min and test_memcg_low failures by
skipping the !usage case in shrink_node_memcgs() and adjust the
test_memcontrol selftest to fix other causes of the test failures.

Waiman Long (2):
  mm/vmscan: Skip memcg with !usage in shrink_node_memcgs()
  selftests: memcg: Increase error tolerance of child memory.current
    check in test_memcg_protection()

 mm/internal.h                                    |  9 +++++++++
 mm/memcontrol-v1.h                               |  2 --
 mm/vmscan.c                                      |  4 ++++
 tools/testing/selftests/cgroup/test_memcontrol.c | 11 ++++++++---
 4 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.48.1


