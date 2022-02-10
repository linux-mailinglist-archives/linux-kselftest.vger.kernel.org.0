Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350654B17E9
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 23:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344797AbiBJWFX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 17:05:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237490AbiBJWFW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 17:05:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F06F0F23
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 14:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644530721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CHki4NQGix/o6xHSAHI1vc1+xjLGEOdiSoRfFNXvPi8=;
        b=dsxeNFvFO9A7htkrZD0jjsvIWGYxdrifS/TVOhqHhHdNHpRBVbpbgkeN9RVscEUmAyUw9P
        X1REG2jMCeCSEjaoKH3HImzLA2mVZdpbzRpOgAvzCPLNV4Rx95h+mraVEd0urxXam9RSzA
        U2FGsBvkHvwrF/EYu63XNFs3so/d3GM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-efhyKNYDMsGq_m9aZSXE1w-1; Thu, 10 Feb 2022 17:05:20 -0500
X-MC-Unique: efhyKNYDMsGq_m9aZSXE1w-1
Received: by mail-wr1-f71.google.com with SMTP id d13-20020adfa34d000000b001e33a1c56f3so3031747wrb.20
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 14:05:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CHki4NQGix/o6xHSAHI1vc1+xjLGEOdiSoRfFNXvPi8=;
        b=ewXsgzmtdEdXa7MCUzq5qbHiEmvWVpp4IgwDu4/h5t+3HQp2HYKPXaXv5RRVDUGnRJ
         y+pD61Xgw0hiSEK9y8KEZKbTUmICnip3K3N6QmfUBXCZT8rl23OrUUH+RB0m45iKsIlr
         Sayko+hnk5AWG1n3ka2UWpO3fo8OBeUjuL+MlXLA0e28Bk1Or2Cb8A3ff/Uqv6dbhsed
         fGbwxzrMHVXxp/n0RTM9pp8oV2Uaa78WNNioRs3vTx3VaOkZ76fBV4BWvwRdo36unjnX
         v/9BaWKcguehCaNlv5xPJ6Jx1KrvT1wk7cirb1uKxsoYQam1SYXxMtJzxWofDG//NQ3a
         lYCg==
X-Gm-Message-State: AOAM531jKrAiTkvxWww1ILQhK9OeMCQQINOUH3pIcgezhot8eF3ZfPUd
        YVVknvNzQ01SUlV178D4Ku/ICNzSWs9krqzbfQMYIvO1D1XJKd8KhiCoOsibopZXa1KSnwSNdlP
        p8UIOgb2WAXuE93k2l5yaEsnGOhfq
X-Received: by 2002:adf:ed8e:: with SMTP id c14mr5846576wro.688.1644530719448;
        Thu, 10 Feb 2022 14:05:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwCXcAZE5KzedQudWeRn9dls4oSg7GDgn8W191HvOGCvVb9GnBGrQNKTte3JgfdQBUZWUt2ZQ==
X-Received: by 2002:adf:ed8e:: with SMTP id c14mr5846567wro.688.1644530719255;
        Thu, 10 Feb 2022 14:05:19 -0800 (PST)
Received: from pc-4.home (2a01cb058918ce00dd1a5a4f9908f2d5.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dd1a:5a4f:9908:f2d5])
        by smtp.gmail.com with ESMTPSA id b25sm990992wmj.46.2022.02.10.14.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 14:05:18 -0800 (PST)
Date:   Thu, 10 Feb 2022 23:05:16 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH net-next] ipv6: Reject routes configurations that specify
 dsfield (tos)
Message-ID: <20220210220516.GA31389@pc-4.home>
References: <51234fd156acbe2161e928631cdc3d74b00002a7.1644505353.git.gnault@redhat.com>
 <7bbeba35-17a7-f8ba-0587-4bb1c9b6721e@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bbeba35-17a7-f8ba-0587-4bb1c9b6721e@linuxfoundation.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 10, 2022 at 11:23:20AM -0700, Shuah Khan wrote:
> On 2/10/22 8:08 AM, Guillaume Nault wrote:
> > The ->rtm_tos option is normally used to route packets based on both
> > the destination address and the DS field. However it's ignored for
> > IPv6 routes. Setting ->rtm_tos for IPv6 is thus invalid as the route
> > is going to work only on the destination address anyway, so it won't
> > behave as specified.
> > 
> > Suggested-by: Toke Høiland-Jørgensen <toke@redhat.com>
> > Signed-off-by: Guillaume Nault <gnault@redhat.com>
> > ---
> > The same problem exists for ->rtm_scope. I'm working only on ->rtm_tos
> > here because IPv4 recently started to validate this option too (as part
> > of the DSCP/ECN clarification effort).
> > I'll give this patch some soak time, then send another one for
> > rejecting ->rtm_scope in IPv6 routes if nobody complains.
> > 
> >   net/ipv6/route.c                         |  6 ++++++
> >   tools/testing/selftests/net/fib_tests.sh | 13 +++++++++++++
> >   2 files changed, 19 insertions(+)
> > 
> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index f4884cda13b9..dd98a11fbdb6 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -5009,6 +5009,12 @@ static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
> >   	err = -EINVAL;
> >   	rtm = nlmsg_data(nlh);
> > +	if (rtm->rtm_tos) {
> > +		NL_SET_ERR_MSG(extack,
> > +			       "Invalid dsfield (tos): option not available for IPv6");
> 
> Is this an expected failure on ipv6, in which case should this test report
> pass? Should it print "failed as expected" or is returning fail from errout
> is what should happen?

This is an expected failure. When ->rtm_tos is set, iproute2 fails with
error code 2 and prints
"Error: Invalid dsfield (tos): option not available for IPv6.".

The selftest redirects stderr to /dev/null by default (unless -v is
passed on the command line) and expects the command to fail and
return 2. So the default output is just:

IPv6 route with dsfield tests
    TEST: Reject route with dsfield                                     [ OK ]

Of course, on a kernel that accepts non-null ->rtm_tos, "[ OK ]"
becomes "[FAIL]", and the the failed tests couter is incremented.

> > +		goto errout;
> > +	}
> > +
> >   	*cfg = (struct fib6_config){
> >   		.fc_table = rtm->rtm_table,
> >   		.fc_dst_len = rtm->rtm_dst_len,
> > diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
> > index bb73235976b3..e2690cc42da3 100755
> > --- a/tools/testing/selftests/net/fib_tests.sh
> > +++ b/tools/testing/selftests/net/fib_tests.sh
> > @@ -988,12 +988,25 @@ ipv6_rt_replace()
> >   	ipv6_rt_replace_mpath
> >   }
> > +ipv6_rt_dsfield()
> > +{
> > +	echo
> > +	echo "IPv6 route with dsfield tests"
> > +
> > +	run_cmd "$IP -6 route flush 2001:db8:102::/64"
> > +
> > +	# IPv6 doesn't support routing based on dsfield
> > +	run_cmd "$IP -6 route add 2001:db8:102::/64 dsfield 0x04 via 2001:db8:101::2"
> > +	log_test $? 2 "Reject route with dsfield"
> > +}
> > +
> >   ipv6_route_test()
> >   {
> >   	route_setup
> >   	ipv6_rt_add
> >   	ipv6_rt_replace
> > +	ipv6_rt_dsfield
> >   	route_cleanup
> >   }
> > 
> 
> With the above comment addressed or explained.
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> thanks,
> -- Shuah
> 

