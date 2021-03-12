Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB48338B5A
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Mar 2021 12:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhCLLR5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Mar 2021 06:17:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41534 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233653AbhCLLRn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Mar 2021 06:17:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615547863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UGPDzUa5JilVZrEVbbRzUiBVPETkoDHcYduKqCj+MOo=;
        b=b5iVaOfaYUBsZHo+EWiYYqTjrie1OlyVO3RuxJKUbiIw8z3RF1QEkHdjaJhM2Hc2jsQUIk
        1OEhAzkb+2HHiIeUus+HoBxjTwQ9ifAp3OX+VguohP3FI0uqkNkupB95MqaeBhWJJJ5+vk
        zXq3e4dkgXW7HQgdwJrNv9fyQcZE920=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-q5kalNEnMASwlMrnVkZ9-Q-1; Fri, 12 Mar 2021 06:17:41 -0500
X-MC-Unique: q5kalNEnMASwlMrnVkZ9-Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12C8318460E5;
        Fri, 12 Mar 2021 11:17:39 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 64077694CD;
        Fri, 12 Mar 2021 11:17:29 +0000 (UTC)
Date:   Fri, 12 Mar 2021 12:17:26 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Yanan Wang <wangyanan55@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Xu <peterx@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        wanghaibin.wang@huawei.com, yezengruan@huawei.com,
        yuzenghui@huawei.com
Subject: Re: [RFC PATCH v4 3/9] KVM: selftests: Use flag CLOCK_MONOTONIC_RAW
 for timing
Message-ID: <20210312111726.6xfpc2cycab7yfld@kamzik.brq.redhat.com>
References: <20210302125751.19080-1-wangyanan55@huawei.com>
 <20210302125751.19080-4-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302125751.19080-4-wangyanan55@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 02, 2021 at 08:57:45PM +0800, Yanan Wang wrote:
> In addition to function of CLOCK_MONOTONIC, flag CLOCK_MONOTONIC_RAW can
> also shield possiable impact of NTP, which can provide more robustness.
> 
> Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> Reviewed-by: Ben Gardon <bgardon@google.com>
> ---
>  tools/testing/selftests/kvm/demand_paging_test.c  |  8 ++++----
>  tools/testing/selftests/kvm/dirty_log_perf_test.c | 14 +++++++-------
>  tools/testing/selftests/kvm/lib/test_util.c       |  2 +-
>  tools/testing/selftests/kvm/steal_time.c          |  4 ++--
>  4 files changed, 14 insertions(+), 14 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

