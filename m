Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A426B38E68D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 May 2021 14:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbhEXM31 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 May 2021 08:29:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42732 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232466AbhEXM30 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 May 2021 08:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621859278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ikStd8qunKQm65lWUW587QvKLPZMZNFV5KeKWHkbI+s=;
        b=dUNT6gdc3O9dXlvfH4WPw78ghCxLgtN+k30q2l5QDixRhAX5/HPHzHCqHQtA0dMkjQcVR7
        3amLodyugzlaAz7rfLMvsudLsLVD51jofovF40Ffl3g8xecaNpSqno0QgEiZOEKHcvQlNZ
        lWk9Z18K2Q+AAaK4Vw8Vc/VX65VQ690=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-8dRSWlStPyGphqQFTY2wuA-1; Mon, 24 May 2021 08:27:57 -0400
X-MC-Unique: 8dRSWlStPyGphqQFTY2wuA-1
Received: by mail-ej1-f69.google.com with SMTP id j16-20020a1709062a10b02903ba544485d0so7505592eje.3
        for <linux-kselftest@vger.kernel.org>; Mon, 24 May 2021 05:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ikStd8qunKQm65lWUW587QvKLPZMZNFV5KeKWHkbI+s=;
        b=VcgJ3hcpeChTtjFLUcXKnPpNnIYzhqwlyMLES9fB6/lDOdLGV8bDutyRDzNrvJ6nXz
         2qGV07HLaLsaZ6DYptlYcL0MVVVE/yeyCRw8S91BSBdpu1aCjkc43y97hYL9hH6qxgne
         mSQ1FnGs/PKI4KKM8VYqWPErsRlQh5Dh6axllg9PK0aVRP7h6sjrLLXYwbXoExUqEdjV
         AwLaMTJeusVwqFFlrPjXewd22EPM6id/CJeKsAgTP3w26iTnUnuBen0+ls23FE7beQNI
         zg1Kiyig4aPuuzS3Zkgl2FSHt/7f+IfEAbixNFQUYn3PtTo/wbD7ucEoknPrdindoG8a
         45CQ==
X-Gm-Message-State: AOAM531pChTDesZQ0/5Ei5MLeqxsFgPddEL9AbNJafmTrGPW1eBMKM0V
        OA6K9M3oq70upTASBwuYWwVKfTDFzB5LsSaFo/4HH8kNpMu6igB759BcFUJbk0hjl/EESOv96Ie
        su+iXeH4a5XRr0ohmoKFpsWs7brjc
X-Received: by 2002:a17:906:7f8a:: with SMTP id f10mr22329234ejr.12.1621859275924;
        Mon, 24 May 2021 05:27:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLbUgLHbLVYN+b0wOSTuWgYGRBcmqoKumnwIIXZlIViNzT8Yi97liN6/CRamtdksEb13OjLA==
X-Received: by 2002:a17:906:7f8a:: with SMTP id f10mr22329215ejr.12.1621859275726;
        Mon, 24 May 2021 05:27:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id a5sm9215530eds.73.2021.05.24.05.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 05:27:55 -0700 (PDT)
Subject: Re: [PATCH] selftests: kvm: Fix a potential elf loading issue
To:     Zhenzhong Duan <zhenzhong.duan@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        shuah@kernel.org
References: <20210512043107.30076-1-zhenzhong.duan@intel.com>
 <20210512043107.30076-2-zhenzhong.duan@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2b16869a-7518-529b-9cbe-fb2e5f61a6e9@redhat.com>
Date:   Mon, 24 May 2021 14:27:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512043107.30076-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/05/21 06:31, Zhenzhong Duan wrote:
> vm_vaddr_alloc() setup GVA to GPA mapping page by page, then GPA may not be
> continuous if same memslot is used for data and page table allocation.
> 
> kvm_vm_elf_load() expects a continuous memory of GPA or else it need to
> read file data page by page. Fix it by adding a check in vm_vaddr_alloc()
> to ensure memory is allocated in a whole if same memslot is used for data
> and page table.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
Why not do

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 7426163d448a..f362a066f37a 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1170,6 +1170,9 @@ vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
  	uint64_t pages = (sz >> vm->page_shift) + ((sz % vm->page_size) != 0);
  
  	virt_pgd_alloc(vm, pgd_memslot);
+	vm_paddr_t paddr = vm_phy_pages_alloc(vm, pages,
+					      KVM_UTIL_MIN_PFN * vm->page_size,
+					      data_memslot);
  
  	/*
  	 * Find an unused range of virtual page addresses of at least
@@ -1179,11 +1182,7 @@ vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
  
  	/* Map the virtual pages. */
  	for (vm_vaddr_t vaddr = vaddr_start; pages > 0;
-		pages--, vaddr += vm->page_size) {
-		vm_paddr_t paddr;
-
-		paddr = vm_phy_page_alloc(vm,
-				KVM_UTIL_MIN_PFN * vm->page_size, data_memslot);
+		pages--, vaddr += vm->page_size, paddr += vm->page_size) {
  
  		virt_pg_map(vm, vaddr, paddr, pgd_memslot);
  

instead?

Paolo

