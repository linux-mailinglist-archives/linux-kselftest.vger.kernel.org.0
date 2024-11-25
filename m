Return-Path: <linux-kselftest+bounces-22505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 764219D8746
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 15:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48B4AB42249
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 13:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60751ADFF1;
	Mon, 25 Nov 2024 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwUW4cRI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210601AB6D4;
	Mon, 25 Nov 2024 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540895; cv=none; b=rM8Ue9hljSugoitgmsy4Zew0c0sLEPf07K9Lo+xwMvpMixKZmP1uzCDd6bjTLHJ/Kw+0lInAVQOt9tjbHep7m+ZN9i5osEIKeoIczNcbhS4HM9dCYWeuZIzjImqP3T8JbxqGP5MDsjqhMTJTseRc/5L+qUhTi1JY1hfG0QvU+8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540895; c=relaxed/simple;
	bh=0SOZQeyrNKlS9tHFmzi8ORnOWl29Sf5sPDo1Ych8PFk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VQJelUiJAXUFGDkxf3LHxH0lKhPphusJVOu8MQLZAdUlrPictOgV4s/OJpAxJuFM4uGK9FgQswsMBS9O6tJ+HnZzIWpxDmSf7dlxairduxwp+NWBvmVmS7p0WfK7dBO9ZpMOqqpH8R+/1CChdIFwZFkd6F6CJcrUg/+Ymc5iLLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwUW4cRI; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43163667f0eso39735805e9.0;
        Mon, 25 Nov 2024 05:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732540892; x=1733145692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oa0cn0wwc4zMYLeRwlkxFR8F0f3kJ7kjZT+G9vlnpOU=;
        b=OwUW4cRIjk9AIYYRL1S4mmjMm7KOyJop4V27XGRo2naaE/4dd7tanabU/IPrGOqj3B
         NlXnb/PdFm7wLDY8IOUyTs1GAKPoCj7m3VKw5fgELY/L+wksdhL58eMDVME5jQcCwTxI
         frBWWH8eZtJ2HVy1fjAcdQ3VU3lyFgNUGGNK620/Nwf1ve7Xi+IDSgjBJPITA66HcSYW
         Qs1NmRACdocQrP6ihhf0+PvBHVexfnJIWU+9BXMBtGovjYqpVfYtAAqsp1Y8Bs6l9ThR
         dpQuh1zneMZXgfZXFSqleXt5jZ0i6YFDBijcmBx1N0px/4pm08FhmLV5hmvlfSA81+7z
         eKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732540892; x=1733145692;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oa0cn0wwc4zMYLeRwlkxFR8F0f3kJ7kjZT+G9vlnpOU=;
        b=LFP3I5YpcCgjJT8gqdJGYKqss+VqufrDYckGLqzoMPYrJA4NTTyoJP5usNNmxtJ4Jk
         DIErOozLrhR2jHKgoY2jyoVIZSdxsezOhk0hud1l56TAd7IYu5EfLAAAhFD2L8PrGGXs
         1T24kZjtPnHxeZPNcWUd2VyUIXrvPJZRH7wlXcBLtRM6AAQVWkLV17Lk8TjrMFhvbhmC
         71ocZcYNhe7f3rb9AE1GMGDarmeNBaVUAymn1trbxeWzmEGwcGXNr32N8qXtCB3a80Oi
         9tevccMU9Bzalp4ichyQOTGMdI1PR0vqCd6wAXGRHPA9hts1lD3vq05bOhbRxrUC2uET
         WNQw==
X-Forwarded-Encrypted: i=1; AJvYcCWIKJmRtemAiChherKYwo/dwFEC4zp2asmYf1D6rAUuP5xy4TCqNv5HoFhdEEEk1XK/gfuFGhxJ7DvmK/8zrZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjq62V9koS0Ueq5yirL0F7y2YsMJ8tOV1H8lvZQrdSaGssLSbQ
	KDxUR7B8mCC7HwRV4Enm39voHRJqQA5QIktikpzKLRTHF5EcXA7l9G3Dqg==
