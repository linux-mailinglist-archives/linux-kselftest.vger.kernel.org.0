Return-Path: <linux-kselftest+bounces-21461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 620A89BD3B6
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 18:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E761C22A35
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 17:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC3B1DD0D1;
	Tue,  5 Nov 2024 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzDP4yNB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B133BBC9;
	Tue,  5 Nov 2024 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730828773; cv=none; b=rzE7hNuH1uCb4/HgJ/KJIrszpQxljnCzjYc6pGx1/WklUYfOZqx44f1+xFz921SnCZ0YcngcGd4eZrdQcFk8N3AYClo9tWqf8E2etjdGx0FC/iFxmCazE/5tUWekhuC9EKre/gY9Ny8vkfr/8W01lc7PkNxszqVDbASfkL2HIwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730828773; c=relaxed/simple;
	bh=+FUsLsTyGMpWDoKvFD/1W7Wa3Tggg5nEAW23Jq6NNpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCJ8HpUHCzxDLRbtUdnTWoKYcRiO2yzLiSvIfHGzypOMIu5ATM9wwqSMgajEIn+RAwNPvX/5BUuxIgBe8VDZkPC9A3T7pzZ8m7cUqSIAdqgMD4GLyMCYnM55FrU9aweYZ+weo7/MkI+2zd23puO9iokBRGN24qkutmcXDR+YJ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzDP4yNB; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e953f4e7cso4652958b3a.3;
        Tue, 05 Nov 2024 09:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730828772; x=1731433572; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qA3PXY9MCOr7JpDpY/056juwYQ4sogZW24EQ/kDsSUQ=;
        b=SzDP4yNBE4TshYrtN42zGcDtYGjtbir9jc+TjPHyqCzmD6P65HzMOlGzApHcqy1KKb
         PCFaWrhDOpZr5MSqt4anhS7vUqxUYa0H+EllaNGxCip5WPbciIzY6Zx6y3Fw5hnqEbzM
         MQ8R7sb7EzFfumKGqgckxYnAnwl6Xla3dPurL83L4Q1bXWCOx/xTjgNKKlNurLPpNrK3
         EvFDtcDuS+YgbtQhg5dKZkZhSkLUpjFK3EhfVrpstL8LaSpqvHznAazZVJXqzQX6QFiO
         yBHVILocitIQc3WiT8OcVsqG6n6h4sz0XYnBpKlNOGWdD3Z31WqUQruo+TJXvPThoaf9
         Vj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730828772; x=1731433572;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qA3PXY9MCOr7JpDpY/056juwYQ4sogZW24EQ/kDsSUQ=;
        b=n8z48Xc19uW8YS832uCTacZUg4egKH6vdp2gSn9gTqAqrQmWxYsax2e/qlC7MzBCfI
         CzJqtuXabWwUzCxcANe114HmqvArROHVlqwdi/skY8NeXW5kDK1UQnabyJuQ2KJm8IT4
         aAPsRAJxLLSB2hNc2Vcw/b1toJkvBR52Q7k2VLbaJL0hjbFZcK10V2RgqWSk/Ef6ZFNB
         UJnwUMqccL81tuSKpS08fTVoEl2dFJEfvpmLxgutoHgdg9Wy/EL6aDOoH9IJVhGSo2xC
         xiJ0QTna7lFweg/SO4msb2ig7vpb6tFvfZq9D9PkSDh9ocPhzD3AUpKTa7cBZD8IcyXr
         M8Tw==
X-Forwarded-Encrypted: i=1; AJvYcCU1g/r7ecVNdMp5SAHUkGQ3nFdiPnrhmgnnWAfDPUMVfIhCSMcmZSjn0scmNhMSZwnkX4D/Ku5XxvUFYgy6lef/@vger.kernel.org, AJvYcCV9WnuUd+iLzFpGj0I/nCw8oRLt41aoNCV2CeyZc0KvumR1jRNYtabAa9VHyJkLS/vfnYZEuF2x@vger.kernel.org, AJvYcCWdi0XXjqN9zPZxAFAFdKyrXYCDg//PClEab6lXzhVBIu1jEY5lr0ID5fuzlfxgvNJyRcjPkffHncUvALA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3XNERJCi+xvyD32IwDEG8mVN48yRNzzHqYg0Yr2aLVDZZF9i+
	GlgckOICp4bPhs18LZg3GCumu/H2ttoooVkVsv8m8P1H/ZS5m7o=
