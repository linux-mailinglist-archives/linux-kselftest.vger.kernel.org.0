Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8FC2F4569
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jan 2021 08:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbhAMHj3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jan 2021 02:39:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37163 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726460AbhAMHj2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jan 2021 02:39:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610523482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vASVQk6CyeuqGmqPAo777fJFAsgxGMg2kZr0CGQiujs=;
        b=BJDI+BaPT+Ob6ni1/79iVfOJso+RaMbKk1issyQC7dRelnYqSOvJzt8uFFFZQ9m93tibF1
        j7ZW78WsNG1F/eW96IfA78K6+kLlZ1U1vWVQhSuVIhZYisPCEe+ZowyKJyyGl8d8Anf1fs
        Yh8VMNJ6tYISsh0XslzFu+7E1Abphow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590--7PEjkhWPR-znfObeI4NFA-1; Wed, 13 Jan 2021 02:38:00 -0500
X-MC-Unique: -7PEjkhWPR-znfObeI4NFA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C934802B40;
        Wed, 13 Jan 2021 07:37:59 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-122.ams2.redhat.com [10.36.112.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD6135D9DD;
        Wed, 13 Jan 2021 07:37:53 +0000 (UTC)
Subject: Re: [PATCH 2/6] KVM: selftests: Avoid flooding debug log while
 populating memory
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jacob Xu <jacobhxu@google.com>,
        Makarand Sonare <makarandsonare@google.com>
References: <20210112214253.463999-1-bgardon@google.com>
 <20210112214253.463999-3-bgardon@google.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <c25adfbe-c36c-8f39-92f8-308f8f8656d0@redhat.com>
Date:   Wed, 13 Jan 2021 08:37:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210112214253.463999-3-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/01/2021 22.42, Ben Gardon wrote:
> Peter Xu pointed out that a log message printed while waiting for the
> memory population phase of the dirty_log_perf_test will flood the debug
> logs as there is no delay after printing the message. Since the message
> does not provide much value anyway, remove it.
> 
> Reviewed-by: Jacob Xu <jacobhxu@google.com>
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>   tools/testing/selftests/kvm/dirty_log_perf_test.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> index 16efe6589b43..15a9c45bdb5f 100644
> --- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> @@ -146,8 +146,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>   	/* Allow the vCPU to populate memory */
>   	pr_debug("Starting iteration %lu - Populating\n", iteration);
>   	while (READ_ONCE(vcpu_last_completed_iteration[vcpu_id]) != iteration)
> -		pr_debug("Waiting for vcpu_last_completed_iteration == %lu\n",
> -			iteration);
> +		;
>   
>   	ts_diff = timespec_elapsed(start);
>   	pr_info("Populate memory time: %ld.%.9lds\n",
> @@ -171,9 +170,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>   
>   		pr_debug("Starting iteration %lu\n", iteration);
>   		for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
> -			while (READ_ONCE(vcpu_last_completed_iteration[vcpu_id]) != iteration)
> -				pr_debug("Waiting for vCPU %d vcpu_last_completed_iteration == %lu\n",
> -					 vcpu_id, iteration);
> +			while (READ_ONCE(vcpu_last_completed_iteration[vcpu_id])
> +			       != iteration)
> +				;
>   		}
>   
>   		ts_diff = timespec_elapsed(start);
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>

