Return-Path: <linux-kselftest+bounces-31339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DBCA97390
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 19:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F4B3A7045
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 17:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5EA297A7E;
	Tue, 22 Apr 2025 17:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sup2C2og"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD52296D1B
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745342721; cv=none; b=uQ4ICLWhvMeMj+fQSiXbD7q3+ng2T/HJ7KzoMEKaJwhOnaTriEHxKYyad+X5tvIFxfmHSxFHVuugeznHT+JO5M3wUDQ6FOO6ySGkaaHMMWDgsMsmRbpLlJeEWEkEPNBYfNuPK6hdUbxNKVgASQJcyWaNQcNCUQxRuo0DHMhpI/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745342721; c=relaxed/simple;
	bh=4eFT+ddUgf/MynCnAqV2xPC+DUEYZuUSd9SxFogWjGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZga452ZHEabvH02c26ZcGWbEOO87rzvNqTxXA2PzEBzrG0bs83drjQ4LkGiu8ptbk34/AWr44f9RJfrM8szyVkn8oUuMxL/k+4RzzVLsnGF9pkdW6epx9uq8FRZyYNHo1KgqwHq+CPCpdvayqj1OGcYhG+Dipto+iQL4tuoZB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sup2C2og; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745342717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AlsF8bB7mLO6h5yOJV7f9wu/vSQAYRdULalqxfc/a/E=;
	b=Sup2C2og87+iqD0+y0opeUh2Yzb3RhtRGcg3IvheVsvbPC3jdxkXElhijTP7dif3KUoqKC
	P4SNrXyv24mdqG5GWx5y/AlBR1GT/yJe3R6DVJHswM5eCpwSG8YJqW48CNbOtBiTI5vtss
	Vt4BDObBJ7R8+JJyc5VbloPioqV+4eg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-u_D_9bQwPfGpow79DwR03A-1; Tue, 22 Apr 2025 13:25:16 -0400
X-MC-Unique: u_D_9bQwPfGpow79DwR03A-1
X-Mimecast-MFC-AGG-ID: u_D_9bQwPfGpow79DwR03A_1745342715
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d08915f61so30136355e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Apr 2025 10:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745342715; x=1745947515;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AlsF8bB7mLO6h5yOJV7f9wu/vSQAYRdULalqxfc/a/E=;
        b=L3D6HEHArNkzKIMfY7CMLQtRhv+TUlfP7ZEVjRRkEwrSMz1vomObUJ0F318iy723Aj
         aUuzNP3D0vhk1IWK0B7CWPIKbvOnkICkXwV4MYsxKHTZHnjO8WDbB44zflvopch4pmfg
         nW/1qILWBKiBoJw3iByHJBIoFg2Sv5Tdok5KJNOlPTL7APCFx67ipxKGjnbkUoHXWJFj
         IZZbYw6pGYUnZ9MxEOIGYKG9EGvhXU4Jls3DCoVLhKXN5l1oRLqu0lwfLmgQIsJksu5a
         RgRE9tP763p0LkPvM5wWX1y928Gz//2YCIU0vqpwRr5oTpvEwweD/J5CBEISqJeRAK7u
         Q5yw==
X-Forwarded-Encrypted: i=1; AJvYcCVfU5EOszvjJSWw64x29DUpoYFcRI2QoKnr3IJs2VbdQyHp/7JuofzP8UZ0K8444UDkcbGSFx9lRlErsXgDmYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt5OuowNALiVc7m7t9hGjGRBWA5Xc2Oa3InJ1Rp7TULsC1wP+A
	DOA6BzzhmI8UcdJgHIAe5bn20iRSYGhbxvU+zCzJK/EtBN56Vrxwt/A8x2L8q+Gq//MzVyNbUO9
	VAa/Oo56SOKOYF2zDLxsY4jMSa75n99FyJHkb917K+K1m3jk+u7Pokojxv1elPWruhw==
X-Gm-Gg: ASbGncvY+IeLgMp4ihr0ezm4I+aR67aPlueuzZrw8pHd+RtZPTDWE+Vxaa3Rwskw3iE
	shPI0TlX8IhI5R83JYnZxaoNw5oueSpSN8MR2VUtaH9EDhldcd1qyGtO1opgPgNrYa/eoz0zMyH
	oMMajZ5LpjcZaLzKnMiT074ZDhitCC/pT3piHSezBK2deruoe/BvWhpqILHeuLdS9TN1KEsQGl9
	v+K2Wbpm4tNznB5FtPmFyXdBrpIuXgvwURkkEo207vUAEqXW7a7MNCngwrmbx9Jk1fh4mxdRMFM
	dAvf5FNDwdXIma7LYlU4mCPcnjCCupf4k9g2Gjju4UCrlhg+staDqZzR9oq+V82XB8gOxFyXgN9
	XcqP4q/A4haxSetPQ8H+lZJEaSD00QM5s9GKh
