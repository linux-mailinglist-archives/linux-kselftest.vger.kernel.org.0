Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23015595F73
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Aug 2022 17:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbiHPPjV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Aug 2022 11:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbiHPPi0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Aug 2022 11:38:26 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1611F32EF6
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Aug 2022 08:38:13 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id v4so5211755pgi.10
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Aug 2022 08:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=6LpLI14G6coqJFruGZ3VYJdlLWVZL7InToOUXv07gLQ=;
        b=V3kYfawNPteaJkUnHbTXnRrS5N35HXy6iGSEoRvrRPR7lf/QPGG3xDy01PDbV3CNJU
         rYN3Q+NG+MI7miMCPrKRr9QMWbJNUvipQt7nZBzy91mXjgUP1bhKDg6Pv8PLccjK328e
         QHgPWN2TVwVDgsm0DNCSKHVDZJyXPC0S2jmlNvJNeN/YEUOYVYC0ArRAq7x4AOWHAAvX
         U8kkfqX2SlO0Wx9GoH6WDXhHME6I42+EOUK5vgZdNMDY/qSlMxKyT1KEekpwoGvFgNHf
         kgo444qsZ2z0tgTbJp5duXgBZVSHUHP1vb6nzpsrWEMHaATSgyPonGA239evs+ZXtTji
         kdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=6LpLI14G6coqJFruGZ3VYJdlLWVZL7InToOUXv07gLQ=;
        b=OZchCM6Lnf+0+TI5coJA6AG+keCMesJRZXEVziN+luZ4YScGeyOa4z7Go72bO6JVR6
         8/a08kye3hkB9dWX3mZ6Cos040cXkO3Bn5bh/tSg+MCNilkEGpnOoeSXNJ0q5IW9xsB3
         ce9dxquj2XCyujR5Jt5iiUfe3a3nadDa9NB/iP4RbuIJ8nGDnc9u1dStPWFchD38bH+C
         u9Vl9hkoYWqcFl3N6WdKOC/JAr4Vjgne7YK2UVlXLJo2enPUk+BgguL7SRkWInjqF+/5
         fDT05zId2DNMDXHo029ZYV4YE3sqxRoJMG5p9e8HUcA7BDH2CpYvmaiRRPotRj0ZNAhQ
         2NhA==
X-Gm-Message-State: ACgBeo34zXeB+9SnIqrqdu749esTPIfOxlw7zYRDlxWi6iWoDNaeXLDI
        6kswxovxOrCZd0FJKQBMYM8UYA==
X-Google-Smtp-Source: AA6agR4vWikDhLEVIg5nAiL4NEUcgXEMkiaD3WHaihv4ACQ9BBnFu3QXd85Rfr1lttpC/Y68iivbPA==
X-Received: by 2002:a63:81c7:0:b0:429:a566:e536 with SMTP id t190-20020a6381c7000000b00429a566e536mr2846519pgd.22.1660664292890;
        Tue, 16 Aug 2022 08:38:12 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id l9-20020a170903120900b0016cf3f124e5sm9281691plh.131.2022.08.16.08.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 08:38:12 -0700 (PDT)
Date:   Tue, 16 Aug 2022 15:38:08 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Nikunj A. Dadhania" <nikunj@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, bharata@amd.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <Yvu54I7Y+/ybVyec@google.com>
References: <9e86daea-5619-a216-fe02-0562cf14c501@amd.com>
 <9dc91ce8-4cb6-37e6-4c25-27a72dc11dd0@amd.com>
 <422b9f97-fdf5-54bf-6c56-3c45eff5e174@amd.com>
 <1407c70c-0c0b-6955-10bb-d44c5928f2d9@amd.com>
 <1136925c-2e37-6af4-acac-be8bed9f6ed5@amd.com>
 <1b02db9d-f2f1-94dd-6f37-59481525abff@amd.com>
 <20220815130411.GA1073443@chaop.bj.intel.com>
 <f0094f31-9669-47b5-eb52-6754a13ce757@amd.com>
 <20220816122457.2fjyd4uz5hp5cani@box.shutemov.name>
 <f95f35af-4824-2a2a-7cd0-71d1fda6867a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f95f35af-4824-2a2a-7cd0-71d1fda6867a@amd.com>
X-Spam-Status: No, score=-14.4 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 16, 2022, Gupta, Pankaj wrote:
> 
> > > > Actually the current version allows you to delay the allocation to a
> > > > later time (e.g. page fault time) if you don't call fallocate() on the
> > > > private fd. fallocate() is necessary in previous versions because we
> > > > treat the existense in the fd as 'private' but in this version we track
> > > > private/shared info in KVM so we don't rely on that fact from memory
> > > > backstores.
> > > 
> > > Does this also mean reservation of guest physical memory with secure
> > > processor (both for SEV-SNP & TDX) will also happen at page fault time?
> > > 
> > > Do we plan to keep it this way?
> > 
> > If you are talking about accepting memory by the guest, it is initiated by
> > the guest and has nothing to do with page fault time vs fallocate()
> > allocation of host memory. I mean acceptance happens after host memory
> > allocation but they are not in lockstep, acceptance can happen much later.
> 
> No, I meant reserving guest physical memory range from hypervisor e.g with
> RMPUpdate for SEV-SNP or equivalent at TDX side (PAMTs?).

As proposed, RMP/PAMT updates will occur in the fault path, i.e. there is no way
for userspace to pre-map guest memory.

I think the best approach is to turn KVM_TDX_INIT_MEM_REGION into a generic
vCPU-scoped ioctl() that allows userspace to pre-map guest memory.  Supporting
initializing guest private memory with a source page can be implemented via a
flag.  That also gives KVM line of sight to in-place "conversion", e.g. another
flag could be added to say that the dest is also the source.

The TDX and SNP restrictions would then become addition restrictions on when
initializing with a source is allowed (and VMs that don't have guest private
memory wouldn't allow the flag at all).
