Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BD75F1962
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Oct 2022 05:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbiJADW0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 23:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbiJADVp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 23:21:45 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E3A3FD56;
        Fri, 30 Sep 2022 20:15:00 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d10so5757336pfh.6;
        Fri, 30 Sep 2022 20:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/j3pQl7KNQD6fZGldj2Yu7/6BAOJombUczMRGLkAS7o=;
        b=mgl6vSGeFDVKtIaJ2aUUpj5CclceO4fNtR18BDmlhfEpUEeZhZLG+ULT95J6lRoQnK
         g+lNqrS+HjVBerjmNgsbs9BkOHdbdhtxs19GAwinUnqOK2bEawtu+QQDxRr68amjq7HZ
         FTh79gXpzCwH3ZX9W1o+hFZfdMFSYvlhPAsQhAMs/BG66hRtM34iInP3wa44BlIdRB22
         zLOErjpG2LPMicbjC3Rsf3J+aXvST7DD77qO9UxFhJbWGhostrBZKITtjKSBmA78rdKl
         j/iVkuEI7RYXxWfBnPAOpaef/6tLLde9I5qmr9n+lbvhBTrRZ4IZXdQ/LcveMv00OA2f
         JDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/j3pQl7KNQD6fZGldj2Yu7/6BAOJombUczMRGLkAS7o=;
        b=2BWYwQeHlduHyC1a+WGtq+YHPR//wrBG1U432niBmAdvD67aBfK3WvjEtJlVguGJMA
         2lkOVVKDPQScExjLKm315t6Q0tpfXdQ7WSC0TEUR2ZeL6Dqj9FX1q7dfq3JiJsC9lJ4h
         Gn8yfhthY1ariFzIhzhkD2z+PDO0e8CbXGglQC/K7G8Un0rk2rtN7QakOrbNOehL2ram
         ops/KodqaN4+GUxYPWaYRxHGtlUVDd0me4T0odF0fmnniCx7gkqBuh5j+6a/vGAh31v8
         lhAB0mF5R6QnXOFZZXgGRBlQ1N7KDsN2srQsio6l9NFU7kWqIpAPjyTrBBAhdIht5YfE
         SWUQ==
X-Gm-Message-State: ACrzQf202djo4kvdAyO0/MmdVNvSHjpucWGnlL1nW1ljKAdZ6yTRTkPB
        +emUR1pRdrI+DCq9vaRTHAg=
X-Google-Smtp-Source: AMsMyM5SsMW3MpGDsBSOIP3KV1QTMgg8OOIzN8WJsv6ACc3mas8d/uNS3lU/N70q4OO1X7rCvgwRZA==
X-Received: by 2002:a05:6a00:2185:b0:520:7276:6570 with SMTP id h5-20020a056a00218500b0052072766570mr12182376pfi.84.1664594031046;
        Fri, 30 Sep 2022 20:13:51 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-5.three.co.id. [180.214.232.5])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902e74500b00176ab6a0d5fsm2733794plf.54.2022.09.30.20.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 20:13:50 -0700 (PDT)
Message-ID: <14319427-5239-1b63-b758-5e2d79cdd357@gmail.com>
Date:   Sat, 1 Oct 2022 10:13:44 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
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
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220930210751.225873-9-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/1/22 04:07, Janis Schoetterl-Glausch wrote:
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>  tools/testing/selftests/kvm/s390x/memop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> index 3a160ab0415b..1887685b41d2 100644
> --- a/tools/testing/selftests/kvm/s390x/memop.c
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -970,7 +970,7 @@ static void test_errors_key_fetch_prot_override_enabled(void)
>  
>  	/*
>  	 * vcpu, mismatching keys on fetch,
> -	 * fetch protection override does not apply because memory range acceeded
> +	 * fetch protection override does not apply because memory range exceeded
>  	 */
>  	CHECK_N_DO(ERR_PROT_MOP, t.vcpu, LOGICAL, READ, mem2, 2048 + 1, GADDR_V(0), KEY(2));
>  	CHECK_N_DO(ERR_PROT_MOP, t.vcpu, LOGICAL, READ, mem2, PAGE_SIZE + 2048 + 1,

No patch description? Seriously?

What about this one?:

```
The word "acceded" isn't the right word to describe too much memory
situation. Substitute it with "exceeded".
```

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
