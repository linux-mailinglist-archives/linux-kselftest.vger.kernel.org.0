Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34550512016
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Apr 2022 20:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243244AbiD0QZm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Apr 2022 12:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243381AbiD0QYj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Apr 2022 12:24:39 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47876231692;
        Wed, 27 Apr 2022 09:18:49 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id v10so1813202pgl.11;
        Wed, 27 Apr 2022 09:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mqASqeNgn2MnRKKvwUc4ZQ7zeAhzxAmdAAXdF7mi3dg=;
        b=VPYVt0nOnYVYZR60ZA6lctKmm/WOzCKfgCNGoiZ4E9EYKXM3a8SzhPw7rwq3lmJ9Va
         p90WEIuEcSNY8OZWEnnOLx0GSm4nVQ93Elr89pi1oYOwDl8bS98H8WxP79KZj9PFHaRH
         nwIkbRDVgIbMuMxCi9PxMEa2Riru3C1Ohn2Fs3atKkNKXXgF4L2Ml7swXiVL6ttY4fFE
         53/lNcov94euEqSTnTw9eozsCNmF0YbJJeAiMFn+G+SvlMT77Q/gyoKTBTO6HKwi+VHL
         S1/FQNRSP/h+e6aUTaX3OSLFlxYLKYpeiS/yRqZbiz65EP5Vv3a+yaqEmUdmWvNs4Qns
         0ujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mqASqeNgn2MnRKKvwUc4ZQ7zeAhzxAmdAAXdF7mi3dg=;
        b=RLdBvyBrpxX5hui1yrLYi4GDtYo4hRaSVltAXan9BOhy6zWWWR3XxLWLwwEYtABJwB
         JHIfNxYAYmcHIhM4k/NOAsTeBZMoHiGQrMKTI2dSBhQ8yePDLLS654V/eGT3aqZqmN9B
         Y/qfruqHUVpJp7BAh3VwOFHNYUantVYCjL0NS4+C61s+U/DOX/3+wkBliq/3mvaUiuHL
         6o1HyttaiwezFrTivmuZMEtWTeKG0EwKovQvbyUnXidLwrSpgqbkCsB+ndWyVWpPjYkI
         cK0jad+K6v8D963pXkwYEIF6mMvrIyfoHiIfPdAIDUnEJZfLuc9IYuD5lzx/Am1qHkcO
         noTQ==
X-Gm-Message-State: AOAM5311xG4XJs35EpnunW+gar9ODdpg3Gtso6Rtcc2o/r+/CEdmsoo/
        sTPXxzslgzX8OTQyqoUqLylCHJ4qU9Y=
X-Google-Smtp-Source: ABdhPJylGofNVmOaPFlpu9B/m3r7wliPYu5BslrXyLzQ5pgRedl3bvbInBeBujOFxwCrealaY9G5/w==
X-Received: by 2002:a63:834a:0:b0:3ab:5946:17b with SMTP id h71-20020a63834a000000b003ab5946017bmr12162950pge.59.1651076324945;
        Wed, 27 Apr 2022 09:18:44 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:4f81])
        by smtp.gmail.com with ESMTPSA id o41-20020a17090a0a2c00b001d75aabe050sm3386122pjo.34.2022.04.27.09.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 09:18:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 27 Apr 2022 06:18:42 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, shuah@kernel.org,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] selftests: cgroup: Fix unsigned expression compared with
 zero
Message-ID: <Ymls4pydYPMBtyCm@slm.duckdns.org>
References: <20220427061756.56893-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427061756.56893-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 27, 2022 at 02:17:56PM +0800, Jiapeng Chong wrote:
> Fix the following coccicheck warnings:
> 
> ./tools/testing/selftests/cgroup/cgroup_util.c:566:8-12: WARNING:
> Unsigned expression compared with zero: size < 0.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  tools/testing/selftests/cgroup/cgroup_util.c | 2 +-
>  tools/testing/selftests/cgroup/cgroup_util.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
> index 4c52cc6f2f9c..661e06b94a43 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.c
> +++ b/tools/testing/selftests/cgroup/cgroup_util.c
> @@ -552,7 +552,7 @@ int proc_mount_contains(const char *option)
>  	return strstr(buf, option) != NULL;
>  }
>  
> -ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t size)
> +ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, ssize_t size)

Converting input size parameter to ssize_t doesn't make sense. I don't see
where it's doing size < 0 either but that's probably where it should be
fixed.

-- 
tejun
