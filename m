Return-Path: <linux-kselftest+bounces-43562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 385F1BF255A
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 18:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E4718A6629
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 16:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44DF2848A0;
	Mon, 20 Oct 2025 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="r0bRcpFQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com [35.158.23.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E355284671;
	Mon, 20 Oct 2025 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.158.23.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976858; cv=none; b=Ool+zj6+6xiSoKjZgzYPUVsJX/Ul/DrvB33n8P/EX+fTyN9IhV8QkS6UzYmqHNbOqZmUqiGTAb8QFNVxxa8MLOhfRyYEGsUvXqRkxx09Rewk/VK863ib0xf6CHT1jD8KbQWonHFVCnrjNVn2DMldPm7ma0GW55+BN+w3VngcWB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976858; c=relaxed/simple;
	bh=n0SF7XdAN+SKJyChrtucQj/9yIMiZFAkj8Z+b9LPqOc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NYdmuzpF9Rv3qaPEECPlUTkrKukk783JX5HOLbIEQmt3jyieZALKmyu5i+z6bCLjF0mnV7AidbjuekXnwceP8b/ZdkwosYj+BTCwlIMKy1RI3JhHembn30twza44+JLqQFOhSN6Wql9ILi3dd/Uvs8k57WvGQiBieQ5woHotoYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=r0bRcpFQ; arc=none smtp.client-ip=35.158.23.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1760976856; x=1792512856;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bDE/UgJKgZwC9aFtGJ5WbzVcYQJbFk3uDJQx4+C3IGI=;
  b=r0bRcpFQYQSgEYyyRC1u+Pax4sOFVP9KFNoJkD3H7JYfW4K7OSFk1qFO
   zJCi+7v1pqJCSG8tdBPsCeG0OXoOjKZgFcLuJ+zspK/WeawtFYRC1EGRe
   9UbYNmudCYXvxcIxBMgMFNhp5IkjgZIJ6rQJU+w9CsXe6bxYPNN8j+PHJ
   QyLk+OrQIGI2YutMSONsdPzsEhAQouquYgPoE1mqdc4yWxZaHnA9cSe6p
   zChzQ0nWDH5IYd7Rme25rRFU67mR8fvCRAxwe5GQcAgkAbiqzQcHTqgq/
   ZkVASFpUT6umqw6hqxps899Y1bAvUZRj824WYYsHbBcX8gR8vxwrdrLZX
   A==;
X-CSE-ConnectionGUID: EzV4z7h5Tyq/esQTJyqbfg==
X-CSE-MsgGUID: TWPY43StSWiT/Jkndqj2qg==
X-IronPort-AV: E=Sophos;i="6.19,242,1754956800"; 
   d="scan'208";a="3899445"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 16:14:06 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.234:19895]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.18.241:2525] with esmtp (Farcaster)
 id a5299e80-435c-40e6-94ce-2de2a320a4cc; Mon, 20 Oct 2025 16:14:06 +0000 (UTC)
X-Farcaster-Flow-ID: a5299e80-435c-40e6-94ce-2de2a320a4cc
Received: from EX19D022EUC003.ant.amazon.com (10.252.51.167) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 20 Oct 2025 16:14:05 +0000
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19D022EUC003.ant.amazon.com (10.252.51.167) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 20 Oct 2025 16:14:05 +0000
Received: from EX19D022EUC002.ant.amazon.com ([fe80::bd:307b:4d3a:7d80]) by
 EX19D022EUC002.ant.amazon.com ([fe80::bd:307b:4d3a:7d80%3]) with mapi id
 15.02.2562.020; Mon, 20 Oct 2025 16:14:05 +0000
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
Subject: [PATCH v6 1/2] KVM: guest_memfd: add generic population via write
Thread-Topic: [PATCH v6 1/2] KVM: guest_memfd: add generic population via
 write
Thread-Index: AQHcQdyOdC7YhcHS8EaGGq7hvFXtwg==
Date: Mon, 20 Oct 2025 16:14:05 +0000
Message-ID: <20251020161352.69257-2-kalyazin@amazon.com>
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
write syscall populates guest_memfd with user-supplied data in a generic=0A=
way, ie no vendor-specific preparation is performed.  If the request is=0A=
not page-aligned, the remaining bytes are initialised to 0.=0A=
=0A=
write is only supported for non-CoCo setups where guest memory is not=0A=
hardware-encrypted.=0A=
=0A=
Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>=0A=
---=0A=
 virt/kvm/guest_memfd.c | 48 ++++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 48 insertions(+)=0A=
=0A=
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c=0A=
index 94bafd6c558c..f4e218049afa 100644=0A=
--- a/virt/kvm/guest_memfd.c=0A=
+++ b/virt/kvm/guest_memfd.c=0A=
@@ -380,6 +380,8 @@ static int kvm_gmem_mmap(struct file *file, struct vm_a=
rea_struct *vma)=0A=
 =0A=
 static struct file_operations kvm_gmem_fops =3D {=0A=
 	.mmap		=3D kvm_gmem_mmap,=0A=
+	.llseek		=3D default_llseek,=0A=
+	.write_iter     =3D generic_perform_write,=0A=
 	.open		=3D generic_file_open,=0A=
 	.release	=3D kvm_gmem_release,=0A=
 	.fallocate	=3D kvm_gmem_fallocate,=0A=
@@ -390,6 +392,49 @@ void kvm_gmem_init(struct module *module)=0A=
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
+	struct inode *inode =3D file_inode(file);=0A=
+	pgoff_t index =3D pos >> PAGE_SHIFT;=0A=
+	struct folio *folio;=0A=
+=0A=
+	if (!kvm_gmem_supports_mmap(inode))=0A=
+		return -ENODEV;=0A=
+=0A=
+	if (pos + len > i_size_read(inode))=0A=
+		return -EINVAL;=0A=
+=0A=
+	folio =3D kvm_gmem_get_folio(inode, index);=0A=
+	if (IS_ERR(folio))=0A=
+		return -EFAULT;=0A=
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
+	if (copied && copied < len) {=0A=
+		unsigned int from =3D pos & ((1UL << folio_order(folio)) - 1);=0A=
+=0A=
+		folio_zero_range(folio, from + copied, len - copied);=0A=
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
@@ -442,6 +487,8 @@ static void kvm_gmem_free_folio(struct folio *folio)=0A=
 =0A=
 static const struct address_space_operations kvm_gmem_aops =3D {=0A=
 	.dirty_folio =3D noop_dirty_folio,=0A=
+	.write_begin =3D kvm_kmem_gmem_write_begin,=0A=
+	.write_end =3D kvm_kmem_gmem_write_end,=0A=
 	.migrate_folio	=3D kvm_gmem_migrate_folio,=0A=
 	.error_remove_folio =3D kvm_gmem_error_folio,=0A=
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE=0A=
@@ -489,6 +536,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t si=
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

