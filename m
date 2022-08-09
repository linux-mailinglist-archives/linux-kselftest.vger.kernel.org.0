Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE83E58D457
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Aug 2022 09:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbiHIHQo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Aug 2022 03:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238017AbiHIHQn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Aug 2022 03:16:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6ACD20BF4
        for <linux-kselftest@vger.kernel.org>; Tue,  9 Aug 2022 00:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660029401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pFDs6xidhpbw1qYaUFr1MfUDhoMVpVETbRmiPl3tRsM=;
        b=Khza/dN1QoNhC0Ta2bpD7qkDZuz1OyCI0xm9ynaHUH6d0wtVYh4Msr2s8n9qVjNWkjVZEd
        UMbKZtyKZdcZ391G92A/oJRB6lT6pz+bN7HAW8xs4uLN4WfnwitlV8D8p2piYXiLTUxXUs
        DmlzWo53/8c3XrA8MdAtgXuhQKQ0F4I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-wVvB783QNq-aMoXaZIWmxA-1; Tue, 09 Aug 2022 03:16:38 -0400
X-MC-Unique: wVvB783QNq-aMoXaZIWmxA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37B753801FE4;
        Tue,  9 Aug 2022 07:16:38 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.193.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DC411415125;
        Tue,  9 Aug 2022 07:16:35 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, maz@kernel.org, oliver.upton@linux.dev,
        andrew.jones@linux.dev, seanjc@google.com,
        mathieu.desnoyers@efficios.com, yihyu@redhat.com,
        shan.gavin@gmail.com
Subject: Re: [PATCH 1/2] KVM: selftests: Make rseq compatible with glibc-2.35
References: <20220809060627.115847-1-gshan@redhat.com>
        <20220809060627.115847-2-gshan@redhat.com>
        <8735e6ncxw.fsf@oldenburg.str.redhat.com>
        <7844e3fa-e49e-de75-e424-e82d3a023dd6@redhat.com>
Date:   Tue, 09 Aug 2022 09:16:33 +0200
In-Reply-To: <7844e3fa-e49e-de75-e424-e82d3a023dd6@redhat.com> (Gavin Shan's
        message of "Tue, 9 Aug 2022 18:45:26 +1000")
Message-ID: <87o7wtnay6.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

* Gavin Shan:

>> __builtin_thread_pointer doesn't work on all architectures/GCC
>> versions.
>> Is this a problem for selftests?
>> 
>
> It's a problem as the test case is running on all architectures. I think I
> need introduce our own __builtin_thread_pointer() for where it's not
> supported: (1) PowerPC  (2) x86 without GCC 11
>
> Please let me know if I still have missed cases where
> __buitin_thread_pointer() isn't supported?

As far as I know, these are the two outliers that also have rseq
support.  The list is a bit longer if we also consider non-rseq
architectures (csky, hppa, ia64, m68k, microblaze, sparc, don't know
about the Linux architectures without glibc support).

Thanks,
Florian

