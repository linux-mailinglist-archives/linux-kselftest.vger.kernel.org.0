Return-Path: <linux-kselftest+bounces-40189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8CBB3A47C
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 17:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CFEA7B18AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 15:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E0523A562;
	Thu, 28 Aug 2025 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="P644/9x6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.72.182.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD59622A7E4;
	Thu, 28 Aug 2025 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.72.182.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756395075; cv=none; b=VUCvXwHlwpPq/J7Tsk1/jZ6BghiKn3mLyzefZe5aXROantPNypNw7L9V3shoqbkp6zRdOG3lxmo9UCRYtRS+JZt/xkrwXAERGZPQ/i1+thCpRqC9Oa0E81MW2tHIyvkWODLEKTPvWWeDYrI4FvvuZ0JQCsVjmPG5+Cj91BPERZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756395075; c=relaxed/simple;
	bh=6NgXamk4sP0MSxRAZMVmS2/YpynC8mCX69SLlxT0S2c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SKt5VABSIveP67WOGa9SHdnD5RjlU3DK3gGIxCpgcG7zkfVGkxCx+DkfXfyWTnfT4vOMLWyDfz41tOCgvz2+DFrhK6xrks0Yy+GPASAAD1Pdsarr13l7lK14McOMH9hc5iMZpY/pc/bzxCfnY7wb1/soa6356bbgbYciRX7dlPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=P644/9x6; arc=none smtp.client-ip=3.72.182.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1756395073; x=1787931073;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jx8orT7GjXbReFrOJJPwKD910vtsBij7TtYAxtKgUt4=;
  b=P644/9x6O23zrA2dSvRemADwpc6G4Y473M9JAyVnf2hls1/rqUGvXB9f
   3CVx8UEe4BMOHK8zQ8ZKsJTgj24zjkoaNolsbdu8GW13E55fOPke+BLWq
   f+PVl4UFDjla7VvvIm2Urb3gM+bpy8j5yRjvHfz4mDZJZW9q2niwpymzC
   HTNTSoi8uEGS9KZ4FLyRz8TCceZ5AP5tM2IaifmUkMhrdh4HZyvheg6PF
   YWyN7itqTGxArgOJ2WA5+uCqkOfaVoiywgQy9JJQct26v04UvzTPpty0+
   gJruUBNU7pvlqlNqhLAuJL+yltJEkVF4Uf6RtosZBKj2gaoOIpEg5zxrV
   A==;
X-CSE-ConnectionGUID: nUG/+GuiQOWobyyoOsuECg==
X-CSE-MsgGUID: OAJl7skiQXCXfR2Sz+9gIA==
X-IronPort-AV: E=Sophos;i="6.18,214,1751241600"; 
   d="scan'208";a="1325474"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 15:31:03 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:10558]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.18.194:2525] with esmtp (Farcaster)
 id 47185e85-e09d-469f-9c87-24af2c61ec23; Thu, 28 Aug 2025 15:31:03 +0000 (UTC)
X-Farcaster-Flow-ID: 47185e85-e09d-469f-9c87-24af2c61ec23
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Thu, 28 Aug 2025 15:31:01 +0000
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19D022EUC002.ant.amazon.com (10.252.51.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Thu, 28 Aug 2025 15:31:01 +0000
Received: from EX19D022EUC002.ant.amazon.com ([fe80::bd:307b:4d3a:7d80]) by
 EX19D022EUC002.ant.amazon.com ([fe80::bd:307b:4d3a:7d80%3]) with mapi id
 15.02.2562.017; Thu, 28 Aug 2025 15:31:01 +0000
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
Subject: [PATCH v4 1/2] KVM: guest_memfd: add generic population via write
Thread-Topic: [PATCH v4 1/2] KVM: guest_memfd: add generic population via
 write
Thread-Index: AQHcGDDCvFtEUrPBRUaVWhkWmm3z+g==
Date: Thu, 28 Aug 2025 15:31:01 +0000
Message-ID: <20250828153049.3922-2-kalyazin@amazon.com>
References: <20250828153049.3922-1-kalyazin@amazon.com>
In-Reply-To: <20250828153049.3922-1-kalyazin@amazon.com>
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

write syscall populates guest_memfd with user-supplied data in a generic=0A=
way, ie no vendor-specific preparation is performed.  This is supposed=0A=
to be used in non-CoCo setups where guest memory is not=0A=
hardware-encrypted.=0A=
=0A=
The following behaviour is implemented:=0A=
 - only page-aligned count and offset are allowed=0A=
 - if the memory is already allocated, the call will successfully=0A=
   populate it=0A=
 - if the memory is not allocated, the call will both allocate and=0A=
   populate=0A=
 - if the memory is already populated, the call will not repopulate it=0A=
=0A=
Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>=0A=
---=0A=
 virt/kvm/guest_memfd.c | 64 +++++++++++++++++++++++++++++++++++++++++-=0A=
 1 file changed, 63 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c=0A=
index 08a6bc7d25b6..1f6f85edace0 100644=0A=
--- a/virt/kvm/guest_memfd.c=0A=
+++ b/virt/kvm/guest_memfd.c=0A=
@@ -379,7 +379,9 @@ static int kvm_gmem_mmap(struct file *file, struct vm_a=
rea_struct *vma)=0A=
 }=0A=
 =0A=
 static struct file_operations kvm_gmem_fops =3D {=0A=
-	.mmap		=3D kvm_gmem_mmap,=0A=
+	.mmap           =3D kvm_gmem_mmap,=0A=
+	.llseek         =3D default_llseek,=0A=
+	.write_iter     =3D generic_perform_write,=0A=
 	.open		=3D generic_file_open,=0A=
 	.release	=3D kvm_gmem_release,=0A=
 	.fallocate	=3D kvm_gmem_fallocate,=0A=
@@ -390,6 +392,63 @@ void kvm_gmem_init(struct module *module)=0A=
 	kvm_gmem_fops.owner =3D module;=0A=
 }=0A=
 =0A=
