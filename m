Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC995A2663
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 13:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242003AbiHZLBx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 07:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344178AbiHZLBW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 07:01:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED87DCFF8
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Aug 2022 03:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661511511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jMnbTKtNSpTsqq0eZVxc5+MQ+KePmpUNSlwTet2oL2k=;
        b=eGtLDKFj7bMqPqGtzox0UOQ3E+T//5Syz7kr6b96pblaX1i0qRwQANBTFl69SxALsp6rez
        zQ0mF84CuWsTrk9mblo35rSzs9u2OYNus2riqZBdTNUnZOQ/vs8q/X0TfUUex4ZzmQ4NN3
        5pe86DAZaHJyCvi7Py0dbSLTrHAdl10=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-398-6sFBvxb6PH6iyV_uyZcWzQ-1; Fri, 26 Aug 2022 06:58:29 -0400
X-MC-Unique: 6sFBvxb6PH6iyV_uyZcWzQ-1
Received: by mail-ej1-f70.google.com with SMTP id qb39-20020a1709077ea700b0073ddc845586so477478ejc.2
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Aug 2022 03:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=jMnbTKtNSpTsqq0eZVxc5+MQ+KePmpUNSlwTet2oL2k=;
        b=2/+6bXrqluiIQh6enbdz+LN9P/t2J0n7WsqZDrVGel9msUVN8JA8TgGUKNutCSTTLO
         8Si1lkkJRf0BIQ2rusdmM6AJZ/SE5ZpsXhkW4Qm5hpw3vU5p4LkayisVE/MsRv4Sr7Uz
         FmIVrSQBwLZoSHr03cnX7iRbWypX0UPizELsZaeqX+grWuEbRJ3s5MMy/JdmUv+Nd8oQ
         DqTlwZ18sI2f9N4qopqwPVlOmKUNeMUj21VU7uBcQCLvdxWkPAK7lD/gj5LJCA2Me7i4
         yEaBpN8WQIHy6KmQSG8ynMXq99pHRff4QqL2a5DJVqX7GOFELon8t/SlUqGHdfxnJU3U
         0elw==
X-Gm-Message-State: ACgBeo1fDEbkHro0uLuAlongKYQVO04gqCj23ze1a7w1UGKqa5HtIdRm
        LxFQuAL7mUVdYJo3Pglo48mOGIcFttcdEGmM1aMfolIkzG9dYhiVyEtPYj/zdsqMfzLRgN70mW+
        NidL7LFxWG8oi6OatghBmig1s6CIv
X-Received: by 2002:a05:6402:5150:b0:447:933d:ec65 with SMTP id n16-20020a056402515000b00447933dec65mr6212660edd.80.1661511508656;
        Fri, 26 Aug 2022 03:58:28 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4J7blDIUmOh5lFPHJwf/tJLIYkgJgvljjD4T11ziyn6v4vnxonXD5Bpxyrz7ntlO6vhSx/Hw==
X-Received: by 2002:a05:6402:5150:b0:447:933d:ec65 with SMTP id n16-20020a056402515000b00447933dec65mr6212653edd.80.1661511508460;
        Fri, 26 Aug 2022 03:58:28 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id p17-20020a50cd91000000b004479cec6496sm1102859edi.75.2022.08.26.03.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 03:58:27 -0700 (PDT)
Message-ID: <99364855-b4e9-8a69-e1ca-ed09d103e4c8@redhat.com>
Date:   Fri, 26 Aug 2022 12:58:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>
Cc:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, peterx@redhat.com, corbet@lwn.net,
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
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 1/5] KVM: arm64: Enable ring-based dirty memory
 tracking
In-Reply-To: <87a67uwve8.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/23/22 22:35, Marc Zyngier wrote:
>> Heh, yeah I need to get that out the door. I'll also note that Gavin's
>> changes are still relevant without that series, as we do write unprotect
>> in parallel at PTE granularity after commit f783ef1c0e82 ("KVM: arm64:
>> Add fast path to handle permission relaxation during dirty logging").
>
> Ah, true. Now if only someone could explain how the whole
> producer-consumer thing works without a trace of a barrier, that'd be
> great...

Do you mean this?

void kvm_dirty_ring_push(struct kvm_dirty_ring *ring, u32 slot, u64 offset)
{
         struct kvm_dirty_gfn *entry;

         /* It should never get full */
         WARN_ON_ONCE(kvm_dirty_ring_full(ring));

         entry = &ring->dirty_gfns[ring->dirty_index & (ring->size - 1)];

         entry->slot = slot;
         entry->offset = offset;
         /*
          * Make sure the data is filled in before we publish this to
          * the userspace program.  There's no paired kernel-side reader.
          */
         smp_wmb();
         kvm_dirty_gfn_set_dirtied(entry);
         ring->dirty_index++;
         trace_kvm_dirty_ring_push(ring, slot, offset);
}

The matching smp_rmb() is in userspace.

Paolo

