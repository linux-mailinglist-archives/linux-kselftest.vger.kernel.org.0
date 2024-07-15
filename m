Return-Path: <linux-kselftest+bounces-13758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB78931CA3
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 23:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85840282DC5
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 21:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3CD13D8A0;
	Mon, 15 Jul 2024 21:35:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6F413CFA3;
	Mon, 15 Jul 2024 21:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721079321; cv=none; b=GbLFdFOjOwHmuGkQWiVlQTE4Jfny0HsqnUaYADH90Mw2krOO+BHDv+XhOuxybQ+ulNM/BCovGejaid8DTwqQfib+qxXn4C4naq0xpkidlaNAqssy3krT4b3LnHPYBrncgav7N6mc5g6XhS9IxiqffbfPLrYzCTe2cWAUxnKpeBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721079321; c=relaxed/simple;
	bh=32qYmHyIp8QMfc6ddW2c9iP5wrq8oLvXg0tbcevTzEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5NJbTc4bFt2GZrJainA9V2ajrSdL7OyhEVjS+M8hyDHgk4UEQ+CCatpAzPetsk3euVvbWdOCs6FDacSKmTKUdVQCGfC8+XadW7LNxxMLV0/Gvl+TsabKCsPjh2gauEF/49aBHebVbXZBJVR8QKEwWQgT8JPPVY3I8Yl9QkwBtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fb53bfb6easo31444385ad.2;
        Mon, 15 Jul 2024 14:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721079319; x=1721684119;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OotDTj0wsG1E/E62Kwi88XqlpHF3B7vjq5oagD+5Vbw=;
        b=VEuZ1S0tWvJiIMki9uXRYIII/DCFkSK2ND0uoIhd+KIPFisaejeRkUZ5J0OmLVUCqF
         kXo5D5D3VV4YUrduTHFYczUFn/uwz/0SPUc6KqFbiWKcLW1zoT2DEsnXZaJ6L0cZrVB8
         NfQsHhCcDCm5vGtFkvzNDDSvOf+CSO0IdSsIfym+3D9l9QCwXEFh0OM0UI+bA2P8NKQO
         O2ZUsmGUPUmJQ0gepqeyhv5kIQbA9mNRW5Y4WNKn6w2wyx7lHJrAGamDNqUoj0KGc5Yt
         77pBP8IWw3btgDL0iudOOxG2RAhnMDF4YVy2pEAnzlXxRttSotl+hYL4UHJb9yFxt4wd
         2dEw==
X-Forwarded-Encrypted: i=1; AJvYcCW0o3rZX62IgqMP1ST6KWrBA/JDgaJXkGDSQ+eNwwTq+lJ0gvL7UtRcBhlb5iWYqI9CrapzvwXsnAlCyIIBY2cGiiyF4XIeHbqXNXJ3QHz5cOYUpuU2Rv00z5Efl5h4HUHNVP2UHpN6/IKNV186tvhfNPIiVHOPeSVefMlnbRWVKH1m3mWRQQHH9LoevUFFuYgge1XIRKIgRoQn
X-Gm-Message-State: AOJu0YzRM1t7Z+2gEit6YvtaemSnjFklvtF6pX15MYhiIN2faXFYzh3Q
	oWg3hDBdzX32Iv+pVZEj0cH4bYwzv793tTzPXTklo3oO9A9KyDE=
X-Google-Smtp-Source: AGHT+IHXzF2zbiCUWAgw/G+9Ak+eoVe7Pz3FnXphvUuu/6dG1mUgnDx9+AqzCGAnSEgP9t5S5HAZYQ==
X-Received: by 2002:a17:903:1c5:b0:1fb:7c7f:6458 with SMTP id d9443c01a7336-1fc3cb5bcc4mr4142335ad.32.1721079318849;
        Mon, 15 Jul 2024 14:35:18 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc5cd92sm45538395ad.302.2024.07.15.14.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 14:35:18 -0700 (PDT)
Date: Mon, 15 Jul 2024 14:35:17 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Alexis =?utf-8?Q?Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 0/2] selftests/bpf: convert test_xdp_veth to
 test_progs framework
Message-ID: <ZpWWFRsB4tRBP0mD@mini-arch>
References: <20240715-convert_test_xdp_veth-v2-0-46290b82f6d2@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240715-convert_test_xdp_veth-v2-0-46290b82f6d2@bootlin.com>

On 07/15, Alexis Lothoré (eBPF Foundation) wrote:
> Hello everyone,
> 
> this small series is a first step in a larger effort aiming to help improve
> eBPF selftests and the testing coverage in CI. It focuses for now on
> test_xdp_veth.sh, a small test which is not integrated yet in test_progs.
> The series is mostly about a rewrite of test_xdp_veth.sh to make it able to
> run under test_progs, relying on libbpf to manipulate bpf programs involved
> in the test.
> 
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> ---
> Changes in v2:
> - fix many formatting issues raised by checkpatch
> - use static namespaces instead of random ones
> - use SYS_NOFAIL instead of snprintf() + system ()
> - squashed the new test addition patch and the old test removal patch
> - Link to v1: https://lore.kernel.org/r/20240711-convert_test_xdp_veth-v1-0-868accb0a727@bootlin.com

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

