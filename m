Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E6549CD7A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 16:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242599AbiAZPMd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 10:12:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23652 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235639AbiAZPMd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 10:12:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643209952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UUIXRDsB43LqGC6wuVo5tX7u3LkbrScUsL4k4ngSu2Y=;
        b=K5Ldzbe8JCoUCaE6G36I0hAyIGV5Q8avoLdhKpClVXlZmxqtoSrzt31e3GyXPC4VKEEsQt
        YcwmHjRYPHPDmy+LaHVOgi07pDp7V4GyFroDOMIgqhyWG3PT5nQDiHxunRiJLsWzSg1tM2
        KFaRlDw7FB6uPVZ2nQ+TZanxhQkz9Vk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-2g8TLkecMGCvOFKobQbksg-1; Wed, 26 Jan 2022 10:12:31 -0500
X-MC-Unique: 2g8TLkecMGCvOFKobQbksg-1
Received: by mail-ej1-f69.google.com with SMTP id m21-20020a1709061ed500b006b3003ec50dso5018890ejj.17
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 07:12:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UUIXRDsB43LqGC6wuVo5tX7u3LkbrScUsL4k4ngSu2Y=;
        b=NUufwUvi3t80AEo720ya+Im5JPcY14zy9yHknAr5x+w+HADJ2FAnwouV1R1/xOAJP0
         xNWQf0YFUr40XTFnmrymU7yI7fM4WBWsr0L6/nlCC2WWCupYy4ONMAzUj2TUSW8KmWF+
         xsMDOBzjuNedNe9o71JOm8aBaMC7F0e43xznz4f8WaRsdE5ax9MnWuiEbsfYYpcsBIiw
         t+WUthE/NxpqgXGVRPYPxhPj/ILxj1pY+f7OMfSj/853+1X5ndKuAQLqOY0ESgyLEV4p
         W2Z/ff9J0g9fO+DhF4Ig6vDyEVU7BylCzdpU1DG42jX86Ky2h66tj9COnpAbJi92a6cQ
         Caaw==
X-Gm-Message-State: AOAM530J3CSRHxQFApD0r3S2vWc0ET/WWYAK0t2LVhXDjkMsUDC6CDRo
        57iuBRx3ETEJs/U+T/b6XYy5Ob5BWD1Eiy2DPOI4dWAdiPqsREG/Dar9KrCtHexj7c6h4aQrLE8
        vDxNR9HtfHN9UAOmGEapDjjl4q2ro
X-Received: by 2002:a05:6402:1e93:: with SMTP id f19mr24928681edf.343.1643209949954;
        Wed, 26 Jan 2022 07:12:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6Qy96gPxqMhyDBBrrHHmi32FfITBGmSSHPgu5dt26Cvx+nGMpg11N+n6bAEnecDU6AecWoQ==
X-Received: by 2002:a05:6402:1e93:: with SMTP id f19mr24928663edf.343.1643209949742;
        Wed, 26 Jan 2022 07:12:29 -0800 (PST)
Received: from gator (cst2-173-70.cust.vodafone.cz. [31.30.173.70])
        by smtp.gmail.com with ESMTPSA id u17sm7479631ejb.31.2022.01.26.07.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 07:12:29 -0800 (PST)
Date:   Wed, 26 Jan 2022 16:12:27 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] kselftest: kvm/arm64: Skip tests if we can't create a
 vgic-v3
Message-ID: <20220126151227.jlhb5o32jwal24m6@gator>
References: <20220126145242.3473836-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126145242.3473836-1-broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 26, 2022 at 02:52:42PM +0000, Mark Brown wrote:
> The arch_timer and vgic_irq kselftests assume that they can create a
> vgic-v3, using the library function vgic_v3_setup() which aborts with a
> test failure if it is not possible to do so. Since vgic-v3 can only be
> instantiated on systems where the host has GICv3 this leads to false
> positives on older systems where that is not the case.
> 
> Fix this by changing vgic_v3_setup() to return an error if the vgic can't
> be instantiated and have the callers skip if this happens. We could also
> exit flagging a skip in vgic_v3_setup() but this would prevent future test
> cases conditionally deciding which GIC to use or generally doing more
> complex output.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> 
> v3:
>  - Use custom print_skip() helper.
>  - Use internal version of _kvm_create_device.
> v2:
>  - The test for being able to create the GIC doesn't actually
>    instantiate it, add a call doing so in that case.
> 
>  tools/testing/selftests/kvm/aarch64/arch_timer.c | 7 ++++++-
>  tools/testing/selftests/kvm/aarch64/vgic_irq.c   | 4 ++++
>  tools/testing/selftests/kvm/lib/aarch64/vgic.c   | 4 +++-
>  3 files changed, 13 insertions(+), 2 deletions(-)
>

 
Reviewed-by: Andrew Jones <drjones@redhat.com>

