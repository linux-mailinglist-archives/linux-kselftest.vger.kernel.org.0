Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9663157D5C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jul 2022 23:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbiGUVQV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jul 2022 17:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiGUVQR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jul 2022 17:16:17 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2625E815
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 14:16:15 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 23so2750967pgc.8
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 14:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=11OqmbhSRizQ74Ch/j9J4lE0a0EnvcFlYhbfmnjs8Cg=;
        b=RenZ/SKdXZfOHNevGxkMopwKMPWrfJxiCyc9BeId33rQlF1/1vzAERKsROGsgu73PO
         3Vh+kBwRBR34zv6Cs7ZDNkRpWgwILWeqJwmR13cSjtmU0unAVdR41Nf/NH0jfEogkr2r
         JHF9df+/fhRXMvvJnH3igBuCM+wK+xZhIdC/GSM24+Vcw7Gc90w73jNaPXTXhKdfuYLT
         Dku2YQ2CN5mLe0SZz1eF0QJrwRspDs0R8NQZXQX7+lxV0WzhKtPvY+5ITZxdh5gN/3r+
         nMFKRwOUV1v2Cq34kX1X0GD8LegMqzy3ApouqelaYdqEVdaSzVtSegGXRc/6GHjh0zKx
         /wJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=11OqmbhSRizQ74Ch/j9J4lE0a0EnvcFlYhbfmnjs8Cg=;
        b=b1GTul4Bz9oD5m2W4qyVxKzk5CglPhORIxCpyBKD0A6trbaFIsM28hb1g2RxdzuIG1
         uPfieouVhX4Z0JlFK0Dz9Cx1PVsRJBGgqBPGtXA2kk3OWtTBIMJoA197DKwzjAnObYde
         4GaIjfXklz8kt2DTDtGb9/Fp4gxmXFfxYeOPvMcpdApgRM2KdoaaIwEzx4Vys9TeUjQd
         8zMylmaNDrE22iX/X3cxqBfbBUOGyD+Rid1J1RYIQVjeUaRFg1YjXEZLu1Keini1addE
         WmjPNNLUEw7nWl6uzrHPZ4du/ZzBwgAqBhc7SgkxbANjDCLWWtdQy81tDD6y19n7BuGg
         Ntjw==
X-Gm-Message-State: AJIora8n0HgsbJEOzRks3XcHwjcoi0yqDS6I5ZwSEl+D87nLGjCYNKIk
        4NfGrBbAkt6Q65mUvTuWqKZHfA==
X-Google-Smtp-Source: AGRyM1tYVnSFtctc/PTPJVmFsiWSfHQt3N50JGg4333C9oMWtUgpVYWuQQYd9+YZX+C2GpeXrgjMVA==
X-Received: by 2002:a65:6151:0:b0:412:e419:d651 with SMTP id o17-20020a656151000000b00412e419d651mr289868pgv.378.1658438174487;
        Thu, 21 Jul 2022 14:16:14 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id h6-20020a056a00000600b00528c6c7bf37sm2213407pfk.129.2022.07.21.14.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 14:16:13 -0700 (PDT)
Date:   Thu, 21 Jul 2022 21:16:10 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86 <x86@kernel.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        dave.hansen@linux.intel.com, "H . Peter Anvin" <hpa@zytor.com>,
        shauh@kernel.org, yang.zhong@intel.com, drjones@redhat.com,
        Ricardo Koller <ricarkol@google.com>,
        Aaron Lewis <aaronlewis@google.com>, wei.w.wang@intel.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Quentin Perret <qperret@google.com>,
        Steven Price <steven.price@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marc Orr <marcorr@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Peter Gonda <pgonda@google.com>,
        "Nikunj A. Dadhania" <nikunj@amd.com>,
        Austin Diviness <diviness@google.com>
Subject: Re: [RFC V2 PATCH 2/8] selftests: kvm: Add a basic selftest to test
 private memory
Message-ID: <YtnCGktd8S7gtAQJ@google.com>
References: <20220511000811.384766-1-vannapurve@google.com>
 <20220511000811.384766-3-vannapurve@google.com>
 <YtiJx11AZHslcGnN@google.com>
 <CAGtprH9BQkcJcpp=uEJJLwM-Z=cW9rsJ7iVKbjv_gisVj8EWGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGtprH9BQkcJcpp=uEJJLwM-Z=cW9rsJ7iVKbjv_gisVj8EWGQ@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 21, 2022, Vishal Annapurve wrote:
> On Wed, Jul 20, 2022 at 4:03 PM Sean Christopherson <seanjc@google.com> wrote:
> > ...
> > > + * which doesn't handle global offset table updates. Calling standard libc
> > > + * functions would normally result in referring to the global offset table.
> > > + * Adding O1 here seems to prohibit compiler from replacing the memory
> > > + * operations with standard libc functions such as memset.
> > > + */
> >
> > Eww.  We should either fix kvm_vm_elf_load() or override the problematic libc
> > variants.  Playing games with per-function attributes is not maintainable.
> >
> 
> I will try to spend more time on how kvm_vm_elf_load can be modified
> to handle GOT fixups in different scenarios including
> statically/dynamically linked sefltest binaries as I currently recall
> limited information here.
> 
> But modifying kvm_vm_elf_load to fixup GOT entries will be
> insufficient as guest VM code (possibly whole selftest binary) will
> need to be compiled with flags that allow memset/memcpy
> implementations to work with specific guest VM configurations e.g. AVX
> extension. Same concern is outlined in
> https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/kvm/lib/x86_64/svm.c#L64.
> 
> Would it be ok to maintain selftest binary compilation flags based on
> guest VM configurations?

No, we should instead define/implement versions of memset/memcpy that are
guaranteed to be guest-friendly, either explicitly by selftests are implicitly
by compiler builtins, e.g. see arch/x86/boot/string.h.
