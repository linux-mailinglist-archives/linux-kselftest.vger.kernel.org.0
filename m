Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3616443906E
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Oct 2021 09:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhJYHgi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Oct 2021 03:36:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43390 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231686AbhJYHgi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Oct 2021 03:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635147256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hbcl0gbQpn4WwZGm5yo+PNPS7V1g/gwZXgW3ceJl2vs=;
        b=MVRs2dUecqH8SIEwtUq0b2LLCXZlZWonAkvGsVePQhv8bV4KKKys6jbwucf3T14qUlYBWy
        3qsuhTr+1oXyTre7F86nO1nHE5FsQGJ3oGqOqtVm8e+qAnAHYw/AsnHNaXuSdvs34CRrL4
        tsdtC9okaPWnoNDgkmAl/FvU6l0agfs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-F6hrkuzBMRSi27kbr2aEfQ-1; Mon, 25 Oct 2021 03:34:14 -0400
X-MC-Unique: F6hrkuzBMRSi27kbr2aEfQ-1
Received: by mail-ed1-f72.google.com with SMTP id k28-20020a508adc000000b003dd5e21da4bso1398315edk.11
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Oct 2021 00:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Hbcl0gbQpn4WwZGm5yo+PNPS7V1g/gwZXgW3ceJl2vs=;
        b=fddH3xic+0+EMamrGL59E7LDTU07oM9ApRbXG4GBaxSwduAJ78N3HGgGVYbqWMogyX
         6gfsd4mP1xuC+jFGiewASAOwEgggqIL5QRXqsqz3WlHqnwnDxryfA/zmLP+nyOI5TORA
         pOkmzBNn77Tghx6F5zRCfRJKGi52K/Ts/l+22F0H0mYK9H+Pbub3c9gx+50Qp/7CQD4m
         e4zZpEaDfXC0v30AXvTzN9frWrV2rfYNp3OUz8bpWRhC6eKD6QKI0rpvHp+QS7tk8TRD
         ZDuC3O9l667q8Q0vGPQN4xBV+X5ywKPHnRUYpqF/pP1r9iGbaPBbRBweym3v2/kvI58t
         qJxQ==
X-Gm-Message-State: AOAM532veKgWL09q6wP9+XuFr4jkRRBdmQQm7dQ6/GuMG0QnUZuVPE8F
        sS9UnjQevgYKZTBL1kWt0dlEA/Kf0PcBUJlRzRjtSoJ/ZTnhw6G1m/5sYG8y010KcFwbBIGYwaL
        nQwIBrMYKqgVwsyBXLAKSUItxosMo
X-Received: by 2002:a50:da4e:: with SMTP id a14mr24504884edk.154.1635147253135;
        Mon, 25 Oct 2021 00:34:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZx5HQLM0XBPPBrNQJPx5RAYvF31ANHQfsnzNbKOPkOI2CAtR3+iWtEpEcInVQTyuPbtbI9Q==
X-Received: by 2002:a50:da4e:: with SMTP id a14mr24504859edk.154.1635147252945;
        Mon, 25 Oct 2021 00:34:12 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id q9sm2857658edd.66.2021.10.25.00.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 00:34:12 -0700 (PDT)
Message-ID: <9de44944-57c1-047c-8c66-94eee6369a67@redhat.com>
Date:   Mon, 25 Oct 2021 09:34:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [RFC 03/16] KVM: selftests: handle encryption bits in page tables
Content-Language: en-US
To:     Michael Roth <michael.roth@amd.com>
Cc:     linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
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
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
 <20211005234459.430873-4-michael.roth@amd.com>
 <31db4c63-218a-5b26-f6ed-d30113f95e29@redhat.com>
 <20211024164945.mt62qjrld3dwssv4@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211024164945.mt62qjrld3dwssv4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 24/10/21 18:49, Michael Roth wrote:
> So test code would need to consider cases where addr_gpa2raw() needs to be
> used to set the C-bit (which is basically only when they want to mix usage
> of the vm_phy_page[s]_alloc with their own mapping of the guest page tables,
> which doesn't seem to be done in any existing tests anyway).

Yes, and it seems like a more rare case in general.

> The library code would need these addr_gpa2raw() hooks in places where
> it calls virt_*map() internally. Probably just a handful of places
> though.

Either that, or you can have virt_*map that consults the encryption 
bitmap, and virt_*map_enc (or _raw, doesn't matter) that takes the 
encryption state explicitly as a bool.

> Even in this alternative approach though, having addr_gpa2hva() silently
> mask away C-bit still seems useful for the reasons above, but again, no
> strong feelings one way or the other on that.

Ok, keep it the way you find more useful.

Paolo

