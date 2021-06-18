Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46B83AC616
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jun 2021 10:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbhFRIbB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 04:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233757AbhFRIbA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 04:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624004931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2dX1Z1B4jDVkxeyQIb00TBL9OAqb/e0k+UeCSPEL6lM=;
        b=Vvn032ENBgFnkOuTzKqptjPXV0MdMk+v36tnx+ISPrpm5CIFL9fzaCutXDlSD9nwMy05AB
        FykGmO0YnMFulOhDJkXUVF2VxipNsObl0ZtfTFD85AjGXf9Y4YxFDv67lyVuWtgxlCLIZG
        8gxqmezP2SKX275K8LiCYgB8n3dwEdw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-DxYcSh3wMMGXVw3hX1qEmA-1; Fri, 18 Jun 2021 04:28:49 -0400
X-MC-Unique: DxYcSh3wMMGXVw3hX1qEmA-1
Received: by mail-ed1-f70.google.com with SMTP id cb4-20020a0564020b64b02903947455afa5so1337622edb.9
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jun 2021 01:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2dX1Z1B4jDVkxeyQIb00TBL9OAqb/e0k+UeCSPEL6lM=;
        b=iLKeS/FVLXrpoEA5Rd5BNUsBefi3EqpFJ4Pdk7sx8kD+kv5pYV+pGv7+F/d0DZ6uJA
         eZvamofnDz+Nohz034jaXOS4TfkK3psjagcJ0dYheXWUHpBpxE50FtNlOvXTdS9xHa4L
         uG3HtzcuHBWuQpcL0bZBK6WoNr4pTa+bjIRnN42KcZKGhFDUbXRykhhEKb5lGwwDPB2H
         /Khi6MePKZd33F5Go9xuIwaIQCAbUcm2sSEz9BV8FaIIQ4VYrZX1SQoYL1QxcUfK2ziM
         ijPn54J4eKwvF+vUDFK2XuQeDrRGq+zZT7FhUb4Pu4TTCEu1IrT2xDjWKiEVhPi6Y595
         /dVg==
X-Gm-Message-State: AOAM532zZbMJ9CAfbW3KV3IZBp1a7RF04Obt+pNoLClvh/u+P+LdtLOl
        Z0ATZqeiqwqEhotGbiic783Npo8YWajwzRF0OuZDL4osg9ONgpeDI8zWy0A7mL8SvVmHxZkDIGA
        Tuz2uTqfx51XqvhXP7eg2hdGQW2U1
X-Received: by 2002:a17:907:2648:: with SMTP id ar8mr9824425ejc.67.1624004928740;
        Fri, 18 Jun 2021 01:28:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxEeRkMy/icCxnO1ZwArvUqnCPkqScwHQd07KbiNxNFCpJPaEhOwv7LrjsH24qmyNHLMlMAg==
X-Received: by 2002:a17:907:2648:: with SMTP id ar8mr9824392ejc.67.1624004928541;
        Fri, 18 Jun 2021 01:28:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id lu21sm730110ejb.31.2021.06.18.01.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 01:28:47 -0700 (PDT)
Subject: Re: [PATCH v11 2/7] KVM: stats: Add fd-based API to read binary stats
 data
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jing Zhang <jingzhangos@google.com>
Cc:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Fuad Tabba <tabba@google.com>
References: <20210618044819.3690166-1-jingzhangos@google.com>
 <20210618044819.3690166-3-jingzhangos@google.com>
 <YMxDv5BgfdMn2Y9b@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f9919638-06e2-2c4a-a6a6-f00fca6d78f8@redhat.com>
Date:   Fri, 18 Jun 2021 10:28:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YMxDv5BgfdMn2Y9b@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 18/06/21 08:57, Greg KH wrote:
>> + * 2. Read descriptors from its offset and discover all the stats by parsing
>> + *    descriptors. This is a one-time work for the lifecycle of the
>> + *    corresponding vm/vcpu stats fd.
>> + * 3. Periodically read stats data from its offset.
> You forgot "2.5.  rewind fd pointer position", see below...

Or use pread (that's what the test does).  I'll do a copy-editing pass 
and be sure to mention that as well.

Paolo

