Return-Path: <linux-kselftest+bounces-41210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9BFB52948
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 08:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1309A7A29D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 06:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4952223E355;
	Thu, 11 Sep 2025 06:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lT79n5Kw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF05F226D1F
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Sep 2025 06:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757573655; cv=none; b=U9+aCgNDCmRxFMvuszPDexU91JF1BZH4bNVfliDDNKK1poedoL0Mi8kjf/uCuUixN46Ha2oCcdVxNQW/TbextukX8cz82g5aiuYJ6UucTvS2izlMiqDc22wk3GFjFwn/wInUs3Wv9jVum1Bv94TnnRlMjIo7d6r9TfmUDZZoWqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757573655; c=relaxed/simple;
	bh=HsSbvPpiinyCihIb8Sgvopg+FLqWOWFxbriOrPtZk64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dI56h0XSZuX4ggmJ8RjsZb20fwe3vBvSTAb2jWHfFUJk2zOvZlzR3Xf+zOvIN0NfUx+yfvsCGdqBXq155Pj8sMtb/UnTIR4fgR1Y3jVHdzme1QF/mTL0DW8zFDd4FIisiknURd6iLs8CbvF8rJ+Mx5eq5DdoUdAKjLblZhtrcIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lT79n5Kw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24c784130e6so4164045ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Sep 2025 23:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757573653; x=1758178453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FX2vgtJaxZj2A6Z1GumM41ujOH8A5gIx4cxENKUfovg=;
        b=lT79n5Kw/ybGCM3mqOGzfIPqrVNm1bWdkoBSOnBSo5rsPUoANPhCbDdyKi/T7kQo1j
         owyqf/FKZgqUD6UL+CxA25i6H6layv4ljOaEgAm/8fF6dUpFHU+PtRgViw6DLqlsbtbL
         j9xG3VPGpZ7knEfacb0XKnsR6dP48kYDd0GNRNGBfL/qr7dS3PLlDEJ4ecmQGYXB4RYd
         Dvs4jeNIZC8jit4LVWFsuzqhBGkvNTdgnGGEqEmjVw+FteUdN/2qFUmnduYg+EOcaq7l
         9mqX/VWgoEyVDQSek6RkFmViFeLRxfqTNP2c2U3Ef0nBFj/dzyWinYl64FvK8usJtnQa
         dfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757573653; x=1758178453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FX2vgtJaxZj2A6Z1GumM41ujOH8A5gIx4cxENKUfovg=;
        b=NH8fbDsdFzlZ3eGIS4q4B2TxS+cFunbh+ru3WhsZto5yuxvJnyfsJiYoeNlnO05wEb
         CoT36fQoMOTpv/+UibWUmarHmml5a+jg6033XUymOhXPnHjV/DSWHRPdbbq7CwjQMlpL
         MLNFidc0I6pMVsoKEJHNwzmCBXTcr4gR0OcPzapXNIL3hF57Bmrciyo35A2jsw+zTe9U
         THJuQ3m34cbudpObicEXl4zrhA2LQJ0Afrm0wAKVV0CUpiKQt5Qy2+SCSSdIilIPlEEG
         wb1sXLxV/xSkITODezcahcsSrP6LJMXCErMwU1m7lF3ISM/ZfcYhTyYTTMLRHTkRrReH
         a0fg==
X-Forwarded-Encrypted: i=1; AJvYcCX7Mlds3iQdQ+t2EGQABMaG91NcgK0YQRiATyQ8gQTBc0hPVsBLTVFEGtlfvE43GHe/4i7fRjF779UKItfP9Pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpaAFwPltOpUApKEQsJ3jR2o6zsAtzWqFYp4mdRN6NMWzpJnZt
	XGxq/QuSMfPdf9N6zvTUeKY9l6dYJ755ZlWNRITq4P7E9yiJ0tKxDFnagPaghTyA
X-Gm-Gg: ASbGncuw8pMBdDHNN0IOPKbsEGdAjUHNEO7BjwkN3Xco6d/IEpuvBYPXkslhj0tvNSh
	Dt3lX+wb/ncl5VvNYhA17iwHzJujSIfigZY6/NOu9RZLdjvHFV9MaIh73XldirfQbV4SxcevwRL
	Ie2P8YkGN73DI6dghdEa4hHCGymlD4o2PZq6rRvKdGYVI5Oq2Pk3yURkrOQBJcwOeaxK72g0uDb
	dqjdCD1GymZrGOmGzuUv9zOm9mAfdScCT2UNJsP/Ge8/zi5lPZzfcyjdr2GU6nQyzSgEqUAzRFt
	XI19WiQQijjDbUNSAxhM2nPnsx1FRp118Fd58+7uTX5ZoeA+VbLyztuoT4c0yqr1CyVe1tIXAYG
	jBaGccu/mdlRTVQm77zp75UrAtS36Z6EVXIc6Mg==
X-Google-Smtp-Source: AGHT+IEYR2a/LixxA6LHlM/R7UE1JLK460Ev1Uo20oFsmsItEoJidUORFnKkRGQ4z29RFi6EVRTcOg==
X-Received: by 2002:a17:902:dac3:b0:24a:fc8d:894c with SMTP id d9443c01a7336-2516d81824fmr247971415ad.1.1757573653055;
        Wed, 10 Sep 2025 23:54:13 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b20dfddsm8452275ad.125.2025.09.10.23.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 23:54:12 -0700 (PDT)
Date: Thu, 11 Sep 2025 06:54:03 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv3 net-next 5/5] selftests/net: add offload checking test
 for virtual interface
Message-ID: <aMJyC_YNjVWcB7pe@fedora>
References: <20250909081853.398190-1-liuhangbin@gmail.com>
 <20250909081853.398190-6-liuhangbin@gmail.com>
 <aMGR8vP9X0FOxJpY@krikkit>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMGR8vP9X0FOxJpY@krikkit>

On Wed, Sep 10, 2025 at 04:57:54PM +0200, Sabrina Dubroca wrote:
> 2025-09-09, 08:18:52 +0000, Hangbin Liu wrote:
> > +__check_offload()
> > +{
> > +	local dev=$1
> > +	local opt=$2
> > +	local expect=$3
> > +
> > +	ip netns exec "$ns" ethtool --json -k "$dev" | \
> > +		jq -r -e ".[].\"$opt\".active == ${expect}" >/dev/null
> 
> Sorry Hangbin, I should have noticed this when we discussed the IPsec
> test, since the problem is similar for the other features set in
> netdev_compute_features_from_lowers:
> 
> `ethtool -k` does not test the dev->*_features (mpls, vlan, etc) set
> in the new common function, it only checks dev->features and
> dev->hw_features. So this will not test the new function.

Hmm, that make the selftest more complex. A very easy way to verify whether
the feature is set is using tracepoint. But Paolo said adding new tracepoint
is not welcomed.

Since all these flags are fixed after compute from lower devices. We need to
find out a proper device and test the features are inherited.

The next question is how to test gso_partial_features, vlan_features,
hw_enc_features, mpls_features (maybe also tso_max_segs/size in future)
effectively.

The veth device only has hw_enc_features and mpls_features, while it's 
hw_enc_features doesn't have NETIF_F_HW_ESP. The netdevsim device only have
hw_enc_features.


For mpls_features, seem we only able to test NETIF_F_GSO_SOFTWARE, but I'm not
sure how to check mpls gso..

For hw_enc_features NETIF_F_HW_ESP. Does sending ipsec data and see if
netdevsim has pkts count enough??

Any advices? Should we just drop the selftest?

Thanks
Hangbin

