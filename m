Return-Path: <linux-kselftest+bounces-21437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5975A9BC3E7
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 04:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEEF1B2139A
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 03:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6145B1714B4;
	Tue,  5 Nov 2024 03:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C37JvSEY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BB33D9E;
	Tue,  5 Nov 2024 03:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730777584; cv=none; b=iq+2hdthgz+jJwfZQi3CWwWkvbGI0yG9z0zvFwAwbNu4wc9RFNlbBWd1DT3kF3MILrzTMsNdzzKU2qAYTPwT8zNxqOj3LoMIQDNxTZTtBKAFoBPxnj3iR4Z0UZFgTpmj1ASCbOhzc84Lr04TiUdh4zfynwBQez5i8Qlc6Xfoz0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730777584; c=relaxed/simple;
	bh=cwmqCLPvqMms8KSlwJdV/ZtGMAd9X/rKu8os01b98lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SixxplrXExtdS9hsggAHIjOyU9l+zJJQQAYQSz+9Dp4whI/90zO2Ub5bKVEsSNchyj6WxR9FfqU2qE0KF0G4I0h3mGfSldNQYEqJcaPQjBK5rVsb4NnHlFb8DsjusmZ9DoSDjUxvDZAncQiR6M0DsPWvK6Od8TYt58QJBljlPA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C37JvSEY; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2114214c63eso16615415ad.3;
        Mon, 04 Nov 2024 19:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730777582; x=1731382382; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QL9Eh+ucA0uGSZL2kYpF7DcVnG0izz1pCsJF9Z1GTXc=;
        b=C37JvSEYDE/sibtYrjhGDtaiSakvee4eG1hAC1kGXv7lnQhwBGirhF39FS7C+c3QQv
         1gb23cfbGc3kmf9RrUCht50OZCP0/LKv8GxwuStujGyZZxo7EDQMwlQf1sHqLFxErMhT
         hJvFBG2flULng8Zvamp1HbZ2dgVyQx+hgnLAJsxGDsnN6fZKmRnVSteFpUt/V3mvHFub
         +kqgBgSZzS3AfrWJBljJmu0GKNeELrnsDh9rlFJX6U6jmfBeV5RLRDZaig8t9kZ+N7yX
         FqRFWi76YtucB80k/0hIhIe3KNUOB7WHmHRGh4lbOYpElWGrGmfMm+zetWdGF3my+ZoX
         9zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730777582; x=1731382382;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QL9Eh+ucA0uGSZL2kYpF7DcVnG0izz1pCsJF9Z1GTXc=;
        b=SIY/82tOEn2n/gNyGppZE/kVd5mjfEo+XwjJ26JjzVX618Cz40NtsTVk77hutpPInZ
         WnV+TdXx5ovCcyXAiblcj7Tj10+/Hw7AkiONMz2xiK9joPk0PE3jXb98orwKxBySKlK8
         r0tSxRRTKH+V0dq00sBmOJbLdFTDVOdLXM+/N3p9SFw+NSicMLn/3g7XHB8qgVNhfnj1
         FcmbTQnOfqA4GKoDrMsCapLGnuumugAqC3U5IazFHg9kG+luOzol49+LCAQYf1GJ+p3p
         0OHhAvTpaB9qJMbzvMyVLR1ye7wlDf+tNtYsls0Sg7YVk6ghV7ElC5kA9xS269wtQsSC
         HNKw==
X-Forwarded-Encrypted: i=1; AJvYcCU8NV0SNF83ydSGUqByvu0tP7M+Av1btwriEixto9v/PNNnGjAie1GIpCBPMBvgKtJL32DGQTx7bXZy090=@vger.kernel.org, AJvYcCUgYKuA/wPgRrQtG1TBPp5FN9Z6CJdR7aTvf3f1WdFMrIQJIcnyy0xrXG95k0B086CZ7VUzXFYm@vger.kernel.org, AJvYcCWK9bcnOKoj/Dl2Ztkzq70RIrKtCbS520hqkTcUXEQHWNe3UQh/CAIzM1vG+kyNNFd42HV0wGnT0F4egjOnfk5b@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd81wvicTVPyhEAZQ1utkLiacL/VFSzCwWH+r/i9UADcqPoQ9n
	deD9VZrC1hgMqZ9KCmSibL/T64sLgjNyFbI7BdDJjj+bke5DuGU=
X-Google-Smtp-Source: AGHT+IFMAVN3OEGCAF/twvoo0A2O/Uil8GAPzOknu/APXznJ/gQDsxQpbbFmqlg2ypGQ95vOBFLLMA==
X-Received: by 2002:a17:903:40c8:b0:20d:cb6:11e with SMTP id d9443c01a7336-210c68dd576mr480870675ad.26.1730777582007;
        Mon, 04 Nov 2024 19:33:02 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056edc65sm68614285ad.10.2024.11.04.19.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 19:33:01 -0800 (PST)
Date: Mon, 4 Nov 2024 19:33:00 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	andrew+netdev@lunn.ch, shuah@kernel.org, horms@kernel.org,
	almasrymina@google.com, willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 06/12] selftests: ncdevmem: Switch to AF_INET6
Message-ID: <ZymR7A3Ws9ZY1jpS@mini-arch>
References: <20241104181430.228682-1-sdf@fomichev.me>
 <20241104181430.228682-7-sdf@fomichev.me>
 <20241104175418.0d996608@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241104175418.0d996608@kernel.org>

On 11/04, Jakub Kicinski wrote:
> On Mon,  4 Nov 2024 10:14:24 -0800 Stanislav Fomichev wrote:
> > -static int configure_flow_steering(void)
> > +static int configure_flow_steering(struct sockaddr_in6 *server_sin)
> >  {
> > -	return run_command("sudo ethtool -N %s flow-type tcp4 %s %s dst-ip %s %s %s dst-port %s queue %d >&2",
> > +	const char *type = "tcp6";
> > +	const char *server_addr;
> > +	char buf[256];
> > +
> > +	inet_ntop(AF_INET6, &server_sin->sin6_addr, buf, sizeof(buf));
> > +	server_addr = buf;
> > +
> > +	if (IN6_IS_ADDR_V4MAPPED(&server_sin->sin6_addr)) {
> > +		type = "tcp4";
> > +		server_addr = strrchr(server_addr, ':') + 1;
> > +	}
> > +
> > +	return run_command("sudo ethtool -N %s flow-type %s %s %s dst-ip %s %s %s dst-port %s queue %d >&2",
> >  			   ifname,
> > +			   type,
> >  			   client_ip ? "src-ip" : "",
> >  			   client_ip ?: "",
> > -			   server_ip,
> > +			   server_addr,
> >  			   client_ip ? "src-port" : "",
> >  			   client_ip ? port : "",
> >  			   port, start_queue);
> 
> nit: I think this generate a truncation warning, not sure if it's easy
> to fix:
> 
> ncdevmem.c:259:28: warning: ‘%s’ directive output may be truncated writing up to 255 bytes into a region of size between 209 and 215 [-Wformat-truncation=]
>   259 |         return run_command("sudo ethtool -N %s flow-type %s %s %s dst-ip %s %s %s dst-port %s queue %d >&2",
>       |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> maybe make buf smaller? 🤔️

Are you having some extra -W arguments to make it trigger on the build
bot? Wonder why I don't see the warning locally.. (will try to pass
-Wformat-truncation)

