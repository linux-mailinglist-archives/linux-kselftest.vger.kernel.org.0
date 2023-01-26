Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9C267CACD
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jan 2023 13:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbjAZMTv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Jan 2023 07:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237157AbjAZMTo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Jan 2023 07:19:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897E33251A
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 04:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674735526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I9Pg4QUbNxEbqQg5rlyFX3DNaClmlULemPiPESaUQkE=;
        b=GNeS5sbPyHCBktL6Bz9x2qI6aJysIMXM3wCbRzTmNyD8X+20ljEI4kQsoGPK9SO/iyjaJ0
        OzCMpDLD9XYmQGlWZnBAm3KBjiTwxNa3H/N7KZ1EIjVzZJwy7gH/tMdNNq8ipTEaNJP+uF
        uuRdFTLu2FAUQ8qLA/5bO4JosZiHNJE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-501-KjpDtYDgPOuQ2y2pCDcIDg-1; Thu, 26 Jan 2023 07:18:45 -0500
X-MC-Unique: KjpDtYDgPOuQ2y2pCDcIDg-1
Received: by mail-qt1-f197.google.com with SMTP id i1-20020ac87641000000b003b7fa8c92bcso644037qtr.15
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 04:18:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9Pg4QUbNxEbqQg5rlyFX3DNaClmlULemPiPESaUQkE=;
        b=gm5kHvvLxKcwisO5D7It5dSSBrdx0jTJFRksBxMElsiduTCPKO9LhtssHBnBdoqOyu
         fjyEBkjDnItXbB6mjmmoOn0bS6VWAA93qips6aViP+rfRku++O7aqjza6/3diMfoDo1g
         UK2Unp3XIZfYdrTujR1TpQJhE/WJPeRbOgn5b7kKR4976xHWqH8jk/RDk1/b2r5Ohh73
         kj0cN0q2vR4dAU7jFD6ugWPHgn7o/qaAixMla+0XI6Qgf+yI0E+WEJOaIs6/S0NUwDL4
         2zS3HGhiywrknptLhEptJT2UyrmqL8K6yzEMNrEK60rE521I240GUtbaFg9H30F9/vHM
         NpTg==
X-Gm-Message-State: AO0yUKWSAB8HQ2TcZE775UQu5ND/DlcPEtkAF2vsG4mkNATfTW3sYHI1
        W3tlID9GkrUO1eogUgODqHFI0fG9ESyB/mzWO4qVEakjK1nZKWy/j0/p9vZnEh/+l1dqJk5kxta
        ZZ80yFeRACT9v2rMfCUycn7STRQEf
X-Received: by 2002:a05:622a:1b9f:b0:3b7:fb43:e745 with SMTP id bp31-20020a05622a1b9f00b003b7fb43e745mr12125491qtb.39.1674735524643;
        Thu, 26 Jan 2023 04:18:44 -0800 (PST)
X-Google-Smtp-Source: AK7set/LpzPPRNyX46aBCgsS1xFZrPlr8YJl6tz+anqlXRntKC1x8THXiiUIltDWpqrLib/RmsI1nQ==
X-Received: by 2002:a05:622a:1b9f:b0:3b7:fb43:e745 with SMTP id bp31-20020a05622a1b9f00b003b7fb43e745mr12125469qtb.39.1674735524334;
        Thu, 26 Jan 2023 04:18:44 -0800 (PST)
Received: from [192.168.0.2] (ip-109-43-177-174.web.vodafone.de. [109.43.177.174])
        by smtp.gmail.com with ESMTPSA id b17-20020ac84f11000000b0039a610a04b1sm632086qte.37.2023.01.26.04.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 04:18:43 -0800 (PST)
Message-ID: <6594a21f-6372-0b69-3bb3-6ed1b1387e6e@redhat.com>
Date:   Thu, 26 Jan 2023 13:18:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v6 10/14] KVM: s390: Refactor absolute vm mem_op function
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
References: <20230125212608.1860251-1-scgl@linux.ibm.com>
 <20230125212608.1860251-11-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230125212608.1860251-11-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 25/01/2023 22.26, Janis Schoetterl-Glausch wrote:
> Remove code duplication with regards to the CHECK_ONLY flag.
> Decrease the number of indents.
> No functional change indented.
> 
> Suggested-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
> 
> 
> Cosmetic only, can be dropped.

I'm torn between unnecessary-code-churn and 
nice-to-get-rid-of-one-indentation-level here ... anyway, patch looks sane 
to me, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>

