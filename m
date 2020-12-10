Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F13B2D5A7C
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Dec 2020 13:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbgLJMXk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 07:23:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23728 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729666AbgLJMXe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 07:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607602928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7PSrzA8rIkZ91gYxwlJNdk5yQ9KUFigi9bQ/KRmwMkM=;
        b=JO0uVZism5S7+vnQuEfo5UV3rO3rhFVCYs/dOHzHEDv0Q0vxl9n/KN2jw3n45jkBUQb94I
        TJ4zW7LT2pwflkyCBQAsrGFALXI1hlNNRY9QfPJrR3UOXfJicktvEFA9TFaKlbKt2Xx+sC
        quLWNh1brjNVeTYxEsbPD67OJIsQSAM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-04VbyAOuMbyKHvgWUsoUCg-1; Thu, 10 Dec 2020 07:22:06 -0500
X-MC-Unique: 04VbyAOuMbyKHvgWUsoUCg-1
Received: by mail-ed1-f70.google.com with SMTP id l33so2364164ede.1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 04:22:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7PSrzA8rIkZ91gYxwlJNdk5yQ9KUFigi9bQ/KRmwMkM=;
        b=P2MigAAvU8Mt02vnedePZ8KQ4IgaslnR0pN643m3+w6hBEPT3s6xojmCJkhqVDv5LS
         sAwU6A0DaUvnS9J4MJNRIUfbg0nVHYLigpoXnSaOemUpDpatlnxce8cDHIPwtLLr0zDc
         G4nFMVvfLCp/zNlSIbf31P4S98BDfcXP7QA4X5Y/Ns+8EmrUzmyujSNoB9QAWeICMoK2
         3bXDU8ojZ0Mpq1DUnOmfZEkaBA0NHCLjK6hPDNOD5YUWBzRvxmPxkli8LrtkFzvkW0+j
         a/uoR0oFWq5jnvNC9iPiF2UWHliwA6wpaWuYJgw1YIg+Rq7MRX34BD3nIj2lLobvbDa6
         G2Aw==
X-Gm-Message-State: AOAM532kpOHx8O76VthZJ3XbCBQSKpyBGYmv37kByXaz63jzEmn1cFJW
        4ifUNeXMMK/ehprjmGZAPfs+aN7XHUZURLzPXeth8ouTifFCQp4jIo5eWNQ80Xy61K2eo135ThD
        YC/9Jskat4LEpmeHNt5KEWiPPgw5t
X-Received: by 2002:aa7:cf85:: with SMTP id z5mr6509213edx.274.1607602925125;
        Thu, 10 Dec 2020 04:22:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybequ2MuYAvUJlcvYBoDwmZDe57QoKmulE84b6L8d93gCq/hTPU3F6HevqVt9BG7Kzyoq87w==
X-Received: by 2002:aa7:cf85:: with SMTP id z5mr6509198edx.274.1607602924980;
        Thu, 10 Dec 2020 04:22:04 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id h15sm4492763ejq.29.2020.12.10.04.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 04:22:04 -0800 (PST)
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kvm@vger.kernel.org
References: <20201203171118.372391-1-mlevitsk@redhat.com>
 <20201203171118.372391-2-mlevitsk@redhat.com>
 <87a6uq9abf.fsf@nanos.tec.linutronix.de>
 <1dbbeefc7c76c259b55582468ccd3aab35a6de60.camel@redhat.com>
 <87im9dlpsw.fsf@vitty.brq.redhat.com>
 <875z5d5x9m.fsf@nanos.tec.linutronix.de>
 <b6e0656b-4e3f-cf47-5ec9-eead44b2f2e9@redhat.com>
 <20201210121417.GN2414@hirez.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fe3e4637-b74b-864a-9d2f-c4f2d9450f2e@redhat.com>
Date:   Thu, 10 Dec 2020 13:22:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201210121417.GN2414@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/12/20 13:14, Peter Zijlstra wrote:
> On Thu, Dec 10, 2020 at 12:42:36PM +0100, Paolo Bonzini wrote:
>> On 07/12/20 18:41, Thomas Gleixner wrote:
>>> Right this happens still occasionally, but for quite some time this is
>>> 100% firmware sillyness and not a fundamental property of the hardware
>>> anymore.
>>
>> It's still a fundamental property of old hardware.  Last time I tried to
>> kill support for processors earlier than Core 2, I had to revert it. That's
>> older than Nehalem.
> 
> Core2 doesn't use TSC for timekeeping anyway. KVM shouldn't either.

On Core2, KVM guests pass TSC through kvmclock in order to get something 
usable and not incredibly slow.

Paolo