X-Received: by 2002:a05:600c:3154:b0:43d:36c:f24 with SMTP id 5b1f17b1804b1-4406ab97d6amr138565815e9.13.1745342715338;
        Tue, 22 Apr 2025 10:25:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFktvjOJw9MtQ957iwKCDYuBMP9s5b2E7h4EADLtf2ryrYEiq0M4Q5bYb99jVnuXjG8D4LoA==
X-Received: by 2002:a05:600c:3154:b0:43d:36c:f24 with SMTP id 5b1f17b1804b1-4406ab97d6amr138565515e9.13.1745342714950;
        Tue, 22 Apr 2025 10:25:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c731:8700:3969:7786:322:9641? (p200300cbc73187003969778603229641.dip0.t-ipconnect.de. [2003:cb:c731:8700:3969:7786:322:9641])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d6db10csm180519755e9.27.2025.04.22.10.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 10:25:14 -0700 (PDT)
Message-ID: <b9e5fa41-62fd-4b3d-bb2d-24ae9d3c33da@redhat.com>
Date: Tue, 22 Apr 2025 19:25:12 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v7 3/8] security: Export
 security_inode_init_security_anon for KVM guest_memfd
To: Christoph Hellwig <hch@infradead.org>, Shivank Garg <shivankg@amd.com>
Cc: seanjc@google.com, vbabka@suse.cz, willy@infradead.org,
 akpm@linux-foundation.org, shuah@kernel.org, pbonzini@redhat.com,
 ackerleytng@google.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, tabba@google.com,
 vannapurve@google.com, chao.gao@intel.com, bharata@amd.com, nikunj@amd.com,
 michael.day@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com,
 kalyazin@amazon.com, peterx@redhat.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 Paul Moore <paul@paul-moore.com>
References: <20250408112402.181574-1-shivankg@amd.com>
 <20250408112402.181574-4-shivankg@amd.com> <Z_eEUrkyq1NApL1U@infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z_eEUrkyq1NApL1U@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.04.25 10:41, Christoph Hellwig wrote:
> On Tue, Apr 08, 2025 at 11:23:57AM +0000, Shivank Garg wrote:
>> KVM guest_memfd is implementing its own inodes to store metadata for
>> backing memory using a custom filesystem. This requires the ability to
>> initialize anonymous inode using security_inode_init_security_anon().
>>
>> As guest_memfd currently resides in the KVM module, we need to export this
>> symbol for use outside the core kernel. In the future, guest_memfd might be
>> moved to core-mm, at which point the symbols no longer would have to be
>> exported. When/if that happens is still unclear.
> 
> This really should be a EXPORT_SYMBOL_GPL, if at all.
> 
> But you really should look into a new interface in anon_inode.c that
> can be reused instead of duplicating anonymouns inode logic in kvm.ko.

I assume you mean combining the alloc_anon_inode()+
security_inode_init_security_anon(), correct?

I can see mm/secretmem.c doing the same thing, so agreed that
we're duplicating it.


Regarding your other mail, I am also starting to wonder where/why
we want security_inode_init_security_anon(). At least for
mm/secretmem.c, it was introduced by:

commit 2bfe15c5261212130f1a71f32a300bcf426443d4
Author: Christian Göttsche <cgzones@googlemail.com>
Date:   Tue Jan 25 15:33:04 2022 +0100

     mm: create security context for memfd_secret inodes
     
     Create a security context for the inodes created by memfd_secret(2) via
     the LSM hook inode_init_security_anon to allow a fine grained control.
     As secret memory areas can affect hibernation and have a global shared
     limit access control might be desirable.
     
     Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
     Signed-off-by: Paul Moore <paul@paul-moore.com>


In combination with Paul's review comment [1]

"
This seems reasonable to me, and I like the idea of labeling the anon
inode as opposed to creating a new set of LSM hooks.  If we want to
apply access control policy to the memfd_secret() fds we are going to
need to attach some sort of LSM state to the inode, we might as well
use the mechanism we already have instead of inventing another one.
"


