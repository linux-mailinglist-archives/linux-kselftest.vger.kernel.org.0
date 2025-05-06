Return-Path: <linux-kselftest+bounces-32515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D000CAACA6B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 18:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25C297B5043
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 16:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1579A283FF5;
	Tue,  6 May 2025 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nGmdfCnz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA152836B9
	for <linux-kselftest@vger.kernel.org>; Tue,  6 May 2025 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746547519; cv=none; b=OAcEc7FfTZbCL0qozS3BtTdtYGzGSpgd/rXasuwVx0TErVp9VjyAXEN0CYVggLog6rt7XvQ0knNZC9Qxh+nWrkSwIH8mnOd5OdKd4yCpsLZXc9GP1ffGehnPT0ieCRIoP126+NbXLT9isIzug1dBhNfAN1VH6s2qz6t+/x45fU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746547519; c=relaxed/simple;
	bh=kRp4IxyzyS/awOzFbebOHY+i3kmMtE/y4muUCSNf6Qs=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=qS6Ri/FXlXd1Yx+eX0RWfgTrqg5vgrFzY2sLh6nrGOLOJ0SCSRHIuLfKCEb4iQGosiYrPNmWCHgd7F6fWU++AujGLwCoozrKmmSnpgkeSoNq+MYAO0vacn73NsNXHvYNkDs9b0xMu2fciP0GQphNveoTPNnQqkZ7xGLDYw0hWOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nGmdfCnz; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22e5a558bfaso2929615ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 06 May 2025 09:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746547516; x=1747152316; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i1mo/Wo+ejg//AUbVLPWXwjlsnYrBMoTR6luF4u3TZs=;
        b=nGmdfCnz+COlgoDiCBZ4UxH91Q+YuEodJGv9wtVqdpiIvLNSlDfUTRAs8HuSuKPjhd
         gw9Vm1n+EAihd951/Ry+258AVq7nZCBBZTSpb7IJZzWWLhKw9pQvq/pxYeCRKzkFutCT
         p1aMwSmrxFo0koMwu3Sg7vHEVuqtFeCFZy4CWBYdmtKRG6apxCkwnlKOJJHM99diSmPP
         IcGXSMr0gV1cjBy7RiPArUqKCMQR1DzBFOtMRKPzVzbQwLlToJPLDNGthiR0RPiJW57R
         ga9N+SWSYc3O8h/Mqg5ZIi0MiGKlZuFY9whPeOAtCxLi+witiFBW4EFs0q90ea1L2Zud
         S5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746547516; x=1747152316;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1mo/Wo+ejg//AUbVLPWXwjlsnYrBMoTR6luF4u3TZs=;
        b=r4iBe5znJgCPLWJBQpYptihmQ0IWaRL8YVLjKPz9GlI/Mkc7ehuB05thj2vT63OL0n
         n/0vKfDZP+7MTBGY/V9T+b6DTOoVDgNsy7u7XoKZTGKucVabjX4m2msi8/iwjscNeGWA
         SqvzH10yiraZV7W5KDmqKNlZdJP4JR8k8yKXXYRfF+Sy6jNwswks49dYUoTiPAEROpG4
         J5OfSeO1gwVkYPMrPvu8mVnnpmPapwfh4QUumm0JOA//2Q++eCW551pFiCRmwSWYHsa1
         GsbwjxuOSsaS/sHQrD8p7Yq9mHH3HaaArSL8B0xvRq4hHf2MY64qA3RTj1nIhiir+Rq+
         tJxw==
X-Forwarded-Encrypted: i=1; AJvYcCWyrPuNBoiXhJopuxI1fptzIOax6w8eTJLXU3KcWuL79D1sa6Q8t83cZXJ/wXy0AuJwUKP/mTrKIGPSBkb1+28=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUmz5Y7qa9qAvPVgasoAAEr4Lom5TLT9Um9ncm1U3iBN42d31J
	bRjgNt7Bsa1Gkt8zANNzIJcfQgp55i2zA9z9zpGtjcX02zlAsxsrepPg+RXH1oOamLcHhVmolZi
	pPXtlsk0XjhVVxu8QKFIo8A==
