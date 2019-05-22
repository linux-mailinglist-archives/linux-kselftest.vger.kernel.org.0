Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D37B25FBD
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2019 10:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfEVIoV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 May 2019 04:44:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbfEVIoV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 May 2019 04:44:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0DCDC3082E42;
        Wed, 22 May 2019 08:44:21 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-204-233.brq.redhat.com [10.40.204.233])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 33C00600C6;
        Wed, 22 May 2019 08:44:14 +0000 (UTC)
Date:   Wed, 22 May 2019 10:44:09 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Thomas Huth <thuth@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] KVM selftests for s390x
Message-ID: <20190522084409.qz5hs7lqj65qg6x5@kamzik.brq.redhat.com>
References: <20190516111253.4494-1-thuth@redhat.com>
 <b412e591-3983-ebef-510b-43f9b7be4147@redhat.com>
 <9423ba89-b10e-5e6e-3cc8-8088f3088233@redhat.com>
 <4d94124e-00f6-aa65-3a4a-bd8910480329@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d94124e-00f6-aa65-3a4a-bd8910480329@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 22 May 2019 08:44:21 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 20, 2019 at 01:43:06PM +0200, Paolo Bonzini wrote:
> On 20/05/19 13:30, Thomas Huth wrote:
> >> No objections at all, though it would be like to have ucall plumbed in
> >> from the beginning.
> > I'm still looking at the ucall interface ... what I don't quite get yet
> > is the question why the ucall_type there is selectable during runtime?
> > 
> > Are there plans to have test that could either use UCALL_PIO or
> > UCALL_MMIO? If not, what about moving ucall_init() and ucall() to
> > architecture specific code in tools/testing/selftests/kvm/lib/aarch64/
> > and tools/testing/selftests/kvm/lib/x86_64 instead, and to remove the
> > ucall_type stuff again (so that x86 is hard-wired to PIO and aarch64
> > is hard-wired to MMIO)? ... then I could add a DIAG-based ucall
> > on s390x more easily, I think.
> 
> Yes, that would work.  I think Andrew wanted the flexibility to use MMIO
> on x86, but it's not really necessary to have it.

If the flexibility isn't necessary, then I agree that it'll be nicer to
put the ucall_init() in arch setup code, avoiding the need to remember
it in each unit test.

Thanks,
drew
