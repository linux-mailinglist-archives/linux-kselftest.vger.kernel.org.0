Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC5325A30F
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Sep 2020 04:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgIBCdH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Sep 2020 22:33:07 -0400
Received: from ozlabs.org ([203.11.71.1]:34405 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbgIBCdF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Sep 2020 22:33:05 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 4Bh7Jt5XNMz9sV7; Wed,  2 Sep 2020 12:33:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1599013982; bh=3HN/3EBvdb78tsfY8PadQdQ5z7NAekpcsOqrCfMPQqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lLNGBfO0pcebXNzR5mgwARaiB1s+uIQiGmmFYc+0Lnr9idyC1Cz3ht9OXTavvioxD
         l/WmNcValHRjmPwU+6yrqWmZy0PRWaxb/bnGUXCFGxitEfYpGlPwSTvMDcJNg0eoHr
         GQkvS4T3A6tDoH+kgz4/yND883xW/0cN/kjg9WHBkEw22OZUKNATt7P53rQJwekFKi
         wYCjUZO+TuBTjl5wR09qJ6l+7qqa0HpYuy4O9NlCeNndrLJgSd30u8JHb3f/qi4m3Q
         uOxtuuIwqCzYO03yU0nPpyZH8WNoLVNwltJJBb9y13T8GZ7aP7AxgfTSS56mv3nY6a
         DEcR1PurA6cpQ==
Date:   Wed, 2 Sep 2020 12:32:59 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     mpe@ellerman.id.au, mikey@neuling.org, npiggin@gmail.com,
        pbonzini@redhat.com, christophe.leroy@c-s.fr, jniethe5@gmail.com,
        pedromfc@br.ibm.com, rogealve@br.ibm.com, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/7] powerpc/watchpoint: 2nd DAWR kvm enablement +
 selftests
Message-ID: <20200902023259.GC272502@thinks.paulus.ozlabs.org>
References: <20200723102058.312282-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723102058.312282-1-ravi.bangoria@linux.ibm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 23, 2020 at 03:50:51PM +0530, Ravi Bangoria wrote:
> Patch #1, #2 and #3 enables p10 2nd DAWR feature for Book3S kvm guest. DAWR
> is a hypervisor resource and thus H_SET_MODE hcall is used to set/unset it.
> A new case H_SET_MODE_RESOURCE_SET_DAWR1 is introduced in H_SET_MODE hcall
> for setting/unsetting 2nd DAWR. Also, new capability KVM_CAP_PPC_DAWR1 has
> been added to query 2nd DAWR support via kvm ioctl.
> 
> This feature also needs to be enabled in Qemu to really use it. I'll reply
> link to qemu patches once I post them in qemu-devel mailing list.
> 
> Patch #4, #5, #6 and #7 adds selftests to test 2nd DAWR.

If/when you resubmit these patches, please split the KVM patches into
a separate series, since the KVM patches would go via my tree whereas
I expect the selftests/powerpc patches would go through Michael
Ellerman's tree.

Paul.
