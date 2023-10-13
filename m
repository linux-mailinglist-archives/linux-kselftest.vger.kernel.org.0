Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17EB7C7DAF
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 08:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjJMGaJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 02:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJMGaJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 02:30:09 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D421BB
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Oct 2023 23:30:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ad8a822508so284846466b.0
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Oct 2023 23:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697178606; x=1697783406; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VlsSN+I3I9LHiPwm/QKJMqlA+Ye2MfSqfYL2XdtaW2Y=;
        b=kmk531rilXQUitnIFp9+oUDcWEIFn3EkAiUTqjilzD+6skqrDBAFIkzuF2vbhRV3IY
         dYz+U3lQMXAuZN3p51mn8zPfmAd92XKcnORcVfDe21cOWVlUXYOQ80WTqEHG74OP38Er
         pXzeFsMe8OCfrK/mJrxfDA+65C18JRFAxbCeRFVvakpoiv9GGND+FfGAi16Gsv2Rlzb0
         N8eNHMLj/Si1tYc7na9bsT4TapSI01jelyL0ciajLXTmusQWqjdwrg/xS3cOND335CeJ
         qbhpC5hh1BgXn5H7KKp1KXSROC3Yo22l8SDGSZFXyx/QBWJCh5z0a7c2XacBYdpWlAdb
         Sj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697178606; x=1697783406;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VlsSN+I3I9LHiPwm/QKJMqlA+Ye2MfSqfYL2XdtaW2Y=;
        b=QXNdXwqVsz5qZLEDI5N6oG3XVUq9jI9v6qcGrp//z2XBksW4+WmttCVTyNijU700rt
         FOVlZOMMH5i7MQvSA68HiYAZfNW7sV+YhiMHUn42GFFz/LAQ/D+3ptrjWIAxaNRqHCd4
         JY9SsCZsDl5g3M/c+ASTLuRwgcjOK7gLJwOXkKMAJUoDn+mLOgQ1xSEmlj3FeCR2T8C9
         +1Uc1gP90SSsQxbfxde21NSEklFVDUR7a/cvtD4urNr/JPgD/Yn9tZjvbspJXuWxLfQu
         D7Y/cU0C/wItsmTjJ+D9FI5nDfI1ZQCNl6p8sFyOv3OOs//7voN2PypgZTB27UV3VnOy
         vUzg==
X-Gm-Message-State: AOJu0YwHYctA2CUkjtHPlDFUI87cQ3ae9htNytjRlViiX7mcgfZTlKtR
        9Cy3KmahU+mKV/rUGJ0OhyEWMg==
X-Google-Smtp-Source: AGHT+IGNOnSs8xzdJgEFPUtBqJj/23r2Laz3t651Htk71AKDs3MXt3CmE6/6M6hLxyJLTO+zXBbR+Q==
X-Received: by 2002:a17:907:8b8c:b0:9a2:28dc:4166 with SMTP id tb12-20020a1709078b8c00b009a228dc4166mr24507418ejc.75.1697178605714;
        Thu, 12 Oct 2023 23:30:05 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id kf24-20020a17090776d800b009b95787eb6dsm11882433ejc.48.2023.10.12.23.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 23:30:05 -0700 (PDT)
Date:   Fri, 13 Oct 2023 08:30:04 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Haibo Xu <haibo1.xu@intel.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Initialise dynamically allocated
 configuration names
Message-ID: <20231013-0fb230037c78d2c397e691c7@orel>
References: <20231013-kvm-get-reg-list-str-init-v1-1-034f370ff8ab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231013-kvm-get-reg-list-str-init-v1-1-034f370ff8ab@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 13, 2023 at 12:19:30AM +0100, Mark Brown wrote:
> When we dynamically generate a name for a configuration in get-reg-list
> we use strcat() to append to a buffer allocated using malloc() but we
> never initialise that buffer. Since malloc() offers no guarantees
> regarding the contents of the memory it returns this can lead to us
> corrupting, and likely overflowing, the buffer:
> 
>   vregs: PASS
>   vregs+pmu: PASS
>   sve: PASS
>   sve+pmu: PASS
>   vregs+pauth_address+pauth_generic: PASS
>   X�vr+gspauth_addre+spauth_generi+pmu: PASS
> 
> Initialise the buffer to an empty string to avoid this.
> 
> Fixes: 17da79e009c37 ("KVM: arm64: selftests: Split get-reg-list test code")

Doh, this is an embarrassing bug. But the patch above just moves the buggy
code. I'm still guilty for the bug, but the fixes tag should be

Fixes: 2f9ace5d4557 ("KVM: arm64: selftests: get-reg-list: Introduce vcpu configs")

> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/kvm/get-reg-list.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing/selftests/kvm/get-reg-list.c
> index be7bf5224434..dd62a6976c0d 100644
> --- a/tools/testing/selftests/kvm/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/get-reg-list.c
> @@ -67,6 +67,7 @@ static const char *config_name(struct vcpu_reg_list *c)
>  
>  	c->name = malloc(len);
>  
> +	c->name[0] = '\0';
>  	len = 0;
>  	for_each_sublist(c, s) {
>  		if (!strcmp(s->name, "base"))
> 
> ---
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
> change-id: 20231012-kvm-get-reg-list-str-init-76c8ed4e19d6
>

Other than the tag,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
