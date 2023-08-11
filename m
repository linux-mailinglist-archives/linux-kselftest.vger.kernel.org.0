Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2A3778755
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 08:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjHKGRi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 02:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjHKGRh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 02:17:37 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E602D4F
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 23:17:36 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bc7e65ea44so11977865ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 23:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691734656; x=1692339456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zT3po1gHIt6nPnvjsqOOvRKd1niJj75SVykGMENxpsE=;
        b=CspI2QH/oPGq3QjFLjbOhAgBHsclK/zfrD/U/vxI0yWfOjtL8ftBGpzRjqU4PUaAL6
         ofDVscUYH3PeuOn5xSkr2RnTzeXHOQgecckMFMV62bGm9qJfBSiu0OUcyHn1Rt9PjNM9
         ANLlgpOPQo9d1nSHqZUCNLHI3I4MZSu2SONMN71BbVzpSUYxbXofbXfpYRhrwLNXTEwp
         WRHkt3lnAzcaHu3t54x+2uHQxZIglWW5YPluFfUVmXAC6m2ZFTpjKttVxmEc6uMnLFut
         y+Doyr4BOUIW3rLUeO7McH8cW40GoCNWQOiLbTOeMQkJIocmg8t3/zrr0DZKLR8DhyG3
         XMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691734656; x=1692339456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zT3po1gHIt6nPnvjsqOOvRKd1niJj75SVykGMENxpsE=;
        b=PqWI5A6pqrwkZYH0jBxzd7q89nxIyZLcZQUnZIAp3P9volCHoDGBxNdFcRGDMjcDHU
         LmOzPhvs87mpgdmtj5JaAqEuCYJebLvDOgw29+dw0zrCx81QqhPxziv2farY1MS9Fmu7
         RHDLqOb6qR6sQZnF7ZWhAbay7LBXNcpp5SFaClAF/a8tOZvGgfaOnpYRtHO70UIV4sB6
         uFPK/Zwu4VxPDB3JzdV2rJxjUDf0vw41UDqCIUDO7rCZdDlNbS2Ub0gp0nRzQjGInpSA
         PJwjjBV4EPt22+sEPXKKM1FO0qa1AY8M4bw+x79aMoMzpQRkL3GV+qXffk+rCh25Xq8j
         gcrg==
X-Gm-Message-State: AOJu0YzkW5S0JmKC62p8YH3AdXE7iI+9AiTMiObfc2XevGKqOoB7r3Dh
        kmQn2TVJbjjUGRl+CpsQvz3qeA==
X-Google-Smtp-Source: AGHT+IFKziwPEu+qyJ63lojKtvSeYDeu+04YrQlRjRIh2+V5Kvfbjv07QAHfSLIpUnieYaUVrXz30w==
X-Received: by 2002:a17:902:e84f:b0:1bc:e37:aa76 with SMTP id t15-20020a170902e84f00b001bc0e37aa76mr5729526plg.6.1691734656165;
        Thu, 10 Aug 2023 23:17:36 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903120500b001bbc8d65de0sm2913338plh.67.2023.08.10.23.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 23:17:35 -0700 (PDT)
Date:   Fri, 11 Aug 2023 11:47:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Meng Li <li.meng@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-acpi@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH V2] cpufreq: amd-pstate-ut: Modify the function to get
 the highest_perf value
Message-ID: <20230811061733.mvqlir3nbnzdp6tx@vireshk-i7>
References: <20230803014354.3304825-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803014354.3304825-1-li.meng@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 03-08-23, 09:43, Meng Li wrote:
> The previous function amd_get_highest_perf() will be deprecated.
> It can only return 166 or 255 by cpuinfo. For platforms that
> support preferred core, the value of highest perf can be between
> 166 and 255. Therefore, it will cause amd-pstate-ut to fail when
> run amd_pstate_ut_check_perf().
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  drivers/cpufreq/amd-pstate-ut.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

-- 
viresh
