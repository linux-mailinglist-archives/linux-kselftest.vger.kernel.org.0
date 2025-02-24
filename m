Return-Path: <linux-kselftest+bounces-27363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35236A4279A
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 17:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D03E3B8E06
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 16:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9804262D03;
	Mon, 24 Feb 2025 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZDFCu6+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599CF25A656;
	Mon, 24 Feb 2025 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740413427; cv=none; b=fN6x6uBTP1CqDzzl3xZjJJsyjdqmwWx02Je/LYOQMFHSViKenegb6priI/uT4aP+pRPHWbAsgtyCKsPVxLWiNy5uZGcsV+krVyuMczU/lo7Tv2zmaw7yJ3ZN93l7tQkH/Kna9KEwR/4v+zCKzWrx0PK8pV6ZpJi458d5+lpdUw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740413427; c=relaxed/simple;
	bh=jNcE8AQZhOVPhvrA5Kk3kZjmIrlRPqfksmrkDKa4r6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UE8avOKjaKNhrFvk/bQRYBIqIm6roDJb8eHNK8nGr4nXqvLYcqvANSfGEb2QJ2qKIXztuSL3eccQYrHmcnM8Ah23W/q7XCseF0iMuRrTZrLq3fyYQZhjFy9BP6oGLpUeXk8d66NDmuPNLxMNuk+dVhQgi7LH0Fb5S4r5qly3LVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZDFCu6+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220f048c038so86945345ad.2;
        Mon, 24 Feb 2025 08:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740413425; x=1741018225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N1TzpsdcC91Ujb4ChasLI7EwLyVk7a9yq3Bu4FlOXSs=;
        b=JZDFCu6+hiOJL1MmTti/ff6/lfBkUcVSua1IxsDisTXY0zTK7U5ko802Yg+4SSq5an
         v+ngiBk0jm7gO3HyAax/qstyT+vijHyi1MB0lODFTxmCB7LBtookqsSIReFfzmCWM4wZ
         YPDF//SD5usf9lhWAaGWoIfck/oUYws9vTffSsAA3csZ+Y3mE5ukU9vXrM3dP0/X2CGm
         /K4i3OcLMpnpDSKs1pZUVsh4eFHIlk34KpCqa1/+hsLukxDsPqRPbWc16Phe93+EhLYq
         sz0FjtgXF0J9GhV0SZMlMFtPtRPOhUlYLp4d9wXLhwf01yOR22EhPzp48ke3coqmw5LS
         07vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740413425; x=1741018225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1TzpsdcC91Ujb4ChasLI7EwLyVk7a9yq3Bu4FlOXSs=;
        b=D041gu8OHgIge8U2PBNCAO0Yl5tKDMkGR5WL3MBz0wil5oWR0h1IRrPUWqjUBpZrys
         jZ528klpLCcl4gh+Jr/nH4Aasc520SlbnYwd1VC6aImPUxdxfjILIktyOB2yMaliLKnp
         bdI6pWVFKs3zn6/uro2FYB+e7WNq/KJNzCNq65N9OLlncD3zzYWuN1iCfuKPk8OKS8gS
         GflLfviTWShG+hpeA62TYyMYUnf33Z8W/WEZEcYdGEVxrbiZGMnn1yhoyd7c/6x1YnAC
         YEo9RBSkU4WC1j4llcanLJMToRzW5uWJpQwdm0cMRSANf0ZqHeqTy3ZtLBGIqXNtA9VV
         /Q2w==
X-Forwarded-Encrypted: i=1; AJvYcCUHyGP/IbYGHC4x3l9hgidN+YSWlHs8at+CxH5yRHPJSSYpfAQQaHiWELUsA64GbNhEh1Pp4MJ8+0slDT5g@vger.kernel.org, AJvYcCURs2/feiRxPS6yU9e4uqwAAA00sDeen3HnYh9Q35Sjr9tf3hMniIrkbw/s9mpUwdo1+Nnyz+7b@vger.kernel.org, AJvYcCXP/EeQzCeqXVKZyV0WrZOn9oM/ICjWIeM08HIu/F3TaIYVLivBbschj1wTsuYEJ0tX2L0=@vger.kernel.org, AJvYcCXxi/7zkrg1GzmBiXke86yC5P3YlMaJsA4MrfXnAZnk37qVQYtlXth9rbLzhE6yq74IJRZ5Br0AZKW3+tWmy4FB@vger.kernel.org
X-Gm-Message-State: AOJu0YwnSPYhU2ZCzo7oL1yLA5uhetiEtef4qGY6S+DoOWq1eGqlhqE/
	Sm2ibe/0kb6waqPxpyydLDDkiYhOHEGKNOqknByR5uaW7+e/s6Q=
X-Gm-Gg: ASbGncsgLQQ+QBdwUMLZVdfG4cuVvCTfl4i84bP7F6QtsLJjJ1ec6jpHqPUSHOsm/CV
	AQSFW4jieIB26H0PyX9H/lUt3QJXUqcOgy3F+h3WgFdXuVjpANdYP3AsT3oX8sOtLgSKCk3Sp/Y
	Df/p4bwuozu8Nf+hiLlFbdWVVngP1RQjOTdpIbn+gXNoYGEjD/vPWtuyLOpPBXhrDcnpVbS6cPj
	qdOM6xuytOrNyUtBMH8B+STj42fpTzGu47Uk/Im0DuC0ihF/JQn5ZEOpOKh/mqjRMSua3kSV/sJ
	vCm918T0CxzKXEx69f8ajoYsSQ==
X-Google-Smtp-Source: AGHT+IHP48YdbTjpE7DUXRkAHIDByL8gUau0YwX5P63iNmlBr5Pv0mUImO5v1RmPA7bpgI/WIbHYBw==
X-Received: by 2002:a17:902:da91:b0:220:c143:90a0 with SMTP id d9443c01a7336-2219ff600b7mr271465225ad.24.1740413425279;
        Mon, 24 Feb 2025 08:10:25 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d53491besm182768115ad.14.2025.02.24.08.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 08:10:24 -0800 (PST)
Date: Mon, 24 Feb 2025 08:10:24 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
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
	Shuah Khan <shuah@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/2] selftests/bpf: Migrate test_xdp_vlan.sh
 into test_progs
Message-ID: <Z7yZ8OxdisKbFYBi@mini-arch>
References: <20250221-xdp_vlan-v1-0-7d29847169af@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221-xdp_vlan-v1-0-7d29847169af@bootlin.com>

On 02/21, Bastien Curutchet (eBPF Foundation) wrote:
> Hi all,
> 
> This patch series continues the work to migrate the script tests into
> prog_tests.
> 
> test_xdp_vlan.sh tests the ability of an XDP program to modify the VLAN
> ids on the fly. This isn't currently covered by an other test in the
> test_progs framework so I add a new file prog_tests/xdp_vlan.c that does
> the exact same tests (same network topology, same BPF programs) and
> remove the script.
> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

