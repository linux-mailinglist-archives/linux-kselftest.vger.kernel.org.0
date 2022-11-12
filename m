Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A096268BE
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Nov 2022 11:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiKLKFj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Nov 2022 05:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLKFj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Nov 2022 05:05:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2F52AB
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Nov 2022 02:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668247482;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YNPWveXNga0scY6/51aebupOAjiaIyJv8HXR04747GY=;
        b=Sz9OM92T0p5NMjzz5llRz0IGTk0fPozFFYTT06RKVRXzkWIb0u5LDAlsXtg8/6UnkEvCjL
        w/IybcIo4m86pf6rcamfWeWc5CUjQ9/gCYog8K6K3+bNyLhgB4jC6+wHSy5X/97uNCkW5D
        wPld/j+dwz+sC3q9hbx6WvwtsVl/93E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-23T7CmQMMxq2btIs--dQOw-1; Sat, 12 Nov 2022 05:04:37 -0500
X-MC-Unique: 23T7CmQMMxq2btIs--dQOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03D85101A528;
        Sat, 12 Nov 2022 10:04:37 +0000 (UTC)
Received: from [10.67.24.81] (unknown [10.67.24.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A8B8202322E;
        Sat, 12 Nov 2022 10:04:31 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 2/2] KVM: selftests: Build access_tracking_perf_test for
 arm64
To:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org,
        David Matlack <dmatlack@google.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
References: <20221111231946.944807-1-oliver.upton@linux.dev>
 <20221111231946.944807-3-oliver.upton@linux.dev>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <8a578b9d-b2a8-a1f9-2a8c-c0109c863723@redhat.com>
Date:   Sat, 12 Nov 2022 18:04:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20221111231946.944807-3-oliver.upton@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/12/22 7:19 AM, Oliver Upton wrote:
> Does exactly what it says on the tin.
> 
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> ---
>   tools/testing/selftests/kvm/Makefile | 1 +
>   1 file changed, 1 insertion(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 0172eb6cb6ee..4c0ff91a8964 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -156,6 +156,7 @@ TEST_GEN_PROGS_aarch64 += aarch64/psci_test
>   TEST_GEN_PROGS_aarch64 += aarch64/vcpu_width_config
>   TEST_GEN_PROGS_aarch64 += aarch64/vgic_init
>   TEST_GEN_PROGS_aarch64 += aarch64/vgic_irq
> +TEST_GEN_PROGS_aarch64 += access_tracking_perf_test
>   TEST_GEN_PROGS_aarch64 += demand_paging_test
>   TEST_GEN_PROGS_aarch64 += dirty_log_test
>   TEST_GEN_PROGS_aarch64 += dirty_log_perf_test
> 

