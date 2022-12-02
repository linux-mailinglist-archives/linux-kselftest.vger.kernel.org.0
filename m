Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37B9640FC4
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 22:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiLBVGP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 16:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLBVGO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 16:06:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B402EA5D4
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 13:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670015118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cFFC8DQP235KAQhynGslmUAEiqukq9bbJSq7ImsePcg=;
        b=T/193CqJnNIWE0Wxto4OdjIarCFKdcwQAvD/oKa1YNs3oh+cFWSbahqjOhmlMmXm4BkGV3
        eQCpxbnlqI2+eJzvrdsJ+WWVqLRLobrqInQDcvfWM2Cc47FX4uY1bK/4TaUiKeyMm3KSuZ
        iIqYzwdZSyDNrBk3Hh3RYazTQi0QDv4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-612-dL8U8J5APuOZa_r2rus45Q-1; Fri, 02 Dec 2022 16:05:15 -0500
X-MC-Unique: dL8U8J5APuOZa_r2rus45Q-1
Received: by mail-qt1-f198.google.com with SMTP id cj6-20020a05622a258600b003a519d02f59so20453206qtb.5
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Dec 2022 13:05:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:subject:from:references:cc:to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cFFC8DQP235KAQhynGslmUAEiqukq9bbJSq7ImsePcg=;
        b=IzSSyUPDh7QQjyskln493d3wPwMXwnEfZacy/MYzIAxvB4Vv1APozDXKzBXjZ2DCNy
         uduBWRet+K3sfATckAriaRfEu3KpB7dWiw/igiPVfQ83d+Z9GsuHJOuw8PwZvhVnRNab
         9u7z1lfSZp6g/DHf5vDdpdhGd/34ZMTyXCvEnAcMoPE8ZWh/ExohoygzYAMnpNNqrT9P
         NPsyXjD+y1h0yxbbRPHWkNFfwPnykwrKuLWp/O9txSUSKGh2aQwkHNlQ1iQcGF3a/3s9
         Ep8KtKJwtjF9Vq7OAEdEU0DGRWzT7sUD2XYy4f9YL3Nqx1Emk61lqr6KzUJfbsxgmlHK
         X/GQ==
X-Gm-Message-State: ANoB5pnwpIzxK3EcHvbMiKhwaAlymqzSw6RUvbywud6klIfFCluNhqOF
        PFTv3/SNF48jqckVDKim6GQrDd2VocJSt2WpSx0fjWUtvXv8KgQ3oWqTrPP99r4iLWhgwQWrq2m
        Twhf9OqjAp4xD+9idv/fvYHfVYHf6
X-Received: by 2002:a05:622a:249:b0:39c:b5a2:5eb2 with SMTP id c9-20020a05622a024900b0039cb5a25eb2mr67826959qtx.39.1670015114804;
        Fri, 02 Dec 2022 13:05:14 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7vp3IqAgQ6ZMG3YOqX9iv6KuZoBk5uX+Ua75WkVAW8bb9j7DfCTCTUCSehg/cIXkMvDfHQgw==
X-Received: by 2002:a05:622a:249:b0:39c:b5a2:5eb2 with SMTP id c9-20020a05622a024900b0039cb5a25eb2mr67826934qtx.39.1670015114551;
        Fri, 02 Dec 2022 13:05:14 -0800 (PST)
Received: from [192.168.1.9] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a430600b006fc5a1d9cd4sm6305004qko.34.2022.12.02.13.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 13:05:14 -0800 (PST)
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, jpoimboe@redhat.com
References: <20220630141226.2802-1-mpdesouza@suse.com>
 <3f9f91a3-4c08-52f4-1d3c-79f835271222@linuxfoundation.org>
 <alpine.LSU.2.21.2207010931270.13603@pobox.suse.cz>
 <8ff95ef5-db76-171d-4c4c-a84d9981290d@linuxfoundation.org>
 <20220715144526.GF2737@pathway.suse.cz>
 <aae71b0b-74e3-5874-b12f-bf0d42d851e4@redhat.com>
 <c5a6cb8a-7b99-249e-5ba4-732fc0ed2e30@linuxfoundation.org>
 <Y4nEhb7yPK5l54IX@alley>
 <21025073-0ed6-427e-219e-99e9731f6688@linuxfoundation.org>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v2 0/2] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
Message-ID: <ed5a1f19-1e2e-7a04-7cc8-1a0324b2d508@redhat.com>
Date:   Fri, 2 Dec 2022 16:05:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <21025073-0ed6-427e-219e-99e9731f6688@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/2/22 3:03 PM, Shuah Khan wrote:
> On 12/2/22 02:25, Petr Mladek wrote:
>>
>> Yes, kABI is not backward compatible. But building the tests
>> modules out-of-tree way would allow to build test modules with
>> different kABI from the same sources.
>>
> 
> Okay. This is a solid reason for livepatch modules to live under
> sefltests. Let's capture this in README and the other updates that
> need to be made to it in v3.
> 

One additional benefit, however small, is that I think everyone is
building production livepatches, source based or via kpatch-build, as
out-of-tree modules.  (Miroslav/Petr/Marcos please correct me if I'm
wrong about source based.)

Having the livepatch selftests live under selftests/ would imply that
new subsystem (build) features would have to support the production
build use case from the get go.

Regards,

-- 
Joe

