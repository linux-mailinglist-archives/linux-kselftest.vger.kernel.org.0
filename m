Return-Path: <linux-kselftest+bounces-41062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B070B505DD
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 21:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BEA33BD644
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 19:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9682E3019D0;
	Tue,  9 Sep 2025 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rQkYepwX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320FD2F747B
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Sep 2025 19:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444743; cv=none; b=LKiNBt8loTlSLzlTdrVUiUDT+vG7CdO7Opnffpnox0wai4EceUAFbuWkadNmm/Ub2hAfhoa4iElSoEWWeqwj6SqjCffB66Cs5DLvrFKeEIxKsn4RvXYudIWHdddfsCExZ/0z9VFHyfR6/xnPbDJC1DNamN/ui4mpUfEKALb2fLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444743; c=relaxed/simple;
	bh=09167jgEIy8C4gbDQAAmkBnRs9OtDp05EZlsYi3qh24=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gPSE/tbU10fsrodUAt8yYIUCSMk8FCRm3svsZdtglvY6U0AOYvZbTTzsg7Ho9mFG5fU0tq836J3aSBLPx+GMLjzDmQiqWsJXsfVd2PgxWZJVoprEJao/cYPUOUtqiPQqLw43+T9exO3lxIIGkgOKa0WuOmEBRwiMFShVge5nR/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zokeefe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rQkYepwX; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zokeefe.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-244581953b8so68467155ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Sep 2025 12:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757444741; x=1758049541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FdPX30UzJgvc8rb2FS3LAFal5bl/d6KCBhdWDQJQT7U=;
        b=rQkYepwXahw+Zc8/589OFAkiWlCHnylPudloO4VHePCYic1qvjpt3SQIT6FVvz/uxE
         8txIhP39M6yqBqIxP8X9JYPfqIIhH9xI+zLDp6qmDQItVQxV1iGZR3d5i1B/pVHB9hqH
         CYuITLLYaB7Jqlzk4ZlE7JN0aLl42Wl85HprVBgnhZUx83MfyiPkwwk6+HmEwvV3xiS4
         QizUTxk8MRDnDS3/G7V35Ihn7UuEOD5jDl5X+S7JJ6PolabgvPdUN6c3VFa5XnLRoIAL
         tMW1JN2ZBa7Bn/BVf7IIcwb9MOIlxDCHBPS87ZrPx4OlE16cAMJVt9qnerhmj0higBao
         vXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757444741; x=1758049541;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FdPX30UzJgvc8rb2FS3LAFal5bl/d6KCBhdWDQJQT7U=;
        b=eWIpQwFWNhcu0oiPfCy93GpyEH6vtPofT+cJAv5luIL/PhgjpyHrFJ79tkL2qbhFYZ
         7yixSl4gu/vBTOUg5OSYPGjgynO+XuDkPvQnRd+rPHGW4fKoPDP45e785NKqRp/pBUUx
         ZDHxZKKt5GVlVcfDbQz34jXKLGLws0Yw6GFUEZvjrLPEegrCtkB5bHmyeH0r98n93MXo
         d4QGgQ9G3eS0KiAYt1XTe1geenM56Q4bIuSRTUfRYdgdprwie0+vlAT39y8V5zMojFR7
         nXL0z8qAK+b9wLkt2PotdTD4z4W03y7iUfQr3E8vZDjl86sSL+d2AB54VPHUsTaxXR+S
         8b9A==
X-Forwarded-Encrypted: i=1; AJvYcCVDFghrdV5Al09bvESqD3pB6Ei9YYRRnAqUtKyO3hXnrcksSa3plI3sYzaz/FL0uvXea0hpgaqdF0PqIN1incM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ9QM59QnagKPZWEehBe78frjb6Q93ZedgC34XDELRYb3H6+QL
	+RB0nXWStHJl7cMOU1DRvdXOTx8tor/bfSOM6/jYSXKjAdKvGg9j5qF7Q9EVtWYycDd7vix+QPb
	hMGWCSwrbvg==
X-Google-Smtp-Source: AGHT+IE7x2j8jiGmSa5hAjziFVPfetOC+qsRzdWEflJQ3CeZTBtL/LM/cmENZY4RpAOOGBS9kWw8FhCNJe+8
X-Received: from plgx7.prod.google.com ([2002:a17:902:ec87:b0:24c:be1c:4fa1])
 (user=zokeefe job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2447:b0:249:1f5f:f9a2
 with SMTP id d9443c01a7336-2516906b170mr155110685ad.0.1757444741506; Tue, 09
 Sep 2025 12:05:41 -0700 (PDT)
Date: Tue,  9 Sep 2025 12:05:34 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909190534.512801-1-zokeefe@google.com>
Subject: [PATCH] selftests/mm: remove PROT_EXEC req from file-collapse tests
From: "Zach O'Keefe" <zokeefe@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Shuah Khan <shuah@kernel.org>, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: "Zach O'Keefe" <zokeefe@google.com>
Content-Type: text/plain; charset="UTF-8"

As of v6.8 commit 7fbb5e188248 ("mm: remove VM_EXEC requirement for THP eligibility")
thp collapse no longer requires file-backed mappings be created with
PROT_EXEC.

Remove the overly-strict dependency from thp collapse tests so we test
the least-strict requirement for success.

Signed-off-by: Zach O'Keefe <zokeefe@google.com>
---
 tools/testing/selftests/mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
index a18c50d51141..3fe7ef04ac62 100644
--- a/tools/testing/selftests/mm/khugepaged.c
+++ b/tools/testing/selftests/mm/khugepaged.c
@@ -394,7 +394,7 @@ static void *file_setup_area(int nr_hpages)
 		perror("open()");
 		exit(EXIT_FAILURE);
 	}
-	p = mmap(BASE_ADDR, size, PROT_READ | PROT_EXEC,
+	p = mmap(BASE_ADDR, size, PROT_READ,
 		 MAP_PRIVATE, finfo.fd, 0);
 	if (p == MAP_FAILED || p != BASE_ADDR) {
 		perror("mmap()");
-- 
2.51.0.384.g4c02a37b29-goog


