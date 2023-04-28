Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB7F6F1447
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Apr 2023 11:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345468AbjD1JhH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Apr 2023 05:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjD1JhG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Apr 2023 05:37:06 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1753AB2;
        Fri, 28 Apr 2023 02:37:05 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-1a8097c1ccfso97844835ad.1;
        Fri, 28 Apr 2023 02:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682674624; x=1685266624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTEzTPu2IUqI1aWq3K0d1qux/fcUnEztVJOEixtCdn0=;
        b=RaiDNepmv9Qqx/jrvOwZq+WoNJf2ZVNNzl4ji2b3okLdKMX+7B3KMZL2cFT9mTB7ot
         Bi3MJzit+ncFn4FVvOR/TjWXYitG3oEujevSGG9UfjJR65GhO8ANWdfp/CB8mziqJw6w
         ASO5bJ4z8tn8ODnT3oO2mOj+at+zlWzQ5t64LQ0nahw5QWmSiOqq6aBKefQC/fkF4DLd
         WYPqY8hmVFM4CEZX6eWj23Si/xVbiZIfC1PvqWSN7xl888AjzsRCYL32K1inCg+wLoIT
         zmmRSYbUYm2YgOsyn2V+SIsoAT0LR93l6og3veH8T0lM2c73pCa8EMihimYNvh5qo3n/
         MzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682674624; x=1685266624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTEzTPu2IUqI1aWq3K0d1qux/fcUnEztVJOEixtCdn0=;
        b=JW5paXlo/Vv11D89FWAcxtKFy8zuG+ONEJp20rlY+bu2oI+1SAKcH3VNTaT2WGDLZw
         rVeFf+PwBy1tk0Tuiyi5eK7VN5HzXG2VHTOGSj5oR4xVHuwH9OI2ZoceL39gfloDO8f0
         hYyU5XLltv3ivE4FKDxomFKqz+wZCzeHZJWoM8AzAApLP5VcKDs29+Pc5ZS+UhfR0lXR
         XRBO9S5MwUa+QlOkdaaZ8M/sGy4smR+df7J/gr8+FdqEnCzD4S58UJdkCKWM3Ukm0R6u
         Qj0iNNEM86JOgzBnS23PZxznmhglOaI2NLqZMTRZVJMqoFwU5mzidiSCxIowELvn61f1
         2fqg==
X-Gm-Message-State: AC+VfDxWVkuxImuiqRM+/sysitxsXms7nknqt7sjikGI0d6WBR3Or8P8
        KSIwHlw4kVgEqPl+SDLPOwk=
X-Google-Smtp-Source: ACHHUZ4DjfNE11FGNiMCbCrke+rYMVWKogo2JxoZLEfw/P7rLMcKpdWVjpQcH2dQuoOaSJ8hsfrYjw==
X-Received: by 2002:a17:903:124f:b0:1a6:7fac:1b7d with SMTP id u15-20020a170903124f00b001a67fac1b7dmr5547750plh.59.1682674624574;
        Fri, 28 Apr 2023 02:37:04 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n19-20020a170902969300b001a6db2bef16sm12872864plp.303.2023.04.28.02.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 02:37:04 -0700 (PDT)
From:   xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     shr@devkernel.io
Cc:     akpm@linux-foundation.org, bagasdotme@gmail.com, david@redhat.com,
        hannes@cmpxchg.org, kernel-team@fb.com, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mhocko@suse.com, riel@surriel.com, willy@infradead.org,
        yang.yang29@zte.com.cn, xu.xin16@zte.com.cn
Subject: [PATCH v9 2/3] mm: add new KSM process and sysfs knobs
Date:   Fri, 28 Apr 2023 17:36:59 +0800
Message-Id: <20230428093659.23962-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230418051342.1919757-3-shr@devkernel.io>
References: <20230418051342.1919757-3-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> This adds the general_profit KSM sysfs knob and the process profit metric
> knobs to ksm_stat.
> 
> 1) expose general_profit metric
> 
>    The documentation mentions a general profit metric, however this
>    metric is not calculated.  In addition the formula depends on the size
>    of internal structures, which makes it more difficult for an
>    administrator to make the calculation.  Adding the metric for a better
>    user experience.
> 
> 2) document general_profit sysfs knob
> 
> 3) calculate ksm process profit metric
> 
>    The ksm documentation mentions the process profit metric and how to
>    calculate it.  This adds the calculation of the metric.
> 
> 4) mm: expose ksm process profit metric in ksm_stat
> 
>    This exposes the ksm process profit metric in /proc/<pid>/ksm_stat.
>    The documentation mentions the formula for the ksm process profit
>    metric, however it does not calculate it.  In addition the formula
>    depends on the size of internal structures.  So it makes sense to
>    expose it.
>

Hi, Stefan, I think you should give some credits to me about my contributions on
the concept and formula of ksm profit (process wide and system wide),  it's kind
of idea stealing.


Besides, the idea of Process control KSM was proposed by me last year although you use
prctl instead of /proc fs. you even didn't CC my email. I think you should CC my email
(xu.xin16@zte.com.cn) as least.
 
> 5) document new procfs ksm knobs
> 
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Rik van Riel <riel@surriel.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  Documentation/ABI/testing/sysfs-kernel-mm-ksm |  8 +++++++
>  Documentation/admin-guide/mm/ksm.rst          |  5 ++++-
>  fs/proc/base.c                                |  3 +++
>  include/linux/ksm.h                           |  4 ++++
>  mm/ksm.c                                      | 21 +++++++++++++++++++
>  5 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-ksm b/Documentation/ABI/testing/sysfs-kernel-mm-ksm
> index d244674a9480..6041a025b65a 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-ksm
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-ksm
> @@ -51,3 +51,11 @@ Description:	Control merging pages across different NUMA nodes.
>  
>  		When it is set to 0 only pages from the same node are merged,
>  		otherwise pages from all nodes can be merged together (default).
> +
> +What:		/sys/kernel/mm/ksm/general_profit
> +Date:		April 2023
> +KernelVersion:  6.4
> +Contact:	Linux memory management mailing list <linux-mm@kvack.org>
> +Description:	Measure how effective KSM is.
> +		general_profit: how effective is KSM. The formula for the
> +		calculation is in Documentation/admin-guide/mm/ksm.rst.
> diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
