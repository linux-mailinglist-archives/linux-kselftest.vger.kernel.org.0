Return-Path: <linux-kselftest+bounces-38740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBE8B219DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 02:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9C61A241A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 00:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA60A2D5C9B;
	Tue, 12 Aug 2025 00:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="J+pfjIfg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CAC2D5439
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 00:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754959070; cv=none; b=BUixUPnojEty081k/wnFq1yHcNv5cdRJap1sadGH/Z0T8IuXRPlaVxTYwtpYjjeeGnx9IoeEnOWYclee5N3VExF7plhNk1pqzDkbNS2DUUbp35ej7WVA2cIOW7r5Vhzmx4FWhcI0Pc9dIE4n9edLQFOQh68D5UZd0qoeysS4lBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754959070; c=relaxed/simple;
	bh=Zoh+456yPTlOVfyqB1JAdgyRQS67Q1wYUO8Fk/hdDqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqdBDBiXF7ko9n9I7xdjfkQ2ZUbe2vuANdJJ9EfeC67k+zbicvPmwTGelNR0jN3BIOCF7G+Nh7HeFBR2FLX92Ce7Dmk25xpnv3V13tHK7pwZGB9IBeBEzW8JCXQJmlTti/lh8nn+lBs9uqJ4FUpyZ3m3BpT1upV0VO8cMJgUYto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=J+pfjIfg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2405c0c431cso46115625ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 17:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754959067; x=1755563867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hi4jnmsHTvqQw1eRRjxdKyQuNx3J0h7y8Nu2xezZ5UU=;
        b=J+pfjIfgtpdwfb0lvaCZrwLH48EcNyBepVoFlhcrHh6fE0I3Q6OweX0O0M8L02VmLs
         oQVJKdL7E3DWP3OD7chpVxpslPmStJL82OLlLk4fUIHTFch2ljuirHwm4OSI59Y/mgSC
         pCqjL7hRtOTVhXdPe0F9aQqVSIRpg0ChUHS91tKpagQOrF6/RsIzNEOWyK2GkELFxnMZ
         thvtLZhpVuPOE5NNjr6hJkVPqLbYExoMrUp1zHitVbsqq0J63U0hDOaNEFpPu/Qpqi0W
         LISLDFnwvPNIdfmftLP5ByvKq5C9cydB9SoL7mCBZYEUWcJ0nGoF3zwi7pdNOM2Czkah
         LJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754959067; x=1755563867;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hi4jnmsHTvqQw1eRRjxdKyQuNx3J0h7y8Nu2xezZ5UU=;
        b=j1tFmcGVDD6RIeof7joC0ibHvWUeGzWdEq/lEjtawUMzjJZ8FmGdtqw4kZhXYHoIKR
         J0upDqXZ0fUdkNVvpgadUbdjA2urxUdM1eM1NhrtU4daBiydO5bV389R3n2/sERWXzie
         qyV7wI3Y4z1WhDppogua2aWSN1jG/1QlQ5jeu+JB6Y4riQUoEhRPs9KvkP6pcRyFG0iF
         Inn5ZUDUVa2tpfKNeHB3fQ90QCLUcjtne/IOhe95MjItjkiR3UsGN5ph4pwZTiEERTFo
         4hPNNZGvvwG6tu6lrVZ2/ldYXqvlNPrBW/M60bGXOlTHQZdtYVKi6tTIby+qMQaXB/Uv
         dPcg==
X-Forwarded-Encrypted: i=1; AJvYcCVVgr5ZCeskZJv+uXKWTAkjpGWbVNfSNUHzg88PjkjeEqoMFR7wvXHqJgK7QJNiNnxNRjC2n7WYy+WFMQ7h6Y4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+uDcJ2PI51Ax3V3fndL5zqPsdDsgXJFEkDHLO4zFOLQ4yzi5a
	k8eHJfTW46uJ1H+7UC0fDS9H71ZRIuQPr68QFAhBx2YgcA6IhIOPXkoiW49J78tAAJY=
X-Gm-Gg: ASbGncsgQQSx1fA3GVpSV1d9uh19t7cWgCvKQKr4ssvDSGh9l/HAVKGGUV9IlWBMrPm
	oBX+Z/LMT1VLg0sKgklpNWRdI1mqDWBNAn852EQH0Rj0514JWpFozb+6/ItSbsgUijR/KGxdoA6
	5jwRsiccH+5FWc4CMGveRKDbPFNB5cuhVmiL8UruldaIpTqbGF0qUARxE5OnFWIngS3ecndN2NH
	DYDAiH53cRvfyOPM0sPQAK26OgQeHy726WaE0MX3okjD3g964D4nr+jWrC4cE+cuAhSXpB80mzR
	1ClfEB8JP0JlMUfwqTNpCTDT4cZTgZrKm/AeSr8+ZBr1eQvSQaKquJkr2hy5HJnxB+8PUfTSm1M
	2i4gR8oDuuInjQdPp2zmGWe+iiC83WnPAnxbck2HPK0PcQbFNvDz5PK13V/y65ZXgTLA=
X-Google-Smtp-Source: AGHT+IFRSXuDFlvPS5PxumIrCP6El65cWROzIzFAT7VIuasP8g6CXDhJN02xRtdA+6LGDv7Xg8I6dg==
X-Received: by 2002:a17:902:ef4e:b0:242:9bcb:7b95 with SMTP id d9443c01a7336-242fc389ea5mr19350275ad.57.1754959067544;
        Mon, 11 Aug 2025 17:37:47 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b4adsm284741865ad.132.2025.08.11.17.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 17:37:47 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:37:44 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, willemdebruijn.kernel@gmail.com,
	ecree.xilinx@gmail.com, Willem de Bruijn <willemb@google.com>,
	shuah@kernel.org, sdf@fomichev.me, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/4] selftests: drv-net: add test for RSS on
 flow label
Message-ID: <aJqM2ELIzMDDgSDb@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	willemdebruijn.kernel@gmail.com, ecree.xilinx@gmail.com,
	Willem de Bruijn <willemb@google.com>, shuah@kernel.org,
	sdf@fomichev.me, linux-kselftest@vger.kernel.org
References: <20250811234212.580748-1-kuba@kernel.org>
 <20250811234212.580748-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811234212.580748-5-kuba@kernel.org>

On Mon, Aug 11, 2025 at 04:42:12PM -0700, Jakub Kicinski wrote:
> Add a simple test for checking that RSS on flow label works,
> and that its rejected for IPv4 flows.
> 
>  # ./tools/testing/selftests/drivers/net/hw/rss_flow_label.py
>  TAP version 13
>  1..2
>  ok 1 rss_flow_label.test_rss_flow_label
>  ok 2 rss_flow_label.test_rss_flow_label_6only
>  # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - check for RPS / RFS
> v1: https://lore.kernel.org/20250722014915.3365370-5-kuba@kernel.org
> 
> CC: shuah@kernel.org
> CC: sdf@fomichev.me
> CC: linux-kselftest@vger.kernel.org
> ---
>  .../testing/selftests/drivers/net/hw/Makefile |   1 +
>  .../drivers/net/hw/rss_flow_label.py          | 167 ++++++++++++++++++
>  2 files changed, 168 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/hw/rss_flow_label.py

Reviewed-by: Joe Damato <joe@dama.to>

