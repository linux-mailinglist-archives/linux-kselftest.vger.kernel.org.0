Return-Path: <linux-kselftest+bounces-41116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5709AB51282
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 11:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA293AE8FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 09:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A43310621;
	Wed, 10 Sep 2025 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b71AZ6bt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770F819C54E
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Sep 2025 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757496660; cv=none; b=KLEFsvTB10I4Slqj7zX6f/6qYaX/N+e0evZ5hPzhJMvzY1Sgeh1yny+uHHsQs1d1hV9r8Ne2eTdL7V9eJd6lghWrAbxMrRttq29DdEU2TL9hpYU2Gcc6jRKQ877npCoTWsZQ7mQDXnEk9Yr59flA91GGVp9vfqRSpVWmG/RBM8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757496660; c=relaxed/simple;
	bh=a21Cu+J0U06Xk6062QwlPqOlBDs91JVnwm8k0OIr77g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rJFowWS6D142wLv6wSsuM3jTV1gzx6h5hv2IR8qsRNt9SXlFN/wejJfG5hzA+5jrxeQyrbhJfUjH1ju7SZhCD3mKn+RcHADJ5XLzZ2Ne0QefI49+A3hiu3OoU28uhoj6xXHv54Mtf4YXGAguTGR8EqGND0jf2OJQEYPixEf3pTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b71AZ6bt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757496656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2qzBA9zUbwBtQk09XBYRmyAB+zZC5CxWhnXgvnYd3No=;
	b=b71AZ6btBzU5G/vro5L9zD41LROOiFpW1X87rVTJdSxvhM4v1NWC7PoHBO2jTfXfU1OTnK
	hKYfaFBHbfPXShzHpqGcigzVDY1NSAZ01RIcdOh7jL6CBftwaomFH0nH+OEes2DaC/38Pj
	e7QZYWbaDY2eWuOSTdUsfsp3e0SVHAs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-iRUIG134MS6j3tzmsebTlw-1; Wed, 10 Sep 2025 05:30:55 -0400
X-MC-Unique: iRUIG134MS6j3tzmsebTlw-1
X-Mimecast-MFC-AGG-ID: iRUIG134MS6j3tzmsebTlw_1757496654
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3df3e935ec8so3017209f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Sep 2025 02:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757496654; x=1758101454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2qzBA9zUbwBtQk09XBYRmyAB+zZC5CxWhnXgvnYd3No=;
        b=JvJmuo94JWZutyZf7JtI3wtdnpDCSCswZu6ir3PfrjgOgILEhgTDUerHTgCESuAtDf
         RX4pSRvwkh1OIDU380nltp0ws/XkowFHnhN0U6U1CMO1y2XB1IIfsJe0gRkNpXgdoKih
         Nhmcbt6rJ/DF3GyfkTNM5ikkzcM7BqjYLcZjX8E7FTJKHsRgKK8p3xMwvwM2/ggmpDQ7
         lTcFh4iMzEtbn+DYVQYh3nNGx+SF1Hf//ybG8/FY1nl1O5dSkmj+yoFvf9KFolPHn5Lj
         mrPpbdSwUYtKzX9AlczGNNFPObQv9TbdDFidPRhbqTuHJoRwGca+b3T8tRIozfaITAWw
         HCLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKNKtwkI3kB7+vZ29PfJ0GssEy56ZJG5FlGiWF+ByydO+sl4/PgkojW4FWi5g4F7hC+Iel2poQfma8F0OEcxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhe6fmBl2x2ahn9Rs3oM/kB0l8BjGXQu5aY4picpI+bOzGYdUS
	4J9aJuDftX0qLi5gRCtvrx5UI/56blyueIt2n/eFKFiWJUEYnkTQ8F9cljTmdxev7U8uf8HhF/V
	UXAWHImtzbMF6869S5SDHNgPfDvnrzltKik93bTk/LJehQ0vB1MUVXTX+apKaQPSO2i9K1A==
