Return-Path: <linux-kselftest+bounces-44819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66778C36A37
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 17:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5149A1A27563
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 16:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17CB33439B;
	Wed,  5 Nov 2025 16:04:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED644321448
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358688; cv=none; b=sbRuYdQlmTZoTLWP4vhY7hjrHyGS/ljo8WjweNbM5pGs8cRlj/rQny91UOH/lQaVfIFUQkxd9IljA3WHN+4zHAuSH9SwMhpfj9EK07KLjXqazuIwW+TOOnkl6z3l5yV6H9Grgw7NDs0zAFF4sCXxEZWkbBp+kDamfdRu3zaJS38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358688; c=relaxed/simple;
	bh=JofqSWCzl11ihkf1QS7aH5EerIGWNBW0jBvqMlbq2a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4EKlXJ1ZszkMzm8Fx21yuaO0VEI4GZyUlhA5DmKUrWBMLBS9gQFnUy7CRBuBIaRb4irBT1jdVhW/556XgUja1EWibp4Jn6a5HSApxTB1ZXB3UStyVq1iPRY/9PZgMPBeqm/o98LSuzqZVeNKOnc9gk5OkOEfywl7IGOWt/MxT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso1082711166b.3
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 08:04:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358685; x=1762963485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQtbK0HPx+N0NDzFM7oR+NUAI3H2NYy2UQCcQpjJkTY=;
        b=Ob2HU8p7Xw8tk9lHe8MZe+bDMqRWtwS8F0rfjlepZDxIZpVTwZXWhldWnCMYCoNJDJ
         +0ym+wdnkcbGzg1/0rCT4I0+ppc8C+bT29X/0mi6F8kN9XtdcU7jhqpdkV7zfvXKOtCd
         9M1x4Ufh8EPFz41OujvsUKhjlZ6LJbcnaMF5i+XudS3wsaZec2pkxtr+vRoEhFsb4cH0
         bO77Dk8u80xHYKIWsAX5nM5lx5V5JlConK/EY1uGZiCsTmmtuCcGlt/VtVNX97Qa/F9D
         o2FYXYy1eoN35aJcq0LPHzk98Dir0bJqWBSXSRnrI85M8mRM7Ta4ssbuZbMsiwSDBhc5
         ES6A==
X-Forwarded-Encrypted: i=1; AJvYcCXh7cQi59zstc+/odegAT5Oq6nRGSn5HDm4zSerKU5QAMeBC02IETgJ+YDCmQwXZehidx6zCN3HRpMYw5Vme50=@vger.kernel.org
X-Gm-Message-State: AOJu0YynbOWfP231B9uJG4s8y+MWOLIBqP7+a2gGHP8fBWuDbdNH55L+
	g5iYvWThYXSjduSKXsbp272Jf0zHn1ciwsiBZvrjDqoiWkeVTfAfvo0hKA9rzw==
X-Gm-Gg: ASbGnctBoZc3q15foE5fJw9XAjx8SvFN09/z7/UNhtqBlq9FwsrOUChScPd0gTxwXyl
	aq2XUvYtbisZ2lfNcXnQ7yVJUUN0pIzmU5LdnCL6yapd5yZTErMw6DBk+Twzq63hYE1w7Ej1FG/
	8OLz7nXm/nLo4OfKNPgNpwNxmv1eXu+rW5YaOHjyregG+SoEb9q9RdMz0GbGce8C1aVnP9DuiMC
	MuIfX+TOeRd/SVZktWAn6DTi2+4H4Pc+MdkgyUOFDA63au+ytqCW0p7s0ADatuMdoU4vXd2b1A4
	U6/GKnvltPcLRMTHy1ynMqhvnqNl97vorLPjGHZOKM3hJzZ+/236UBZV74vKGKpxmmrUjHvJPRI
	mkbLMf+NW3Q+xhqmieFUG4dkhkHXa18QGi9VD7eH++kCz/x0L+/mKnD8Cn6RTwdK+z9U=
X-Google-Smtp-Source: AGHT+IFeg0PfZi72Z71d5ee0yOEa03D5xAyx6X2QALCBR3Xeog/mqq1XoLJB5RS10SM8/uMZFbIGPg==
X-Received: by 2002:a17:907:9815:b0:b71:854:4e49 with SMTP id a640c23a62f3a-b72655edfabmr373939666b.56.1762358685029;
        Wed, 05 Nov 2025 08:04:45 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e2597sm528556266b.45.2025.11.05.08.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:04:44 -0800 (PST)
Date: Wed, 5 Nov 2025 08:04:42 -0800
From: Breno Leitao <leitao@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, calvin@wbinvd.org, 
	kernel-team@meta.com, jv@jvosburgh.net
Subject: Re: [PATCH net v8 4/4] selftest: netcons: add test for netconsole
 over bonded interfaces
Message-ID: <sw7wovxj7l43rj2dkvapzl3w6rrbai5qje4zswz6xrxmmkyxtm@gym66qdsivwh>
References: <20251104-netconsole_torture-v8-0-5288440e2fa0@debian.org>
 <20251104-netconsole_torture-v8-4-5288440e2fa0@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-netconsole_torture-v8-4-5288440e2fa0@debian.org>

On Tue, Nov 04, 2025 at 09:37:04AM -0800, Breno Leitao wrote:
> diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
> index 6bb290abd48bf..57f5a5d5cea67 100644
> --- a/tools/testing/selftests/drivers/net/bonding/config
> +++ b/tools/testing/selftests/drivers/net/bonding/config
> @@ -1,5 +1,6 @@
>  CONFIG_BONDING=y
>  CONFIG_BRIDGE=y
> +CONFIG_CONFIGFS_FS=y
>  CONFIG_DUMMY=y
>  CONFIG_INET_ESP=y
>  CONFIG_INET_ESP_OFFLOAD=y
> @@ -11,6 +12,9 @@ CONFIG_NET_CLS_FLOWER=y
>  CONFIG_NET_CLS_MATCHALL=m
>  CONFIG_NETDEVSIM=m
>  CONFIG_NET_SCH_INGRESS=y
> +CONFIG_NETCONSOLE=m
> +CONFIG_NETCONSOLE_DYNAMIC=y
> +CONFIG_NETCONSOLE_EXTENDED_LOG=y

I've just realized that check_selftest discards the '_' when checking
for the order. This means NETCONSOLE should come before
CONFIG_NET_SCH_INGRESS.

I will wait for additional review, before updating.

