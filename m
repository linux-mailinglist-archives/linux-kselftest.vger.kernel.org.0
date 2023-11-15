Return-Path: <linux-kselftest+bounces-127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B88057EBF96
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 10:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4884DB20B17
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 09:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1448F4F;
	Wed, 15 Nov 2023 09:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBtyPwJp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50716AB3;
	Wed, 15 Nov 2023 09:35:58 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB9FFE;
	Wed, 15 Nov 2023 01:35:57 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b6a837a2e1so3726803b6e.0;
        Wed, 15 Nov 2023 01:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700040956; x=1700645756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y14CWVBX/6BOBmenjOqPw5zX4JOn2XRwD65cHjQ6RJI=;
        b=GBtyPwJpPi7hopnbrJuw0gSl3IDaR8vT2kKcSaE23Y2Ml7MY7eCFTmLJP3Xkc+B+0v
         kGgSwle5Bl4jJXlCYgZBUmwncdL4rSEXuSTp5B+pk29+cOZhChFQY6ONEa3h69Z91ypo
         gEUFC/eKDXXE/j5GZcRZThYHJrpm9yYqSvKhLK3jUvHDzcv64fgz/gZaINBkjEvtCZ8y
         9vZqz/CqVh6XrZ3g/BfYt2IsgQnV9n1LsQQSJeIU7meZo8RoHnhPRICMoizpnu7jsLM2
         eiA7ISpmWs1WTYx2LNvS1ZFVjBgMRbbFtWQMrOkCxTit1zy3dr+tSQwsnqbxMON+PcSc
         UOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700040956; x=1700645756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y14CWVBX/6BOBmenjOqPw5zX4JOn2XRwD65cHjQ6RJI=;
        b=kK0yWhSHp55d5K0b5Nu14kF6vioHrK5jR2d0VQLutUzMClLbdmf5ubRShQENncdRfx
         yzkI2DI/K3TFr7pFFkS0gckGx0FJ8NHRDrkpquM2KpWDwBeCtQym3xbVDTuyNr6lmOvO
         CeKFRD36eIzmuH0aLWQDJko7iTLcTmaYcSgZhcmtLJTUs4xpeAPM76tTRsR+fW/VYBTs
         dXyfVQNoRd3Lnt/gPT1HlIKeYZcSnA8ghVJB/uCQpfM1VHuhAysvhS9YB+pH+8XIpSh1
         ndziJxh5kbaJAnndiEFn8chRoT6ti74dJMmyhCNVDxz+I+njSDjsic24xch1+1Fn2o2G
         nS/g==
X-Gm-Message-State: AOJu0Yxs5+HygLGil4znqJg/t4s6O4lhN8iv8Fw95ZQqlFDGMAgCibOh
	X0pYrwoG57chSNlo2AgfisU=
X-Google-Smtp-Source: AGHT+IF93sBNiCaIC3uDNKSKRZJrQ7DHkVcEW6f7Hvccg1iM+XVYLdO3Z/l9xAVoTwcXGCuKeQ2lqw==
X-Received: by 2002:a54:4397:0:b0:3b2:df83:a760 with SMTP id u23-20020a544397000000b003b2df83a760mr14740212oiv.41.1700040956687;
        Wed, 15 Nov 2023 01:35:56 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s18-20020a656452000000b0057825bd3448sm730224pgv.51.2023.11.15.01.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 01:35:56 -0800 (PST)
Date: Wed, 15 Nov 2023 17:35:51 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Guillaume Nault <gnault@redhat.com>
Subject: Re: [Discuss] Seeking advice on net selftests netns naming method
Message-ID: <ZVSQ9y37zobubeN+@Laptop-X1>
References: <ZVND+e6RKLFudYQA@Laptop-X1>
 <7b2d70645fecf83f30d71c44ae0071da1b3be67c.camel@redhat.com>
 <ZVR4j+ZYQmb68/V9@Laptop-X1>
 <8093c847a556cf38c40f5e9329b087ea34f59e29.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8093c847a556cf38c40f5e9329b087ea34f59e29.camel@redhat.com>

On Wed, Nov 15, 2023 at 10:10:38AM +0100, Paolo Abeni wrote:
> > Thanks, this is a good idea. I reviewed all the test cases and it should works
> > for most of them. Only the SRv6 tests are a little complex as they use 2 id
> > number for netns name. e.g. the setup_hs() in
> > srv6_end_dt46_l3vpn_test.sh. I plan to add the tmp string between the hs/rt and
> > ids. e.g. hs-xxxxxx-t100-1, rt-xxxxxx-1. I will have a try first.
> 
> Supposing netns_init() creates a namespace named <unique>, I think the
> following (very hackish thing) would work:
> 
> # create an alias for the namespace
> ln -s /var/run/netns/<unique> /var/run/netns/hs-t${tid}-${hs}

We can't do this as the purpose of using "unique" namespace name is do
Parallel testing. If we create the soft link and run multi SRv6 tests (there
are multi SRv6 tests with same netns name) at the same time, the naming will
be conflict.

Thanks
Hangbin

