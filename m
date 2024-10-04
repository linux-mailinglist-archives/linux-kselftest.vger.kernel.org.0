Return-Path: <linux-kselftest+bounces-19019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD0D990450
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 15:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73AA1F21A72
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 13:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25BA2139DF;
	Fri,  4 Oct 2024 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vq3C08dL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303EC2139B1;
	Fri,  4 Oct 2024 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048454; cv=none; b=Lr83v7qWffO1sZzkrdit6Q5KNAz9fzyVxkgQK7e2CPtpikoJb+e4Six68Z0JPwj6oRI+WVceAHkuFaG7cHyr6WzQ08mxxEj57BJmaqw6IjWCYmHlnhSTmuiLXEz/C+6Ii0WZe7fn0hpJitpWcNQRUkvBkJuB7Xshlrk6UxOnZS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048454; c=relaxed/simple;
	bh=wcg9NfwkZy7+ePoluepbaDrhRVrYMrqO3WU8+R2Sdjo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=qhNAmWiBfr+IdYVKf6qB2Wu2bEWG8HBKMIrFb7aIaB2LpLth2bQF9CoLoZxibinDIgEwmORYcLUNoQUywqnVpO3vhIV8w09Dw6GVAxRi+6iOfF2fSIaDhXpZ3KbxrE6eD2FofeRqCchSEmo2UuRhoiRXud2p759x0zgtTHN5lnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vq3C08dL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cbc22e1c4so17144325e9.2;
        Fri, 04 Oct 2024 06:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728048450; x=1728653250; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pPs9699qh78nUh7Ck+Zku3WQCWqQe2zlzey+/CEixmM=;
        b=Vq3C08dLkcjZKhN1lszEaZNgjjVQSyqQaRcLYWdqrsW92OWYqzHXzm5x/QkW+vXELE
         MCRcZvLIgnqcrAklaKLoxsqE09y47e2QA9Lj+TiQ/mxlPeC8Opfk5/gAAfGytrDMtt/g
         2v7Ivr/k8TgQvLhZ+xHPpXOgUoClszUZTl+9oKmnSwOhc5dUkzTYtn05Dl4JFdl7L6oN
         pscTi+bX5DCjEnfS8pAdQHeuRLrJC8+Vb2oxCJMM1PMFJCpiGEZIEoIEg/xSXG0V3nyQ
         BF0SJy1VpBq/hZPOajEqAtgVdTtQY4ekPnbmvxO2zJXfgrtf92LCXztc3Y41DO2E/sc2
         kGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728048450; x=1728653250;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPs9699qh78nUh7Ck+Zku3WQCWqQe2zlzey+/CEixmM=;
        b=pTm6s3G/rKHTD+TRErc8CqT6lViqE023DMy+sv+SYmPxjRSV4BW2wJ87uBYI48GpzC
         /MlwjEafO+yJlDPQh2Y8g4PzS1CCeV+YCIKjRWOFd81DP5jK5Jt4dXvB9PBBkgOe4Vdj
         +7S3THArM8s1WbJn6WwKbBDbIMuqe9h1YyELgKIADCt0dDAPGPROb0DBrj+g5VVuqwE1
         Dr2hxXFY33BvloNcbBrgIeKU34BfazlfLlz6uLnPlVvLiD2m+8K88n/dn01dwtm5E9h6
         1CXWZ91Ao/BxNPeVNAdbod19MKfprMnXylasnUdMXzrawe1xah5qHi97vQ7T/17xFqxq
         gK0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUY1yj8up7dl/KoRmmSwYMlFsD2JcaeURzzahkfFXfNvnlbLD6TDVkJDZrOzYw2PM7Q8/DZSOfUYWcSjl0=@vger.kernel.org, AJvYcCWIsY3ErXIFXRmaEUykEvGP3/jUmS04P+714UT6PPg0ffW0VgIblI19//H7QHTGWzL5KBxM6SHR66FTnye8khld@vger.kernel.org, AJvYcCX+iAY7pzf47G/u2nlYab5DXemEP38FxNXhOKMx6pNs3Pnls1PF6AKyDt0bwF/YP1bGRrvRFkc6@vger.kernel.org
