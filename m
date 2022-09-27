Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2FE5EC238
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Sep 2022 14:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiI0MPR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Sep 2022 08:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbiI0MPF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Sep 2022 08:15:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3962ED4F
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Sep 2022 05:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664280899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rSE3SZr7AU4BSfTZW9EzqUJqNHJZJS1agFSm+3MsOAM=;
        b=UigL3dT8bhVsb5z6RXv7Ii0OgqjjeoH97JzvKZE4qav8VPLjw8NlsBv/PFLWlBvYTDPnLo
        sKG5Ti3jIo5y07R1dapdgxj/AExqo9aaEswvclfkDTVuPHHNjoekOMqp7kkx2fD1Tjjfvf
        J6FTxC0RUdvso8C2o7qMis73n981MXI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-669-DNsUJCsVOtamKzkGKkOqpQ-1; Tue, 27 Sep 2022 08:14:56 -0400
X-MC-Unique: DNsUJCsVOtamKzkGKkOqpQ-1
Received: by mail-ed1-f69.google.com with SMTP id f18-20020a056402355200b0045115517911so7609888edd.14
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Sep 2022 05:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rSE3SZr7AU4BSfTZW9EzqUJqNHJZJS1agFSm+3MsOAM=;
        b=pfmnmkB2+w6gW9f7Og6TfNFeZsFCAplhT0woArM9Q7jjwNcFxijzquG3wlnACH8qaz
         vBTb1Js8nVujqY1OKQG6aaCz/O/OL4IB9AkEG4JscT9Mvpfo6UqUddPOxfoDOdz+NA+V
         TiWF4Rk8qkRon+9VRf6f8Ki5Pz6sqoWDIMCEWGhe+sBo/9en3y9H9okRTzy3q/FVriem
         Y79jk2twGir6GLsbY4572W0xZGdWjhkGVMJeQF7FZKbV7JGtFG0f+gBll66bGeIcMdaY
         gCwnrePwhjc7YpBEPVsh+RLZtwIHcGjQVy+hCieMu13A4V6QyvMLt/sB2KVUVcXldlro
         0xTg==
X-Gm-Message-State: ACrzQf39BjjC+XNXI8MG0ZGQ26n5NzyW2r2ayBdwkPWoL16C0ITpMgng
        2RRs8kEV5L8IBRumzX+BpdBsZJ/6eDWc6nANg4Ei8UIV1QGeML4L7OuRF3nAwFLjrXB3fVMRfuI
        n/MxOXWs5YHT2PfX7g2Q0kr1gDHq0
X-Received: by 2002:aa7:c04f:0:b0:457:1b08:d056 with SMTP id k15-20020aa7c04f000000b004571b08d056mr14655692edo.146.1664280895437;
        Tue, 27 Sep 2022 05:14:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5dF2l0zCe+9PMvtpzvSQRGqYKmswR21oDA/D9ukNUOBwPFoxUVmoO0fb4CxB4+uAI8q522lA==
X-Received: by 2002:aa7:c04f:0:b0:457:1b08:d056 with SMTP id k15-20020aa7c04f000000b004571b08d056mr14655669edo.146.1664280895219;
        Tue, 27 Sep 2022 05:14:55 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id u11-20020a170906780b00b0077a8fa8ba55sm695214ejm.210.2022.09.27.05.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 05:14:54 -0700 (PDT)
Message-ID: <005c8afa-d290-d140-0dac-19a41f2ef81a@redhat.com>
Date:   Tue, 27 Sep 2022 14:14:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] KVM: selftests: replace assertion with warning in
 access_tracking_perf_test
Content-Language: en-US
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        kvm@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220926082923.299554-1-eesposit@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220926082923.299554-1-eesposit@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/26/22 10:29, Emanuele Giuseppe Esposito wrote:
> Page_idle uses {ptep/pmdp}_clear_young_notify which in turn calls
> the mmu notifier callback ->clear_young(), which purposefully
> does not flush the TLB.
> 
> When running the test in a nested guest, point 1. of the test
> doc header is violated, because KVM TLB is unbounded by size
> and since no flush is forced, KVM does not update the sptes
> accessed/idle bits resulting in guest assertion failure.
> 
> More precisely, only the first ACCESS_WRITE in run_test() actually
> makes visible changes, because sptes are created and the accessed
> bit is set to 1 (or idle bit is 0). Then the first mark_memory_idle()
> passes since access bit is still one, and sets all pages as idle
> (or not accessed). When the next write is performed, the update
> is not flushed therefore idle is still 1 and next mark_memory_idle()
> fails.

Queued, thanks.

Paolo

