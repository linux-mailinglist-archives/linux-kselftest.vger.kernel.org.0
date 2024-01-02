Return-Path: <linux-kselftest+bounces-2595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1CB822582
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 00:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A54284956
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 23:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C636317740;
	Tue,  2 Jan 2024 23:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wbEkI5us"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6426717984
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Jan 2024 23:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbdb8e86842so5640319276.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Jan 2024 15:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704238379; x=1704843179; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OrZsxOCrBJcDQG2F63wPu/oWesILjPUyL8XFF214j9w=;
        b=wbEkI5usZz2egk8Qhs2bsGoyngtDc57V7xwc5++UXaFTqmhNZfVl/lpS9bgoj6SrOu
         gORm049iIi/tbOltRAZtxJUCEsGnt5C2yTKcI5W1ujLeHn+jQgs6rz9bHlYUEil1XFfg
         zCCQbGIuKgdKX4yZ9v6j5nCuHlI9vlVSuvT3ep2ZQE42LpNcaLXATtENyZT+9LihZosF
         TbjE7GhD/hgctEtWUMBKoItVRk1fQscyBoxe6Is9zsB9K5YlF1ZNy/SfX9bFNfu9Q5aA
         xb3uRN6PhK32KEQtbXtbVWXCEQEtrdPz8WJy9cwQMNpkJ1gn4fks7QTe6S2dXKxsHL4j
         G9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704238379; x=1704843179;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OrZsxOCrBJcDQG2F63wPu/oWesILjPUyL8XFF214j9w=;
        b=D9wxqGVcGsVGvVsF3rORBnSyt46jk9iUkGm41gqD+HLkt9rfHrx8L33odTByDtEPlp
         VwHHCIPtQ2dg/VjvuCf+o2/U86rrz21F9C+lMB5TGDNr7qanAa+Sf+OEfJs6QqAAU6/h
         syCXcv+uZ2wCYOQZmzgWz9tgpPcD/kM8Qoz82RDrMi/9RmSrzWFo9Wi6RE47onpeQVWQ
         VrjcgP8zv3tkf9dknCioVs1l5b4k9Tkl+hTKxq9kotG+N+6I6QXQwWEiaXv2bYY7eGhy
         ad2LR+mfpSQOJ9OyNVxNWFWqOkgpVxj4eBf6mMRW/SM9cJP+RKTMrPdbBV/sIUdBuCHz
         kleQ==
X-Gm-Message-State: AOJu0YywRsF8j0DHoTPAkdJNYnbYog7P5bHu0ta4uJpfDsWtonYq8MTX
	Xzmc08JY74rnTtmzRqrMMfYArANX5L7Zh0SxOg==
X-Google-Smtp-Source: AGHT+IEuwPzcUwn85Vv4VXikLgRwT5vcLx1QXyFQo+oOhEISU5egcPovU+KpM8prSGIuu4/6FVFM3vh5OGc=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:7c15:8de:bd73:b2f6])
 (user=surenb job=sendgmr) by 2002:a25:949:0:b0:dbc:1b8a:ea84 with SMTP id
 u9-20020a250949000000b00dbc1b8aea84mr417162ybm.7.1704238379350; Tue, 02 Jan
 2024 15:32:59 -0800 (PST)
Date: Tue,  2 Jan 2024 15:32:56 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240102233256.1077959-1-surenb@google.com>
Subject: [PATCH v2 1/1] userfaultfd: fix move_pages_pte() splitting folio
 under RCU read lock
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org, 
	aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com, 
	david@redhat.com, ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com, 
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org, 
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com, 
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com, 
	jdduke@google.com, surenb@google.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

While testing the split PMD path with lockdep enabled I've got an
"Invalid wait context" error caused by split_huge_page_to_list() trying
to lock anon_vma->rwsem while inside RCU read section. The issues is due
to move_pages_pte() calling split_folio() under RCU read lock. Fix this
by unmapping the PTEs and exiting RCU read section before splitting the
folio and then retrying. The same retry pattern is used when locking the
folio or anon_vma in this function. After splitting the large folio we
unlock and release it because after the split the old folio might not be
the one that contains the src_addr.

Fixes: 94b01c885131 ("userfaultfd: UFFDIO_MOVE uABI")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Changes from v1 [1]:
1. Reset src_folio and src_folio_pte after folio is split, per Peter Xu

[1] https://lore.kernel.org/all/20231230025607.2476912-1-surenb@google.com/

 mm/userfaultfd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 5e718014e671..216ab4c8621f 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1078,9 +1078,18 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 
 		/* at this point we have src_folio locked */
 		if (folio_test_large(src_folio)) {
+			/* split_folio() can block */
+			pte_unmap(&orig_src_pte);
+			pte_unmap(&orig_dst_pte);
+			src_pte = dst_pte = NULL;
 			err = split_folio(src_folio);
 			if (err)
 				goto out;
+			/* have to reacquire the folio after it got split */
+			folio_unlock(src_folio);
+			folio_put(src_folio);
+			src_folio = NULL;
+			goto retry;
 		}
 
 		if (!src_anon_vma) {
-- 
2.43.0.472.g3155946c3a-goog


