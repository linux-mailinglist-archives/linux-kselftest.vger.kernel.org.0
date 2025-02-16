Return-Path: <linux-kselftest+bounces-26746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5579A374EC
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 16:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5CB3AF0E7
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 15:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3440199230;
	Sun, 16 Feb 2025 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ThQddU+R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135341991B2
	for <linux-kselftest@vger.kernel.org>; Sun, 16 Feb 2025 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739718680; cv=none; b=WtTbId/p9f/t9Tf8PLLoIpPtBCbz9DC5F8h058BdGpvtMXzQXRPBDOhWDCgIR5qEho678wLzWsyYaa5SAq6joTqZUPyKTC/YETXDEKu+3CUOjds1pzWTL3EXDygCfRNWY46nDqaBZ8qIKfIgqVbB/WHiVIMi0o/4WbpytjnCqE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739718680; c=relaxed/simple;
	bh=4IQ0g5KvyuNbmI4QCx+VPX0qeUVxl+rCSR4p41A6Qs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7J+PIeYZTi7JmOcq/36/AIsm92Jynxon4jF78sQuYIetEpRZQ7XxBI7sGvqrY4Dr9IRRmazOGU0UxHbj+SzV19CVDhazrBrmq5EJ+t469ovgrim63RHwUd5h34ETCgMYQsPmBxHb3aTBBh6I2V0TJPzPdE6rI+1mzvOOLiHq60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=ThQddU+R; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dec996069aso6386167a12.2
        for <linux-kselftest@vger.kernel.org>; Sun, 16 Feb 2025 07:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1739718677; x=1740323477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XxEs174tgEejEhOGBs+mL3V6fq9DUU/u2mDzbjv/spw=;
        b=ThQddU+RMy7z0OSUJzzrS1h5g8C+aFHJEUpCeFTZIJjxuUuZtdmKhMSIQC4n94wsMA
         pDafPzHJ9SHhih0K2pNSaOECzLZF2sw4Sflu7Qp9Vp/gSgbYl4P5wPj+NSMhOmlVag/O
         q5meUpCfPzJgianjuaexCNE60Mhx7lfj6eiEJssnoi6ar4ubQDGV7uOkoD2r/g+JPqtM
         IEGNyUMPGTvd3GsvqA2z/npDltepLpNt/hTdYtVUtJ8bezynKDFcwYf7dPxWYQcun3N5
         uyEk8WG+9L3ZE3iHT6G7jtFsOEKGOGhAwvBnTkk4SdNdvPB779Th13jhGSsyKHpPBeBN
         xLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739718677; x=1740323477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XxEs174tgEejEhOGBs+mL3V6fq9DUU/u2mDzbjv/spw=;
        b=uWEgFo+62fYEKQUFkaUCI78r1F2NMhvEpNoSikw2YcuhFiEvOozMgm0sE0E2Rd47ci
         pWhcFqWDXLPIq63s/FX5+oazzm4X5YZ+5EEziGknveDCxvDo2sVkIaztpUJr6nNw3OmP
         PYEQCJ38uu2ZdvEGnb9D15Ywq9ev72EDdQpkQg7R3+sEB6xgFKUOFEXEgK5lmkcgQor7
         WQxqG+LhmizkwNkKcqit+DkbxCopvjmGFodUhGTaeXig11YbLwx4AOfGMz40IdwxZj/s
         +Nw56ygDMfTuk+MrEC4Cgyi0oB4Nh+yOgHprO99TfFEkqDuPwf+ziPfHs+bFiWwlwOvA
         DGJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU346NIw7RftY+6PxCFnlX9CuFQNC4WAHgyaJGFFxHHDgrsOtYYabavQgKMU4LpwCGsPCgNFq9j9A5sQJElsAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM1nvPKcS+MvA2iGIGbDNxRduEp2kGV0XjgvBce/kjGBR7XQrz
	b3rS62DEIzOu9RmU9E6nBWb9DtG/AEkWL0ReW4VBdx+gS6CfvjzCHTJZBH/KOOU=
X-Gm-Gg: ASbGncvpM7zvsXiEIvAoGnOvGp59AppnokjszbftIAXV7y08qidiCu6UNHzRJZq0L5l
	0DcS3f8E8/o/A8Wota4BSpviWmO5+b0ArLoHR6IMzxbniYEZTP5Nf2QhuDy3+P1CUgD4NhY7JoF
	O4+M/yxNRAMim6NHU1LP454NjwHaPoDrxgaE2urCoR3ZpTQiUCf9DW44fCpsy0PGWspS0vc5AUe
	rmlX/c1FlqvBeY48UaTTegj4/5jN72k2Hu4anR0bxveeTdCOgo0IwWlWwXmpNYOSS0/ib98y4xx
	y/cFQLCOu8kJeGiggx9GnuqMpHMiet5DeAX7sz2xBemyVVE=
X-Google-Smtp-Source: AGHT+IFJErHfiwjq8OuATuDMBXLWRjnh3cAPDyG+uN8XMo+VzOnpfp01aY9p8urTKh5hiaXOlWw+3w==
X-Received: by 2002:a17:907:7f27:b0:ab2:da92:d0bc with SMTP id a640c23a62f3a-abb70c01ecemr672451566b.3.1739718677216;
        Sun, 16 Feb 2025 07:11:17 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece270967sm5963200a12.55.2025.02.16.07.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 07:11:16 -0800 (PST)
Message-ID: <684bc34c-ae15-4cff-9e44-945294ee233b@blackwall.org>
Date: Sun, 16 Feb 2025 17:11:15 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net 0/2] bonding: fix incorrect mac address setting
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jianbo Liu <jianbol@nvidia.com>,
 Boris Pismenny <borisp@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250207092920.543458-1-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250207092920.543458-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/25 11:29, Hangbin Liu wrote:
> The mac address on backup slave should be convert from Solicited-Node
> Multicast address, not from bonding unicast target address.
> 
> v3: also fix the mac setting for slave_set_ns_maddr. (Jay)
>     Add function description for slave_set_ns_maddr/slave_set_ns_maddrs (Jay)
> v2: fix patch 01's subject
> 
> Hangbin Liu (2):
>   bonding: fix incorrect MAC address setting to receive NS messages
>   selftests: bonding: fix incorrect mac address
> 
>  drivers/net/bonding/bond_options.c            | 55 ++++++++++++++++---
>  .../drivers/net/bonding/bond_options.sh       |  4 +-
>  2 files changed, 49 insertions(+), 10 deletions(-)
> 

For the set:
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


