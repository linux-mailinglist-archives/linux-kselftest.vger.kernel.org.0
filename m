Return-Path: <linux-kselftest+bounces-27809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB5AA48B45
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 23:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 200737A7FBD
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 22:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E44270EC8;
	Thu, 27 Feb 2025 22:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKIaobaK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C6E14EC60;
	Thu, 27 Feb 2025 22:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694764; cv=none; b=Sv9vZGXRDA65+X5lMsQHD5Qnrndqj/ZO1lDr0XROVaKepjN09AM7TlzSj+U3Q39lyi4jYh//bC9O1k29G+bIzRYR+ceEAEbtXLCe1b+ilvdhE24sYY0YB/2QW3afV1142LSP6FgwXROdqPRd+8lNvoY9lkVSwb4X2jO+Hcql0t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694764; c=relaxed/simple;
	bh=kJue5qF1O88thhWiBUhTAkc+0gerXobM1xMG5TfadMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jf8BVjjryKTMfkSvjZHIQhmHd1B62W1qbVzBiCL7hbsy7XDk0o0dAb0h37TdopPRh3X52hEPoxasr8dm6kFG6QmVaDNA0SoO7ECnR3zPVEE6bZmNixLLSDJaC2aW+ehDgvaqnwlq785wENQKsFUOX3TqqmzDj4F9H7zWIxM24FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKIaobaK; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2235c5818a3so25551485ad.1;
        Thu, 27 Feb 2025 14:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740694762; x=1741299562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FuwHNr64To1YZr/5VGQMiVziw9gpIJwT9lA0paNQuxQ=;
        b=XKIaobaKV7RSC8h+1FclPQsl5jhbY8Oqs4fNZnrCise9n4eNzpOj49FPnwGa0+bDtG
         zeKjDLQfeV5nGr81LZFQi1Dh0zAm22h3Zhda0zbRlltJXobbvKgxC5ek84sWSCKxeocl
         9hbU9uhWAwIS8f6Zf40FQPPVMG3viOMRGOtwK9Lg8CbRx/GhNzyCq8TFdEuhGqT7wj3E
         yqlULI6UkjktQN5aKPfdDgOq6VAbIOHGStduJ1qSssuGuX9MY8lQn36uL/iejlPnl/c6
         J1RR5kMbuFnpi6/JYGSSHCoSGBsFg8bMep7rXGLHHUEw4h3999U8OPhdIhgwa4+HsYUF
         2HYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740694762; x=1741299562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuwHNr64To1YZr/5VGQMiVziw9gpIJwT9lA0paNQuxQ=;
        b=syuZoxCj1sugvgwcamnZj7ckQWmj1EBuZwJTzdAfQeljbdEXJQexviIvR7QqMitLCu
         IUJNmyoZ+ixWfU2/ahvFYCSvyQeQgKdapRItU6yJfEKnVrLQyAJgaVJNeSXbZfjHXbEw
         0kvqwdRAXlzhdKskrsT81EPk+rpw3GY0RF3OEVdk+Rzn4bZB8ccdH9tv2x7u58KhGLju
         CDwWDjGfgm4akfRwgFKFYMp4OAaUsKhLQZ56fjpfDXCXNIWyp70jf3YqESLlGkKssfd+
         FFFgHiMei5jJjbjSho7C/IqU6V9s3xVBVuClBtEkkTDg/knHn/VDUSQx68yvt8L5Ubxq
         Pygw==
X-Forwarded-Encrypted: i=1; AJvYcCVaDVH58qODY16XPTkThzS92Au7W3c/t1OaI1kzq0pn0AGf0yEuF/9OQ6Zz5qEJ8cif6a8=@vger.kernel.org, AJvYcCVyOrhnUNgkd9C60663JG+zFTKqoIxoq3TMbwLsoPsXDsWaG5y6iAqZu9/blUODH0sPiA86G+e2K8t9u9//GmkE@vger.kernel.org, AJvYcCWYfAQ8ifhtBugQODHNHowyS9qloLxPv7k4bBenZ7Y2wdHQAoPy+u88LuZ231JOLkpN1EqrcDdZPRMMhi5H@vger.kernel.org
X-Gm-Message-State: AOJu0YyVHjf7/Qcv7xYAkMXwsIlj7O99FEVTSy55ZTtvwLObMS+hkm+c
	uHJJC/TswfasE980RQxyGQn433qzaoUOHzzSPh1cuPt57CZ0JbZpTB1a
X-Gm-Gg: ASbGncsD27/Cy3whUYkf1PvSLrvuWEnlk8VkAY1EqhcrjmFCp0aGLVLLPCQjQEM+fLu
	0PAylVFLorBXJ4gHcMrowNnBH6jiW8ZMkvQ3sUFUe6duKvdVZeryOmKkUd2+iMzCzEeiiffMNFl
	OlygKVT9Bl+W9m2B0xmBXGMf6eGX2ddb3X57kas24xYCbMVS2nZvEr9LdlBBxBTLF9eyf3b2hdc
	DbCRHJqZh6Lw3kHmwJNtkyCI+LEhGkUDiJ6UqRXC4zoGAcvLBcfDd/zhT9EJQJUxeVjjPfawB6V
	YTvA01whmxL2CvVdojmkIaEhIw==
X-Google-Smtp-Source: AGHT+IEtI8fug1hP9HPt5r1Vl4r9sfcw7d7kBuzUcBbGpkCMNoZ3emli/QVrVjGm4odETnprb1P7Pw==
X-Received: by 2002:a05:6a00:4b4a:b0:732:5696:51db with SMTP id d2e1a72fcca58-734ac429836mr1722643b3a.24.1740694761231;
        Thu, 27 Feb 2025 14:19:21 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-734a006010esm2323498b3a.179.2025.02.27.14.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:19:20 -0800 (PST)
Date: Thu, 27 Feb 2025 14:19:20 -0800
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
Subject: Re: [PATCH bpf-next 05/10] selftests/bpf: test_tunnel: Move erspan
 tunnel tests to test_progs
Message-ID: <Z8Dk6NuryDiYm1nF@mini-arch>
References: <20250227-tunnels-v1-0-33df5c30aa04@bootlin.com>
 <20250227-tunnels-v1-5-33df5c30aa04@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227-tunnels-v1-5-33df5c30aa04@bootlin.com>

On 02/27, Bastien Curutchet (eBPF Foundation) wrote:
> erspan tunnels are tested in the test_tunnel.sh but not in the test_progs
> framework.
> 
> Add a new test in test_progs to test erspan tunnels. It uses the same
> network topology and the same BPF programs than the script.
> Remove test_erspan() from the script.
> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

