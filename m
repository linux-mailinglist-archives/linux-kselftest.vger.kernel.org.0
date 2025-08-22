Return-Path: <linux-kselftest+bounces-39749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561B5B3247D
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341BBAE23A7
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B0C34F49C;
	Fri, 22 Aug 2025 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KwlDTxEI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57B134F490
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 21:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897997; cv=none; b=VXr5EOXFWTv2XNUixZVqSdRpMyTTNI4aYJ2HeXlw7LI00upOAOKhH3NxhDFvgT9hROd2ZIA1Fv+hBAWHCpZVBsZqckOC5SXxKcxmjO/6nAN++XZgfXo9Qncu7gj1ANkDiu+HxE81nxKTyQ9UAGK6+op2WSBwq9esugCt4WZnuMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897997; c=relaxed/simple;
	bh=QAaSVnAZOjFKf/sylisIjOOXF6u1HhPRzpSw/kWVRgk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sj/m0RrNPv4D1H010uhk05nUeEHyImYijwI+lSpoQnuzQPuqdUW0ijfB8N4d+BCcJoB8JO8UyeOwQE/punYlUhcway51A3Xntno7/8ix9cHgPCPy0lB9GKswC5lQjVO+NwbQW0Z4ttyZYAdjcwoUS8AxiWhDsye/gnsUBMOdOKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KwlDTxEI; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-323267b6c8eso4706751a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 14:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755897995; x=1756502795; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A4DSJv40q29irREb8+Wi7uRC2ecWb42rYBObPYpAfH0=;
        b=KwlDTxEIXi0icDsYLYbh8bNawlcyHm1tOD1Nkj7ZCzAOBjchFz2ewVKqMVtGE0GhNI
         vM+3ZynaogsGA9U6IIYYI4NLDrUSvoUusMdPgdkFfrhft5SvdokvhslCmZCaOsPzxkZm
         188G4FU11ql+LymVutFsf8Zen7yl23X9D6T2mWUkSE28VhKlfr0sVVoMBdSRHXlmOFIB
         P+gYLpwP1XM+rBTBxlwIaCVXUjLlr4cQImrCqaPKqrLwsdg6x7I5mJifJONpNwmFOwhp
         YNaWzJ90tvnta6B4o9qik82KMLSWaTBKfVV4hiaAxhpD0nR3fZlTKzFnnWwrv7ODVZVL
         J60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755897995; x=1756502795;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A4DSJv40q29irREb8+Wi7uRC2ecWb42rYBObPYpAfH0=;
        b=RMwenRc3CMpoA5C26z/hddo7oBHUdK5EhrxQOxkdzpTenVCVotZeDskYPyzHW09iTN
         0pJHkumFOGOrO22206ltWMSDm0SiXv0fSE5QOyDcxJCThp9MGWBu/6pxWSpnJqAl37Se
         O0UXLEix1yfByI93ciIr058INLgsryqyxfMwfzIi4TE7oNeBdLtFH/oHJ8VakdCbGIGP
         vNCTmprxjiaTc+fcaH/H2sBk4YdqrHevN4gn+CSmjHgYxHrf3i9a38ipBybjusILTjnE
         yi36Wugtf1/Vb8FvUSEygRO/YK5VtNV3S1wVxw0de8EWr2yQURJZAYMo+3EpVMnbRp5c
         /uPw==
X-Forwarded-Encrypted: i=1; AJvYcCVmFMEmsUKAV9cVo/8p6N6pxyxx9kQoKpb6jJpF/Li1Unacbx+KmZ8RZosxWSklvMEX3GL6oZAF7LXlaGIQ/8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy08df+ehUM3rnxkP5uaF7gAK0xY4wLo+N5L3nt1NQs5d0Ab1mW
	tIyDG6t4xtX9hhBz6OiE8S7opK3GOJeZXQIyCxb7my4Rp+fl6xrwZgC3BKPxetemDwl27UKF3Mo
	cWl9uE2K94b4rJw==
X-Google-Smtp-Source: AGHT+IG6C+ETtnqDmoZlodDXAgqqA+I3ObXD6p8p8Kjw9UA6jkJxTcGeBBitpJah157R2b5pFfr7fyBckUmu6g==
X-Received: from pjbqj5.prod.google.com ([2002:a17:90b:28c5:b0:31f:3029:884a])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c47:b0:313:62ee:45a with SMTP id 98e67ed59e1d1-32515ef861fmr5833165a91.13.1755897995313;
 Fri, 22 Aug 2025 14:26:35 -0700 (PDT)
Date: Fri, 22 Aug 2025 21:25:05 +0000
In-Reply-To: <20250822212518.4156428-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822212518.4156428-1-dmatlack@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822212518.4156428-19-dmatlack@google.com>
Subject: [PATCH v2 18/30] dmaengine: ioat: Move system_has_dca_enabled() to dma.h
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

Move the function prototype for system_has_dca_enabled() from hw.h to
dma.h. This allows hw.h to be included from tools/, which will be used
in a subsysequent commit to implement a userspace driver for Intel CBDMA
devices in tools/testing/selftests/vfio.

No functional change intended.

Acked-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/dma/ioat/dma.h | 2 ++
 drivers/dma/ioat/hw.h  | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
index a180171087a8..12a4a4860a74 100644
--- a/drivers/dma/ioat/dma.h
+++ b/drivers/dma/ioat/dma.h
@@ -19,6 +19,8 @@
 
 #define IOAT_DMA_DCA_ANY_CPU		~0
 
+int system_has_dca_enabled(struct pci_dev *pdev);
+
 #define to_ioatdma_device(dev) container_of(dev, struct ioatdma_device, dma_dev)
 #define to_dev(ioat_chan) (&(ioat_chan)->ioat_dma->pdev->dev)
 #define to_pdev(ioat_chan) ((ioat_chan)->ioat_dma->pdev)
diff --git a/drivers/dma/ioat/hw.h b/drivers/dma/ioat/hw.h
index 79e4e4c09c18..0373c48520c9 100644
--- a/drivers/dma/ioat/hw.h
+++ b/drivers/dma/ioat/hw.h
@@ -63,9 +63,6 @@
 #define IOAT_VER_3_3            0x33    /* Version 3.3 */
 #define IOAT_VER_3_4		0x34	/* Version 3.4 */
 
-
-int system_has_dca_enabled(struct pci_dev *pdev);
-
 #define IOAT_DESC_SZ	64
 
 struct ioat_dma_descriptor {
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


