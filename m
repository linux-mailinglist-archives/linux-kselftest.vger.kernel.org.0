Return-Path: <linux-kselftest+bounces-33344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBB8ABC84A
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 22:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C05B07A90CD
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 20:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394311DF24F;
	Mon, 19 May 2025 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jviXqZPQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A21152E02;
	Mon, 19 May 2025 20:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747685908; cv=none; b=hj3z01VV1LBvWpBnlz/Q72UAGyUW4zqZ8Qn6F0Yn6xJ/xV5n5t5GigTqhN3j7GX9gKMHMN2RCfb7rY63R0dTb7c0FKx456vldUaP48106+U1tNoCMPMst8K7M5YqbiSe7db+FoUgnPmYxySFlku+sYI7UywC7w0gtl4R+RMxmiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747685908; c=relaxed/simple;
	bh=3kDAClqFHDOoUnyLge3RBJUMy2kXoR2roeHAT1JNcbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuC6MLkAzI0lyocWo18dxjgUxl/yjsI+OIgjhz2sLt+BjQrmRc43rK/ubrPsdGiRL2ZICFM4OJVyIWB/NYpQRi4MSQlEPu1tI2oXklPy9pUMAFri2JDUHbtg/UgOj0J2HDANZptVr9BlJpNF2dTdBI7/3htBTc7V2vBD5y++6Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jviXqZPQ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-742b614581dso3362847b3a.3;
        Mon, 19 May 2025 13:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747685906; x=1748290706; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5dUkToe6133HCn9oH6HeuV64GRZQpP/9OlW0HBh+lDU=;
        b=jviXqZPQQBzUCb3CQz3zpPEqOwdtjKPnAn1f/BApajLQZR2TVBEXoZzcwF+LVqZApi
         bK6JqV10ABnuKMOcYWxZ7c6wdjnfrf5ubdK4DixeJJzDUxF+8y/0im6Vihk+Iop/FRfv
         PbHFOs1QnBobNWCPK7JJPZLBe39YNLK0AKxiKffyl+JSSz0CSzi5CObnV6rEiDxoqb46
         d4UfU9iBwjl6AiXaljcvONkEDjqPZDE7omHLi85wVvx/7FBrfiOdRKVEYuGNs9FrMg2x
         AaDmo75/RMForviq4JPSAeaF0e2SAV3gxdADWwRjG11yIBLFO5USTnfBWtoB3fZzApfu
         ZtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747685906; x=1748290706;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5dUkToe6133HCn9oH6HeuV64GRZQpP/9OlW0HBh+lDU=;
        b=e/6YReGHlwaEoKnwz/4znXWjeRG+h3dYPlcxbuVp1iZnLbnADx3FJEDkenwPqcIboS
         6ISlD1MkP7X/fKhRMHf51tEoKv1NgiSfSGfCdUuduZPS7UXldY57HpEvbbsgsSM/9OuX
         cDJmPsN5eq559kv8OJP1eLH6hoq2mcEqs3YhQxtpzbi3+hXlz/YAPv9T6VEu5gR4uu2g
         UFBDZnibYl2kUqcgDrzG2ZMA72KK3lXLFFiSDJXE2+grFdOXftcC3hqGiZqjvju4xwmT
         dk9b3qqdjYx/cVFsBNGHgamXl8zXyuDewq/2q6H/P0frMxqprR7bQPk1lnBoivC8qEzz
         R2LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR/lHigaythxgD6ekw7HrAdv+LmaO/yCkWINCFqnDbS+KPkp8k/oORV4sNmnVwZmKXRfgzO/S59fL4HTQ=@vger.kernel.org, AJvYcCWuqrVrPcx0KkEDYjwE4KYiKGstjTakd09NOBVjJjZqMWxdDnKMSlH6ZY8xjxEGVsHFch43oiryGPgajfXUIqFw@vger.kernel.org
X-Gm-Message-State: AOJu0YwHd5M06oPq+ArFAJfCBjQAwJjuuLzseAwKYPbTyPQVfKOoifto
	gv3HJox+msxIpkF3UG1G/BfcJlF+eRiez/vTb21SdBp+oaXk3hugeRs=
X-Gm-Gg: ASbGnctrhqlo556QLfrjmy+kcdrFoPtYPrtHNx1ruxqBD8+MCRkxWMQyhoyQKeM3A9S
	UjtrvmFyaOkBlUsmLKz1ynfwWKuZQAP/pc4rQThw+10yqbghNYLO5T/QvLfRjHfDG3rZ/sCU9QW
	D4J4rdv0zxiz2ofsRLp2RSIrMT+fKbmi7MzwGw7MQGQxl1BxkWtHHmCnzJCeU/U0eK8SWy0A5Nv
	HR2LezFrLay8HREZxCKiXwJ7K7yDM7CsxagKxfNs0widmQnA+fa2xXn/KqGWBt/MeFmMVOsdem9
	D1u1RCK7vThELrCJt2EPqiSiCViYmxtFzmkiTDAEmItmDdagiKdW9KqXVRJUsG+XimAoTr8HiSh
	ehzYxTdPmclpJ
X-Google-Smtp-Source: AGHT+IGqGCI84mG3nuTlxoIkQlSjkZTHBiQnHQ6MCgb3WED28+iuxjh3EdkFKKf+zLsFLAY7KJxpig==
X-Received: by 2002:a05:6a21:3385:b0:1fa:9819:b064 with SMTP id adf61e73a8af0-2170cb407f7mr19171966637.18.1747685905826;
        Mon, 19 May 2025 13:18:25 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-742a970c6b1sm6870000b3a.59.2025.05.19.13.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 13:18:25 -0700 (PDT)
Date: Mon, 19 May 2025 13:18:24 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	sdf@fomichev.me, ap420073@gmail.com, praan@google.com,
	shivajikant@google.com
Subject: Re: [PATCH net-next v1 4/9] net: devmem: ksft: remove ksft_disruptive
Message-ID: <aCuSECZWisb5vQUE@mini-arch>
References: <20250519023517.4062941-1-almasrymina@google.com>
 <20250519023517.4062941-5-almasrymina@google.com>
 <aCtNYJo01UfMOLfr@mini-arch>
 <CAHS8izOMLm5jLr+778nY0AdFoOWPSb+UV+1sZmOkFb5SSqTGqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOMLm5jLr+778nY0AdFoOWPSb+UV+1sZmOkFb5SSqTGqg@mail.gmail.com>

On 05/19, Mina Almasry wrote:
> On Mon, May 19, 2025 at 8:25 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 05/19, Mina Almasry wrote:
> > > As far as I can tell the ksft_disruptive here is unnecessary. These
> > > tests are largerly independent, and when one test fails, it's nice to
> > > know the results from all the other test cases.
> >
> > We currently don't do anything special for disruptive tests. I'm assuming
> > anything that changes nic configuration is disruptive and was thinking of
> > an option to run all disruptive tests at the end of the run. But so far we
> > haven't had any problem with mixing disruptive and non-disruptive tests,
> > so it's all moot. I'd prefer to keep everything as is for now (or remove
> > this whole disruptive category).
> 
> I've noticed that if all the tests are marked disruptive, and one test
> fails, the others don't run at all, which seems unnecessary. I'd like
> to see if the rx test passed if the tx one failed and vice versa for
> example. Removing the disruptive tag seems to resolve that.

I don't think that's the expected behavior. Disruptive should not
have any effect on other tests if any one fails. Any idea why it happens?

