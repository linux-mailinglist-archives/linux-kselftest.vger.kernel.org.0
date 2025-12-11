Return-Path: <linux-kselftest+bounces-47447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11228CB6D78
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 19:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C126A301E6C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 18:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A9331197E;
	Thu, 11 Dec 2025 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qtr1MYk5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SGBMzhWG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5C5316197
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765475672; cv=none; b=Ec//A0wskHAHnGbUeYKYQLC5u04Jt6e4B9ugZtmHsWYIbMB7FaQ5DbUWSKogZvDvIqcMg9xcXdrIWUB/ySbAG21dH3pUf+g/zfrTxvIJmkt5BhtotZmgz3focu4YVCvbI9QjocbiGlCo6I/nV5SS1JZkta6LdoiKn7bV9Vkrnhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765475672; c=relaxed/simple;
	bh=T7pjnhmn3U59zEBpymWdkY81rHaunzt4BBUTKm53zwg=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=A6ItJrrlH2iZEM4afGb5II2AIzrktWhqrumrN8lSMHV2uUD0LGm/lykdh3GYzhh1P4h2hkxSBGc2GbrLHeIGiJbgb7NNQZ43YdHu9xvTl7l9dq2JSPmal0wuKB5sKIRvb19P/qiKn2vTsHS4ZfLmFbiOvoAt1wBoUIAW1maE/OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qtr1MYk5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SGBMzhWG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765475670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=T6K6T28DoHunvDKpuEqj+Ae7g7B6b79uBdSlE9I255k=;
	b=Qtr1MYk53uz2Wgx5QlJkFxQYKjDfowqAFzV8YwRjxH9z1S7goyTaYcClZFYJeXOlnaTBJ/
	lSl5j9N14rp5wHwCTnBZ+2nGbf0+ZL04SRUgF+DIuF+CrAgeRjpVIvKpVTHfeMDd72TCiX
	CykfOPr4ZqjpZkzkNg/1MVU1TycFYiU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-Odb1BVEEMtCOshxofFCyDQ-1; Thu, 11 Dec 2025 12:54:28 -0500
X-MC-Unique: Odb1BVEEMtCOshxofFCyDQ-1
X-Mimecast-MFC-AGG-ID: Odb1BVEEMtCOshxofFCyDQ_1765475668
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47799717212so3031805e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 09:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765475668; x=1766080468; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T6K6T28DoHunvDKpuEqj+Ae7g7B6b79uBdSlE9I255k=;
        b=SGBMzhWGqi77KuxwH8i4PMwv+245/C/rlE7vQYslGqvf3XfCnNA4C8hSGUzFS9y89g
         G37VBMyAylc9/Sll5bteURJ8s0ke+gN6ffg1TYGadO0TcW83QE1QLQQ3Mhh7dO8iTy/S
         CrXD2CrZt86ln1YUtznyxZKxWyQfSh54ABHfhVvFtC1o5ZNnTr/GegJYq43UvB2xNIhR
         iBXpW8HBun9G0jfyYP4qP3WnrZt/3c1KSe8e5lZ2zqkpF0yt3vZMuAEsqvTGKLR1jh6t
         bZDnONP/QLSWjD7HOgiYHKlx0j/0kZwm2inGGS3DRpyQFuB8dQLIG02cBp0kjfISimDQ
         UG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765475668; x=1766080468;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6K6T28DoHunvDKpuEqj+Ae7g7B6b79uBdSlE9I255k=;
        b=lfnPeitoqzSfB8L7NtcsUWfhKUXiBJ0wz7K9b7IxF245UBHB55en9cPZRNi59ovIPa
         lz2qmgzHBA0L/Rgnf/VLAoPpUgGpMMwwF5zrTKJf4rAm/7zh7MnnYEP0caF4mQpGeLLt
         PNcEzEQuNUPtJ+rz+PJpFPzJ1HUfUe8CIXxNzpbETDlnH9idmyT2zZtwqmbaOWEMUene
         9WbOYS7PN2sXj2b+/CAnqyT5s2vR7YHYshQY4uGGB09Q3UztWq39O5Roh9mKZaNhU3i8
         /Bdmj6K8HaWLmM31f2+ms34zJrtPaFIW7wiwh4cLNI5X6I1X/XYb+FqKANXGbufOti2X
         J+ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsDR+Wt8AxR+K2/2o2iFzXoQwZut/f9WjFLg0atl41mO+mtuUJ3C97JSAQBUwuizogqFvzTWBwi9SOkJW4wMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBC6WlieVxOpd+akcLni+S8fxZR9dU0jZD/ve90n/SWfAplR4A
	77g8xXV/zi0XZn7zXShILsaXX0F9URj2nkHCQskn0ieOS1d57GwxNkdQCzZRdSBGcKlFcxb6Fk6
	gAitRjrEpO3GLsLLK7/OzBohVVWt4abxLMWHtS+iUbWpP1riUQ2uHojGZ0ridYrPU7Ib6oQ==
