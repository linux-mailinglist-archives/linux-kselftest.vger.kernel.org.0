Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA905AA434
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Sep 2022 02:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbiIBATz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 20:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiIBATy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 20:19:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D512DF1
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Sep 2022 17:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662077990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dO2Mn5n5WZ/MoIF+K7eeDvmnGSBHo08xkcQ+P3b4bKQ=;
        b=BdKTBxvozNixSzd2DnYAHMSbF/kQq49nkYRu66226UvaHF7tGUKyclZmQhk96X+PfkarJu
        CJSJkO3VhTVZAWIRjtzJAa+9VbtoIFjIjHSBFJzv8MyWo6qpGym0XOz2wE9oNh5LQ9EuKN
        ls06qT2NQakTUd4/8/B8AqrABdCRseo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-386-Dcg9oD02O9un78kaKBHeNg-1; Thu, 01 Sep 2022 20:19:49 -0400
X-MC-Unique: Dcg9oD02O9un78kaKBHeNg-1
Received: by mail-ej1-f70.google.com with SMTP id gb33-20020a170907962100b00741496e2da1so185064ejc.1
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Sep 2022 17:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dO2Mn5n5WZ/MoIF+K7eeDvmnGSBHo08xkcQ+P3b4bKQ=;
        b=CkH2oOCjC059qxxUYGSissn84kwhnv6E94E++HE+gck8U6XL1Mwh1cfJw0m3Z5E0/L
         e3uF7yNsz2IlU5XDA5ABmthbh+yqASwTYqEzbCXTcet/nDrCdumnUfGLaXnBC+Ry3XNk
         8iQiFV4pb9/RUn8PvwWg8B5chfstlhSPwU19k2lH+uSPgBRlHjj4M5zdIWPyoMJdkmaj
         AqQM2eqy6rK7VE4Uhtb0sKb7ICe+Gjxjz5dv+6x1sibzU0njAiN4np0V/zR6mz8ReqrH
         /qbdi16xgBAL9DCM4VpVcfpG4EXweqX1swmCASzrUDYHW/8fGC3TGRc4lhNL+26zdwdh
         nm9Q==
X-Gm-Message-State: ACgBeo2DJmkzzGOYQl1cUEX6a0z/jHFHtcsV4NkrHsJLRxGHJZcve582
        1+XTv8sFuV9JJl2tZKNMhykq4yDj1YtLoxjk0K8ep9ewxmO5IGrnQMkfRs4J+RC8NSn9muxHOZ2
        CZCRm9poULFLw1ehO0h+M3jWa2rK8
X-Received: by 2002:a17:906:4795:b0:73d:d6e8:52a7 with SMTP id cw21-20020a170906479500b0073dd6e852a7mr23729561ejc.59.1662077988839;
        Thu, 01 Sep 2022 17:19:48 -0700 (PDT)
X-Google-Smtp-Source: AA6agR71etqoXM4HGXVz/MwtlqW3T8BbNkFPT5a/e9qOoDZWnrG77GI6lD81PpRdFOR9EqVhGDa/oA==
X-Received: by 2002:a17:906:4795:b0:73d:d6e8:52a7 with SMTP id cw21-20020a170906479500b0073dd6e852a7mr23729550ejc.59.1662077988617;
        Thu, 01 Sep 2022 17:19:48 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id lb14-20020a170907784e00b00741a0c3f4cdsm352041ejc.189.2022.09.01.17.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 17:19:48 -0700 (PDT)
Message-ID: <44a42d03-4dd1-3f1c-3a60-7c2a6a7d417a@redhat.com>
Date:   Fri, 2 Sep 2022 02:19:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, Marc Zyngier <maz@kernel.org>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, corbet@lwn.net,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        shuah@kernel.org, seanjc@google.com, drjones@redhat.com,
        dmatlack@google.com, bgardon@google.com, ricarkol@google.com,
        zhenyzha@redhat.com, shan.gavin@gmail.com
