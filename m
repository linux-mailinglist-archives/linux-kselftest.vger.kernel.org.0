Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAEE4278EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2019 11:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfEWJLk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 05:11:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfEWJLk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 05:11:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B9F03086229;
        Thu, 23 May 2019 09:11:39 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EA255B681;
        Thu, 23 May 2019 09:11:35 +0000 (UTC)
Date:   Thu, 23 May 2019 11:11:33 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Thomas Huth <thuth@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: selftests: Compile code with warnings enabled
Message-ID: <20190523091133.wemwsmz6xslsz3va@kamzik.brq.redhat.com>
References: <20190517090445.4502-1-thuth@redhat.com>
 <f998da41-c75d-0afa-02cd-e2e5d8f0f546@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f998da41-c75d-0afa-02cd-e2e5d8f0f546@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 23 May 2019 09:11:39 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 20, 2019 at 12:03:08PM +0200, Paolo Bonzini wrote:
> On 17/05/19 11:04, Thomas Huth wrote:
> > So far the KVM selftests are compiled without any compiler warnings
> > enabled. That's quite bad, since we miss a lot of possible bugs this
> > way. Let's enable at least "-Wall" and some other useful warning flags
> > now, and fix at least the trivial problems in the code (like unused
> > variables).
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  v2:
> >  - Rebased to kvm/queue
> >  - Fix warnings in state_test.c and evmcs_test.c, too
> > 
> >  tools/testing/selftests/kvm/Makefile                       | 4 +++-
> >  tools/testing/selftests/kvm/dirty_log_test.c               | 6 +++++-
> >  tools/testing/selftests/kvm/lib/kvm_util.c                 | 3 ---
> >  tools/testing/selftests/kvm/lib/x86_64/processor.c         | 4 +---
> >  tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c   | 1 +
> >  tools/testing/selftests/kvm/x86_64/evmcs_test.c            | 7 +------
> >  tools/testing/selftests/kvm/x86_64/platform_info_test.c    | 1 -
> >  tools/testing/selftests/kvm/x86_64/smm_test.c              | 3 +--
> >  tools/testing/selftests/kvm/x86_64/state_test.c            | 7 +------
> >  .../selftests/kvm/x86_64/vmx_close_while_nested_test.c     | 5 +----
> >  tools/testing/selftests/kvm/x86_64/vmx_tsc_adjust_test.c   | 5 ++---
> >  11 files changed, 16 insertions(+), 30 deletions(-)
> 
> Queued, with a squashed fix to kvm_get_supported_hv_cpuid.
>

I've done the fixups needed to keep aarch64 compiling and will send
the patch shortly.

drew 
