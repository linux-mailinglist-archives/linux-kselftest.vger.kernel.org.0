Return-Path: <linux-kselftest+bounces-28072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA248A4C594
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 16:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03139166413
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 15:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462A721481D;
	Mon,  3 Mar 2025 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxUnxWEz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D4713D8A4;
	Mon,  3 Mar 2025 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016863; cv=none; b=CbGYe65DGvrIlXnzcTGvzOEQ/6ZNBk4qNYoWCfyihsqoBl+aG9QNydAZlUF/tF28FEBFh8JQwl7hPIY5wsCV5a3ZDYKJD+5EV0YiP6/o7DIkAigHsC3e18mI/ysCxy42jJHtOkBqA5QOkCmtns6szmMJnVP7ryCkgrPNO1vr1CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016863; c=relaxed/simple;
	bh=PIZqjGL+Pfv8uvJR8VoObmdmvwZoXftcIS5O93eQd20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flOsOZ0n9G0R7CkJcJwVDohevZNSN/uODizMB+LwfmZh8bsopuQzZyeqeCEWOGJcAMqnu0zfVq38MUyVIttHe45lfKtDhPVtxLBN7aEzOoi+TC6nxqF3WEib+T1FvXxsR+x5z0eODfLF0B21IpVL/rVxbG69ZinJcG8r7rkA3M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxUnxWEz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2239f8646f6so30458745ad.2;
        Mon, 03 Mar 2025 07:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741016861; x=1741621661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NWupMrUF4OTp98Zc6SnT73bTuQIdxbbtilplurqymKI=;
        b=HxUnxWEzccllFmPeY+VjipAUO4hK1Le3kFXHQNZ47me9CTWoievwuMcpvLn47AuHgL
         6AVDFceWmfzcIg+YasM5JUljLBDeNctrEnT16Xok1eE1s1q39j1JRrJGHBa5LZYARNu1
         6BheGPKMJ3oFeBI4NRL37WpxBK+jkl5JNgOrv2kCvzfmyHgJ3RQ2i0r7oq/GwJ/OKgLc
         1GPUcgXCmdCh5t1ZZCJrlbjewiKh/xBNNUbcg0UwamOtsnribyJkil1ll1IWPxxNruq+
         +aN7LydYwDvn4RmAteEsR6H4IJwBqNstd2MiD6jo6SRGRgHMicCPtL8ffmvNdNzAPXM7
         NmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741016861; x=1741621661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWupMrUF4OTp98Zc6SnT73bTuQIdxbbtilplurqymKI=;
        b=semrX6rxvUoVxWVHMbT5KJc0Snk8NVnk6GEGH66xJV3SCObMpmcYPda0iQ4FZQK3gK
         xhtwS7O0ZVmDDon1SRAd7z4m8vqJp59wBYizmrcef8Ket0aH2Pbx6BlwxruZQSwbQd9c
         bSlqQiikg2Y9qpAjBTiJc/5NtgqfvGp/SOX80qnIzM2uQYd0pFupo6npdIuHN3Zyx7Iu
         szT5iz9jZ7jgghk7FPTt1B2o9d/1hFVKlzNn5FLiFD4MHpuaKh/ACeyA8+t3v4hujf3T
         5nidOcfM+S7qKoIfLa5e09K7yCJVsRY8dvGBBPd5NfNa+Ojs6LjS6WS580FpBjEutTNh
         kjbg==
X-Forwarded-Encrypted: i=1; AJvYcCUsnhy4WzSO89zM6chyJPV/MQOljHYv/ho/HxYpArBzYfRsonudW07ggYZ/DkuuXCiDSyF2cyCoHh2RN0em@vger.kernel.org, AJvYcCVdjQ98ISZTIVhUA3fMRC5l62JX97k8Mxhou4sQUFlIB9uJLSsno+iAZrDg/9z9QLi/+6M=@vger.kernel.org, AJvYcCX012OxfWyLS8LM6WSwWhdIh+NOtzctIGmfhYcA3kF1Hw/u5ApE8c/P9le9x5qmlTs3MlL72e/lP0vCQlXE4qIk@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq3FghLVJXQZ9vH1dj/y3CWtUuETL3yvWTOamCpK+zdgWdmyIb
	y0T8jXC1uyDEVi7V65rNXMXH80qkEd3maOnuRQMR5bPpPKK3QJw=
X-Gm-Gg: ASbGncub4d5w0pkMIDAoe2oStrwBDr388JChKg820joxU5eiFza+tWFQrabyeIxxpCV
	dfzVkEMF/1J8fLd41Mid1FESUHDcio+qnSy0kDM84SN7c9weZ4VRDJ8jEmM2DXc+PvFh8UAtjrs
	kr9NNPgLi61WODmynslNAMIn2rRaPf2wnqE8H2SkjZ990nbMZPSVDLbMzAHX6NhC+yfKhux76at
	WQOrHA8puHfduSy+PJEEAJ+VJ76dzzs093uWpZTto6SW3gti7EI3O28YMm+qyxGnpjr2uWyRYc5
	crVqbGJW/Fowp4UoYHOQPqfp8DK+Kkl0xFG4Yb2QeA0X
X-Google-Smtp-Source: AGHT+IGY8dXLSgr9+Pw9SQ/kf878QkUqdbfyKRzGrGQ3BYMolGFvcHxqKSgE77A52y0/9OJ8JjKUHw==
X-Received: by 2002:a17:902:f693:b0:223:4985:9da with SMTP id d9443c01a7336-2236920baf1mr186740005ad.50.1741016860964;
        Mon, 03 Mar 2025 07:47:40 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22350547cddsm79317955ad.259.2025.03.03.07.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:47:40 -0800 (PST)
Date: Mon, 3 Mar 2025 07:47:39 -0800
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
Subject: Re: [PATCH bpf-next v2 04/10] selftests/bpf: test_tunnel: Move
 ip6gre tunnel test to test_progs
Message-ID: <Z8XPG0PDt1gO65O8@mini-arch>
References: <20250303-tunnels-v2-0-8329f38f0678@bootlin.com>
 <20250303-tunnels-v2-4-8329f38f0678@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250303-tunnels-v2-4-8329f38f0678@bootlin.com>

On 03/03, Bastien Curutchet (eBPF Foundation) wrote:
> ip6gre tunnels are tested in the test_tunnel.sh but not in the test_progs
> framework.
> 
> Add a new test in test_progs to test ip6gre tunnels. It uses the same
> network topology and the same BPF programs than the script. Disable the
> IPv6 DAD feature because it can take lot of time and cause some tests to
> fail depending on the environment they're run on.
> Remove test_ip6gre() and test_ip6gretap() from the script.
> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

