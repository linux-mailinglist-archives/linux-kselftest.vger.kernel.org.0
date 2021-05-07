Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3F5376134
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 May 2021 09:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbhEGHgw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 May 2021 03:36:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233280AbhEGHgv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 May 2021 03:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620372951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YRLhFcul/s0bAb0h6pwheuix10YVXJYp5em6Jk4RpTY=;
        b=LKQ8IWaBht40hQ37zGhiXWlx+x+Dj6an1dgqmq+UDQ3Msuggv1C2b3TezDAWLG/j28CUxx
        SYtxDjtmTeLa6lateTlt99a9Vpwn/iZBxnYdboXBfMzDsZa4lqARUwn76xIegra1nQR16K
        nHeDtHsZAN4JgiRXzfUjQ3eqptexoS4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-E0_9XD72OTqoe1Vk4fXKpQ-1; Fri, 07 May 2021 03:35:49 -0400
X-MC-Unique: E0_9XD72OTqoe1Vk4fXKpQ-1
Received: by mail-ed1-f69.google.com with SMTP id g7-20020aa7c5870000b02903888f809d62so4004961edq.23
        for <linux-kselftest@vger.kernel.org>; Fri, 07 May 2021 00:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YRLhFcul/s0bAb0h6pwheuix10YVXJYp5em6Jk4RpTY=;
        b=JBJxjGkDcfwZ0X0NKASXQHXVU/I95rnch8zg8XeJsqHBtJqN+Qz08OHHM/s9li+ie5
         fq4NDuiyVv9mBYXRsdSyWHsoJT/O+iBLkcetxdPH6NyAl+TXxCSz+9beZwx5R8gTVXcA
         UpJZK+kHCMdUFkhFEJEEPRx4h9NjxkqAY0S5Uw16QcyviQKtV2RNTWbN2//3fTdPpMuZ
         xe4uUp2C51BLTI2qM34WslcgTGQTN6XI2JliBUsjlTzS7SxYkAhjd7EQs9NK68V3odE0
         MhsAn/x5EuxHGJksCC/sp5kR59Wt+nm5wSch2LDC9kOjzBwPA7NpZA2ailnglj9lJWtT
         1XNQ==
X-Gm-Message-State: AOAM532/RyrILyd6b1gYRH7jBTk4Vt8ZkcCbJ09Gsw49HXqZq3bCCAvV
        JO85GwLIksS58gmD1oif8JNgPT1UlbxU36U71/7JLesdBWHmplpYeKOxUyWMRF1vWHh8wetl+9T
        69p/fdrLNEIDKsCOYB3YEUx3B6FEl
X-Received: by 2002:a17:907:174a:: with SMTP id lf10mr8861624ejc.433.1620372948274;
        Fri, 07 May 2021 00:35:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5XI2zKUbsKazvcW2Vr5jvMDeiB+dtOEKTtfzbIqz37aYae3i7ugq6B0OmfMhiabycSZroRA==
X-Received: by 2002:a17:907:174a:: with SMTP id lf10mr8861569ejc.433.1620372947917;
        Fri, 07 May 2021 00:35:47 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c63c0.dip0.t-ipconnect.de. [91.12.99.192])
        by smtp.gmail.com with ESMTPSA id l17sm2925176ejk.22.2021.05.07.00.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 00:35:47 -0700 (PDT)
To:     Nick Kossifidis <mick@ics.forth.gr>, jejb@linux.ibm.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
References: <20210303162209.8609-1-rppt@kernel.org>
 <20210505120806.abfd4ee657ccabf2f221a0eb@linux-foundation.org>
 <de27bfae0f4fdcbb0bb4ad17ec5aeffcd774c44b.camel@linux.ibm.com>
 <996dbc29-e79c-9c31-1e47-cbf20db2937d@redhat.com>
 <8eb933f921c9dfe4c9b1b304e8f8fa4fbc249d84.camel@linux.ibm.com>
 <77fe28bd940b2c1afd69d65b6d349352@mailhost.ics.forth.gr>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v18 0/9] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <5232c8a7-8a05-9d0f-69ff-3dba2b04e784@redhat.com>
