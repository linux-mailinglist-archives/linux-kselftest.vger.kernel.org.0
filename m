Return-Path: <linux-kselftest+bounces-44213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CC8C16EC8
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 22:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D6314FC127
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 21:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D05351FC1;
	Tue, 28 Oct 2025 21:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P/xXcotN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455EB350D4D
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686460; cv=none; b=U60qVw/k+mbasmHfUjOM9z4TWPCYi9cZr62VmB9q81LTvGe8OWYkCgCXgOFncbEVqZg0qAyZ+t6e99Jjb456MZyVyk2AT84WPKIwTib/K+8NpwedlbCrioFtDmaiu25T9ZlTqsFDHuOjkc1g8qK+/h6dj5oFknkbfQ6ZitxZtkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686460; c=relaxed/simple;
	bh=byR26H853vtY1lU2qQd3dx7y+cPojvAtdUsYskKNuJY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GHUuJ5q3jzeq+Hqu8glaetzIdQn/TWygnsl9T+8LdERrYoZgIAm8WIJuGS0UsW2mP8rK2W0SIA48MCDksF1XSz86JAgSiWk4iejtWPDyEWnwp9QFCW8k9AVt+PhlW4mUdgGSTOudkz4eL45KukhB5E5k9HpuEh0VP29JWsTJWUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P/xXcotN; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-7c52d9638f8so2082584a34.0
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 14:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761686457; x=1762291257; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MnNPBnpM5bYky9vxwBzGQagmW12705iL+thpB/tnb+E=;
        b=P/xXcotNawces0pDKnwZ+086OySgvphs2+KoiE0d9meYLbsOIqEr8hNiUcftkO28RW
         kHwJKqDqbYkryFpKmug/OnF24gvrX4en8m6wf3O9ESoPDYpxEzO32pqokx+f3yevJOFC
         Q4HtloX8W9ZABF3TS4VC8p8uQPsncu2xR4H17LY1urV/KPsX6Du11XSgMZBm/GEHfvdf
         Rd0XgdpHKI+R/5gwv9E8ogkPGIZACGfd1nRBtj8+tfErp1yqZy6Xiqod3oW/kN6bI1Qn
         7/MTMwYdn9pZ8O0nIBBDf9SbzU8iAjuyYCTDgCiseaMn5TtY5bAmEInEFgwFw/v0AhlG
         PrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686457; x=1762291257;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnNPBnpM5bYky9vxwBzGQagmW12705iL+thpB/tnb+E=;
        b=u4FH8Aho/1CocHM0ZTMRoBkFKhKwPPBs1VJn5fYl0zqmEyyrrgVq0WumTw4P5FgIcF
         PAnX1VYUUhE6Ds3K+FK1zhulNTVZWcY+C6vJd7n82ojUZ28b9nxZfAWtaccXMkNP1V0t
         NAHUFj0ROPl/hpJeFgyB6zwYwaMhrJzg3gs2NbjVQ+f6b4GJfq52l7T1G+Qk7kZ32BvA
         IZMTONv06IfEolanKip68+YVPSqO+Ch9zEjoAxR+d6mRpu3FNFIGwlXtIvYAPaT9Zg9s
         Fm5YgBiL1fyfkEnGetVnXXhedUQUJCOzTZKRjuk1BaCRycI5iCaeBjPat6i8TZHLQ9kO
         skLA==
X-Gm-Message-State: AOJu0YxHedXyFzmuDG5MxJM/pyIULlcoboYCl0hN0uPt2j+lOMZ2LMMB
	7CKtMUtofyycFtnvcR1d7kwel0CnzGIzzV9jyD99mHhsjDHXFqugXgWPClkAVilGnvnFtGyoN//
	9zQx9xsPZ/GeMl1uuVqvpZE0jDSVWY+xUN90BsVFiU86eHVNxpZ+tcyMpO95aT7the802mHxiI0
	bpmHQuG558tINdSvmBE+nYGvVyocDjFWoIfrud6cj8wo4=
X-Google-Smtp-Source: AGHT+IGR5mnppgMEZJUYIBgsKY04ukEokgXLIWL+libJL2Zf7k+H6SYVbXC6UYmt0y9gc43yPO9LBdNfLA==
X-Received: from otbay35.prod.google.com ([2002:a05:6830:46a3:b0:7c5:31c4:1a54])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6830:4124:b0:7c5:4005:fff3
 with SMTP id 46e09a7af769-7c6830c4954mr406884a34.29.1761686457320; Tue, 28
 Oct 2025 14:20:57 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:20:28 +0000
In-Reply-To: <20251028212052.200523-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212052.200523-1-sagis@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028212052.200523-3-sagis@google.com>
Subject: [PATCH v12 02/23] KVM: selftests: Allocate pgd in virt_map() as necessary
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If virt_map() is called before any call to ____vm_vaddr_alloc() it
will create the mapping using an invalid pgd.

Add call to virt_pgd_alloc() as part of virt_map() before creating the
mapping, similarly to ____vm_vaddr_alloc()

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 1a93d6361671..0e6a487ca7a4 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1569,6 +1569,7 @@ void virt_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 	TEST_ASSERT(vaddr + size > vaddr, "Vaddr overflow");
 	TEST_ASSERT(paddr + size > paddr, "Paddr overflow");
 
+	virt_pgd_alloc(vm);
 	while (npages--) {
 		virt_pg_map(vm, vaddr, paddr);
 		sparsebit_set(vm->vpages_mapped, vaddr >> vm->page_shift);
-- 
2.51.1.851.g4ebd6896fd-goog


