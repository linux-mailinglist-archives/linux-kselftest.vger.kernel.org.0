Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F7364C5D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Dec 2022 10:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbiLNJYE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Dec 2022 04:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237721AbiLNJYC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Dec 2022 04:24:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83C15588
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Dec 2022 01:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671009794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7575zCJt/W+bOCfmNqE0fJaW9dUNr74ly+FhAEM/HvY=;
        b=jKdH75PBV6Y0RGJXsuf3lw87WhziL/G9ZDowNQL+qLycPiqtkRs1lEFgJjKAh/S7N5kIWU
        LAps7GjW7FVuJb8thUBL2VG/Vxdk5oLTotW3EJsutUcHx6rQAeD7kkF/97726YwN7m0tna
        wrb+HPdXeLMQoMK7iJR3jrQeWgWMEX8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-298-Fcm5MvEDOl2chLeCM2mC-A-1; Wed, 14 Dec 2022 04:23:12 -0500
X-MC-Unique: Fcm5MvEDOl2chLeCM2mC-A-1
Received: by mail-wm1-f71.google.com with SMTP id i9-20020a1c3b09000000b003d21fa95c38so4164030wma.3
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Dec 2022 01:23:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7575zCJt/W+bOCfmNqE0fJaW9dUNr74ly+FhAEM/HvY=;
        b=rZ+Ifi7Hcw20iivbv2naB6fQJx4VqQWlz7A2kDl7gEu51JCtgmzCPi6myBiP0Lwamq
         csoaTFj3mz+VJTiLkYbOJbPQ2i/c0z4ZG37NFZJLQTgmyOgW1Tk2vbD4TBs8JUiinuVk
         LGfW6jekhGge/74XmJxRHXwQ2bBEplaEN1leA7H7/o+8Xm7OSPJKYgJCLd8VHPlKVdHs
         jeVIAOwAf5IbspyVLAqoH6CWfiR1IRfJMC5FVggp2p8YfIl4U4Qpujvv+CVtWRF8Mvrn
         cGFvKNMxP/RmLWaXUCNpiWohr9h3XhCyn+DhYyluxlTKxfyu4BvPV8urutys/Se7IRQJ
         1h0Q==
X-Gm-Message-State: ANoB5pnxyQpHWkRzosBvlOvU1ovoHlXjCz15jB9DTanDIgJ/piWUlyB4
        AfSrcAzVzIq1SNKYc8GPbpuyQGg1vWvSBziOg2BVoozZDbCL2T2L8mDcdfZhKBfAw1o+Uo7FLxh
        wbFnDoj8J4HLV3WV5TFN8ueGtP/5j
X-Received: by 2002:a05:6000:1f81:b0:250:22e4:b8a6 with SMTP id bw1-20020a0560001f8100b0025022e4b8a6mr5865934wrb.39.1671009791804;
        Wed, 14 Dec 2022 01:23:11 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5BsrFQrZiqcKQNGodRXeWHRfYLzojFhTjRKPMU8We633YCGl8jewbotKhhnFGoVJScipq0ng==
X-Received: by 2002:a05:6000:1f81:b0:250:22e4:b8a6 with SMTP id bw1-20020a0560001f8100b0025022e4b8a6mr5865908wrb.39.1671009791515;
        Wed, 14 Dec 2022 01:23:11 -0800 (PST)
Received: from [192.168.0.5] (ip-109-43-178-56.web.vodafone.de. [109.43.178.56])
        by smtp.gmail.com with ESMTPSA id s18-20020a5d4ed2000000b00242271fd2besm2257482wrv.89.2022.12.14.01.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 01:23:10 -0800 (PST)
Message-ID: <4e8cc757-13e2-3be4-fea2-3ef3dcd0688d@redhat.com>
Date:   Wed, 14 Dec 2022 10:23:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 4/9] KVM: s390: selftest: memop: Replace macros by
 functions
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20221213165405.2953539-1-scgl@linux.ibm.com>
 <20221213165405.2953539-5-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20221213165405.2953539-5-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 13/12/2022 17.54, Janis Schoetterl-Glausch wrote:
> Replace the DEFAULT_* test helpers by functions, as they don't
> need the exta flexibility.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>   tools/testing/selftests/kvm/s390x/memop.c | 82 +++++++++++------------
>   1 file changed, 39 insertions(+), 43 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

