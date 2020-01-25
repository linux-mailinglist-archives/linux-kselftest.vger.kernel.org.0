Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1FF149432
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2020 10:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgAYJj1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Jan 2020 04:39:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59963 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725996AbgAYJj1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Jan 2020 04:39:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579945166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tSakUTi8biBaDO4JGr8rcWBisLF05BHEM8+vn5mJmsg=;
        b=Xo2etNGO3GaY/PnoEg9FHfsXYXe8f37Tx8EB6OSx/wkb4U7XZcDSbCl0dWt0yuXC0qUJud
        aaIJqFIeGRztVJR8b8N7aAU2Fc8R8b4ufSJO8ULOVgO78/jCdhUyoWdtVcKPYmT1tCHaxz
        u0yEe7Rms66XHZ20ls0hj3fwjwjZxYI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-gKY4_ks-Md25NF-5v39P9A-1; Sat, 25 Jan 2020 04:39:24 -0500
X-MC-Unique: gKY4_ks-Md25NF-5v39P9A-1
Received: by mail-wr1-f71.google.com with SMTP id w6so2747782wrm.16
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Jan 2020 01:39:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tSakUTi8biBaDO4JGr8rcWBisLF05BHEM8+vn5mJmsg=;
        b=CWbVUGJWH93Eg9BHoImLMHR+lPk32+WFTaXybbv0dc5/gmfKfAYPlEfriu0kGPz5MR
         Ea4A6YG+/tVunY4TTuCeIvUrikn/tkS4FZ7zIsXW5KUOO9jw83Dmc+w6E269s9W0dtGN
         yP1Wrn27QQRcqZasEWJTlIhNp81yK1zzQJnfvT1B98lYyXxX6m5V54rZmqKxM8k5Cc4X
         mRYTZGLRAP8Rk+0WC1k+MI6PSlO54r5GfiLQyKuhSgcCrXX6SFO0PRU5XHhPXADqkpvG
         RFxV1l+V9q7RqJpyB+3lGEIMz64hRwekxSFAhUKcoBmwOgpxkQ+F68b1fVyztrUUX1Ii
         A1oA==
X-Gm-Message-State: APjAAAXWwCGUkKkFzvER9MSttNdPn1uHDEUoeW3c5ymYVaMv6D0xmy8u
        nTxYjzV+AqwUK6iGO52ly3xuxXlIGBzfrBgkK4clwW22aDY2wiaormCAI0ktXOox62TUdGWEcXs
        GBmInEZA4PqtmVUEZXnYbahiQjtMe
X-Received: by 2002:a7b:c450:: with SMTP id l16mr3501972wmi.166.1579945163413;
        Sat, 25 Jan 2020 01:39:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqxXHzToOxP0s/Db+4GnkirH83ip6eSuf/6sQnScHphAbo+jbh853oEfOBR31PKwD5KTWSeosQ==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr3501951wmi.166.1579945163182;
        Sat, 25 Jan 2020 01:39:23 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id f1sm11276551wro.85.2020.01.25.01.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2020 01:39:22 -0800 (PST)
Subject: Re: [PATCH v4 07/10] KVM: selftests: Support multiple vCPUs in demand
 paging test
To:     Andrew Jones <drjones@redhat.com>, Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>
References: <20200123180436.99487-1-bgardon@google.com>
 <20200123180436.99487-8-bgardon@google.com>
 <20200124104943.6abkjzegmewnoeiv@kamzik.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <df86f0da-366d-bb20-d1d0-125697c660a8@redhat.com>
Date:   Sat, 25 Jan 2020 10:39:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200124104943.6abkjzegmewnoeiv@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 24/01/20 11:49, Andrew Jones wrote:
>> +
>> +	/*
>> +	 * Reserve twice the ammount of memory needed to map the test region and
>> +	 * the page table / stacks region, at 4k, for page tables. Do the
>> +	 * calculation with 4K page size: the smallest of all archs. (e.g., 64K
>> +	 * page size guest will need even less memory for page tables).
>> +	 */
>> +	pages += (2 * pages) / PTES_PER_4K_PT;
>> +	pages += ((2 * vcpus * vcpu_memory_bytes) >> PAGE_SHIFT_4K) /
>> +		 PTES_PER_4K_PT;
> pages needs to be rounded up to the next multiple of 16 in order for this
> to work on aarch64 machines with 64k pages.

I think this is best done with a generic function that does the rounding
and an arch-specific function that returns the page size.  Can you send
a patch to implement this?

Thanks,

Paolo