Date:   Fri, 7 May 2021 09:35:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <77fe28bd940b2c1afd69d65b6d349352@mailhost.ics.forth.gr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 07.05.21 01:16, Nick Kossifidis wrote:
> Στις 2021-05-06 20:05, James Bottomley έγραψε:
>> On Thu, 2021-05-06 at 18:45 +0200, David Hildenbrand wrote:
>>>
>>> Also, there is a way to still read that memory when root by
>>>
>>> 1. Having kdump active (which would often be the case, but maybe not
>>> to dump user pages )
>>> 2. Triggering a kernel crash (easy via proc as root)
>>> 3. Waiting for the reboot after kump() created the dump and then
>>> reading the content from disk.
>>
>> Anything that can leave physical memory intact but boot to a kernel
>> where the missing direct map entry is restored could theoretically
>> extract the secret.  However, it's not exactly going to be a stealthy
>> extraction ...
>>
>>> Or, as an attacker, load a custom kexec() kernel and read memory
>>> from the new environment. Of course, the latter two are advanced
>>> mechanisms, but they are possible when root. We might be able to
>>> mitigate, for example, by zeroing out secretmem pages before booting
>>> into the kexec kernel, if we care :)
>>
>> I think we could handle it by marking the region, yes, and a zero on
>> shutdown might be useful ... it would prevent all warm reboot type
>> attacks.
>>
> 
> I had similar concerns about recovering secrets with kdump, and
> considered cleaning up keyrings before jumping to the new kernel. The
> problem is we can't provide guarantees in that case, once the kernel has
> crashed and we are on our way to run crashkernel, we can't be sure we
> can reliably zero-out anything, the more code we add to that path the

Well, I think it depends. Assume we do the following

1) Zero out any secretmem pages when handing them back to the buddy. 
(alternative: init_on_free=1) -- if not already done, I didn't check the 
code.

2) On kdump(), zero out all allocated secretmem. It'd be easier if we'd 
just allocated from a fixed physical memory area; otherwise we have to 
walk process page tables or use a PFN walker. And zeroing out secretmem 
pages without a direct mapping is a different challenge.

Now, during 2) it can happen that

a) We crash in our clearing code (e.g., something is seriously messed 
up) and fail to start the kdump kernel. That's actually good, instead of 
leaking data we fail hard.

b) We don't find all secretmem pages, for example, because process page 
tables are messed up or something messed up our memmap (if we'd use that 
to identify secretmem pages via a PFN walker somehow)


But for the simple cases (e.g., malicious root tries to crash the kernel 
via /proc/sysrq-trigger) both a) and b) wouldn't apply.

Obviously, if an admin would want to mitigate right now, he would want 
to disable kdump completely, meaning any attempt to load a crashkernel 
would fail and cannot be enabled again for that kernel (also not via 
cmdline an attacker could modify to reboot into a system with the option 
for a crashkernel). Disabling kdump in the kernel when secretmem pages 
are allocated is one approach, although sub-optimal.

> more risky it gets. However during reboot/normal kexec() we should do
> some cleanup, it makes sense and secretmem can indeed be useful in that
> case. Regarding loading custom kexec() kernels, we mitigate this with
> the kexec file-based API where we can verify the signature of the loaded
> kimage (assuming the system runs a kernel provided by a trusted 3rd
> party and we 've maintained a chain of trust since booting).

For example in VMs (like QEMU), we often don't clear physical memory 
during a reboot. So if an attacker manages to load a kernel that you can 
trick into reading random physical memory areas, we can leak secretmem 
data I think.

And there might be ways to achieve that just using the cmdline, not 
necessarily loading a different kernel. For example if you limit the 
kernel footprint ("mem=256M") and disable strict_iomem_checks 
("strict_iomem_checks=relaxed") you can just extract that memory via 
/dev/mem if I am not wrong.

So as an attacker, modify the (grub) cmdline to "mem=256M 
strict_iomem_checks=relaxed", reboot, and read all memory via /dev/mem. 
Or load a signed kexec kernel with that cmdline and boot into it.

Interesting problem :)

-- 
Thanks,

David / dhildenb

