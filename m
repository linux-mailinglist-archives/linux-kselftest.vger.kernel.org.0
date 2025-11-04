Return-Path: <linux-kselftest+bounces-44764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F77C33436
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 23:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42BCB4285C1
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 22:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BF9347BAD;
	Tue,  4 Nov 2025 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMLbSDWH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C00346E5C
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Nov 2025 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295957; cv=none; b=Uwefbo5TSKB44WXWz0L/w5jrPiXHaPGmMl8XNYob0EmqGRuHbOo6RMz2Iv2NUVmGJHUZF4BvkkrwN/LXjy4BhYeBi1yTN8r159uFUBN5N4tuDAB1tUAwEdiPGLUc6VSlShEAUp4mI/OZkStRYQZ3r7zyEFR3Fm30/XWn+Pnn3h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295957; c=relaxed/simple;
	bh=hLx98oFksm1euOd3gRvzTKc2fkdp8CNEeWRtz4krUsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IouUeRBaC82OnbcIkmwVvRmQ6rkONIaJgRkgv/Q27kOkgXcyDCwlCLYkz9AwFqiN3vTzhUq066v1//z9TjIuVs1DyoBBD+WwU0NXrVD+tigSfrxaun9UUBzydLaBYj07SdgeEsI8DxuGl1mKPk0QxXlGaBZmaAuvWx1tpMDSUQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMLbSDWH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29470bc80ceso4044185ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Nov 2025 14:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295955; x=1762900755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7NPOoIdp5+m43RuZesJ5XJFKTqD36Mp7WZTcw49QJWI=;
        b=HMLbSDWHK18Avq74DI56BBSgIkRB2C/MfQ2JDwb8qjy1/Ukni4jFk6QZkjR+FXwzX8
         nNwUaMT306RKmz0Yr1I+ipGPg7c2w8HeYEfmpjXLGnGUqCo6QOMdBSR+oFlf0YTScCvM
         IEKWT1HKomSIRLODBZAfoDjImqNd6VZEcFmaSv3Ij2nZE2GxnvFrNJSNpG8TF0pyG5Gc
         sKSjbQ5kx/rF7b4/emj+U0gdEEgNj0exMS/44IaF2xDRMikgPqUNiZiF4Q+45mVYD6Uw
         C3gd9xqpoOVqw07SyeClO1Utou6poiEo17vC6Qt63HBlQQVQK8/u/epWSEL+XIb3pC61
         lugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295955; x=1762900755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NPOoIdp5+m43RuZesJ5XJFKTqD36Mp7WZTcw49QJWI=;
        b=keE73G1S2QoBWpQbRSBJVwdB074nZ9JiNOtX00KBQCNqwz3Ng3Apx1DvTljxXbr6zM
         lI+xg2/kXqANCMHinIcd1Pu8u2WDZwyP7OAFdC5vvQ+IQKMihx+sPr38VxNZWmvBn6Tr
         HinQye1NqJYAo3vi0+HczHx4MVQLC90mCVrTT32XS/cygDN6EOfxFEe9NU6OItxgCUZp
         RiSvILhNQ3363lm1wSwL+GhEI2i20aSDwfqn3OpcD9PDz71SD85PWfi2uLJZnwRoY3Xy
         nH7sQt1RglRnR3CSX2dhR2dm47phSUFYDEQsXcx5JR2pxUhw7tDSu+hMeWcDSY2T91n4
         k62Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcWWct6jpAfQi0ari4is9eaqsk63isDxu5OQUcuLq3ebWwst37yymi4RqHBb6pnEq5jiJLo/UHIwopxMQYtEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0xKHA+XS07/YasQ+3QCHeGw5HBlLrVNus3Sb3ZRb1aaHHe+DM
	PM6axgK4kZ10Za7DqzHUkehmHg03sbdrNf05ONcAeKDlz/qVDVCzthNz
X-Gm-Gg: ASbGncsI0+7UvKJy5GdmJRHcAZ3OSpEGjx1JAqU9Q7CpZhCs7ROgpzZmnu9kJt72cZ7
	ths+iTddIJ5dqhSqoQYDtyWWQX9e0Kl4V6uY53I22c2YEWx9OB1DWz2wAZBAgjB/W1b7Co1VQ7s
	VvyV915oT5RpndowyZ6Emvf76Nr3pNCV6LYHGTnARbo8xTZ8pv2Un2J88wYDf2GUs1eQTFkfxFu
	QqIvKuAG5YEKgl4IVmQQroWdGHSPEIz/w9Uplp10Yk/3NjbiNN6AUc0GXhhB+as9rKqg21MNc2Q
	VKM2S+iseNR36GVeweYblEVCS7m90HTL474e7J6KgIU8vgXH5QtdJpODHx8oI3VzOW6wEqtpFZi
	HzGpbSBAlR5ODJVtb0HJX/lEwsr91A4s/0oeCCIr/WmdJzWyrMha4ocal32J3AlzExpxUOwPwqA
	==
X-Google-Smtp-Source: AGHT+IFcWJCIHYENfyxIioaojYZp29/Ndik7t8pPlyOLj+vibXcfDiidJwI3fcQfTIxtp/Uq8IFSMw==
X-Received: by 2002:a17:903:22cb:b0:295:55f:8ebb with SMTP id d9443c01a7336-2962adb7080mr13883295ad.21.1762295954777;
        Tue, 04 Nov 2025 14:39:14 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:47::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972ac6sm39637535ad.8.2025.11.04.14.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:14 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:56 -0800
Subject: [PATCH net-next v2 06/12] selftests/vsock: speed up tests by
 reducing the QEMU pidfile timeout
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-6-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Reduce the time waiting for the QEMU pidfile from three minutes to five
seconds. The three minute time window was chosen to make sure QEMU had
enough time to fully boot up. This, however, is an unreasonably long
delay for QEMU to write the pidfile, which happens earlier when the QEMU
process starts (not after VM boot). The three minute delay becomes
noticeably wasteful in future tests that expect QEMU to fail and wait a
full three minutes for a pidfile that will never exist.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 81656b9acfaa..940e1260de28 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -22,7 +22,7 @@ readonly SSH_HOST_PORT=2222
 readonly VSOCK_CID=1234
 readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
-readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
+readonly WAIT_QEMU=5
 readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
 
 # virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
@@ -221,7 +221,7 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	timeout "${WAIT_TOTAL}" \
+	timeout "${WAIT_QEMU}" \
 		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 

-- 
2.47.3


