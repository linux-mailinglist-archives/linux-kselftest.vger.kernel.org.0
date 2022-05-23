Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFDD5313A9
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 May 2022 18:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbiEWNsj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 May 2022 09:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236644AbiEWNse (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 May 2022 09:48:34 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5303B5640E;
        Mon, 23 May 2022 06:48:27 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id b200so3816347qkc.7;
        Mon, 23 May 2022 06:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZfWVPz+O1VSySrCT+nJSG/7hKIl6GIpKGGB50irRGQA=;
        b=Bmy+GrmaprGd+QUoHPtV6p2akpIBOwmGaSVblfNXPYa1i23LW/I/aFXK9blqxsncEv
         2kZPkZXHc07NwIWUxuLNRqDsPuFSOAQzCYMhPlFJdT/p0quwwPg2Dk33t2MXw+lCCiz/
         qP5wKeDj3WQrp4VLJtTpRK3HZT3eo6rrYu5lh/xIfU9c+VchrHMcntOcjaKg0nrh83s3
         WucZLSJ1VF062NnVguCk79DujnqqB3jrv7epKI7SM/XJt9lIjqKuvjMC3SH0oP6eDhbE
         cO8Xg47+32sgWpx2heKZzjhHBRoeE51UEnfTQY3z4hikWwWNYoR9tG9vsui16qCr+gHR
         2ivQ==
X-Gm-Message-State: AOAM531xCWr2V9tm0YzjQ4YBOpxpDUy7fIA22IyswXXtaLK76FHxXx0t
        aDTA3ehVfxCan7nvOcpWGEs=
X-Google-Smtp-Source: ABdhPJzRuT8KiH9S+tSHH3yTDcVglcx6KatfL3zJcjRfefdWiIC4BjibdZdsn/zp4XMQgHXguq28xw==
X-Received: by 2002:a37:62cd:0:b0:6a3:4cbe:e74e with SMTP id w196-20020a3762cd000000b006a34cbee74emr9058442qkb.550.1653313706187;
        Mon, 23 May 2022 06:48:26 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-020.fbsv.net. [2a03:2880:20ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id t6-20020a05622a01c600b002f93aeaf770sm904648qtw.92.2022.05.23.06.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 06:48:25 -0700 (PDT)
Date:   Mon, 23 May 2022 06:48:23 -0700
From:   David Vernet <void@manifault.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dan.carpenter@oracle.com, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] cgroup: Fix an error handling path in
 alloc_pagecache_max_30M()
Message-ID: <20220523134823.lcbruwv5eodueoag@dev0025.ash9.facebook.com>
References: <628312312eb40e0e39463a2c06415fde5295c716.1653229120.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <628312312eb40e0e39463a2c06415fde5295c716.1653229120.git.christophe.jaillet@wanadoo.fr>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, May 22, 2022 at 04:18:51PM +0200, Christophe JAILLET wrote:
> If the first goto is taken, 'fd' is not opened yet (and is un-initialized).
> So a direct return is safer.
> 
> Fixes: c1a31a2f7a9c ("cgroup: fix racy check in alloc_pagecache_max_30M() helper function")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  tools/testing/selftests/cgroup/test_memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index c3d0d5f7b19c..8833359556f3 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -448,7 +448,7 @@ static int alloc_pagecache_max_30M(const char *cgroup, void *arg)
>  	high = cg_read_long(cgroup, "memory.high");
>  	max = cg_read_long(cgroup, "memory.max");
>  	if (high != MB(30) && max != MB(30))
> -		goto cleanup;
> +		return -1;
>  
>  	fd = get_temp_fd();
>  	if (fd < 0)
> -- 
> 2.34.1
> 

Acked-by: David Vernet <void@manifault.com>
