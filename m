Return-Path: <linux-kselftest+bounces-21959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75049C7A26
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 18:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7701DB2DC53
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 17:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B56E202630;
	Wed, 13 Nov 2024 17:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIdry9fU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4702022E4;
	Wed, 13 Nov 2024 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519806; cv=none; b=tAz84ZbfrLa9XHNXyXIpsm+B15RFkZo43NG4iBV/ZJG7hIHFjy3m49t9yY4BzEtrUyf/riSDafG6ZnAlSrOYQwfz0X+VPPo4aHKasHyiev/+H5Cm19g45qIIxpjEAwqLF84n93fv4bYDn6dZvekv6tGjWrNvg8BYPs60hSnheYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519806; c=relaxed/simple;
	bh=ppk0DUXZE7SCkPcT+d0mwFpKJ2BW3fnSWS8UBzFdzy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1R2TSoTLLhoCvq59t9lUIvoRZVRblzAYo7B2R4Ef2QjEr0ms2iTMk4BQQzJ8+RnOXJTvxUFoV2rITsmNlx+r68xVYBMyCxaVl9H9W2crFQ2qh0tnU6MSmWaIXjmezAljPlVpS9zI8+OP5gUpI4bUI6bHJVO8nmnoCv9aPjrbgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIdry9fU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ca388d242so76400155ad.2;
        Wed, 13 Nov 2024 09:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731519804; x=1732124604; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BV72+3ZpwcNw1vtM04R974G4OSzv6JXyNQR3jeSSWck=;
        b=kIdry9fUkyWLFsCJ8ave5y8tSwIg7i8t78J+TznDx+S/2BXNvw1mKMHfSx7+0kIrWM
         IRcbZ5Debd77ivEDPKDNJf9qXlQBzvniXmj1KHz1IGys9MeIezs9dHKnDvpgbaeEDm6R
         4CnZgmqswksrvGQMGkDHQJGctL18lb5z0ajNrz8pCWs5Blr9uD30omtaOqG0s2J7nDyr
         gOwlXSHztUvt0W97wQpEgA/HFiaKy18bfjrnTebBMkTdUvbC8qooMfbzHkyMBcqjwekM
         4bBKtiA1cFYUntBeplhrzTrXyd7N5iYXwn82XNaijJmzqbui6KPnQKGgaFGI6fZ9/Llw
         dVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731519804; x=1732124604;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BV72+3ZpwcNw1vtM04R974G4OSzv6JXyNQR3jeSSWck=;
        b=ReJmhoIbAqU0Ma8J4Djg7tYZSh3SltdZFKK9u0H0gMO5DZVX+bijwlswpl98uko0MN
         32RiZdUpnXm97TBfBlngHb6KxM2Inbdf+aqpSUQ/DD7aPOXNlQCqc7UCa0LU4Y6mPcsy
         iWX3fpbBFe5Qr0O3hM4TWLG9Am3FpaaNcTov+iX33HjTzpiAKlS8P1cJ1Hxyk3IZJK1g
         lezqtVByWh9sgdLkBplHCvniiuwFdj7cZaZQ/s3gBFppmBkMKUIo4T2Kpa295vwttUnL
         hzd0vQcBSJVG+jRyWDNJw2cudkMaCOXjCI7LTwHjX3RUwTstALBgfEBVkvSTIHMaSlST
         eaPw==
X-Forwarded-Encrypted: i=1; AJvYcCWGz+IqJejnYBYsumDhUKQqCitaZhWzSB6wZWvb6llLtKVnJLIBUxuK/emURInY44bwKGhfiica5ovau01d@vger.kernel.org, AJvYcCWKSOzChZ/GVRykBGhYRsZ8T7btUxAZen/4+7Rl215tj9+TrCCohbCJT6lEHPXQy27zmCiTpDAXG0m33iK/HlFQ@vger.kernel.org, AJvYcCWNqyyT8cPvFKLF56lE1n+rHynhOkFecrWaUdi9LBoLwbDqaUslc+emNdjmh0R8HbcSpSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0vAES++02K/y8auSYOq+Rg/blDuX9GV0IVUD5JNyziM2y2ED2
	gltI4R0BKZTXW/H6kRCLWp8P1s0d8HNpE/zCpzqLbjABrXFaHnk=
X-Google-Smtp-Source: AGHT+IHPEWWm6okD4vlePvfsSz/17eemiZD1ccUkGYCho+wfOQkSzsumZEda2hVkg35rk38M6YSOWg==
X-Received: by 2002:a17:902:e84e:b0:20c:774b:5aeb with SMTP id d9443c01a7336-21183d1024cmr280164975ad.3.1731519804314;
        Wed, 13 Nov 2024 09:43:24 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e70408sm112206805ad.260.2024.11.13.09.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:43:23 -0800 (PST)
Date: Wed, 13 Nov 2024 09:43:23 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Alexis =?utf-8?Q?Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Petar Penkov <ppenkov@google.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 05/10] selftests/bpf: expose all subtests from
 flow_dissector
Message-ID: <ZzTlO04y8jyZxIm-@mini-arch>
References: <20241113-flow_dissector-v1-0-27c4df0592dc@bootlin.com>
 <20241113-flow_dissector-v1-5-27c4df0592dc@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241113-flow_dissector-v1-5-27c4df0592dc@bootlin.com>

On 11/13, Alexis Lothoré (eBPF Foundation) wrote:
> The flow_dissector test integrated in test_progs actually runs a wide
> matrix of tests over different packets types and bpf programs modes, but
> exposes only 3 main tests, preventing tests users from running specific
> subtests with a specific input only.
> 
> Expose all subtests executed by flow_dissector by using
> test__start_subtest().
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

