Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7015F1EF848
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jun 2020 14:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgFEMsX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Jun 2020 08:48:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46242 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726499AbgFEMsX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Jun 2020 08:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591361301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eO1D3JEFx3gMyiYe03xD1d+mWzCgrlVM6JLDMuUPpwI=;
        b=HoHfI3/tB7+HeilpL1Jd+0KsMn5HCNh2ckp81PWMODwkEngcXQh5iuAmKiLQBfhhjZpVAE
        3hHfCYLfMbVeOMIlEvohEOKD8nolBvu2uQfYFZU+gXCRzo66IqIvKbIpDI8fL9WIvD5A9D
        AkuDjvQGANB4DjxzobJOhYCDzHjGjXg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-DXSP4htrOg2Wfrj1xeAy1Q-1; Fri, 05 Jun 2020 08:48:19 -0400
X-MC-Unique: DXSP4htrOg2Wfrj1xeAy1Q-1
Received: by mail-qt1-f197.google.com with SMTP id u26so8295608qtj.21
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Jun 2020 05:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eO1D3JEFx3gMyiYe03xD1d+mWzCgrlVM6JLDMuUPpwI=;
        b=H+50N8fnzRgoUqg8/Fg8nnkTvJsS+yifrictvm9MV0GI8UTXFFy4k90n0XMzBr9vCR
         w9nRk2r3BLP5W6KUbE08h3WYILHGSHA2eA8AI3clPT9idxRW9njN5igDDoIdyYg2GuCY
         aI51wECEc4oy7mdD84sVhnX5J75ds+edbejKAeQHzYdNDgzpCQ+tTPYPWjt+tSnorT7H
         CYiF9/FpICnWJGYuRK6JNSMUdlcw4Q235BlsJEoV6V6Yu0aEqifKAUCkN7p+cDsCVPvw
         wjpW0UcpCvQtTT5i+4wCCCibCrxna1rx8+rQ7PxBJALSOaFPIDxAv5sUQi2e+dq0vreU
         c/CQ==
X-Gm-Message-State: AOAM533thTCdxm+yDZqGOXfY8Enkz/umrIEv/OGgWK2VWG3FAOylGFL3
        Wz/s+CAankdp6WdqKoOZ8i0V+A00IYtKdhkoXmLl2sjbpfE/3IoYOKrhCou08efwMIaLIrA6kd9
        NsruTIl74wZnqiEmhliivZ3isujEg
X-Received: by 2002:aed:21af:: with SMTP id l44mr10019744qtc.124.1591361299524;
        Fri, 05 Jun 2020 05:48:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKVSPnObIIx/lF3VrXTnCi0p2UjVU2aEXiipGyR5R5g+TcrRTsbvtNz/PEa3g8UQfd15ZLLQ==
X-Received: by 2002:aed:21af:: with SMTP id l44mr10019726qtc.124.1591361299260;
        Fri, 05 Jun 2020 05:48:19 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j5sm7534542qtr.73.2020.06.05.05.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 05:48:18 -0700 (PDT)
Date:   Fri, 5 Jun 2020 08:48:16 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Jones <drjones@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ben Gardon <bgardon@google.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: delete some dead code
Message-ID: <20200605124816.GB55548@xz-x1>
References: <20200605110048.GB978434@mwanda>
 <9f20e25d-599d-c203-e3d4-905b122ef5a3@redhat.com>
 <20200605115316.z5tavmf5rjobypve@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200605115316.z5tavmf5rjobypve@kamzik.brq.redhat.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 05, 2020 at 01:53:16PM +0200, Andrew Jones wrote:
> On Fri, Jun 05, 2020 at 01:16:59PM +0200, Paolo Bonzini wrote:
> > On 05/06/20 13:00, Dan Carpenter wrote:
> > > The "uffd_delay" variable is unsigned so it's always going to be >= 0.
> > > 
> > > Fixes: 0119cb365c93 ("KVM: selftests: Add configurable demand paging delay")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > ---
> > >  tools/testing/selftests/kvm/demand_paging_test.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> > > index 360cd3ea4cd67..4eb79621434e6 100644
> > > --- a/tools/testing/selftests/kvm/demand_paging_test.c
> > > +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> > > @@ -615,8 +615,6 @@ int main(int argc, char *argv[])
> > >  			break;
> > >  		case 'd':
> > >  			uffd_delay = strtoul(optarg, NULL, 0);
> > > -			TEST_ASSERT(uffd_delay >= 0,
> > > -				    "A negative UFFD delay is not supported.");
> > >  			break;
> > >  		case 'b':
> > >  			vcpu_memory_bytes = parse_size(optarg);
> > > 
> > 
> > The bug is that strtoul is "impossible" to use correctly.

Could I ask why?

> > The right fix
> > would be to have a replacement for strtoul.
> 
> The test needs an upper limit. It obviously doesn't make sense to ever
> want a ULONG_MAX usec delay. What's the maximum number of usecs we should
> allow?

Maybe this test can also be used to emulate a hang-forever kvm mmu fault due to
some reason we wanted, by specifying an extremely large value here?  From that
POV, seems still ok to even keep it unbound as a test...

Thanks,

-- 
Peter Xu

