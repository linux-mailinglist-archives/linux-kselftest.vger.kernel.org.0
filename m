Return-Path: <linux-kselftest+bounces-34744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 392BCAD5A7C
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 17:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E58A3A2489
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 15:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6651C8632;
	Wed, 11 Jun 2025 15:30:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1048413C81B;
	Wed, 11 Jun 2025 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749655818; cv=none; b=AN0S8h8au6zhswX4zmPwbRo2uXwDVdMX06+b1Gkv9n/hNFAlyUAK2MY8OqFfBAe1U+alMWUP9KH5ESBhcNiKYVZkFhxauvyYyLTt342kOJzGZ0VBjzPDXCxSO4Lhb/MmMoLUGWotD1DKn/3R3qbMB3cwLRB7DUg6WYMeMkdV/O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749655818; c=relaxed/simple;
	bh=me7hTnC3owdy4sHQPBKARVuS+hl5ofHZmQhcRYsgm2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDD8ekw+fhqaoVXkg3wRnnnRXyzJlH1JkrxanvakJHT8u8h4XoUnYV3OkRt78xfam+NPb2dIymTIn8DMAV/StCICcHyd9++XtXPUOTS70KmEuU8xamhpy16hwbvT1NyCGvu0cF5WBTIV1IXT5zXWvDV6CxoWSLgxxYQTLZIiDwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-606fdbd20afso47275a12.1;
        Wed, 11 Jun 2025 08:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749655814; x=1750260614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUie1GuPz3nxQfCu5WO0KOXtG3mRCIy5PewTihRgmyg=;
        b=EmfcvGtknrbd5o3XZVw5QkcpMluRzPbG8de8/xj9UPstpmCa5/xD3L1c8Brf9gjAnm
         s1ZT5QtWitykHlbA6wdQLCI7Yy3LaFXglHXGZhuyO41Q76JCuEafd8zbt4a+U0YoC/OX
         23soF+ym71YKcfcc++dXk+GzHHX6wgWGub0MSibeVaLO44rdO1hCJdiC7h9MH0hYt0oh
         gE/Hq+b/PrEpcD0wZVqMuUTLnRWq3aVwUOk14rZk719V3HeaQJF5c7wUaF6K29UgGGaf
         wBB3UzSP88qxJOqsZhHEHYlVso3SvY5nI36CSTPTWDIaOtvyhMPCdSx1sG2BUN4Z6z7v
         Hxow==
X-Forwarded-Encrypted: i=1; AJvYcCV3jkDiDo6Ix0LWNHh1WDxG4C/cp8MB/YEf82rPILZbWo/D7On1thRTlDvMNcYbvUsAkr6+K123Vxk=@vger.kernel.org, AJvYcCVvDelkC+QKAg90X4z71Qx/LVPDCsmhfYOyLZtIg8+eB151ZC8qFovbMJShdSYsT+974SqJjujS@vger.kernel.org, AJvYcCWjdOoHMdU7+qv0uJHgCkc5Z6Gk1wwdqoezTTTj+KQ+rNUP/x2hW7lVCDc59osJ8IyFLKDe5n7m6+Cth3XPqqxO@vger.kernel.org, AJvYcCWrcD4tjTxPuSTXqI9U9CSWPYekH8/Yv5qhuGQoXBqjVM2A9gNCgoXsbZNpD8AvpSTFUoNJUJQfsrtf4zBV@vger.kernel.org
X-Gm-Message-State: AOJu0YzsQtNb0XymXkB3B48rdcUXB1s01+17YLK5EbnDb9F72X/NafgP
	T2ulbFbBMX38n4yV5GHRABGM+Gji0l1na6TUdlU+JqEmR4UB+WdF+RBc6hIDag==
