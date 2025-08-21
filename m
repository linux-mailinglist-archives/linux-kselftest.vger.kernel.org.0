Return-Path: <linux-kselftest+bounces-39576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDD7B3053C
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B798727025
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 20:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D009537D5AE;
	Thu, 21 Aug 2025 20:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWu3gNCR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175E8371EB8
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 20:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806918; cv=none; b=eM1Octgr8RKXlKpUj5ck1fHvrXuXa7E1fUbrkxBdF1BQpxsjd+Dn5WtU+u9fjGSRvUc3OEAzv6+0FtxqK1dAwLlqgA+3loYUiwkYIYOP3AkZXolod83bVt01jcSP0fdm9uf1q1M7y250vjJbHN+hDPKZBQSFB0P2hSfLw1u1YKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806918; c=relaxed/simple;
	bh=u2IvbkeQqipan9xn1FH8uDngo5kbDeDcvQE423cldao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2wmvcCRYmqt4YrH5pnqdZ9G7Fks9TabDDYlkBPatENBjIQ97g+mfr7pCqIB5MKmd/SodszugqHC4y/mTsM2yEgSk0NbT8Th9i6eRcjMMhDIivW0+YyVfWlFU2StL88PSt1CXao1R7YwfRve8UzCxQfYCIUxSZV9U7k/+OOJAMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWu3gNCR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uIthYg0x+2djveHghlw2Jb9wmVGYKVQz7R4ULrPQfiU=;
	b=gWu3gNCRFOsVNUuWNJEaJT4/smWuwebgkhI909aCi18ILvJjj5U7YQmWWGABCmv4chp0TV
	zV/fj1uRmOb/F8sJKTzbOiQuWGXb4y/HFFB5tpH6G0ZKaRgehJHsUCAVNpNvX0+YSn0rDQ
	d62ftm4cV7f9jCf68yOkQkEp79sT6Pg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-X_5aFOf_P5eYEdaAWrOh7g-1; Thu, 21 Aug 2025 16:08:33 -0400
X-MC-Unique: X_5aFOf_P5eYEdaAWrOh7g-1
X-Mimecast-MFC-AGG-ID: X_5aFOf_P5eYEdaAWrOh7g_1755806912
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9dc566cb4so996948f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 13:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806912; x=1756411712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIthYg0x+2djveHghlw2Jb9wmVGYKVQz7R4ULrPQfiU=;
        b=ZpHk1WN6K0Qp8+KKMDOwlMNTJyiGD7ECOcpQvOYJtV2lPagPcmScWlUpmlmEzAKRHB
         +0/RMvnhaxpe+nb+DYKQ3vIM3pz0RvVqHcjhLOngvgFjzSMOUT0jnjhCmFtBsQSMMcxt
         tNHdpQ2EEgpZC+Cp5VMZPLRsghfr+4ap8GoJxmKHoETdFlysX8UnCqZV1UcHUWyioXja
         yR4pBEUttgdaG0SP3qcdKyfR94NGQ97vSPD14SW9aQrE55M0AOD/y4yE6tOmtwnfmgnH
         l0PngH/b+pPgc65WWPB69jw71WL5cEyeXjDPREh98yw0xWKH6QlU6lU/j/xbvTkZYIbo
         NMdA==
X-Forwarded-Encrypted: i=1; AJvYcCW4Lj7i6ogzASSKYVy/Qygkv+bSG2laBbvZR0JI5xLUT72gFRyIBvSexw+Ux2Eac2kmokeKJTANsDsJHzi38v4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh6cMW+GJmD3oVoKVFECN8ozPoi+EpKBIdaU5Mbo96EdhQs6Az
	wK1CBZN6WZVEEEna6Dx2BHk6PusQbVmfTRHcCsJOpNg7d4S2TmvP+VkLdc3hXpOTwLCoIGk2eqF
	ezpIdOW4tSPyxmSLIRIbQ0Gf4r4wx8tLpWpHZTx4OkfPHmXmoC4VFK77a7Mnl2nt2dYfeDA==
