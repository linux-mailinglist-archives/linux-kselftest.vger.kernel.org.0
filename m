Return-Path: <linux-kselftest+bounces-17433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CED2C96FE7B
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 01:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E846C1C228BB
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 23:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAED215B15D;
	Fri,  6 Sep 2024 23:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6IdksBt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6A315AD83;
	Fri,  6 Sep 2024 23:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725665292; cv=none; b=jN5AWdelAOodSI689WkjpC5D4gfsH2O5Zi0Z9ePz4COvrqicsWjkK/8mO+dA9MYkpE8FdBWuAF8RLzGUo4S852oH2A/xhYsd4iCv7HIxhRjTeanVlD+Thq7b8K+vPMlqok76OEZAwRuL9NQDU92WnRQjKocFdRBYQNEit/5MKXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725665292; c=relaxed/simple;
	bh=qU46c5aFmpc7j9gyVhM9h46IdY44emYpEv/jit0N648=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iZKTePgESvN2wYETguWaFy8jF04YqsxyVU/qA0RzO/wpbu8WJCkp1jowiV8cVrocXuL/scby0NcDOgj2qe6BDTEIKfAIJOkO0w0X+utr/FQm2vdXSCNl666+TuH32OcEpGbIH6u/ri/I6MZFuzsdOUUYmwBEURRUshptWMA6XkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6IdksBt; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6c351809a80so14205256d6.1;
        Fri, 06 Sep 2024 16:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725665290; x=1726270090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqz8q2FUFpFlbCCDjXG+7PBcJcJE11GfFiHSwwdg/e4=;
        b=Q6IdksBtWqvHGO9+yNB3bOS/i3/M6fzjqA8eXbvG/1dGJSFsZmvdB4HJFhx6a/wSTi
         oqHlJiqAN8RgPEg1uVex2CWzIZICW2QEeOI3FtXPxReypFvXHUDsPf9VEbWZCGD6GQEq
         MUu91wXL9+eg6wmyXvQdfA2+mmNGBdErqNiIKrdtp2zxPznArrGJp8cSoB9I8uHRU9Mm
         aeIxRaCkdLtF1BdPkzTRBhMgM0VcdcHyXCVOs988C1ESGD9ib1NEL6nhYV8UQhie53Ib
         yyH+uJRaU5OHkK1PJDDKdia4Au1/OwxE8eOvCbmfkfz0Bf9l834Zf4otyM/T39eUtX1y
         fzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725665290; x=1726270090;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jqz8q2FUFpFlbCCDjXG+7PBcJcJE11GfFiHSwwdg/e4=;
        b=sWD2WxnRbTHfDIssONSN/iTaNKZIsSUcCHFjEvOuq3a0NZlR1E+hGvk80rBlcM/KTL
         xAiW3qHb/6jFufUvOeheDe4+zr4thjqR4wFR0F3fKWtgGxHVItMLrbIM7m04NHw01ZZJ
         5qw5sAKsPZJq8Al5ETcKBkndqK73jlRZdAHFzGtqpyHnzY6x0ECANlmVQQqb6EM6Hf4b
         XsRoCQfkxi/ACjExgIxfJm/oez3dM56kii2AyPcyD9lo8hFLPXPE8tVqXtvvtq6Mk/YI
         Jyiyv7Mu9ggBHN4zfgjJYBtwgdQHs2SZFEWzHE2kOgSyq7iJw8csMcHil6iU0UJOZjbC
         PHdA==
X-Forwarded-Encrypted: i=1; AJvYcCUtfdbXuM7E7ppzqHCRZoBqLEGW+/DgUR6kSTiYGxseW0LQMJDkVYV6nEeY5W9g4k+qUkD8CSIeuubXDL/I+iE=@vger.kernel.org, AJvYcCV9zJ6kM8LPRJKgEfCEAhczMxFF6MvTUWkIxr2JpT/V8A/e7Cgj2hrV1OmBy1ocLZ+vulOROLSU@vger.kernel.org
X-Gm-Message-State: AOJu0YwnhhD/k0hsdMDgdOAh3VDF+ouu4Hxl2B5oY5t7nJJJ+FngpDXA
	x3AKBz28Pq6yPp+ib/BwGOZ2aNKc2JmBrEfN4nzeijg2uADipz/v
X-Google-Smtp-Source: AGHT+IFdl0YUzpYfOEPf1j/1Kg3b3Nx+r4hut1xW63itkb4dHaYUmlX9+DmYwH7PT6a+b83EfkKg0w==
X-Received: by 2002:a05:6214:5403:b0:6c5:1614:9c59 with SMTP id 6a1803df08f44-6c52850056emr48007046d6.31.1725665289736;
        Fri, 06 Sep 2024 16:28:09 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53474d632sm9846d6.89.2024.09.06.16.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 16:28:09 -0700 (PDT)
