Return-Path: <linux-kselftest+bounces-9789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4778C1210
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 17:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849582828F4
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 15:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3655515F416;
	Thu,  9 May 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="l2NteKRJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A3D12A179;
	Thu,  9 May 2024 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715269098; cv=none; b=bjKAKIF4sqhNBqX7LcZ1pa0gDg+By3Gxn7o4zGFWMVSP54LKhXYodt4W5Nv5Swrdj5DLGjJKX8RxcYhi5IreXTBXKfrqrd5kZXq6VOfZwePTE242dIXuu5fDa0RaFatR74VrFnzLZIKikL2yNdEuPzi2bkhqQYHijeBpZ1Yngxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715269098; c=relaxed/simple;
	bh=nANHlT8bQuzaSmFK3lwpS7Cj4BPy1dbSvsaWfROiQuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LNgFo3//ZuQ+/JuGMqaZYmjWuRg27I/wXvE5PIA3Sepsy0skYgK3NNJfSbMmuFoZ8jqhhYEUIIR9Vghr1mImk0FsqGd2XmK+45AyezDZI6A2Ps+FYM8c7gesAj3gqBsoL5nLKDycdX9QpRv7yLoHhCYKFCjrhkwHYMhFxTarKLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=l2NteKRJ; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=50SVXh7j8YqDqiQBc6TkcGnGUn+l90zrT0o1BlM2Ags=; b=l2NteKRJVsFxAzIoByojnt/Vfu
	qGc+PJQHO+cCUCM6K4zGy6fOQD5KE+qffxitaRdbqmKL5FVtNuvHqa1CUlzu9Dd2/QgtUgGQfmXdD
	6HHEkXyCZ8e1zJVkxBx6tUYdJdsjIJTQF2XY+fNNcCHzSwtscyCuT9OFRzvQLn0X+KnpYwRmybtAi
	mu/DURR1YvT4emFjagxsU1an1mnNDGaEOR3m4AN++mm/crvPkK3CcqbYwLReek35RrX8ONz0XZ004
	PS2E0AmL6FxHEC1zYtrUPgjkl4gidrmvmNdZ2riFTfsxHbbSFHd0eRchxnv9/V+oH5owo6jzDCxCJ
	EkdfNMQQ==;
Received: from [167.98.27.226] (helo=ct-lt-2504.office.codethink.co.uk)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1s55qI-000cg5-FA; Thu, 09 May 2024 16:37:59 +0100
From: Ivan Orlov <ivan.orlov@codethink.co.uk>
To: pbonzini@redhat.com,
	shuah@kernel.org
Cc: Ivan Orlov <ivan.orlov@codethink.co.uk>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: Check API version when creating VM
Date: Thu,  9 May 2024 16:37:57 +0100
Message-Id: <20240509153757.42032-1-ivan.orlov@codethink.co.uk>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: ivan.orlov@codethink.co.uk

As it is said in the docs, we should always check the KVM API version
before running the KVM-based applications. Add the function which
queries the current KVM API version through `ioctl` to the `kvm_util.c`
file.

Add a new TEST_REQUIRE statement to the `vm_open` function in order
to verify the version of the KVM API before creating a VM.

Signed-off-by: Ivan Orlov <ivan.orlov@codethink.co.uk>
---
 .../testing/selftests/kvm/include/kvm_util_base.h  |  2 ++
 tools/testing/selftests/kvm/lib/kvm_util.c         | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 3e0db283a46a..d7a83387ae33 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -38,6 +38,7 @@
 #define kvm_static_assert(expr, ...) __kvm_static_assert(expr, ##__VA_ARGS__, #expr)
 
 #define KVM_DEV_PATH "/dev/kvm"
+#define KVM_DEFAULT_API_VERSION 12
 #define KVM_MAX_VCPUS 512
 
 #define NSEC_PER_SEC 1000000000L
@@ -275,6 +276,7 @@ int get_kvm_intel_param_integer(const char *param);
 int get_kvm_amd_param_integer(const char *param);
 
 unsigned int kvm_check_cap(long cap);
+int kvm_get_api_version(void);
 
 static inline bool kvm_has_cap(long cap)
 {
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index b2262b5fad9e..58a5deccb388 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -176,6 +176,19 @@ unsigned int kvm_check_cap(long cap)
 	return (unsigned int)ret;
 }
 
+int kvm_get_api_version(void)
+{
+	int ret;
+	int kvm_fd;
+
+	kvm_fd = open_kvm_dev_path_or_exit();
+	ret = __kvm_ioctl(kvm_fd, KVM_GET_API_VERSION, NULL);
+
+	close(kvm_fd);
+
+	return ret;
+}
+
 void vm_enable_dirty_ring(struct kvm_vm *vm, uint32_t ring_size)
 {
 	if (vm_check_cap(vm, KVM_CAP_DIRTY_LOG_RING_ACQ_REL))
@@ -190,6 +203,7 @@ static void vm_open(struct kvm_vm *vm)
 	vm->kvm_fd = _open_kvm_dev_path_or_exit(O_RDWR);
 
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_IMMEDIATE_EXIT));
+	TEST_REQUIRE(kvm_get_api_version() == KVM_DEFAULT_API_VERSION);
 
 	vm->fd = __kvm_ioctl(vm->kvm_fd, KVM_CREATE_VM, (void *)vm->type);
 	TEST_ASSERT(vm->fd >= 0, KVM_IOCTL_ERROR(KVM_CREATE_VM, vm->fd));
-- 
2.34.1


