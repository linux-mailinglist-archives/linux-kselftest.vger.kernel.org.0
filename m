Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC922D2D1E
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Dec 2020 15:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbgLHOZ2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Dec 2020 09:25:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44765 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729644AbgLHOZO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Dec 2020 09:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607437427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yYABeUJ41wkb4dfuaHr9ztBYcxYNx2eYwG9YnsUg4D0=;
        b=apOiCmPV0b9qg6KwXeVP1s/ZinYQFsuWXM4V8GUxJXjingu1vZMD77Ypmf1VVxYBPooi34
        ePHSrs1FW8kOm8PabjJGw97YPq0JWyPeTHJpORmARg23/fUsWfrDHgmBPgxsyKsGeA4EpB
        BRbdDxfPq/pDXf1fhE7HM0Vykna4HYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-ZkxIiaedPvS_iNIQaWCyTQ-1; Tue, 08 Dec 2020 09:23:45 -0500
X-MC-Unique: ZkxIiaedPvS_iNIQaWCyTQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F07DF180A089;
        Tue,  8 Dec 2020 14:23:42 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-8.gru2.redhat.com [10.97.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DEAB620DE;
        Tue,  8 Dec 2020 14:23:42 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 4CA80416D862; Mon,  7 Dec 2020 20:16:56 -0300 (-03)
Date:   Mon, 7 Dec 2020 20:16:56 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] RFC: Precise TSC migration
Message-ID: <20201207231656.GC27492@fuller.cnet>
References: <20201203171118.372391-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203171118.372391-1-mlevitsk@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 03, 2020 at 07:11:15PM +0200, Maxim Levitsky wrote:
> Hi!
> 
> This is the second version of the work to make TSC migration more accurate,
> as was defined by Paulo at:
> https://www.spinics.net/lists/kvm/msg225525.html

Maxim,

Can you please make a description of what is the practical problem that is 
being fixed, preferably with instructions on how to reproduce ?

> I omitted most of the semi-offtopic points I raised related to TSC
> in the previous RFC where we can continue the discussion.
> 
> I do want to raise another thing that I almost forgot.
> 
> On AMD systems, the Linux kernel will mark the guest tsc as
> unstable unless invtsc is set which is set on recent AMD
> hardware.
> 
> Take a look at 'unsynchronized_tsc()' to verify this.
> 
> This is another thing that IMHO should be fixed at least when
> running under KVM.
> 
> Note that I forgot to mention that
> X86_FEATURE_TSC_RELIABLE also short-circuits this code,
> thus giving another reason to enable it under KVM.
> 
> Changes from V1:
> 
> - added KVM_TSC_STATE_TIMESTAMP_VALID instead of testing ns == 0
> - allow diff < 0, because it is still better that capping it to 0
> - updated tsc_msr_test unit test to cover this feature
> - refactoring
> 
> Patches to enable this feature in qemu are in the process of
> being sent to qemu-devel mailing list.
> 
> Best regards,
>     Maxim Levitsky
> 
> Maxim Levitsky (3):
>   KVM: x86: implement KVM_{GET|SET}_TSC_STATE
>   KVM: x86: introduce KVM_X86_QUIRK_TSC_HOST_ACCESS
>   kvm/selftests: update tsc_msrs_test to cover
>     KVM_X86_QUIRK_TSC_HOST_ACCESS
> 
>  Documentation/virt/kvm/api.rst                | 65 +++++++++++++
>  arch/x86/include/uapi/asm/kvm.h               |  1 +
>  arch/x86/kvm/x86.c                            | 92 ++++++++++++++++++-
>  include/uapi/linux/kvm.h                      | 15 +++
>  .../selftests/kvm/x86_64/tsc_msrs_test.c      | 79 ++++++++++++++--
>  5 files changed, 237 insertions(+), 15 deletions(-)
> 
> -- 
> 2.26.2
> 

