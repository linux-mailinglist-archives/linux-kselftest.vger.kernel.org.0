Return-Path: <linux-kselftest+bounces-46543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A52C8B99B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 20:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C3534E76FF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 19:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE6A340DB0;
	Wed, 26 Nov 2025 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2AyXwUI8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52273331A58
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185776; cv=none; b=PyxbbcYlL4E4eRTYDl5OvOANQ+WCX2ZQshFD2y4ujDsEKAttbh2PsjTgL97sfQ8NHCMfsv9bNss0+bXD/lw0tPf9VnFqRNqg55pSoj8BSnjgoFnhJiOZXzRsu+NLS+Mu3i2fiwkRJNGIEsVGaoervALSq52GMP6tGro7SVFD1bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185776; c=relaxed/simple;
	bh=/FXmHIzCD+k6Qaqzmfau8LRE8Vrb+9907NJenDBaRrw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f38oq6oC6p9IRoJZ/mZ6JmCfEUNYUrFlldKVkpJnalqdF2L+Ib2hyhoF1nEqJYdjrY4VoQAJvfTNLKR34UNKF+Ib2CeHs73LhXE0ZpDSc6aCHZGUnRNZ7tuT32fbYjCmAxRPO/lbeSPV6RaNo4ncHeHUGVgwqbwfwmUxooObdVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2AyXwUI8; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b89c1ce9cfso50480b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 11:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764185772; x=1764790572; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uHriGM21Vxl9AOHAXOvBqeFMQcHzxMHlkr+LZIh84mE=;
        b=2AyXwUI8LHR5+vkf1wx8lh5FgwstwLcl+Q+eNcEIpRMuMqZGexLMIbWsdyC9hB0pUs
         zT0RbQRxVGqyV6fD15rInwB7XO4aYHVLtI7PkTxYlzEkMt8Ucr6bn98hAyYTvalCf9zj
         dNjQqzQe5FJzvgcplPHgsg27vO75UxHdNoVj3pDT0EgP0WaCq78htQHKGoi31krRRsqJ
         KyP6RfTip0i6X0kOcRKccOJgaG4fCwVhmNsakemqfiHPbjhwjDkBRZN+SqiYc/6F/8Hu
         HJW8lu+hd18exJvydsHeqhimsjI9IVG4zQoICUywd9ClyZ96qI1/suO3jWqkVDSwnG4K
         CJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764185772; x=1764790572;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHriGM21Vxl9AOHAXOvBqeFMQcHzxMHlkr+LZIh84mE=;
        b=r14JUbKxCal2ugLd0zNAkdsfosiRZ//EpZHIPRa2OJuKX83mfVt+1ihMQkbjh2vij+
         b+S7wsDazQBNJWWd/bKlv6o8VRUpyyTvBUa6s2/8pKYHT1K7Tn7BU5htnDoPh0vflNQD
         b+gfscN8R38HQ0qzq5f2fiIlajVWvbuZygwRWoNDo+fM03e0M+a6CYRYJpCe32k6HroN
         1kbrsp89+QdWMWPyM58drsmFvC2MshBRRi3QLE3KUr8CGtrDLkLyCBbnWpMd7aMjSe4P
         NRgXYc+rI7y9pzDavpv+OU5FUlG6XbrqmxmcT8y7mg/jzO45DmbdNfIuT3xFlGIN3oK4
         8dCw==
X-Forwarded-Encrypted: i=1; AJvYcCWIaUuDYEgT+sv0HtX/u9euK9Q8TMpfLDPd1rT9EiTeJ4fydiulmjbzYQTzKDt0nenxSbGi9IaonoKM4bvpdQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww5CDnAnh+aGOnhAotdaAXpv/KXSXPqoGhmFfL8hjBwBPud0dy
	Isf5Rs/O1pR8yKxkkzFSpuNQyuwvSqIx99rdAZaDHdweplg19rgXA7Dl6TJpoybtyGEWiYo8uvv
	sOUL7TjNbfwbe7Q==
X-Google-Smtp-Source: AGHT+IGSiH44ozkyo+4RkUn4tpozCQb7RKk52SJWagBr1rO1D7Afqr3pd7mKB/7v6Lj8EhB8iNn4BVDHpADpeQ==
X-Received: from pfbmu13.prod.google.com ([2002:a05:6a00:6e8d:b0:7bc:34a1:3751])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:bd92:b0:7b2:2d85:ae59 with SMTP id d2e1a72fcca58-7ca879ebbc9mr7460707b3a.11.1764185772505;
 Wed, 26 Nov 2025 11:36:12 -0800 (PST)
Date: Wed, 26 Nov 2025 19:35:48 +0000
In-Reply-To: <20251126193608.2678510-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126193608.2678510-2-dmatlack@google.com>
Subject: [PATCH 01/21] liveupdate: luo_flb: Prevent retrieve() after finish()
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Philipp Stanner <pstanner@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Prevent an incoming FLB from being retrieved after its finish() callback
has been run. An incoming FLB should only retrieved once, and once its
finish() callback has run the data has been freed and cannot be (and
should not be) retrieved again.

Fixes: e8c57e582167 ("liveupdate: luo_flb: Introduce File-Lifecycle-Bound global state")
Signed-off-by: David Matlack <dmatlack@google.com>
---
 include/linux/liveupdate.h  | 3 +++
 kernel/liveupdate/luo_flb.c | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index ed81e7b31a9f..b913d63eab5f 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -165,12 +165,15 @@ struct liveupdate_flb_ops {
  * @obj:   The live kernel object returned by .preserve() or .retrieve().
  * @lock:  A mutex that protects all fields within this structure, providing
  *         the synchronization service for the FLB's ops.
+ * @finished: True once the FLB's finish() callback has run, to prevent an FLB
+ *            from being retrieve()'d again after finish() (incoming only).
  */
 struct luo_flb_private_state {
 	long count;
 	u64 data;
 	void *obj;
 	struct mutex lock;
+	bool finished;
 };
 
 /*
diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
index e80ac5b575ec..072796fb75cb 100644
--- a/kernel/liveupdate/luo_flb.c
+++ b/kernel/liveupdate/luo_flb.c
@@ -155,6 +155,9 @@ static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
 
 	guard(mutex)(&private->incoming.lock);
 
+	if (private->incoming.finished)
+		return -ENODATA;
+
 	if (private->incoming.obj)
 		return 0;
 
@@ -213,6 +216,7 @@ static void luo_flb_file_finish_one(struct liveupdate_flb *flb)
 
 			private->incoming.data = 0;
 			private->incoming.obj = NULL;
+			private->incoming.finished = true;
 		}
 	}
 }
-- 
2.52.0.487.g5c8c507ade-goog


