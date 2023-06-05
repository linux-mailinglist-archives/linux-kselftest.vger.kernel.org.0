Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1509722B5E
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 17:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbjFEPj5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 11:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbjFEPjs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 11:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04805D2
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 08:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685979543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MQkr2X8nA9Tbhw8fess+euxrCcam9DnIxmBl/XeagVo=;
        b=G8bCimn1Vkb9ZXVgJC58KymE6MrdiadGdNj4/qljGJK2Dlj2ziXqIC96zLyrVwp5GoCAiQ
        eNZZhdW04+F9ovO8YGLzPZ39sEr5hOnDmud8yUKdQVbvBMkeXo43Na7M/aBvMFweL4c8dB
        f63WzgB9NY2pOD/K6YDPAOtGUJFVa9c=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-1tIwtJVpOFymUoiXcHgWHg-1; Mon, 05 Jun 2023 11:39:02 -0400
X-MC-Unique: 1tIwtJVpOFymUoiXcHgWHg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f899ba8dc1so2710921cf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jun 2023 08:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685979541; x=1688571541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQkr2X8nA9Tbhw8fess+euxrCcam9DnIxmBl/XeagVo=;
        b=LZ+726HMbiwqe/xr1aPFuoEJ1WuZTmDkKZDYD0cgIL+Ed4IFhoSzdyK8w4Tt5GaWXY
         PKAN8pfM+DzkVrNary7qiDMwl3UEaurwAj+x7X8Xlg8xewY4Cl27JPvzB+syu6dPddsc
         oV5rWJzdIM//A5ErLNKPk5MSOXWFb/uZDJAedKtkGzN+4d5Vu41u6vTFYbgDie8ve4QR
         MuKclLrLdc7OSGMFpVBIx1arcOFWjTUZUl9JbwvjHpLwJLMHxBm3kjXHJa4HFi5XrUta
         SpE1FpNkuRwkwGB4YUuHORUjgNMtIstzyOdpfXxdp1kOXfzZQkaZ5K4oA3o6BVPI7cO8
         lDvw==
X-Gm-Message-State: AC+VfDwwY/YoGvGW+z2xOby96d0q92PMtONrt0HclaD7OK/9ceQ8zv+V
        qgG8lCsDtpCmolPo7vsdsbQmUIhtJZk2t/KGfpVUDO61mKt+58uY4M2TtLBLaWpTucjaMO1XJIE
        8MTbmVdIZm3Ou0RNwuWL/t/kpiDfJin8wpshz
X-Received: by 2002:ac8:5c50:0:b0:3f5:315f:5c1d with SMTP id j16-20020ac85c50000000b003f5315f5c1dmr25510662qtj.4.1685979541286;
        Mon, 05 Jun 2023 08:39:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6X9CYQMUlZYA93CXYoJuh/J/dQRSbdRkTjm8X+EToYZM1MmiRsxpa17vOq+AzSo0GpunfjUA==
X-Received: by 2002:ac8:5c50:0:b0:3f5:315f:5c1d with SMTP id j16-20020ac85c50000000b003f5315f5c1dmr25510636qtj.4.1685979540993;
        Mon, 05 Jun 2023 08:39:00 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id h8-20020ac87448000000b003e635f80e72sm4780407qtr.48.2023.06.05.08.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 08:39:00 -0700 (PDT)
Date:   Mon, 5 Jun 2023 11:38:58 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/12] selftests/mm: fix a char* assignment in
 mlock2-tests.c
Message-ID: <ZH4BkqDh0MXqx8ae@x1n>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-5-jhubbard@nvidia.com>
 <18e69073-1007-07d8-bf0d-5f400ecab8ea@redhat.com>
 <ZHoJxAWtwBo33l6B@x1n>
 <f61fb7c1-64ab-c3c3-bd95-92a962f07226@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f61fb7c1-64ab-c3c3-bd95-92a962f07226@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 02, 2023 at 11:52:42AM -0700, John Hubbard wrote:
> On 6/2/23 08:24, Peter Xu wrote:
> > On Fri, Jun 02, 2023 at 12:04:57PM +0200, David Hildenbrand wrote:
> > > On 02.06.23 03:33, John Hubbard wrote:
> > > > The stop variable is a char*, so use "\0" when assigning to it, rather
> > > > than attempting to assign a character type. This was generating a
> > > > warning when compiling with clang.
> > > > 
> > > > Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> > > > ---
> > > >    tools/testing/selftests/mm/mlock2-tests.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/tools/testing/selftests/mm/mlock2-tests.c b/tools/testing/selftests/mm/mlock2-tests.c
> > > > index 11b2301f3aa3..8ee95077dc25 100644
> > > > --- a/tools/testing/selftests/mm/mlock2-tests.c
> > > > +++ b/tools/testing/selftests/mm/mlock2-tests.c
> > > > @@ -50,7 +50,7 @@ static int get_vm_area(unsigned long addr, struct vm_boundaries *area)
> > > >    			printf("cannot parse /proc/self/maps\n");
> > > >    			goto out;
> > > >    		}
> > > > -		stop = '\0';
> > > > +		stop = "\0";
> > > >    		sscanf(line, "%lx", &start);
> > > >    		sscanf(end_addr, "%lx", &end);
> > > 
> > > 
> > > I'm probably missing something, but what is the stop variable supposed to do
> > > here? It's completely unused, no?
> > > 
> > > if (!strchr(end_addr, ' ')) {
> > > 	printf("cannot parse /proc/self/maps\n");
> > > 	goto out;
> > > }
> 
> Yes it is! I certainly had tunnel vision on that one. I've changed the
> patch to simply delete that line, for v2, thanks.
> 
> > 
> > I guess it wanted to do "*stop = '\0'" but it just didn't matter a lot
> > since the sscanf() just worked..
> > 
> 
> Maybe, yes. Hard to tell the original intent at this point...it might
> have been used in an early draft version of the loop that didn't get
> posted, perhaps.

I'm pretty sure of it.. see the pattern:

		end_addr = strchr(line, '-');
		if (!end_addr) {
			printf("cannot parse /proc/self/maps\n");
			goto out;
		}
		*end_addr = '\0';

And...

		stop = strchr(end_addr, ' ');
		if (!stop) {
			printf("cannot parse /proc/self/maps\n");
			goto out;
		}
		stop = '\0';    <------------------- only diff here

-- 
Peter Xu

