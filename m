Return-Path: <linux-kselftest+bounces-45648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A25E3C5E496
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 17:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7FB5E362130
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 15:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFB132F74B;
	Fri, 14 Nov 2025 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="kf+ToO07"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.57.120.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A704732F74A;
	Fri, 14 Nov 2025 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.57.120.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763133555; cv=none; b=QDXLDD6liqlCKtJhONU4Q/GDMSO4+ED+yYfRprLS7614eyycrHhWYerJQKRgTJ7+Pc/0DxQF0SN7ytcxZGvVEQ7gw/l1k82cs12dHQIc35wDxnemFXyYfGmE/deUXP6TtvRx4W7E95+0icKmJOzUddL4S71ZoB/SvgaPYB3xerU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763133555; c=relaxed/simple;
	bh=qtKXoxooT9aPVZlDpOzpYWf6LGmWj3p7Hm+C7uqrWR4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pshzqY+NDmmYTG3dH+zrV5i2R6jzzGm+p3cOYYsXftEUeiQ11Fd68tunlVt/bdpoNCI82E0+imbi2pxtjmkPdUbyzG0+o+/3Ev0tFeNoyeE4Zg2hdr7wZOixqpSP3Z4sJ3onZvhtrp9f0go3sSpQHVIjWHi13NrTusZpDLUTwsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=kf+ToO07; arc=none smtp.client-ip=52.57.120.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1763133553; x=1794669553;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bKf0Jo0Hm2KfNIs4K3e3m0InZJCYrIUI4ru3kx8CWjM=;
  b=kf+ToO07i+JEB9g88oKplHD+aCLp9KIq5YkXUbdL7gGyJMylWsOS1ikX
   NSdHo6FJ/wr32BRJ4qy8whgmUQmPYYpmvf1RayNIjmk1PzwFztipXwnde
   PtY4bZS9U8BuFuqNjZApc3GxELXekA4EQkGNSMFonJLQHUIdk5wjHlSZv
   6NUWzzzQkkt01FVL9T0NVAr0/x9lokqCIEP75OmNLRa+XlYgawZ5oRprX
   7cyWEJbsDfFU2sJwrv0owaAWqRQJ1iKUqrCC/kwmBm+m9sCiygDNq6S9A
   R9WCmvDa0PNien5aaQAACJUp3wfwjsfOSSXJ3pzWaXtDs8p0rhtU7AWME
   g==;
X-CSE-ConnectionGUID: 8UUp7qKpTxutEkj9b275LA==
X-CSE-MsgGUID: HCrEZwmaQv+klPvYy52xNw==
X-IronPort-AV: E=Sophos;i="6.19,305,1754956800"; 
   d="scan'208";a="5093707"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 15:18:54 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:16555]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.37.32:2525] with esmtp (Farcaster)
 id 37f9e9e0-3a84-4a33-b291-c598729a7c67; Fri, 14 Nov 2025 15:18:54 +0000 (UTC)
X-Farcaster-Flow-ID: 37f9e9e0-3a84-4a33-b291-c598729a7c67
Received: from EX19D022EUC003.ant.amazon.com (10.252.51.167) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 14 Nov 2025 15:18:54 +0000
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19D022EUC003.ant.amazon.com (10.252.51.167) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 14 Nov 2025 15:18:54 +0000
Received: from EX19D022EUC002.ant.amazon.com ([fe80::bd:307b:4d3a:7d80]) by
 EX19D022EUC002.ant.amazon.com ([fe80::bd:307b:4d3a:7d80%3]) with mapi id
 15.02.2562.029; Fri, 14 Nov 2025 15:18:53 +0000
From: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "shuah@kernel.org"
	<shuah@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "david@kernel.org"
	<david@kernel.org>, "jthoughton@google.com" <jthoughton@google.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "vannapurve@google.com"
	<vannapurve@google.com>, "jackmanb@google.com" <jackmanb@google.com>,
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>, "Thomson, Jack"
	<jackabt@amazon.co.uk>, "Itazuri, Takahiro" <itazur@amazon.co.uk>,
	"Manwaring, Derek" <derekmn@amazon.com>, "Cali, Marco"
	<xmarcalx@amazon.co.uk>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
Subject: [PATCH v7 2/2] KVM: selftests: update guest_memfd write tests
Thread-Topic: [PATCH v7 2/2] KVM: selftests: update guest_memfd write tests
Thread-Index: AQHcVXn8AzrsKiqAcEa0iTWGk+wWoA==
Date: Fri, 14 Nov 2025 15:18:53 +0000
Message-ID: <20251114151828.98165-3-kalyazin@amazon.com>
References: <20251114151828.98165-1-kalyazin@amazon.com>
In-Reply-To: <20251114151828.98165-1-kalyazin@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: Nikita Kalyazin <kalyazin@amazon.com>=0A=
=0A=
This is to reflect that the write syscall is now implemented for=0A=
guest_memfd.=0A=
=0A=
Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>=0A=
---=0A=
 .../testing/selftests/kvm/guest_memfd_test.c  | 58 +++++++++++++++++--=0A=
 1 file changed, 52 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing=
/selftests/kvm/guest_memfd_test.c=0A=
index e7d9aeb418d3..ef3e92e18ee6 100644=0A=
--- a/tools/testing/selftests/kvm/guest_memfd_test.c=0A=
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c=0A=
@@ -24,18 +24,57 @@=0A=
 =0A=
 static size_t page_size;=0A=
 =0A=
