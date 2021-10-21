Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9474365E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 17:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhJUPWp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 11:22:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38681 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231624AbhJUPWk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 11:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634829624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NOe3cFJFILZdz8eTftQ7v5VvvEiNDk+j+1cks9VzhR8=;
        b=gSUpt0qVyEqu5fMwP4yRL/fyocdkTnasCkqYpPipU1lBSu6OjX5hGTfWFw6YLaF3sc3dIn
        FjHW+TPS5nrxUfJy7jwX9MtsX8bb3KKafxfrsdSMTpI9hrPLk/TBPsZuNgAUDE0il1g9gO
        dvsU1bcoleZjNRMMjly5HQPxULi42Co=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-m_RcGpL6OaS7WhykrPEhXg-1; Thu, 21 Oct 2021 11:20:23 -0400
X-MC-Unique: m_RcGpL6OaS7WhykrPEhXg-1
Received: by mail-ed1-f72.google.com with SMTP id z1-20020a05640235c100b003dcf0fbfbd8so722651edc.6
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 08:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NOe3cFJFILZdz8eTftQ7v5VvvEiNDk+j+1cks9VzhR8=;
        b=u/tn+cVgYh91dMSiQL2jA+EsFJOsAKxILFgaLuOQoEZcAOwzWqcQQm4XD6WEzrZ5DH
         ePW2kRQN/+NF+MlaRXq+/QMvpMZDRgM5btI237aZJYO6vZZiFjnJ8mKJiJSTgBdTReQ/
         eoFZwvXvhmWWEb66hOjhh0988MKjy/ijb2TrIc+4CHMjib277r2SQ1VlW0980/gZuaaM
         abTez9XKMZIC/RiQ4rhxKQyMKupWKRXgXKL/lpaX4kgxOJktWnORSjywvs5asSYQc1m4
         fJ5rTXFkmXSvORrf/UjjjfqW+eaji9pxpxysaCmsdxkv7wLZm4ejSokq6n/gG9/eKe/L
         3Jiw==
X-Gm-Message-State: AOAM530zSNLb14ND1++PH0lKwF5Wj2Quw25eCU0ngayEX+OqPjIA94Oa
        kWpgUUQJDrqsL1KgTdSTD6rXR+Am51q8yUPpmOqlFuz125qXgwoc4RKoCivvlmLIpdVE6E+UrZq
        3EGPiQjAgZDP+Bg2qxNCJG9RnFShD
X-Received: by 2002:a17:906:2310:: with SMTP id l16mr8121390eja.118.1634829621441;
        Thu, 21 Oct 2021 08:20:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjeZqyJXsmAoXhDVP1zKKfZ0Y7fUe4znDsFRJP/2IiYcz3JF2glaBceal0TUeS55/ECM+NVA==
X-Received: by 2002:a17:906:2310:: with SMTP id l16mr8121368eja.118.1634829621264;
        Thu, 21 Oct 2021 08:20:21 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id a1sm3008008edu.43.2021.10.21.08.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 08:20:20 -0700 (PDT)
Message-ID: <811ec8ba-433e-b167-6a60-cf3b5ceabb63@redhat.com>
Date:   Thu, 21 Oct 2021 17:20:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [RFC 01/16] KVM: selftests: move vm_phy_pages_alloc() earlier in
 file
Content-Language: en-US
To:     Michael Roth <michael.roth@amd.com>,
        Mingwei Zhang <mizhang@google.com>
Cc:     linux-kselftest@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
 <20211005234459.430873-2-michael.roth@amd.com>
 <CAL715WK2toExGW7GGWGQyzhqBijMEhQfhamyb9_eZkrU=+LKnQ@mail.gmail.com>
 <20211021034529.gwv3hz5xhomtvnu7@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211021034529.gwv3hz5xhomtvnu7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 21/10/21 05:45, Michael Roth wrote:
>> Why move the function implementation? Maybe just adding a declaration
>> at the top of kvm_util.c should suffice.
> At least from working on other projects I'd gotten the impression that
> forward function declarations should be avoided if they can be solved by
> moving the function above the caller. Certainly don't mind taking your
> suggestion and dropping this patch if that's not the case here though.

I don't mind moving the code, so the patch is fine.

Paolo

