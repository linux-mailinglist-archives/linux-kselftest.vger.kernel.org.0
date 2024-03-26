Return-Path: <linux-kselftest+bounces-6615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E5B88BEEB
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 11:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672471C3CF66
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 10:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19165C904;
	Tue, 26 Mar 2024 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DN+4xh8f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F044D5B1FB
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447774; cv=none; b=aIgCSab9kJn/zBvzESRjZVZnuqWZlP4fjsWK2ooUqy9QQiUS7FUWMuLMdAr7aCb6UHVcl45ij1jW67sB9sBWNH921BYEPBzeCOkUq8FCmLN9mndAV6emclHuj5mPC0ijavOJ3OKve3NwRRIpXUh8q7UkZlDV8WNkbbLmazasPqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447774; c=relaxed/simple;
	bh=sPRMdzA0/luYwpYQ+t5SitI43KODkM/+VZrv4i/srQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4Re1S19Y+QXZxpK8j0JAhAp80D9jxasZGTGYydcct5XRNAbAhBNvvX8Yssf9smbNp1y3JTMG5YiVm2apXk+LKaraQa6EbP9OAS9UaQBk3CYDcv+nLIS8EwM1RLMW2jms7gSSsutOfmXdHhSfF4wHIwX1yzahA2e3WZUzkJKS2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DN+4xh8f; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56beb6e68aeso5910a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Mar 2024 03:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711447771; x=1712052571; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sPRMdzA0/luYwpYQ+t5SitI43KODkM/+VZrv4i/srQQ=;
        b=DN+4xh8frdyAiEnVwfuinp82pltvxQlVw9XhAML7PoAKV6C1fWD9uAjFFAGBqpglCO
         9sot3FI9CZUm3XszHjBnNKuKc3X0Xm8XZe8weIANEBJhDl+RpwRSXvIRJ7Knjxi+yStn
         QNMp+AUehd+8D6KG6XbZFyv1G8KYlLZl59eMcMFD5pNhqIEK5xitJlnEvZP1LCkq/eNz
         6CFWCsHYSlTFM+jMSLhctbAQOYIVAePeTkAMaxfSnMg1ZFYNMnaJIwhp33UQQjJg+7kn
         EYAJi5qfuOY80+/OHgnmVAMpGdSUIOe4JNq2H5yJNRir7ktw6Dfkw81R7Hgg7HHHz28Q
         Q34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711447771; x=1712052571;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPRMdzA0/luYwpYQ+t5SitI43KODkM/+VZrv4i/srQQ=;
        b=PekLQLiRNAUtDWZX8MxSIJpG9LLX48M5tpnocSm3ZLLRwA9aJp4ZlJURVyjk/CV4Rs
         15wgrY3JTmMn2/vjykj+UEu1yWK+TORoi5Rk35pqiDx3BRDngv83R97ItpdX0/9AJ4rB
         XhQmsgQbUpgmU0oQ4FGec944aKPoXF/svX1Rm4eMbP6foPYXrKcjPLbzLdtVWdGzK31n
         UFQUncQ7NeqsM5UHenwALpenUfE25G7JvTAK9qgeIu6qEAHgKpLPYGjIJg/cEMduxQT7
         lVxvLM4dIeHEVZxq0suPzaxKAbi7PF3l7UATKu4PSEizMwDHe0CE7+WsheUgx0Du+jqy
         Fzkg==
X-Forwarded-Encrypted: i=1; AJvYcCX9ToRES0s2RnZ0OYhO4dhBd8jFuOTFDfJgi8rn+bGZrDah9sdseJ1ws1C//ZMM8+DbhxISTHScUDcpFf/h092AOUYMnLZOdsLucfLTqGn3
X-Gm-Message-State: AOJu0YwJpCm3/qZe8RG2M0lhxcUo/xVPdS6O9odz3JncpXKjlQrXmSXR
	2vOmtd/CmIEjg+yvK/slCiHYqL9i5HZye10JibCPPWBL1B4221H338YeB7PKLZzavsZTi9q7ngZ
	kpFxCkHq09GVplBap2q7dELdO/yT/OL9EaC2k
X-Google-Smtp-Source: AGHT+IFsdAQAH3RTB6NNO1lM6vBlfeh66lb6zcjOza4ii2Pdb3Ksm7rfchw4e7cN0A62WHXsMB1XpXXLh6TwvmgAmHM=
X-Received: by 2002:a05:6402:7c2:b0:56c:9ae:274a with SMTP id
 u2-20020a05640207c200b0056c09ae274amr73795edy.7.1711447771060; Tue, 26 Mar
 2024 03:09:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b743a5ec-3d07-4747-85e0-2fb2ef69db7c@sirena.org.uk>
 <20240325185235.2f704004@kernel.org> <33670310a2b84d1a650b2aa087ac9657fa4abf84.camel@sipsolutions.net>
In-Reply-To: <33670310a2b84d1a650b2aa087ac9657fa4abf84.camel@sipsolutions.net>
From: David Gow <davidgow@google.com>
Date: Tue, 26 Mar 2024 18:09:17 +0800
Message-ID: <CABVgOS=F0uFA=6+cab56a_-bS1p79BrpF6zJco7j+W74Z4BR5A@mail.gmail.com>
Subject: Re: kunit alltests runs broken in mainline
To: Johannes Berg <johannes@sipsolutions.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	SeongJae Park <sj@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Brendan Higgins <brendanhiggins@google.com>, Rae Moar <rmoar@google.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 15:55, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Tue, 2024-03-26 at 01:52 +0000, Jakub Kicinski wrote:
> >
> > I'm late to the party, but FWIW I had to toss this into netdev testing
> > tree as a local patch:
> >
> > CONFIG_NETDEVICES=y
> > CONFIG_WLAN=y
>
> I'll send this in the next wireless pull, soon.
>
> > CONFIG_DAMON_DBGFS_DEPRECATED=y
>
> > The DAMON config was also breaking UML for us, BTW, and I don't see
> > any fix for that in Linus's tree. Strangeness.
>
> I noticed that too (though didn't actually find the fix) against net-
> next, wireless trees are still a bit behind. I guess it'll get fixed
> eventually.
>

+ Shuah, sj

Thanks for fixing this. I've sent out a fix (though I'm not 100% sure
it's the right one) to the DAMON issue here:
https://lore.kernel.org/linux-kselftest/20240326100740.178594-1-davidgow@google.com/

I don't think it'd conflict with the wireless fix, but if so, I'm
happy for them both to go in via KUnit if that's easier.

Sorry for the breakage!
-- David

