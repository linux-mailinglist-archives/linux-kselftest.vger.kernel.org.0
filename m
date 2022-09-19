Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FFF5BD1FD
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Sep 2022 18:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiISQRO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Sep 2022 12:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiISQRJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Sep 2022 12:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85D02983A
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Sep 2022 09:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663604227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xn5fnqKtyryYA5w5sfE3wIiUTcmcdDi6qpfcSbkJ4Lw=;
        b=R10g2q7MF069L96xyxjbx86o6FVyu4S0FAG/4+qRdbU1yYZ4JlzKbnSRyHeTPm5rOqWdi1
        2V+mUuaLpQqlTNmjZcjsYiFLmIfLGQ/jP356MtQ0Ut6wX5Y3n+mUC7bzj7DZnCJHXMqrmf
        nIAon8/sbTvv7sJfAxuar2nPyYQ+8Qo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-228-0kFHq870M9Su2l73Ybwosw-1; Mon, 19 Sep 2022 12:17:05 -0400
X-MC-Unique: 0kFHq870M9Su2l73Ybwosw-1
Received: by mail-qk1-f197.google.com with SMTP id v15-20020a05620a0f0f00b006ceab647023so10184445qkl.13
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Sep 2022 09:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Xn5fnqKtyryYA5w5sfE3wIiUTcmcdDi6qpfcSbkJ4Lw=;
        b=P/5IUWMYk4L3LbOGy/ne/77eTOQBTwekq2PUIund2zXY6vCvo/fgca7slG7IBc6jV0
         7awoPqRaDxACgPeNEZPZ8BJOw7yMtakWklIhqhHlssVOmIsHoGP8/LOJmTBm/KVmUObn
         EcSrIKBRIAITTFcf85fbl+NO5Z8+mvDyy3dYLteV7gB/a6fvkMj50kF2LAIw1DrvHe7H
         wO42Yd7iPNbSJH467NJjvpj59OEQxvxrgwuS59tnau2iYyvk+76eGsysAxtlt44vGvgs
         O+fQdnGxDR6PrCwmB4W4a6S6rmmhdxakCbVlWOc3aSI3xnuuIIyMejV4YGhL/cbO+5+P
         tFAg==
X-Gm-Message-State: ACrzQf0wUhkeSpC1P0WZeo34llkkl2iCrPgnTujzx2Kwauku085Got1E
        SJDZnlj2+4JLh0Dg3dsi27AQQTxnKcBIp4i4gbMUOAlBrpjPuydXsVQz/AXEObON38R2PTtqbUj
        RGD2tibpeAhR3AqHW8lL63mbrb6l1
X-Received: by 2002:ac8:5e0a:0:b0:35c:e8d8:6c19 with SMTP id h10-20020ac85e0a000000b0035ce8d86c19mr5068666qtx.178.1663604225351;
        Mon, 19 Sep 2022 09:17:05 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM51+LmYDmB5JjErlr4hYbacMbbiBwggTg81wkAjJVlWGP8agHsUu4S5cY7WS6QJw0cvQ6qJIg==
X-Received: by 2002:ac8:5e0a:0:b0:35c:e8d8:6c19 with SMTP id h10-20020ac85e0a000000b0035ce8d86c19mr5068640qtx.178.1663604225144;
        Mon, 19 Sep 2022 09:17:05 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id bv12-20020a05622a0a0c00b0035cf2995ad8sm826570qtb.51.2022.09.19.09.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 09:17:04 -0700 (PDT)
Date:   Mon, 19 Sep 2022 12:17:02 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        catalin.marinas@arm.com, linux-kselftest@vger.kernel.org,
        bgardon@google.com, shuah@kernel.org, corbet@lwn.net,
        drjones@redhat.com, will@kernel.org, zhenyzha@redhat.com,
        dmatlack@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        oliver.upton@linux.dev, shan.gavin@gmail.com
Subject: Re: [PATCH v2 1/5] KVM: x86: Introduce KVM_REQ_RING_SOFT_FULL
Message-ID: <YyiV/l7O23aw5aaO@xz-m1.local>
References: <20220916045135.154505-1-gshan@redhat.com>
 <20220916045135.154505-2-gshan@redhat.com>
 <YyS78BqsQxKkLOiW@xz-m1.local>
 <87illlkqfu.wl-maz@kernel.org>
 <a2e0b9bc-2c67-8683-d722-7298bd65058c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a2e0b9bc-2c67-8683-d722-7298bd65058c@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 19, 2022 at 09:58:10AM +1000, Gavin Shan wrote:
> I think Marc's explanation makes sense. It won't make difference in terms
> of performance. We need to explicitly handle barrier when kvm_test_request()
> is used. So I prefer to keep the code if Peter agrees.

No strong opinion here. I keep thinking clear+set look awkward even if it's
unlikely path to trigger (ring should be recycled when reaching here for
any sane user app), but if it's already 2:1 then please go ahead. :)

Thanks,

-- 
Peter Xu

