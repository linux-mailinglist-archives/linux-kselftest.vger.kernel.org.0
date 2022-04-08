Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DBC4F98B1
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 16:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbiDHO6E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 10:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbiDHO6D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 10:58:03 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7A4245AD;
        Fri,  8 Apr 2022 07:55:59 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id s11so10872299qtc.3;
        Fri, 08 Apr 2022 07:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RkQdhzMDs8tUm3hby//Hd4ev3pWtbOp3xvInpobyZS4=;
        b=lrvPVCsfGDkCGwWe+RqJphGmx2SiDaJ/okIVXFr8qJJlv4iQ0V5JkRw7+guRP5MaZw
         mSDnFKo0tUG8SHb/7TwFtprWvMIxR8/ouU0ZIgADO7mnBVZmIqpXtIXqhxOLaBkQG8Lf
         MXzCgZYkcqy/gIIW0fdXxdV/4AmvuSD1c0L9oQyKOoAgESKgyuvDqrC3xLPjHwcs6kSI
         3gBvM9nBKrAH4VCbo0mws7lAb+6OwhEpHeKM2Q2ymtjm+DXvVzPOBR/r5P1dnjBUVIDL
         e97dBtSrb3+S3OvirDjNe8NRRCKOtTA52lXeSjeZj+y3RaXdT5vClJ5bg0/IR9EuISIP
         /wPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RkQdhzMDs8tUm3hby//Hd4ev3pWtbOp3xvInpobyZS4=;
        b=O7gH5Xj0TmKfCVall1VEpN/QtiviTucJ/P40JovyktPZb99UwvJS/L4NYFT/+plqdW
         369QHxgYwVWKGNaOErtwIcUdVYeXRUfv3/wVURijUGJFv19Tb9gWSsEMIWDxZrxxLMQW
         yCZbPx27Wz0FYw9d7YinRtG58NgRn1gK5UVogphduRfdJFWxqBAeQYcU9JJudrWwD3uz
         l2C/VuLc1uHc3ce7ZaFMqDDUyDtjwjMIFENupekjXY/irKd9w7pu8hOZ/eZVb5h7KXXp
         umfp+aC3hWmNtQhub0NSPgK/s6M86lfmDxQ7MhaSS9LvkEdeuihYsqkTasTcnKczojOf
         2Eiw==
X-Gm-Message-State: AOAM531Q0/VpwAkJBNn0AuhV+eUIyvx/cARtyFVPeyEmxFvKs6nI943A
        Yl+a8UoRS5FMup6S7ZPNX588xQnBIb10pA==
X-Google-Smtp-Source: ABdhPJyFh17N7vhka55fTsXg+zkueUtsdgIx6jfkxsIhhuLZCq7xKih5mgpoDbLVzGhrMIqUs0yCdg==
X-Received: by 2002:ac8:7083:0:b0:2eb:b6b9:acec with SMTP id y3-20020ac87083000000b002ebb6b9acecmr16426324qto.465.1649429758703;
        Fri, 08 Apr 2022 07:55:58 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com ([2620:10d:c091:500::2:77ef])
        by smtp.gmail.com with ESMTPSA id x82-20020a376355000000b0069b971c58c1sm1411203qkb.60.2022.04.08.07.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 07:55:58 -0700 (PDT)
Date:   Fri, 8 Apr 2022 10:55:56 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/4] memcg: introduce per-memcg reclaim interface
Message-ID: <YlBM/HlPyPUZew5N@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
References: <20220408045743.1432968-1-yosryahmed@google.com>
 <20220408045743.1432968-2-yosryahmed@google.com>
 <YlA754XNFAmWQcm6@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
 <YlBCeadBqbeVvALK@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlBCeadBqbeVvALK@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 08, 2022 at 04:11:05PM +0200, Michal Hocko wrote:
> Regarding "max" as a possible input. I am not really sure to be honest.
> I can imagine that it could be legit to simply reclaim all the charges
> (e.g. before removing the memcg) which should be achieveable by
> reclaiming the reported consumption. Or what exactly should be the
> semantic?

Yeah, it just allows you to avoid reading memory.current to just
reclaim everything if you can specify "max" - you're still protected
by nretries to eventually bail out. Mostly, though I just feel like
supporting "max" makes memory.reclaim semetric with a lot of the
cgroup memory control files which tend to support "max".
