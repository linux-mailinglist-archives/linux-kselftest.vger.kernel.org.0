Return-Path: <linux-kselftest+bounces-39570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C45CB304F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C10163D55
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338D4371E96;
	Thu, 21 Aug 2025 20:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWxOjxrR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D3E3705A1
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 20:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806901; cv=none; b=F7w+qfIsFPB3zWDckIaBpWXT3HheaSWEWGKQe6EeQjBMHz6Z+9myFRChoBrS1n0daUzkLq4XvaCfjbailxv8+xJRF5cin3MlzC4w/HPNFo5ztThcbmQtLTplbbIE9RekdM68RD+TNBwxJZF9XIwFgacmFx8lluBJN3W87CqdQ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806901; c=relaxed/simple;
	bh=o0B/aIsMAhafmNCelOfWp+ALdEBw0Dyti3dxNNba1Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPHzc4A5t51XhikvOk1xPbp0rUkTVDODrtqtvF2T3Z601AtAWlv28W+pvtXoKj72ribpovaCG2QWEEqD+MYSWodcwLbnPqCfSfpF0Ye54FHeWVfl4+0IYnNPdYu3kXwHESsbw/bjZmKxYLbeti1+Z3u9bgm4dfBOC72s0yhfCz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iWxOjxrR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qEz5al18caSg7WeU7/xaDhHrA43/vq8xaUIrOF+uMyw=;
	b=iWxOjxrRN4x5VIWw+kp5y4YmvLNvjKSNKeylj1vK1XyCRY9sxWg0FfVqV/vfqPm/IW6yXy
	bmY/62DCOp3qmLfp5DLecQ+IHUdK47i4PcZPRKtgGc6+osTfaUU27E7W1fDGaDHCoZarZQ
	saYSRsBdiS/kD9py5e1jjBqq1zT3Ad0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-E903HwYmOo-kBxy70EdbVw-1; Thu, 21 Aug 2025 16:08:15 -0400
X-MC-Unique: E903HwYmOo-kBxy70EdbVw-1
X-Mimecast-MFC-AGG-ID: E903HwYmOo-kBxy70EdbVw_1755806894
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9e4117542so631243f8f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 13:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806894; x=1756411694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEz5al18caSg7WeU7/xaDhHrA43/vq8xaUIrOF+uMyw=;
        b=K4aKbxadoc/aJZ+QMzPtdJOQEtzqTes3Z1LJ8CfJZNxhx1PURIFwT6AetJ46JoWODi
         chwWsY5SN9aySnKu6dQnQVWh9VgIKvV2m4On0G9ggtfInV8WYEBEaT2WizcBP4BZYwVQ
         j8Zkgj1ZmILXINj8IyubL+8L/3Wn2S2xkBGn6eqmJbAWfMVOTyPgxnc4lpNOVtvz1DF5
         Bd0XBAmB64NIySQmPOFAwkjoSIC69aaG0V7vgHFxnHk1HZgHPjfpGBvfc1G//Jnlygos
         GG5Om5PrHukJwdTlL9Jn9aoBq8cWUVhaSt1cPJIh/HawLgOYOnGDlhm0ZeVGT0vXvc+E
         z+GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzi6f+7CvmEx2L5qpqc1v7ZgPWh4CwVhCDyys+zjBNN+jSesOPwUXEqOQj9ZtJS4Is2B+1OTanN6r2ypaPD9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YznWgAq8AxRY6TeyzdXy/3tAhNyY2/sd9RwPAwIXBT23cYI5g2/
	AnQK7VtTGCpedMBacJPHV3MnEeeoaDTbxIxe5ePphdmdDTJEMg0fsjueMkL4xvtBJfm8FQkJNAl
	ZDLy8tdjUxqE66wOFJ5qlsuOQvvlsNf9NTxmfy848Z6nVFVk06ucLfjVQGAxWORWwOoGMXw==
X-Gm-Gg: ASbGnctTPfXhc4v/sVeIi6f4fLXKj4dHyUx0sYJcMcqK99eAUtGc1SRDwF1Hkin3qSk
	GZ2EZGe5Epz67PdWImU2jRlS6M6MHaDOuvWO7zTVaiCbAqiXNXJg39oFaeageppbZ+6D2IynyxJ
	KD/oRtC/xHNbA4Qcs00p+XuAEh1l906asgcDOC2RD04hmNe1AGWcLwp/c6IFxhdis+LFgPbEfds
	x4avUR2c6yLwRnmsG4NCtuJtot3A+7GNNVbn2yaiKMyKlBOQRHZYThQB8xpTp8LgRLbo/KMgqwZ
	g0JWmq9K69v9YznvwaXbWWLfmX06jwXhoC7pmPgiWQTAkgZrAm1B1VrWIqNzX9m/XF1JaSxl1zN
	IZAknj8KvJaXik6czs2PTvw==
X-Received: by 2002:a05:6000:18ad:b0:3b7:9c79:32bb with SMTP id ffacd0b85a97d-3c5dcdf9bd9mr215813f8f.44.1755806894471;
        Thu, 21 Aug 2025 13:08:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYrE9N2OTZOZSEOVxEUY9xhX4UsF8UOhI+5wOqBRpd/3VSIxUjVMLdiea20BiXkc+w3FSZ8A==
X-Received: by 2002:a05:6000:18ad:b0:3b7:9c79:32bb with SMTP id ffacd0b85a97d-3c5dcdf9bd9mr215789f8f.44.1755806894010;
        Thu, 21 Aug 2025 13:08:14 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c074e38d65sm12982954f8f.27.2025.08.21.13.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:13 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 24/35] ata: libata-eh: drop nth_page() usage within SG entry
Date: Thu, 21 Aug 2025 22:06:50 +0200
Message-ID: <20250821200701.1329277-25-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's no longer required to use nth_page() when iterating pages within a
single SG entry, so let's drop the nth_page() usage.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/ata/libata-sff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 7fc407255eb46..9f5d0f9f6d686 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -614,7 +614,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 	offset = qc->cursg->offset + qc->cursg_ofs;
 
 	/* get the current page and offset */
-	page = nth_page(page, (offset >> PAGE_SHIFT));
+	page += offset / PAGE_SHIFT;
 	offset %= PAGE_SIZE;
 
 	/* don't overrun current sg */
@@ -631,7 +631,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 		unsigned int split_len = PAGE_SIZE - offset;
 
 		ata_pio_xfer(qc, page, offset, split_len);
-		ata_pio_xfer(qc, nth_page(page, 1), 0, count - split_len);
+		ata_pio_xfer(qc, page + 1, 0, count - split_len);
 	} else {
 		ata_pio_xfer(qc, page, offset, count);
 	}
@@ -751,7 +751,7 @@ static int __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
 	offset = sg->offset + qc->cursg_ofs;
 
 	/* get the current page and offset */
-	page = nth_page(page, (offset >> PAGE_SHIFT));
+	page += offset / PAGE_SIZE;
 	offset %= PAGE_SIZE;
 
 	/* don't overrun current sg */
-- 
2.50.1


