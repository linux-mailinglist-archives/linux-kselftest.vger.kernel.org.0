Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D5C4F971B
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 15:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbiDHNpL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 09:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiDHNpK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 09:45:10 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC656007D;
        Fri,  8 Apr 2022 06:43:06 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id b19so4779777qkk.12;
        Fri, 08 Apr 2022 06:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=usXuRJ1HBdyqGrxJX6MSUUEje7zULhcW0WK5TkC07EU=;
        b=JGvLuYecJdMvhSnQQgFQpCHMrAZp1psXgvW4Wojv80bQnyUjpdPY1Yz/DqdVdmQgQQ
         pvWKNO78nmCZgnU3ADHDBABagTnxyahI46DtiJxJVRQzlYeEHap+MwA2HpwzyoyDOo9p
         kmL77mgh5l4qdNdp3yFw/CVxBixxaPsKrJz6zmW5qinIGKYIxt3tpa0T1d6zGUcnDuDf
         rclg+AatTczypAJ6SxUXFQ689CwdUCeGdii7LVrDr3UM5zg0YEvRQXzKqcFcqI4FvkRi
         JQRMmH2pHZwahBOkt8ec4MIdUijj1lZt0bTK5ua3Zs9CXs+qRvwlaBGjVXNpT8jhrpkA
         K/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=usXuRJ1HBdyqGrxJX6MSUUEje7zULhcW0WK5TkC07EU=;
        b=XdNEJoZ9cmuTnd4EAg6U6om7zO8uclruN5gJVYG1NH8F2paaXY9PrJKHKACxH1BDPS
         aAbiBHudlwwJYyCUL5llLFl5KE/eMoLsUyRptiBzmLmDKbVZtLGt4FCxSULqT1C3RneP
         t/Z4OfuvRybg78kMj6wonzUzKpVaNnhuX6CeFy2ZAK053FMMHHPIz38TzBcC1xwdbRuu
         /auUMJy877+qXDo9pGdWhn4ppiPIgLz2QhFRUPanixTmCcbTNsiel6NSGMYHr1KjRmdL
         ZqtZ3n6pFuuoTY58ZhsgXRlTX5YKTp3OfovrZ5mMiQPK+hxDuwVbh8PSG8sSDdTYABdI
         buWg==
X-Gm-Message-State: AOAM530gEYUXb8Zdzrsx9PgsUKg2Ls/8AfUtnsSWsCRiKlfdB/TuzE3E
        8JBlGcbcEBjakcUgqOfuWyBclBLKA1Ehlg==
X-Google-Smtp-Source: ABdhPJwKb3j8nwLRTzxpkMdgP+ZKR36kQhmnucIRB4JxEvmQk5W70XZ9K3BjtfNj/y/WPSYCOCCD2g==
X-Received: by 2002:a37:92c1:0:b0:699:a3e5:f74 with SMTP id u184-20020a3792c1000000b00699a3e50f74mr12768518qkd.141.1649425385772;
        Fri, 08 Apr 2022 06:43:05 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com ([2620:10d:c091:500::2:77ef])
        by smtp.gmail.com with ESMTPSA id v12-20020a05622a130c00b002e1b3ccd9adsm17660596qtk.79.2022.04.08.06.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 06:43:05 -0700 (PDT)
Date:   Fri, 8 Apr 2022 09:43:03 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3 1/4] memcg: introduce per-memcg reclaim interface
Message-ID: <YlA754XNFAmWQcm6@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
References: <20220408045743.1432968-1-yosryahmed@google.com>
 <20220408045743.1432968-2-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408045743.1432968-2-yosryahmed@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 08, 2022 at 04:57:40AM +0000, Yosry Ahmed wrote:
> +static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> +			      size_t nbytes, loff_t off)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> +	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
> +	unsigned long nr_to_reclaim, nr_reclaimed = 0;
> +	int err;
> +
> +	buf = strstrip(buf);
> +	err = page_counter_memparse(buf, "", &nr_to_reclaim);

Is there a reason not to support "max"? Empty string seems odd to me
here.

> +	if (err)
> +		return err;
> +
> +	while (nr_reclaimed < nr_to_reclaim) {
> +		unsigned long reclaimed;
> +
> +		if (signal_pending(current))
> +			break;

I think this should be `return -EINTR;`

> +
> +		reclaimed = try_to_free_mem_cgroup_pages(memcg,
> +						nr_to_reclaim - nr_reclaimed,
> +						GFP_KERNEL, true);
> +
> +		if (!reclaimed && !nr_retries--)
> +			break;

Here you can just `return -EAGAIN;`

> +
> +		nr_reclaimed += reclaimed;
> +	}
> +
> +	return nr_reclaimed < nr_to_reclaim ? -EAGAIN : nbytes;

Then this can just be `return nbytes;`

I'm very much in favor of this new interface. Thanks for working on
it!