X-Google-Smtp-Source: AGHT+IH5eiqM+GukGy4eHAEU6Tq2FHVB00BdiyUDeaIE6OKI+9mYaTJy4CBBv+vaOD5LVB3g3ewfS67gEdx2/54B0w==
X-Received: from pfbid12.prod.google.com ([2002:a05:6a00:8a8c:b0:73b:bbec:17e9])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2408:b0:223:37ec:63d5 with SMTP id d9443c01a7336-22e32ba8292mr60504445ad.28.1746547516646;
 Tue, 06 May 2025 09:05:16 -0700 (PDT)
Date: Tue, 06 May 2025 09:05:15 -0700
In-Reply-To: <ZN/81KNAWofRCaQK@google.com> (message from Sean Christopherson
 on Fri, 18 Aug 2023 16:20:52 -0700)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqzbjs5k9ms.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH 02/11] KVM: guest_mem: Add ioctl KVM_LINK_GUEST_MEMFD
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, tglx@linutronix.de, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, shuah@kernel.org, 
	andrew.jones@linux.dev, ricarkol@google.com, chao.p.peng@linux.intel.com, 
	tabba@google.com, jarkko@kernel.org, yu.c.zhang@linux.intel.com, 
	vannapurve@google.com, erdemaktas@google.com, mail@maciej.szmigiero.name, 
	vbabka@suse.cz, david@redhat.com, qperret@google.com, michael.roth@amd.com, 
	wei.w.wang@intel.com, liam.merwick@oracle.com, isaku.yamahata@gmail.com, 
	kirill.shutemov@linux.intel.com, Ryan Afranji <afranji@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Aug 07, 2023, Ackerley Tng wrote:
>> KVM_LINK_GUEST_MEMFD will link a gmem fd's underlying inode to a new
>> file (and fd).
>>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> ---
>>  include/uapi/linux/kvm.h |  8 +++++
>>  virt/kvm/guest_mem.c     | 73 ++++++++++++++++++++++++++++++++++++++++
>>  virt/kvm/kvm_main.c      | 10 ++++++
>>  virt/kvm/kvm_mm.h        |  7 ++++
>>  4 files changed, 98 insertions(+)
>>
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index eb900344a054..d0e2a2ce0df2 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -2299,4 +2299,12 @@ struct kvm_create_guest_memfd {
>>  	__u64 reserved[6];
>>  };
>>
>> +#define KVM_LINK_GUEST_MEMFD	_IOWR(KVMIO,  0xd5, struct kvm_link_guest_memfd)
>> +
>> +struct kvm_link_guest_memfd {
>> +	__u64 fd;
>> +	__u64 flags;
>> +	__u64 reserved[6];
>> +};
>> +
>>  #endif /* __LINUX_KVM_H */
>> diff --git a/virt/kvm/guest_mem.c b/virt/kvm/guest_mem.c
>> index 30d0ab8745ee..1b3df273f785 100644
>> --- a/virt/kvm/guest_mem.c
>> +++ b/virt/kvm/guest_mem.c
>> @@ -477,6 +477,79 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
>>  	return __kvm_gmem_create(kvm, size, flags, kvm_gmem_mnt);
>>  }
>>
>> +static inline void __kvm_gmem_do_link(struct inode *inode)
>> +{
>> +	/* Refer to simple_link() */
>> +
>> +	inode->i_ctime = current_time(inode);
>> +	inc_nlink(inode);
>> +
>> +	/*
>> +	 * ihold() to add additional reference to inode for reference in dentry,
>> +	 * created in kvm_gmem_alloc_file() -> alloc_file_pseudo(). This is not
>> +	 * necessary when creating a new file because alloc_inode() creates
>> +	 * inodes with i_count = 1, which is the refcount for the dentry in the
>> +	 * file.
>> +	 */
>> +	ihold(inode);
>> +
>> +	/*
>> +	 * dget() and d_instantiate() complete the setup of a dentry, but those
>> +	 * have already been done in kvm_gmem_alloc_file() ->
>> +	 * alloc_file_pseudo()
>> +	 */
>> +}