X-Gm-Gg: ASbGncsYAWAww5SHC7hJeOl+oucD+ER3u3MYVP5CpaLqrauSt00J2x7BSfDcZRXBTrC
	5Sk0BD4WrN/FKB5uTgABVUFf1gyTcS+NSjD/3j9OI/hQ70gsk/0T3aH74CXlYOfzMcRTojirh3f
	RIt939Ft+yWQxuay6SCsBxWJW6FsRMAfPLefTqha7+mpQTfUExK1CtqS5965vvcgGJZavUvhi6E
	Kqf1rf70qkMSRVYzx1lniMXfqQdlG/pAOu3VihotXwi4EU2aBvYeaClssjZ+ivuCGGcDaSBxGY9
	qYOsX8Td7ztItUrbq0oJpDn1d5ax92qouXq7KPpyNdKYvIrDl2E4
X-Google-Smtp-Source: AGHT+IE8N5wV34cUPxiOzs7PaILot9mRgAqsdxwknTuYVOYElIqcGbivsb9/Qiz0VClgksSDfe4LhQ==
X-Received: by 2002:a05:6402:518e:b0:607:671:2e81 with SMTP id 4fb4d7f45d1cf-6086386dd60mr295045a12.11.1749655814115;
        Wed, 11 Jun 2025 08:30:14 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607783e65adsm7566889a12.70.2025.06.11.08.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 08:30:13 -0700 (PDT)
Date: Wed, 11 Jun 2025 08:30:11 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 3/5] netconsole: append msgid to sysdata
Message-ID: <aEmhA0QoZy3LbAu+@gmail.com>
References: <20250611-netconsole-msgid-v1-0-1784a51feb1e@gmail.com>
 <20250611-netconsole-msgid-v1-3-1784a51feb1e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-netconsole-msgid-v1-3-1784a51feb1e@gmail.com>

On Wed, Jun 11, 2025 at 07:36:05AM -0700, Gustavo Luiz Duarte wrote:
> Add msgcounter to the netconsole_target struct to generate message IDs.
> If the msgid_enabled attribute is true, increment msgcounter and append
> msgid=<msgcounter> to sysdata buffer before sending the message.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
> ---
>  drivers/net/netconsole.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 813f50abaf9f..34b61e299eeb 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -155,6 +155,8 @@ struct netconsole_target {
>  	size_t			userdata_length;
>  	/* bit-wise with sysdata_feature bits */
>  	u32			sysdata_fields;
> +	/* protected by target_list_lock */
> +	u32			msgcounter;
>  #endif
>  	struct netconsole_target_stats stats;
>  	bool			enabled;
> @@ -1345,13 +1347,21 @@ static int sysdata_append_release(struct netconsole_target *nt, int offset)
>  			 init_utsname()->release);
>  }
>  
> +static int sysdata_append_msgid(struct netconsole_target *nt, int offset)
> +{
> +	nt->msgcounter++;

This will eventually wrap. I am wondering if you should use the
overflow.h helpers to avoid warnings in UBSAN and friends.

Quick glanced over that filed, I found:

	/**
	* wrapping_add() - Intentionally perform a wrapping addition
	* @type: type for result of calculation
	* @a: first addend
	* @b: second addend
	*
	* Return the potentially wrapped-around addition without
	* tripping any wrap-around sanitizers that may be enabled.
	*/

> +	return scnprintf(&nt->extradata_complete[offset],
> +			 MAX_EXTRADATA_ENTRY_LEN, " msgid=%u\n",
> +			 nt->msgcounter);
> +}
> +
>  /*
>   * prepare_extradata - append sysdata at extradata_complete in runtime
>   * @nt: target to send message to
>   */
>  static int prepare_extradata(struct netconsole_target *nt)
>  {
> -	u32 fields = SYSDATA_CPU_NR | SYSDATA_TASKNAME;
> +	u32 fields = SYSDATA_CPU_NR | SYSDATA_TASKNAME | SYSDATA_MSGID;

This might be gone now, according to your last patch.,

LGTM.

