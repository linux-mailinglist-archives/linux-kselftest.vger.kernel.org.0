Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F160425025
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 11:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240693AbhJGJfA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 05:35:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46577 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232700AbhJGJe7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 05:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633599185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YLM20CrNDiSc8ANWHfJkU17zM0jd+LCsGgIfHq5T3Hk=;
        b=gtzk2UTHHzp0GQ2ndvuiACc3gJn4KZys8JiVVDqF9SkLw61Y72YrT8TH9zyA3KVw29Vbfm
        miVKNGXsE0ahZ67mLx7F8XRuQOyDqs/X56wmXxIZy9LIOLm+v4uZkQAIZykKpHGoFWhqx2
        YwfBojuBXxEIkB2sLjDkAYL5JKsTAXs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-Zqa8jTMVOn6o6I4g41GY8Q-1; Thu, 07 Oct 2021 05:32:56 -0400
X-MC-Unique: Zqa8jTMVOn6o6I4g41GY8Q-1
Received: by mail-ed1-f69.google.com with SMTP id eg14-20020a056402288e00b003db54cde124so599404edb.17
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Oct 2021 02:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YLM20CrNDiSc8ANWHfJkU17zM0jd+LCsGgIfHq5T3Hk=;
        b=pDdWjObmPqj06KJLsCz6kDvNnAzb1ie8OxI2MZ+Vv4lwYqsjAGYYk8zPaAJ53aclZ4
         WJ0Z634IJJ5Qxd+c029sbCjD7KKUTcMIaZ9a8CAKqeJ34sJVVh/OT9cgGzW39o1pJ/Np
         Zi2zYILlf66qeYj9rRiuId04HOS4CHSEbA8STxGeG0YYCn5dl8NQia5n7CodTgcaAx+J
         zCE829YrhIz1VDYHY+oDMtL31YOSHdqrCp1gXej/9atkgG2aIrQ0EAQ0TjTTNJ5qdFFt
         mnKVd2hqAVwAt7CVghgU16wOCHq2gBWwXRsEX/ChVltBHtSpfo9cXYvEkIlYtfsORI2c
         4yeQ==
X-Gm-Message-State: AOAM532fwtupkYLQ/BB4Ei8zBrTdt9K+vSFafYH2k+vJjv1jeYof+x7B
        3t40NzfD3+5t14zv7WLp6QH5LZEJeUmWezx/7KwIzuquDk76q+jG7hMoWRjWHKa+bKIusAUkWVt
        6nhdwhz6JvvGzOr6TW4idQi3qu44W
X-Received: by 2002:adf:a118:: with SMTP id o24mr3898226wro.15.1633598859307;
        Thu, 07 Oct 2021 02:27:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTkTGQO7OWYf67tE5FRQkAoLSad774DWcZLIKG1RX8coeD4jn+lqAsFsAow6Xbu9zf7PRTow==
X-Received: by 2002:adf:a118:: with SMTP id o24mr3898207wro.15.1633598859138;
        Thu, 07 Oct 2021 02:27:39 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6886.dip0.t-ipconnect.de. [91.12.104.134])
        by smtp.gmail.com with ESMTPSA id l17sm23582725wrx.24.2021.10.07.02.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 02:27:38 -0700 (PDT)
Subject: Re: [PATCH v1 6/6] x86: remove memory hotplug support on X86_32
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@kernel.org>, x86@kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org
References: <20210929143600.49379-1-david@redhat.com>
 <20210929143600.49379-7-david@redhat.com>
 <YV66zoLEP3niIHEu@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <565bdc3e-04b2-8eff-181c-d4dcf82e0e40@redhat.com>
Date:   Thu, 7 Oct 2021 11:27:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YV66zoLEP3niIHEu@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 07.10.21 11:15, Oscar Salvador wrote:
> On Wed, Sep 29, 2021 at 04:36:00PM +0200, David Hildenbrand wrote:
>> CONFIG_MEMORY_HOTPLUG was marked BROKEN over one year and we just
>> restricted it to 64 bit. Let's remove the unused x86 32bit implementation
>> and simplify the Kconfig.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks for the review Oscar!

-- 
Thanks,

David / dhildenb

