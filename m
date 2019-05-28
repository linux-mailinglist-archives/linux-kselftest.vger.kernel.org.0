Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4922C70D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2019 14:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfE1Mxt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 May 2019 08:53:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfE1Mxt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 May 2019 08:53:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 84CE8A3B6C;
        Tue, 28 May 2019 12:53:49 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85B2B1972C;
        Tue, 28 May 2019 12:53:47 +0000 (UTC)
Date:   Tue, 28 May 2019 14:53:44 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Janosch Frank <frankja@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re:  [PATCH 8/9] KVM: s390: Do not report unusabled IDs via
 KVM_CAP_MAX_VCPU_ID
Message-ID: <20190528145344.42fe6bc5.cohuck@redhat.com>
In-Reply-To: <1deb73ac-9589-89cb-9a9b-f9957584733e@de.ibm.com>
References: <20190523164309.13345-1-thuth@redhat.com>
        <20190523164309.13345-9-thuth@redhat.com>
        <1deb73ac-9589-89cb-9a9b-f9957584733e@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 28 May 2019 12:53:49 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 28 May 2019 13:00:30 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Paolo, Radim,
> 
> would you consider this patch (or the full series) as 5.2 material or 5.3 material?

FWIW, I'd consider this patch 5.2 material, as we're currently relaying
wrong values to userspace.

> 
> 
> On 23.05.19 18:43, Thomas Huth wrote:
> > KVM_CAP_MAX_VCPU_ID is currently always reporting KVM_MAX_VCPU_ID on all
> > architectures. However, on s390x, the amount of usable CPUs is determined
> > during runtime - it is depending on the features of the machine the code
> > is running on. Since we are using the vcpu_id as an index into the SCA
> > structures that are defined by the hardware (see e.g. the sca_add_vcpu()
> > function), it is not only the amount of CPUs that is limited by the hard-
> > ware, but also the range of IDs that we can use.
> > Thus KVM_CAP_MAX_VCPU_ID must be determined during runtime on s390x, too.
> > So the handling of KVM_CAP_MAX_VCPU_ID has to be moved from the common
> > code into the architecture specific code, and on s390x we have to return
> > the same value here as for KVM_CAP_MAX_VCPUS.
> > This problem has been discovered with the kvm_create_max_vcpus selftest.
> > With this change applied, the selftest now passes on s390x, too.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  arch/mips/kvm/mips.c       | 3 +++
> >  arch/powerpc/kvm/powerpc.c | 3 +++
> >  arch/s390/kvm/kvm-s390.c   | 1 +
> >  arch/x86/kvm/x86.c         | 3 +++
> >  virt/kvm/arm/arm.c         | 3 +++
> >  virt/kvm/kvm_main.c        | 2 --
> >  6 files changed, 13 insertions(+), 2 deletions(-)
