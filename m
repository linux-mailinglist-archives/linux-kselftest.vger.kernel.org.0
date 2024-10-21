Return-Path: <linux-kselftest+bounces-20249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF329A618D
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 12:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59F681F20978
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 10:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074E91E47BD;
	Mon, 21 Oct 2024 10:06:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696951974F4;
	Mon, 21 Oct 2024 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505218; cv=none; b=js3WYm7LrX4HzNagtYCT+eTQGjbCzz2F2J3r2tKlDOC++tD0cTYB09MmfyQkw+nlw3vKsoww5m+d+4GlDBfFIR2rPVn+XDtPyh41eihdXGdbI0x/CXd3vpI6i9y3EuCWRZ0+7aOSJvN2LvmuNm7waQWdt4TifsHUbuaYQrY6xJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505218; c=relaxed/simple;
	bh=jiNx/VbfXMWt8MLnrl4L90+qNhzCBpFOuZw48hxTOKs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dxLPcrC8n4K0e76vH/UBIcVh65Jstjh0+7UMxYGi+r4y5CFokv5Mz8UZ7l57JfIn3HZ4YG04yY7k2BUgrbN1RtGXOR8yY6LBU80IB5ouzHF/fXLgaoe2z5IyIyENQQK6ebeYiyXh/WN0pKkfxWVckYOt1o0OlyXS8iLl68zYfp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee5671627bb7b3-557c2;
	Mon, 21 Oct 2024 18:06:51 +0800 (CST)
X-RM-TRANSID:2ee5671627bb7b3-557c2
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee4671627bad7c-47302;
	Mon, 21 Oct 2024 18:06:51 +0800 (CST)
X-RM-TRANSID:2ee4671627bad7c-47302
From: Liu Jing <liujing@cmss.chinamobile.com>
To: borntraeger@linux.ibm.com
Cc: frankja@linux.ibm.com,
	imbrenda@linux.ibm.com,
	david@redhat.com,
	pbonzini@redhat.com,
	shuah@kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>
Subject: [PATCH] selftests: kvm: Adds a judgment on the return value
Date: Mon, 21 Oct 2024 18:06:44 +0800
Message-Id: <20241021100644.3591-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The global variable errno is not recommended to be assigned,
    and rc in the function does not check its return value, so it is fixed

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
---
 tools/testing/selftests/kvm/s390x/cmma_test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/cmma_test.c b/tools/testing/selftests/kvm/s390x/cmma_test.c
index e32dd59703a0..c59c21f28bbd 100644
--- a/tools/testing/selftests/kvm/s390x/cmma_test.c
+++ b/tools/testing/selftests/kvm/s390x/cmma_test.c
@@ -210,7 +210,7 @@ static int vm_get_cmma_bits(struct kvm_vm *vm, u64 flags, int *errno_out)
 	struct kvm_s390_cmma_log args;
 	int rc;
 
-	errno = 0;
+	*errno_out = 0;
 
 	args = (struct kvm_s390_cmma_log){
 		.start_gfn = 0,
@@ -219,8 +219,10 @@ static int vm_get_cmma_bits(struct kvm_vm *vm, u64 flags, int *errno_out)
 		.values = (__u64)&cmma_value_buf[0]
 	};
 	rc = __vm_ioctl(vm, KVM_S390_GET_CMMA_BITS, &args);
+	if (rc < 0) {
+		*errno_out = errno;
+	}
 
-	*errno_out = errno;
 	return rc;
 }
 
-- 
2.27.0