X-Gm-Message-State: AOJu0YyhXwaUVvnXvoyhBW3dyOzYlNJ4utb59MY/pN2GJJ+MsIF+ZOvR
	+ytTpAA4RuBDceO+BXQ90RaU6emHXoinaG4kyHP5OjjAvqS9/uzp
X-Google-Smtp-Source: AGHT+IHkTjRLCXy9DjHO9CfeCffvqDeVVM2xUdtxUAAf2e/y3hOMv6kLqLuJ+2bAFdJRO5VpoQPmtg==
X-Received: by 2002:a05:6000:dcc:b0:37c:d0f9:58c with SMTP id ffacd0b85a97d-37d0e7843e7mr1782737f8f.35.1728048449696;
        Fri, 04 Oct 2024 06:27:29 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:395e:c10e:1999:d9f1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d081f736esm3257450f8f.18.2024.10.04.06.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 06:27:29 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Shuah Khan <shuah@kernel.org>,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  sd@queasysnail.net,
  ryazanov.s.a@gmail.com
Subject: Re: [PATCH net-next v8 01/24] netlink: add NLA_POLICY_MAX_LEN macro
In-Reply-To: <20241002-b4-ovpn-v8-1-37ceffcffbde@openvpn.net> (Antonio
	Quartulli's message of "Wed, 02 Oct 2024 11:02:15 +0200")
Date: Fri, 04 Oct 2024 13:58:04 +0100
Message-ID: <m2msjkf2jn.fsf@gmail.com>
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
	<20241002-b4-ovpn-v8-1-37ceffcffbde@openvpn.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Antonio Quartulli <antonio@openvpn.net> writes:

> Similarly to NLA_POLICY_MIN_LEN, NLA_POLICY_MAX_LEN defines a policy
> with a maximum length value.
>
> The netlink generator for YAML specs has been extended accordingly.
>
> Cc: donald.hunter@gmail.com
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>  include/net/netlink.h      | 1 +
>  tools/net/ynl/ynl-gen-c.py | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/include/net/netlink.h b/include/net/netlink.h
> index db6af207287c839408c58cb28b82408e0548eaca..2dc671c977ff3297975269d236264907009703d3 100644
> --- a/include/net/netlink.h
> +++ b/include/net/netlink.h
> @@ -469,6 +469,7 @@ struct nla_policy {
>  	.max = _len						\
>  }
>  #define NLA_POLICY_MIN_LEN(_len)	NLA_POLICY_MIN(NLA_BINARY, _len)
> +#define NLA_POLICY_MAX_LEN(_len)	NLA_POLICY_MAX(NLA_BINARY, _len)
>  
>  /**
>   * struct nl_info - netlink source information
> diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
> index 717530bc9c52e7cfa897814870b4583c88618a27..3ccbb301be87f80bbcf03da63d60f58c4fedc1c8 100755
> --- a/tools/net/ynl/ynl-gen-c.py
> +++ b/tools/net/ynl/ynl-gen-c.py
> @@ -466,6 +466,8 @@ class TypeBinary(Type):
>      def _attr_policy(self, policy):
>          if 'exact-len' in self.checks:
>              mem = 'NLA_POLICY_EXACT_LEN(' + str(self.get_limit('exact-len')) + ')'
> +        elif 'max-len' in self.checks:
> +            mem = 'NLA_POLICY_MAX_LEN(' + str(self.get_limit('max-len')) + ')'

This takes precedence over min-length. What if both are set? The logic
should probably check and use NLA_POLICY_RANGE

>          else:
>              mem = '{ '
>              if len(self.checks) == 1 and 'min-len' in self.checks:

Perhaps this should use NLA_POLICY_MIN_LEN ? In fact the current code
looks broken to me because the NLA_BINARY len check in validate_nla() is
a max length check, right?

https://elixir.bootlin.com/linux/v6.11.1/source/lib/nlattr.c#L499

The alternative is you emit an explicit initializer that includes the
correct NLA_VALIDATE_* type and sets type, min and/or max.

