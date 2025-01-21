Return-Path: <linux-kselftest+bounces-24832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBE9A17A94
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 10:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8A83A3908
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 09:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425651BD9CE;
	Tue, 21 Jan 2025 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jipzRbAA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD159D2FB;
	Tue, 21 Jan 2025 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737453313; cv=none; b=Kmz+uOSzMvHE1bi/C+WMx8doBy53LdNMBf1Rcpsh7+Vnhe0lqA6FLogBuW62XbRKPhAHZzxRtQHpoeC8C973JGnd3Ba71sXlhVwI6lq6Mm4UFnPOq72OOesMAgjR7YyIi68/zrkjNX+l89bse9DuILPM9zCU+gNGBncJ27iBM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737453313; c=relaxed/simple;
	bh=zqC7jqOZtPe73LjKss7iY2u8jYVuufOCEi1MTP+rSxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VptSaNIzBbIPfHRWol6n+R+ysjrTG8A/oBDWXMcUo2+9GcphfDRnEaosH1exoWGk3dHfXDKmLVwdKdhBL4SD+J8BlaSK7ZsnItnrgmhyHzqSdi2A507n7ZuTE2qdc2QsAhUJaJlRt7PvyDp7arg8gV2f4wAa5XlnE5UF85nAU/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jipzRbAA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-219f8263ae0so94232305ad.0;
        Tue, 21 Jan 2025 01:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737453311; x=1738058111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mKnusMsytJqFcwgZdAa9y1bcRHA6o+BK1wYiAyk4GCE=;
        b=jipzRbAA/dCmg29/Kr/Z1KTxxP3LSf6hNiAbY/AgRAjwWFF37bDFe1WxQ3JFL7NtFI
         dUxnmvwGbCFQIRQeMzwPdKFKKScyK4b722zmqJo4n87EUx5WiKg5ynQ2gr2rS2xXeSB9
         GEXWXpEscYiU59PYeAoN+EplngvunBVBzmd+6PTlKRRFI8JdzIog/wuhZQ8c2PFWBXjA
         rhIM31QQyzd2M8QaqbtI0euqyKEcbNXsD6lRwMRLoBTtR66lXZKSB3lPANTd2BA2YrKQ
         KJTXIyrkft27yW6lDymglXeymtHXWveI2dGgqeNvxJAAaRI5Hv59iZoKbV8XnHFr5us+
         YoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737453311; x=1738058111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKnusMsytJqFcwgZdAa9y1bcRHA6o+BK1wYiAyk4GCE=;
        b=OmnVCXTGYPCm9jgeinSCfc5MYqqh3prawnRIchbjdP9YAuVOQDKP2G+QkCTnGZv1Ov
         9DQsusEaAGn5lp38iFrg8n1l8CVDyIpZw8gAwTTQcbTAP2llq98YvchcvIsiOrg+mWhi
         /zlm3ke16H5NV7B+xIJ3w5XA0l0p3L1YR6N9LMjVMLP79jLVYycS3pF+DC6e8dUWtnvC
         vCu7iHk4Wnykcbid84bvfrJ4TUbNektdsRSRmEiuEdYU5p9h6GuHG8x82hyii5uvWHSd
         Zz++rolmoD4NhFE6nQo1hycHVvp4qFvgNFBc/xFF95r0Glc+P5t7w8vRJCeluaQ/Osie
         HG/g==
X-Forwarded-Encrypted: i=1; AJvYcCUT0CtvKyoGTnHUSG5q9hk0ycspNLkV35z1abBv9qx+Nyifqt5mEkpgXvumXlh+4Ar1hXlX3EuLbfP/TOfTMumJ@vger.kernel.org, AJvYcCV1H6kwmypgIFeu8vrEX7Q2jT0wVBv/lPjaIOPNgkzMEnOyMw0TXRjgMaRNpalXmt75B77Lker2Kd7GWpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNsUJvI0DQA8QCfJ4Tn4J1VDat4e6unIaCuMe30LgNAgB4w71g
	ePt7hXWDCbTkF3v8MqW2Fs5SeAaSuRZKvGsudycwCcYkc9OI5S+++UxZ54Uir8I=
