Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52037321345
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Feb 2021 10:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBVJki (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Feb 2021 04:40:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21612 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230063AbhBVJkc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Feb 2021 04:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613986745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DFxc+0us/i36TuhQU4VjFE7oonKp2pd6VcvaTnTkT80=;
        b=VmpxmvcRyGmKaIDm/4oAjtcVQ+dojXtl9vYmbKm4KHVKxwCjbZj3WtniPGzAsFgmUZ4g4Q
        YDPSQgyqH693uC784GnWggclSPn8A3oeymrjqHZI4SjgXCLNLsZVGjzdwh1RoUblz3QgAW
        8RU6a0CBku5H0o2ILlfu75IafAdwQr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-uAjoBBddN9WmOEycYhZwYw-1; Mon, 22 Feb 2021 04:39:00 -0500
X-MC-Unique: uAjoBBddN9WmOEycYhZwYw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D047D18A2F09;
        Mon, 22 Feb 2021 09:38:20 +0000 (UTC)
Received: from [10.36.115.16] (ovpn-115-16.ams2.redhat.com [10.36.115.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BABB110589DD;
        Mon, 22 Feb 2021 09:38:11 +0000 (UTC)
To:     jejb@linux.ibm.com, Michal Hocko <mhocko@suse.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Mark Rutland <mark.rutland@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
References: <20210214091954.GM242749@kernel.org>
 <052DACE9-986B-424C-AF8E-D6A4277DE635@redhat.com>
 <244f86cba227fa49ca30cd595c4e5538fe2f7c2b.camel@linux.ibm.com>
 <YCo7TqUnBdgJGkwN@dhcp22.suse.cz>
 <be1d821d3f0aec24ad13ca7126b4359822212eb0.camel@linux.ibm.com>
 <YCrJjYmr7A2nO6lA@dhcp22.suse.cz>
 <12c3890b233c8ec8e3967352001a7b72a8e0bfd0.camel@linux.ibm.com>
 <dfd7db5c-a8c7-0676-59f8-70aa6bcaabe7@redhat.com>
 <000cfaa0a9a09f07c5e50e573393cda301d650c9.camel@linux.ibm.com>
 <5a8567a9-6940-c23f-0927-e4b5c5db0d5e@redhat.com>
 <b58debfe598331791ecc238a6bf8d2cf1762203a.camel@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <304e4c9d-81aa-20ac-cfbe-245ed0de9a86@redhat.com>
Date:   Mon, 22 Feb 2021 10:38:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <b58debfe598331791ecc238a6bf8d2cf1762203a.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17.02.21 17:19, James Bottomley wrote:
> On Tue, 2021-02-16 at 18:16 +0100, David Hildenbrand wrote:
> [...]
>>>>    The discussion regarding migratability only really popped up
>>>> because this is a user-visible thing and not being able to
>>>> migrate can be a real problem (fragmentation, ZONE_MOVABLE, ...).
>>>
>>> I think the biggest use will potentially come from hardware
>>> acceleration.  If it becomes simple to add say encryption to a
>>> secret page with no cost, then no flag needed.  However, if we only
>>> have a limited number of keys so once we run out no more encrypted
>>> memory then it becomes a costly resource and users might want a
>>> choice of being backed by encryption or not.
>>
>> Right. But wouldn't HW support with configurable keys etc. need more
>> syscall parameters (meaning, even memefd_secret() as it is would not
>> be sufficient?). I suspect the simplistic flag approach might not
>> be sufficient. I might be wrong because I have no clue about MKTME
>> and friends.
> 
> The theory I was operating under is key management is automatic and
> hidden, but key scarcity can't be, so if you flag requesting hardware
> backing then you either get success (the kernel found a key) or failure
> (the kernel is out of keys).  If we actually want to specify the key
> then we need an extra argument and we *must* have a new system call.
> 
>> Anyhow, I still think extending memfd_create() might just be good
>> enough - at least for now.
> 
> I really think this is the wrong approach for a user space ABI.  If we
> think we'll ever need to move to a separate syscall, we should begin
> with one.  The pain of trying to shift userspace from memfd_create to a
> new syscall would be enormous.  It's not impossible (see clone3) but
> it's a pain we should avoid if we know it's coming.

Sorry for the late reply, there is just too much going on :)

*If* we ever realize we need to pass more parameters we can easily have 
a new syscall for that purpose. *Then*, we know how that syscall will 
look like. Right now, it's just pure speculation.

Until then, going with memfd_create() works just fine IMHO.

The worst think that could happen is that we might not be able to create 
all fancy sectremem flavors in the future via memfd_create() but only 
via different, highly specialized syscall. I don't see a real problem 
with that.

-- 
Thanks,

David / dhildenb

