Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1206A3AF979
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jun 2021 01:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhFUXiL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Jun 2021 19:38:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49833 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231719AbhFUXiK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Jun 2021 19:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624318555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y4rj5S7DFpUC+3DesUoe15Y9dUe8dzdqWSEsCDEqvgA=;
        b=APC7UXMuV7Au63FUsCMO9Q282eUDQEYwVP6WEwBIpcNACtEU6q35IBZpXxT0Tl1c8gRw3B
        ZfTWWxZJEHP3vYgUhWVabQ0OkNLeM2z0aCJDGdDbUN7ynhtmi/BYFTLIMedOMPcQ0i19as
        MYGb9+SLpvUYyhqYAANmlkVvnTJCfXc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-GOullGbiNq6e3Ux6rAob7g-1; Mon, 21 Jun 2021 19:35:54 -0400
X-MC-Unique: GOullGbiNq6e3Ux6rAob7g-1
Received: by mail-wm1-f69.google.com with SMTP id i24-20020a1c54180000b02901dbcf5d699eso676324wmb.0
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Jun 2021 16:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y4rj5S7DFpUC+3DesUoe15Y9dUe8dzdqWSEsCDEqvgA=;
        b=seV9N1BSS0k2NlubRree2NJEoK7qYgys6tYvYN003M3VJVxGBYMXV3nbsxnRbWAwin
         8jjRLwdNIQmNuZ+lPr6NIzSP4FhmftuoOg/qqgtXvTqgHCLJ9sWvIQG3+FrbTLjwti+7
         CIryW/HNuGxwLN/TD7iaAceq+1GLlispMybZFcv1+ZKoJQw5WEpbMR4lZhwk4CihLztK
         3L2KGVSOlwcRZ96Q+3qOHBim08itKP9QH36iHgEL7FoOvx3PfhEqE9inNZtWnW3L+sFb
         BzqmqopJ3Lls+per+kkoL0rmHtCoVBz3iaP6gntFFkFxsFNkP1yVuSHzrrMiRVQYRLVZ
         pIVg==
X-Gm-Message-State: AOAM531OQRpn9ZYqjvchTr8P8+X5hJvyqcyfZaH+mmnnnEVObWPs8D0v
        SmdVRQH6XPgvdpwdun1/77vRQ7KrufAwi0VCtwuP5FMa6wH7SDGBTefN60fn0ZTxPzJHRHnjLEp
        U7CtOxxIzlg+3/1cvq3xXPV2Z4Fa2
X-Received: by 2002:a05:6000:1c5:: with SMTP id t5mr1064364wrx.71.1624318553283;
        Mon, 21 Jun 2021 16:35:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhLPASIEPgENpXabVu2lLjBJcoZDTjIn3uO5++5JKzeF1Zgk0yuFtAQij55J0dmy/ecQX5WA==
X-Received: by 2002:a05:6000:1c5:: with SMTP id t5mr1064334wrx.71.1624318553129;
        Mon, 21 Jun 2021 16:35:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id u15sm458337wmq.48.2021.06.21.16.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 16:35:52 -0700 (PDT)
Subject: Re: [PATCH v12 2/7] KVM: stats: Add fd-based API to read binary stats
 data
To:     Jing Zhang <jingzhangos@google.com>
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
        Fuad Tabba <tabba@google.com>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20210618222709.1858088-1-jingzhangos@google.com>
 <20210618222709.1858088-3-jingzhangos@google.com>
 <0cde024e-a234-9a10-5157-d17ba423939e@redhat.com>
 <CAAdAUtiL6DwJDWLLmUqct6B6n7Zaa2DyPhpwKZKb=cpRH+8+vQ@mail.gmail.com>
 <aa1d0bd9-55cf-161a-5af9-f5abde807353@redhat.com>
 <CAAdAUti1MreOnAXtA+jBEaq+AixmqvBEByi9G4EgDpfu63spHA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c639c557-0e16-6938-2da5-46400ee2dd14@redhat.com>
Date:   Tue, 22 Jun 2021 01:35:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAAdAUti1MreOnAXtA+jBEaq+AixmqvBEByi9G4EgDpfu63spHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 22/06/21 00:58, Jing Zhang wrote:
>> Pass it as an argument?
> The num_desc can only be initialized in the same file that defines the
> descriptor array.
> Looks like we have to have a global variable to save that. The
> solution would be similar
> to have a statically defined header for each arch.
> So, keep the header structure for each arch?

Oh, sorry.  I missed that there's only one call to kvm_stats_read and 
it's in common code.  The remaining comments are small enough that I can 
apply them myself.  Thanks!

Paolo

