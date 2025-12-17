Return-Path: <linux-kselftest+bounces-47637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23437CC60FF
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 06:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A72130424AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 05:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4175029BD8C;
	Wed, 17 Dec 2025 05:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IHdg87Ke"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A980238D22
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Dec 2025 05:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949716; cv=none; b=PVGKc7Ia6AuTHxYTDTa23r5/8Lcq1kD563pTiKFe5y8XbhzE7v34k7peTF7mhDxLi5f4FkZV/iamn1TDRN8v1InOsBi/BJ3SSXDAu+jLiUiT423CvbAkmevJ3k6U5NvIjpv+r+OgO+4e386mU/01lExDOEYPscdxnxEDwXWxSSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949716; c=relaxed/simple;
	bh=Pyh2W1i8IZlUeBaqc00BgLkYCHlkSrQShsXZSzjfZ7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGmLMtnl/TrT44s4h1cyH7k8K6k4mWvkvDAnJFw47eQznjltGYBc7nI7LJuEBnYbKsmOjPeGCIgHOExTEQ5l16AiA1V9jjtshtheqDh2zJyIhYeyGKuOYjypPKiBUEfTbN5RcMAiXSCKbnG5QXm+RkNjjJpPZQ+/eE6MKvdlp4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IHdg87Ke; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-8b29aebdf3cso74284385a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 21:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949712; x=1766554512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2Q4EUjN96I8JLsrl8Thk8/d3aPnxYAXF44AaVOt3uI=;
        b=IHdg87KeUrILc8yIhZahuIqFXNHWECMj4wnXxIkZRn67g0x3QwyZyWmlnzAA71n95A
         dUTQnW9vfnJgTAJn0D36rCoU+m7WDw8MLVaf0ZPVwQR4KS6yqIujaVHadXEW8WoLqG7I
         i7tPzy820mLTMw37aeu/ETOvuN5npxNhPXD/LylpgQkGoFXpTGl7yQsCKRAi9N0XnP/9
         s98Yju4OZGFpZ2fKB2/Qsq9CLKDaqjCl0ovOz3U49zU6/XT2O9g3nnV3ROZOP1CAihqv
         jcfp8qcClLkXqewm4yVPmH9Odc4baYsQQPu2nVPV5CyYcVzDlSpNXRDRdrQkjzvQO4RS
         xgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949712; x=1766554512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R2Q4EUjN96I8JLsrl8Thk8/d3aPnxYAXF44AaVOt3uI=;
        b=UHFWcIwjllW5VwE27GYY26fv3aE+GtAuBa7YQZR8tNX7Zsnr8dTvpa6bWxqhyGdvDW
         nXFMxEHCz74+86q55mGtALcJUsrlVEZEevuSlRlpYbJfME/grghFwRHxLlK/8vDtlNRf
         A3l9fuY6nH6GvkdEprWZ5PcWhZq2IgLWtJQZZfMOXpyyqPy7YF1OoPXf4OQuHWisKUvW
         E0I5UijM3F8OblLrF1vb65e7IVONDULhjCz6Fx8lAHdDhHJbwk46U2iHHKt3iBaAbTM9
         8zMRNsD0ongfrDPe1/Rqy+tbgyqPBlAG6gSmqXUq12/f/0m6+E5j7cukRZ4kCKHnZgNw
         zhlw==
X-Forwarded-Encrypted: i=1; AJvYcCWhCRBaDqgk00R3JrIKJK39LOQ9QbOg8GcbkKzocXk0s9W95BJASA85FMGGcWyJXWgE8pMdjfeDtn5BIfAFB8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmOesURgAJKhjov4488r4zjeg9Gy3ioD7dz7o6RHPQlKHMhrKf
	saqhDlVuYiff3Xus2fRD/n3lKWLMFoJoekKcvBvPfSseCtCqsWIhuEG5ojcPJOyliAieo7aqPIT
	KmLXWlCDWIheNyYC40BrsDJAs03gjbdTXIZVg
X-Gm-Gg: AY/fxX7acgTEtNUUccllmOFOwzTVbOZWM0fVNHCHps6chlYmT2wVnlFglxn0NkrLErT
	dwRxCxcqGjimJR2HqAL6mc/gjay+FFLOiOGgzTm3/jBDXnirJyPku5hnseD3RnfY/6wYdTdu85O
	3HlXfVigdwnQYGXQA/BvtkTKTHn1/2bW5kq0Fci0UdUM0lULKOMSFOGw1TDpDXolXF3RqGMGHDY
	e6v009m1wEdYaiZg9AN19vYmZ3uBEhCN3VFmDlT0NZisrjwxudLlOWNR1z2uazg0ZFRrNp8B8vE
	0sf9ANl8QA3ZG9bEUVOTWrs015Hf55Ju/WBtJKIiO9qNOT9Bph6Ly+8ov33YeDJLNrAj8zFQUxj
	+Ouph+qlPcE6yz9r2h2Kt+CRA4MlFP0t6an00M1fr6Q==
X-Google-Smtp-Source: AGHT+IEwQVVahKTBzODwZ9LCNp7ytSuh2rRQqS2AIb4ql60egeJB6RRbKK8HEAJwdh0Tw0BDMeZ7L4T+UOA8
X-Received: by 2002:a05:622a:610:b0:4ec:f9c2:c200 with SMTP id d75a77b69052e-4f1d0655504mr181608401cf.11.1765949712259;
        Tue, 16 Dec 2025 21:35:12 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8899dc07525sm19327636d6.15.2025.12.16.21.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:12 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6A40F3404B4;
	Tue, 16 Dec 2025 22:35:11 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 67759E41A08; Tue, 16 Dec 2025 22:35:11 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 01/20] block: validate pi_offset integrity limit
Date: Tue, 16 Dec 2025 22:34:35 -0700
Message-ID: <20251217053455.281509-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251217053455.281509-1-csander@purestorage.com>
References: <20251217053455.281509-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PI tuple must be contained within the metadata value, so validate
that pi_offset + pi_tuple_size <= metadata_size. This guards against
block drivers that report invalid pi_offset values.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/blk-settings.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 51401f08ce05..d138abc973bb 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -159,14 +159,13 @@ static int blk_validate_integrity_limits(struct queue_limits *lim)
 	    (bi->flags & BLK_INTEGRITY_REF_TAG)) {
 		pr_warn("ref tag not support without checksum.\n");
 		return -EINVAL;
 	}
 
-	if (bi->pi_tuple_size > bi->metadata_size) {
-		pr_warn("pi_tuple_size (%u) exceeds metadata_size (%u)\n",
-			 bi->pi_tuple_size,
-			 bi->metadata_size);
+	if (bi->pi_offset + bi->pi_tuple_size > bi->metadata_size) {
+		pr_warn("pi_offset (%u) + pi_tuple_size (%u) exceeds metadata_size (%u)\n",
+			bi->pi_offset, bi->pi_tuple_size, bi->metadata_size);
 		return -EINVAL;
 	}
 
 	switch (bi->csum_type) {
 	case BLK_INTEGRITY_CSUM_NONE:
-- 
2.45.2


