Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBB2427B28
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2019 12:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfEWK4a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 06:56:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbfEWK4a (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 06:56:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1331410F6F;
        Thu, 23 May 2019 10:56:30 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B3B35D9C3;
        Thu, 23 May 2019 10:56:25 +0000 (UTC)
Date:   Thu, 23 May 2019 12:56:23 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Thomas Huth <thuth@redhat.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] KVM: selftests: Add the sync_regs test for s390x
Message-ID: <20190523105623.3zlnbleniovobwzk@kamzik.brq.redhat.com>
References: <20190516111253.4494-1-thuth@redhat.com>
 <20190516111253.4494-5-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516111253.4494-5-thuth@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 23 May 2019 10:56:30 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 16, 2019 at 01:12:53PM +0200, Thomas Huth wrote:
> The test is an adaption of the same test for x86. Note that there
> are some differences in the way how s390x deals with the kvm_valid_regs
> in struct kvm_run, so some of the tests had to be removed. Also this
> test is not using the ucall() interface on s390x yet (which would need
> some work to be usable on s390x), so it simply drops out of the VM with
> a diag 0x501 breakpoint instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS                                   |   1 +
>  tools/testing/selftests/kvm/Makefile          |   2 +
>  .../selftests/kvm/s390x/sync_regs_test.c      | 151 ++++++++++++++++++
>  3 files changed, 154 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/s390x/sync_regs_test.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 514d1f88ee26..68f76ee9e821 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8645,6 +8645,7 @@ F:	arch/s390/include/asm/gmap.h
>  F:	arch/s390/include/asm/kvm*
>  F:	arch/s390/kvm/
>  F:	arch/s390/mm/gmap.c
> +F:	tools/testing/selftests/kvm/s390x/
>  F:	tools/testing/selftests/kvm/*/s390x/

Do we need these lines added? We have tools/testing/selftests/kvm/ in the
common KVM section already. If we do want to specify them specifically,
then I guess we need x86 and arm MAINTAINERS updates as well.

Thanks,
drew
