Return-Path: <linux-kselftest+bounces-27810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581BDA48B4B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 23:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5922D16CD7F
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 22:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28CB271284;
	Thu, 27 Feb 2025 22:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnJGnhEV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64048270EC8;
	Thu, 27 Feb 2025 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694850; cv=none; b=fGcbuVEJKvlfEVpY6jPu4ybEFbtTHQWBOWm1RFtxy11NqAiqT0bVPBjdT6o49ixOE4ek+XP+uklvbNQlUrubJvarEP02HzJTRhcsphn8RATj4pcPJflRClB35yWYPfbtRzBafl7uTq5oUnPyqBqkfijt6jwFm/YghBWEEaDH+iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694850; c=relaxed/simple;
	bh=nJ9cqAY06b1H9psIDaBzzxiDay85pRwp+Iqvomz8JPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1i9XgdeTj3fZGwWFFJfE5oRjL0pXMxtEO7xJbRKWKjbFOkHiyn1g8D+Wk5SLbd4TxMO8H1G8o8NPULfMCM8cVkt64uKdm/jsMau+ylLOUhiSo9WKPf0sJJU/4XkLN8LjcnfIovLfUlfhVZzhVccVC352N/GbonqYFX3Ve4kavE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnJGnhEV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2232b12cd36so21806455ad.0;
        Thu, 27 Feb 2025 14:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740694849; x=1741299649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BH1l8/FwzoGHwFyDrtYRAirS4jCvclfhfe4Iqx+a17A=;
        b=bnJGnhEVP7OtqzfoX/PYUpiox0kRTRSH6y7liVXyXaSwRrwSeIMuySVlsTcDl2COtE
         1NnXFa4QLNX1nefax2WmZu4KOnIM+ios8SGInzmnjssgX99n11VIDVqNdO18cvSGeHMz
         bl8KEJjRBBvDuc+hdgqYLuKJcupaDW0+sODc6imBq4Vhh7/NVZLEj6xh8BZ29H3LsjkK
         zllK/v1xvAmqT3sHX2eKkilGC00xhY+ksjFgLeKWUcYIaPkzWWuoKZee7Gn2IlCB0agu
         MB5LnbtdqVKWeUt22H/VI9rDXIeWSkg1RdhxquqkK0Vdrmcz2oceV6dXWhpC9nhmPCn7
         oSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740694849; x=1741299649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BH1l8/FwzoGHwFyDrtYRAirS4jCvclfhfe4Iqx+a17A=;
        b=jw/ahdK0/RImX0SyNHQPe2dYs2WApyIabreJsNhsQGFbGJnrvnZePWdUIuUxoxbbMV
         +do7ysJCGmnIiHybuNy8PZ0ABfyz/NK9KrRAsANjTB5e1ACcCAoiSq/4p+mF7lP7f6ha
         i8U/nmJFq1iMlfuvtb9DUa5t6iba1tSPHOwCdzGa/u3APohQuv2sfF54LxkUGXz/J3bF
         Sk8OarnmOXKp29zVi5j8JuQ0WkWpZ5GsIpghnLLy7xLUpSTRMGnjGQLrmTF15RdxbLov
         tXNBmC0ICFG6zMe1ti9YCeaSa0P3hkfTCYhTxav+3BFUUmU2gAjPyFNAZ8xEc2p4Gngx
         K0lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkZoNHwf2NOFdPJspocf9IGGswPIpm1t3hqNzMyQPbm54kG1cDfmSguSkhaLSM6zS7I+Y=@vger.kernel.org, AJvYcCWYHxNJam5eTAcIwlP2k2fhWjNZMupqdM9bu4eP64TIn0UWN7T1rO5OiHsIh1axa9VEuONPHBevrnu8zU/b@vger.kernel.org, AJvYcCXV6gMI7HglRkf/Oo3NFFWdCaXsq1v//XDCo3Pp8mKgIKsCtWm0tfUradGwZ5f7cyIz/O/E55U2sPXqVyGRj49X@vger.kernel.org
X-Gm-Message-State: AOJu0YzFCppvpNJMPM/kPpCQoSyvqxRwZ/OfLRg+ZTKJ1heVyg17YtAr
	WL0fJ5cBcFO/eY+VO9XUJKeQMctDrevJipvpRpf3SCXEr+V0ukm6mGh/
X-Gm-Gg: ASbGncv8cRAH73S2GnKx9zm0n0utkg8Vs3SV218rBT/jg57z5or/g73CrqmwUVLtwdE
	Qk/I7k/JdUBdzdQbAjXmqj3iNErHyw2vVtjSIKWNky6VrhPJ4zYcKM5UAIcmNGMGO1GNeTL9IVs
	dnvTBY3juEwioLsz/bUzGH8bQsvAkehXLoxterflLSpW8a2WN90yrMrsPW1QrT05fmfjsxQXhLv
	Ox154jXr/Cri1SC+lFArvVstOuHVou7HAM9gM+teD2YnSKRpvk+ngkLC6rvDO324OU/qrW1o5iV
	jTHRRbuVbExKcTy1Tyl+dHDNMg==
X-Google-Smtp-Source: AGHT+IHsjHcYBON52tFFIBp0YpqJ89N+H1PvM9CttmTtsV91giTbLDVEmLUdonpeJppCcN/kqCEKfQ==
X-Received: by 2002:a17:902:c948:b0:220:d79f:60f1 with SMTP id d9443c01a7336-2236920765bmr11883685ad.42.1740694848688;
        Thu, 27 Feb 2025 14:20:48 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-734a0024e59sm2300605b3a.92.2025.02.27.14.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:20:48 -0800 (PST)
Date: Thu, 27 Feb 2025 14:20:47 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexis Lothore <alexis.lothore@bootlin.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 06/10] selftests/bpf: test_tunnel: Move
 ip6erspan tunnel test to test_progs
Message-ID: <Z8DlP7XHOALzzyRu@mini-arch>
References: <20250227-tunnels-v1-0-33df5c30aa04@bootlin.com>
 <20250227-tunnels-v1-6-33df5c30aa04@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227-tunnels-v1-6-33df5c30aa04@bootlin.com>

On 02/27, Bastien Curutchet (eBPF Foundation) wrote:
> ip6erspan tunnels are tested in the test_tunnel.sh but not in the
> test_progs framework.
> 
> Add a new test in test_progs to test ip6erspan tunnels. It uses the same
> network topology and the same BPF programs than the script.
> Remove test_ip6erspan() from the script.
> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

