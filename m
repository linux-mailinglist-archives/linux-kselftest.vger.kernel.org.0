Return-Path: <linux-kselftest+bounces-22830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599509E3F35
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 17:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6DB0B3DB7B
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 15:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F9C20C47E;
	Wed,  4 Dec 2024 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwNLZIxE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B46A209F5B;
	Wed,  4 Dec 2024 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327318; cv=none; b=ncjWabkNtzCiMrN3bWxL/SX6gS5N//VktWathDBcpFC5JwhIaE1L+0YqA6+V+XU/6zwStHGoi7JO+oEDQ/tIFDxMHCdL8fA4dr1BG+81UBljcyvqOCoMu2GBnxXrONMlwHTy32S7pTiIcN4JXncYPQiI9zSEIxf3QhzZ+Cdz7kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327318; c=relaxed/simple;
	bh=ddIIs2MMrdU+TTF+qZ8Me6qlDgdA32VPibL4i1IWt/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEILv22rGXcMWtdvqGfcisz8CUcdrBQod74bfm6rl/CSzQQHtJJh9mCv3oOA+aUXadUMXKvG0JEzi+h6R+/913gJX7DxDwxjSJhcwj0JCjBomwgT/8ntZh5DigmMhAvnOgmPWj4tfIZRkvkJ5Pk5riUyB4nIoEjT8ZmW66VhZwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwNLZIxE; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2155157c58cso36160945ad.0;
        Wed, 04 Dec 2024 07:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733327316; x=1733932116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JnCHEz4Gh7akoOewhOyufWncAXhN1SKzUf/9Phjsxl0=;
        b=BwNLZIxEspc/7LjDcmz+JY5wTMG1X4mOvUFJWOS3Jw0u/S2+/F8MHdGUSI3swLyEXd
         C7Q0HtXgBKlTqEhik2+acYakI7skSHQPXWwiyifv8Ch4sCLC9m2z98OeMYN+q0KPDB7o
         MdEvBoET8ePEiG6ZEOMhwUzaIE/Cwp+5If529wYu48W2JXQtLQbpYJntJmw6ddJAUXXl
         Mt31Q0MmwfWX1U2I60dslvz9ffeZ9raJiERBB/Fu4uBHIyp1BL/1WytcqTEvcsNWcNQN
         VJqCTOV0xFBx93cnAMvJn56rqnL6MqWYsBwJJo8RoRBhmFnRz2JnJXsAm6dyEgHUbisj
         V3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733327316; x=1733932116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnCHEz4Gh7akoOewhOyufWncAXhN1SKzUf/9Phjsxl0=;
        b=uJsDPKbcXNTm1ONO8NMXbWMb56CtA8BzG6Uy8p3NqHxyKfoI35hB3LbWnbCsOR5/sH
         /W7zrgWZ553vOsiBmwBbvBeYrVbeAddgfeeuCrkxLaZWcOeFwK7WkLozOrZcexOm4h4Z
         7AlklYKtzMlRi1G2T3z+IoQXaYqlX6GDbGoGUVVAJt9LV+JKf7Aymm7HPQJjFeVgis9O
         xP4TsU2/tMTBWl4jsCprKLT5D2vQRvP5ZEw1CNKlxl1y7MogqGSQ5i3eepd2cAAgm7L6
         YqXhocYhyCKLUl6rmn7WPyJiBnFctI/cu88/sbB5foMkpuZZ70h39B5GjfR2alaH7xCT
         eqiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwk8IHXMzKHYFsZmMYvSmlgzfyvZh0HhXeWPfgtOKeiRWON/etLYNMe9XbUANlqlwb06c=@vger.kernel.org, AJvYcCVyBIk4WBJ8zXW/jXAoESykUCmNyMsOfa/bIzlc2ppxj0rbDAhEaaeRqGo536t87hX6I+8Sj/kKV2Nl8k9g1OSN@vger.kernel.org, AJvYcCX6bnOXyG+T8VbaPBCiFaxpaGiNQ7o77dJbEVmcJADAEPLWArRAG2Gm3k6afYGK7qscFMtZE58yqDEAn6tT@vger.kernel.org, AJvYcCXbFCO6RDXIgMcmjxM2jgvQtPBwGSiNt7G35V6EdFE4vbyD7IH2wU5PrTexgKxEWa9LQi2t/Yi6@vger.kernel.org
X-Gm-Message-State: AOJu0YzjzBVHYGe/amdSY9FlqMDRFysmJ9OYUOMlDacFfNqU0NqL5or8
	8iVGWvxOmSj0SVKbPp5DbeFZGTD57JgSkZFWrc/KI1ImlWyxAGA=
X-Gm-Gg: ASbGncu3mrHGznIvC2HQXSXgoHRmYLcnu/F+1W08J2Q/C5tUPi5lQzju1YyiiScg0zI
	35oDgK3DeopezMFRduug6GiPRRP6HGkJo8GyAsCzSlXsWAcbiDrq/TFD8ABfkvwHwONHi4RCepu
	xNN4gnuTwWYByfIgJLB84EK+DLmPCzYx+SI7ylf3e+LsGANrwQboP2lkgkbWIrvJGo6Cc/zd/nL
	TCulBqhEv5I4bOHdbM7lbsSaSlGc3/VJf/NcMsef9Q00InP0g==
X-Google-Smtp-Source: AGHT+IEP1xSLasVS7/Eh+0BFE6F4XD6Q3rr3wy2zzlq0Xnmtaud9x1YoV3SSGm2oWHby4PT3mFPSWw==
X-Received: by 2002:a17:902:cf0c:b0:215:4fbf:11da with SMTP id d9443c01a7336-215bd0f10c1mr85383305ad.21.1733327316519;
        Wed, 04 Dec 2024 07:48:36 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521904caasm113537035ad.60.2024.12.04.07.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 07:48:36 -0800 (PST)
Date: Wed, 4 Dec 2024 07:48:35 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/1] selftests/bpf: Enable Tx hwtstamp in
 xdp_hw_metadata
Message-ID: <Z1B50w1jzHFt-LuA@mini-arch>
References: <20241204115715.3148412-1-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204115715.3148412-1-yoong.siang.song@intel.com>

On 12/04, Song Yoong Siang wrote:
> Set tx_type to HWTSTAMP_TX_ON to enable hardware timestamping for all
> outgoing packets.
> 
> Besides, set XDP_UMEM_TX_METADATA_LEN flag to reserve tx_metadata_len bytes
> of per-chunk metadata.

XDP_UMEM_TX_METADATA_LEN is missing after d5e726d9143c ("xsk: Require
XDP_UMEM_TX_METADATA_LEN to actuate tx_metadata_len"), so that make
sense. Maybe add a fixes tag?

And I don't see mlx5 looking at HWTSTAMP_TX anywhere in the drivers,
so I'm assuming that's why I didn't need HWTSTAMP_TX_ON during my tests..
Which device are you testing against? I do see some hwts_tx_en
checks in the stfmmac at least... Can you add these details to the
commit message and respin?

With the above addressed:
Acked-by: Stanislav Fomichev <sdf@fomichev.me>