-static void test_file_read_write(int fd, size_t total_size)=0A=
+static void test_file_read(int fd, size_t total_size)=0A=
 {=0A=
 	char buf[64];=0A=
 =0A=
 	TEST_ASSERT(read(fd, buf, sizeof(buf)) < 0,=0A=
 		    "read on a guest_mem fd should fail");=0A=
-	TEST_ASSERT(write(fd, buf, sizeof(buf)) < 0,=0A=
-		    "write on a guest_mem fd should fail");=0A=
 	TEST_ASSERT(pread(fd, buf, sizeof(buf), 0) < 0,=0A=
 		    "pread on a guest_mem fd should fail");=0A=
-	TEST_ASSERT(pwrite(fd, buf, sizeof(buf), 0) < 0,=0A=
-		    "pwrite on a guest_mem fd should fail");=0A=
+}=0A=
+=0A=
+static void test_write_supported(int fd, size_t total_size)=0A=
+{=0A=
+	size_t page_size =3D getpagesize();=0A=
+	void *buf =3D NULL;=0A=
+	int ret;=0A=
+=0A=
+	ret =3D posix_memalign(&buf, page_size, total_size);=0A=
+	TEST_ASSERT_EQ(ret, 0);=0A=
+=0A=
+	ret =3D pwrite(fd, buf, page_size, total_size);=0A=
+	TEST_ASSERT(ret =3D=3D -1, "writing past the file size on a guest_mem fd =
should fail");=0A=
+	TEST_ASSERT_EQ(errno, EINVAL);=0A=
+=0A=
+	ret =3D pwrite(fd, buf, 1, 0);=0A=
+	TEST_ASSERT(ret =3D=3D -1, "writing an unaligned count a guest_mem fd sho=
uld fail");=0A=
+	TEST_ASSERT_EQ(errno, EINVAL);=0A=
+=0A=
+	ret =3D pwrite(fd, buf, page_size, 1);=0A=
+	TEST_ASSERT(ret =3D=3D -1, "writing to an unaligned offset a guest_mem fd=
 should fail");=0A=
+	TEST_ASSERT_EQ(errno, EINVAL);=0A=
+=0A=
+	ret =3D pwrite(fd, buf, page_size, 0);=0A=
+	TEST_ASSERT(ret =3D=3D page_size, "write on a guest_mem fd should succeed=
");=0A=
+=0A=
+	free(buf);=0A=
+}=0A=
+=0A=
+static void test_write_not_supported(int fd, size_t total_size)=0A=
+{=0A=
+	size_t page_size =3D getpagesize();=0A=
+	void *buf =3D NULL;=0A=
+	int ret;=0A=
+=0A=
+	ret =3D posix_memalign(&buf, page_size, total_size);=0A=
+	TEST_ASSERT_EQ(ret, 0);=0A=
+=0A=
+	ret =3D pwrite(fd, buf, page_size, 0);=0A=
+	TEST_ASSERT(ret =3D=3D -1, "write on guest_mem fd should fail");=0A=
+	TEST_ASSERT_EQ(errno, ENODEV);=0A=
+=0A=
+	free(buf);=0A=
 }=0A=
 =0A=
 static void test_mmap_cow(int fd, size_t size)=0A=
@@ -267,7 +306,7 @@ static void __test_guest_memfd(struct kvm_vm *vm, uint6=
4_t flags)=0A=
 	test_create_guest_memfd_multiple(vm);=0A=
 	test_create_guest_memfd_invalid_sizes(vm, flags);=0A=
 =0A=
-	gmem_test(file_read_write, vm, flags);=0A=
+	gmem_test(file_read, vm, flags);=0A=
 =0A=
 	if (flags & GUEST_MEMFD_FLAG_MMAP) {=0A=
 		if (flags & GUEST_MEMFD_FLAG_INIT_SHARED) {=0A=
@@ -282,6 +321,11 @@ static void __test_guest_memfd(struct kvm_vm *vm, uint=
64_t flags)=0A=
 		gmem_test(mmap_not_supported, vm, flags);=0A=
 	}=0A=
 =0A=
+	if (flags & GUEST_MEMFD_FLAG_WRITE)=0A=
+		gmem_test(write_supported, vm, flags);=0A=
+	else=0A=
+		gmem_test(write_not_supported, vm, flags);=0A=
+=0A=
 	gmem_test(file_size, vm, flags);=0A=
 	gmem_test(fallocate, vm, flags);=0A=
 	gmem_test(invalid_punch_hole, vm, flags);=0A=
@@ -299,6 +343,8 @@ static void test_guest_memfd(unsigned long vm_type)=0A=
 	flags =3D vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS);=0A=
 	if (flags & GUEST_MEMFD_FLAG_MMAP)=0A=
 		__test_guest_memfd(vm, GUEST_MEMFD_FLAG_MMAP);=0A=
+	if (flags & GUEST_MEMFD_FLAG_WRITE)=0A=
+		__test_guest_memfd(vm, GUEST_MEMFD_FLAG_WRITE);=0A=
 =0A=
 	/* MMAP should always be supported if INIT_SHARED is supported. */=0A=
 	if (flags & GUEST_MEMFD_FLAG_INIT_SHARED)=0A=
-- =0A=
2.50.1=0A=
=0A=

