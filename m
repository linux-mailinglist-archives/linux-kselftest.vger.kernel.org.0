Return-Path: <linux-kselftest+bounces-40559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7039B3FDA5
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 13:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F507189277D
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 11:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284372F49EE;
	Tue,  2 Sep 2025 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="lsFmIzzh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.72.182.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE252F83D0;
	Tue,  2 Sep 2025 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.72.182.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756812029; cv=none; b=Xe0TSPnDL3418oGoDUekeoSkAhXbJs1Zu9AzQjrQAxp9lGsBTgqhXPhaPxGhMxzpJdTM1C6PL4DN7Ndn5k0EIpzt6AaWOuHPnjO8g8A/smjTb5NnfD4aO7gNdogQVKSqGv5cX+IoVOOho1dT0wGBcaDMRWYwLbHQSqb7YUDp+4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756812029; c=relaxed/simple;
	bh=wLPqkcrFWC90MjY5sTrKjuELe2hth0wbMagtCKtQeEM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JJWUxEkBv1H4j3/HX2xakvX+EfGVbC1aoozhdlftwiXeK/A3e4pn3GRp+8aSGByfJr3IEuzG1OWz+WSpnVeBRkr9QtNtbzOGCcykgQ8rvocHfcmiUCWqdTdM1JCqQWi+XV6i+NULKrrZu5CtjfpRde6ifFkHCIuSEYtU0az7Md8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=lsFmIzzh; arc=none smtp.client-ip=3.72.182.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1756812027; x=1788348027;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4U/GLmw/FZs2LtG2FoqidgM1jKHBj0dCkKYDbjnXvsY=;
  b=lsFmIzzhuWwEkaeVhlhqS7kh3HWWO5wh6OqLoAePCCfAC3CaTF4uBRX7
   rEOPLR4X3zKiWGXXE31SVX/smaopj4/PmvfBgA/LGu1GDZolU5ajZKXDG
   eefi88HT2AmUMVoX1uAMoCpz1nBwPI6KXB+HKoB0c3Kl+ej4uXguQyuCI
   gQE5XslA6RPZgqYvnBqPwu+8ABN4KH8flVOUaFOCjOeEAMAJhNAG/dCx4
   1gQXfZ2LV7NmjQgD3lbxdTKo5CmTbpyZnnfsA8XPrwlgOt0HhC7U7O8ft
   0W02WCzookzNn3zgbZAf8wLsuJfs5sRXTWVC5JuXL/60t+r/BbBEn4/NN
   g==;
X-CSE-ConnectionGUID: RPbfGhQvT7SDDE89GnEZoQ==
X-CSE-MsgGUID: ix4JFTmkRaGaeMwIGDEllw==
X-IronPort-AV: E=Sophos;i="6.18,214,1751241600"; 
   d="scan'208";a="1511844"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 11:20:16 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.224:28163]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.43.161:2525] with esmtp (Farcaster)
 id 0dc98258-151a-46cc-81b3-dce1ed47247b; Tue, 2 Sep 2025 11:20:16 +0000 (UTC)
