Return-Path: <linux-kselftest+bounces-939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 261EC8003A7
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 07:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6AF9281574
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 06:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3366DBE7E;
	Fri,  1 Dec 2023 06:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqxx95AJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5345171A;
	Thu, 30 Nov 2023 22:20:57 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5c19a328797so130529a12.3;
        Thu, 30 Nov 2023 22:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701411657; x=1702016457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YK7DAK/HYP5JoaioB+ozsCCJdE2mJr0IL2oKiStr1mo=;
        b=mqxx95AJDxQc4Pe6Mbs1bEgPe3FWWGlwebTTMMxKqcEEMtRpvpQWULgABZbP6R4KZU
         dKtcN0q/Y5LaSMYzlqmddCtOoOURutB69biw36e+88fgc9SO4oOl14yv9M2O78TCe3dq
         tyqf5p4HuspBOjcEGAQvQWpw1pxi2MREo2sBPhtknWCC0Ty8Ty1hceiOipA84EUwS3S6
         rWnn2893raZMFfC5B8qEWL2PNu52p1lOKCl5BiBJYvgXgNUoB42frvlcjpphzdwl3oAt
         i5zl55L0IhUT31GUUMvvgNX6mAATxv4sFjkNlZBelV0C9CO/yWvNTuGQzTFsKyIrRAp1
         AYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701411657; x=1702016457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YK7DAK/HYP5JoaioB+ozsCCJdE2mJr0IL2oKiStr1mo=;
        b=MVuyhNdzr/mOvZ3z5tWgBU3BMVXARpcl+QDkVKgoQ2lxIwKr+ZcPhbU/93vpeqpp4T
         P4A00Z+a5o548FmJ3kGWRhtr4VCcyU6m9X0AhJ9S3U1lNKYYMdtKw187V4pkdyFX/iZv
         Qe/5VLdBenddff2Y78hdbLtARqYSgqj0KIAg/gQMOS2pRZTdOBUlT9VuImJzYG7FbV/V
         W2IEBaXlVMuzYtURORWpI04TxfXfXXzz7yVUucGIe14wGz+Z8eqrh82duGT6A3YpYgmn
         Tbh8gC9Wz0Xa0eVVcefHEWIld5LdFUldnyyXYg9j4/5sw+sCyk9ahDMtwg5XYuF0w3cN
         UlqA==
X-Gm-Message-State: AOJu0Yy1AnyU0/DAx1vVl2FFeYkIsTXFNxtwwodnlZglMR3wqnsLKeTS
	Ll6vSP7o1TqfmBf38ghnL98=
X-Google-Smtp-Source: AGHT+IFg344i9i44nWIlUV5nGDm3itL0uS1LAjuTEZ0pXCNIudCdwvHhrYNJRYVSw9tIQ3panVXfrw==
X-Received: by 2002:a05:6a21:33a4:b0:18c:18d3:c8fd with SMTP id yy36-20020a056a2133a400b0018c18d3c8fdmr19354698pzb.14.1701411656907;
        Thu, 30 Nov 2023 22:20:56 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t189-20020a6281c6000000b00690c0cf97c9sm2313172pfd.73.2023.11.30.22.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 22:20:55 -0800 (PST)
Date: Fri, 1 Dec 2023 14:20:49 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	James Prestwood <prestwoj@gmail.com>,
	Jaehee Park <jhpark1013@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Francesco Ruggeri <fruggeri@arista.com>,
	Justin Iurman <justin.iurman@uliege.be>,
	Xin Long <lucien.xin@gmail.com>
Subject: Re: [PATCHv2 net-next 01/14] selftests/net: add lib.sh
Message-ID: <ZWl7QaMAWj+RP21T@Laptop-X1>
References: <20231130040105.1265779-1-liuhangbin@gmail.com>
 <20231130040105.1265779-2-liuhangbin@gmail.com>
 <CAMy_GT_YawM_6Xw9Qtt8rNLraAnfh_UkYjrb6j_1sWCSjfPN0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMy_GT_YawM_6Xw9Qtt8rNLraAnfh_UkYjrb6j_1sWCSjfPN0w@mail.gmail.com>

On Fri, Dec 01, 2023 at 01:56:51PM +0800, Po-Hsu Lin wrote:
> > +# setup netns with given names as prefix. e.g
> > +# setup_ns local remote
> > +setup_ns()
> > +{
> > +       local ns=""
> > +       local ns_name=""
> > +       local ns_list=""
> > +       for ns_name in "$@"; do
> > +               # Some test may setup/remove same netns multi times
> > +               if unset ${ns_name} 2> /dev/null; then
> > +                       ns="${ns_name,,}-$(mktemp -u XXXXXX)"
> > +                       eval readonly ${ns_name}="$ns"
> > +               else
> > +                       eval ns='$'${ns_name}
> > +                       cleanup_ns "$ns"
> > +
> > +               fi
> > +
> > +               if ! ip netns add "$ns"; then
> > +                       echo "Failed to create namespace $ns_name"
> > +                       cleanup_ns "$ns_list"
> > +                       return $ksft_skip
> > +               fi
> > +               ip -n "$ns" link set lo up
> I got this patchset tested the result is looking good. However it
> seems that not all of the tests require this loopback bring up, e.g.
> * arp_ndisc_untracked_subnets.sh
> * cmsg_ipv6.sh
> * cmsg_so_mark.sh
> * cmsg_time.sh
> * drop_monitor_tests.sh
> * icmp.sh
> * ndisc_unsolicited_na_test.sh
> * sctp_vrf.sh
> * unicast_extensions.sh
> 
> A possible solution could be adding an extra flag to setup_ns(), bring
> lo up on demand.
> 
> Not sure if this is needed, as I can't think of possible impacts of
> this for the moment.
> (Maybe a test does not require loopback device in such state?)
> Other might be able to provide some feedback about this.

Yes, I also can't think of impact of set lo up. So I just do it explicit.
If someone could help find out the impact, I can add a flag for this function.

Thanks
Hangbin

