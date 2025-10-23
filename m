Return-Path: <linux-kselftest+bounces-43830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 797BEBFEC82
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 03:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A77E19A751F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 01:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E785F23FC41;
	Thu, 23 Oct 2025 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcfT/tLC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D2F221FCD
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181233; cv=none; b=BejactnIFbgKXpjU0TVJ5sBm6nZt/v4zqQFe6HJpDQoEhBYVBBB9zGmkklJAXxWb3n5e7/19PPe5GXZ2LQ50F51qpJL/4NDRW4Hj0N3NV7IcifemIaZW3aTX4zOTfxxBMWFivG1aFClIMliauasHA7zJPCbb5NpraRmnqL8lA28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181233; c=relaxed/simple;
	bh=53S5Zx5/+dq3CxymSoKg3PxckRbS+/iJdEXFwbACpeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AGnmtAdycHqmpoZkAATBtf12ZUqp04FMpafXOzg9v7NK1gjNR03hu5GNuhLU/KygAVdcocQNJTjjRxVWl6wmvPfI3Z9rBc3g6kb5RKL0CY70cuTLn8VGBqovVjLQKcVgWbDAzV6jyTbTMYgWekmOv2Xg2lYa7N/uprP0C8UF0eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcfT/tLC; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso254216b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 18:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181230; x=1761786030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6hhytdydN3st1fvO6O+FLwguIsO7CYdeOMt51FRiMAY=;
        b=VcfT/tLCM9qe93/s9wsAmucZa7SSwKxk8qkYaI5I93SRF0N+TGfTwwu5PDNEhkYqhS
         JWK31iSk4WICz+bvPoVUW53zHVBSYoAyg+iaxwp8NsrdI0JkxrEs0A1CKuMahafjhKJD
         7547O6hlO+eIOkaTEifFj1li4tk9Tuh70zSLJSGXuYBsG0LXvH0bPuBu84MiGck2ip4H
         F5WqniA03/2cZq3P26FPqZZFNJe7w7qTdNEUqjZBp1XPHjoOi3IPHhhblVaP3QAkrOP1
         Ryp35MorM7iq4DIySQaVOAHTUFN36koedCBpu9PQc8PXNOzE2ktYhHYdNPrPUUkPyKeH
         E2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181230; x=1761786030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hhytdydN3st1fvO6O+FLwguIsO7CYdeOMt51FRiMAY=;
        b=XW3a1SC/uH//BFIr0Tu93Tz0b1sYBSZ5+QpK/K5PNrqiVZsWC+Nlj6Dfx3Ho3djB3P
         susZS8ngruTGf5F2gSZmT725fN27VK599aRFlePPchlcFGBNh+S5Dds1aLVgh9YMIv4Z
         +HyuNRAF4+woOUMutG8spSME7f2pb0Bz/zyGobh1RwVC+FVWg4lzl796sNNndv6sMXCU
         bkas0NxuNXxQDTHvxOwELdVDPFcJ+mRqP2wyclvCcndJrLXzMXF47vX4p6HqcbgH4ss4
         fX66BxpXWIQleSzAA68ZYk3I2yxzHq8+Sgt/GO8QdL10DA4CSuFhv0jU/BzpickjuQoM
         D4oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRrdGM4WpeFbIj2hc/U2iwAFfxH8SCDaAmELGb+EIcgfW/uOCj/rnC2fLdfEaMeuarfOaTwk9Ug4ciD9RLbqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYPH60ZNE0JJhR6/P2+txlRrtOoeQAKjjac+LgEtGY32fuH1vd
	0ivLFWEzyjsYG9PYtSKgwzSiPq21JDzpqQYmxvmQJ/xFwDFnX8DYniLG
X-Gm-Gg: ASbGncsUuz7Y/e5BDKgrZ2g1g6yn9gwCtMu/cJijb04oNSddmRKmXsaWttnkCZCaFkJ
	hwXZcRco5DM8kBoewTCzMDCueunHpJmGq7UscMjezUj/ADPKpEjlsDcxciIkRUkpIsDie3cCrcp
	BSg5fb3z8yJEJHND32yLl/bwGeEhb2cNLTCCvTQbNKGFpshi7dAi178jAFIuE378bpKjaI1Wl7Q
	6XGH8xN8vvsCPsDrxgXrhIYFmQSMmWzZlkTOAGIqORBFrNHBFXrRySykL5JvLuLa3F4zslLQ0Kl
	RYexzlH1PgIDL2P61HuZQt3/tDTUm7O+ciohPlJ7N59oMw9NF/Fm8nf4r8gmpl6g0SJvMYuh1M0
	Us3wTgLX3sCDQvdM+tT1XoZkyzF9PWFDa8Eo34tOHt4dcOKrbino0KAAXE/YhNj+I0mBu5QVyCn
	GxytRS+LMd
X-Google-Smtp-Source: AGHT+IEOLFrEwrP2Rf2uPvi/YyHr9hHzHgOPOlWS5DL5z4avx5Oje0geKjvDdLHF1RWLtx4Gg/89VA==
X-Received: by 2002:a05:6a00:4fc9:b0:7a2:7458:7fc8 with SMTP id d2e1a72fcca58-7a2745880c9mr1173130b3a.13.1761181230338;
        Wed, 22 Oct 2025 18:00:30 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274b8a0edsm560059b3a.35.2025.10.22.18.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:30 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:10 -0700
Subject: [PATCH net-next 06/12] selftests/vsock: speed up tests by reducing
 the QEMU pidfile timeout
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-6-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Reduce the time waiting for the QEMU pidfile from three minutes to five
seconds. The three minute time window was chosen to make sure QEMU had
enough time to fully boot up. This, however, is an unreasonably long
delay for QEMU to write the pidfile, which happens earlier when the QEMU
process starts (not after VM boot). The three minute delay becomes
noticeably wasteful in future tests that expect QEMU to fail and wait a
full three minutes for a pidfile that will never exist.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 6c8f199b771b..99db2e415253 100755
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