X-Farcaster-Flow-ID: 0dc98258-151a-46cc-81b3-dce1ed47247b
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Tue, 2 Sep 2025 11:20:16 +0000
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19D022EUC002.ant.amazon.com (10.252.51.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 2 Sep 2025 11:20:15 +0000
Received: from EX19D022EUC002.ant.amazon.com ([fe80::bd:307b:4d3a:7d80]) by
 EX19D022EUC002.ant.amazon.com ([fe80::bd:307b:4d3a:7d80%3]) with mapi id
 15.02.2562.020; Tue, 2 Sep 2025 11:20:15 +0000
From: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "shuah@kernel.org"
	<shuah@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"michael.day@amd.com" <michael.day@amd.com>, "david@redhat.com"
	<david@redhat.com>, "jthoughton@google.com" <jthoughton@google.com>, "Roy,
 Patrick" <roypat@amazon.co.uk>, "Thomson, Jack" <jackabt@amazon.co.uk>,
	"Manwaring, Derek" <derekmn@amazon.com>, "Cali, Marco"
	<xmarcalx@amazon.co.uk>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
Subject: [PATCH v5 2/2] KVM: selftests: update guest_memfd write tests
Thread-Topic: [PATCH v5 2/2] KVM: selftests: update guest_memfd write tests
Thread-Index: AQHcG/uOPOuTx3pVLkmJVq9l2Ktv1Q==
Date: Tue, 2 Sep 2025 11:20:15 +0000
Message-ID: <20250902111951.58315-3-kalyazin@amazon.com>
References: <20250902111951.58315-1-kalyazin@amazon.com>
In-Reply-To: <20250902111951.58315-1-kalyazin@amazon.com>
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
 .../testing/selftests/kvm/guest_memfd_test.c  | 86 +++++++++++++++++--=0A=
 1 file changed, 80 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing=
/selftests/kvm/guest_memfd_test.c=0A=
index b3ca6737f304..1236e31f5041 100644=0A=
--- a/tools/testing/selftests/kvm/guest_memfd_test.c=0A=
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c=0A=
@@ -24,18 +24,91 @@=0A=
 #include "test_util.h"=0A=
 #include "ucall_common.h"=0A=
 =0A=
-static void test_file_read_write(int fd)=0A=
+static void test_file_read(int fd)=0A=
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
+static void test_file_write(int fd, size_t total_size)=0A=
+{=0A=
+	size_t page_size =3D getpagesize();=0A=
+	void *buf =3D NULL;=0A=
+	int ret;=0A=
+=0A=
+	ret =3D posix_memalign(&buf, page_size, total_size);=0A=
+	TEST_ASSERT_EQ(ret, 0);=0A=
+=0A=
+	/* Check arguments correctness checks work as expected */=0A=
+=0A=
+	ret =3D pwrite(fd, buf, page_size - 1, 0);=0A=
+	TEST_ASSERT(ret =3D=3D -1, "write unaligned count on a guest_mem fd shoul=
d fail");=0A=
+	TEST_ASSERT_EQ(errno, EINVAL);=0A=
+=0A=
+	ret =3D pwrite(fd, buf, page_size, 1);=0A=
+	TEST_ASSERT(ret =3D=3D -1, "write unaligned offset on a guest_mem fd shou=
ld fail");=0A=
+	TEST_ASSERT_EQ(errno, EINVAL);=0A=
+=0A=
+	ret =3D pwrite(fd, buf, page_size, total_size);=0A=
+	TEST_ASSERT(ret =3D=3D -1, "writing past the file size on a guest_mem fd =
should fail");=0A=
+	TEST_ASSERT_EQ(errno, EINVAL);=0A=
+=0A=
+	ret =3D pwrite(fd, NULL, page_size, 0);=0A=
+	TEST_ASSERT(ret =3D=3D -1, "supplying a NULL buffer when writing a guest_=
mem fd should fail");=0A=
+	TEST_ASSERT_EQ(errno, EFAULT);=0A=
+=0A=
+	/* Check double population is not allowed */=0A=
+=0A=
+	ret =3D pwrite(fd, buf, page_size, 0);=0A=
+	TEST_ASSERT(ret =3D=3D page_size, "page-aligned write on a guest_mem fd s=
hould succeed");=0A=
+=0A=
+	ret =3D pwrite(fd, buf, page_size, 0);=0A=
+	TEST_ASSERT(ret =3D=3D -1, "write on already populated guest_mem fd shoul=
d fail");=0A=
+	TEST_ASSERT_EQ(errno, ENOSPC);=0A=
+=0A=
+	ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0, page=
_size);=0A=
+	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) should succeed");=0A=
+=0A=
+	/* Check population is allowed again after punching a hole */=0A=
+=0A=
+	ret =3D pwrite(fd, buf, page_size, 0);=0A=
+	TEST_ASSERT(ret =3D=3D page_size,=0A=
+		"page-aligned write on a punched guest_mem fd should succeed");=0A=
+=0A=
+	ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0, page=
_size);=0A=
+	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) should succeed");=0A=
+=0A=
+	/* Check population of already allocated memory is allowed */=0A=
+=0A=
+	ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE, 0, page_size);=0A=
+	TEST_ASSERT(!ret, "fallocate with aligned offset and size should succeed"=
);=0A=
+=0A=
+	ret =3D pwrite(fd, buf, page_size, 0);=0A=
+	TEST_ASSERT(ret =3D=3D page_size, "write on a preallocated guest_mem fd s=
hould succeed");=0A=
+=0A=
+	ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0, page=
_size);=0A=
+	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) should succeed");=0A=
+=0A=
+	/* Check population works until an already populated page is encountered =
*/=0A=
+=0A=
+	ret =3D pwrite(fd, buf, total_size, 0);=0A=
+	TEST_ASSERT(ret =3D=3D total_size, "page-aligned write on a guest_mem fd =
should succeed");=0A=
+=0A=
+	ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0, page=
_size);=0A=
+	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) should succeed");=0A=
+=0A=
+	ret =3D pwrite(fd, buf, total_size, 0);=0A=
+	TEST_ASSERT(ret =3D=3D page_size, "write on a guest_mem fd should not ove=
rwrite data");=0A=
+=0A=
+	ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0, tota=
l_size);=0A=
+	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) should succeed");=0A=
+=0A=
+=0A=
+	free(buf);=0A=
 }=0A=
 =0A=
 static void test_mmap_supported(int fd, size_t page_size, size_t total_siz=
e)=0A=
@@ -281,7 +354,8 @@ static void test_guest_memfd(unsigned long vm_type)=0A=
 =0A=
 	fd =3D vm_create_guest_memfd(vm, total_size, flags);=0A=
 =0A=
-	test_file_read_write(fd);=0A=
+	test_file_read(fd);=0A=
+	test_file_write(fd, total_size);=0A=
 =0A=
 	if (flags & GUEST_MEMFD_FLAG_MMAP) {=0A=
 		test_mmap_supported(fd, page_size, total_size);=0A=
-- =0A=
2.50.1=0A=
=0A=