+static int kvm_kmem_gmem_write_begin(const struct kiocb *kiocb,=0A=
+				     struct address_space *mapping,=0A=
+				     loff_t pos, unsigned len,=0A=
+				     struct folio **foliop,=0A=
+				     void **fsdata)=0A=
+{=0A=
+	struct file *file =3D kiocb->ki_filp;=0A=
+	pgoff_t index =3D pos >> PAGE_SHIFT;=0A=
+	struct folio *folio;=0A=
+=0A=
+	if (!PAGE_ALIGNED(pos) || len !=3D PAGE_SIZE)=0A=
+		return -EINVAL;=0A=
+=0A=
+	if (pos + len > i_size_read(file_inode(file)))=0A=
+		return -EINVAL;=0A=
+=0A=
+	folio =3D kvm_gmem_get_folio(file_inode(file), index);=0A=
+	if (IS_ERR(folio))=0A=
+		return -EFAULT;=0A=
+=0A=
+	if (WARN_ON_ONCE(folio_test_large(folio))) {=0A=
+		folio_unlock(folio);=0A=
+		folio_put(folio);=0A=
+		return -EFAULT;=0A=
+	}=0A=
+=0A=
+	if (folio_test_uptodate(folio)) {=0A=
+		folio_unlock(folio);=0A=
+		folio_put(folio);=0A=
+		return -ENOSPC;=0A=
+	}=0A=
+=0A=
+	*foliop =3D folio;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int kvm_kmem_gmem_write_end(const struct kiocb *kiocb,=0A=
+				   struct address_space *mapping,=0A=
+				   loff_t pos, unsigned len, unsigned copied,=0A=
+				   struct folio *folio, void *fsdata)=0A=
+{=0A=
+	int ret;=0A=
+=0A=
+	if (copied =3D=3D len) {=0A=
+		kvm_gmem_mark_prepared(folio);=0A=
+		ret =3D copied;=0A=
+	} else {=0A=
+		filemap_remove_folio(folio);=0A=
+		ret =3D 0;=0A=
+	}=0A=
+=0A=
+	folio_unlock(folio);=0A=
+	folio_put(folio);=0A=
+=0A=
+	return ret;=0A=
+}=0A=
+=0A=
 static int kvm_gmem_migrate_folio(struct address_space *mapping,=0A=
 				  struct folio *dst, struct folio *src,=0A=
 				  enum migrate_mode mode)=0A=
@@ -442,6 +501,8 @@ static void kvm_gmem_free_folio(struct folio *folio)=0A=
 =0A=
 static const struct address_space_operations kvm_gmem_aops =3D {=0A=
 	.dirty_folio =3D noop_dirty_folio,=0A=
+	.write_begin =3D kvm_kmem_gmem_write_begin,=0A=
+	.write_end =3D kvm_kmem_gmem_write_end,=0A=
 	.migrate_folio	=3D kvm_gmem_migrate_folio,=0A=
 	.error_remove_folio =3D kvm_gmem_error_folio,=0A=
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE=0A=
@@ -489,6 +550,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t si=
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

