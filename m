Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076BF4366A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 17:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhJUPpn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 11:45:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59301 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231770AbhJUPpm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 11:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634831006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wrRcdVxpJS7I9scrv7ojtxkuOUqX9VRgc3hJ9YIuX40=;
        b=fvlBwZ4xNPbg/x3NgJfdRBchdNC7u0oHzVEjZM18YbTAluLQ1JP18KUTFjUAOqyYB0UcpC
        kohDMK6yoTPABgA8tKQ8QsTPrh7oL9MG3ldRBbBoSyN4qhJS58o5cuQ8X3L5rIRyn9dr8B
        ZwLmCi3vZFZP7oK0HFRtqrmYJb6We+w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-TLIfL1SSNWKJAuPx001hJw-1; Thu, 21 Oct 2021 11:43:25 -0400
X-MC-Unique: TLIfL1SSNWKJAuPx001hJw-1
Received: by mail-ed1-f69.google.com with SMTP id p20-20020a50cd94000000b003db23619472so745297edi.19
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 08:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wrRcdVxpJS7I9scrv7ojtxkuOUqX9VRgc3hJ9YIuX40=;
        b=Sl2wJ/XkFVSvR/gYxuHoTDz0+BfZJYmww3pplUKy4czdkDPAdttpjzUdQBWZ0w6RSs
         74B+FP4aTojS35N+uO5JoAskO8Mb2rM7WgJ3RYTx+rmAyPF4TEWpLQ2om35xTVHWkSSh
         lipJhauivIjGRcjPTKj02oFSHfSAnuYMNx35P272bLWp3yGK5K4Otk1rzM9xcUL8LRcd
         6QaTtfmUelcZ5MSp+o05JQqtgZK0Dv8nIybQO8bBmUy/gBf+B5xmE9RqfmkbBy1YDfWa
         MVCxDKvOYi5oRE+SxQTtgkny+geDmV0Y8kPrdTAYvmGPsfiisQsbNl/945sxt86T8Xqr
         kgow==
X-Gm-Message-State: AOAM531KvFcuiNLBfwxEzNGtmCkPNi1H22pxmUsz5LaFKWT407x4RNvC
        /dmAIFXdIsUueDovrSVOtjSes/dsZ6TugW/qDnRyeTnzKs4kjKDCX2b+OKss/H4sexLh0rteN4O
        vix15sOQxdSzRjwRvFf4WtW2/lcIc
X-Received: by 2002:a50:e14c:: with SMTP id i12mr8504893edl.125.1634831003866;
        Thu, 21 Oct 2021 08:43:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDPWN/en5wVhnU7VDIOTI9urEVpR9kawe7unnx2IoWCOSX4QAfTGwzdlyzb3yZgI4S+oNiQw==
X-Received: by 2002:a50:e14c:: with SMTP id i12mr8504826edl.125.1634831003495;
        Thu, 21 Oct 2021 08:43:23 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id x22sm3063222edv.14.2021.10.21.08.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 08:43:22 -0700 (PDT)
Message-ID: <850e87f4-ad0b-59d7-6e31-b3965b6b6492@redhat.com>
Date:   Thu, 21 Oct 2021 17:43:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [RFC 06/16] KVM: selftests: add library for creating/interacting
 with SEV guests
Content-Language: en-US
To:     Michael Roth <michael.roth@amd.com>, Marc Orr <marcorr@google.com>
Cc:     linux-kselftest@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Nathan Tempelman <natet@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Mingwei Zhang <mizhang@google.com>,
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
 <20211006203710.13326-1-michael.roth@amd.com>
 <CAA03e5EmnbpKOwfNJUV7fog-7UpJJNpu7mQYmCODpk=tYfXxig@mail.gmail.com>
 <20211012011537.q7dwebcistxddyyj@amd.com>
 <20211012125536.qpewvk6cou3mxya7@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211012125536.qpewvk6cou3mxya7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/10/21 14:55, Michael Roth wrote:
> One more I should mention:
> 
> 4) After encryption, the page table is no longer usable for translations by
>     stuff like addr_gva2gpa(), so tests would either need to be
>     audited/updated to do these translations upfront and only rely on
>     cached/stored values thereafter, or perhaps a "shadow" copy could be
>     maintained by kvm_util so the translations will continue to work
>     after encryption.

Yeah, this is a big one.  Considering that a lot of the selftests are 
for specific bugs, the benefit in running them with SEV is relatively 
low.  That said, there could be some simple tests where it makes sense, 
so it'd be nice to plan a little ahead so that it isn't _too_ difficult.

Paolo

