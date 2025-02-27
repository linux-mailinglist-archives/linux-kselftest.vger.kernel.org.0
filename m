Return-Path: <linux-kselftest+bounces-27815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3D4A48B6A
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 23:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCEDF188982D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 22:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00446272913;
	Thu, 27 Feb 2025 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhyQO/HE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C69527183D;
	Thu, 27 Feb 2025 22:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694954; cv=none; b=nV2caKHJgSYmHOUYVMY+VaN7qD3lNO1QRzxPIOvPa02ErJEQh6SiLb2sOfhb2+skTJONHFku9EwtWIQB9mKfhJuJhcp1VyxwO/gtDCa8NESRA49N+zF65bKjL24ZaY3Kuc80l2AfHmw+VC0oI53iENiARqK+1UArClDHVf1eUEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694954; c=relaxed/simple;
	bh=T6Bo50skY4SCzRbWW2limk0zSRLlYkPHA1ym6x6SC90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDIRgaGEm2DYx+q3hQnHLsZf+4LzDAHWDs5UBPqy1/8q1QkrzZ+AFd2yO42afjem/Z28fT0TEGsiUA6/XziW+U/apIMxQPBDmMDPaiJSZGM5gELbpKV9QfwNCWyY46T9CUOWxiwfknykoooabztcUfoz6Dv/X8w+EMamP+46oz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhyQO/HE; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fe98d173daso2526769a91.1;
        Thu, 27 Feb 2025 14:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740694953; x=1741299753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LJDVGKS8xeRNIpq4DDg+hys1rLrFWY25whSokAczVVQ=;
        b=lhyQO/HE0/+LsXTj3lNNlLFI3p1jQ3sGgaW0EbbJLz3Qh2A7ZG9nGVcwCyF2vkO3+M
         ghz9kgiwwzDUwdT3NXoBheebTaWgQmzsbZEQWDmdpCHbs7bbEyUEo0kWl7vf0Z01WCse
         XJ3DlsTe7QYc+Wg60dZuAdjo44G2wwQqechup47DTW+GpoyOpFg3K7M+Ka+v8dn4b+jp
         JqPyRSN2tCQfgSWrrlzakpQ7iA5MowYNy8FtIpcDVzNZh2+7x0RuFJGCbiW5ax/txsdn
         fmx45w2vNcBiNH0VPwHgkJIlqzjZsXF4r/K9j4lTItfVb5sL+huyw0XcYdiGtuiZ5sCj
         yg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740694953; x=1741299753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJDVGKS8xeRNIpq4DDg+hys1rLrFWY25whSokAczVVQ=;
        b=SfVmDTMxkEg104vBSVkq2HB6eoAlb3Lh1SGaXrNIYIhB01wzcF8pZJe3aWdkZcaFlK
         BSu32qZnins5iYonLhcec+13ZRQjYdjGmEPjnK1h6+0Ui91neYC7n+Wum6DJESAvnq5q
         mMtyIbAh4HiWKvlhbO+SZ6nGvd7vs/DjP+qeNRLcmScSHqCXSOicJnSK9YvvLlU0aBkr
         bTI9a++2kcvdMDGYP03JPW/qBYj6xK9jz2QvPjlGJ0DOgUcotb+HgLTw9QcwqASceL4q
         we1fkYmFnmrC/Ikl+k1ATCZUM6QcJ2DQZk2ZyPLmwMSbmdChqhScuyQLKuIHaz3nzici
         qCHg==
X-Forwarded-Encrypted: i=1; AJvYcCVAo4HNsiJfpRpL/GpLRXSSRUKJBxCOQ6gILs8ItNEGmtnzhdW1slTiV769O24157dq6bggvm59TScVTa1A@vger.kernel.org, AJvYcCWC2b/6xMHHKmJPzGGETM1UxUMs6pheRy2dDrVQPRVJmQgvJWRiQw1OjCfiWNH+WNpXKI3Eg+dSg8OSjmWiL+83@vger.kernel.org, AJvYcCWu+yOrG5yDIK8UMhH9xjujbGPrEG0Aze/n6LbS8NpDzwgrWpoMvXt6NDMBD/4KrVGiusk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyETZAGuIi/DERFG1OXObiQ10+871OXxPJy47RHDc5XcpzQgn4v
	cGAhEsbJJQcX+7+JB9ZknpUSTq0hrRG2sF3Zml/Z7zbGCEBPGi8=
X-Gm-Gg: ASbGnctRf4VMU+4N8YbMsVMmKCVVyM0GcspygVdyG367WZWCyEvMC0v3rmvJT2wjlxJ
	QG55Lt2nFKrukRjh7CJ0mzqytz5b7uKJ3dpOQWZnnT9p7VUTk8ovS88l9LDCW8b97r4EoEd4nEj
	XFhEqU1WcHvGlXThXO/UJJQgBZSyKQVPtKUxM9/BGyHSRWKHDLCAeIidoKyJ7WgW21kppiEssHf
	XvUvY6MKC1b8ApW4AlnJ5Vxf99PHAjy0LsLTwoUsVQ9MHtMvwIacxCJnipheRggTRbKrZkpwks3
	7YLBb4rbRpThs/xBQ0N8GQXNOw==
X-Google-Smtp-Source: AGHT+IHn+Ln1T+Or+8rEipf6FBTj9dYsfBDLagfJ6RzH15PWcaHs8JWOE9U6BH42Bt5qd0KZn2dp4w==
X-Received: by 2002:a17:90b:2247:b0:2fe:84d6:cdf9 with SMTP id 98e67ed59e1d1-2febabf1a73mr1356087a91.26.1740694952654;
        Thu, 27 Feb 2025 14:22:32 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fea67530d0sm2289741a91.10.2025.02.27.14.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:22:32 -0800 (PST)
Date: Thu, 27 Feb 2025 14:22:31 -0800
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
Subject: Re: [PATCH bpf-next 10/10] selftests/bpf: test_tunnel: Remove
 test_tunnel.sh
Message-ID: <Z8Dlp_8RicAToHEr@mini-arch>
References: <20250227-tunnels-v1-0-33df5c30aa04@bootlin.com>
 <20250227-tunnels-v1-10-33df5c30aa04@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227-tunnels-v1-10-33df5c30aa04@bootlin.com>

On 02/27, Bastien Curutchet (eBPF Foundation) wrote:
> All tests from test_tunnel.sh have been migrated into test test_progs.
> The last test remaining in the script is the test_ipip() that is already
> covered in the test_prog framework by the NONE case of test_ipip_tunnel().
> 
> Remove the test_tunnel.sh script and its Makefile entry
> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

