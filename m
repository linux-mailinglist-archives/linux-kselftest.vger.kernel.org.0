Return-Path: <linux-kselftest+bounces-23656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0F39F9233
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 13:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1462A16A99C
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 12:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC3D2046B5;
	Fri, 20 Dec 2024 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="vSb7SljQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318C320468E
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734697698; cv=none; b=NZiJpP4tOcJxzNrLdHDyQp7ddutZQafcYBNjd09F4YjumDgb7KmxkCx2wPDeYBdXZzi6qk/5Vzm/zZi4tF+xLHshFTlhBonIAvpfju4/Opa3hXmEt0Q3nxqft2Dl0c6otdy6AVS0u5U9uztvWzxGDnQynaobOCvemmFRs+uiKkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734697698; c=relaxed/simple;
	bh=Ddb6v77SHWQ01yjg5zQWJJWLi+Qk+6+wE6upKt6anmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E19opWAMRpnEEeVUzR/dpWYnA29Q8ecLiV01wU7VtY0wfxV6xdZUrobI4EgBDieUDI91iFftFR628uwEI0g4JE1ZljeF5CMQ+JjfGVl3T7xS69CyUaKwn3GHpvCJ4x6oTAS9A3cMiFEg4By/vGXlJW4mLBt91mPWBmeFCMxvw1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=vSb7SljQ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so1110766f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 04:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734697695; x=1735302495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PK3ngqbeNw4BOnOakPdfhW4DY28wx9y6ctKhCJu1Yn8=;
        b=vSb7SljQDLnLAsLXPxQg60KQz7T6rCpa13zKH9v4I7clFHRGrF49kDaduZzPrFDUPH
         Cyh7jkdtqov7XKyH/caO0Dl4D+4p27jSEtmIekeWgePqSgaTPlGTGtzL4xgJ/sMBudEh
         xbJdMugxCCVY2I2COLQ/vN0r7X69tCBs1Ip6XburNeqj4uiIi0IypXc+QOfXcw07v4xp
         oGIfuWAFBobeUVHPIbQwasDde4Dm3nMSAvi8BYxLMv0KEeuvpzXkqMm9iFLgsNf+1Lnh
         H5AnYLnJQKQXlf1cJgjfbdpqZpuReLLh/DL7ZieB95z4QHHRq32MB8ue1Y05WdDBcgSE
         gwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734697695; x=1735302495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PK3ngqbeNw4BOnOakPdfhW4DY28wx9y6ctKhCJu1Yn8=;
        b=vY6sqE8BzNwTBfZkUv/4Box9/tCo73W4EgKGwIqxnNI6FqzOqB9HC1wYaguO0SPTf/
         pT8/x4eVvmkS6/IFkjuV88AVcCHzmZ0KNXGleqtcDPpGOB0kbDRlSxNTjpiMD7/6kHky
         Ttu6ziNSb016SHDil2sMo4dpFktko11jQWZfY9f4sTZp6N4KXBVJWGNV8ytm99v63iMD
         b83Fnk9MDswYm8kLxN/vDVgORWkjJFY1WOx1+mVSDDOIn2EnHgO2hpTN25uoJmyXwzRg
         CG6NBAy5ZBbLwQGyU7Ees64W8IJWhZ1oOwH3tMxwUugnMI+YNU1Bdw7vMkgL3Sv02tGu
         IwyA==
X-Forwarded-Encrypted: i=1; AJvYcCUYMZ1DlTuaCyGLJTjjuPwOJdBJYCe/wL12GuM5/SOMGsEgsnBry7Nr02nzCrWiWuS1MG4coBeMRiaS1bYVZKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXpPeQWP2+2El/cWKjgfDdwDFG2U92T4qOO0CJO+EEPxM/5qX5
	Av2QeW3M6c72hhsKo21D4EwND2azd+XZG/aSZT2F4DDmCfzv8Dp57gvYendHCCE=
X-Gm-Gg: ASbGncv6j0btAoQJ6hhI1ANVMUr5ePhGp/ewTLgkHDVboRJdEEMfRCUn2MfcSHu8+eC
	hbObPZrkxCBZsJWnhzeH4L/dHq6FEVdYDoPiJ2bBR/IIEEVzzr1sYUXlcaXY+1D3MbFJ5YvjxAA
	cNhXCHwifqG5uM+asme7XS0w/ZrO8A+BAs7RX9Y8sJreaSrCNVOvOP3bcvqafyURTVu6/xwmkqG
	X185JicRAc2nfH5OUbEOMdsVRJ2W1SFNshWe35KKBdLxlxE+7vWYLj2sP5oqLLDzxl5dWn/ZVY7
	2BUSthoHwS9d
X-Google-Smtp-Source: AGHT+IERzTmIuZ5ShE2OixsRQokWqLCp5nlaW4wpXU7HE4OP8i/8gpF9Ee/IWg29uVu7gnnL3BEArQ==
X-Received: by 2002:a05:6000:1fa7:b0:385:f7a3:fed1 with SMTP id ffacd0b85a97d-38a223f5cf6mr2525361f8f.44.1734697695631;
        Fri, 20 Dec 2024 04:28:15 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e528sm3994788f8f.83.2024.12.20.04.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 04:28:15 -0800 (PST)
Message-ID: <50b37747-6820-4849-a578-a168e62dda6f@blackwall.org>
Date: Fri, 20 Dec 2024 14:28:14 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] selftests: net: Add a VLAN bridge binding
 selftest
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Roopa Prabhu <roopa@nvidia.com>,
 bridge@lists.linux.dev, Ido Schimmel <idosch@nvidia.com>, mlxsw@nvidia.com,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <cover.1734540770.git.petrm@nvidia.com>
 <baf7244fd1fe223a6d93e027584fa9f99dee982c.1734540770.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <baf7244fd1fe223a6d93e027584fa9f99dee982c.1734540770.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/24 19:15, Petr Machata wrote:
> Add a test that exercises bridge binding.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> CC: Shuah Khan <shuah@kernel.org>
> CC: linux-kselftest@vger.kernel.org
> 
> ---
>  tools/testing/selftests/net/Makefile          |   1 +
>  .../selftests/net/vlan_bridge_binding.sh      | 256 ++++++++++++++++++
>  2 files changed, 257 insertions(+)
>  create mode 100755 tools/testing/selftests/net/vlan_bridge_binding.sh
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


