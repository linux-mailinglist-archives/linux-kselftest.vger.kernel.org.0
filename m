Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F458153366
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2020 15:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgBEOxu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Feb 2020 09:53:50 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54128 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726534AbgBEOxt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Feb 2020 09:53:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580914427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IAbY+Yr9/eO31ocuCCsfW4JHEc/zKedrcNZ590XXkuc=;
        b=GJWrUBisWxensDopE9vYZMHLXVp+p97DMzF9VKK05gS99hBfa+rq1h9Xkg/Ff8myQRewUx
        CKpinyXb+d/YNjtny0pgErNYXSG2AeiyfHl/6IeMw+ab3McV7L/iRZe5smMSMd96HPKzFs
        CKoYKX1Kuypoh9XPu1Fyr0jB56TVMvg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-C6JQgeMnMKul1juuNAByXg-1; Wed, 05 Feb 2020 09:53:44 -0500
X-MC-Unique: C6JQgeMnMKul1juuNAByXg-1
Received: by mail-wm1-f71.google.com with SMTP id l11so2055640wmi.0
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Feb 2020 06:53:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IAbY+Yr9/eO31ocuCCsfW4JHEc/zKedrcNZ590XXkuc=;
        b=fIcMqBqpLNr96UP//T+ph1ObZIo01I08HNpOYSlqtatibqb31zD35I2A6mOuLWE15x
         2mB+jCzkVSIxmEDLi/MdK9MALrbSHQ/vQ7p3hHB2ns21G5H6+ZaaOjRa2qfUZRc2hkUv
         TCSJY1lGdq0PrAZfkthQlX1PLgGY9RYZiGAXiO2dQqrWh1plE86hMmsWpDGMsF2CEAdm
         YXc2gIfXCuTeATYBaK7HRp2kD3f0IMyqhp5QVFEz10Zf3LSRnxHXDNufFy2v7Iu/do/u
         d1BRsf8xYu5BLdcV3EUnEkH+UWSizntn+dK9e+xXKQ/w9s8pZTArrjvOSCbAlZRGYvSw
         dR1A==
X-Gm-Message-State: APjAAAU8j3OuDrJwL/58si5DKLtc9FtU283GTsOTSCUJqRcIOPwKb9E+
        F+/Szd6LZXAHhbPa5OYEFwfX5G5zSss32ILz2NYrYd+buCfU0IJ0MHEvg4jU9bS+03G04RVWlt7
        BKBGUQc49fRxkKMUIYWZFVFZacirS
X-Received: by 2002:adf:ed09:: with SMTP id a9mr12568518wro.350.1580914423775;
        Wed, 05 Feb 2020 06:53:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqz4uM/x/8RTwBkdiICJD8IV48N7CDDFK2+/pLfMxQ3+hcFqA1/YQpAgUC0SFoYYkKnZRG1C1g==
X-Received: by 2002:adf:ed09:: with SMTP id a9mr12568501wro.350.1580914423593;
        Wed, 05 Feb 2020 06:53:43 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56? ([2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56])
        by smtp.gmail.com with ESMTPSA id q14sm60827wrj.81.2020.02.05.06.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 06:53:43 -0800 (PST)
Subject: Re: [PATCH 3/3] kvm: mmu: Separate pte generation from set_spte
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>
References: <20200203230911.39755-1-bgardon@google.com>
 <20200203230911.39755-3-bgardon@google.com>
 <87pnetkuov.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1adc4784-8567-d008-4d78-957fd33585ed@redhat.com>
Date:   Wed, 5 Feb 2020 15:53:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87pnetkuov.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 05/02/20 14:52, Vitaly Kuznetsov wrote:
>> +	spte = make_spte(vcpu, pte_access, level, gfn, pfn, *sptep, speculative,
>> +			 can_unsync, host_writable, sp_ad_disabled(sp), &ret);
> I'm probably missing something, but in make_spte() I see just one place
> which writes to '*ret' so at the end, this is either
> SET_SPTE_WRITE_PROTECTED_PT or 0 (which we got only because we
> initialize it to 0 in set_spte()). Unless this is preparation to some
> other change, I don't see much value in the complication.
> 
> Can we actually reverse the logic, pass 'spte' by reference and return
> 'ret'?
> 

It gives a similar calling convention between make_spte and
make_mmio_spte.  It's not the most beautiful thing but I think I prefer it.

But the overwhelming function parameters are quite ugly, especially
old_spte.  I don't think it's an improvement, let's consider it together
with the rest of your changes instead.

Paolo