References: <20220819005601.198436-1-gshan@redhat.com>
 <20220819005601.198436-2-gshan@redhat.com> <87lerkwtm5.wl-maz@kernel.org>
 <41fb5a1f-29a9-e6bb-9fab-4c83a2a8fce5@redhat.com>
 <87fshovtu0.wl-maz@kernel.org> <YwTn2r6FLCx9mAU7@google.com>
 <87a67uwve8.wl-maz@kernel.org>
 <99364855-b4e9-8a69-e1ca-ed09d103e4c8@redhat.com>
 <874jxzvxak.wl-maz@kernel.org> <Yw4hyEAyivKT35vQ@xz-m1.local>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 1/5] KVM: arm64: Enable ring-based dirty memory
 tracking
In-Reply-To: <Yw4hyEAyivKT35vQ@xz-m1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/30/22 16:42, Peter Xu wrote:
> Marc,
> 
> I thought we won't hit this as long as we properly take care of other
> orderings of (a) gfn push, and (b) gfn collect, but after a second thought
> I think it's indeed logically possible that with a reversed ordering here
> we can be reading some garbage gfn before (a) happens butt also read the
> valid flag after (b).
> 
> It seems we must have all the barriers correctly applied always.  If that's
> correct, do you perhaps mean something like this to just add the last piece
> of barrier?

Okay, so I thought about it some more and it's quite tricky.

Strictly speaking, the synchronization is just between userspace and 
kernel. The fact that the actual producer of dirty pages is in another 
CPU is a red herring, because reset only cares about harvested pages.

In other words, the dirty page ring is essentially two ring buffers in 
one and we only care about the "harvested ring", not the "produced ring".

On the other hand, it may happen that userspace has set more RESET flags 
while the ioctl is ongoing:


     CPU0                     CPU1               CPU2
                                                 fill gfn0
                                                 store-rel flags for gfn0
                                                 fill gfn1
                                                 store-rel flags for gfn1
     load-acq flags for gfn0
     set RESET for gfn0
     load-acq flags for gfn1
     set RESET for gfn1
     do ioctl! ----------->
                              ioctl(RESET_RINGS)
                                                 fill gfn2
                                                 store-rel flags for gfn2
     load-acq flags for gfn2
     set RESET for gfn2
                              process gfn0
                              process gfn1
                              process gfn2
     do ioctl!
     etc.

The three load-acquire in CPU0 synchronize with the three store-release 
in CPU2, but CPU0 and CPU1 are only synchronized up to gfn1 and CPU1 may 
miss gfn2's fields other than flags.

The kernel must be able to cope with invalid values of the fields, and 
userspace will invoke the ioctl once more.  However, once the RESET flag 
is cleared on gfn2, it is lost forever, therefore in the above scenario 
CPU1 must read the correct value of gfn2's fields.

Therefore RESET must be set with a store-release, that will synchronize 
with a load-acquire in CPU1 as you suggested.

Paolo

> diff --git a/virt/kvm/dirty_ring.c b/virt/kvm/dirty_ring.c
> index f4c2a6eb1666..ea620bfb012d 100644
> --- a/virt/kvm/dirty_ring.c
> +++ b/virt/kvm/dirty_ring.c
> @@ -84,7 +84,7 @@ static inline void kvm_dirty_gfn_set_dirtied(struct kvm_dirty_gfn *gfn)
>  
>  static inline bool kvm_dirty_gfn_harvested(struct kvm_dirty_gfn *gfn)
>  {
> -       return gfn->flags & KVM_DIRTY_GFN_F_RESET;
> +       return smp_load_acquire(&gfn->flags) & KVM_DIRTY_GFN_F_RESET;
>  }
>  
>  int kvm_dirty_ring_reset(struct kvm *kvm, struct kvm_dirty_ring *ring)
> ===8<===
> 
> Thanks,
> 
> -- 
> Peter Xu
> 