Date: Fri, 06 Sep 2024 19:28:08 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 ncardwell@google.com, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 fw@strlen.de, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <66db9008e0b4e_2a33ef29428@willemb.c.googlers.com.notmuch>
In-Reply-To: <ad780c53-9538-4d3f-a02f-1063828fc035@kernel.org>
References: <20240905231653.2427327-1-willemdebruijn.kernel@gmail.com>
 <20240905231653.2427327-3-willemdebruijn.kernel@gmail.com>
 <f63e7367-c4fb-4cdc-a44c-6accbc309c5a@kernel.org>
 <66db217a558c4_29a385294d3@willemb.c.googlers.com.notmuch>
 <ad780c53-9538-4d3f-a02f-1063828fc035@kernel.org>
Subject: Re: [PATCH net-next v2 2/2] selftests/net: integrate packetdrill with
 ksft
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Matthieu Baerts wrote:
> On 06/09/2024 17:36, Willem de Bruijn wrote:
> > Matthieu Baerts wrote:
> >> Hi Willem,
> >>
> >> On 06/09/2024 01:15, Willem de Bruijn wrote:
> >>> From: Willem de Bruijn <willemb@google.com>
> >>>
> >>> Lay the groundwork to import into kselftests the over 150 packetdrill
> >>> TCP/IP conformance tests on github.com/google/packetdrill.
> >>>
> >>> Florian recently added support for packetdrill tests in nf_conntrack,
> >>> in commit a8a388c2aae49 ("selftests: netfilter: add packetdrill based
> >>> conntrack tests").
> >>>
> >>> This patch takes a slightly different approach. It relies on
> >>> ksft_runner.sh to run every *.pkt file in the directory.
> >>
> >> Thank you for adding this support! I'm looking forward to seeing more
> >> packetdrill tests being validated by the CI, and I hope that will
> >> encourage people to add more tests, and increase the code coverage!
> > 
> > Thanks for taking a look and your feedback.
> 
> You are welcome!
> 
> >> I have some questions about how the packetdrill should be executed:
> >> should they be isolated in dedicated netns?
> > 
> > Yes. The runner decides that, by passing -n 
> 
> But then it means that by default, the tests are not isolated. I think
> many (most?) selftests are running in a dedicated netns by default, no?
> 
> To be honest, that's the first time I hear about:
> 
>   ./run_kselftest.sh --netns
> 
> I don't know if it is common to use it, nor if we can enable this
> feature when using 'make run_tests'. And I don't know if many CI runs
> multiple selftests in parallel from the same VM.
> 
> >> There are some other comments, but feel free to ignore them if they are
> >> not relevant, or if they can be fixed later.
> >>
> >>> Tested:
> >>> 	make -C tools/testing/selftests \
> >>> 	  TARGETS=net/packetdrill \
> >>> 	  run_tests
> >>
> >> Please note that this will not run the packetdrill tests in a dedicated
> >> netns. I don't think that's a good idea. Especially when sysctl knobs
> >> are being changed during the tests, and more.
> >>
> >>> 	make -C tools/testing/selftests \
> >>> 	  TARGETS=net/packetdrill \
> >>> 	  install INSTALL_PATH=$KSFT_INSTALL_PATH
> >>>
> >>> 	# in virtme-ng
> >>> 	./run_kselftest.sh -c net/packetdrill
> >>> 	./run_kselftest.sh -t net/packetdrill:tcp_inq_client.pkt
> >>
> >> I see that ./run_kselftest.sh can be executed with the "-n | --netns"
> >> option to run each test in a dedicated net namespace, but it doesn't
> >> seem to work:
> >>
> >>> # ./run_kselftest.sh -n -c net/packetdrill
> >>> [  411.087208] kselftest: Running tests in net/packetdrill
> >>> TAP version 13
> >>> 1..3
> >>> Cannot open network namespace "tcp_inq_client.pkt-TaQ8iN": No such file or directory
> >>> setting the network namespace "tcp_inq_server.pkt-sW8YCz" failed: Invalid argument
> >>> Cannot open network namespace "tcp_md5_md5-only-on-client-ack.pkt-YzJal6": No such file or directory
> > 
> > Ah, I guess this requires adding CONFIG_NET_NS=y to
> > tools/testing/selftests/net/packetdrill/config
> 
> Good point. But I have CONFIG_NET_NS=y on my side. I didn't investigate
> more, I was first wondering if other people tried this option.
> 
> >> But maybe it would be better to create the netns in ksft_runner.sh?
> >> Please see below.
> > 
> > No, we opted for this design exactly to use existing kselftest infra,
> > rather than reimplementing that in our wrapper, as I did in the RFC.
> 
> OK, I understood from the discussions from the RFC that by using the
> kselftest infra, the tests would be automatically executed in dedicated
> netns, and it could also help running tests in parallel. That sounded
> great to me, but that's not the case by default from what I see.

Perhaps that's something to change in the defaults for run_tests.

Since the infra exist, that is preferable over reimplementing it for
one particular subset of tests.

Or if not all kselftests can run in netns (quite likely), this needs
to be opt-in. Then a variable defined in the Makefile perhaps. To
tell kselftest to enable the feature for this target.


