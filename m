Return-Path: <linux-kselftest+bounces-45649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86031C5DF3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 16:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96E6423DF0
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 15:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02FC33F365;
	Fri, 14 Nov 2025 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="q1d5SPSN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.158.153.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3164F330333;
	Fri, 14 Nov 2025 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.158.153.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763133558; cv=none; b=fUG00J7+DEY/ICZxV/P+5MW1FYnRofCAtNFff/LVDJln2kQZd6pj0Dueug2toSze75rH7b6JrhgG7DTnOga61wjCkTHdRodx2+VfpVNo50HUcbBDkmBEJZnjRGq2vncz10gv7MiGAmnPveP/MdcHx6vqArFIqepgLPYFTbb6PdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763133558; c=relaxed/simple;
	bh=Lw+3gEtll30YxeBvu3ffGbRZz6zOoOtgy4ulRySElfs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WzdlpF/C3wknseLPHJDuqIVGhSO/oQLxpktli96Ur2fTATkE/NG6IkJD+hQ9UkYV+2MJxDPFM1VypkIGl0n8skPWIq1tkLqsZFEumC317eS3ILAEFCxqIKOl91g2QwqRUDQm4uTp3ed65tU+UcCf72nC1gXGqjcSIlNXr3fQ7dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=q1d5SPSN; arc=none smtp.client-ip=18.158.153.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1763133556; x=1794669556;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2jS9lSxf0MwFRU30weBPIyuZUC60gMOFaKVeHsrnLYY=;
  b=q1d5SPSNFWUNMZdaMZEBPCqM3F1KC4mTSBKqsHHU3fyxP+NMo/C+svuA
   V8zr7xdtKduoc9uyhy2Y10a++mqNDS4Hme9b2/7CKOjccX2F6rOMPXQuL
   UuxjKqJJWgbLxWwIEHHlcBYw6w76Q55JhTCxQhcI7MrsPAULScPiKgXrn
   fuD8gqNR6ZsWZXzfBK0kWxxUKwrIa1lTD7SZ0aAbjaB3yDa68MypSHVBl
   FK565Jj+Xkh8vdT7wGGoyPp/oTBIaJeuCNVWr/ZbG6HwUvqzGiDy+kYKv
   0elwKxcW39BwvskCUSk/k+/R2AI4IXEPqymzD0JuYHQM6HFcQnGl0FkTV
   g==;
X-CSE-ConnectionGUID: NQy97IzqSRe+LgECbniuaQ==
X-CSE-MsgGUID: tcsel8u9QK6dgorzXfsH+A==
X-IronPort-AV: E=Sophos;i="6.19,305,1754956800"; 
   d="scan'208";a="5074408"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 15:18:53 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:16555]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.37.32:2525] with esmtp (Farcaster)
 id c36ef757-119a-4eaf-9a52-dac4efce4dc0; Fri, 14 Nov 2025 15:18:53 +0000 (UTC)
