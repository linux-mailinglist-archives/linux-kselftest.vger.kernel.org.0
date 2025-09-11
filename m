Return-Path: <linux-kselftest+bounces-41206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD1EB525EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 03:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D132BA00351
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 01:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F2B1E5B9A;
	Thu, 11 Sep 2025 01:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcxNztO1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C052BA930;
	Thu, 11 Sep 2025 01:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555227; cv=none; b=hxEzMrmt2j5p8OmlWK/KgUH8jg02PWlz0Xj8rciv4eK9IvTuWEUPvg65zjbIksYvN+hWB3lh3dWBzszSIHpfrogdDZxeo+m0R+7dMXCB2hB6tVWGjdltexUfWiKy0x8eMZuYYgSD6BwweI4ZLIK+BDtwPXMu7Z8KHIYviJ5nf8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555227; c=relaxed/simple;
	bh=gbU2qsb+60Hqlm6nQqHjpY15CNlC31/o71WvOU4PEuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxhMPaX4p+LvrPBcgZDl1A4pbZ+QsTSFwwCd1cyESszltbqEG4zG+QqsrRExB3TVXZVkfB0/bwLCx0czxYKGGsL3PGLJE/EHAwxY793Po1Ftb5S5RzQaqDNwX2FPOHeQFfc36bb/zsWgCAcDBjEJVF0u4n5McFCV0900SFwQJnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcxNztO1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24eb713b2dfso1483115ad.0;
        Wed, 10 Sep 2025 18:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757555225; x=1758160025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9EKHosBRxgYKkSKH5grw3haxNFNlpbShU8sS3mHvALk=;
        b=UcxNztO1pn2H8Y5cunMjFt8uaSw5Hq2QlcMtvra+S3A4fraJazNdB+bs18CONa3w0k
         3Nh0MESqB7VAqY3paNi0ERRkYblkxjYaxdJEBnM6GTpq8KECwgkwASu3QDshsRAcWg1w
         TFptgH9AJweCbfVC6D4JlSMtLmBDjhTiocblfBrlUJfA8yoMSJhyUC74DveBTYIUysEi
         0NAfMi7IbJrXFjQ5ahc9SNcXlFQcblFWNbxOS9pj/UT54qp2oxnBLvDIEiZa2tcctTR+
         rO0X572VBOhBqosunTJUgyFDcdbVl+I0C7S1BOlyuDZa5GfCbSCEO0A5/xVlqPOjGLdv
         mzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757555225; x=1758160025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EKHosBRxgYKkSKH5grw3haxNFNlpbShU8sS3mHvALk=;
        b=g23EDusbehW6v02PfIm75yX8LZwPRXcMLZ1MVtUIWpAdWYICRaDuzTvGXgYM7WOoqw
         Mn2UQyxKmaJtJ2w9T5QmLWzm3C3DC6yuKPVZZitEW4Yj6geIdVPeMMk73SbtO5HsXLGR
         ZYmjchpvoF69JNAqF8FwfL2uGoGVwSkX15JOmPt2V8OoSRyhilcqvw7zopbhgCsJM35p
         1fFCr65xKOqEEo+GJVXLTk2OtTbTXcvwaoDZ6IPdYQchp00nGjFfZ/UoscX5nPIm1T8D
         t5XAvU6FyHhUUCplKA1lYnWoZx4se7zqgpcDgvQ7JMdIvOtaDtF5Bxg9lwzqov8BbLcv
         +eGA==
X-Forwarded-Encrypted: i=1; AJvYcCV4uS0FoL9QJz0uHxX3arj55n7NzdXubsNqDRsvwXf3fEV9noHljf53e2L1UpBA4dYWpvpinJZNWQJqH+qN7c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqMdmlWVK68GqeNzcGVTuNgxJDtfGPLfDtn7zZ1ut9uFc2lch0
	FPrNGxpM/NGLP1diqzCrxejwtWdTcc4QBOENN/l7H+Qv7oziNInfn2Fk
X-Gm-Gg: ASbGncvPEYweuf2uw4mHGp8+gHRcq8dINBWpBXtryCARK3B1pnhfY3kYSf8kaBVjtiT
	uY2IWveB897ehq/+C0N48a2kI7f/ED1NaOki0l4K90BTKIKhyZ9OYw/A7uenQprWa7N5qJDD1DM
	8Bn7DSN9QAWjgT7vMAYdYBWp0FvKu4KBvnZIuBIgjppkh3/XJ+qBfP8sW7GvYZJNb+nP9BWLSn5
	ihklI1/CaL3b+tn2ooNpAXZFoBLv7fYrT6EVTrRA1X70LuwUQ+Ej6UILxNF9DDJHW2RuYAYFcjM
	Wb9pLNRuj1TaZX37mnKnDy8h5vXPEFshgg33YAdxvnenqTeo11Q1/KFXvgfAZYcZxhysTfchQIP
	HEOX2g+JfE3GhAz8zjEpfMmbXk+Jlrjt1zvIYTQ==
X-Google-Smtp-Source: AGHT+IGUbHEB/rQLl+UqdSvAkEyeUvWOmdJPOZTNQ0SvY7LmtlnSpa1pNYdxeldQ71BciiP/DXGF5A==
X-Received: by 2002:a17:902:f78f:b0:24b:24dc:91a2 with SMTP id d9443c01a7336-251738cd8b0mr193771385ad.60.1757555225116;
        Wed, 10 Sep 2025 18:47:05 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a5d6sm1058435ad.93.2025.09.10.18.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 18:47:04 -0700 (PDT)
Date: Thu, 11 Sep 2025 01:46:55 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv3 net-next 3/5] team: use common function to compute the
 features
Message-ID: <aMIqAfT__zvr32hM@fedora>
References: <20250909081853.398190-1-liuhangbin@gmail.com>
 <20250909081853.398190-4-liuhangbin@gmail.com>
 <aMGZwEnJ943Rwf-Q@mini-arch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMGZwEnJ943Rwf-Q@mini-arch>

On Wed, Sep 10, 2025 at 08:31:12AM -0700, Stanislav Fomichev wrote:
> > @@ -1976,27 +1919,16 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
> >  
> >  	err = team_port_add(team, port_dev, extack);
> >  
> > -	if (!err)
> > -		netdev_change_features(dev);
> > -
> >  	return err;
> 
> do the same `return team_port_add` here as you do in team_del_slave?

Oh, thanks. I forgot this one.

Hangbin

