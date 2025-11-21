Return-Path: <linux-kselftest+bounces-46272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6DCC7B49A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 19:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D20024F21DF
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 18:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1988D350A21;
	Fri, 21 Nov 2025 18:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XknTcb0z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BE2351FB5
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748897; cv=none; b=IElqquYHhq7wLC144SkpbtXwJZLXoM2GGG+Et0SKd5I6PfkYvDkTjEKihTB3nfJes2oRud+QkET7kcnbGFuNBXa7ezv59l/Y6WwQM1CGo0MEDLm+fe7Jm9WuKG4WXmMcgetk4HfFItIJXo08BOaHP4ptFb/LuqN0LjZBSynrcyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748897; c=relaxed/simple;
	bh=EWzdxi/6D7uOhC0usSXd/odovIK6k2auEMXfrZlT0D4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E/MLDefcvZIZjxYtmDklq+P7dAHAm5tzwC2c95qVLGgd8Jiv4zZ1sGfUdNEmuMzzf/iuqrr3H1xywDD/Cqnpm36ObEla0UBO6eMQOOX9W+zOajjN326o95Cvoh08RBVmcGY/sYbQ+XXi5oGQRTQwN9TVJmuWI2RXv71FLiiJM6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XknTcb0z; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7bb2303fe94so2561481b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 10:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763748893; x=1764353693; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gxoRtWy7HuLenxKtZXNeAeuShCDGWTm4ZnN8F9lAoo4=;
        b=XknTcb0zqQmWJ09IthNfoNSVq43zP7nMCrsQ5FnG+AB8wVB5dhYE7xk0diORJr4ORZ
         kACjObXTIKmxdN6M14HpcrMTNb6EmVivSiAs4/VcwXFx/1OS3F4a0fbhuL4UXAW42F4t
         OjctWeXF8SUZ6q4NMuSRhW/To9c2ffiKZu/fNs6JizdrSENOUofmwOFmUWmQ/ycwpMdA
         huXEvdyESmZrMv14IuJqls4GRwGXcGxHDedYinQIxbjfOpikPn5kJ49csJjg0msLcl6m
         IIP1tDUfZuameuqnysjXmJSRzcSp9I8Ut5Ofq15LSc41OaayC6pFnrNXjQC6iwrhbRBV
         Xmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763748893; x=1764353693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gxoRtWy7HuLenxKtZXNeAeuShCDGWTm4ZnN8F9lAoo4=;
        b=EjiZMCKlm5Oj3Mx9DPHlenTv0v1FA0Rr+6gs7A6OnnvY+YOWZShlAhnhhHHMZb+Ggg
         MI0RdvTliRV/xMVwdJRWZMMZXfqDSw8qx4lEYbtmPVF/D3v/5wIrmzG5OVE+I+Ol+gIE
         D+QxyEYO8Q7ftQbDIH7EhWPMiS26nghuRoXHEum2g74BgYsrJEHmpZUi/yZ0rhXUjhII
         IRLrxqhWaNjUsXGrVOjrztMEksvwVq6t7M7xxEgS0UdrswzN0dhZLkVXVbB9BpyPPC+2
         cBP9K0y0aeEMFba/KCWYqkDCzgOc/dhs7Hdq+2jj69F+VhXYSi6Z8ZRttD6dWnxHUQdh
         O24A==
X-Forwarded-Encrypted: i=1; AJvYcCXTPNfEXaB7u7WGH/yfn+1vBMdLEoxJz1F9XXe32SLW0EG6TaEFZIK9cU1Xy9e2whm77NQfE7WS3MKi74RLfbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcYPLGvk0wKK1bwcWKGH5b0PfmK/IK6R1sFdcmYfmaKJ1Ug7cg
	57UN2x8786SzPOz7xs8FBYa56LsxHmcbqPEOWie0e3qIS/jlmUMpi3zXyOrVIxrR6okeL4DWLO3
	u75ZKiqU/kOVwwg==
X-Google-Smtp-Source: AGHT+IHQn7qr1/J/V6EApoKUiOvFm+H4aq1OEXxG+wD/Rq1YWwhDHIUSbBCfzvmajb9SiXfW7VESioXVGKGKTw==
X-Received: from pfih10.prod.google.com ([2002:a05:6a00:218a:b0:7b9:3791:eaee])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3d12:b0:7b9:df65:93a9 with SMTP id d2e1a72fcca58-7c58eaf27a7mr3961144b3a.32.1763748892978;
 Fri, 21 Nov 2025 10:14:52 -0800 (PST)
Date: Fri, 21 Nov 2025 18:14:20 +0000
In-Reply-To: <20251121181429.1421717-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121181429.1421717-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251121181429.1421717-10-dmatlack@google.com>
Subject: [PATCH v3 09/18] vfio: selftests: Upgrade driver logging to dev_err()
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Alex Mastro <amastro@fb.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Upgrade various logging in the VFIO selftests drivers from dev_info() to
dev_err(). All of these logs indicate scenarios that may be unexpected.
For example, the logging during probing indicates matching devices but
that aren't supported by the driver. And the memcpy errors can indicate
a problem if the caller was not trying to do something like exercise I/O
fault handling. Exercising I/O fault handling is certainly a valid thing
to do, but the driver can't infer the caller's expectations, so better
to just log with dev_err().

Suggested-by: Raghavendra Rao Ananta <rananta@google.com>
Reviewed-by: Alex Mastro <amastro@fb.com>
Tested-by: Alex Mastro <amastro@fb.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c   | 4 ++--
 tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
index 8d667be80229..0afbab0d82de 100644
--- a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
+++ b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
@@ -70,7 +70,7 @@ static int dsa_probe(struct vfio_pci_device *device)
 		return -EINVAL;
 
 	if (dsa_int_handle_request_required(device)) {
-		dev_info(device, "Device requires requesting interrupt handles\n");
+		dev_err(device, "Device requires requesting interrupt handles\n");
 		return -EINVAL;
 	}
 
@@ -256,7 +256,7 @@ static int dsa_completion_wait(struct vfio_pci_device *device,
 	if (status == DSA_COMP_SUCCESS)
 		return 0;
 
-	dev_info(device, "Error detected during memcpy operation: 0x%x\n", status);
+	dev_err(device, "Error detected during memcpy operation: 0x%x\n", status);
 	return -1;
 }
 
diff --git a/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c b/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
index e04dce1d544c..c6db311ce64d 100644
--- a/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
+++ b/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
@@ -51,7 +51,7 @@ static int ioat_probe(struct vfio_pci_device *device)
 		r = 0;
 		break;
 	default:
-		dev_info(device, "ioat: Unsupported version: 0x%x\n", version);
+		dev_err(device, "ioat: Unsupported version: 0x%x\n", version);
 		r = -EINVAL;
 	}
 	return r;
@@ -135,7 +135,7 @@ static void ioat_handle_error(struct vfio_pci_device *device)
 {
 	void *registers = ioat_channel_registers(device);
 
-	dev_info(device, "Error detected during memcpy operation!\n"
+	dev_err(device, "Error detected during memcpy operation!\n"
 		 "  CHANERR: 0x%x\n"
 		 "  CHANERR_INT: 0x%x\n"
 		 "  DMAUNCERRSTS: 0x%x\n",
-- 
2.52.0.rc2.455.g230fcf2819-goog


