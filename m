Return-Path: <linux-kselftest+bounces-34801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D045AD6C43
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 11:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5FD118915FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 09:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D8D225768;
	Thu, 12 Jun 2025 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiIzTsNz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842C9217704;
	Thu, 12 Jun 2025 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749720738; cv=none; b=CKeHjvd3jA2r8RlvLPbPS98LKjkrpktJVky18ijoCz77R3PRiFW7X8MXRA+gFb2zBzIwcUOdMZMDy3NuYGpFoCAzFFulNsar/dP5ez4YvSAmYN7YGgycpeKtQYwK6H5qdoDjLWZhoqcRSblycqzUNGiB+J3k8mMLHrJS83/c8ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749720738; c=relaxed/simple;
	bh=HbiV1Peyfi7DeLC4V8wHqXr9LxAEjt7zTAZbOl/yk4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=shrrDSbW39Jql65Y45wVk+YtM4bk6+H33Ev2FV9ayfXCeCcMsSn/btjPtVsmWxUvj6/mBkeIrsLi+tGy2+S+0QulUjaT7P+txSow3dmdb42RBEDudoA8WF9X1/E9DKWvSzhSH2UCdSD5HWtyWvNIE8fHfUwLM7p2lMyI4TmsAHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiIzTsNz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-442e9c00bf4so5619385e9.3;
        Thu, 12 Jun 2025 02:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749720735; x=1750325535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sg1YUq+46gelWFKCWCbK7uj3DawqVLnvcZOeGb+PVOA=;
        b=XiIzTsNzyiK1dH/n+3mH7PpoxAMpVGb8dy5hbx2uWDpMKdURNcFPMHUQeP0UPD8O2S
         Y8f+UsaDmUzppDg4b1AwyDbgwtuDFO2qyp47sghpRpDLXJZnPtiyPClEY22QY502JqQ/
         QqOxoA+00X6Q4TolpFDda3HYkuo9YEamNI/w6JsCO/ERagNPMMSNbD2At/wpSzei6hot
         49UneBkF9Amn8EE5CUdzCRjMmQrxgnDZkP96/geSyS5iNYr5a02grL7XKY+y9+xEaGb/
         1T46ypPep3f5GTWWNIY8JFAV1fOUEova/6jBRN+vYxd6VnkipNCtA1NOGRNi8dzVfEmo
         EjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749720735; x=1750325535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sg1YUq+46gelWFKCWCbK7uj3DawqVLnvcZOeGb+PVOA=;
        b=fhZxDKQPvsEZesRORTV2CDdk4B138ibOU68dIr3zxeaQbo/mbhRPo9KO5aEunhU5g2
         131sCZUKQnfR4JNGL279+FteCdHvmPLlRMG8a0Hrz/XQB0ROrVhuS+/23ZEALIbGMhQM
         1PG8ewzl1gS2/dzvkuihsBidQXlrRX5+oycMnh1pmFyEh80jZ8KGWJsMlOBqU3Q2+YTp
         ZzG6s/3Y+/08qqkuv0P88GYC5LA1zQiOIimtdtPLOOMZtk1WM5D2JuUf8k8quAyuRG2Z
         lFV5Ko/mxleE7fhx1ec5BpNBO5aeZTzdznMl8ThyfMfdwGJb1syUWgOK8ySKOI4uU5r8
         6IWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWODpn4NE6ZaDChFKCLWhIuJXx2/8cLAFV0QRptw0Eo1CNmNHX9R5neXw9ks+qNTFP4NvAo+9k1@vger.kernel.org, AJvYcCXPjhYYCM/66M6PmifqkBmQpsGkO/Z3YumAi4PBmBp09bLMLvKQTjHrlDB4TwWa9FtByajoojTlNtlaVDa4vhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTf4RdlLNF9HtfqANjBzrBDwhjtcMtZBa2hlYNyephY9FU4lXN
	NMLHF0fikbux8INxgiuLqNE1ncqurHsONy4LFM69bh0gY/42Riz+RoY9
X-Gm-Gg: ASbGnctTwKr5ycHjN2danEFXtWbubR0uWKN//z7klwHc6+Ay1XP5YAI62gnuahsV7H+
	fg3+Pnv4V0EjFWopz2euwIIwZrbgPUTp6TxFVWdkWoo+KL08ag9CWziANz5ts0ybjMdg/FsI6Mq
	27lUS0GBwGY3Zob5dOnUSwv9+IuqNI0kZDa9XMTQ+u6FfvvE/2kcU9IpzuIREQey/jM3l9ovLlf
	pmvDv3iNDlqlVwROpSpJvPPIYr/MaX/FVw2qz8U6a1ZK5WasXgcMwrSGWxTb3++r0UQuenZ4rXs
	ui/WseIKCpoB1k5go97FoGcpKNJoSTFqAvbhb4IrEJYvQP+Jutx9+a1ZorezLywLD/UvGGyGlGq
	fJJlynmToKnm1jlJDnonXBIPoizzD/PjA8FT0JDRpoHi2sDdpGg==
X-Google-Smtp-Source: AGHT+IEB/Hlduf/FtNCdy88U194VqMOrJkKcasBBtJYh4OexQw3KdEgsmxQ5dH28Ka9KEU40wWAHiQ==
X-Received: by 2002:a05:6000:1ac7:b0:3a4:d3ff:cef2 with SMTP id ffacd0b85a97d-3a56075a079mr2152038f8f.27.1749720734579;
        Thu, 12 Jun 2025 02:32:14 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a561b65ab2sm1454514f8f.96.2025.06.12.02.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 02:32:14 -0700 (PDT)
Message-ID: <75addb05-06c5-41ab-bede-4de79f3474c5@gmail.com>
Date: Thu, 12 Jun 2025 10:32:12 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/2] net: ethtool: Don't check if RSS context
 exists in case of context 0
To: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Joe Damato <jdamato@fastly.com>,
 linux-kselftest@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
 Nimrod Oren <noren@nvidia.com>
References: <20250612071958.1696361-1-gal@nvidia.com>
 <20250612071958.1696361-2-gal@nvidia.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20250612071958.1696361-2-gal@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/06/2025 08:19, Gal Pressman wrote:
> Context 0 (default context) always exists, there is no need to check
> whether it exists or not when adding a flow steering rule.
> 
> The existing check fails when creating a flow steering rule for context
> 0 as it is not stored in the rss_ctx xarray.
> 
> For example:
> $ ethtool --config-ntuple eth2 flow-type tcp4 dst-ip 194.237.147.23 dst-port 19983 context 0 loc 618
> rmgr: Cannot insert RX class rule: Invalid argument
> Cannot insert classification rule
> 
> An example usecase for this could be:
> - A high-priority rule (loc 0) directing specific port traffic to
>   context 0.
> - A low-priority rule (loc 1) directing all other TCP traffic to context
>   1.
> 
> This is a user-visible regression that was caught in our testing
> environment, it was not reported by a user yet.
> 
> Fixes: de7f7582dff2 ("net: ethtool: prevent flow steering to RSS contexts which don't exist")
> Cc: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Nimrod Oren <noren@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Joe Damato <jdamato@fastly.com>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

