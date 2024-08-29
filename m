Return-Path: <linux-kselftest+bounces-16674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC169640F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 12:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BFAAB21DB1
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 10:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DCE18DF9F;
	Thu, 29 Aug 2024 10:08:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4091E18CC1E;
	Thu, 29 Aug 2024 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926088; cv=none; b=h/1jdFjklUW6ePX7XxXgA3DISDuAp+ZVcYgThxidb4WIrL9OyM76I+5NlGAKYgo9muShiFU+jLMC32Hc8ts74pjsioY/SAKzF6P8ZTsNzEN2LXEdkmcEGfCD82u+qqyA166YHrLkz/FbxT1VHuJu578ZwLbF8zDohCr9p/eGZ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926088; c=relaxed/simple;
	bh=v7npGnWVI06jQB/GP+WqmHASzHtfMK63ymHNNGaUS9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFJqTEfxBWYlTw7dIEhoRPeMpGBO1HZ+BjEwCAKVXLrCy/So5bJet+9QX2oa+ezOJf09CouJyA1WiHvjCUWaIQPZHbQF07Pooq/aqhV+JgOzBwNAmB6QVlPXh7BqRhmYR7YO483tm/fA72Fmj0yHUWEBwv7JymzgJgSLxL5j/Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5334adf7249so645506e87.3;
        Thu, 29 Aug 2024 03:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926085; x=1725530885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68VfpIe/gY3b5Zsqxl5bIsvzSythZF52J8UjEnejXGE=;
        b=XCjImMkft1QWJvHeR+XzkO47uOooNgeVvZXJrZncHO+3wurLG/Mp/itLAGg3tbc5Gi
         ppqThxJRUoUR3FevnIgew26tSmQweyFBCnkCnnbGHTwaB4a0rhnN4Fj/QrX88anXYd34
         y/Os9loT5b6PLTBu2wgrOpKBn5CzHI6It3vAwCXBH7qSp6hINn5ewPIQhZE0AkwIuZzF
         QlZstIOUcFX5kanIRZrFwYtqbG30SdkRbzuWJ9l4cRlmdxRLfGZu7LHy2Ad3FrlK4vvO
         YwNym/Iy8VeM4WEGXCqzZi0fEmydqM220GuFXcNjaiSA/T2l4IuFg1K8TQL8DvnCynKh
         4/uA==
X-Forwarded-Encrypted: i=1; AJvYcCUobM+cTW6kP56gbxZQWGYOgnvzCK0Mj3Ryr4hGoGZMnYiPrUvru7OeeFqdZ88bNTUe3TTEWih5@vger.kernel.org, AJvYcCUv3zcQBPDpy8b73zXUi7ByDTOZVgVwyZaoLQntjadPcAydm0Zg+RncDOv6PsE8Lw5uE61wR5hHX370jOnEts2m@vger.kernel.org, AJvYcCWWvIFXh31M4xE1sL2cQjBwUg/c40+zjEjkbFSOxFwoYDABTjw8zkXjh9ueH3neAjIznDaYQ+hDkSeptjn2z2KE@vger.kernel.org, AJvYcCXdaea2AwDn06d39g+CK60AjUClll0WF3CSDDbRe4TwsXtm92aLP98e600c2ws9e5U3pnGnDAJBEQLCAcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz779Lk9kpY/UGZUFh/dUa7yPoqYXzkwr4jWo5+d/6c/wqZVor8
	lINScQZpb0Uu2nsbKi2Di5E0zOUMvZuYPEl6hQ0ZNeLNxMYv3REh3wvYKA==
X-Google-Smtp-Source: AGHT+IFmz+YxnGXgxNh++Tsg0uingdtxTTovmvly65eI0+SFc9ZOa//xepAe3YbevHsB4xnK70BHgQ==
X-Received: by 2002:a05:6512:10d6:b0:52c:90b6:170f with SMTP id 2adb3069b0e04-5353e56eab0mr1847296e87.29.1724926084638;
        Thu, 29 Aug 2024 03:08:04 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-113.fbsv.net. [2a03:2880:30ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d6dc3sm58031766b.156.2024.08.29.03.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:08:04 -0700 (PDT)
Date: Thu, 29 Aug 2024 03:08:01 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: fw@strlen.de, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	rbc@meta.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	"open list:NETFILTER" <coreteam@netfilter.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH nf-next v3 1/2] netfilter: Make IP_NF_IPTABLES_LEGACY
 selectable
Message-ID: <ZtBIgekUyptmCqRa@gmail.com>
References: <20240827145242.3094777-1-leitao@debian.org>
 <20240827145242.3094777-2-leitao@debian.org>
 <20240828074240.2abaa74c@kernel.org>
 <Zs88pbEadxLWLLbn@gmail.com>
 <20240828114123.3c85a9a5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828114123.3c85a9a5@kernel.org>

Hello Jakub,

On Wed, Aug 28, 2024 at 11:41:23AM -0700, Jakub Kicinski wrote:
> On Wed, 28 Aug 2024 08:05:09 -0700 Breno Leitao wrote:
> > On Wed, Aug 28, 2024 at 07:42:40AM -0700, Jakub Kicinski wrote:
> > > On Tue, 27 Aug 2024 07:52:40 -0700 Breno Leitao wrote:  
> > > > +++ b/tools/testing/selftests/net/config  
> > > 
> > > You gotta check all the configs, net is now fine, but bpf still breaks.
> > > There may be more configs we don't use in CI.  
> > 
> > Sure, how can I find which configs I should care about?
> 
> There are various configs in the tree. Grep for the configs you convert
> from select to depends on, they will all need updating.

I am looking at all files that depend on these Kconfig options, and
there are a lot of tests.

Thinking more about the problem, it doesn't seem to be a good idea to
change dependency from all NF modules to NF_IPTABLES_LEGACY. In other
words, the `s/selects/depends on/` is the part that is causing all this
hassle, and it seems unnecessary.

That said, I would suggest we do not change the dependency, and keep the
"select NF_IPTABLES_LEGACY", and keep NF_IPTABLES_LEGACY user selectable.

This will make the patch safer, while fixing the problem.

