Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239C64DBA47
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Mar 2022 22:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356056AbiCPVp5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Mar 2022 17:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356917AbiCPVpt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Mar 2022 17:45:49 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1241AF35
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Mar 2022 14:44:34 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id u30-20020a4a6c5e000000b00320d8dc2438so4281188oof.12
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Mar 2022 14:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=jaTnWfP5Ctwr90+tTsSeB1mPeSYn8clE+CkG+kehTNk=;
        b=I4xUDzI1RQ9uhmUTrNp9Zl9awT7HtuyhW42gT4zUQGO2cTzapPafEa21pW2fJjSJh6
         M/drMRkTXwYbNkaj5qy/FlNRZ5Wal9fzyfAv5mmZE2ufle/Nnf51tWlLZ6vApCGvmJ/b
         HQYvCayrrItYl4WZl+KlwNQdbE9TFlLbt9XdKw/zBmvw6XzOVWA/FL3QJSU5ptQbbz/J
         FBGKWI5meAce6LYi9WaOSqvYJNWhTOvnbZP0iIxV9LXiAd+oDHU6/FZIUtawnMbfPqNe
         4X9OqWGaDHdwpDxUymsjkc58xeoVpXwq0ru5BfsR/re+n0rvku5p7aDCw6V8AIDDshWr
         GkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=jaTnWfP5Ctwr90+tTsSeB1mPeSYn8clE+CkG+kehTNk=;
        b=U3kUQjVCjqWytUV9fft9P/nAAQcUGh328BWkF8Y652WhdhYPhxOa8Ce5o+H56UeJTC
         TCVcH8mHhKBxbwtJXG+aJ2hL6VxkX5M1HJTC5v0mcjbf36JXy8XbVn4FU/+mF7XxYU3y
         K8+KFRrEWKbpdxxZ2HvxbSXcjSoGX4u9HZ0T5H80IcSMOyv992o36ZRfYR5PGCvveCBk
         4K6qKIJZJP8IMQ/uwk1bloSmaljIsSoSo4rMb5hwUDpciRT625yS5aucs/sofVQUNOnU
         9PUAy6Nj4YHdLTWq/ptj2g9Xirf6TdAg/oWKHJVNf6pXxowBKBcIyiCHb5gGugHjztff
         6gkg==
X-Gm-Message-State: AOAM530N29qiQf6KidXTg4l1JUHCL6BfdiuaMlJlDhQWIiaC80v8CXvC
        ceXkPARcMKJLi+Uv8CgEllzfunA6i6KAPW0hADc=
X-Google-Smtp-Source: ABdhPJyn2zMtJrrUWIhbSfg3xPJmr73k3HTxz5k9k2IpYSZgp00Taw6kZsoWEYPNqF8D9fjRROZaKQ==
X-Received: by 2002:a05:6870:9617:b0:d7:5d73:8545 with SMTP id d23-20020a056870961700b000d75d738545mr677058oaq.15.1647467073556;
        Wed, 16 Mar 2022 14:44:33 -0700 (PDT)
Received: from localhost ([2804:14d:7e39:8470:b171:978c:2a42:8690])
        by smtp.gmail.com with ESMTPSA id a19-20020a056808099300b002da1428db03sm1441975oic.7.2022.03.16.14.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 14:44:33 -0700 (PDT)
References: <20220225165923.1474372-1-broonie@kernel.org>
 <20220225165923.1474372-12-broonie@kernel.org>
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
Subject: Re: [PATCH v12 11/40] arm64/sme: Identify supported SME vector
 lengths at boot
Date:   Wed, 16 Mar 2022 18:32:47 -0300
In-reply-to: <20220225165923.1474372-12-broonie@kernel.org>
Message-ID: <8435jhd13g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Just a small suggestion:

Mark Brown <broonie@kernel.org> writes:

> diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
> index d08062bcb9c1..550e1fc4ae6c 100644
> --- a/arch/arm64/include/asm/cpu.h
> +++ b/arch/arm64/include/asm/cpu.h
> @@ -64,6 +64,9 @@ struct cpuinfo_arm64 {
>=20=20
>  	/* pseudo-ZCR for recording maximum ZCR_EL1 LEN value: */
>  	u64		reg_zcr;
> +
> +	/* pseudo-SMCR for recording maximum ZCR_EL1 LEN value: */
> +	u64		reg_smcr;
>  };

Perhaps append =E2=80=9Cwhen in streaming mode=E2=80=9D to the comment abov=
e (or mention
streaming mode in some other way), to convey the difference between
reg_smcr and reg_zcr?

--=20
Thiago
