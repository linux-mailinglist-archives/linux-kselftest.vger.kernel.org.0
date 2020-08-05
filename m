Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B88F23CEE1
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Aug 2020 21:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgHETIN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Aug 2020 15:08:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30293 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728147AbgHES4u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Aug 2020 14:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596653782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hymn0Sfg1TJ19WBAjozBxwIK1aOHio4HHWImCGmRqUw=;
        b=DC2dgjyqrHtI8yFjA1OOHZqoBAQUWEujxddK7inq8eNMBc9DrNu83kJLUEJNbuv8NKCkjv
        pAwRCtMqviyD/dLW4kPzCsufXVOdwjH+2kgnmjOgsk1bHYSr+yxTT5V/U0KgBgC3wEibSJ
        zAjxh1rr9fN0zd85XBGt9fjrd5HgwaY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-TOzn69JPN5i8S5iNeSho6g-1; Wed, 05 Aug 2020 14:48:06 -0400
X-MC-Unique: TOzn69JPN5i8S5iNeSho6g-1
Received: by mail-wr1-f69.google.com with SMTP id w7so13904868wrt.9
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Aug 2020 11:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hymn0Sfg1TJ19WBAjozBxwIK1aOHio4HHWImCGmRqUw=;
        b=fN32GxoqjuQ7WBo71RxTMl+jzCHxWZFMiA8dJzBs0ODbb8fmy/D5NYOXichRSY1IVK
         ATIHueyS2eIAlm2fsTWsDXH6EMyZANSRXM8QptvGkj6qmOzgpV5pIvEu0soH7qvN2WKY
         fEXLbdlTpOYWY2ydHYNRua0jL2+aEGtq4AThRPe8xccfknG8GQNv8xJddPyXYbctO47+
         zBuNKiXInNFl5BnL4ZQ7qA13HobI4oybbxobKM7KOq6Po+KCbt4dcldBdv5BgcqNz/Zy
         X3NzcMbeHfrH8r3qQscz+6tO7OaJVjZgOZ5cXcBpE0a2IcfGpp8jxORKgpuLFAQroVWF
         Sv6Q==
X-Gm-Message-State: AOAM531T+PEH6pgi4rVWA9mfsW3vE76EC94T2mB6dKuG4ZQpntu6yvKy
        cbsTdfwUTkvx0FhIbTM5zMV0OHPPauz6D4KuEcZL95EqbJa0QXyDFNonhYVXH3I8MJ2jhkY6iAn
        D+63G0YCT7Ue8CuW36NBhrPdiJ4/4
X-Received: by 2002:a1c:286:: with SMTP id 128mr4206656wmc.37.1596653284954;
        Wed, 05 Aug 2020 11:48:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMFtqWVfa9ps/xQ0YYj/MHXx500Q/j+ugxOTprbSKK6roqR5QcQxjQa6u8ZT4SfEKfWTMCUg==
X-Received: by 2002:a1c:286:: with SMTP id 128mr4206635wmc.37.1596653284682;
        Wed, 05 Aug 2020 11:48:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20? ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
        by smtp.gmail.com with ESMTPSA id l18sm3776157wrm.52.2020.08.05.11.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 11:48:03 -0700 (PDT)
Subject: Re: [PATCH 1/1] kvm: mmu: zap pages when zapping only parent
To:     Ben Gardon <bgardon@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Peter Shier <pshier@google.com>
References: <20200727203324.2614917-1-bgardon@google.com>
 <20200804211444.GA31916@linux.intel.com>
 <CANgfPd9kbnzW+eaBi+dwA1+E2VXEd6JfN4n2PstWrmh4VPRFjA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cf54ab19-611c-c975-8080-b49e13c966f3@redhat.com>
Date:   Wed, 5 Aug 2020 20:48:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CANgfPd9kbnzW+eaBi+dwA1+E2VXEd6JfN4n2PstWrmh4VPRFjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 05/08/20 19:10, Ben Gardon wrote:
>>
>> Alternatively, what about moving this logic into mmu_page_zap_pte()?  That
>> can be done with a little massaging of FNAME(invlpg) and would avoid what is
>> effectively redundant checks on is_shadow_present_pte() and is_last_spte().
>> Patches attached and somewhat tested.
> That seems like a good change to me and the patches you attached look
> good to me. I'm happy to review them more if you want to send them to
> the mailing list as their own series. Thanks for putting them
> together.
> 

Thanks, I'll wait for that.

Paolo

