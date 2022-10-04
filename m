Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A558A5F3E11
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Oct 2022 10:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJDIS2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Oct 2022 04:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJDISI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Oct 2022 04:18:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B473911C02
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Oct 2022 01:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664871486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NLtFZq4bDaN6BM38qfHtC/XiTFqjPED0T8bmDBUI3bM=;
        b=XRcRml3kdBAWjR7L5PLbkQAZO8DpuLMUwtyAbuOPU799wuQv2+BTvtpZ2OICSzJ2UPRuhi
        cF00jAjVD1rtNC2qQVyLvfz2PS7hiV/T6bn8elvR4XrSgmpeFFWRAN8ZXOqRgvN7rt7MMv
        cixpFKbWngmLJjaR8+kksA9yXMPOAfk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-647-Lc3aK_qwMTWh9vaPk8oCGw-1; Tue, 04 Oct 2022 04:18:05 -0400
X-MC-Unique: Lc3aK_qwMTWh9vaPk8oCGw-1
Received: by mail-wr1-f72.google.com with SMTP id m20-20020adfa3d4000000b0022e2fa93dd1so1786901wrb.2
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Oct 2022 01:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NLtFZq4bDaN6BM38qfHtC/XiTFqjPED0T8bmDBUI3bM=;
        b=4u32zHAr4lZlkBa5/2Oi8cgxnknvbgXB6Jc5/lfhJO5nKEXfzYTYG7jPoiEdQltdx9
         q0JTans+j8l7U1XzgWLnYeBk3JHO6iOGZMLSEPb5/4ZvqEEBJY0t1V3pVdJZiNvrSIl4
         7YpYN9XDMOQO+y7cT2A6hULXMq0Bj+9pJP1BgXbof0MD2VJGG09OBGVssImcHMClxzej
         kLUra0PTvOK99Uu+U6snlldiRSmD8YqIAAlELOTNA2f1OoMW3l8ZKRdwxEw6vtd3p31/
         85WClJHA5pT0cVlf3/KKwczuNvmn6OO/dHmhYZ2QZuBi4gLydZTuaSX8+GOaWxvVtQrf
         +2mg==
X-Gm-Message-State: ACrzQf31a4uBWUbbO/QV0WwkwywAUxKEvQLB+A9E7mYen4BECrvgAeNa
        jV1vU1EdnjFwndxOtFeDTpY6gf0TGovpq8N6+zy/HhoqOyNG0Ddg41qJ+2u83pOcmYYoewdecKX
        gNNlA2PZBLQYJK6Gsdygvg5s5m+qf
X-Received: by 2002:adf:d1e3:0:b0:22a:b9e2:8841 with SMTP id g3-20020adfd1e3000000b0022ab9e28841mr14873496wrd.184.1664871484640;
        Tue, 04 Oct 2022 01:18:04 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6pGiVfRgi+gr5FmqmXrxztDFohEkGW+UwhA75mOZyu+1mXYa4G6dLTHbSwxPWZraEEuJmhXw==
X-Received: by 2002:adf:d1e3:0:b0:22a:b9e2:8841 with SMTP id g3-20020adfd1e3000000b0022ab9e28841mr14873486wrd.184.1664871484473;
        Tue, 04 Oct 2022 01:18:04 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-178-246.web.vodafone.de. [109.43.178.246])
        by smtp.gmail.com with ESMTPSA id y9-20020a5d4ac9000000b0021badf3cb26sm14655866wrs.63.2022.10.04.01.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 01:18:03 -0700 (PDT)
Message-ID: <65ec72fd-5893-659d-cc79-340eacb3a897@redhat.com>
Date:   Tue, 4 Oct 2022 10:18:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1 4/9] KVM: s390: selftest: memop: Pass mop_desc via
 pointer
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
References: <20220930210751.225873-1-scgl@linux.ibm.com>
 <20220930210751.225873-5-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220930210751.225873-5-scgl@linux.ibm.com>
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

On 30/09/2022 23.07, Janis Schoetterl-Glausch wrote:
> The struct is quite large, so this seems nicer.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>   tools/testing/selftests/kvm/s390x/memop.c | 44 +++++++++++------------
>   1 file changed, 22 insertions(+), 22 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

