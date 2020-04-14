Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8A91A7377
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Apr 2020 08:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405853AbgDNGRN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Apr 2020 02:17:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45492 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405855AbgDNGRM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Apr 2020 02:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586845030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DOrTl4YvBq5Mc/4tt5fmz7abkbkAWLtGCwVC/yQsB/U=;
        b=QvZ7pCmq0TCfuHCewRZ1S6GuNsFlu4mdFcjkULnxnhnz+To2zSqZG01T55tdhA/5Y6/Crg
        zBond/FWYHfhXAseF2iUpbedKMUAAyxp6YvkEetGBeJ4cUwD3hz2UaTTabEpnkzpp1wAxf
        wM/U3VYcLyjbUuOo+JwV6kCh/Z9riBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-5IYuHBlQO_yDrdlI2Zhw9g-1; Tue, 14 Apr 2020 02:17:06 -0400
X-MC-Unique: 5IYuHBlQO_yDrdlI2Zhw9g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CAFD800D5C;
        Tue, 14 Apr 2020 06:17:05 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 247D65D9CD;
        Tue, 14 Apr 2020 06:16:57 +0000 (UTC)
Date:   Tue, 14 Apr 2020 08:16:54 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wainer dos Santos Moschetta <wainersm@redhat.com>,
        pbonzini@redhat.com, kvm@vger.kernel.org, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krish.sadhukhan@oracle.com
Subject: Re: [PATCH v5 0/2] selftests: kvm: Introduce the mem_slot_test test
Message-ID: <20200414061654.qhuo3hsslz32qwgc@kamzik.brq.redhat.com>
References: <20200409220905.26573-1-wainersm@redhat.com>
 <20200410204509.GK22482@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410204509.GK22482@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 10, 2020 at 01:45:09PM -0700, Sean Christopherson wrote:
> On Thu, Apr 09, 2020 at 07:09:03PM -0300, Wainer dos Santos Moschetta wrote:
> > This series introduces a new KVM selftest (mem_slot_test) that goal
> > is to verify memory slots can be added up to the maximum allowed. An
> > extra slot is attempted which should occur on error.
> > 
> > The patch 01 is needed so that the VM fd can be accessed from the
> > test code (for the ioctl call attempting to add an extra slot).
> > 
> > I ran the test successfully on x86_64, aarch64, and s390x.  This
> > is why it is enabled to build on those arches.
> 
> Any objection to folding these patches into a series I have to clean up
> set_memory_region_test (which was mentioned in a prior version) and add
> this as a testcase to set_memory_region_test instead of creating a whole
> new test?
> 
> A large chunk of set_memory_region_test will still be x86_64 only, but
> having the test reside in common code will hopefully make it easier to
> extend to other architectures.
>

Yes, that would be my preference as well. Eventually I decided it could be
done later, but I still prefer it being done from the beginning.

Thanks,
drew 

