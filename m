Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADAD612916
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Oct 2022 09:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiJ3IY4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Oct 2022 04:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJ3IYz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Oct 2022 04:24:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8433A1C3
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Oct 2022 01:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667118233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+HCqRxUUbo88Ftgcg5phMTzAnfw/KEo8G7x0IwDXoJ8=;
        b=AiEZ/3tiIheqlXPV9Cy9fPfbGz7JpCM4QftrIopdxw2S/4t7/1welyFhByCAb+dzkR9eTC
        WnTDMOMNj8kJZdIO/MSzN9AAggmpiztHInnyLQVmFI0kJI8XTgJRTYh5C5Jw0zy4hDEJ61
        G6VwfhwAeLLQnQz7Ts89FHPX0Tevtps=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-259-gqXSng0GOTe0NK4W4RDjQA-1; Sun, 30 Oct 2022 04:23:49 -0400
X-MC-Unique: gqXSng0GOTe0NK4W4RDjQA-1
Received: by mail-qk1-f197.google.com with SMTP id bq17-20020a05620a469100b006eeb0bbe02bso7018556qkb.5
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Oct 2022 01:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+HCqRxUUbo88Ftgcg5phMTzAnfw/KEo8G7x0IwDXoJ8=;
        b=kClPgauF7/Ufq+EpZkIK3JgrukE5P00C3uqNpFIhRYruu5mfHIqQ3Dm0sBNIe29huQ
         5pFMDlIv5fuguq+/n8q25rgitr7BAalYno+s4mrLVZwRd4jiWvUU6GGCY0Nbo6obVHYG
         34Zbw/pj27ibrGRi+zaWGR62zLRm3tDbp/0YORekB/g4OO+w/TFvtKrl+S8SdLQX4lUj
         ehJFQ7t/8gg6FzheTdHuUITxYQ1lYlmQvxe5QsxyPsYLOvFS53GJj9wHGsYtJxqCJIqV
         +CDtpmE+kr+sRQ381EdkGR1YSrPfXTWFtO4Sp8eSeneD+0uoIcX8n9nzrCtXx2gperwa
         V1gA==
X-Gm-Message-State: ACrzQf1OR0Owr1Qct8Ag63WERfCqLv9co+/TFDp6DSRnTPPQKZ05httz
        Z5V/5DosgNJTDYxzShyn4raqMxYKf/5IPpfg7KjlPFHVsKaJdY9VumxxcnOEMmuG14ae1QqtHZk
        nVZsETgcsNIJOGa9wQ4JqAu5wnDik
X-Received: by 2002:a05:620a:1b9b:b0:6ed:35f0:9b56 with SMTP id dv27-20020a05620a1b9b00b006ed35f09b56mr5458723qkb.196.1667118229183;
        Sun, 30 Oct 2022 01:23:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4F2ggOmOjSpEqUNKsLAehF43Wvadj3+7i45DOAqcVbkmJHNigl4LT/t5qEoy98Cov1Nwjo4Q==
X-Received: by 2002:a05:620a:1b9b:b0:6ed:35f0:9b56 with SMTP id dv27-20020a05620a1b9b00b006ed35f09b56mr5458712qkb.196.1667118228955;
        Sun, 30 Oct 2022 01:23:48 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id x21-20020a05620a0b5500b006ec9f5e3396sm1303237qkg.72.2022.10.30.01.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 01:23:48 -0700 (PDT)
Message-ID: <83e1eb701804d9d5afdaf2f26574a793f85a0292.camel@redhat.com>
Subject: Re: [PATCH RESEND v4 23/23] KVM: x86: smm: preserve interrupt
 shadow in SMRAM
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
Date:   Sun, 30 Oct 2022 10:23:42 +0200
In-Reply-To: <137568e8-90a6-19e3-1bcb-055ed0c419e7@redhat.com>
References: <20221025124741.228045-1-mlevitsk@redhat.com>
         <20221025124741.228045-24-mlevitsk@redhat.com>
         <137568e8-90a6-19e3-1bcb-055ed0c419e7@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2022-10-28 at 12:35 +0200, Paolo Bonzini wrote:
> On 10/25/22 14:47, Maxim Levitsky wrote:
> > @@ -19,7 +19,8 @@ struct kvm_smram_state_32 {
> >         u32 reserved1[62];
> >         u32 smbase;
> >         u32 smm_revision;
> > -       u32 reserved2[5];
> > +       u32 reserved2[4];
> > +       u32 int_shadow; /* KVM extension */
> >         u32 cr4; /* CR4 is not present in Intel/AMD SMRAM image */
> >         u32 reserved3[5];
> 
> Of course the placement of KVM-specific fields is somewhat arbitrary, 
> but based on sandpile.org data I would place it at 0xFF1A ("reserved", 
> you have to search for 7F1Ah in the web page).
> 
> > @@ -86,7 +87,7 @@ struct kvm_smram_state_64 {
> >         u64 io_restart_rsi;
> >         u64 io_restart_rdi;
> >         u32 io_restart_dword;
> > -       u32 reserved1;
> > +       u32 int_shadow;
> >         u8 io_inst_restart;
> >         u8 auto_hlt_restart;
> >         u8 reserved2[6];
> 
> Likewise, based on AMD BKDG I would place this at 0xFECB after the "NMI 
> Mask" field (which unfortunately I learnt about only after "inventing" 
> HF_SMM_INSIDE_NMI_MASK).

I don't see any problem with this, makes sense.

I wish AMD would keep on releaseing the BKDG - I haven't looked there
because last public version is very old.


Thanks!
Best regards,
	Maxim Levitsky

> 
> I can do the changes myself, but please ack.
> 
> Paolo
> 


