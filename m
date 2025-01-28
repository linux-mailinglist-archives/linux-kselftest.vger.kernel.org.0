Return-Path: <linux-kselftest+bounces-25317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC17BA20EBE
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 17:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0452E3A5401
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 16:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E332F1DE3A8;
	Tue, 28 Jan 2025 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fUVgdNNE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B21F1DE2DF
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082352; cv=none; b=fqqsFXLX3g8HvnmjoJpS9nFDTNLI7+wOOLzGMBAYZDoUhbURZgSa+E0Hy0BPeumb4u/Do0rGQLBh0nXnj79lHd1W/kBVmcfKAhkVtOyWQmM9qC4lgp/iESvvjj+4cxMGu8dWzQdoNQZzQ77mdbJWFS2VJHiNET/L7wOCsfAUFBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082352; c=relaxed/simple;
	bh=w527x+/NhVUL9yP2qw2Z9aDUTEwaqV205Icu1Yf0vqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIhtlgLyR1rNZBwpVnhUhdfDs7gBq6P8ONlG5neazZS3y+y2Dq0aF09rnVO+T/y+lV+mHD0QHJjeTzSDtQ2oFMsTY3x2TSeULaCXnX6BuYRvfDL9PGzGWVQ85w7JJoaCmqnCgEhNttrow5TgheAltuhqMhvjJBXaAezll6TfIMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fUVgdNNE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738082350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/oRKZspjjnbQgCvlCmKMk/rnifqjvsX5F8ZygRJOO1k=;
	b=fUVgdNNEOCjEUkihszSzBUxVBiAL0QUPbpo/0xjqfRHgUAn9wa6VPhPaY27JNf61JjUjn7
	jErl2yy9ATtfLNWKwWcx5eMQfQerITbzIfkYX+S+PSA+i7ts+piQPgVRJxULifE+3e566w
	qrKTy9R7ZQ4EThFrCNiT2lWqNj9AogQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-E8pEr2SSNi2FMZbt11YTXQ-1; Tue,
 28 Jan 2025 11:39:06 -0500
X-MC-Unique: E8pEr2SSNi2FMZbt11YTXQ-1
X-Mimecast-MFC-AGG-ID: E8pEr2SSNi2FMZbt11YTXQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A29EB19560BB;
	Tue, 28 Jan 2025 16:39:05 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.225.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B8108180035E;
	Tue, 28 Jan 2025 16:39:03 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	linux-bcachefs@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 01/21] bcachefs: remove dead code in is_aligned
Date: Tue, 28 Jan 2025 17:38:38 +0100
Message-ID: <20250128163859.1883260-2-agruenba@redhat.com>
In-Reply-To: <20250128163859.1883260-1-agruenba@redhat.com>
References: <20250128163859.1883260-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This statement does nothing.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/bcachefs/eytzinger.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/bcachefs/eytzinger.c b/fs/bcachefs/eytzinger.c
index 2eaffe37b5e7..c0fdfe909cf2 100644
--- a/fs/bcachefs/eytzinger.c
+++ b/fs/bcachefs/eytzinger.c
@@ -20,7 +20,6 @@ static bool is_aligned(const void *base, size_t size, unsigned char align)
 {
 	unsigned char lsbits = (unsigned char)size;
 
-	(void)base;
 #ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 	lsbits |= (unsigned char)(uintptr_t)base;
 #endif
-- 
2.48.1


