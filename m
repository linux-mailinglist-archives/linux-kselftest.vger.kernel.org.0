Return-Path: <linux-kselftest+bounces-43563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C63D9BF256B
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 18:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7EA94F763E
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 16:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6D52848A0;
	Mon, 20 Oct 2025 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="RKZF37ra"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.65.3.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F4A279917;
	Mon, 20 Oct 2025 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.65.3.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976875; cv=none; b=H7X+S9lLAzMLlX1kPQPnQNRIDuQJCf8cZNlhwcq5VJY+EDGlBFsbYPDA7U+Xz52TNxmyB/zwFyrTrI9Xlt63ePxMT8iSXa/7rzOF/n/lqqXPTBIBrGiSFLhcRGNzZFwQNvx8rVNxjW/pA/9riRyEF/2dx/IZwSln2AmBfsxwWzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976875; c=relaxed/simple;
	bh=luCWr/Ti5SiD6fz+TpJW/iL8yE1ZLZnMzX0YcwCrUyg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YO26dQXd6O6N9EllYellSMylI4DNqC/+WtWKA0CIr7Oc2VvRLZ2qrq2eVsDXqo9vLiKD7GC+YNKru2j0/hE4K4nboTA0LyiHdzAJSh0bem1R+yNaO3Vg8XgNYtj6fkEzuoOL8JkhjBmxgzOHjrWAkA3P35gOVuuyiBFEYkj0ru8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=RKZF37ra; arc=none smtp.client-ip=3.65.3.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1760976873; x=1792512873;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q24GU8FcFCs6WJb9C+XwHstoC5iy5s3AhZ8lLVXQMsU=;
  b=RKZF37racKRjX2zf0QAbUJJu6AgxU2GUPfqO68CdMRW1eAtZpMbdeio2
   Sndza5GbheYIIFdhhkyyXoIrlRuiv/SozVjp6fKy6mBFdyx1hH7gowfbp
   BQjio+QVnS2JTn5dqGevmBL3LXClDPMKWh9WFOBcLHnsEqKA9KCQ6FXZK
   1gzg5wiMU7a7RJPSimPho1TivgVrIoPWazwhbfNx10763/9tu5Err2IiI
   yKbHSF05pxpW8WnxWvMyBQRueyh/mdAFbOOyHlFHmkNsnRgXBM8qVvv0M
   JDQjI3XI+oOtQyxhTchiIGG/olHNYgkNJdvHEJkwptOnAZIYMqsYBlO8T
   g==;
X-CSE-ConnectionGUID: q1YPj9UCS+C9pLJ1GqSwKw==
X-CSE-MsgGUID: 6KYuymc7Sv+p6+VzGT1Dvg==
X-IronPort-AV: E=Sophos;i="6.19,242,1754956800"; 
   d="scan'208";a="3895146"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 16:14:17 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:15098]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.47.14:2525] with esmtp (Farcaster)
 id bf172871-1a0f-446d-960b-c321c4ef4f18; Mon, 20 Oct 2025 16:14:17 +0000 (UTC)
X-Farcaster-Flow-ID: bf172871-1a0f-446d-960b-c321c4ef4f18
Received: from EX19D022EUC001.ant.amazon.com (10.252.51.254) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 20 Oct 2025 16:14:17 +0000
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19D022EUC001.ant.amazon.com (10.252.51.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 20 Oct 2025 16:14:16 +0000
Received: from EX19D022EUC002.ant.amazon.com ([fe80::bd:307b:4d3a:7d80]) by
 EX19D022EUC002.ant.amazon.com ([fe80::bd:307b:4d3a:7d80%3]) with mapi id
 15.02.2562.020; Mon, 20 Oct 2025 16:14:16 +0000
From: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "shuah@kernel.org"
	<shuah@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "david@redhat.com"
	<david@redhat.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>, "Thomson, Jack"
	<jackabt@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>, "Cali,
 Marco" <xmarcalx@amazon.co.uk>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
Subject: [PATCH v6 2/2] KVM: selftests: update guest_memfd write tests
Thread-Topic: [PATCH v6 2/2] KVM: selftests: update guest_memfd write tests
Thread-Index: AQHcQdyVtSwBRiB1XUqIh7uAE+bzAw==
Date: Mon, 20 Oct 2025 16:14:16 +0000
Message-ID: <20251020161352.69257-3-kalyazin@amazon.com>
References: <20251020161352.69257-1-kalyazin@amazon.com>
In-Reply-To: <20251020161352.69257-1-kalyazin@amazon.com>
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
 .../testing/selftests/kvm/guest_memfd_test.c  | 51 ++++++++++++++++---=0A=
 1 file changed, 45 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing=
/selftests/kvm/guest_memfd_test.c=0A=
index b3ca6737f304..be1f78542d64 100644=0A=
--- a/tools/testing/selftests/kvm/guest_memfd_test.c=0A=
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c=0A=
@@ -24,18 +24,55 @@=0A=
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
+	ret =3D pwrite(fd, buf, page_size, 0);=0A=
+	TEST_ASSERT(ret =3D=3D page_size, "write on a guest_mem fd should succeed=
");=0A=
+=0A=
+	ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0, page=
_size);=0A=
+	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) should succeed");=0A=
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
+	ret =3D fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0, page=
_size);=0A=
+	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) should succeed");=0A=
+=0A=
+	free(buf);=0A=
 }=0A=
 =0A=
 static void test_mmap_supported(int fd, size_t page_size, size_t total_siz=
e)=0A=
@@ -281,12 +318,14 @@ static void test_guest_memfd(unsigned long vm_type)=
=0A=
 =0A=
 	fd =3D vm_create_guest_memfd(vm, total_size, flags);=0A=
 =0A=
-	test_file_read_write(fd);=0A=
+	test_file_read(fd);=0A=
 =0A=
 	if (flags & GUEST_MEMFD_FLAG_MMAP) {=0A=
+		test_write_supported(fd, total_size);=0A=
 		test_mmap_supported(fd, page_size, total_size);=0A=
 		test_fault_overflow(fd, page_size, total_size);=0A=
 	} else {=0A=
+		test_write_not_supported(fd, total_size);=0A=
 		test_mmap_not_supported(fd, page_size, total_size);=0A=
 	}=0A=
 =0A=
-- =0A=
2.50.1=0A=
=0A=