Thanks Sean, we're just circling back to this series, working on a next
revision.

>
> Does this have to be done before the fd is exposed to userspace, or can it be
> done after?

Does "exposed to userspace" mean the call to get_unused_fd_flags(),
where an fd is reserved?

Do you mean to make this reservation as late as possible?

> If it can be done after, I'd prefer to have the allocation helper
> also install the fd, and also rename it to something that better conveys that
> it's allocating more than just the file, e.g. that it allocates and initialize
> kvm_gmem too.
>
> Completely untested, but this is what I'm thinkin/hoping.
>
> static int kvm_gmem_alloc_view(struct kvm *kvm, struct inode *inode,
> 			       struct vfsmount *mnt)

Will rename this kvm_gmem_alloc_view(), that naming totally makes
sense, and attaches a meaning to the struct file as a view into the
memory.

> {
> 	struct file *file;
> 	struct kvm_gmem *gmem;
>
> 	gmem = kzalloc(sizeof(*gmem), GFP_KERNEL);
> 	if (!gmem)
> 		return -ENOMEM;
>
> 	fd = get_unused_fd_flags(0);
> 	if (fd < 0) {
> 		r = fd;
> 		goto err_fd;
> 	}

Do you see the fd as part of the view? I thought the fd is just a handle
to the view (struct file).

>
> 	file = alloc_file_pseudo(inode, mnt, "kvm-gmem", O_RDWR, &kvm_gmem_fops);
> 	if (IS_ERR(file)) {
> 		r = PTR_ERR(file);
> 		goto err_file;
> 	}
>
> 	file->f_flags |= O_LARGEFILE;
> 	file->f_mapping = inode->i_mapping;
>
> 	kvm_get_kvm(kvm);
> 	gmem->kvm = kvm;
> 	xa_init(&gmem->bindings);
>
> 	file->private_data = gmem;
>
> 	list_add(&gmem->entry, &inode->i_mapping->private_list);
>
> 	fd_install(fd, file);
>
> 	return 0;
> err:
> 	put_unused_fd(fd);
> err_fd:
> 	kfree(gmem);
> 	return r;
> }
>
> static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags,
> 			     struct vfsmount *mnt)
> {
> 	const char *anon_name = "[kvm-gmem]";
> 	const struct qstr qname = QSTR_INIT(anon_name, strlen(anon_name));
> 	struct inode *inode;
> 	struct file *file;
> 	int fd, err;
>
> 	inode = alloc_anon_inode(mnt->mnt_sb);
> 	if (IS_ERR(inode))
> 		return PTR_ERR(inode);
>
> 	err = security_inode_init_security_anon(inode, &qname, NULL);
> 	if (err)
> 		goto err;
>
> 	inode->i_private = (void *)(unsigned long)flags;
> 	inode->i_op = &kvm_gmem_iops;
> 	inode->i_mapping->a_ops = &kvm_gmem_aops;
> 	inode->i_mode |= S_IFREG;
> 	inode->i_size = size;
> 	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
> 	mapping_set_large_folios(inode->i_mapping);
> 	mapping_set_unevictable(inode->i_mapping);
> 	mapping_set_unmovable(inode->i_mapping);
>
> 	fd = kvm_gmem_alloc_view(kvm, inode, mnt);
> 	if (fd < 0) {
> 		err = fd;
> 		goto err;
> 	}
> 	return fd;
> err:
> 	iput(inode);
> 	return err;
> }

