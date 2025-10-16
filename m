Return-Path: <linux-kselftest+bounces-43323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9979BE36F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 14:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450A41A610AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 12:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE21332C31A;
	Thu, 16 Oct 2025 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/vwe4ji"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B5031CA4A
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618307; cv=none; b=sd/mBz8f7tOq8QVzbqD42xvJKTBMmX4TCcPL9R42o3Gt4EccyFBpqZY3mQ36aDHx7kbRIa/7c6HpRpJg5SXMJhLrPkSDMVFvlvkAnXf5AfH5Li47yzb10wAw1hfCO+g0iBcLRttSCsVM0+qEQ7I4Jhwa+zX1i8cPO1nAlT+Z4KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618307; c=relaxed/simple;
	bh=Dd9bbstWTxKW6GEQKajDsyfE3C38pzh8JqnmYMwneUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noebDaYp8gyReyShlcdYqT9dIqeadimy3koGf5OxKNhVlZsI7nqrRKKmEEX8P5HnO2BHx0/Tlfa0cNCjRBsgP286sdu6hr+o2dbqMONm6ACY4CPrXv9Huvrmwd7JW6GKSwvvKtJN/hKTbZ1ztsaKqsJFpCChU64Dmn/tL8mr1Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/vwe4ji; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7841da939deso667954b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 05:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760618305; x=1761223105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mzn3hIsMXxvxQH6Pl2+jyVSLI5DbYlEg7TFGTWc7hzg=;
        b=T/vwe4jiyxGpT1S1oc3wPNsENwprBnoTGQBNOtOPdrlK54vWUO6tjtixYeiXuTuL+I
         zEQ4UuOWzZoOOgtPWCiL/svMQ/+JdGTM9ZNAxyI4BtGSIQtu7cy/SJR11MnqP7iO1sbD
         /yt3Zxq9Y1HEoPelnM5lGW7BKQGUzSJGYsG07iWp4Q/9pPRhrFNL3EoE4Bei6xWD68bb
         +YkrRDfUXLLtSAbe1glGjm7Si7Vw3lFVxtll8K4nkvB/cuq0gIvlXa7H17vEc2UFnIZ7
         M/pd1vIKGZGyvlsVuDR6COX80bIMEidx87hLlwKP8gAWP/8wAuKipmopnoI2SmgqIMKy
         0+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760618305; x=1761223105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzn3hIsMXxvxQH6Pl2+jyVSLI5DbYlEg7TFGTWc7hzg=;
        b=wDY1lR0GPKB27I6edZnP/8RDzKN4yOjAvFpVVlOWB0Om5WQCP93GxZv7kqn+eZ/oVO
         U0ITVUPjzH0ph0QlOhe0ZRP8mea86+b+6JHHXjpbNqeBk7F8sgRAF5Mr8bBfIDUh1dt3
         iFx0q/oN5RrW/B7n+I86NgPhR3O2uIGo2R/zxlsL29d8sIulpgygbqffFiBQu8rhS2jH
         HD8S9/0yA392qgnCnjYQAIJB5A3doJIoUyiDjflgPVqNFWJLujx6YT/3bTJ9idBnK1Wi
         WnlJD9K3lO6wXwvZciqyk7hUUSFVWNcSaNPStPJ0W3bIWpiGFV43tW24cU+ZFwbBoZPi
         83cw==
X-Forwarded-Encrypted: i=1; AJvYcCXZXVpVQRzMvsmmtwTooS9zRtlUooTL1fnMQ0gUm6GNNb99dSOCcBRLfi74q9S75Z314KBGKT7FGXBIO1v2Aoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKgL3bnA9QVRktAd+hAiOcMn/yu0JYT30XDEjYKlW+q0BvyVKL
	w2lJZacng1p5IqftPWTz4VKoq3CZysIG5tNsHPkieqXDwliX/5xlFasU
X-Gm-Gg: ASbGnctbYlFbmUyDYlpv/mywvXo3pQBP8ZupdJuo7tArzxNK+TZXK9yFkOXriTAniF0
	AzWVdcmctutKALPqj+7Xzjq0HmiSchyN1NtLW0s1A2pQSF5eL92ixNEqv34c2rOfWJ8QqFXl1fs
	00RzMacCPQSVjObbIAAlOt119aGPt9c02cGho5vdnQlX+xzlVQ8ie981wdIcM9ZOve8cDwhfCJY
	RC+dV49Ep263iDKu/2vC6B/3lLcpmwYSivCRZhJjAlo4x0/GI4kFsVxMP+kF8PeLm+uR2Dp5V9o
	6KtuT2/H0KjN0y/lfshOfGwdm5MtKbNfe6MAcJlD8Tm+7EvVVtnSkcVx6/PDllzme1Pj5OhwkI8
	/koos3ZmaXILIq/3yYavoCzknL4+bP3r2zg4tklk7pj7EN0OBkj8lE0nNBNXK9jh1hT08rVvU3p
	qCLjXL7ZKYqMoXI0c=
X-Google-Smtp-Source: AGHT+IHaEAqXhlDDVHzRiYiU8r+iTf++U36IibLSmyfdTTGveuzbh0DYZipswjt8IVOLHS7FMFSoVw==
X-Received: by 2002:a05:6a00:92a2:b0:783:c2c4:9aa5 with SMTP id d2e1a72fcca58-79387d0f5aamr43386468b3a.32.1760618305303;
        Thu, 16 Oct 2025 05:38:25 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d09aa20sm22165667b3a.39.2025.10.16.05.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 05:38:24 -0700 (PDT)
Date: Thu, 16 Oct 2025 12:38:15 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv4 net-next 1/4] net: add a common function to compute
 features from lowers devices
Message-ID: <aPDnN072argrq23q@fedora>
References: <20251014080217.47988-1-liuhangbin@gmail.com>
 <20251014080217.47988-2-liuhangbin@gmail.com>
 <sfjjkeub7fmvsktzrx6mmv6zvilno3un665tbqe2punw4azefo@jwuhk23763gc>
 <aO74J20k16L7jS15@fedora>
 <to4zjjo5wfd5suootcy2v7n7kuc6rym3ld4jov26nunnarji2u@2hr7jyiq36pj>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <to4zjjo5wfd5suootcy2v7n7kuc6rym3ld4jov26nunnarji2u@2hr7jyiq36pj>

On Thu, Oct 16, 2025 at 01:27:00PM +0200, Jiri Pirko wrote:
> >> How about "master_upper"? This is already widely used to refer to
> >> bond/team/bridge/other master soft devices.
> >> 
> >> MASTER_UPPER_DEV_VLAN_FEATURES?
> >
> >I'm not sure if we should avoid using "master" now. Maybe just UPPER_DEV_VLAN_FEATURES?
> 
> Why? We have "master_upper" to point exactly at this kind of device.

I mean try not use "master/slave" words. I'm OK to use UPPER_DEV_* prefix.

I will update the name if there is a next version.

Thanks
Hangbin

