Return-Path: <linux-kselftest+bounces-23662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB309F9566
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 16:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74AE116A61C
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 15:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDB8218AD9;
	Fri, 20 Dec 2024 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Md249jNt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098071754B;
	Fri, 20 Dec 2024 15:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734708420; cv=none; b=kvx8+dtny1z7GxAWAg+Eps+LWnSsmMlQleDV154KdBxo8QTRoZ2s+5iyxCkAy9YVR8MvBir+2yuYWDwCMHI9dgGVaruARtcxPmS55S2MqF5DVKccGh0yKG4X4bv9UEVa1MLRzVOSWa6GF4i+I/fnXmo+Uhe/BdF6DHgX43PJegY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734708420; c=relaxed/simple;
	bh=B7Jar74UlEAc5Zz/Tm7QzRK3yjHSA+2yIJw7aNVQxCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7LAoOLHLeVZPbF4Bqf58l7T+KAdUiMz3fCSAJKAR0rBQL5ojXFJxHOgPZ9+YZEoJclVVDZ0B7tbF7FY3BtJKa7eMaZZIJrZOltpkMyb1dWOWKsZNoO7Lb8hyME+80/1FpQAzgXBI23UorDBpxstsrI8xAfP3pjHFtnW5voU+gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Md249jNt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-218c80a97caso18002615ad.0;
        Fri, 20 Dec 2024 07:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734708418; x=1735313218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NsV9DFAZTZ+VyTBPQiYpJZXRBPd7DhEFM5G5rn/xIBo=;
        b=Md249jNtOViY/rTkQRkNBnLmWJVpOeiyx4cai8DiXTGmUDfEPt2n4oRUHc0prM3t9R
         HwzE3MH91+WC04Z8OxUqRWXTfHwQ1OUqS1+AmXaAcV2rqh5sKvZTlF515EEsHlbmD52R
         2jGaSRfJug+UBWaKHAjQZPkjMCp51HMC+LmpbMib2oelF1i2538/96Q3bGQhM/gzKD1b
         sU3Z7wN1VXhc909YgvHvPZO33wAzEMz4vilRuMigbzxWoNm/NVgWc1ibIqwtxDWKo2Xu
         nyurrYC/L78gZJakvRAm4DPN7786hx00snKIHaC4429aHt4Kxy8WUarrnZwFk4I+yg2t
         J5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734708418; x=1735313218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsV9DFAZTZ+VyTBPQiYpJZXRBPd7DhEFM5G5rn/xIBo=;
        b=o+tQMsCxYtI3oy57EwYYId6VxcKSoXzxRHLTIUD/qi+ocaKyKOAvpI2gdjDe6ukOem
         t+lgOa9W7/dYeiPsAK414UwIO6s/hEbTEXxPneHyxzGhEZuK1OvcFarIz5j3N56pGLBV
         XKE08qH+sOrC2+TSEMGVS3S2LKLQnR5hTcM+T7YNlhbkO9bXzarSdHRBANyBdro9e++k
         R89hREJ4ZburYyon7zbdjbp5Mq9CSJQOJEU+UooTwlbEN4VsA55cy0C40j8Cijrjro/C
         FzexZH0pzYTkCPnxNx7cu57P9j7jDwPYYSj+SdLYydqUYpu1gEWgN1OIXm5fFp5nGcO/
         23tw==
X-Forwarded-Encrypted: i=1; AJvYcCU0DcRRJPCLikqGbhXkTAaAN5wcVaGC8pif7I0fHdQ1CVqcSnLZFM3yl9G4E7KNvFDbDw4=@vger.kernel.org, AJvYcCUbr/ao8qLWPGrvB7+2p60W4iXkPHrUY0vDYl+zEJiW2SaxZITTZNPBIaZ3g7pBrET5oEctdv0o0CMme9gl@vger.kernel.org, AJvYcCV4Y0nif6Pp3kJhOMYmYli/gl1lLARfq/5HgWBnY41lAS3UV9zAI1TUSLDsAWGBFP9qjtjvqQdk@vger.kernel.org, AJvYcCVLI9GdqkMKbDdWCmlOCbwo/A9sXElYdrEMc29D6l2fG5r2AuV7PVkaffDJkHCL07fXca377mC0yaZBRg0fQYSr@vger.kernel.org
X-Gm-Message-State: AOJu0YyQbTt+RYyW4wTXBLfAj2iwTtv+fkLO5IeJYtWHdZ3mGwNxDBhv
	zpLGNmTHiD0PjlpnvQWonJYFy9esXgKi3zSJQ5g8F5GvI9x1ja4=
X-Gm-Gg: ASbGnctngT2hp2YY89ggX7/sOGnBvFs7AAuYQamLi2JLh1OmZ/Vm0JW9mdKYrbkDhVb
	HyAuZueVjnmzJZOQBdFArwDayTxLFhQV3zEgLfyPFKNf0/E2YTSSvKDS3BqWN3n5OnxTOne++Ce
	gKwKpoPqA6oV2Olu8cCxpkK9SUFUjlgxSfevnbRfw6eObl8o4I+9NReVNvbgelLFBqJkW+PAIMS
	rXpZ1ESxiO4v+dyYVyBws6RpMe9KafRifUvpXq3R0u7xwNqj0xb7VxL
X-Google-Smtp-Source: AGHT+IHz9+7bOTzRfbdXnya+sL1oqM0dpu0HPvuM/yUXMazVgXdFgCL+6D1K17jv+LV7lZUZX7em2w==
X-Received: by 2002:a17:902:f693:b0:216:1367:7e48 with SMTP id d9443c01a7336-219e6ccdcb2mr47583195ad.0.1734708418153;
        Fri, 20 Dec 2024 07:26:58 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96ebb6sm30518565ad.95.2024.12.20.07.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:26:57 -0800 (PST)
Date: Fri, 20 Dec 2024 07:26:56 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
	andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH bpf] selftests/bpf: add XDP_UMEM_TX_METADATA_LEN flag to
 umem_config
Message-ID: <Z2WMwPc9fj5kHcul@mini-arch>
References: <20241220091806.1856223-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241220091806.1856223-1-wei.fang@nxp.com>

On 12/20, Wei Fang wrote:
> The Tx metadata test has been broken since the commit d5e726d9143c ("xsk:
> Require XDP_UMEM_TX_METADATA_LEN to actuate tx_metadata_len"). Because
> this change requires XDP_UMEM_TX_METADATA_LEN flag to be set, otherwise
> xsk_buff_pool::tx_metadata_len will be initialized to 0, which means that
> the driver cannot get Tx metadata and cannot execute AF_XDP Tx metadata
> hooks.
> 
> Fixes: d5e726d9143c ("xsk: Require XDP_UMEM_TX_METADATA_LEN to actuate tx_metadata_len")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Thanks for the patch, but it should have been fixed recently in:
https://lore.kernel.org/bpf/20241205044258.3155799-1-yoong.siang.song@intel.com/#t

