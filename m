Return-Path: <linux-kselftest+bounces-40679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE227B415BF
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 09:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79F8F1B235FF
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 07:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5DE2D7385;
	Wed,  3 Sep 2025 07:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4X/3Ewf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCF728489B
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Sep 2025 07:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756882981; cv=none; b=so+VN8DWFak1LJ44D6Ada2+S8esCiPDZ/ssV/zn/2qUjcml0rh1OyMLRxYyUlLK8O8h2VN4JyTfFm78tUxnXz9PiNA6zmXthMnxLKxSA7u/C+c6JGQNMLcMis9sPpQJc00F4PwaLaUvTXEJUVmmCZ5rE6b0+NWPtV7bMHtDiKMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756882981; c=relaxed/simple;
	bh=TqFzKWeRTZdCm/cvkUCA7aEx7pP5X8qJ7Iyq2g/ihz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g2dC6LwJVPIJ8etaWaJPwS+UKEExDP6nuHwQ1jNBcswzYEuoIJLVDFg1OHsRWoGyu1FSzky3GscWYFYJ0g379d49KyVxAZBsUrG+U+cdppUL1au0tf40YRSa4LfrvVl4oKlFslPP6c4eKIhUtlpjKPGjNtn9cKwcHVz1lIEydqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b4X/3Ewf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756882978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Nc4ZGDL32vdkqTp2UxmErkTt7s51BsabNhqnOcOJ0vQ=;
	b=b4X/3EwfnI7PcI1DCcjsIEVmeMCeUpGJHRvBKEVqD38c5ACUcNWeBRShdgnlpviLQUDhV/
	RfF+/nhH25fBBDDqVkmqZm1z8PxvYlggans1B7oMGpJyuWgJXllqRV8yuV8QxyA8NnumTc
	tkWoCoBMej7aX5V/Z78VZwwmBQfwxrQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-Gkwg2k5ENFycjLCXNOGqVg-1; Wed, 03 Sep 2025 03:02:57 -0400
X-MC-Unique: Gkwg2k5ENFycjLCXNOGqVg-1
X-Mimecast-MFC-AGG-ID: Gkwg2k5ENFycjLCXNOGqVg_1756882976
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45cb604427fso1036925e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Sep 2025 00:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756882976; x=1757487776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nc4ZGDL32vdkqTp2UxmErkTt7s51BsabNhqnOcOJ0vQ=;
        b=tLlMMgXKjfP5NU72g2ZD17V5d7FvR0lRFb7GXZzi0tlNIn3oJrXgFrYe0uh9rLDI3+
         cfdli/uHU3j/sG1j+c7NfKpU3au20SEbly7u+8f89OA4GRtMN1CEiLlnPK4mGY1oOm9E
         uq/smke565K+Vs4aVZl7TF9FERnkZHxJSloeTB7ulcIuHPSh5yd4RTGy81cppP0gKC12
         24qhqfqzT+RKn9+h9UXbzcJ3uCsCVjTREeaWQhFNMzjkqtTUbGF0BBIZzliMKomLSA0N
         6jbCGDMPxf9EIFNewXCRfWYnDnIL/ANR2zW6jurYslJDymRmR3JmLmSwxeBXPxbJR2WM
         oWKA==
X-Forwarded-Encrypted: i=1; AJvYcCUz751N3IRu91udWAcy9f0mD/zspVofpvK4oS3BbaDr8sSa9TSJtN8v+0vbz2up1JYcjyItjQRiHODo7VkCUbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJNY5S3Mv9KM0D+TBN+7+zWCf1Rfq3qadlgHcHXdXESoWrQz1Z
	lxkA/txquBvhV9qeabMvz52h/ep0Q5LWBhW/Y3eQUJokMU+Tbsx3mrTN5wD5yYE0Qio0Hb9EOvh
	1nB7JkLluk73Ke6P/pC9NV+puRORQZCejfRjMCJnH8fCB2lXEFZPI8O/AWuzy962nYNtxMgUIh3
	buHQ==
X-Gm-Gg: ASbGnct+3Khg7O3yT4am+DxrPp1FPDW0DjKwwZfL0j3ChCpqGXpovL3ZWPEWeL45nj8
	Mxt+hEUP1CJ9y52XlIN2H792OijlDfoYa6c9XBRPd1AZFBGCotXXDZPv6KlVMXCdNzSCTu+zra1
	DSq/zHPyQC13uDLf8noemr7J38dz5ja/9vq0tBWjjAb3sd3URQpaXMY26xaTaMwetq/siC8iqr7
	HB7usYsK1I8AobtGSBU8xc+B6MEp7jjRzrTGD/FGAkofjH78UZ/NCX08mUY8F2CykAKywLKF8hi
	SuaNepz5aUWKPJWP6+rbasYUmZiCgDQMwQ2GipibJfTGPhvWKWdPGSSC83TpKtT+jNjlUXFooJG
	Anae6zJfOnh+KkMY75SON6rMs
X-Received: by 2002:a05:600c:35c8:b0:45b:8939:8b1c with SMTP id 5b1f17b1804b1-45b89398f5emr91180625e9.27.1756882975830;
        Wed, 03 Sep 2025 00:02:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/9mgihyp4H/Sd6HpN2hGIHH2BAgbt8Nw3A35djnCsNu46HxzvDh72AIsbnyyE/AU8sxs5IQ==
X-Received: by 2002:a05:600c:35c8:b0:45b:8939:8b1c with SMTP id 5b1f17b1804b1-45b89398f5emr91180285e9.27.1756882975345;
        Wed, 03 Sep 2025 00:02:55 -0700 (PDT)
Received: from localhost (p200300d82f099c0081732a94640ddd31.dip0.t-ipconnect.de. [2003:d8:2f09:9c00:8173:2a94:640d:dd31])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b7e8ab093sm237018805e9.22.2025.09.03.00.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 00:02:54 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v2 0/2] selftests/mm: split_huge_page_test: split_pte_mapped_thp improvements
Date: Wed,  3 Sep 2025 09:02:51 +0200
Message-ID: <20250903070253.34556-1-david@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One fix for occasional failures I found while testing and a bunch of
cleanups that should make that test easier to digest.

Tested on x86-64, the test seems to reliably pass.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>

--

Mostly a resend, because I accidentally disabled "ccover = true" in my
git config so people were only CCed on the cover letter.

v1 -> v2:
* "selftests/mm: split_huge_page_test: fix occasional is_backed_by_folio()
  wrong results"
 -> Fixup missing ")" in patch description

David Hildenbrand (2):
  selftests/mm: split_huge_page_test: fix occasional
    is_backed_by_folio() wrong results
  selftests/mm: split_huge_page_test: cleanups for split_pte_mapped_thp
    test

 .../selftests/mm/split_huge_page_test.c       | 138 ++++++++++--------
 1 file changed, 81 insertions(+), 57 deletions(-)


base-commit: ef42a39c44ef6da64ae3495d27e28dd6fca62a51
-- 
2.50.1


