Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEA36AD4A5
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 03:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjCGC0D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 21:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCGC0A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 21:26:00 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2DE30298;
        Mon,  6 Mar 2023 18:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678155959; x=1709691959;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=At4e7f0M94Tcj7c8GXNKqZO3dXNfEpotNAwodaTcHWU=;
  b=Md7dL1JS/1WocgOxIiovrPyjIQlcHaRroS3uI6/6J8aG32UltJJKmGI4
   NG26ums8e4IeFUb0mMQzRLh9GXpcAxl2zeWBlxgqq8IxG3YMw50R+Glvi
   KJr4l95ZIUDqMpFAvm0KFtEMFi6Ez/js0MGPLP7hBypGW6g0rPs/6zx+P
   7zQ06S3dRb05JHSnU4BHjeS0VLt28xXbssdHAA4IXA7X7JBIpRdtnk87K
   7WJhB7C6ssgNIBSfA/IUjYhBWM5MmEJ6BfsnB7+rZpvlzKeX2hFV0rLPa
   CS7SwbKxXHnz3UhQ5rvSD4ATXWTR7Lykeyj896yid70EG7yZZ4QMLWkBD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="324049736"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="324049736"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 18:25:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="1005680292"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="1005680292"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.105])
  by fmsmga005.fm.intel.com with ESMTP; 06 Mar 2023 18:25:48 -0800
Date:   Tue, 7 Mar 2023 10:18:09 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     vannapurve@google.com, seanjc@google.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        shuah@kernel.org, yang.zhong@intel.com, ricarkol@google.com,
        aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, nikunj@amd.com, diviness@google.com,
        maz@kernel.org, dmatlack@google.com, axelrasmussen@google.com,
        maciej.szmigiero@oracle.com, mizhang@google.com, bgardon@google.com
Subject: Re: [V2 PATCH 0/6] KVM: selftests: selftests for fd-based private
 memory
Message-ID: <20230307021809.GA2143916@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20230222025019.GA1628054@chaop.bj.intel.com>
 <diqzlek9spuj.fsf@ackerleytng-cloudtop.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <diqzlek9spuj.fsf@ackerleytng-cloudtop.c.googlers.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 06, 2023 at 06:21:24PM +0000, Ackerley Tng wrote:
> Chao Peng <chao.p.peng@linux.intel.com> writes:
> 
> > On Fri, Feb 10, 2023 at 11:59:23AM -0800, Vishal Annapurve wrote:
> > > On Tue, Jan 17, 2023 at 7:11 PM Vishal Annapurve
> > > <vannapurve@google.com> wrote:
> > > >
> > > > ...
> 
> > > > > Last question, do you have a list of testcases that you consider
> > > "required" for
> > > > > UPM?  My off-the-cuff list of selftests I want to have before
> > > merging UPM is pretty
> > > > > short at this point:
> > > > >
> > > > >   - Negative testing of the memslot changes, e.g. bad alignment,
> > > bad fd,
> > > > >     illegal memslot updates, etc.
> > > > >   - Negative testing of restrictedmem, e.g. various combinations
> > > of overlapping
> > > > >     bindings of a single restrictedmem instance.
> > > > >   - Access vs. conversion stress, e.g. accessing a region in the
> > > guest while it's
> > > > >     concurrently converted by the host, maybe with fancy guest
> > > code to try and
> > > > >     detect TLB or ordering bugs?
> > > >
> > > > List of testcases that I was tracking (covered by the current
> > > > selftests) as required:
> > > > 1) Ensure private memory contents are not accessible to host userspace
> > > > using the HVA
> > > > 2) Ensure shared memory contents are visible/accessible from both host
> > > > userspace and the guest
> > > > 3) Ensure 1 and 2 holds across explicit memory conversions
> > > > 4) Exercise memory conversions with mixed shared/private memory pages
> > > > in a huge page to catch issues like [2]
> > > > 5) Ensure that explicit memory conversions don't affect nearby GPA
> > > ranges
> > > >
> > > > Test Cases that will be covered by TDX/SNP selftests (in addition to
> > > > above scenarios):
> > > > 6) Ensure 1 and 2 holds across implicit memory conversions
> > > > 7) Ensure that implicit memory conversions don't affect nearby GPA
> > > ranges
> > > >
> > > > Additional testcases possible:
> > > > 8) Running conversion tests for non-overlapping GPA ranges of
> > > > same/different memslots from multiple vcpus
> > > >
> > > > [1] - https://github.com/sean-jc/linux/commit/7e536bf3c45c623425bc84e8a96634efc3a619ed
> > > > [2] - https://lore.kernel.org/linux-mm/CAGtprH82H_fjtRbL0KUxOkgOk4pgbaEbAydDYfZ0qxz41JCnAQ@mail.gmail.com/
> 
> > > List of additional testcases that could help increase basic coverage
> > > (including what sean mentioned earlier):
> > > 1) restrictedmem functionality testing
> > >      - read/write/mmap should not work
> > >      - fstat/fallocate should work as expected
> > > 2) restrictedmem registration/modification testing with:
> > >      - bad alignment, bad fd, modifying properties of existing memslot
> > >      - Installing multiple memslots with ranges within the same
> > > restricted mem files
> > >      - deleting memslots with restricted memfd while guests are
> > > being executed
> 
> > In case you havn't started, I will work on 1) and 2) for the following
> > days. As a start, I will first add restrictedmem tests (without KVM) then
> > move to new memslots related tests.
> 
> > Chao
> 
> > > 3) Runtime restricted mem testing:
> > >      - Access vs conversion testing from multiple vcpus
> > >      - conversion and access to non-overlapping ranges from multiple vcpus
> 
> > > Regards,
> > > Vishal
> 
> Chao, I'll work on
> 
> + Running conversion tests for non-overlapping GPA ranges of
>   same/different memslots from multiple vcpus
> + Deleting memslots with restricted memfd while guests are being
>   executed
> + Installing multiple memslots with ranges within the same restricted
>   mem files
> 
> this week.

Thanks Ackerley. Looks good to me.

BTW, for whom may have interest, below are the testcases I added:
https://github.com/chao-p/linux/commit/24dd1257d5c93acb8c8cc6c76c51cf6869970f8a
https://github.com/chao-p/linux/commit/39a872ef09d539ce0c953451152eb05276b87018
https://github.com/chao-p/linux/commit/ddd2c92b268a2fdc6158f82a6169ad1a57f2a01d

Chao
