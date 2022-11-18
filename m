Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC20162EB4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Nov 2022 02:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240485AbiKRBvG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 20:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiKRBvB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 20:51:01 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BBD1E71A;
        Thu, 17 Nov 2022 17:51:01 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so3724698pjk.1;
        Thu, 17 Nov 2022 17:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBS4FEaFHTKXaYFv2EZVW4mDEjeLzjqY4+noYhxCMC0=;
        b=PQJiGp8FtrzmlUizG+g1ph5MA8h5OzMv5uAA3sI+jLjxaM8z5Bw7stVBixImIawU/j
         qDwCW44gKY4EL2t6MknTpgzfBadhflgt1nuMyf0GuXvWzQaBiyTXiqOBpfwrHgoGX8JU
         hDs9EaawGpzWaKK/uH62CvcAoBpNcVNNRGmt3yQ8IuiwyafwrDt6JUWcD5j5RIm2i+Li
         LWxo3PVbAm/xX9oILh2qYCC9dr5VWZ7CLmpmr7cGc9ad6Fbylw30fR1/AgQHpdMRFKR8
         2fZT1ARENMBLGt3WhX7OPsYObaBpZXosDwQtvBb+POv6xgkKMnbDS2MIgGDDnDNZNV9m
         /WYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBS4FEaFHTKXaYFv2EZVW4mDEjeLzjqY4+noYhxCMC0=;
        b=KmkcAV6ScOb1GmAEM/1vuIpwMAy8IE0V5hDoY6sfCHPvpl2Xnk7LXyAnVS3sUL7VD9
         70ymaFZhHt9GzyIPFOhZ9ZM3zGa7hFPxF3BmLf2sBCrp9TIbDGlcJdz4M8tHKmfQIToA
         WxrWUY6FZ/OBcs6hBVjqH++ySQJSiQswqWd0wiitrFAhv/TATNiWzL6IR9JqmDZ6KkpT
         zOA6oN4qw9deC898uigcSiQiTXFcfBZjgQqQsfemwvrJbHDPNL9iEV9HYdSMsb1k2BUr
         zrKsbxxUiFS27r+avVnWcgQcCtoUBWhH12EgTkJbRNcMcs9+aMCX0ueBE/klG7Wy3k3F
         RfqQ==
X-Gm-Message-State: ANoB5pml2RSsHgN86oBBAG3YauLs+VAMBXtBl6i5ibA3vveNknCAcINa
        vqts/xjBOZmBlPn9aF2/Z+c=
X-Google-Smtp-Source: AA0mqf7UJgdPd4BUn/uEbwTZdqKfI8L6J8nUK3uXEaa7odzb6UBilqbNmtt/Uj6H4wDYtK/+YNamhg==
X-Received: by 2002:a17:902:a508:b0:17c:7aaa:c67d with SMTP id s8-20020a170902a50800b0017c7aaac67dmr5225945plq.171.1668736260670;
        Thu, 17 Nov 2022 17:51:00 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-20.three.co.id. [180.214.232.20])
        by smtp.gmail.com with ESMTPSA id h15-20020aa796cf000000b00560bb4a57f7sm1865320pfq.179.2022.11.17.17.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 17:51:00 -0800 (PST)
Message-ID: <73ecf737-c523-b4ab-f11f-431bb5fb2c37@gmail.com>
Date:   Fri, 18 Nov 2022 08:50:54 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 2/9] Documentation: KVM: s390: Describe
 KVM_S390_MEMOP_F_CMPXCHG
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
References: <20221117221758.66326-1-scgl@linux.ibm.com>
 <20221117221758.66326-3-scgl@linux.ibm.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221117221758.66326-3-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/18/22 05:17, Janis Schoetterl-Glausch wrote:
> +For write accesses, the KVM_S390_MEMOP_F_CMPXCHG might be supported.
> +In this case, instead of doing an unconditional write, the access occurs only
> +if the target location contains the "size" byte long value pointed to by
> +"old_p". This is performed as an atomic cmpxchg. "size" must be a power of two
> +up to and including 16.
> +The value at the target location is written to the location "old_p" points to.
> +If the exchange did not take place because the target value doesn't match the
> +old value KVM_S390_MEMOP_R_NO_XCHG is returned.
> +The KVM_S390_MEMOP_F_CMPXCHG flag is supported if KVM_CAP_S390_MEM_OP_EXTENSION
> +has bit 1 (i.e. bit with value 2) set.
>  

Is KVM_S390_MEMOP_F_CMPXCHG supported with conditions (as you implied)?

-- 
An old man doll... just what I always wanted! - Clara