X-Gm-Gg: ASbGncvOyhlAYIaZDuJRe9k1DUImnuil77qFMgoZTQQnyEe565kYxVLKY2mykorfweY
	HBxrbF+WSLY/93RVSpD5eW4G/MpINuskZT7bHxuDGHC0NFRFALoLXR/jY2Fzw8u0dPVAwavFiDV
	WdodXgmUcVY2f80/Cxivh6HTwXHuCYlwdrPznrjtprOKJmDK+P8e6Fxv3ErmJOA+3Hqg7gT7ZKL
	yyqtPHmaXdCcKRCDzLOjIlSZj8ax9jTT5tXd4KSamMvL+N8QK2r8XFK5KxZ/P2oz3ATYQYDVC5u
	VOEbKypi+hLPWfgTkA6P1VLBYmZuOIhEKMVXgA==
X-Google-Smtp-Source: AGHT+IGNH4hQ3aM3rD6cvvYYRgYauN4jMf9b0IL6JeWRXy+7Fq2BjtXzWPiFdK1A1L3Bf6RZcrenxQ==
X-Received: by 2002:a5d:47c6:0:b0:382:4485:2d96 with SMTP id ffacd0b85a97d-38260be5323mr7197223f8f.50.1732540892164;
        Mon, 25 Nov 2024 05:21:32 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad6255sm10678389f8f.5.2024.11.25.05.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 05:21:31 -0800 (PST)
Subject: Re: [PATCH net-next 1/5] net: ethtool: only allow set_rxnfc with rss
 + ring_cookie if driver opts in
To: Gal Pressman <gal@nvidia.com>, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
 linux-net-drivers@amd.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1731499021.git.ecree.xilinx@gmail.com>
 <cc3da0844083b0e301a33092a6299e4042b65221.1731499022.git.ecree.xilinx@gmail.com>
 <871a9ecf-1e14-40dd-bbd7-e90c92f89d47@nvidia.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <b0f84914-c4bf-9071-b72d-cc2cc4a517f9@gmail.com>
Date: Mon, 25 Nov 2024 13:21:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <871a9ecf-1e14-40dd-bbd7-e90c92f89d47@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 25/11/2024 07:11, Gal Pressman wrote:
> On 13/11/2024 14:13, edward.cree@amd.com wrote:
>> Ethtool ntuple filters with FLOW_RSS were originally defined as adding
>>  the base queue ID (ring_cookie) to the value from the indirection table,
>>  so that the same table could distribute over more than one set of queues
>>  when used by different filters.
> 
> TBH, I'm not sure I understand the difference? Perhaps you can share an
> example?

Something like this:

ethtool -X $intf context new equal 2
# creates context ID 1, table filled with 0s and 1s
ethtool -N $intf <match fields...> context 1
# filter distributes traffic to queues 0 and 1
ethtool -N $intf <match fields...> context 1 action 2
# filter distributes traffic to queues 2 and 3

See the selftest in patch 4 for a concrete example of this.
Some NICs were apparently sending the traffic from both filters to
 queues 0 and 1, and ignoring the 'action 2' on the second filter.

>> @@ -992,6 +992,11 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
>>  	if (rc)
>>  		return rc;
>>  
>> +	/* Nonzero ring with RSS only makes sense if NIC adds them together */
>> +	if (info.flow_type & FLOW_RSS && !ops->cap_rss_rxnfc_adds &&
>> +	    ethtool_get_flow_spec_ring(info.fs.ring_cookie))
>> +		return -EINVAL;
> 
> I believe this check shouldn't happen when we do ETHTOOL_SRXCLSRLDEL as
> flow_type is garbage, WDYT?

Agreed; this check should only apply to ETHTOOL_SRXCLSRLINS.  Do you want
 to send the fix or shall I?

Also, the check below it, dealing with sym-xor, looks like it's only
 relevant to ETHTOOL_SRXFH, since info.data is garbage for other commands.
 Ahmed, is my understanding correct there?

