Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A495720EC4
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 10:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236936AbjFCI2w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Jun 2023 04:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjFCI2v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Jun 2023 04:28:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416BCD3
        for <linux-kselftest@vger.kernel.org>; Sat,  3 Jun 2023 01:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685780887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l/3htB5uc/OVmwcp2TUB+HB2hf7Xjfr9dm8bokABVSg=;
        b=DjhEuySenbHHXvdNJ0ijglllZ5QgHSNeCJ9KCvJRnlheKufJNgETpwPETYEF3DXISnb/8t
        1cI0es335umTuWlLCHjVyBMfEsKQTdCQOvxAQbL9t8lAywSwzA5Si4XnST7CYOTPnCDhb8
        faPtdRFjxH08TSOodmEudNZnJzJ5JQg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-pTKc4G35NSSdIvqV7VKclQ-1; Sat, 03 Jun 2023 04:28:06 -0400
X-MC-Unique: pTKc4G35NSSdIvqV7VKclQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30479b764f9so1435889f8f.0
        for <linux-kselftest@vger.kernel.org>; Sat, 03 Jun 2023 01:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685780885; x=1688372885;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/3htB5uc/OVmwcp2TUB+HB2hf7Xjfr9dm8bokABVSg=;
        b=HZFSPdND0RQKdgjSB0scN2y6XZi0DUxlmWR4KOZQSzFZz4oUow/ps+nkUsS653ZIwz
         gF7ILmSLQVpQeaVZ/wBpoefrQ40lT17qINiSgRfnPzKhtOhYdD51nuKALh0XfM704VVJ
         A8oDTMBVHPidb8HACFiRe5cal3I+DHLeOuYsaIwaPSlzGogSbjh56OxCIsgb9pR4M2rd
         3nLnmxZQ/wtUPM251CZTBlVtzrxMIvGKBv0jw8C/oP1mLDGrPSKCredk0w1bw7J9k+i7
         sGMnIa2waR9JV5aswHsU2/DLaGIijktkY1VXbPLzfa1JGLqlrBlcE7BoTEVwimFTphnS
         CK0A==
X-Gm-Message-State: AC+VfDz6KbPWwZcLsAZ8bleuk7KZBRuW84eqD1MqgoE2OI0dIpa5aZN9
        X5OW7Gelsl+5ZpXudg+F90rcZMxMo9j8nA1vWg77YQhqftb/ip7pd8vpaFM0S2f5iORDc8FHH7n
        6t8GSzSBT5mZYOr0sOcdUrBSrkTXy
X-Received: by 2002:a7b:c3cb:0:b0:3f6:76e:6049 with SMTP id t11-20020a7bc3cb000000b003f6076e6049mr3156161wmj.1.1685780885015;
        Sat, 03 Jun 2023 01:28:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4WNohNnuxjyqTy5UlAW/2/uI+WGbgepGRvlLf8YeXkBXpHZhu3ExWgAP7lG3XWOQUoZ4xnig==
X-Received: by 2002:a7b:c3cb:0:b0:3f6:76e:6049 with SMTP id t11-20020a7bc3cb000000b003f6076e6049mr3156145wmj.1.1685780884585;
        Sat, 03 Jun 2023 01:28:04 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451? (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de. [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
        by smtp.gmail.com with ESMTPSA id n24-20020a7bc5d8000000b003f17848673fsm4295963wmk.27.2023.06.03.01.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Jun 2023 01:27:58 -0700 (PDT)
Message-ID: <a4fbc191-9acb-5db8-a375-96c0c1ba3fcd@redhat.com>
Date:   Sat, 3 Jun 2023 10:27:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 11/12] selftests/mm: fix missing UFFDIO_CONTINUE_MODE_WP
 and similar build failures
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-12-jhubbard@nvidia.com>
 <7a999b80-e266-2b7e-f198-869b1ac7cde7@redhat.com>
 <993773ab-7f5b-241f-b532-ee79a03b371f@nvidia.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <993773ab-7f5b-241f-b532-ee79a03b371f@nvidia.com>
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

On 03.06.23 00:20, John Hubbard wrote:
> On 6/2/23 03:23, David Hildenbrand wrote:
> ...
>> Unfortunately, that seems to be the ugly way to handle this because
>> including the in-tree headers seems to not work and I yet haven't
>> figured out why (there were some changes back and forth so I lost track).
> 
> Yes, ugly, and based on Muhammad's response, I plan on dropping this patch
> entirely, in fact.

Ah, finally I know why it sometimes worked and sometimes didn't ... yes, 
let's document that somehow.

Maybe we can even warn from the Makefile when the in-tree headers are 
not installed yet?

-- 
Cheers,

David / dhildenb

