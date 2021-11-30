Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E793646327A
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Nov 2021 12:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240779AbhK3Lh1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Nov 2021 06:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236883AbhK3Lh1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Nov 2021 06:37:27 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0101DC061574;
        Tue, 30 Nov 2021 03:34:08 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x6so85054978edr.5;
        Tue, 30 Nov 2021 03:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jxt0KjOu/rGxEDPUA6mfD10PFiJuYOjmgF4D2VnmVSA=;
        b=kVae02EA/ehz8I2Qxvst2hM9e07Eo/Z/dPCPyzKZPHjS9sSIeaWfE7dx4iXtTmzkvi
         J3ANW78Tesn3AzDGWLLoV1Xr90TM6nIxrwRwWafLzkxaOq+mTp/vy6aIsQDFGGDajGVB
         Bz1ujetZ6cQXHZBIFIaf/idAiKAtYLJzSCQLndSU6mtRNuDoHGfD4XaHeh6MWIrIObXK
         Usa8WhRn2ZSj1HI10GYw9hFXqGzHWO4TemYiCf77pmlt6rgvNzv7MOtSYdhNfQIdQPOO
         3Sbp7eYU/D19NDK2cAbYo838h+ZkmYzuFz9rHrsKqcmqNUKxo7rYws/f90B792bOv+ju
         WzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jxt0KjOu/rGxEDPUA6mfD10PFiJuYOjmgF4D2VnmVSA=;
        b=YHlzmVZKBXnpO4YXjUE1EbZ+HvsegyvElco8quykF7IRYsPBR4anIDJb3UYlTphkOz
         aJCh0c/S9HyEhqn69MI9XOvGMGWrSz93siKXUMkLMxqXGub1ZgZ1IO59xTmZOixpaBin
         CQwnJNtIqOJddh3EUi057xC/3QhMGJmMncd/+75tgF4AkdT5knI9hfVtuhzIufFin1qL
         sBzHVrwavzDgI6JykM0RGUMuouNry6+dyBB617ISuQC++8/Z7ijROD/UFtQnExzfiF1K
         iLXi4CumaE1OGgdJE6KGD8MTFNtiDM7+rv3XJgO1ww1xZiW6b7e3p5hP7lWIkqXHyZu8
         VvVw==
X-Gm-Message-State: AOAM533D7xLFWiphAy1YjNuVZV4yQX0B2uCOwPz1OVDi5l/stDtMHvOB
        Y7Q80uK3ZA50I9MUtrMfSx4=
X-Google-Smtp-Source: ABdhPJxaGlaVoYm9BcjetagPoKMwxpkKa8ohhVTHyyksYAiJBo0ftDe4DXuUi5OQVtNjrh9epnDaAg==
X-Received: by 2002:a17:906:dc90:: with SMTP id cs16mr66150919ejc.432.1638272046645;
        Tue, 30 Nov 2021 03:34:06 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id dp16sm10025444ejc.34.2021.11.30.03.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 03:34:06 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <76b1bb76-3f2e-2443-124b-2e7a7a6e4543@redhat.com>
Date:   Tue, 30 Nov 2021 12:34:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 0/6] nSVM optional features
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Bandan Das <bsd@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Wei Huang <wei.huang2@amd.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20211101140324.197921-1-mlevitsk@redhat.com>
 <f983e2e343f600ab5196aef8389d719bc2ab7308.camel@redhat.com>
 <a33c5f6fb887973fc69a0586c615aea6461cad6e.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <a33c5f6fb887973fc69a0586c615aea6461cad6e.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/26/21 07:55, Maxim Levitsky wrote:
>> Kind ping on these patches.
> Another kind ping on these patches.

I'm first flushing the fixes, and then will be back to new features.

Paolo