X-Gm-Gg: ASbGncvHLEE5cf45qblkxyJaxCU/8BmNUHsWvcS4VntlVAIVVmQT1mhxJTfotDaTK8N
	WQVPFgcx9N4ygHI5nDWDiRtbLYvZNdkpdGbD/+/7UqOBlFscJkWYPBXAwXnQtKH5KmDEUyz4f7i
	okZdC9IMsRlB5/5jrOPl+3hlxLi+vZp4Mqi4Yxe0MuUF1g3EiUJXwt5+/wty8um4teO/a0RduOG
	REp8M/ZQ6rlegMSt1Vxlj+PnzoipyqhdfIfBER+IM96uLNsKJ+xG9FxinnmVOm8HrggXQlQQY8=
X-Google-Smtp-Source: AGHT+IFLHJDuDMC2r2wukKrDtCy74jN8nExwlKKasIL9PAJS43F1847S0oN/T8hHyykmOsc87oV1rg==
X-Received: by 2002:a05:6a21:7895:b0:1e8:a13b:3885 with SMTP id adf61e73a8af0-1eb215fb145mr28841967637.35.1737453310768;
        Tue, 21 Jan 2025 01:55:10 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bdd30d1fdsm8510913a12.60.2025.01.21.01.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 01:55:10 -0800 (PST)
Date: Tue, 21 Jan 2025 09:55:02 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Jianbo Liu <jianbol@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Liang Li <liali@redhat.com>
Subject: Re: [PATCH net] Bonding: Fix support for gso_partial_features
Message-ID: <Z49u9h7qryvUbhDr@fedora>
References: <20250121085525.176019-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121085525.176019-1-liuhangbin@gmail.com>

On Tue, Jan 21, 2025 at 08:55:25AM +0000, Hangbin Liu wrote:
> The fixed commit adds NETIF_F_GSO_ESP bit for bonding gso_partial_features.
> However, if we don't set the dev NETIF_F_GSO_PARTIAL bit, the later
> netdev_change_features() -> netdev_fix_features() will remove the
> NETIF_F_GSO_ESP bit from the dev features. This causes ethtool to show
> that the bond does not support tx-esp-segmentation. For example
> 
>  # ethtool -k bond0 | grep esp
>  tx-esp-segmentation: off [requested on]
>  esp-hw-offload: on
>  esp-tx-csum-hw-offload: on
> 
> Add the NETIF_F_GSO_PARTIAL bit to bond dev features when set
> gso_partial_features to fix this issue.
> 
> Fixes: 4861333b4217 ("bonding: add ESP offload features when slaves support")
> Reported-by: Liang Li <liali@redhat.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 7b78c2bada81..e1c054416d5e 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1598,10 +1598,12 @@ static void bond_compute_features(struct bonding *bond)
>  	}
>  	bond_dev->hard_header_len = max_hard_header_len;
>  
> -	if (gso_partial_features & NETIF_F_GSO_ESP)
> +	if (gso_partial_features & NETIF_F_GSO_ESP) {
>  		bond_dev->gso_partial_features |= NETIF_F_GSO_ESP;
> -	else
> +		bond_dev->features |= NETIF_F_GSO_PARTIAL;
> +	} else {
>  		bond_dev->gso_partial_features &= ~NETIF_F_GSO_ESP;
> +	}

Hmm, looks we need to remove NETIF_F_GSO_PARTIAL when remove the
gso_partial_features.

BTW, I saw some drivers set NETIF_F_GSO_PARTIAL on dev->features. Some
other drivers set NETIF_F_GSO_PARTIAL on dev->hw_enc_features. I haven't
see a doc about where we should set. Please tell me if you have any comments.

Thanks
Hangbin

