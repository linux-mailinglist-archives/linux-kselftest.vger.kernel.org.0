Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B51C33EFFF
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 13:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhCQMHZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Mar 2021 08:07:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28604 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231453AbhCQMHX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Mar 2021 08:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615982842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4EfKj4t4CxcLLmQbY2ACIUaycCSNWq4cMHjJwz2bFoo=;
        b=fLokAn8ebg5A6hRRUpv4RtdFCy0Jk76wEKD8oWTd3Rl21Nq4/PsjofFRspbPjK+xyt9HE8
        Alvv51a6n7jLW4oRb8Ex3nPR2e1MI9C8cC3Ogtza+oBFu49oHcrGUM6jphU9WXKwqjGSsG
        Ff0rDBCIU9TezwZpgMfq4zspJb+hkcY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-_M2o4w8GNZyvILNwnqQA5w-1; Wed, 17 Mar 2021 08:07:20 -0400
X-MC-Unique: _M2o4w8GNZyvILNwnqQA5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4E3E1009461;
        Wed, 17 Mar 2021 12:07:19 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.196.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C947E1017CF5;
        Wed, 17 Mar 2021 12:07:17 +0000 (UTC)
Date:   Wed, 17 Mar 2021 13:07:14 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] selftests/kvm: add test for
 KVM_GET_MSR_FEATURE_INDEX_LIST
Message-ID: <20210317120714.6xuqujpvdn2tzddj@kamzik.brq.redhat.com>
References: <20210317074552.8550-1-eesposit@redhat.com>
 <ac3ba1c0-450e-4e24-c2a2-39d037358758@redhat.com>
 <61d11f32-a2da-b593-1c62-bbadc6408215@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61d11f32-a2da-b593-1c62-bbadc6408215@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 17, 2021 at 12:25:52PM +0100, Emanuele Giuseppe Esposito wrote:
> 
> 
> On 17/03/2021 11:49, Paolo Bonzini wrote:
> > On 17/03/21 08:45, Emanuele Giuseppe Esposito wrote:
> > > +    struct kvm_msr_list features_list;
> > >       buffer.header.nmsrs = 1;
> > >       buffer.entry.index = msr_index;
> > > +    features_list.nmsrs = 1;
> > > +
> > >       kvm_fd = open(KVM_DEV_PATH, O_RDONLY);
> > >       if (kvm_fd < 0)
> > >           exit(KSFT_SKIP);
> > > +    r = ioctl(kvm_fd, KVM_GET_MSR_FEATURE_INDEX_LIST, &features_list);
> > > +    TEST_ASSERT(r < 0 && r != -E2BIG,
> > > "KVM_GET_MSR_FEATURE_INDEX_LIST IOCTL failed,\n"
> > > +        "  rc: %i errno: %i", r, errno);
> > 
> > Careful: because this has nsmrs == 1, you are overwriting an u32 of the
> > stack after struct kvm_msr_list.  You need to use your own struct
> > similar to what is done with "buffer.header" and "buffer.entry".
> > 
> > >       r = ioctl(kvm_fd, KVM_GET_MSRS, &buffer.header);
> > >       TEST_ASSERT(r == 1, "KVM_GET_MSRS IOCTL failed,\n"
> > >           "  rc: %i errno: %i", r, errno);
> > > 
> > 
> > More in general, this is not a test, but rather a library function used
> > to read a single MSR.
> > 
> > If you would like to add a test for KVM_GET_MSR_FEATURE_INDEX_LIST that
> > would be very welcome.  That would be a new executable.  Looking at the
> > logic for the ioctl, the main purpose of the test should be:
> > 
> > - check that if features_list.nmsrs is too small it will set the nmsrs
> > field and return -E2BIG.
> > 
> > - check that all MSRs returned by KVM_GET_MSR_FEATURE_INDEX_LIST can be
> > accessed with KVM_GET_MSRS
> > 
> > So something like this:
> > 
> >    set nmsrs to 0 and try the ioctl
> >    check that it returns -E2BIG and has changed nmsrs
> >    if nmsrs != 1 {
> >      set nmsrs to 1 and try the ioctl again
> >      check that it returns -E2BIG
> >    }
> >    malloc a buffer with room for struct kvm_msr_list and nmsrs indices
> >    set nmsrs in the malloc-ed buffer and try the ioctl again
> >    for each index
> >      invoke kvm_get_feature_msr to read it
> > 
> > (The test should also be skipped if KVM does not expose the
> > KVM_CAP_GET_MSR_FEATURES capability).
> 
> Thank you for the feedback, the title is indeed a little bit misleading. My
> idea in this patch was to just add an additional check to all usages of
> KVM_GET_MSRS, since KVM_GET_MSR_FEATURE_INDEX_LIST is used only to probe
> host capabilities and processor features.
> But you are right, a separate test would be better.
>

Hi Emanuele,

You might be able to get some inspiration from the aarch64/get-reg-list.c
test. The list of MSRs varies with KVM version and host processor, but
there may be a set of MSRs that does not vary with host processor and
should not be removed in later KVM versions. If that's the case, then
the !missing_regs assert concept of aarch64/get-reg-list.c may also
apply to this new test. Based on Paolo's comment, I presume at least the
!failed_get should apply. Finally, the test should do the E2BIG checks,
as Paolo states, but you may also want to create a lib function for
KVM_GET_MSR_FEATURE_INDEX_LIST, similar to vcpu_get_reg_list(), if you
think it may be of use to other tests.

Thanks,
drew



