Return-Path: <linux-kselftest+bounces-125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A787EBE3D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 08:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 724AFB20B08
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 07:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7682E84B;
	Wed, 15 Nov 2023 07:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6fomB6C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACF64416;
	Wed, 15 Nov 2023 07:51:50 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40C4C8;
	Tue, 14 Nov 2023 23:51:49 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6ce2add34c9so3706095a34.1;
        Tue, 14 Nov 2023 23:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700034709; x=1700639509; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OglTwC5vnjVMX8d3aLPLAd5qQX6D3HCXF24D7yTj60M=;
        b=B6fomB6Cj6ofHZY99C2wBH0niujjlTyBJlCFXeSnxijWhoWndxplgsxV2JUfI+kOaM
         ZFsVDhG+0di6VZvgzGguxMgjUyxpjG5aI0vhq/fGUZ1FfWK9mLrND1FpSuMY1DkHboLE
         pOVL7A0WqpfqdTGrL7LsZll2JK0ftCm+qSlFPGCDfWHJAss+KapW+B0hSfxiVuo3WeqN
         V+cSQX8IBs+7oqSbnWfrepaBhTt7tDSePq8rCTPkQhmP8EkN02qbXhGgmEEIyEfDR2GN
         /2y9qLihOUfUGWT6jY5kuBfjbEiji0etIlRlcarf+qeyMFp7B5Xekp5qchYnbOYxLHZw
         fI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700034709; x=1700639509;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OglTwC5vnjVMX8d3aLPLAd5qQX6D3HCXF24D7yTj60M=;
        b=TnmNxiT7kMJJZByX9RI1LZTeSISFk/y//12+ynIT5WgwUA+S2uaQJfDQw+szEvsv3N
         x+AaFD28pN5mzErdkaWwwxQKVzBYOlszv16yfXXPF0MT7dsPOiZmjz1UGyMm/1Wg1WFo
         du4edaiQ8s7zHCcVtzphCSje5zIedDmN48SFwSFEhD1SDByQZSpcXj6SIsNCQZjgbBl9
         8oyS3gbjBRhUwF+NyXcCdnxoa4ubAy3qac4NqlLzdkeYIbpGOmu/77yQZI/rYpCffV6C
         LfZ+eTa2HBm5eG+//0SVw3J2R9f0MsFfKHIxv2FjlCPeZcgH5UCTxd5ex9PsDF2PVprL
         80eA==
X-Gm-Message-State: AOJu0YykosVZckk7nEjrk9JEiSwSdV8Y3rjVFsTZis4HBWryi6PH6Nt2
	pKnLvrqRUJsPobdPPI9y2/H8VH3dESL/qg==
X-Google-Smtp-Source: AGHT+IHxEfAlB8VacsaCIbE8zcQYB702s8jMGacnLwklhhkYWBFEf3a16uvigNGXjmbsP5N576/SwA==
X-Received: by 2002:a9d:6202:0:b0:6b8:6f94:d3a2 with SMTP id g2-20020a9d6202000000b006b86f94d3a2mr4476076otj.25.1700034709195;
        Tue, 14 Nov 2023 23:51:49 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s14-20020a65690e000000b0057c44503835sm574766pgq.65.2023.11.14.23.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 23:51:48 -0800 (PST)
Date: Wed, 15 Nov 2023 15:51:43 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>, linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Guillaume Nault <gnault@redhat.com>
Subject: Re: [Discuss] Seeking advice on net selftests netns naming method
Message-ID: <ZVR4j+ZYQmb68/V9@Laptop-X1>
References: <ZVND+e6RKLFudYQA@Laptop-X1>
 <7b2d70645fecf83f30d71c44ae0071da1b3be67c.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b2d70645fecf83f30d71c44ae0071da1b3be67c.camel@redhat.com>

On Tue, Nov 14, 2023 at 12:02:00PM +0100, Paolo Abeni wrote:
> I personally would like sort of both :) e.g. lib function(s) to
> automatically create and dispose netns, and retain a script-
> specific/related name prefix. 
> 
> The library function could optionally set  the newly created namespaces
> name in global variables provided by the caller, e.g.:
> 
> # create 3 namespaces:
> netns_init 3 
> 
> # create 3 namespaces and set the global variables:
> # $remote, $local $me 
> # to their respective names
> netns_init 3 remote local me
> 
> The trick to do such assignment would be using the 'eval' statement,
> something alike
> 
> netns_init()
> {
> 	# create the netns
> 
> 	shift
> 	while [ -n "$1" ]; do
> 		eval $1=$NETNS_NAMES[0]
> 		shift
> 	done
> }
> 
> While at that, it would be useful to package some common helper e.g. to
> wait for a (tcp) listener to be created (available) on a given port.
> 
> WDYT?

Thanks, this is a good idea. I reviewed all the test cases and it should works
for most of them. Only the SRv6 tests are a little complex as they use 2 id
number for netns name. e.g. the setup_hs() in
srv6_end_dt46_l3vpn_test.sh. I plan to add the tmp string between the hs/rt and
ids. e.g. hs-xxxxxx-t100-1, rt-xxxxxx-1. I will have a try first.

Cheers
Hangbin

