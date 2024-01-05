Return-Path: <linux-kselftest+bounces-2665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 023BA825736
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 16:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B3D1C22DE2
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 15:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27522E63A;
	Fri,  5 Jan 2024 15:54:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AD22E651;
	Fri,  5 Jan 2024 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-553ba2f0c8fso1901574a12.1;
        Fri, 05 Jan 2024 07:54:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704470069; x=1705074869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6wG9ZzYTMIbl90MDDwci6aGriZP9ArruE6XkOlXJdQ=;
        b=gMAkMddK8k+/VuziXxyF0Fm3mxl8t1jNHc6njXt1FtlVIYdPL+BlBuVwFayM3NkYhp
         Ii35mkuN2gD4X+34GWF2zuJehbB4BY09ywlopQAZwU7tn0waW4YASJMBF7Xr5UDPuppQ
         xOKbzaVN1CczeI/BY8zY9Kgi+zmzlhkVAQcsp22LlEBXDHrqx3fiUTsle4ubHJAsHa8K
         cOIjNTMWolxQOCV64pRYe9BKe1wvv+UdYpKDiqyyRxnswT5w3KeIo9uJ1Qmx5z8QLK1T
         59IBLytMlSCOc9P0VFNMfbVvMzkkcFulEcN3aVNNesB6Ledc3ixaetfDkJQrha6a4md/
         qeEg==
X-Gm-Message-State: AOJu0YwVD5jGw1O2xKu9IFwCzSgwbUGtaTJ4p1DNRS+MftmoyZFohxGP
	zJG9cVcWwDHMia01zIvWKt0=
X-Google-Smtp-Source: AGHT+IFnY2eub3jodcxLJrdqZq9ALnlRArPvDy89eZBPUJ60FNMFUhpMIIn/6e8CsBhUx8frDBSmQw==
X-Received: by 2002:a50:c219:0:b0:557:d32:fe2 with SMTP id n25-20020a50c219000000b005570d320fe2mr506778edf.47.1704470069019;
        Fri, 05 Jan 2024 07:54:29 -0800 (PST)
Received: from localhost (fwdproxy-cln-001.fbsv.net. [2a03:2880:31ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3-20020a508e03000000b0055515b40464sm1110374edw.81.2024.01.05.07.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 07:54:28 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: riel@surriel.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org
Cc: vegard.nossum@oracle.com,
	rppt@kernel.org,
	songmuchun@bytedance.com,
	shy828301@gmail.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] selftest/mm/hugetlb: SIGBUS on stolen page
Date: Fri,  5 Jan 2024 07:54:18 -0800
Message-Id: <20240105155419.1939484-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test case triggers a race between madvise(MADV_DONTNEED) and
mmap() in a single huge page, which got stolen (while reserved).

Once the only page is stolen, the memory previously mmaped (and
madvise(MADV_DONTNEED) got a SIGBUS when accessed.

I am not adding this test to the un_vmtests.sh scripts, since this test
fails at upstream.

Breno Leitao (1):
  selftests/mm: add a new test for madv and hugetlb mmap

 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/hugetlb_madv_vs_map.c        | 124 ++++++++++++++++++
 3 files changed, 126 insertions(+)
 create mode 100644 tools/testing/selftests/mm/hugetlb_madv_vs_map.c

-- 
2.34.1


