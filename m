Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F02D4DA5C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Mar 2022 23:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344033AbiCOW5k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Mar 2022 18:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242097AbiCOW5h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Mar 2022 18:57:37 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BA05D5E8
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Mar 2022 15:56:23 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id h10so875078oia.4
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Mar 2022 15:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=ljhqCefXzcruXQp9WtlPDBfDUy90SHN1xf9SfOB4wXo=;
        b=JJdvfR6X7QbqEPUgushUKYa1RNBQkRRR4WC3wPNl5kIq/jo7YTlvg2icY93SRLQXUh
         /H3mr3foM2w4Zeg0j43gJ+lyqTZfkwfWNtS7hhqrgDZzg1uMGpAMthALWh/NvjFIn0uk
         z3f1NAhLXblGVwDuppexEX2ch+IXdxztXMB0CgXCRibvmSYeh9K1kwtyLMGeo6P19j1N
         Jtli/+ReQBAwDCc1T90MIaQrwJ+HgvzDdaWem43Q2c+fFy3/26A9/HhbRTJRjcCnbG5G
         EuQjWi2H+mQ7i+YNbP971nB8QNYJ9z541H61yb1PbWeBwslBmfI5P8ltP7wPBHkp0K1e
         VZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=ljhqCefXzcruXQp9WtlPDBfDUy90SHN1xf9SfOB4wXo=;
        b=DMEYjl3HSa269617sFzRnxHXpFmEBAT67S1CL9+Ta4GsPALOJM7WGQJuYztX0ad4xD
         uR8GUpHQ8QOR/OV7PxdQcvTdpISmAa3jX4eFNVtbRJlXyV0WI/jFo4sVkduBjqZOEkcw
         smN51NvZRJfY7957YinK6wz6ekUR7VMOycWM9q+jVLww4MqHiQChdwtllhVqaeMji0CR
         voi3iEV1jbsq0yVQvOUVga/5AB74d5Lxj0mrWK1/87o0xxqfFzE5dt/hwbNwowBB+XKj
         3edY4IuNAScttVWwieQzUhsqSg3e37FEx37KVdjP0jj70fwRLk1GDmn+VnLmpojmU3K8
         hfmw==
X-Gm-Message-State: AOAM533BIRtgps6doArasnr7lSbIPofJ2jyXCnwPRAZHITiE2WfzJlB8
        +A6RsJXHaJDhjvQNHc0+yVrtmA==
X-Google-Smtp-Source: ABdhPJxBltnxj+cRdTc3QSEmr5cFA2sw31omFs/+72HwwBL1IWZvFZ6qtR1216vBiT4g5Njj0Zdmuw==
X-Received: by 2002:aca:db03:0:b0:2da:363b:658b with SMTP id s3-20020acadb03000000b002da363b658bmr2763996oig.173.1647384983257;
        Tue, 15 Mar 2022 15:56:23 -0700 (PDT)
Received: from linaro.org ([189.4.186.55])
        by smtp.gmail.com with ESMTPSA id a19-20020a056808099300b002da1428db03sm247765oic.7.2022.03.15.15.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 15:56:22 -0700 (PDT)
References: <20220225165923.1474372-1-broonie@kernel.org>
 <20220225165923.1474372-24-broonie@kernel.org>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v12 23/40] arm64/sme: Add ptrace support for ZA
Date:   Tue, 15 Mar 2022 18:51:36 -0300
In-reply-to: <20220225165923.1474372-24-broonie@kernel.org>
Message-ID: <84v8werfn3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Hello,

Just one trivial comment:

Mark Brown <broonie@kernel.org> writes:

> +static int za_get(struct task_struct *target,
> +		  const struct user_regset *regset,
> +		  struct membuf to)
> +{
> +	struct user_za_header header;
> +	unsigned int vq;
> +	unsigned long start, end;
> +
> +	if (!system_supports_sme())
> +		return -EINVAL;
> +
> +	/* Header */
> +	memset(&header, 0, sizeof(header));
> +
> +	if (test_tsk_thread_flag(target, TIF_SME_VL_INHERIT))
> +		header.flags |= ZA_PT_VL_INHERIT;
> +
> +	header.vl = task_get_sme_vl(target);
> +	vq = sve_vq_from_vl(header.vl);
> +	header.max_vl = sme_max_vl();
> +	header.max_size = ZA_PT_SIZE(vq);
> +
> +	/* If ZA is not active there is only the header */
> +	if (thread_za_enabled(&target->thread))
> +		header.size = ZA_PT_SIZE(vq);
> +	else
> +		header.size = ZA_PT_ZA_OFFSET;
> +
> +	membuf_write(&to, &header, sizeof(header));
> +
> +	BUILD_BUG_ON(ZA_PT_ZA_OFFSET != sizeof(header));
> +	end = ZA_PT_ZA_OFFSET;
> +;

Stray semicolon.

> +	if (target == current)
> +		fpsimd_preserve_current_state();
> +
> +	/* Any register data to include? */
> +	if (thread_za_enabled(&target->thread)) {
> +		start = end;
> +		end = ZA_PT_SIZE(vq);
> +		membuf_write(&to, target->thread.za_state, end - start);
> +	}
> +
> +	/* Zero any trailing padding */
> +	start = end;
> +	end = ALIGN(header.size, SVE_VQ_BYTES);
> +	return membuf_zero(&to, end - start);
> +}

-- 
Thanks,
Thiago
