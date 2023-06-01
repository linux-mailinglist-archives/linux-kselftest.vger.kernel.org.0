Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA46F7194E5
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 09:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjFAH7r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 03:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjFAH7Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 03:59:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15771982
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Jun 2023 00:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685605925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UGN0oJNZes7Qo6ZcpteciDRTsS0uKCd+DRQnkDayhbo=;
        b=WGwTAN+PYuyvGfZWv9W0neWjZHQtsMbUd8s+IKfJSHbZekPRGRTRUT5PnDuhB6WWLqhK3O
        +u9l8p4CameARnwHpZoJAhmjY3LZSBcqGpRgveRFuTbcBjW3YQsXMckrR1jBoypJ3f2/5b
        C/SX03HtT8qx505hC0KCmUIEEnojWLg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-uLGOweFGPA63p_1IQYmmYQ-1; Thu, 01 Jun 2023 03:52:03 -0400
X-MC-Unique: uLGOweFGPA63p_1IQYmmYQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f41a04a297so3708455e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Jun 2023 00:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685605922; x=1688197922;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UGN0oJNZes7Qo6ZcpteciDRTsS0uKCd+DRQnkDayhbo=;
        b=C9Z6X6nDyR/Q1DcPqWRc7FuRydtnoCQZYfrXdA3VEIrf9qIAnYYiXR3uHIiNgZjpud
         KILUj1Rpw60A3CQOVnBNJ5ATNePsV/GdJr3Qv+6EODXTMYNTQCNXx+rivXdTslAf5t2u
         M9lKjE8eB+rmFzo3UT/OcdEPBqRexGbLYfJjK5BZdaF6NFqcL9Lm0a1WhLdU2KTAYz+h
         +Bbt2JtJqYfl1uWl5aO0pCnt4r8mZTPKp5G2+hrR/s/M+v3ymPj/FAwi+fjDAcEGaSdl
         g+4+h92hNREqbWOBiB/QvTiDWI4tB52MP3V78P9qA8+HM/6ViQBM4Y+avVT7DOKCc3nI
         SjrA==
X-Gm-Message-State: AC+VfDwArVs4Z6tFbM4xN8dvUWEJqAImeLNURjKrpJJIGXOjxcDffwBu
        eNQDE6zEp5fYRG6AGx6Rfi6uf7tnvRhI7GB+XpClxS7t0zj/Q6VpXvJLrO6Ls2h5h3Ze/Z7cvhz
        q6ByUhqKi+JI8diaZ1nivPSGwGC4/3jd6Ukqz
X-Received: by 2002:a05:600c:2252:b0:3f6:f29:7b41 with SMTP id a18-20020a05600c225200b003f60f297b41mr1285388wmm.7.1685605922820;
        Thu, 01 Jun 2023 00:52:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6pqppsA7O9z8geVps55kh02RQkezTsYAVSQPRyQwzdBB9ynfyxZUJOB68G0Jnr3KhTLwFlsg==
X-Received: by 2002:a05:600c:2252:b0:3f6:f29:7b41 with SMTP id a18-20020a05600c225200b003f60f297b41mr1285375wmm.7.1685605922505;
        Thu, 01 Jun 2023 00:52:02 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id w8-20020a1cf608000000b003f603b8eb5asm1338590wmc.7.2023.06.01.00.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 00:52:02 -0700 (PDT)
Message-ID: <4dfd0f47-e1f7-1e9f-65e0-ee4881495be3@redhat.com>
Date:   Thu, 1 Jun 2023 09:52:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>
References: <20230519102723.185721-1-david@redhat.com>
 <20230519102723.185721-2-david@redhat.com>
 <e49b5642-014b-4a95-9ba8-738bfd02b2ea@lucifer.local>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/3] selftests/mm: factor out detection of hugetlb page
 sizes into vm_util
In-Reply-To: <e49b5642-014b-4a95-9ba8-738bfd02b2ea@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 28.05.23 16:49, Lorenzo Stoakes wrote:
> On Fri, May 19, 2023 at 12:27:21PM +0200, David Hildenbrand wrote:
>> Let's factor detection out into vm_util, to be reused by a new test.
>>
> 
> Bit of a nit as it's hardly vitally important, but perhaps worth mentioning
> that you also refactor the function to accept any array (this is a
> requirement rather than simply refactoring a thing but still :)

Well, the function used to, and still does accept an array. It's just a 
more human-friendly way of expressing that.

If I have to resend the whole patchset, I can add a note "While at it, 
make the function accept an array instead of a raw pointer.".

[...]

> 
> Looks good to me,
> 
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
> 

Thanks!

-- 
Thanks,

David / dhildenb

