Return-Path: <linux-kselftest+bounces-46585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A72C8C559
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 00:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A173B7218
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 23:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36616346A1E;
	Wed, 26 Nov 2025 23:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PHI/IxXt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82341346782
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 23:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764199078; cv=none; b=JB0GMTOvSVFbNvMb3CRIelZXRjeiDxdZz6nWBAC7XBMBDh86/F65UAqnEEvRsTQ7nHnWcrGfrxF3PO3hIaH2VsTyVRK8l0hFD75UGmgYaHpClQ0BJ2WDeocb+6XZH5XohMPxuTI0lrAqYSFwLVYSSTFcCfQ6LA9DRsYZXAgP5QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764199078; c=relaxed/simple;
	bh=k1tQIewzaCgltNFiSSWL8XaCn9LhRqqy5e6y7F2p37c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XwGxR6QbYj9gwRSF+yQ9HZFd5sXvDkQMqoMkNN0gD4Vl589vwQ7quy4jKfvTK7vd36iZSRvDsMow6Gz5k28m53v4vUzT6fyMWNkE4GBW8sWSpgnyBIcqFf0CNv+Jwvc328a9raAdPl7/mR9HQwYp+l0EGA0M76XKfs4byhbxJ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PHI/IxXt; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7c7957d978aso196542b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 15:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764199076; x=1764803876; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lOfh0ZHCrUDr+83C96eRTcOw/RRmvXPhkUJkr4j0xPg=;
        b=PHI/IxXtn4VtAj2XcOXS2zJeFshcM5kaSA1f6uyOXgLGSH7WzTgj7l5WxNRUn3zV8L
         YK+PUAmRfJ5qNhGQxVwTBAKS6tQbe9MdaPG0OJtc4HNW2WH6iNLJ3grlfWatQQ4tFFOy
         eNJhIAllpgS+USnI7wkehL4C1XLMS0yh1yeZl7eXTPVMbgF6HZQrYZ4KMEvQ+Bxl+mJa
         gsN7a53J1JiLleulPLh/9SMKjaPkSKnXMAHSTgwb/ed1MnO3z1/zg3LDRjn7zT0iBx1H
         VvVFgRUCo61fzYjwcUfhYVvaCdd+LaIX0SAASbNb3CmoS8y4YAIVlzhEHreKkOlXzX3h
         aXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764199076; x=1764803876;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lOfh0ZHCrUDr+83C96eRTcOw/RRmvXPhkUJkr4j0xPg=;
        b=Qrsq3q+QH59/PPQCNACzqwV2ARpwyOSRNbJANIC9YfS3sJludS8QaRqM5jxdhaPsNh
         VWMoJa5oX+qsoKGarkP5Nll47l3QDso9Wtl+umY9HOxkI/WHry9ryYACxxcK6/D5O77r
         e32iNOI99SUDSKWLmgh4aXeCLhCJM1dD6Gptl/dxeesXkj8Rdh8slzkrlKCXmLtE6Jm+
         4W1l8LCYTNQzZhUVLYvB6eF1gR5rvRzx9izQzgB1T2Yf7HWN5BRTRFIgy7wtuHKkRJfn
         9vlTlb3GF3h9q1oDg5KUbbeJpJZYWcIsiGkPQbxU1A/YYiN6XhPSwb33Fcm+e6FGffEu
         QSVg==
X-Forwarded-Encrypted: i=1; AJvYcCUuEAXQpBAcq+B5/6ctRG4JJhfzSxr3692HpKN4yh+tL4MO05uBOprxGNs2vNC8Dr71Ad0JUiz+IyZQ7C9arQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2QzPF1mACnTgSbVNM4bmGDbRK4NfK18EJOParTl225ud1ya9g
	YVv1lNAWCdq4ptEWUvB65Vb1nUv3wnKdolUiHIa03NnN5EAVbxhy1QdDhRa3U2+JAPpq9Faow0r
	7F6tK9fMsN0Khig==
X-Google-Smtp-Source: AGHT+IHmJ+fr7Q1GH3an9MkfupTo7jjLnNjtNTKwF96iEI+a/Vr8k305CwqmodTnaoeO8QrvLpRa9pV1P1XcMA==
X-Received: from pfxx5.prod.google.com ([2002:a05:6a00:105:b0:7a2:d31:34ef])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:32a2:b0:340:db9b:cfe8 with SMTP id adf61e73a8af0-36150e1fc11mr23928810637.12.1764199075933;
 Wed, 26 Nov 2025 15:17:55 -0800 (PST)
Date: Wed, 26 Nov 2025 23:17:24 +0000
In-Reply-To: <20251126231733.3302983-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126231733.3302983-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126231733.3302983-10-dmatlack@google.com>
Subject: [PATCH v4 09/18] vfio: selftests: Upgrade driver logging to dev_err()
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
Reviewed-by: Raghavendra Rao Ananta <rananta@google.com>
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
2.52.0.487.g5c8c507ade-goog


