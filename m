Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77B42149430
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2020 10:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgAYJho (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Jan 2020 04:37:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57805 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725945AbgAYJho (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Jan 2020 04:37:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579945062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6WE2fbQswzs+SJz5n1omfDubg+SoDSvUx44H2FyK3h4=;
        b=YHlrvoVSnxbsaOAXtoBUspQU22IGyzV2lf2kYoJLzL/hZAS+GL7Trox/2kG0yWMcVj/iGw
        BgH0ykirM8ghQ31NzdW4dNYs+v90LmhGipO1mw5tZD51cGHE14EZ9Xbv5ld0xI5j1Cy5ps
        LaXDijNt7h2Zc/Zosa0dGi3uCCArhLg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-hIsc8Tv_P_KAWSKtRP6Iqw-1; Sat, 25 Jan 2020 04:37:40 -0500
X-MC-Unique: hIsc8Tv_P_KAWSKtRP6Iqw-1
Received: by mail-wr1-f70.google.com with SMTP id f17so2756931wrt.19
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Jan 2020 01:37:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6WE2fbQswzs+SJz5n1omfDubg+SoDSvUx44H2FyK3h4=;
        b=iGWSg7WApdM58HJbKQkwPF2vPEqLAkb6eoveQ6SJ430RjGXiaiMgYvk92u+i0JzFQG
         ZlEKIiHEpqRPaxMGz2/lvaFtWp2Fl+4dycEKqYiFKwYZ5DXw3d6Xr/u1kXT4L70WiA0w
         aWQk+z4GP+LXBV1/pEBBiPaonVW6nkeXtUyBBSAoS3GNCpwNEH+CtTN7tJqku64/hNxE
         4cW+CoKmOkQC1iBpn15sZWZfp06hKjPHnvRhibdbEFlW3zwkTZp7+/w9cR/HqxfuIB6s
         ji2PaKadUjbsWtFRfphg2rx1kdEUjAv/aipPzj4DXLU1h+OqpjOdQjPPNxDXy9K1Z5Wz
         GBcw==
X-Gm-Message-State: APjAAAX8EVnATQ1R86349ZKOHIMP9eEb75uKUdBcyWt1PHgysUfWaakq
        7XJYLpze16y9mMNq927KxLlPyIvMHDFftuiWFKT8YvXt7o2f/NaB37SVzO5gIXUfLUHbtPcODj2
        E4BUMFBwgv1GqHIaUq0FcYmO/Ur+s
X-Received: by 2002:adf:fc03:: with SMTP id i3mr9643020wrr.306.1579945059511;
        Sat, 25 Jan 2020 01:37:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqzADoueJweyRIZiSjc1N6dPo0jQ7I4gMZv5B4n3ZCIMUKiG1FLlWJFwmcqNLCFzWRZfPX0SfA==
X-Received: by 2002:adf:fc03:: with SMTP id i3mr9643007wrr.306.1579945059285;
        Sat, 25 Jan 2020 01:37:39 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id o1sm10988700wrn.84.2020.01.25.01.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2020 01:37:38 -0800 (PST)
Subject: Re: [PATCH v4 09/10] KVM: selftests: Stop memslot creation in KVM
 internal memslot region
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>
References: <20200123180436.99487-1-bgardon@google.com>
 <20200123180436.99487-10-bgardon@google.com>
 <92042648-e43a-d996-dc38-aded106b976b@redhat.com>
 <CANgfPd8jpUykwrOnToXx+zhJOJvnWvxhZPSKhAwST=wwYdtA3A@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6812a36c-7de6-c0c9-a2f3-5f9e02db6621@redhat.com>
Date:   Sat, 25 Jan 2020 10:37:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CANgfPd8jpUykwrOnToXx+zhJOJvnWvxhZPSKhAwST=wwYdtA3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 24/01/20 19:41, Ben Gardon wrote:
> On Fri, Jan 24, 2020 at 12:58 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 23/01/20 19:04, Ben Gardon wrote:
>>> KVM creates internal memslots covering the region between 3G and 4G in
>>> the guest physical address space, when the first vCPU is created.
>>> Mapping this region before creation of the first vCPU causes vCPU
>>> creation to fail. Prohibit tests from creating such a memslot and fail
>>> with a helpful warning when they try to.
>>>
>>> Signed-off-by: Ben Gardon <bgardon@google.com>
>>> ---
>>
>> The internal memslots are much higher than this (0xfffbc000 and
>> 0xfee00000).  I'm changing the patch to block 0xfe0000000 and above,
>> otherwise it breaks vmx_dirty_log_test.
> 
> Perhaps we're working in different units, but I believe paddrs
> 0xfffbc000 and 0xfee00000 are between 3GiB and 4GiB.
> "Proof by Python":

I invoke the "not a native speaker" card.  Rephrasing: there is a large
part at the beginning of the area between 3GiB and 4GiB that isn't used
by internal memslot (but is used by vmx_dirty_log_test).

Though I have no excuse for the extra zero, the range to block is
0xfe000000 to 0x100000000.

Paolo

>>>> B=1
>>>> KB=1024*B
>>>> MB=1024*KB
>>>> GB=1024*MB
>>>> hex(3*GB)
> '0xc0000000'
>>>> hex(4*GB)
> '0x100000000'
>>>> 3*GB == 3<<30
> True
>>>> 0xfffbc000 > 3*GB
> True
>>>> 0xfffbc000 < 4*GB
> True
>>>> 0xfee00000 > 3*GB
> True
>>>> 0xfee00000 < 4*GB
> True
> 
> Am I missing something?
> 
> I don't think blocking 0xfe0000000 and above is useful, as there's
> nothing mapped in that region and AFAIK it's perfectly valid to create
> memslots there.
> 
> 
>>
>> Paolo
>>
> 

