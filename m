Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BC860FE8E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Oct 2022 19:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbiJ0RGV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Oct 2022 13:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbiJ0RGU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Oct 2022 13:06:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B92199F5F
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Oct 2022 10:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666890379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MZaF2IWq2xKaalK2i77cU14KIzLY62J6A9qt1MT965A=;
        b=Z+0E8nPDTQ5GzqkMwHkYaq1gQxxJHs/CIZs4RHfEBs6SpK7mUEH3SmFT73jIwn+Zbo7u2r
        htEwXaz930bNXuyXqGFSuS7lzK/V5QWrCb0KLjDbKM+s3RBXnXaKlAfgQ0gbqOHoXA3/qv
        qSx3ioPPOIPXnyqOENWyuC3iCw9GPys=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-q5rDa7aNPXegfgBHm32aHA-1; Thu, 27 Oct 2022 13:06:15 -0400
X-MC-Unique: q5rDa7aNPXegfgBHm32aHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C1C51C09B71;
        Thu, 27 Oct 2022 17:06:07 +0000 (UTC)
Received: from starship (ovpn-192-51.brq.redhat.com [10.40.192.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC6B440C206B;
        Thu, 27 Oct 2022 17:06:01 +0000 (UTC)
Message-ID: <b0e8da09162cc6f2194e445a6e566f1bc356d5d0.camel@redhat.com>
Subject: Re: [PATCH RESEND v4 00/23] SMM emulation and interrupt shadow fixes
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Yang Zhong <yang.zhong@intel.com>, x86@kernel.org,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Shuah Khan <shuah@kernel.org>,
        Guang Zeng <guang.zeng@intel.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Wei Wang <wei.w.wang@intel.com>,
        Borislav Petkov <bp@alien8.de>
Date:   Thu, 27 Oct 2022 20:06:00 +0300
In-Reply-To: <0e3a0cab-1093-3e83-9e9c-f8639ebe5da0@redhat.com>
References: <20221025124741.228045-1-mlevitsk@redhat.com>
         <0e3a0cab-1093-3e83-9e9c-f8639ebe5da0@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2022-10-27 at 18:49 +0200, Paolo Bonzini wrote:
> On 10/25/22 14:47, Maxim Levitsky wrote:
> > This patch series is a result of long debug work to find out why
> > sometimes guests with win11 secure boot
> > were failing during boot.
> > 
> > During writing a unit test I found another bug, turns out
> > that on rsm emulation, if the rsm instruction was done in real
> > or 32 bit mode, KVM would truncate the restored RIP to 32 bit.
> > 
> > I also refactored the way we write SMRAM so it is easier
> > now to understand what is going on.
> > 
> > The main bug in this series which I fixed is that we
> > allowed #SMI to happen during the STI interrupt shadow,
> > and we did nothing to both reset it on #SMI handler
> > entry and restore it on RSM.
> 
> I have now sent out the final/new version of the first 8 patches and 
> will review these tomorrow.  Thanks for your patience. :)
> 
> Paolo
> 
Thank you very much!!


Best regards,
	Maxim Levitsky

