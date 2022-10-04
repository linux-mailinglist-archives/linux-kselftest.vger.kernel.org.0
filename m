Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFB35F3E24
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Oct 2022 10:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiJDIVT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Oct 2022 04:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJDIVR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Oct 2022 04:21:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C71D1B9F2
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Oct 2022 01:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664871675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ey2tkE+Uksmp2pmcaxq0Z3p4VeNfOuZjcREwwMwZJB8=;
        b=SzRWaNvy8vQLBNN4xzJmQPa/GhEZaKMLoBSdUzlfS89NqmoWgv84+/B1PjSvvO1s3bvTGD
        f9NwA4LC6Kp7pbDCwPVtF5cktf/fXakylAeSYvCdul6YaRGiGdhW+0RVOx0EjoRF3f/Z8t
        41qrAFi1vK45pRIDsSyv38dpeEOQK2A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-375-ohEL88UiO66aCr1fs-BYRg-1; Tue, 04 Oct 2022 04:21:14 -0400
X-MC-Unique: ohEL88UiO66aCr1fs-BYRg-1
Received: by mail-wr1-f69.google.com with SMTP id p7-20020adfba87000000b0022cc6f805b1so3806452wrg.21
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Oct 2022 01:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ey2tkE+Uksmp2pmcaxq0Z3p4VeNfOuZjcREwwMwZJB8=;
        b=j56V+KI46vtECYUUbajl8NmHqlteBRZgRaIAsD3KBXeYre517l/S+NDzGYag34j5ET
         m+cRifU7Uof+7TSa+E7D36qIH2tXxxtejC4qssKn90JcRixdYs9h7ukhVW22ZWKfFz4g
         +o6qR1NxVSGVOZ9zNgiHu0CspK6nqqfkSk6GW1vpnAIeMeBjdr6c7Os+Brzh33XeVumZ
         zZ8EU53SoNKfA5OaU6e+Gg18QU9LwV5Dm7US3UIptQLIjZu8DpIl5ZgCarfYXzhSFOh4
         3pGAPUMwsNqasWM4w8rwR23zh9Lc/285RnbCG9+Bnwv8XoVQItC9hxsXyRcd3drMfYUI
         QAWA==
X-Gm-Message-State: ACrzQf1k3NgkWOaCrcW2QaHecPqbctf/dgvFhVoMGNulc12/OJfTZodx
        tClAr5IK4zuBvPGdQB0ObwphSgZynJYMVL6WxOSjtX5KOQxDYFU2nSbDsgt1juHfwVgfld24mXp
        QtU7t/zc9SCeiwv+0SUoy2gac6Hiw
X-Received: by 2002:a05:600c:474a:b0:3b4:cb93:7d57 with SMTP id w10-20020a05600c474a00b003b4cb937d57mr9507753wmo.41.1664871673642;
        Tue, 04 Oct 2022 01:21:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7t7/WnQ/rPAxDlAuMCud8gO/JdRg8ZGL5c/bT8KDb0P6rlWds0eGi2vsKOLBXUv0PFtCmybw==
X-Received: by 2002:a05:600c:474a:b0:3b4:cb93:7d57 with SMTP id w10-20020a05600c474a00b003b4cb937d57mr9507735wmo.41.1664871673457;
        Tue, 04 Oct 2022 01:21:13 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-178-246.web.vodafone.de. [109.43.178.246])
        by smtp.gmail.com with ESMTPSA id x24-20020a05600c189800b003b4727d199asm13080082wmp.15.2022.10.04.01.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 01:21:12 -0700 (PDT)
Message-ID: <3762a3e2-07f8-0048-6b3e-6b0417aff781@redhat.com>
Date:   Tue, 4 Oct 2022 10:21:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1 8/9] KVM: s390: selftest: memop: Fix typo
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
 <20220930210751.225873-9-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220930210751.225873-9-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 30/09/2022 23.07, Janis Schoetterl-Glausch wrote:
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>   tools/testing/selftests/kvm/s390x/memop.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> index 3a160ab0415b..1887685b41d2 100644
> --- a/tools/testing/selftests/kvm/s390x/memop.c
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -970,7 +970,7 @@ static void test_errors_key_fetch_prot_override_enabled(void)
>   
>   	/*
>   	 * vcpu, mismatching keys on fetch,
> -	 * fetch protection override does not apply because memory range acceeded
> +	 * fetch protection override does not apply because memory range exceeded
>   	 */
>   	CHECK_N_DO(ERR_PROT_MOP, t.vcpu, LOGICAL, READ, mem2, 2048 + 1, GADDR_V(0), KEY(2));
>   	CHECK_N_DO(ERR_PROT_MOP, t.vcpu, LOGICAL, READ, mem2, PAGE_SIZE + 2048 + 1,

Reviewed-by: Thomas Huth <thuth@redhat.com>

