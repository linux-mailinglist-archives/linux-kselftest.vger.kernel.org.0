Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552C365534A
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Dec 2022 18:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiLWRi4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Dec 2022 12:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiLWRiy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Dec 2022 12:38:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0B7101E4
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Dec 2022 09:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671817085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1DBpMDBnZCETkHhEpu3dbIxZ5usdNzxzwapLkbA2vrk=;
        b=apuVHJD+vLLNCu3jcVT1Ur/wrGWUh7+A2Ju2NX3JwMCp38WEN5853o78cMv4Ir9uaTKr0F
        WEIBphhcyh9pghTZq/eKP+mf+bRNLswW2FKDLSLgDJXTUay2GEsoJ7YWLHVVakcf5kiESM
        PVNN5SzcjrUoU84dzzuR5dB7Oq9Fq8M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-y8DDByLFN7y7FYlxozE8YQ-1; Fri, 23 Dec 2022 12:37:59 -0500
X-MC-Unique: y8DDByLFN7y7FYlxozE8YQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E568811E6E;
        Fri, 23 Dec 2022 17:37:58 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28ABE4014EB9;
        Fri, 23 Dec 2022 17:37:58 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, seanjc@google.com,
        oupton@google.com, peterx@redhat.com, vkuznets@redhat.com,
        dmatlack@google.com, pgonda@google.com, andrew.jones@linux.dev
Subject: Re: [V3 PATCH 0/2] Execute hypercalls from guests according to cpu
Date:   Fri, 23 Dec 2022 12:37:34 -0500
Message-Id: <20221223173733.1624778-1-pbonzini@redhat.com>
In-Reply-To: <20221222230458.3828342-1-vannapurve@google.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> This series adds support of executing hypercall as per the native cpu
> type queried using cpuid instruction. CPU vendor type is stored after
> one time execution of cpuid instruction to be reused later.

Makes sense, are you going to add more patches that use the new function?

Paolo


