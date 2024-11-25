Return-Path: <linux-kselftest+bounces-22510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA239D8C08
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 19:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9114B284A26
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 18:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3881B85CA;
	Mon, 25 Nov 2024 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCQEFCey"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123081B3943;
	Mon, 25 Nov 2024 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732558406; cv=none; b=ABQLRQohQbZ5nIs998Hw4nNRuevF17ikRPRFPXhWTr3WnF0M6UN3he2TGV6MqbE9pdQY5YSNHk8Ey5FO4GQqmleYWCWc0upzcwP4kx7VKro4M7631+6McT/ZMMC6aVfyH9U83G9b4l45Wr0BbblmOBtti4M09E0CAgX9v6HulNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732558406; c=relaxed/simple;
	bh=u/UtjlxPvX0gRxU8q8YyCsuTae6U8jyAl0Kn6Bm6ElA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=E7Z8QRRNvkvR5tcbQ2XrP/IYF39D7fLYSa96R71WveMi6RYBgn/58CNCKyf1IlERH3NCgbucE5HgaYRbz22UR3TVbLYMmi55bHOQRSku4eDeP06HoLKoeL+tni3oTkKbwde6oKYjjuyU3ZnBi747FCVcIdLckEbcET+2efx3JIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCQEFCey; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3825c05cc90so3067463f8f.1;
        Mon, 25 Nov 2024 10:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732558403; x=1733163203; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuwA7pSHzuOklOeHv/Qu2g/rtIe6QZI7t8Z44j1848A=;
        b=DCQEFCeyB+1L3wnI7ZwpKz7SEjxi+9GINCyCvohruVi+gLWEfztuDmxjSZykfE+6vx
         6X5JPM6Zp458gpt3Z+pwY4+rdXt5sOPmiyJSh4CbA+/Z3Cp2/HM5HCwghmJEsEJGD3Wt
         osHlOaFrLWE0ovMFkoPI/ftkycEr90h1aM9iEVU/ZoocaD81y1gsz/2q8LAX50DoDRsY
         b6VhGPFwfwSUMmpvfaSwdSn9RlNnAHKworKoxajo1oj8DNOnoYJPAOHRAPG9a1oaoeRX
         W8mDmMN9PZbaYILD/ZPqiQyyznxdzBRqqMCXwK/iWLJSHFcGC1Gnzl0gsC5I1FeOUEjW
         h/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732558403; x=1733163203;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GuwA7pSHzuOklOeHv/Qu2g/rtIe6QZI7t8Z44j1848A=;
        b=MeYpfYf9GD9rxpvszylfqNqTg1a7co8pQ2EAdJydOQzV3iZEnP4bhNDvsXBnsv4MMe
         w1YfdfU6wDC88mVtO7YybWQmMy1DPXymwUNKZ3KeYGxQebAOTseHd5qgnfopNAj6OTLo
         l4grazHaGmYsmAeTXvodIWi+r2kBeZo0hrYEdCrsCdtkt1VAvmIIq+PWQ/lgLLyzh5q5
         3/oKNEUorldLzR9cnrtghDVzvvEmqjMhDtTvl+XQuJ/9M1SJW10IDyd3KZenNTEiExYk
         DLAHfMmgq4hOlQj5Rc0EwWloXzQ95pZHZIzhceflqwb+pthr7resyac2OpwfWkIWIzXT
         I30w==
X-Forwarded-Encrypted: i=1; AJvYcCXNzTRQkYg5/HgWpYm3mgCQlU3O4nl/QHtpE8hKIv5WXfKBQnG9yJ2KAfDCeWDR3+kczpFdQSj0FpxmYIcjoo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWXEuhSx5bDajjHIM7ZO5xFVhoRVv+Ii9WV1v19hazgWrl7l5/
	fkze0MJrgEJAmvvRdsczfGXvnh1rfE/gPNsnuiTHejp10ioeKh5HVLQICw==
X-Gm-Gg: ASbGncunQojoitAA/NtoNxicnf5aJ5J9IiRn83VCF1i1RIQby9dxdoqqdwJGkyVr4WD
	8803hLSD+5ma8sayTO6fQYtOEwWCZFYqRyKUvbL+8UKGNf1Lrz+vTynf3W3OYatQYnrYko6qFKc
	+NYD4qsFkZydQ4YD6Fkq4AwGO+8/ekorXI/ytKOzQnWXdQ0H38ilGrtKT2R4EE6XdDAGGgUHmDN
	MDkNFErmAbdP5CTMp1+Bg1Hq89p5vz5xNLFz+vy78mqdeyNe5HdplX+spFNPL2KG3KBFqxi0ETg
	54xGjPfSbtpb3yvVXlrb6w/IY94lJNndGfDr2g==
X-Google-Smtp-Source: AGHT+IGJ/VDtKzfYTD0Atge4LeFfuUhDsNQTeEoKMIF+fQxxqyMsDJPaf0Wc+eoSrRS+KhotrZUslg==
X-Received: by 2002:a5d:6d8c:0:b0:381:f08b:71a4 with SMTP id ffacd0b85a97d-38260bce4a4mr12498003f8f.45.1732558403206;
        Mon, 25 Nov 2024 10:13:23 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbedf58sm10997588f8f.103.2024.11.25.10.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 10:13:22 -0800 (PST)
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
 <b0f84914-c4bf-9071-b72d-cc2cc4a517f9@gmail.com>
 <d986d2ad-3ac6-4357-a8dc-e83e3622efb2@nvidia.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <be6cf399-deeb-f879-057d-baf9c4e76863@gmail.com>
Date: Mon, 25 Nov 2024 18:13:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d986d2ad-3ac6-4357-a8dc-e83e3622efb2@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 25/11/2024 14:10, Gal Pressman wrote:
> Thanks, I did not know it works that way, is it actually documented
> anywhere?

Yes; the struct ethtool_rxnfc kerneldoc has:
 * For %ETHTOOL_SRXCLSRLINS, @fs specifies the rule to add or update.
 * @fs.@location either specifies the location to use or is a special
 * location value with %RX_CLS_LOC_SPECIAL flag set.  On return,
 * @fs.@location is the actual rule location.  If @fs.@flow_type
 * includes the %FLOW_RSS flag, @rss_context is the RSS context ID to
 * use for flow spreading traffic which matches this rule.  The value
 * from the rxfh indirection table will be added to @fs.@ring_cookie
 * to choose which ring to deliver to.

I am also preparing a patch to add this info to the ethtool man page.