X-Gm-Gg: ASbGncvBMVdbK9NnITwEJuTlyvqLC0iJz4993rlN55NHesrq4441nVE28AeizWe8VBX
	a6TxVdG6g/e+pTI5Vaqi/kXl7AFPwemnEHkJzwt/1Q/VE5UxtPLGMZ1iK9Ko8nDfU27h+4wcj2j
	cR+DiNEZDQPU6ogbMOzEm6L1dQfrA0dthWu7+IkPM/atuRM3rmExKtnZBI1o0tnZEHqwOTYVnjg
	D52nbJAjMR62yPuFDlkNgY3wWkcks9wuiuUkVX1NwEi7MXqSBDROlaJQclktbXFxk6508EDbGgt
	W0lxq7snrVhGGBuzF4LBGRKI2yEQalApZEvvUidhz0rgHD10UBrqxo07UjsABDhAFc10l/wO8eF
	Y/mteI96QYbP2vheel8Xsv0Dm
X-Received: by 2002:adf:e611:0:b0:3e7:42aa:1b3 with SMTP id ffacd0b85a97d-3e742aa0327mr9054258f8f.27.1757496653815;
        Wed, 10 Sep 2025 02:30:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEi3IitV0wCKvn7oRCPMLTVb77zHfNWhPGpq1wNihRoL3dQO3S5kiGmSFpyN3gxcJUcHXYIQ==
X-Received: by 2002:adf:e611:0:b0:3e7:42aa:1b3 with SMTP id ffacd0b85a97d-3e742aa0327mr9054232f8f.27.1757496653393;
        Wed, 10 Sep 2025 02:30:53 -0700 (PDT)
Received: from localhost (p200300d82f179c00d650ab5f74c22175.dip0.t-ipconnect.de. [2003:d8:2f17:9c00:d650:ab5f:74c2:2175])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45df8247bdesm20861465e9.14.2025.09.10.02.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 02:30:52 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH v1] selftests/mm: gup_tests: option to GUP all pages in a single call
Date: Wed, 10 Sep 2025 11:30:51 +0200
Message-ID: <20250910093051.1693097-1-david@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We recently missed detecting an issue during early testing because
the default (!all) tests would not trigger it and even when running
"all" tests it only would happen sometimes because of races.

So let's allow for an easy way to specify "GUP all pages in a single
call", extend the test matrix and extend our default (!all) tests.

By GUP'ing all pages in a single call, with the default size of 128MiB
we'll cover multiple leaf page tables / PMDs on architectures with sane
THP sizes.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/mm/gup_test.c     | 2 ++
 tools/testing/selftests/mm/run_vmtests.sh | 8 +++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/gup_test.c b/tools/testing/selftests/mm/gup_test.c
index bdeaac67ff9aa..8900b840c17a7 100644
--- a/tools/testing/selftests/mm/gup_test.c
+++ b/tools/testing/selftests/mm/gup_test.c
@@ -139,6 +139,8 @@ int main(int argc, char **argv)
 			break;
 		case 'n':
 			nr_pages = atoi(optarg);
+			if (nr_pages < 0)
+				nr_pages = size / psize();
 			break;
 		case 't':
 			thp = 1;
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 9e88cc25b9df2..6240e579b3ba5 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -138,7 +138,7 @@ run_gup_matrix() {
                     # -n: How many pages to fetch together?  512 is special
                     # because it's default thp size (or 2M on x86), 123 to
                     # just test partial gup when hit a huge in whatever form
-                    for num in "-n 1" "-n 512" "-n 123"; do
+                    for num in "-n 1" "-n 512" "-n 123" "-n -1"; do
                         CATEGORY="gup_test" run_test ./gup_test \
                                 $huge $test_cmd $write $share $num
                     done
@@ -313,9 +313,11 @@ if $RUN_ALL; then
     run_gup_matrix
 else
     # get_user_pages_fast() benchmark
-    CATEGORY="gup_test" run_test ./gup_test -u
+    CATEGORY="gup_test" run_test ./gup_test -u -n 1
+    CATEGORY="gup_test" run_test ./gup_test -u -n -1
     # pin_user_pages_fast() benchmark
-    CATEGORY="gup_test" run_test ./gup_test -a
+    CATEGORY="gup_test" run_test ./gup_test -a -n 1
+    CATEGORY="gup_test" run_test ./gup_test -a -n -1
 fi
 # Dump pages 0, 19, and 4096, using pin_user_pages:
 CATEGORY="gup_test" run_test ./gup_test -ct -F 0x1 0 19 0x1000
-- 
2.50.1


