Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2D921935D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 03:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbgCZCW6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Mar 2020 22:22:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:33439 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727639AbgCZCW6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Mar 2020 22:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585189373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NIQcksW7yW4TfwD44gTdCNCKJx/+8JRLEdw6NqGBbGU=;
        b=gVhDqnn3l2cPZyrB2kW0mgy+dS2GxMKE1ei6ZyfgItTA/NiR2HhRFAPjrhzIUSo1QXTa3+
        YjVi/MHwO9qP59wtg8FFpcSEg7hZMFg72ULLeVJDY2CZUr+YR2lrvPvYTyvEWfoSHRKR4Q
        S1sk8dXDpnuQifN0uzJmOMYvKzpeIzo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-gjbcgJ8mNzegqoy-O6v07Q-1; Wed, 25 Mar 2020 22:22:49 -0400
X-MC-Unique: gjbcgJ8mNzegqoy-O6v07Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 007AC8017CE;
        Thu, 26 Mar 2020 02:22:48 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.33.36.220])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DF1ED1001925;
        Thu, 26 Mar 2020 02:22:45 +0000 (UTC)
Date:   Wed, 25 Mar 2020 22:22:42 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Eric B Munson <emunson@akamai.com>
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
Message-ID: <20200326022242.GB5728@optiplex-lnx>
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
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 25, 2020 at 05:49:49PM -0700, Andrew Morton wrote:
> On Tue, 24 Mar 2020 11:49:10 -0400 Rafael Aquini <aquini@redhat.com> wrote:
> 
> > Thanks Michal!
> > 
> >  
> > Acked-by: Rafael Aquini <aquini@redhat.com>
> 
> I'll add
> Fixes: 9c4e6b1a7027f ("mm, mlock, vmscan: no more skipping pagevecs")
> and cc:stable to this.  Any kernel which has 9c4e6b1a7027f will benefit
> from this change.
> 
> We're getting quite late in the cycle now so I think I'll hold off
> merging this up until post-5.7-rc1.  It will still get into the stable
> trees, but a bit later.
>

Thank you, Andrew

-- Rafael 