X-Google-Smtp-Source: AGHT+IFHC5H5nneUXcqMBSTILHl7Ui1OnMJy/fCXZE5TqaS0ZbfVnM+T/iCUFbTT/MrTdFaNSubITQ==
X-Received: by 2002:a05:6a20:7290:b0:1db:eb91:56d6 with SMTP id adf61e73a8af0-1dbeb91576cmr7421084637.40.1730828771616;
        Tue, 05 Nov 2024 09:46:11 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee7688e38dsm5443608a12.22.2024.11.05.09.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 09:46:11 -0800 (PST)
Date: Tue, 5 Nov 2024 09:46:10 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	andrew+netdev@lunn.ch, shuah@kernel.org, horms@kernel.org,
	almasrymina@google.com, willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 06/12] selftests: ncdevmem: Switch to AF_INET6
Message-ID: <ZypZ4ogjEY39BIM0@mini-arch>
References: <20241104181430.228682-1-sdf@fomichev.me>
 <20241104181430.228682-7-sdf@fomichev.me>
 <20241104175418.0d996608@kernel.org>
 <ZymR7A3Ws9ZY1jpS@mini-arch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZymR7A3Ws9ZY1jpS@mini-arch>

On 11/04, Stanislav Fomichev wrote:
> On 11/04, Jakub Kicinski wrote:
> > On Mon,  4 Nov 2024 10:14:24 -0800 Stanislav Fomichev wrote:
> > > -static int configure_flow_steering(void)
> > > +static int configure_flow_steering(struct sockaddr_in6 *server_sin)
> > >  {
> > > -	return run_command("sudo ethtool -N %s flow-type tcp4 %s %s dst-ip %s %s %s dst-port %s queue %d >&2",
> > > +	const char *type = "tcp6";
> > > +	const char *server_addr;
> > > +	char buf[256];
> > > +
> > > +	inet_ntop(AF_INET6, &server_sin->sin6_addr, buf, sizeof(buf));
> > > +	server_addr = buf;
> > > +
> > > +	if (IN6_IS_ADDR_V4MAPPED(&server_sin->sin6_addr)) {
> > > +		type = "tcp4";
> > > +		server_addr = strrchr(server_addr, ':') + 1;
> > > +	}
> > > +
> > > +	return run_command("sudo ethtool -N %s flow-type %s %s %s dst-ip %s %s %s dst-port %s queue %d >&2",
> > >  			   ifname,
> > > +			   type,
> > >  			   client_ip ? "src-ip" : "",
> > >  			   client_ip ?: "",
> > > -			   server_ip,
> > > +			   server_addr,
> > >  			   client_ip ? "src-port" : "",
> > >  			   client_ip ? port : "",
> > >  			   port, start_queue);
> > 
> > nit: I think this generate a truncation warning, not sure if it's easy
> > to fix:
> > 
> > ncdevmem.c:259:28: warning: ‘%s’ directive output may be truncated writing up to 255 bytes into a region of size between 209 and 215 [-Wformat-truncation=]
> >   259 |         return run_command("sudo ethtool -N %s flow-type %s %s %s dst-ip %s %s %s dst-port %s queue %d >&2",
> >       |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > maybe make buf smaller? 🤔️
> 
> Are you having some extra -W arguments to make it trigger on the build
> bot? Wonder why I don't see the warning locally.. (will try to pass
> -Wformat-truncation)

It is indeed -Wformat-truncation but only gcc complains about it, not clang.
Setting buf size to 40 calms it down.