X-Gm-Gg: ASbGncubcormsfRS5usZqKjXyTFeOBpknxz7tZHWdoyz9kEgn2KYA51Giubk0QFGXqI
	WdMLHlmgziPvYuxkDi3WRFOwZvP72t2K5X6nPUy26XKXL44xGVY4R6DT+9zuNFke5MDJv65OhZr
	HSTlm9FR5N5Jc6vall4OJaTr9e3uNvQZjWHXixgPtz09ShfJx2Z8w3/g45v5WNf2mB7xi71siQM
	S1eZSwUrFdTieI9HS/L1sT9iCTO8MAyo27cmIKTZgKD+Ah6ruQCtpDZqOd0EsXiIQALpZCt67fd
	S7hbfiBN1rHPXugGSsaF/ZLtgafLo8d0URW9ZSGHwidN28/prI7cwH4Lk+XztfScAdcsCPZ/NjH
	qLpiZpbUQSwdNmr2i9q3Qsg==
X-Received: by 2002:a05:6000:40de:b0:3a5:783f:528a with SMTP id ffacd0b85a97d-3c5dcefee22mr195273f8f.59.1755806912315;
        Thu, 21 Aug 2025 13:08:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRe/VOMg0cdir08bDTWMwU06A85Ixelypa7wMbtHpunFYS8URS38ofNnAO5nDnYJmoWLlWSQ==
X-Received: by 2002:a05:6000:40de:b0:3a5:783f:528a with SMTP id ffacd0b85a97d-3c5dcefee22mr195231f8f.59.1755806911819;
        Thu, 21 Aug 2025 13:08:31 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50f16eb1sm7598185e9.3.2025.08.21.13.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:31 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
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
Subject: [PATCH RFC 30/35] vfio/pci: drop nth_page() usage within SG entry
Date: Thu, 21 Aug 2025 22:06:56 +0200
Message-ID: <20250821200701.1329277-31-david@redhat.com>
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

Cc: Brett Creeley <brett.creeley@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yishai Hadas <yishaih@nvidia.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/vfio/pci/pds/lm.c         | 3 +--
 drivers/vfio/pci/virtio/migrate.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/pds/lm.c b/drivers/vfio/pci/pds/lm.c
index f2673d395236a..4d70c833fa32e 100644
--- a/drivers/vfio/pci/pds/lm.c
+++ b/drivers/vfio/pci/pds/lm.c
@@ -151,8 +151,7 @@ static struct page *pds_vfio_get_file_page(struct pds_vfio_lm_file *lm_file,
 			lm_file->last_offset_sg = sg;
 			lm_file->sg_last_entry += i;
 			lm_file->last_offset = cur_offset;
-			return nth_page(sg_page(sg),
-					(offset - cur_offset) / PAGE_SIZE);
+			return sg_page(sg) + (offset - cur_offset) / PAGE_SIZE;
 		}
 		cur_offset += sg->length;
 	}
diff --git a/drivers/vfio/pci/virtio/migrate.c b/drivers/vfio/pci/virtio/migrate.c
index ba92bb4e9af94..7dd0ac866461d 100644
--- a/drivers/vfio/pci/virtio/migrate.c
+++ b/drivers/vfio/pci/virtio/migrate.c
@@ -53,8 +53,7 @@ virtiovf_get_migration_page(struct virtiovf_data_buffer *buf,
 			buf->last_offset_sg = sg;
 			buf->sg_last_entry += i;
 			buf->last_offset = cur_offset;
-			return nth_page(sg_page(sg),
-					(offset - cur_offset) / PAGE_SIZE);
+			return sg_page(sg) + (offset - cur_offset) / PAGE_SIZE;
 		}
 		cur_offset += sg->length;
 	}
-- 
2.50.1