X-Farcaster-Flow-ID: c36ef757-119a-4eaf-9a52-dac4efce4dc0
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 14 Nov 2025 15:18:42 +0000
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19D022EUC002.ant.amazon.com (10.252.51.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 14 Nov 2025 15:18:42 +0000
Received: from EX19D022EUC002.ant.amazon.com ([fe80::bd:307b:4d3a:7d80]) by
 EX19D022EUC002.ant.amazon.com ([fe80::bd:307b:4d3a:7d80%3]) with mapi id
 15.02.2562.029; Fri, 14 Nov 2025 15:18:42 +0000
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
Subject: [PATCH v7 1/2] KVM: guest_memfd: add generic population via write
Thread-Topic: [PATCH v7 1/2] KVM: guest_memfd: add generic population via
 write
Thread-Index: AQHcVXn19V34iuawKk6m+mlThfkEpA==
Date: Fri, 14 Nov 2025 15:18:41 +0000
Message-ID: <20251114151828.98165-2-kalyazin@amazon.com>
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
On systems that support shared guest memory, write() is useful, for=0A=
example, for population of the initial image.  Even though the same can=0A=
also be achieved via userspace mapping and memcpying from userspace,=0A=
write() provides a more performant option because it does not need to=0A=
set user page tables and it does not cause a page fault for every page=0A=
like memcpy would.  Note that memcpy cannot be accelerated via=0A=
MADV_POPULATE_WRITE as it is not supported by guest_memfd and relies on=0A=
GUP.=0A=
=0A=
Populating 512MiB of guest_memfd on a x86 machine:=0A=
 - via memcpy: 436 ms=0A=
 - via write:  202 ms (-54%)=0A=
=0A=
Only PAGE_ALIGNED offset and len are allowed.  Even though non-aligned=0A=
writes are technically possible, when in-place conversion support is=0A=
implemented [1], the restriction makes handling of mixed shared/private=0A=
huge pages simpler.  write() will only be allowed to populate shared=0A=
pages.=0A=
=0A=
When direct map removal is implemented [2]=0A=
 - write() will not be allowed to access pages that have already been=0A=
   removed from direct map=0A=
 - on completion, write() will remove the populated pages from direct=0A=
   map=0A=
=0A=
While it is technically possible to implement read() syscall on systems=0A=
with shared guest memory, it is not supported as there is currently no=0A=
use case for it.=0A=
=0A=
[1] https://lore.kernel.org/kvm/cover.1760731772.git.ackerleytng@google.com=
=0A=
[2] https://lore.kernel.org/kvm/20250924151101.2225820-1-patrick.roy@campus=
.lmu.de=0A=
=0A=
Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>=0A=
---=0A=
 Documentation/virt/kvm/api.rst |  2 ++=0A=
 include/linux/kvm_host.h       |  2 +-=0A=
 include/uapi/linux/kvm.h       |  1 +=0A=
 virt/kvm/guest_memfd.c         | 52 ++++++++++++++++++++++++++++++++++=0A=
 4 files changed, 56 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rs=
t=0A=
index 57061fa29e6a..9541e95fc2ed 100644=0A=
--- a/Documentation/virt/kvm/api.rst=0A=
+++ b/Documentation/virt/kvm/api.rst=0A=
@@ -6448,6 +6448,8 @@ specified via KVM_CREATE_GUEST_MEMFD.  Currently defi=
ned flags:=0A=
                                without INIT_SHARED will be marked private)=
.=0A=
                                Shared memory can be faulted into host user=
space=0A=
                                page tables. Private memory cannot.=0A=
+  GUEST_MEMFD_FLAG_WRITE       Enable using write() on the guest_memfd fil=
e=0A=
+                               descriptor.=0A=
   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=0A=
 =0A=
 When the KVM MMU performs a PFN lookup to service a guest fault and the ba=
cking=0A=
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h=0A=
index 5bd76cf394fa..5fbf65f49586 100644=0A=
--- a/include/linux/kvm_host.h=0A=
+++ b/include/linux/kvm_host.h=0A=
@@ -736,7 +736,7 @@ static inline u64 kvm_gmem_get_supported_flags(struct k=
vm *kvm)=0A=
 	u64 flags =3D GUEST_MEMFD_FLAG_MMAP;=0A=
 =0A=
 	if (!kvm || kvm_arch_supports_gmem_init_shared(kvm))=0A=
-		flags |=3D GUEST_MEMFD_FLAG_INIT_SHARED;=0A=
+		flags |=3D GUEST_MEMFD_FLAG_INIT_SHARED | GUEST_MEMFD_FLAG_WRITE;=0A=
 =0A=
 	return flags;=0A=
 }=0A=
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h=0A=
index 52f6000ab020..5b73d6528f1c 100644=0A=
--- a/include/uapi/linux/kvm.h=0A=
+++ b/include/uapi/linux/kvm.h=0A=
@@ -1601,6 +1601,7 @@ struct kvm_memory_attributes {=0A=
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest=
_memfd)=0A=
 #define GUEST_MEMFD_FLAG_MMAP		(1ULL << 0)=0A=
 #define GUEST_MEMFD_FLAG_INIT_SHARED	(1ULL << 1)=0A=
