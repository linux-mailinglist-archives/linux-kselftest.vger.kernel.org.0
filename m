Return-Path: <linux-kselftest+bounces-43435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 692FEBEB95F
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 22:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228A83A5F34
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 20:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BCA338904;
	Fri, 17 Oct 2025 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EL8IzmC5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE76347FFC
	for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732010; cv=none; b=tN7ic5YAj/9OO8bS0HGQPYhHCfRVVJSot85ENj3XfaospudV+yCIehR8exPjyoZCWKRkz+rB9h0tkMwwIw/EF7xmCKvfvm/8F4ijV7OsHAzwdEI8w0LaO8kpXz9+t2ohGG24bAmGO/1xDvFPNRJ8+qDSHKrWQ0BXioXd4i8tXa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732010; c=relaxed/simple;
	bh=30zQD4pjDiSn/+U/aldACY0mrFS2JuKzSnFZG7FjNQk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nd6KiWk0b8yV2ADdyu+ufiktk+VH5F6w6zJLoIhz+yTha192dOeZBGFJ/rtR/SBvnsPvHLG325AefSU3C1U5gaNzQceDN5Wx3OutZRjTAb3pfBwUsGpICpeEZiCXNZl1D3QBL6VAQphxo/ko0UTTGe7zFCYbJ1TYDnLiUj0FOQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EL8IzmC5; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-336b646768eso2680365a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 13:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760732002; x=1761336802; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0mpVwCYbwMET7AecOcE2QimVcHIz1TOOFcfyLkjDeGo=;
        b=EL8IzmC5z4DTQUYvZCy3jKls8uL6JbJj8vXJCerWWlefkvzKo3EiyPvHEWDXtbvLeL
         ps9wFnbKHg7T67l5dHLlFW+c96db/77a4px1hqLuvOTAGCLCMF8wgXXDGuJchJenCGh+
         eoFgD/SbJ1HhQmEd0UNEeikNEsdmbbyf0KPuzEI2sY5TVYzGE/K1BvRBFrpKSEgBoYZj
         F2hWTGsF78bsFJKdW1WMwg10IwDuK4PBZUoDI3LE3f/njKyvBqMo1C++ioBKM4yvlVhp
         miBHevQlyRYoSLjSp9HMrP6kEZ6gNAzVvLtaUY+3Lvq4AkQHA78RNk/jkDyzgVPcdz8X
         F+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732002; x=1761336802;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0mpVwCYbwMET7AecOcE2QimVcHIz1TOOFcfyLkjDeGo=;
        b=MMW2Vmo4szt2oxntEc9sZVtMx3253Wh4shuRH0WcuHvXuiSz/ACcmQ9/fOCJHOHIh2
         xUL5yf3ziqmTCHHX32LpZFrNOouPlk+mGUxfAhlWDWk2JS7Yt2cyrVb2TaJg3F8+ylmu
         tzL6+jDSHkEglTS9eVsm+zh6mOyGPyxtitphB/JJ/NwxtjfK2l2DkfUkpAku/lTOhJqL
         cQfyh19ZP+tLuHUxRkAchk2jngor7zNf3Wp5HTGpTNjKzRfEOQW+8ryQJwYkRWp9vwaN
         HE7A+2HXOHypzLXrxfwJWK8e3nKmztxsIAg4FnSYzrL9fnRbTQlPRHY2BipniWauMlr5
         eR9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUElReX/OSz08aVIyRRNWdeyOKqrJ/JoZ0oe6hoX/H13ZNwiPD+0cga2RGWLbrD0FlgxUg4NkvqpGYcshIgdsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3EXUxkbV2v9dovjExO3Efnlf+fKU0A3h7h+qK6D2BoJaW/7uj
	xcWx6w9B226RDkico6cdjz3QAX1V4iFvMUBYMikSYi3WXH0EGfxatGt/QILp/H3YBcCuGaFb4h4
	IELjf+Xe6hR1VjwvSSLL/r8TeIw==
X-Google-Smtp-Source: AGHT+IHcO4NwxOJfZLNEBbx6WNz/S52BTLMchZETWWpFSftU3iw+fmFyD6t6Of9AgSIAzGHhdhWoKd+61TBtvxNmOQ==
X-Received: from pjbfs17.prod.google.com ([2002:a17:90a:f291:b0:32e:bcc3:ea8e])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d87:b0:32b:baaa:21b0 with SMTP id 98e67ed59e1d1-33bcf853679mr6444234a91.6.1760732001959;
 Fri, 17 Oct 2025 13:13:21 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:12:13 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <a3126618d7cb353faad7b231e70c2b732498f449.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 32/37] KVM: selftests: Check fd/flags provided to
 mmap() when setting up memslot
From: Ackerley Tng <ackerleytng@google.com>
To: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: ackerleytng@google.com, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

Check that a valid fd provided to mmap() must be accompanied by MAP_SHARED.

With an invalid fd (usually used for anonymous mappings), there are no
constraints on mmap() flags.

Add this check to make sure that when a guest_memfd is used as region->fd,
the flag provided to mmap() will include MAP_SHARED.

Signed-off-by: Sean Christopherson <seanjc@google.com>
[Rephrase assertion message.]
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index cb73566fdf153..8603bd5c705ed 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1057,6 +1057,9 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		region->fd = kvm_memfd_alloc(region->mmap_size,
 					     src_type == VM_MEM_SRC_SHARED_HUGETLB);
 
+	TEST_ASSERT(region->fd == -1 || backing_src_is_shared(src_type),
+		    "A valid fd provided to mmap() must be accompanied by MAP_SHARED.");
+
 	mmap_offset = flags & KVM_MEM_GUEST_MEMFD ? gmem_offset : 0;
 	region->mmap_start = __kvm_mmap(region->mmap_size, PROT_READ | PROT_WRITE,
 					vm_mem_backing_src_alias(src_type)->flag,
-- 
2.51.0.858.gf9c4a03a3a-goog


