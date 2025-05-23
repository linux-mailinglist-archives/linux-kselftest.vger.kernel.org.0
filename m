Return-Path: <linux-kselftest+bounces-33723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 592C3AC2C59
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D2047BBAFF
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E81F226165;
	Fri, 23 May 2025 23:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="THEwdBLV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF28225A3B
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043070; cv=none; b=WYpbyYpki8FsFSzAwjprtodUj7Ky4XsOUPm5SswQT029E9WhB8lWuN0hFdU475Js9/X3KVMbRaMGjyTLgMUmXZaw4zRD6/PHiuZSpJcKr503VDdCwEamYnHuhb0HRbAtgrSM0TAFZtXvJYTxPMJaYQKaCYcUh+9zoqoZuIzRSB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043070; c=relaxed/simple;
	bh=PGrPt1gk7QO/nZNg4yZH9qe0Lf8+bFEWzeJhzrdoMOI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Maxxc4/g9JFjKrQgC4veITbILra1jF6X5xx8TRCFV0CldAtGoMgWMi7+cEEn1g9TBzjO5kOJb3S7sK2Khfc6hVl5U+emUrgkX4j3D30VYFJVpwMh4Tuzr5+umweMJ02MlFOYVOq+l8+DU9QYmwN5QpEgQUS4/qDnRhgyg7Sj3ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=THEwdBLV; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311158ce5afso243828a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748043068; x=1748647868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8nIBIncr92QRBFJc4uveiRwN6XxEWnD1cmrWaQpbkpM=;
        b=THEwdBLV4SofFZw4G7ntp9lLPqkHXi4zXKF2k8iHZJt21CCtg7v1I6S5GPjrM1Z7CI
         tPWUx5R0XmgNB9ug7BvmhVvYnB6YbHLFdfrP+vN3FG9O5y1rgeWLiJeCNC/UkmDYjGh/
         oCKtCpgy/xVL0Upmw0TE6zkuyDKIC1R3jvYEUT0vjGGovKWd4FAH59y7McheZ6ByfWWN
         ldP1Y+H9RGXi7dnWwGnvzQOH29y+FlhgGeXH5H0e1Ckt29LzPetHj0BaFl26HSqk0LWR
         7L5L9oP4G+fiDzFovgRpKtD+3mge24InXKB9XtI1FbYxiOJPGE3nOC2/ij9FBXUtsWgC
         pUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748043068; x=1748647868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8nIBIncr92QRBFJc4uveiRwN6XxEWnD1cmrWaQpbkpM=;
        b=rMeQoO6Kh20ntmdxHFK5cqsEEMYIryL5Vah6Ff0CFxy92sLkKqwRJHeETBMiZfm3kC
         y2+7b8zYiWRvaYR223mrvCt7KlSX5LfcK8LbzcxmmUj8DYu+J5GFM4yLaVUHmiFvMoaV
         j7yyVsujK8MFGsIobhPMHBOR5YAU6q9tjITK1REoK545r3knF7RCQfBQwBVW3yjrkDiZ
         +j1Hq4ReO9D1xiXJDd64f5C6+qYIc2L03N4+64I5UwR9cwcoINJk53/0ydjkGwheNySa
         YRK2E1m/mQ0uvpAZytBCw9WCe6bSAqNflvTuvWKKfuuzR2Y1ujywtaKIQZ0cJZr3Pj2b
         6qvg==
X-Forwarded-Encrypted: i=1; AJvYcCUqOzb1vygK8lwbbjjqlOkQDu7F6h4Y5lvNh1PQcffDXB+GoZMpRuGUdH4+Q9Mv3bxW5dHTHiT6Eq2VmqK8ers=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpbu/MdlUmYz14g7c2LBlG6V8EPhUQ7y1FLRDFGN/zXxq9IbU+
	FHs9CI0A7cs3H8S2f3rsAtNzrMv/ebAE6kuE/EwuQW5/MbQ/db8leqdr9VKXQ0W/EXuZzxVYFBO
	3qFBCpG5nhFZxQA==
X-Google-Smtp-Source: AGHT+IE5fec+WQbHBoCMa3++Nmm00mA9nDx512f1g565wlYHYNSf+gSbBwJcM9UuSPMmVVMpbBGlduomktU3pw==
X-Received: from pji7.prod.google.com ([2002:a17:90b:3fc7:b0:2fa:a30a:3382])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:164a:b0:2ff:6608:78cd with SMTP id 98e67ed59e1d1-3110f30892fmr1630472a91.9.1748043068001;
 Fri, 23 May 2025 16:31:08 -0700 (PDT)
Date: Fri, 23 May 2025 23:30:12 +0000
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523233018.1702151-28-dmatlack@google.com>
Subject: [RFC PATCH 27/33] vfio: selftests: Add iommufd_compat_type1{,v2} modes
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Matlack <dmatlack@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghua.yu@intel.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, WangYuli <wangyuli@uniontech.com>, 
	Sean Christopherson <seanjc@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>, 
	Josh Hilke <jrhilke@google.com>, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add new IOMMU modes for using iommufd in compatibility mode with
VFIO_TYPE1_IOMMU and VFIO_TYPE1v2_IOMMU.

In these modes, VFIO selftests will open /dev/iommu and treats it as a
container FD (as if it had opened /dev/vfio/vfio) and the kernel
translates the container ioctls to iommufd calls transparently.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index b349d901cfdc..205bbfb3d54e 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -371,6 +371,16 @@ static const struct vfio_iommu_mode iommu_modes[] = {
 		.container_path = "/dev/vfio/vfio",
 		.group_iommu_type = VFIO_TYPE1v2_IOMMU,
 	},
+	{
+		.name = "iommufd_compat_type1",
+		.container_path = "/dev/iommu",
+		.group_iommu_type = VFIO_TYPE1_IOMMU,
+	},
+	{
+		.name = "iommufd_compat_type1v2",
+		.container_path = "/dev/iommu",
+		.group_iommu_type = VFIO_TYPE1v2_IOMMU,
+	},
 };
 
 const char *default_iommu_mode = "vfio_type1_iommu";
-- 
2.49.0.1151.ga128411c76-goog


