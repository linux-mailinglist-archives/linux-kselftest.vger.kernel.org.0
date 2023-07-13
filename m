Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA430752767
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 17:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbjGMPje (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 11:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjGMPjd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 11:39:33 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDF32117
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 08:39:32 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id ca18e2360f4ac-78706966220so5745239f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1689262772; x=1691854772;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Edz8S9/DYDu/Er6Wbo87AVay2HssoKiTC5UZFfGh+BM=;
        b=BgEmFI4pgRVRFPcWdSBdvexlbchTLIUxW+mARHWI1QZKPCYcySxKTuX6R+8L0jCYIr
         IV/FTs4+ChFfscqQbKkB59+fbjo1a+E0a4HNKl+R8sVjahiFy8U3RhQD84Jbyqbt+F4/
         5yr94rr+YlMfJ3qNQlhiKzDXq4sRAEf3VpOUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689262772; x=1691854772;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Edz8S9/DYDu/Er6Wbo87AVay2HssoKiTC5UZFfGh+BM=;
        b=VWbxQxRAJCnlE6wxs4wMz8xB8cyi/UbiJONTP/qo5+RSS3nTi1ymcM3GNDDsdCgADJ
         UavAWZyPqb1r+FIgbYU+GOWnqcSFXx156Sb8pqZXylrwuj/danR2cylCbyr2zT5yudHD
         6iz4oZmb1ohPfeMIRw0ixdzAlH0kEesHmFELJ6XzHlio2vYxEYnp3TinFNpLgsPFyDwQ
         oWKkkXdVgXPD4TKhAsSQv22KrkJRPKdlv4U2LU2Y+vPm9Dnp0rh5UTVJBDHOqUzyfJLs
         Aj1pbmNvzV3Mbu69WuF82P6bpeLe+DeVH+8Asqd69HMgL8PYhnv2V0InpYK3SPmyA3Zj
         UeKQ==
X-Gm-Message-State: ABy/qLZrN95WK0E4zF+NOc2dKGKHEM1QTUFYpg0OImIiuEsF1jhjESKi
        dxasmDamFXBKATFk8YpeIDJohA==
X-Google-Smtp-Source: APBJJlHXCW1r6HGRFe1uL46adGj5+gGhTWF7xgaES+0aANFvwXNPy7BA0J7LwrFPf5OwZWyWj3Hkmg==
X-Received: by 2002:a6b:8d10:0:b0:780:cde6:3e22 with SMTP id p16-20020a6b8d10000000b00780cde63e22mr2010448iod.0.1689262771932;
        Thu, 13 Jul 2023 08:39:31 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id cz8-20020a0566384a0800b0042bb09e9345sm1938458jab.90.2023.07.13.08.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 08:39:31 -0700 (PDT)
Message-ID: <e4aed85b-8543-cede-6257-5807b07f2de9@linuxfoundation.org>
Date:   Thu, 13 Jul 2023 09:39:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND PATCH] selftests/mincore: fix skip condition for
 check_huge_pages test
Content-Language: en-US
To:     =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>,
        shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, naresh.kamboju@linaro.org,
        dan.carpenter@linaro.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20230629083546.3031488-1-ricardo.canuelo@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230629083546.3031488-1-ricardo.canuelo@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/29/23 02:35, Ricardo Cañuelo wrote:
> The check_huge_pages test was failing instead of skipping on qemu-armv7
> because the skip condition wasn't handled properly. Add an additional
> check to fix it.
> 
> Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> Closes: https://lore.kernel.org/all/CA+G9fYuoB8Ug8PcTU-YGmemL7_eeEksXFihvxWF6OikD7sK7pA@mail.gmail.com
> ---
>   tools/testing/selftests/mincore/mincore_selftest.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 

Thank you for the patch and sorry for the delay due to conference
travel and vacation.

Will be queued for the next rc.

thanks,
-- Shuah

