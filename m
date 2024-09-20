Return-Path: <linux-kselftest+bounces-18162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DF997D44E
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 12:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100E91F22C72
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 10:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE3114264C;
	Fri, 20 Sep 2024 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+mN5/no"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C43140397;
	Fri, 20 Sep 2024 10:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726828718; cv=none; b=nW89tORK4doSX5dApcu4X0CrWvLwIMFzAweSmLmaso8NQrZcRuhgvVicCqpYwdR0UF+vFph0Ur97yUMY2pmBrx2Tpd5pj4Ab/sKKkUdBiC7EfBUWv2daHqL6C/aVDoB/f8nxLIJ8CHgy0G2Tdz8a6KzQYQu18tJh9MAmBiuur+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726828718; c=relaxed/simple;
	bh=6BOL82o+jOJn+WxXdBQzDl9CV6tJGl7TaJjICz283a0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DX/BFhbkntb79o2CN6ZWfcRpU5iNYPNntJO4MwT52beuaKRaehbB6W4aP0xH95syz7y5cSutNMNJ9L4z8p8EnFZGw8C9L8Zx6VoAPG0FalWrRELB+nEr+z/kqmkXDppppqlr6/+Jk4qr3Hop9kV3QXG8oQbrDuXPm0O2+BPZ7fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+mN5/no; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908C7C4CEC3;
	Fri, 20 Sep 2024 10:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726828717;
	bh=6BOL82o+jOJn+WxXdBQzDl9CV6tJGl7TaJjICz283a0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a+mN5/nod4no51FXoDWoLK8eFDDnB1lK580g7CQrqIUr+C4tGQvRfuGUlrM52fw71
	 W8qsaBcCjQsADdynqx8KADISJktOWNOPUK8of02rAS3UgSpDHN5rUmw7AIGH4SV41x
	 o6A6AN8ADMY+SJZIUsRD8x+iqcqdVgrFksUuNdYMSXHTuiHBwg18u3HF+rcfjvFEXO
	 NtPLW6hz7yoz3xp8x+GNRdcnYIy8jvG06TPC2XRYbqswM72KhsldCxIA8az5PNWV9M
	 WFaf1KVGbCgGg2nYixga/yzOXlssRnq2B/JAPBm+jF/4fS8RJOctRtlDlVLTJZxlYM
	 OOBy3vjP3CfJg==
Date: Fri, 20 Sep 2024 12:38:27 +0200
From: Jakub Kicinski <kuba@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Anders Roxell <anders.roxell@linaro.org>, shuah@kernel.org,
 willemb@google.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: Makefile: create OUTPUT dir
Message-ID: <20240920123827.715ff109@kernel.org>
In-Reply-To: <952aeec9-c21f-46ce-bf68-e6ffce51630c@linuxfoundation.org>
References: <20240916075655.4117151-1-anders.roxell@linaro.org>
	<952aeec9-c21f-46ce-bf68-e6ffce51630c@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Sep 2024 09:51:47 -0600 Shuah Khan wrote:
> > @@ -261,6 +261,7 @@ ifdef INSTALL_PATH
> >   	@ret=1;	\
> >   	for TARGET in $(TARGETS) $(INSTALL_DEP_TARGETS); do \
> >   		BUILD_TARGET=$$BUILD/$$TARGET;	\
> > +		mkdir -p $$BUILD_TARGET;	\
> >   		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install \
> >   				INSTALL_PATH=$(INSTALL_PATH)/$$TARGET \
> >   				SRC_PATH=$(shell readlink -e $$(pwd)) \  
> 
> Doesn't the "all" target mkdir work for this case? Why do we need another mkdir here?

I was wondering about that, too. Looks like the code from the all
target is copy/pasted in the install target except the mkdir line.
Best fix would be to make the dependency work, I don't understand
why it doesn't already, tho.