+#define GUEST_MEMFD_FLAG_WRITE		(1ULL << 2)=0A=
 =0A=
 struct kvm_create_guest_memfd {=0A=
 	__u64 size;=0A=
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c=0A=
index ffadc5ee8e04..2c71c21b9189 100644=0A=
--- a/virt/kvm/guest_memfd.c=0A=
+++ b/virt/kvm/guest_memfd.c=0A=
@@ -411,6 +411,8 @@ static int kvm_gmem_mmap(struct file *file, struct vm_a=
rea_struct *vma)=0A=
 =0A=
 static struct file_operations kvm_gmem_fops =3D {=0A=
 	.mmap		=3D kvm_gmem_mmap,=0A=
+	.llseek		=3D default_llseek,=0A=
+	.write_iter     =3D generic_perform_write,=0A=
 	.open		=3D generic_file_open,=0A=
 	.release	=3D kvm_gmem_release,=0A=
 	.fallocate	=3D kvm_gmem_fallocate,=0A=
@@ -421,6 +423,53 @@ void kvm_gmem_init(struct module *module)=0A=
 	kvm_gmem_fops.owner =3D module;=0A=
 }=0A=
 =0A=
+static bool kvm_gmem_supports_write(struct inode *inode)=0A=
+{=0A=
+	const u64 flags =3D (u64)inode->i_private;=0A=
+=0A=
+	return flags & GUEST_MEMFD_FLAG_WRITE;=0A=
+}=0A=
+=0A=
+static int kvm_gmem_write_begin(const struct kiocb *kiocb,=0A=
+				struct address_space *mapping,=0A=
+				loff_t pos, unsigned int len,=0A=
+				struct folio **folio, void **fsdata)=0A=
+{=0A=
+	struct inode *inode =3D file_inode(kiocb->ki_filp);=0A=
+=0A=
+	if (!kvm_gmem_supports_write(inode))=0A=
+		return -ENODEV;=0A=
+=0A=
+	if (pos + len > i_size_read(inode))=0A=
+		return -EINVAL;=0A=
+=0A=
+	if (!IS_ALIGNED(pos, PAGE_SIZE) || !IS_ALIGNED(len, PAGE_SIZE))=0A=
+		return -EINVAL;=0A=
+=0A=
+	*folio =3D kvm_gmem_get_folio(inode, pos >> PAGE_SHIFT);=0A=
+	if (IS_ERR(*folio))=0A=
+		return PTR_ERR(*folio);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int kvm_gmem_write_end(const struct kiocb *kiocb,=0A=
+			      struct address_space *mapping,=0A=
+			      loff_t pos, unsigned int len,=0A=
+			      unsigned int copied,=0A=
+			      struct folio *folio, void *fsdata)=0A=
+{=0A=
+	if (!folio_test_uptodate(folio)) {=0A=
+		folio_zero_range(folio, copied, len - copied);=0A=
+		folio_mark_uptodate(folio);=0A=
+	}=0A=
+=0A=
+	folio_unlock(folio);=0A=
+	folio_put(folio);=0A=
+=0A=
+	return copied;=0A=
+}=0A=
+=0A=
 static int kvm_gmem_migrate_folio(struct address_space *mapping,=0A=
 				  struct folio *dst, struct folio *src,=0A=
 				  enum migrate_mode mode)=0A=
@@ -469,6 +518,8 @@ static void kvm_gmem_free_folio(struct folio *folio)=0A=
 =0A=
 static const struct address_space_operations kvm_gmem_aops =3D {=0A=
 	.dirty_folio =3D noop_dirty_folio,=0A=
+	.write_begin =3D kvm_gmem_write_begin,=0A=
+	.write_end =3D kvm_gmem_write_end,=0A=
 	.migrate_folio	=3D kvm_gmem_migrate_folio,=0A=
 	.error_remove_folio =3D kvm_gmem_error_folio,=0A=
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE=0A=
@@ -516,6 +567,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t si=
ze, u64 flags)=0A=
 	}=0A=
 =0A=
 	file->f_flags |=3D O_LARGEFILE;=0A=
+	file->f_mode |=3D FMODE_LSEEK | FMODE_PWRITE;=0A=
 =0A=
 	inode =3D file->f_inode;=0A=
 	WARN_ON(file->f_mapping !=3D inode->i_mapping);=0A=
-- =0A=
2.50.1=0A=
=0A=

