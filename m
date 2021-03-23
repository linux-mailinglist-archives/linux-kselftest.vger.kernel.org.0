Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C112E3460F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Mar 2021 15:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhCWOFq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Mar 2021 10:05:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25349 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232019AbhCWOFN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Mar 2021 10:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616508313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s0QrL15SMD0NtmXgQZAo0QmBtYcmlD01AUdLT9WPNTE=;
        b=GwtlNX2rhWxu5J8g+kGm3LFI1whVti651cSOR55NlQK1JSLFpUi/ofCfb8kcHComtBADMq
        CPQmTHF4/oLKxPaqf4coZa5xrtV2+EKBTCHYwA5+Oi4taBwALpfh45gc91eVXPj1CXrGr1
        bXoOQCudAOf4rYyt8bKW900nReFZQFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-pWor3gSUMieSXuWuSBAAKw-1; Tue, 23 Mar 2021 10:05:11 -0400
X-MC-Unique: pWor3gSUMieSXuWuSBAAKw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BACD05719E;
        Tue, 23 Mar 2021 14:05:08 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.194.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42B12694CC;
        Tue, 23 Mar 2021 14:04:56 +0000 (UTC)
Date:   Tue, 23 Mar 2021 15:04:53 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Yanan Wang <wangyanan55@huawei.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Gardon <bgardon@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        wanghaibin.wang@huawei.com, yuzenghui@huawei.com
Subject: Re: [RFC PATCH v5 04/10] KVM: selftests: Print the errno besides
 error-string in TEST_ASSERT
Message-ID: <20210323140453.4fu5cqju2gx5m345@kamzik.brq.redhat.com>
References: <20210323135231.24948-1-wangyanan55@huawei.com>
 <20210323135231.24948-5-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323135231.24948-5-wangyanan55@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 23, 2021 at 09:52:25PM +0800, Yanan Wang wrote:
> Print the errno besides error-string in TEST_ASSERT in the format of
> "errno=%d - %s" will explicitly indicate that the string is an error
> information. Besides, the errno is easier to be used for debugging
> than the error-string.
> 
> Suggested-by: Andrew Jones <drjones@redhat.com>
> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> ---
>  tools/testing/selftests/kvm/lib/assert.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/assert.c b/tools/testing/selftests/kvm/lib/assert.c
> index 5ebbd0d6b472..71ade6100fd3 100644
> --- a/tools/testing/selftests/kvm/lib/assert.c
> +++ b/tools/testing/selftests/kvm/lib/assert.c
> @@ -71,9 +71,9 @@ test_assert(bool exp, const char *exp_str,
>  
>  		fprintf(stderr, "==== Test Assertion Failure ====\n"
>  			"  %s:%u: %s\n"
> -			"  pid=%d tid=%d - %s\n",
> +			"  pid=%d tid=%d errno=%d - %s\n",
>  			file, line, exp_str, getpid(), _gettid(),
> -			strerror(errno));
> +			errno, strerror(errno));
>  		test_dump_stack();
>  		if (fmt) {
>  			fputs("  ", stderr);
> -- 
> 2.19.1
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

