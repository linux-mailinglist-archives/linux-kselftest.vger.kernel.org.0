Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB4C6549CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Dec 2022 01:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbiLWAhX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Dec 2022 19:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiLWAhW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Dec 2022 19:37:22 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD27DF4E
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 16:37:20 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so3559719pjd.0
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 16:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5qpVu3sN2GuUThZ9RB+4eYZTG5/t0SB6qmR3AbS+l70=;
        b=B8R3XSgXnZA0zY5ZIdpmzNALRNnKsAfqFMLI/F+HF96zJYmqg1RNfhTugB8bwKI8A2
         JS/Y6GRPNC3bxfTQCrdpS/9K/kg2Lr6+RHAiBOrwY5KMWHe7ixr5p9ST9I6V2CdjBoQW
         utBDn9+m+81ByW1uwDLF2LCDyCILvdtt27LVTPhR5xnYw17Qhp8OzxxUN+OC0WbfgeyF
         OJHSL9IpNLDgSNZ8DTQRpKT2MgorAXNG7vnzvJERj00cpKqFnRlol438XrI30+88e00T
         aTN9PmkIoWMfS2sV12MkOTVjfYk520RDEMd6Mi5dYYe4rhkOYnXeilicT614LDtZ6Pug
         UAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qpVu3sN2GuUThZ9RB+4eYZTG5/t0SB6qmR3AbS+l70=;
        b=bAJgYJWCAtdbBeCpbNfTFZnqR6Tw9gfPiWzAucowG8HlhhI8giEjdBWBqV+8UeSSYD
         ae/7XUpSieUN61gJHGMFAll1xhiysLFpAYkerC8vEU/aDnD0sLdfFzfMzmnzICUNLliB
         1JKeNmuQCIBo3MytzgFwDHhVNjjThNcvxNFe/7PwvZ4ndqdmyl3Jq3MAboyVPq1SuvX9
         j2tekDfLCiNAjzmdeL9fXLglF9b5V2ZSXPHNGJHYbKKZy5pH4r4bzmMg3zjfjh8moyCQ
         hZk8ikdwcrIB/Aozo3M0Cx7ONhk++Pd9dA+/JrlqOly3KNzIrbhei09ykgpk1IbIaxUX
         LLOw==
X-Gm-Message-State: AFqh2kpj+ql4eORZS67BnCZQ3DPGEktSZRD1AV/FecHj+Gzk8zgBLIBo
        uSKzrHJxQ9bR2M9mckMYxzD6Jg==
X-Google-Smtp-Source: AMrXdXsjr7g6zJgmvJf2nNP86FhM3dZ2aK3tAps43yzHeFgEfsriOphjFvjgXLdFPCH3uTD/vS0vNQ==
X-Received: by 2002:a17:90a:408d:b0:223:e2df:8030 with SMTP id l13-20020a17090a408d00b00223e2df8030mr1083496pjg.2.1671755840213;
        Thu, 22 Dec 2022 16:37:20 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id l7-20020a17090b078700b00218fb3bec27sm1103723pjz.56.2022.12.22.16.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 16:37:19 -0800 (PST)
Date:   Fri, 23 Dec 2022 00:37:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, oupton@google.com,
        peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com,
        pgonda@google.com, andrew.jones@linux.dev
Subject: Re: [V3 PATCH 2/2] KVM: selftests: x86: Add native hypercall support
Message-ID: <Y6T4PJfF3nGU25Ee@google.com>
References: <20221222230458.3828342-1-vannapurve@google.com>
 <20221222230458.3828342-3-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222230458.3828342-3-vannapurve@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 22, 2022, Vishal Annapurve wrote:
> Add an API to execute hypercall as per the cpu type by checking the
> underlying CPU. KVM emulates vmcall/vmmcall instruction by modifying
> guest memory contents with hypercall instruction as per the cpu type.
> 
> Confidential VMs need to execute hypercall instruction without it being
> emulated by KVM as KVM can not modify guest memory contents.
> 
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>  .../selftests/kvm/include/x86_64/processor.h   |  3 +++
>  .../selftests/kvm/lib/x86_64/processor.c       | 18 ++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> index 4d5dd9a467e1..3617f83bb2e5 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -1039,6 +1039,9 @@ uint64_t *vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr);
>  uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
>  		       uint64_t a3);
>  
> +uint64_t kvm_native_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
> +		       uint64_t a3);
> +
>  void __vm_xsave_require_permission(int bit, const char *name);
>  
>  #define vm_xsave_require_permission(perm)	\
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index 1e93bb3cb058..429e55f2609f 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -1202,6 +1202,24 @@ uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
>  	return r;
>  }
>  
> +uint64_t kvm_native_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,

Just do this in kvm_hypercall().  David didn't say "don't do that", he said "don't
do that in a single patch".  Except for fix_hypercall_test, selftests should always
use the native hypercall instruction and not rely on KVM's patching, e.g. patching
will go sideways if someone gets clever and makes guest code not-writable.

> +		       uint64_t a3)

Align parameters.

> +{
> +	uint64_t r;
> +
> +	if (is_amd_cpu()) {

Curly brace is unnecessary.  Though I think I'd prefer to not duplicate the asm
blob (too many darn inputs).  It's a little ugly, but I prefer it over duplicating
the entire blob.  The approach could also likely be macrofied for other hypercall
usage (future problem).

	asm volatile("test %[use_vmmcall], %[use_vmmcall]\n\t"
		     "jnz 1f\n\t"
		     "vmcall\n\t"
		     "jmp 2f\n\t"
		     "1: vmmcall\n\t"
		     "2:"
		     : "=a"(r)
		     : "a"(nr), "b"(a0), "c"(a1), "d"(a2), "S"(a3),
		       [use_vmmcall] "r" (is_amd_cpu()));
	return r;
