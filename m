Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCD97CD7E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 11:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjJRJ0U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 05:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjJRJ0T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 05:26:19 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062A3FD;
        Wed, 18 Oct 2023 02:26:18 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c9e95aa02dso44166155ad.0;
        Wed, 18 Oct 2023 02:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697621177; x=1698225977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DoC9cEOpVyHe6rQ4YNPNMkBTm2d/jp8/btvfUz5j+5E=;
        b=MPXoftSN46r1r+3kEHsMqWLFmWV0JRMilkPXtbllzI0wHePNkTXSDu13DnpvYNxgg1
         ZaXiPQTEx/Cs6PRu/OwDUlsPQkYsIyJYNl5znmr0iqRl3I06mtGCMORmbmJ3e95X0E2g
         Blw79yVmuctoAAW3maKAT6KxMo6mmH+4oi8rdLM1yhvRNTuhvt0hEZVtd51n+n1BZh0o
         +FuMxGbGnsuHaIASdEtv9rK1oVM3FAHAMXi7V9xUE35sZhfn06je2UQ16/hN6xM2LMEK
         p3X7VjG1D8KijWY8vAi2gWDdQCwXDVMukf67soZDWaKgD3sSs0AdiQlOgtFb5Pm0pQJG
         avmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697621177; x=1698225977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DoC9cEOpVyHe6rQ4YNPNMkBTm2d/jp8/btvfUz5j+5E=;
        b=hlvJmLmdOhZbPdk20D0bBNn3xVCI+nTN49bZ+GuABEyB+ufoOsREZVfLOWLvC6RiNn
         xzFycHsW/U5KgkBsGgB8ccVkyNavpxxSMW/BuqgUSIxgBSdfy9LNh8ZA7fByMDhISt1g
         ssuVXyVG+vYmA6qWAfBcN18q74QANQVdd+wMGLmsnbe2to3Og1/d9L3DcdtSC3ukepPD
         bHei2r04vDQOlic1WgmaTlRk3Xv2yFRXtAZtAgXYcCXwxU04exHu7uTzJPJNFPAw5Aym
         W9LKdYDsCCiAf7M4ZP3zeozDId8c12FlDjujN4zogZ8Q852yd2uyUb7MEatbwCUAK9WF
         l2Pg==
X-Gm-Message-State: AOJu0YySjaKL/QYLHc0PeDfJxGNQqifNnLpjix6LUAPJ0Qst0dRrTjmo
        aESQHakjexIvBz9gXMgS2u4=
X-Google-Smtp-Source: AGHT+IG0urvGJ1LbGmBoSOLCgMNs6ixDrKXCnQCLCyYaWGrnKCurREGxlCTFq78k2qT32KhXjGiryw==
X-Received: by 2002:a17:903:60b:b0:1ca:15ad:1c5 with SMTP id kg11-20020a170903060b00b001ca15ad01c5mr4812195plb.6.1697621177413;
        Wed, 18 Oct 2023 02:26:17 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id x18-20020a17090300d200b001bdd7579b5dsm3072041plc.240.2023.10.18.02.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 02:26:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 17 Oct 2023 23:26:15 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH-cgroup 3/4] cgroup/cpuset: Keep track of CPUs in isolated
 partitions
Message-ID: <ZS-kt6X5Dd1lktAw@slm.duckdns.org>
References: <20231013181122.3518610-1-longman@redhat.com>
 <20231013181122.3518610-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013181122.3518610-4-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 13, 2023 at 02:11:21PM -0400, Waiman Long wrote:
...
> @@ -3875,6 +3931,13 @@ static struct cftype dfl_files[] = {
>  		.flags = CFTYPE_ONLY_ON_ROOT | CFTYPE_DEBUG,
>  	},
>  
> +	{
> +		.name = "cpus.isolated",
> +		.seq_show = cpuset_common_seq_show,
> +		.private = FILE_ISOLATED_CPULIST,
> +		.flags = CFTYPE_ONLY_ON_ROOT | CFTYPE_DEBUG,
> +	},

I'd much rather show this in a wq sysfs file along with other related masks,
and not in a DEBUG file.

Thanks.

-- 
tejun
