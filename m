Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB184C65C8
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Feb 2022 10:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbiB1Jib (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Feb 2022 04:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiB1Jia (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Feb 2022 04:38:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0D3E5FB8
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Feb 2022 01:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646041070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O6xuI99PpvDDOODhlbvd9Uc1T3uVIjTSRXmL6hAEYXs=;
        b=b0Oecg70y75kS+Rhvfp4wLjXiM+jgIOAQeKQXWFAUHIE2q9XN8JltyOqxuwZhLhIYZ5hwD
        uJPg/dUDOCNjNr2pwJfSfeCrF/nq0XKJmJ4fY26+P8EKJfOcyX9S6OTg9mtRO7oA6bL6UD
        M6BpBjlMFiRoW4pwC1xIueCbGUTp2uI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-WLspIE50Of-ME7KBbPAuBg-1; Mon, 28 Feb 2022 04:37:48 -0500
X-MC-Unique: WLspIE50Of-ME7KBbPAuBg-1
Received: by mail-wr1-f72.google.com with SMTP id v24-20020adf8b58000000b001eda5c5cf95so1817776wra.18
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Feb 2022 01:37:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=O6xuI99PpvDDOODhlbvd9Uc1T3uVIjTSRXmL6hAEYXs=;
        b=VCw52oN2cfB+6Z/MWnCKIQ2M3zJaIXAniMJwmE3npsUtbN7Ld9lU2yj74HC9Ee7VOg
         Oh49h13//uCTzaFtBa5Y+JYV7TMtfEDS5dHqFNltQjiyt5ndKuKZy0nITez2Iq5Ub15V
         X/y1fkw/ZQL2pslm5aOHWqUse83csvo2+4zAiXuJH0D5kmoLASjnQjkF/8xZxqZjsPk3
         e9woFOmGsIug/D0ihn4VVC6S5QeS6AyjIwJmRt460pnkz7z2e7vQ3/dk0qoI9Yk3srOo
         L2tKfLHHc3jHik4W1nJqW/rPy7acs8x+c8/0PSwXPSbSG3U6hQrFPETqAPKzpwF2N9ZB
         6M/g==
X-Gm-Message-State: AOAM533Su4xgpRRlx83CAnjpR5avXtSDXRlay35doqvkBm/Xtx71qBwx
        IsyVRwMoqzXr++cJB7vwluJucNDurquZwL5gGmG36QIlGZrnNmhVvOazA6vgIBcBRy9GGWr1wKr
        0qf77z4uQRUiN87wMbU5M6cnOYUp2
X-Received: by 2002:a05:600c:68b:b0:380:d3e3:5bac with SMTP id a11-20020a05600c068b00b00380d3e35bacmr12725268wmn.127.1646041067484;
        Mon, 28 Feb 2022 01:37:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxhW7y7soOEk6w3DJYoM93NX0XSqq5ao6PuHL/oQN6/HEeVH+4iT1S317aR4vg+JubPxFR9UQ==
X-Received: by 2002:a05:600c:68b:b0:380:d3e3:5bac with SMTP id a11-20020a05600c068b00b00380d3e35bacmr12725255wmn.127.1646041067304;
        Mon, 28 Feb 2022 01:37:47 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:9700:f1d:e242:33b4:67f? (p200300cbc70297000f1de24233b4067f.dip0.t-ipconnect.de. [2003:cb:c702:9700:f1d:e242:33b4:67f])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5091000000b001edb61b2687sm14108652wrt.63.2022.02.28.01.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 01:37:46 -0800 (PST)
Message-ID: <3b7c068b-ac7e-62fc-f0cd-a8dbf8642876@redhat.com>
Date:   Mon, 28 Feb 2022 10:37:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3] selftests: vm: Add test for Soft-Dirty PTE bit
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     kernel@collabora.com, kernelci@groups.io,
        Will Deacon <will@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20220224212335.3045905-1-usama.anjum@collabora.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220224212335.3045905-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 24.02.22 22:23, Muhammad Usama Anjum wrote:
> This introduces three tests:
> 1) Sanity check soft dirty basic semantics: allocate area, clean, dirty,
> check if the SD bit flipped.
> 2) Check VMA reuse: validate the VM_SOFTDIRTY usage
> 3) Check soft-dirty on huge pages
> 
> This was motivated by Will Deacon's fix commit 912efa17e512 ("mm: proc:
> Invalidate TLB after clearing soft-dirty page state"). I was tracking the
> same issue that he fixed, and this test would have caught it.
> 

A note that madv_populate.c already contains some SOFTDIRTY tests
regarding MADV_POPULATE. Eventually we want to factor out
softdirty/pagemap handling+checks for easier reuse.


-- 
Thanks,

David / dhildenb

