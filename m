Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62FA01938DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 07:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgCZGtN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Mar 2020 02:49:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43716 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgCZGtN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Mar 2020 02:49:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id m11so448595wrx.10;
        Wed, 25 Mar 2020 23:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y4psBKXqPtMQHGDD9G3/UVc0Xd+VFzRe3hFm6IS58p0=;
        b=UjoPC7uF3WBBdKIXcCFujcbJEaFfpjqCfAPOApPz3XC90/gvtt708FrkoU8hDY++vp
         ORaBgcBQrUTPbrQMG4rIyylpegm3CVdAHpZrEoS9zYBhaCnUedkpxjLiN/mhl8ih/MnS
         eUcDHKsHowTcSq2xFxAsG3H39hpKX+Jcqjht39cX54o6OBudmZ6IHGIqAZWZKxydqIar
         85BmoSS91BGjSdk0vM0wGT5wrEQamLTu0ekfSJyC+3QbrHlFCmLpmvuqgki1tVc8tNpj
         0oSbAVSvV3iZoYDvn4A6gndz1lgLYYvxdnKoZIlWsTK7BK7r0nJAlpvaZ+C4QYQM4vps
         rIsw==
X-Gm-Message-State: ANhLgQ2OeyyHI99GpwG6MrtU/6zLjBCGCZUAG1OUg55T3uEw82Mrq9hS
        lPWXmulcO89Utv/ZaG9FuLg=
X-Google-Smtp-Source: ADFU+vsYkHP2H+pALnVpF91T9GwcryXmAjyQiSJ+3+DZsC6TZ76dyL1pE5MKqrHwjbWOtc1EcQMwTQ==
X-Received: by 2002:adf:fac7:: with SMTP id a7mr7803851wrs.191.1585205351825;
        Wed, 25 Mar 2020 23:49:11 -0700 (PDT)
Received: from localhost (ip-37-188-135-150.eurotel.cz. [37.188.135.150])
        by smtp.gmail.com with ESMTPSA id g2sm2247830wrs.42.2020.03.25.23.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 23:49:10 -0700 (PDT)
Date:   Thu, 26 Mar 2020 07:49:09 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rafael Aquini <aquini@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Eric B Munson <emunson@akamai.com>
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
Message-ID: <20200326064909.GB27965@dhcp22.suse.cz>
References: <20200323144240.GB23364@optiplex-lnx>
 <20200323145106.GM7524@dhcp22.suse.cz>
 <20200323150259.GD23364@optiplex-lnx>
 <20200323151256.GP7524@dhcp22.suse.cz>
 <20200323154159.GF23364@optiplex-lnx>
 <20200323155111.GQ7524@dhcp22.suse.cz>
 <20200323155449.GG23364@optiplex-lnx>
 <20200324154218.GS19542@dhcp22.suse.cz>
 <20200324154910.GM23364@optiplex-lnx>
 <20200325174949.95d8a9de61c6a30a7e0f4582@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325174949.95d8a9de61c6a30a7e0f4582@linux-foundation.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed 25-03-20 17:49:49, Andrew Morton wrote:
> On Tue, 24 Mar 2020 11:49:10 -0400 Rafael Aquini <aquini@redhat.com> wrote:
> 
> > Thanks Michal!
> > 
> >  
> > Acked-by: Rafael Aquini <aquini@redhat.com>
> 
> I'll add
> Fixes: 9c4e6b1a7027f ("mm, mlock, vmscan: no more skipping pagevecs")

Wouldn't be this misleading? It would suggest that this commit is
somehow incorrect. I would consider b3b0d09c7a23 ("selftests: vm: add
tests for lock on fault") to be a better fit.

> and cc:stable to this.  Any kernel which has 9c4e6b1a7027f will benefit
> from this change.

OK, makes sense with
Cc: stable # with 9c4e6b1a7027f applied
 
> We're getting quite late in the cycle now so I think I'll hold off
> merging this up until post-5.7-rc1.  It will still get into the stable
> trees, but a bit later.

No problem. Nothing really urget. Coincidentaly we've just had a report
from our partner about this very specific test failure for our
enterprise kernel as well. I will just backport the patch as it seems
nobody really objects to it.

Thanks!
-- 
Michal Hocko
SUSE Labs
