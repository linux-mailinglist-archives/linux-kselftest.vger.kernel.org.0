Return-Path: <linux-kselftest+bounces-40558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FA5B3FDA1
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 13:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2E02C35AC
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 11:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74FB2F3C0E;
	Tue,  2 Sep 2025 11:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="E+nlK09L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.158.153.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792002DEA7E;
	Tue,  2 Sep 2025 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.158.153.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756812019; cv=none; b=ATyhwFZttGhlqrvm7ij8X9lUxrbOq4QtvDmI+6TezyWjLShqT9lszRSbbMP9yB1MYleNFo08MHIu+cQICDNFGkiFC+kXs1+seREFm5CiEgIKblMN/1nYtz76gQA84cRG+N2Hzfbdf16sMlILUvij1zMbCY0e/ceeG5Fj0vIRgW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756812019; c=relaxed/simple;
	bh=ZQ6djA+dRF8qyUysrpr2yHONyU+cbnc0/dSjjBZtaT0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ISrT8awLfHPqmFQsGf0yC/UFuMs7hQf9/FFc9NJfiZ+vlZ31GZUZMmOfZS9CkFTXrRHw0mo4OQFmLTEOWHFUzYRhITBtEoZWEYFDR2xf21PzaZs2569yvGl2YqA7HlKeQ1O7IOWfhwegVGsgskyb0s8W2olCZPbtejER1y44YKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=E+nlK09L; arc=none smtp.client-ip=18.158.153.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1756812018; x=1788348018;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k50yHNxHR2sgIbO76emzZ9LzG11xHWAXrYW1I23pwro=;
  b=E+nlK09L3LZSzu0paWxomxfhmW+xs8wPRNMAWl8QLy1Lz5hUoGamt04k
   qig4SAI98rraQdZIExWts1Pe305uYtnYtv33j5im/dGjRBWm9KFJTJPr2
   32tF+NB9/Wg3ExfocIgws6oUT0xbbfKm9YM+8vC2no9APk0FiTGKCoDyp
   bKDCkzl/adDLK577A/t8gPbx5K2YjaKD50GEAgcKCjPoythEwqLnGb8Ne
   qDCitFihY+NbbyW/nojiuPk45xS2m8OwBevGITMNTw8NY6Awc9AOoxneC
   leeB04e7TS/mru4DaRpFMe1TnKMDGrgPJnCWqVMgDhmPEobUyiTVwGsTp
   A==;
X-CSE-ConnectionGUID: JAVDfZM0QRS/seye0FcEGA==
X-CSE-MsgGUID: NqQ5f8IeTWu7wbMj5xPXvw==
X-IronPort-AV: E=Sophos;i="6.17,290,1747699200"; 
   d="scan'208";a="1403118"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 11:20:04 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:19714]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.43.161:2525] with esmtp (Farcaster)
 id ecc57207-eff7-433b-8959-d9e5a6fff1f4; Tue, 2 Sep 2025 11:20:04 +0000 (UTC)
X-Farcaster-Flow-ID: ecc57207-eff7-433b-8959-d9e5a6fff1f4
Received: from EX19D022EUC003.ant.amazon.com (10.252.51.167) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Tue, 2 Sep 2025 11:20:04 +0000
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19D022EUC003.ant.amazon.com (10.252.51.167) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 2 Sep 2025 11:20:04 +0000
Received: from EX19D022EUC002.ant.amazon.com ([fe80::bd:307b:4d3a:7d80]) by
 EX19D022EUC002.ant.amazon.com ([fe80::bd:307b:4d3a:7d80%3]) with mapi id
 15.02.2562.020; Tue, 2 Sep 2025 11:20:04 +0000
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
Subject: [PATCH v5 1/2] KVM: guest_memfd: add generic population via write
Thread-Topic: [PATCH v5 1/2] KVM: guest_memfd: add generic population via
 write
Thread-Index: AQHcG/uHLx3YvTm960eFD//SgYmnaA==
Date: Tue, 2 Sep 2025 11:20:03 +0000
Message-ID: <20250902111951.58315-2-kalyazin@amazon.com>
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
index 08a6bc7d25b6..a2e86ec13e4b 100644=0A=
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
+				     loff_t pos, unsigned int len,=0A=
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
+				   loff_t pos, unsigned int len,=0A=
+				   unsigned int copied,=0A=
+				   struct folio *folio, void *fsdata)=0A=
+{=0A=
+	if (copied) {=0A=
+		if (copied < len) {=0A=
+			unsigned int from =3D pos & (PAGE_SIZE - 1);=0A=
+=0A=
+			folio_zero_range(folio, from + copied, len - copied);=0A=
+		}=0A=
+		kvm_gmem_mark_prepared(folio);=0A=
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