X-Gm-Gg: AY/fxX5M5qYaeRSrEs/qoJWc+UBYZzn/WVROpAkFEmXJpGN0pA5LzD7mDEO5IPju+YF
	d1y7v1j/7U3vMSMjlLjDzzYH4Vybq7Yip90Tn54mI2SQ9h7xYOfc2G3dBbmX43TkR1PQue8sV9E
	j6OJ5ZMcOxgylI8XEiPZfSnhvw26Kb0ZJd/ndXfJDxlQyjFxktqeJdnpXMpOd7iJyNMOQpMq8BA
	XJYWrPVDC2IJDxNkhQH5Z6fxKIojpCg8ZnClkMUKT7sUt7IMnOjQvHXR7gSXQslG4VQYX296lJA
	sTFizAyl9l4lDGMpfuDctaofXeeHiZSTJxAl/Ft3Wu3rtumjphlWRG/7+jwc+Ybse4iaX0sxrWg
	H3pf58VoOHmoQaVtO2e8Qc21EYWp1HqeHhGwwpDu5jQWeOUKkNMjdOxqlQJM=
X-Received: by 2002:a05:600c:3113:b0:477:7768:8da4 with SMTP id 5b1f17b1804b1-47a856249c2mr52649455e9.7.1765475667690;
        Thu, 11 Dec 2025 09:54:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHq0XWIIYYXwcFnEjkxgRdCPkys75t8d81jvLJeRmVOioi3bdjzbj+DUjq8WDsmC59BFVUkYA==
X-Received: by 2002:a05:600c:3113:b0:477:7768:8da4 with SMTP id 5b1f17b1804b1-47a856249c2mr52649305e9.7.1765475667310;
        Thu, 11 Dec 2025 09:54:27 -0800 (PST)
Received: from rh (p200300f6af498100e5be2e2bdb5254b6.dip0.t-ipconnect.de. [2003:f6:af49:8100:e5be:2e2b:db52:54b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a89da3ed7sm46616035e9.4.2025.12.11.09.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:54:26 -0800 (PST)
Date: Thu, 11 Dec 2025 18:54:25 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Jiaqi Yan <jiaqiyan@google.com>, Oliver Upton <oupton@kernel.org>, 
    Marc Zyngier <maz@kernel.org>, Shuah Khan <shuah@kernel.org>
cc: kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: sea_to_user sefltest failure
Message-ID: <1478ac09-8134-5551-13b6-c7be096262af@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

Hi,

sea_to_user fails for me with:

Random seed: 0x6b8b4567
==== Test Assertion Failure ====
   include/kvm_syscalls.h:58: mem != MAP_FAILED
   pid=4923 tid=4923 errno=12 - Cannot allocate memory
      1  0x0000000000405afb: __kvm_mmap at kvm_syscalls.h:58 (discriminator 3)
      2   (inlined by) kvm_mmap at kvm_syscalls.h:65 (discriminator 3)
      3   (inlined by) vm_mem_add at kvm_util.c:1036 (discriminator 3)
      4  0x0000000000402377: vm_create_with_sea_handler at sea_to_user.c:278
      5   (inlined by) main at sea_to_user.c:324
      6  0x0000ffff8d0a621b: ?? ??:0
      7  0x0000ffff8d0a62fb: ?? ??:0
      8  0x000000000040282f: _start at ??:?
   mmap() failed, rc: -1 errno: 12 (Cannot allocate memory)

this could be related to my config?
# CONFIG_CGROUP_HUGETLB is not set
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
# CONFIG_PERSISTENT_HUGE_ZERO_FOLIO is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
# CONFIG_TRANSPARENT_HUGEPAGE_NEVER is not set
CONFIG_TRANSPARENT_HUGEPAGE_SHMEM_HUGE_NEVER=y
# CONFIG_TRANSPARENT_HUGEPAGE_SHMEM_HUGE_ALWAYS is not set
# CONFIG_TRANSPARENT_HUGEPAGE_SHMEM_HUGE_WITHIN_SIZE is not set
# CONFIG_TRANSPARENT_HUGEPAGE_SHMEM_HUGE_ADVISE is not set
CONFIG_TRANSPARENT_HUGEPAGE_TMPFS_HUGE_NEVER=y
# CONFIG_TRANSPARENT_HUGEPAGE_TMPFS_HUGE_ALWAYS is not set
# CONFIG_TRANSPARENT_HUGEPAGE_TMPFS_HUGE_WITHIN_SIZE is not set
# CONFIG_TRANSPARENT_HUGEPAGE_TMPFS_HUGE_ADVISE is not set
CONFIG_PGTABLE_HAS_HUGE_LEAVES=y
CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP=y
CONFIG_ARCH_SUPPORTS_HUGETLBFS=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING=y

Looking at the code smth like this would skip the test:
get_backing_src_pagesz(VM_MEM_SRC_ANONYMOUS_HUGETLB);

..or is this not worth the effort and my config is too weird?

Thanks,
Sebastian


