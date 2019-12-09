Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F04AA11704F
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2019 16:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfLIPYJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Dec 2019 10:24:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25185 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726614AbfLIPYJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Dec 2019 10:24:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575905048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cUyKBa+6w/X0SFxnoHv5d6eKbbOBp+7aIKnhyd8PFa4=;
        b=eNVXtppA4aR5g77LXbuZeTvHsgfKUhlI245RtMBSUze0+dJoEjGVVd4IsqLpcU08vw/j8i
        8Rkz05bWiTIYUzJJUPiViuQ3gCGcEcS76j+pKOj7JFG0S+mwMBy/ekKtO0X15iwt8OX4Zz
        Cf2fnnzsWRUFAPPmSsRID2ATSJ77wyg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-Q2B1J4IVNJ23Qxcl83vcog-1; Mon, 09 Dec 2019 10:23:19 -0500
Received: by mail-wr1-f71.google.com with SMTP id v17so7606573wrm.17
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Dec 2019 07:23:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cUyKBa+6w/X0SFxnoHv5d6eKbbOBp+7aIKnhyd8PFa4=;
        b=P1uXLVYG7Cbjvv5/+grTtc7YciFEhw9OEF4/7csBRlKHZqwXaK0h4qE2rxtn5d3Wfx
         Asa5NDP2MdOCleN7vAhgezqly5DZCclHkBgv6D/Va1wRBKmy2tNoaCbIX8uiga1EKjfH
         zk7/XAbmEcCLvRGda6kv7wEw+Gs6PjM8l1yFHL4eEsm0QoiTdR/TTtUSjXwsDWNhIl8e
         Yn5mQcNcgJNcoJAkGaYYqQF1K/n6lUOCb85IzwUggmBUA/XndEPkH/eG6XJf2xXrHHTb
         Wd05EYFFJpUX6WKlE5VxDjwVzZe5QA1VDwUQox+wCOgMGIL/EvXPElh5ISR3sMB1UBM1
         mLkA==
X-Gm-Message-State: APjAAAVoiuo34uDyOVH5Pipe799w/tIJoY3D1/dgTiQ15kpgd1BfJ/jk
        kkL+vne1XZb1ZUBBsiAnJ+WIQMJB1SQ44YFt70klr+uztHuNp573B05tZ+JkDaTgux0TqQs/P4f
        twsE75YIbvnsFOG/agqOFffIYKTV8
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr2789654wrx.153.1575904997175;
        Mon, 09 Dec 2019 07:23:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqx0NPr9yEyNrwcLoT342Axfuw2Fk6VGQtA0whJ8WufzbYGTUyCLQ/P9d/nSqFiXLn6bdXvtHg==
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr2789639wrx.153.1575904996946;
        Mon, 09 Dec 2019 07:23:16 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id d16sm29936960wrg.27.2019.12.09.07.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 07:23:16 -0800 (PST)
Subject: Re: [PATCH 0/3] Reanme the definitions of INTERRUPT_PENDING,
 NMI_PENDING and TSC_OFFSETING
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20191206084526.131861-1-xiaoyao.li@intel.com>
 <20191206204747.GD5433@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2beeb1fb-7d3a-d829-38e0-ddf76b65bd3c@redhat.com>
Date:   Mon, 9 Dec 2019 16:23:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191206204747.GD5433@linux.intel.com>
Content-Language: en-US
X-MC-Unique: Q2B1J4IVNJ23Qxcl83vcog-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 06/12/19 21:47, Sean Christopherson wrote:
>> When reading the codes, I find the definitions of interrupt-window exiting
>> and nmi-window exiting don't match the names in latest intel SDM.
> I prefer KVM's names even though they diverge from the SDM.  The "window
> exiting" terminology is very literal, which is desirable for the SDM
> because it doesn't leave any wiggle room.  But for software, IMO the
> "event pending" terminology is preferable as it's more descriptive of the
> intended use of the control, e.g. KVM sets VIRTUAL_{INTR,NMI}_PENDING when
> it has a virtual event to inject and clears it after injecting said event.
> 

On the other hand:

static void enable_irq_window(struct kvm_vcpu *vcpu)
{
        exec_controls_setbit(to_vmx(vcpu), CPU_BASED_VIRTUAL_INTR_PENDING);
}

static void enable_nmi_window(struct kvm_vcpu *vcpu)
{
        if (!enable_vnmi ||
            vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) & GUEST_INTR_STATE_STI) {
                enable_irq_window(vcpu);
                return;
        }

        exec_controls_setbit(to_vmx(vcpu), CPU_BASED_VIRTUAL_NMI_PENDING);
}

so we're already using a lot the "window" nomenclature in KVM.  I've applied Xiaoyao's patches.

Paolo

