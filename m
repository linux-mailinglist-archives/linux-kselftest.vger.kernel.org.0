Return-Path: <linux-kselftest+bounces-25318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F87BA20EBF
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 17:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC54F1885765
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 16:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27251DE3A4;
	Tue, 28 Jan 2025 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhLWYtv6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE29A1DE3A3
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082354; cv=none; b=nAQjZPLd4L6WJ/uWmB5FqbrThBHZ4oCsQiwP8+Mew934EJD4zi3BUQ1nHztlz107LjBz2Yb3jno4kWxILm0k1Rarb+Kjt/d612L3Qd2qtuh8BaMF4U5xyUZwHton/cFsRWY2ZH8mY3qsU9OZxDet87vnRhKMeDEyCwRQD+XAjtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082354; c=relaxed/simple;
	bh=QSSCrbCHUTi6mmqQy8079+qeB9Q6HjqXahfBctCfGfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=folqWzKoProk7OeEXHy5KGPpUxvO0SAN878E5qm0ZcSOgNnY6Mv3kbZJXkelzHj8+gIn1sGqBToAwc8cgjPU9qlOJB5vUlnGPiz/y+leaijqe0QkmLO8/40zDUn9eo9gfY7PCSBxkOFbKEluYQoVqooEu+vxbJuiHOVglGc22fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VhLWYtv6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738082351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xPqh7tzevPX9P8a6Tkudby8UMfLNbKjPJVuBI0QzHUE=;
	b=VhLWYtv6mOgKs1pGPIaQhu1VH4tN90+Ay+QjfYHxsEGN86iRJxycq3lltSmbpKoMJp27+5
	yzNh76dXNlG/IOq8rdCw9S8VmWVonLabxHfYiI0qEYg/ehr4SQUUu1d8AVjhnv7JpJvtlk
	tSyCWpPeykwk2AJS7RU5Edc396yD7pk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-jHDZR_QFP4W_0og6MO-dQg-1; Tue,
 28 Jan 2025 11:39:09 -0500
X-MC-Unique: jHDZR_QFP4W_0og6MO-dQg-1
X-Mimecast-MFC-AGG-ID: jHDZR_QFP4W_0og6MO-dQg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B02118009E5;
	Tue, 28 Jan 2025 16:39:08 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.225.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 26217180035E;
	Tue, 28 Jan 2025 16:39:05 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Shuah Khan <shuah@kernel.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	linux-bcachefs@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 02/21] bcachefs: bch2_blacklist_entries_gc cleanup
Date: Tue, 28 Jan 2025 17:38:39 +0100
Message-ID: <20250128163859.1883260-3-agruenba@redhat.com>
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

Use an eytzinger0_for_each loop here.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/bcachefs/journal_seq_blacklist.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/bcachefs/journal_seq_blacklist.c b/fs/bcachefs/journal_seq_blacklist.c
index 1f25c111c54c..e463d2d95359 100644
--- a/fs/bcachefs/journal_seq_blacklist.c
+++ b/fs/bcachefs/journal_seq_blacklist.c
@@ -231,15 +231,14 @@ bool bch2_blacklist_entries_gc(struct bch_fs *c)
 	struct journal_seq_blacklist_table *t = c->journal_seq_blacklist_table;
 	BUG_ON(nr != t->nr);
 
-	unsigned i;
-	for (src = bl->start, i = t->nr == 0 ? 0 : eytzinger0_first(t->nr);
-	     src < bl->start + nr;
-	     src++, i = eytzinger0_next(i, nr)) {
+	src = bl->start;
+	eytzinger0_for_each(i, nr) {
 		BUG_ON(t->entries[i].start	!= le64_to_cpu(src->start));
 		BUG_ON(t->entries[i].end	!= le64_to_cpu(src->end));
 
 		if (t->entries[i].dirty || t->entries[i].end >= c->journal.oldest_seq_found_ondisk)
 			*dst++ = *src;
+		src++;
 	}
 
 	unsigned new_nr = dst - bl->start;
-- 
2.48.1


