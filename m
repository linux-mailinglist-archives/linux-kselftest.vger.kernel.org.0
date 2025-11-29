Return-Path: <linux-kselftest+bounces-46736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 802CDC947AB
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 21:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0300D3A527A
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 20:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9418B2517B9;
	Sat, 29 Nov 2025 20:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="CdBPRuXu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56C121FF55
	for <linux-kselftest@vger.kernel.org>; Sat, 29 Nov 2025 20:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764447354; cv=none; b=tEBZHQMZJkAMevacbuMCjdlJyEiIE0ZYSsL9vHRSMU2Ru2kiiz2phJ1EKIrGHQJ+3d/N8w5beKBJJkGsAkQulV99D01lQrMsIFpovJtjsyesd1dSYuAZKm15B4/J4sUGq1cWyLPLpmdX65G8qFzSVw9iSMj0ZNRAt6dM6FL3I8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764447354; c=relaxed/simple;
	bh=Avt2UMlvJvKj48Bvein267LDULZsX9bgepF9d3J/W54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bnwqzoa0i5KQ2thDogn/qty4X/J/bkZq+SkTHKUPTzsBQSmkGeCeAGLOLxJv6z9FbnhPez2xZP/8zLPn9gb/U7q95czrbyw08rHu1JhfHPfD56Dnbu2Hlf9kukgy9oNUxjmvmopV/Vfghpm+vujZumXDDt7v79KEPLKoXD75f4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=CdBPRuXu; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640c6577120so5273173a12.1
        for <linux-kselftest@vger.kernel.org>; Sat, 29 Nov 2025 12:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764447351; x=1765052151; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CbrHVgAk4ceMbeJvd+DQH3q/+X1C6b06QZvwWnW1z3Y=;
        b=CdBPRuXuuizuTY8RNs/48SAOXQHm9fduZLonU9pNioMHgcNQrC4YSJu03LW9gDCtCd
         F9dP6Nv0UgeD+GDnWeakwxSUcGgaCvH8Iql6rq8s8fuiGiNcBHeMYelVC0TvLz3EC9Jt
         mfnYacRdoJ0hWKNJTv1XBoaPxkyDdBqmkvWT7JzIi5nNCuMmcYGPM4YNbvNv392vn28d
         AshNEg2kH6aLBivMW/tUDEPmgWlUHWF2E2RztQdQiv5HH1WpFBPiKb+gSDB/bn3HQE8s
         6xE8PAVLxZhaQ2fINcf1p9YkN0wU+CIhyK1McBkJRX8GGsrDKoGOM+lXeyShT6pREmDS
         AF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764447351; x=1765052151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbrHVgAk4ceMbeJvd+DQH3q/+X1C6b06QZvwWnW1z3Y=;
        b=wj+7SjZVMbMz/R6pMtVQR8e6evCS9qN5HGS3VyqzUM1v3BvZAlnX4Ugtg/s2hiEZK7
         Jj7RReUNhleRf7Am9PSYuDJRVd0vGgzpPxFCPxEVh/OrxYivNpTSTXKhb712tV/J2juo
         kO14yacMQ61DzxPTgd/AfmZIyUR6lfzptMcAsHUfO1Mr1sXDuLw80cCFEK79pTboRcro
         kjkuZm62BCNW4JtC+9XuqSzRnC5i8hRLPCB3see8UKxXhTxkHQWRc20p7uX0Bxjbl+fK
         N9GdK6RTKoZtQ2gPj1q/E7zTV5Yj0vcrBNpFSb/njeMlLeO05nMu6ZirGudw+WFH7ChV
         7bgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt1Z6OkBT9mROqT/1WjHb7oWlw5oHhRRSwsC+JTCurDvolDrAgbda7Z6KTytXemjitImKXHrhd+hLBuJmWs4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZbj1MM9iZZYGNXGBK9W9OaEJMP6fRNaTn8o5H/RGnmuSFnMTG
	ot61XkOJjGlBd6jO0omCnAJjcI2emfash44dr/uknyRM77Y8AEKoNbh8pJxECLz8dUjzVwBNckM
	o9J2+h4LfiCyS9ubT8481De8eyK514OTgJxOpGaeMRA==
X-Gm-Gg: ASbGncvaf5Fj5JxaDfLFeRSlLZNGiqL7fyJNHesl3a5unE/IGcXaFv9bJOGaj5fmPdR
	c1/8f3vsA8JmsfKTNfH3dq+Dhdv9oVyYe4qsbY/S0DOE302tIbVu0eERaPtCQwf10/k6B9kiaWu
	J9c5eEp9OyJ3sGSU5FXiWngckUPfL4k1mY9PVuoof6UtOVsRn/SfjVW3QV9B3qZxrsE3NZxH5wm
	4iJtFDB6zFceICS/eEc/kDKWq+hOoVngi6SWrENCMfrhPL4CFoRXQ+JKV4NSAK3iWbJ
X-Google-Smtp-Source: AGHT+IHhHDfztbzeuDsMUdf5J+2oq6s9xY717vsv5xUPI6WLewpy28fqQPGTLFzSqg8VEqM9e+0RQmsqRKBLfv8hzlA=
X-Received: by 2002:a05:6402:354d:b0:643:130c:eb6 with SMTP id
 4fb4d7f45d1cf-645546857a9mr30183908a12.22.1764447351134; Sat, 29 Nov 2025
 12:15:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com> <20251126193608.2678510-3-dmatlack@google.com>
In-Reply-To: <20251126193608.2678510-3-dmatlack@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 29 Nov 2025 15:15:14 -0500
X-Gm-Features: AWmQ_bm9l5hxH1uNn1OhuD9i2_GMwgoosi8JwGJ0OqX1kcxryjhQxFIZ_S_EjcU
Message-ID: <CA+CK2bDhr-ymK7mKxYpA-_XJ9t4jEr3dMQH-5c8=jbtwVvNSKQ@mail.gmail.com>
Subject: Re: [PATCH 02/21] PCI: Add API to track PCI devices preserved across
 Live Update
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Philipp Stanner <pstanner@redhat.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

> +static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
> +{
> +       struct pci_ser *ser = args->obj;
> +       struct folio *folio = virt_to_folio(ser);
> +
> +       WARN_ON_ONCE(ser->nr_devices);
> +       kho_unpreserve_folio(folio);
> +       folio_put(folio);

Here, and in other places in this series, I would use:
https://lore.kernel.org/all/20251114190002.3311679-4-pasha.tatashin@soleen.com

kho_alloc_preserve(size_t size)
kho_unpreserve_free(void *mem)
kho_restore_free(void *mem)

Pasha

