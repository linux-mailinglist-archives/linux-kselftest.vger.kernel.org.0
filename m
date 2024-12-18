Return-Path: <linux-kselftest+bounces-23522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4D99F6CC2
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 18:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C85D188A00B
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 17:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7434C1FBCB5;
	Wed, 18 Dec 2024 17:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqKJ9AMJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADD41F7072
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734544655; cv=none; b=jZn5OS80aNGDYKAzgixBwUxTHxGtG1N5m6Wd5+4f1QtIDu5Gk3T4g4VhsEC5kdF/h2KKp5c4whXlxepc8UNbQo6IZonWAwNEClao/JJ8VKBO4Z268yguRZxDfR3IAhbIjP4dicDl2IwGvzcaeKGfb/rNcYnN9LaSwLyiGnfnVBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734544655; c=relaxed/simple;
	bh=fdB0svn2IykAVnwwywBw2gz//mi+2KF+JcQcZEIPz2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=en1F8yimQis+7d3ZXh9zjEP+0tdrnHVvLFyrye9hOUXCBQsoG21msjPP4//qwYb9xSCI+hVHdlX0IOP6toN0oHQM7En1lgMDjEuFLwrG6ccfPMHcV9DPzXcZeCHSyLgNiqpNx1yY5xuzKE81EnFLVMw0Yc+KJ6+44nlPBHnImgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OqKJ9AMJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734544652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oDVTgihxonMnUGQyldRP1JnTHpETqeFjIwyXoZkQt3M=;
	b=OqKJ9AMJg2RXQfYHNUesdff8VAfZD+9+8HWWl46PtilV/gH8fnTrMMLeTPaoAfXeTcrzsN
	boqbqJXKQIiiqYFeMPl1OpA+dEycwqUmE2gNIBmRotG1bkmbrpZ3ISJPywKEp2sX7OeayA
	9jvzqD069N0EqoZFrZDi1FD1sWD4E+w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-G-cnryS1MnCiJpU55YnotQ-1; Wed,
 18 Dec 2024 12:57:28 -0500
X-MC-Unique: G-cnryS1MnCiJpU55YnotQ-1
X-Mimecast-MFC-AGG-ID: G-cnryS1MnCiJpU55YnotQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA66E1955F34;
	Wed, 18 Dec 2024 17:57:27 +0000 (UTC)
Received: from fedora (unknown [10.43.17.16])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 63D81195608A;
	Wed, 18 Dec 2024 17:57:25 +0000 (UTC)
Received: by fedora (sSMTP sendmail emulation); Wed, 18 Dec 2024 18:57:24 +0100
From: "Jerome Marchand" <jmarchan@redhat.com>
To: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jerome Marchand <jmarchan@redhat.com>
Subject: [PATCH] selftests/bpf: Fix compilation error in get_uprobe_offset()
Date: Wed, 18 Dec 2024 18:57:24 +0100
Message-ID: <20241218175724.578884-1-jmarchan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

In get_uprobe_offset(), the call to procmap_query() use the constant
PROCMAP_QUERY_VMA_EXECUTABLE, even if PROCMAP_QUERY is not defined.

Define PROCMAP_QUERY_VMA_EXECUTABLE when PROCMAP_QUERY isn't.

Fixes: 4e9e07603ecd ("selftests/bpf: make use of PROCMAP_QUERY ioctl if available")
Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
---
 tools/testing/selftests/bpf/trace_helpers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 2d742fdac6b9..51fa29e0e083 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -293,6 +293,9 @@ static int procmap_query(int fd, const void *addr, __u32 query_flags, size_t *st
 	return 0;
 }
 #else
+
+#define PROCMAP_QUERY_VMA_EXECUTABLE 0x04
+
 static int procmap_query(int fd, const void *addr, __u32 query_flags, size_t *start, size_t *offset, int *flags)
 {
 	return -EOPNOTSUPP;
-- 
2.47.1


