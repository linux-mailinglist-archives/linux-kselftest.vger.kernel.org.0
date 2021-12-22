Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD0047D3F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 15:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241479AbhLVOwz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 09:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhLVOwz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 09:52:55 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8D2C061574;
        Wed, 22 Dec 2021 06:52:54 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id bg2-20020a05600c3c8200b0034565c2be15so4008670wmb.0;
        Wed, 22 Dec 2021 06:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UNASmdT0hvuhhs3uP9YzQnXIGyHzJSzVhAFNnDIR+qQ=;
        b=oPmNrh2qnVZy7/rZvkrXfxHUtL7Dy90QCzv0h25xHCk0ESRgscsionZUbrLaMP8YiQ
         9xS6DaUE7w8gcaUadFsu1zRr6YH9/NsCR3kvy0Nag56lp0TgE2DytfYJPYaTP6D5mll8
         Z2iT2PJlaapBG71YAYrZwTovagn9QEOuw/aZcrOnS937Zfaijnwlab0Z/lzdUeSjwqBr
         P9QCypcTgvHybTbmYtm/KMXMYorn6M2bVMUNlPui4flrm/gQnN+j/m9sxycRfzBARixw
         htaqs1RqIIL7DYoZuPF2qCEKbUELafeegij/SRMxvrMjOOfGeu9hduV6E8gIuwwQL8Wx
         gDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UNASmdT0hvuhhs3uP9YzQnXIGyHzJSzVhAFNnDIR+qQ=;
        b=R5/qJ4GpHWlZpd1aZBJLJ2Ww0Fe+udpXpzoPI0R+bHR2hYq74cO0Yr3PfEycHI/KiU
         b4Y28lYbeoMkO8IUOcsE+W/u4I2zQLGWk61aSqhvwfi/ulT2kPR5dzl9+Z1pZnbusk86
         uYgeuzCdaDIxAsoCmyTLXK8ku4OIZvU3BHE+yUBg4f+1RyXquFy/iXI65mJE+1algsEi
         0D5mB5Wqckm01FxnCh8+KmucInIgdgPTK37DMBibBuohclV/pF8Tj4zfCF5loLShwang
         j/5PHy0Wpp7vXJqAqvG8ZsHtp/HgdXNPlK5LjGYseZEsZGcLQkc7oY8q2tGBzOJ7N1JK
         se3w==
X-Gm-Message-State: AOAM533u+7bpVkTh5Kq6UmaAXhifz/GJiOsvvLmZUeVjM3zxZJB5Pj6G
        qf5k/Qx5HGousYmAPW2SXQE=
X-Google-Smtp-Source: ABdhPJyXpgGNGKRcdlXMW7sez9UGp/XRanMx+cNdPZOSjYRNQanq5WOvyc59EI5cbOwxjj6Y9TPewA==
X-Received: by 2002:a05:600c:1e01:: with SMTP id ay1mr1201748wmb.152.1640184773438;
        Wed, 22 Dec 2021 06:52:53 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312::4fa? ([2001:b07:6468:f312::4fa])
        by smtp.googlemail.com with ESMTPSA id m35sm12429107wms.1.2021.12.22.06.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 06:52:52 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <496b5209-6b1c-1205-ed0e-733af6386f8d@redhat.com>
Date:   Wed, 22 Dec 2021 15:52:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 07/13] KVM: selftests: add library for
 creating/interacting with SEV guests
Content-Language: en-US
To:     Michael Roth <michael.roth@amd.com>,
        Peter Gonda <pgonda@google.com>
Cc:     linux-kselftest@vger.kernel.org, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
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
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>
References: <20211216171358.61140-1-michael.roth@amd.com>
 <20211216171358.61140-8-michael.roth@amd.com>
 <CAMkAt6pPpWzazBJAM0N1s115k9on7mC46BKzwk6oYHBOoGyohA@mail.gmail.com>
 <20211217161758.pgpvzlgu4z6vhq7x@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211217161758.pgpvzlgu4z6vhq7x@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/17/21 17:17, Michael Roth wrote:
>>> +void kvm_sev_ioctl(struct sev_vm *sev, int cmd, void *data)
>>> +{
>>> +       struct kvm_sev_cmd arg = {0};
>>> +       int ret;
>>> +
>>> +       arg.id = cmd;
>>> +       arg.sev_fd = sev->fd;
>>> +       arg.data = (__u64)data;
>>> +
>>> +       ret = ioctl(vm_get_fd(sev->vm), KVM_MEMORY_ENCRYPT_OP, &arg);
>> If the helper vm_get_fd() exists why not add another which takes a
>> struct sev_vm. So you can do __vm_get_fd(sev) here?
> I can add it as a local helper for now, maybe sev_get_kvm_fd(), to
> distinguish from the SEV_PATH fd? I'm not sure it's worth exporting it
> as part of the library though since vm_get_fd(sev_get_vm(sev)) would be
> more familiar to callers that are already used to the kvm_util library.
> 

I also prefer the one that you suggest.

>> Can you dedup this from  sev_ioctl() in sev_migrate_tests.c? That
>> function already correctly asserts the fw_error.
> 
> This is a little bit awkward since sev_ioctl() in sev_migrate_tests opens
> SEV_PATH on demand whereas this one pulls it out of struct sev_vm. I
> could make kvm_sev_ioctl() expect the KVM fd as a parameter but that
> means external callers need another call to pull it out of struct
> sev_vm.

Yeah, it's a bit weird because sev_migrate_tests do not use struct 
sev_vm.  Unless you port them first, you could have both 
kvm_vm_sev_ioctl that takes a struct kvm_vm, and sev_vm_ioctl that takes 
a struct sev_vm.  Then you only need to change the argument of 
verify_mirror_allowed_cmds to struct kvm_vm.

Paolo