IIUC, we really only want security_inode_init_security_anon() when there
might be interest to have global access control.


Given that guest_memfd already shares many similarities with guest_memfd
(e.g., pages not swappable/migratable) and might share even more in the future
(e.g., directmap removal), I assume that we want the same thing for guest_memfd.


Would something like the following seem reasonable? We should be adding some
documentation for the new function, and I wonder if S_PRIVATE should actually
be cleared for secretmem + guest_memfd (I have no idea what this "fs-internal" flag
affects).

 From 782a6053268d8a2bddf90ba18c008495b0791710 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Tue, 22 Apr 2025 19:22:00 +0200
Subject: [PATCH] tmp

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  fs/anon_inodes.c   | 20 ++++++++++++++------
  include/linux/fs.h |  1 +
  mm/secretmem.c     |  9 +--------
  3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 583ac81669c24..ea51fd582deb4 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -55,17 +55,18 @@ static struct file_system_type anon_inode_fs_type = {
  	.kill_sb	= kill_anon_super,
  };
  
-static struct inode *anon_inode_make_secure_inode(
-	const char *name,
-	const struct inode *context_inode)
+static struct inode *anon_inode_make_secure_inode(struct super_block *s,
+		const char *name, const struct inode *context_inode,
+		bool fs_internal)
  {
  	struct inode *inode;
  	int error;
  
-	inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
+	inode = alloc_anon_inode(s);
  	if (IS_ERR(inode))
  		return inode;
-	inode->i_flags &= ~S_PRIVATE;
+	if (!fs_internal)
+		inode->i_flags &= ~S_PRIVATE;
  	error =	security_inode_init_security_anon(inode, &QSTR(name),
  						  context_inode);
  	if (error) {
@@ -75,6 +76,12 @@ static struct inode *anon_inode_make_secure_inode(
  	return inode;
  }
  
+struct inode *alloc_anon_secure_inode(struct super_block *s, const char *name)
+{
+	return anon_inode_make_secure_inode(s, name, NULL, true);
+}
+EXPORT_SYMBOL_GPL(alloc_anon_secure_inode);
+
  static struct file *__anon_inode_getfile(const char *name,
  					 const struct file_operations *fops,
  					 void *priv, int flags,
@@ -88,7 +95,8 @@ static struct file *__anon_inode_getfile(const char *name,
  		return ERR_PTR(-ENOENT);
  
  	if (make_inode) {
-		inode =	anon_inode_make_secure_inode(name, context_inode);
+		inode =	anon_inode_make_secure_inode(anon_inode_mnt->mnt_sb,
+						     name, context_inode, false);
  		if (IS_ERR(inode)) {
  			file = ERR_CAST(inode);
  			goto err;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e3..0fded2e3c661a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3550,6 +3550,7 @@ extern int simple_write_begin(struct file *file, struct address_space *mapping,
  extern const struct address_space_operations ram_aops;
  extern int always_delete_dentry(const struct dentry *);
  extern struct inode *alloc_anon_inode(struct super_block *);
+extern struct inode *alloc_anon_secure_inode(struct super_block *, const char *);
  extern int simple_nosetlease(struct file *, int, struct file_lease **, void **);
  extern const struct dentry_operations simple_dentry_operations;
  
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 1b0a214ee5580..c0e459e58cb65 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -195,18 +195,11 @@ static struct file *secretmem_file_create(unsigned long flags)
  	struct file *file;
  	struct inode *inode;
  	const char *anon_name = "[secretmem]";
-	int err;
  
-	inode = alloc_anon_inode(secretmem_mnt->mnt_sb);
+	inode = alloc_anon_secure_inode(secretmem_mnt->mnt_sb, anon_name);
  	if (IS_ERR(inode))
  		return ERR_CAST(inode);
  
-	err = security_inode_init_security_anon(inode, &QSTR(anon_name), NULL);
-	if (err) {
-		file = ERR_PTR(err);
-		goto err_free_inode;
-	}
-
  	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
  				 O_RDWR, &secretmem_fops);
  	if (IS_ERR(file))
-- 
2.49.0


[1] https://lore.kernel.org/lkml/CAHC9VhSdGeZ9x-0Hvk9mE=YMXbpk-tC5Ek+uGFGq5U+51qjChw@mail.gmail.com/

-- 
Cheers,

David / dhildenb


