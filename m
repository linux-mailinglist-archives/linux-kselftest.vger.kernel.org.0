Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B4574E03D
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 23:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjGJVaQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 17:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjGJVaP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 17:30:15 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC6FDE;
        Mon, 10 Jul 2023 14:30:14 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666ecf9a0ceso2565446b3a.2;
        Mon, 10 Jul 2023 14:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689024614; x=1691616614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EuY7YWF+Kh1UKEuVmzs1ImB1X2StsWyaHb8EJ2edbSU=;
        b=b3unhp+1fEq1qyFirSnAUKqpNzuFjhYYSuty9IalbkDlKvc7XoIUkCzsQX53+qqMso
         NwXyfA1g9Xij5ua20EZYWee/MO0shqL3wMkRZAmF3/qpeczM4vPXnasiWO7nmM4zPbpr
         0hXqvIK9ovnj6bBskOJYe09WNUA7ZqVrWMXhlSpXhpAhs0U/uUmVhjPB3K5UT9VZvAox
         7vtXOPRSOOHV8Ak+7M8NJNupp2LhUxzIWpQk6ViFHF13n0NiADBRyjZyT1Y1TJstujDg
         qypPLEV3FJqR1rVskyvFRj9wLqdVoPTFtB/kSQLbNmTPRoK8nmjff2VZGWr2tnc4YlPm
         3/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689024614; x=1691616614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EuY7YWF+Kh1UKEuVmzs1ImB1X2StsWyaHb8EJ2edbSU=;
        b=RmspFaZmcZcgZ1PyGHc4kwrbbfrv/8VXziY8AVnNbahfyo8x8pdl3F21VaG3fcox4O
         OZQpkXl+mvCBfCwlMAlPu4qszUeMnsTU2z6ZZDt31pBGt35tW3nUQqx/k0cFy9A6W2mv
         NAxM/wUaS+xFbFyFq+sXLndt39ITM4+vjBGzUnge8gVoMCwv66LB83vf5SxOZEujfLYH
         pkmh5UshbDMtKHo0x5rwSu5c2Lml4ZalooMDRxxVisn3h+oGwaAqp4da/fNlkEc8HDUl
         9MPmX+W4X3K0PuD5CGiv4WZ2DRVa2KoTOCCTuLdE0gFTZUnjxOdFk9/4UHnCYPbEhcaO
         tarw==
X-Gm-Message-State: ABy/qLZAOqwITqQaQUFjC1FvjTnhze3u8XnT9qC3Ntygf+KDrlCDEJpT
        Vl2j0QW6ef/Vw5VqyMB81phzU4ixrOVt/A==
X-Google-Smtp-Source: APBJJlEw5l9hIhPZnhlmln9tqLygtL8HWCz1m+ezNtvsanxXvgqKiIThDzls38J3M8LUWfBPuFLq+w==
X-Received: by 2002:a05:6a00:1782:b0:666:8403:9f4 with SMTP id s2-20020a056a00178200b00666840309f4mr16380908pfg.16.1689024613985;
        Mon, 10 Jul 2023 14:30:13 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id a10-20020a62bd0a000000b0067db7c32419sm266518pff.15.2023.07.10.14.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 14:30:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Jul 2023 11:30:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mrunal Patel <mpatel@redhat.com>,
        Ryan Phillips <rphillips@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v4 8/9] cgroup/cpuset: Documentation update for partition
Message-ID: <ZKx4ZJowRhRtjZxB@slm.duckdns.org>
References: <20230627143508.1576882-1-longman@redhat.com>
 <20230627143508.1576882-9-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627143508.1576882-9-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On Tue, Jun 27, 2023 at 10:35:07AM -0400, Waiman Long wrote:
...
> +	There are two types of partitions - local and remote.  A local
> +	partition is one whose parent cgroup is also a valid partition
> +	root.  A remote partition is one whose parent cgroup is not a
> +	valid partition root itself.  Writing to "cpuset.cpus.exclusive"
> +	is not mandatory for the creation of a local partition as its
> +	"cpuset.cpus.exclusive" file will be filled in automatically if
> +	it is not set.	The automaticaly set value will be based on its
> +	"cpuset.cpus" value.  Writing the proper "cpuset.cpus.exclusive"
> +	values down the cgroup hierarchy is mandatory for the creation
> +	of a remote partition.

Wouldn't a partition root's cpus.exclusive always contain all of the CPUs in
its cpus? Would it make sense for cpus.exclusive to be different from .cpus?

Thanks.

-- 
tejun
