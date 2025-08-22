Return-Path: <linux-kselftest+bounces-39760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7978EB3248A
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3811E68566E
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87096352090;
	Fri, 22 Aug 2025 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ia8PjAIB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFE735207D
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 21:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898014; cv=none; b=gOugtCh3O7v0PvgtkDX5ukIa5A8MNqnKk1/V2QMTw6s1A1vBNIRbAPU1f/eOCma2r81e3JFdtFgOv7IKu/JZOLq/7HMUD/+yDiG6PIzm4U3kGTbp1I2W7cHM3BM8dCdTSPSIxiXn16KnpJek83Ovu4lYydbgRshRWSLXLhrTGY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898014; c=relaxed/simple;
	bh=tqiS7f8RqPjxZTBzbYxtnIVOIPx6X1mgaU2QnSAHmC4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MXTsokgvqtp/NulbVaGEVLiCEc2eMQBjPAIDAk7ZWR6iM17WCTL5NbpwWJuybsxzG+7+8gC6LZPgSTztpT1nt4vZnvRNX/qJtRO2mJNO6PUmtDsnQylIwH+6fuN4VtUqeHnxVMQfzmO/ZYnc+ZK3uw1vssbivsE6ktA2QewGObA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ia8PjAIB; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b49c1c40e12so810815a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 14:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755898012; x=1756502812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4mgLMBaM8oUts+mNa000FNI4F6bOcEJy7U8rUhSocsY=;
        b=Ia8PjAIBU1rRACU/9DOxWkl6YuxC2CFh13kUyX5kGtEIhfox6V4EObKrMCgiMK5Hv+
         7HFLlYCKoZAcYGmtvGqesW0vx9OvLK67crD27H7m8QaNBjVSBVHPkkXZx+/Pu/JJKO6A
         En7cKRaYJxabbt2/2OnKiUktbQNTtbsOUrVoot48bE6GIEE4yQqg/k1hMZJSAo9Y4/if
         H6iE5G5B48fBfSxBQJUkf7Z4K0lwoiN25sRYd2GcwdWgIiW8UARxtxQUZC6K7E8rPSNU
         IgoD07FD9eKofSWuXXx44ee64N7NqdrPvHEi6OngYyuWut+GT8dWOXDfw5eCeUCdj+AG
         4pEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755898012; x=1756502812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4mgLMBaM8oUts+mNa000FNI4F6bOcEJy7U8rUhSocsY=;
        b=YIWR1NQCGK4fytAkSJmCKB0teVghYLUmCx9xdV0VTtyoRMu3sRsc7N1bN364RWqFuc
         M2W7tRDqDzRMWDhXkj9od9mYtI9K7VuVSEZaeFBvWoLZB22u9X8XKfoF5dnK0axHtCY+
         e+4g4iWP79FfT2fQn/RiihzHao6D88qT0xN2UpiRTNo6hILygwMBMHHtV0xp3nlbsKVQ
         a9XbvbmYmbRVtP10HkTlnPjyaExZaNwg7HML8P6haMttcJDm5z+67rj+rd0n3bupNRSV
         hB2No3ZMoafEBNR3ee573pu4sBVw5XgUHYzaF9TZha6cgZIi5318r94earUKDa4iFkvx
         agzw==
X-Forwarded-Encrypted: i=1; AJvYcCUw7Mkh1dlc+t+hcBErRDCotwKu9Dbf402rATu1wPR1UPRvTpn0fytjfoHMYXvZQ74SpY8uwVIChOb4lpvt+tY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKHFEC0WUlhRJI9Gk42gZQZVyMLkFeQ4U9lXuPU7UkzV1wL6DG
	7s6QPhuo33iMU7ZeIRqa06qGOsn4omt9qBfhLQIKoans+SL+/EhjzXJNp2rYuU3YTefWUIA0ucS
	hbysSgh6w+RJWcg==
X-Google-Smtp-Source: AGHT+IErXOcqm1EB2+I7Lc/FVRFzxmEdfL5ok1npv6xoKKW5r04XsPpcuj3rajrRYaZxil57huRpB5twK0Qgzw==
X-Received: from pjbse13.prod.google.com ([2002:a17:90b:518d:b0:31f:26b:cc66])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:1585:b0:232:7c7b:1c7b with SMTP id adf61e73a8af0-24340c429e2mr7526997637.14.1755898012344;
 Fri, 22 Aug 2025 14:26:52 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:25:16 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-30-dmatlack@google.com>
Subject: [PATCH v2 29/30] vfio: selftests: Make iommufd the default iommu_mode
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Aaron Lewis <aaronlewis@google.com>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	David Matlack <dmatlack@google.com>, dmaengine@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Now that VFIO selftests support iommufd, make it the default mode.
IOMMUFD is the successor to VFIO_TYPE1{,v2}_IOMMU and all new features
are being added there, so it's a slightly better fit as the default
mode.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 5d8944a37982..0921b2451ba5 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -437,7 +437,7 @@ static const struct vfio_iommu_mode iommu_modes[] = {
 	},
 };
 
-const char *default_iommu_mode = "vfio_type1_iommu";
+const char *default_iommu_mode = "iommufd";
 
 static const struct vfio_iommu_mode *lookup_iommu_mode(const char *iommu_mode)
 {
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


