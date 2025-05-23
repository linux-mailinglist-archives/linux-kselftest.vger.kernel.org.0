Return-Path: <linux-kselftest+bounces-33725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D59E4AC2C5E
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 01:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7B91BA039B
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3A922A4CA;
	Fri, 23 May 2025 23:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3cbeesok"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A37215779
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 23:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748043073; cv=none; b=Vtn2Q/6lDGkfamnsmPzjtcZQ4Bgg2yfmz9N65bk3c0LREgYWoC7LG8CnWMxp0J49mWyQNo4sCRzjWZ20wki0DzpwreIKNIvfdWgQcBRtmNlq5po7m5bDlFLSJRNMXvoRxVhZWSuvvyexuBZ41/Qao08qtUWj3rwJgIT0pHOGLlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748043073; c=relaxed/simple;
	bh=iRmwnk0PM4Hf3mgEI6zwXc+LDu9EVp0n9/ZhsmiqBxk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VL57X3c5OwLgEqnzEY87g2gkX6fgzV1lM6s+tkNWLe2gN7SjUq4onfmFFoNRpxjCizqb8YMfl1NGzTzy+0Y5fIJdeIJgnLRX4PwhsWX+6kwuWqDSDGE33WFiOAUt9P0OXXz4Q9uSyYdP4NVvahqvSYxHdLZsSuZqO+Qgmtcyx4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3cbeesok; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b26cdc70befso205901a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 16:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748043071; x=1748647871; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4vc5iaoQdMCELnH2bjQjNG3ycmxby9Jwfat7xnJ+cIE=;
        b=3cbeesokxX1HtedECa0vQUfWdqQelcTpWc3PVQfOwPcYv53QDNGE37k76zEPu/QwoQ
         RH3naQ9V/mJMCCJVQ5iINHHRvH4liIWEtA5AtWzLeGM3nIQpiSIkqSbMESYxtt6ZcEAk
         aq9buLOwkAArF+KBQpilppkbFIjyn8od3/VidHBNG7ZB1DZkc+7Y35JzgBPVimEW4GtI
         zQDQqT47aMBLmW0MK9v4JHqc3zVLa4DcLHSoUHp5/L02jwglT26714936J+r5u5NrfrS
         sm2LR/IH3InJqE4EKwayzdx+UCrST9D1ye1toXDElgKnFVNQroytzZ4EAZThe82lpniB
         a5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748043071; x=1748647871;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4vc5iaoQdMCELnH2bjQjNG3ycmxby9Jwfat7xnJ+cIE=;
        b=bMq2LOnYnMsPjLpRBT1/ZnLbyFUBdTRTf3jJDmGU5uE32soX3RhNjxakXQrrS1h/Hx
         9ATWCqW12FDTprmUeDXsvy1q/aBI8DkxIt3kqGCT37/oGCheoh6KJGH2SN9anV/PShls
         1owuInNBZIMa9FgqCM8K3PAULs44idqt6d6xA4ofxqbogTGUx8Qbq0x9CGPqWF5ONMxQ
         iiE1HX8Onj9PpxJ44mXAh7+4/k7SObapyDgytGYEbMzFzaMArxz/OEyNELaabsBl8XKL
         GxbxuKZJXA3W0w5MpbNjbwRuDN/YBnpOMDKOZDjxSprN8lcupPWFXmiRmKxjJW+J7Pl0
         1TYg==
X-Forwarded-Encrypted: i=1; AJvYcCX/8qBQqL0HY85blYUokwnsdpqUNTn5rFZ97nP/s4CBSA+Zf57gSdyY1OOBSnzn57t5ideSRTYVIuXC29ld1P0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNZBj7XJ8yhf11L+26sh6g+SxAzG/taNFCf8T7T6k88rDU7p6L
	am/jsWYa/Eg8MvCMOKPkzDV+UrerhwByKDF755IsI+m8LlbYzc4tjAUQAomvzoIPTd/fxAOLNkb
	VfDTwJhmz2zOBSA==
X-Google-Smtp-Source: AGHT+IENl5MZx9Ed61vrQtEhT0u+T8Rn2almAe9O4wV7zO3WdxHu48H2yMXx6eyRV4vIc9HaVDD+Ouk3nTGwEw==
X-Received: from pfbjw32.prod.google.com ([2002:a05:6a00:92a0:b0:740:4dd9:9ebf])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9185:b0:215:e1cc:6356 with SMTP id adf61e73a8af0-2188c2677f4mr1813659637.13.1748043070879;
 Fri, 23 May 2025 16:31:10 -0700 (PDT)
Date: Fri, 23 May 2025 23:30:14 +0000
In-Reply-To: <20250523233018.1702151-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523233018.1702151-30-dmatlack@google.com>
Subject: [RFC PATCH 29/33] vfio: selftests: Make iommufd the default iommu_mode
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

Now that VFIO selftests support iommufd, make it the default mode.
IOMMUFD is the successor to VFIO_TYPE1{,v2}_IOMMU and all new features
are being added there, so it's a slightly better fit as the default
mode.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index d996e012a646..d3c3958136cc 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -432,7 +432,7 @@ static const struct vfio_iommu_mode iommu_modes[] = {
 	},
 };
 
-const char *default_iommu_mode = "vfio_type1_iommu";
+const char *default_iommu_mode = "iommufd";
 
 void iommu_mode_help(const char *flag)
 {
-- 
2.49.0.1151.ga128411c76-goog


