Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A631FC4BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jun 2020 05:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgFQDgK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jun 2020 23:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgFQDgJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jun 2020 23:36:09 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C977C06174E
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 20:36:09 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s135so604295pgs.2
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 20:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DLJBB3pRoWG5efQHi3veUFRcagcqJ+oWknNXTwAk0o0=;
        b=NcmAqGk+iRuqRcsBVf4/+Ex0k/oFPhiAYwMxrL0tiAKhUfjO6L9sXlM9BOpAI6QVbu
         KDVYyPvTr3mHFIUXiuuzh8dTwGEfhsa0pRlk7EZ2vdpybUMt71pw5yS5SLUilMgf9lvA
         KLYKhZNTSD40IU6tRKvcLbIBTkgWccHUzP0bQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DLJBB3pRoWG5efQHi3veUFRcagcqJ+oWknNXTwAk0o0=;
        b=oSVr0KXlortnlaoKZMjUX9mbrXNiIhymICH/evglag6zXk7wGYz/4Cn9wdCpnr73L0
         gkgvhfAFUntICi+0Z+93jIavZLQzhnMuSitVeNA4Z3R+Agv2W5nMFH3oEMPIZgzm4RHt
         FRWI2slPfKALB5yy2/Gj/Mi0YDeggCL1l6fpVVK5cBHwpVgfXz8VgHsNVOpgL65DdBPF
         3P4eJY5ApARuklO/gAeDIxZ+V0iOoNni26r4v+zrILO3SXJf+QbW4d/0vlxNvYgc/Bcz
         Z8GswVl4BVYm10PmN1XKYLrw8NZ8gkydhgHggyZb//Br1do39op0OenWQp+L18HR8nGb
         E47g==
X-Gm-Message-State: AOAM533ezg5UKWp27VbErDiGz0p1Ik06pbBu8fjq70v6Nl1LxUnAM0Cq
        08hdmDUmqnurh+vgM731CjoDhw==
X-Google-Smtp-Source: ABdhPJzt2IyfSrsCjbnEWsH+80i2Sph0IP1u82KvDONyDI5ns9Z8WN7IKClvSiOHQihmzNQ32Orptg==
X-Received: by 2002:a63:778c:: with SMTP id s134mr4407440pgc.273.1592364968589;
        Tue, 16 Jun 2020 20:36:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lt14sm3797226pjb.52.2020.06.16.20.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 20:36:07 -0700 (PDT)
Date:   Tue, 16 Jun 2020 20:36:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Gow <davidgow@google.com>
Subject: Re: RFC - kernel selftest result documentation (KTAP)
Message-ID: <202006162032.9BF6F8F4E@keescook>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <20200616204817.GA212825@google.com>
 <CY4PR13MB1175A71AE3937C0786721ABFFD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006161703.B2E51605@keescook>
 <CY4PR13MB1175DCC4066FC0839A6B2E84FD9A0@CY4PR13MB1175.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR13MB1175DCC4066FC0839A6B2E84FD9A0@CY4PR13MB1175.namprd13.prod.outlook.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 17, 2020 at 02:30:45AM +0000, Bird, Tim wrote:
> Agreed.  You only need machine-parsable data if you expect the CI
> system to do something more with the data than just present it.
> What that would be, that would be common for all tests (or at least
> many test), is unclear.  Maybe there are patterns in the diagnostic
> data that could lead to higher-level analysis, or even automated
> fixes, that don't become apparent if the data is unstructured.  But
> it's hard to know until you have lots of data.  I think just getting
> the other things consistent is a good priority right now.

Yeah. I think the main place for this is performance analysis, but I
think that's a separate system entirely. TAP is really strictly yes/no,
where as performance analysis a whole other thing. The only other thing
I can think of is some kind of feature analysis, but that would be built
out of the standard yes/no output. i.e. if I create a test that checks
for specific security mitigation features (*cough*LKDTM*cough*), having
a dashboard that shows features down one axis and architectures and/or
kernel versions on other axes, then I get a pretty picture. But it's
still being built out of the yes/no info.

*shrug*

I think diagnostic should be expressly non-machine-oriented.

-- 
Kees Cook
