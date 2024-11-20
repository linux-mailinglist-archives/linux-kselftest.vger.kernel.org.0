Return-Path: <linux-kselftest+bounces-22359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073409D3F76
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 16:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1307282A3C
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 15:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDF414F126;
	Wed, 20 Nov 2024 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Avhvu7/2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E591113B59E;
	Wed, 20 Nov 2024 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732118131; cv=none; b=gvODhrxhKVw4BbT1ta27GvhKK8wg98owz5btilw4pIUScYiIL0wa78t1vqUe0Se49zhJ5JrcOZH7FV2SFc4VCj0tWOjjaOKU/xivwgqPet+UBKMoLFDaQvK8gXw9Rs0APPRbU2BGc7a3BdPoWKbR08a2V8RNbu4/LYOVXQqCvN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732118131; c=relaxed/simple;
	bh=3PG089p3Ex0v2Wrdrf8Lk4pxMtzsNWx7cgErFJHA86s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjtGFKE1e0msyNffQ70gOo/ekiExF6fQv4Oc5dMt6ZX4177iT9nyuEXneY71K0fNUE4xxWiNdjKbOppZpQ9aPQMF9mQB0S8tDOplCKyj3gWZDEQR/L8R2z8GI0PGYI6lVkmKP311sL9MsYbAZG33JicFPZINJjocmInWE/9HVPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Avhvu7/2; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7eab7622b61so1712971a12.1;
        Wed, 20 Nov 2024 07:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732118129; x=1732722929; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=53ZiGkp+LxJkB24OAL7nCI7ecSWvuqL5Z3qJZGV0j2w=;
        b=Avhvu7/2a+8HFY04qknF0WaspF7gUsqeQAnOP9KNKgC13uSTZvigGAMGkopQFXUKEU
         P1hXSWXGHNPdvJnhhXZCS9udM/gIMEvFZSPnf8KmgEllFRsKBmITNnBbbnX3F+IomF3K
         HQWD6gda/JJK4ZleCBHLfzG/GSEZoNEnyn+vj+JV8gA7wuDXdQPTjOp7N5hmrb95ppGS
         s3WEma8PL9tKdLlbJlK+QaDFkPhKyrbsz0PU1GwTXxEfT8aui7QvUD4CK7ls+YpyYkrV
         n2177cq1ZWPSeh1JHdMox9s+hvg42wr5fDCGTUmwnE/hsuo9bCXA6QTElOotEu+JjGiZ
         3Kyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732118129; x=1732722929;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=53ZiGkp+LxJkB24OAL7nCI7ecSWvuqL5Z3qJZGV0j2w=;
        b=KcWE605ScQhd0I95YAy4A/l52GIDXp7QQzaKSIiaBI+C2JpQVzDJnkIsylaMzuqCfI
         Rde5l6c+zeGt6JLnIYreEGbJcE6aK0Ywxh8h8LXHBb0wq36SuM1Rw4nudi07Q5lAI4ON
         12pz+snhYkQbEf9sIK+v78VKQ8J+skOcPXlReu7FccQSqlaAaFNT/2WeVu1ldPeXFuOl
         l+A0ytSj2c4tpr+FP7kWYIesCdemqGoL6Wr9sXvXlD1qnhezj0BQwkRDn5uDDpw6oeZN
         /XONvNVTRCErBLd3UEo0TWvS4EikjR1o/K3H2hi53Hn6dj8NNO/bj0mCD3kLzoeoWg9G
         +nSg==
X-Forwarded-Encrypted: i=1; AJvYcCVCFQz4mk4Ub5VmsFp6s5GBvBI4Oj2/fliueuMUuY0LCZfFggwSo7mkvZjnUUnW45ZMN+s=@vger.kernel.org, AJvYcCVadrKrZ/p6vexboqzWLgFK96UHS+C6/ae7WuawuZ9I45UicTJFg+AnnNoGPXSmNjfmub/qnSKrXFhf0zFS@vger.kernel.org, AJvYcCVe0eOvf2boUm3E47OKEYYP8Gx+Hg+tPzll5+jFEiTHLolkswE9gj1oFmhHoliUmce0uclfXkdu7jHhcyhfn4XD@vger.kernel.org, AJvYcCWg4KAhRhn6Ejy5fpi/Sze4evb4W89nfkgbRSGiaHbb9U/TAYHpzG88xMUs829O91BVKg0SzJiu@vger.kernel.org
X-Gm-Message-State: AOJu0YylvJVBELLXjQdEFwGgdafru+iY/86wrpEHK57VMWVLHxk2BNFr
	KKUZRUCok9pQZmX3G5vOzGzwn/GIIzuv5W9/p3pXqaX9kXxJcSA=
X-Google-Smtp-Source: AGHT+IExsnj6MCpf5hhC2Cwbjg1B3wy76hUf0JGWdA1LY8wf4ob3MW9+JbKpFPwkJNIjVP6kFAXl1Q==
X-Received: by 2002:a05:6a21:386:b0:1db:efbc:1d4c with SMTP id adf61e73a8af0-1ddafd57969mr4719860637.30.1732118128980;
        Wed, 20 Nov 2024 07:55:28 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724befe9a9csm1789051b3a.193.2024.11.20.07.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 07:55:28 -0800 (PST)
Date: Wed, 20 Nov 2024 07:55:27 -0800
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
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, ebpf@linuxfoundation.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 09/14] selftests/bpf: move ip checksum helper
 to network helpers
Message-ID: <Zz4Gb0TA5e3k11eX@mini-arch>
References: <20241120-flow_dissector-v3-0-45b46494f937@bootlin.com>
 <20241120-flow_dissector-v3-9-45b46494f937@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241120-flow_dissector-v3-9-45b46494f937@bootlin.com>

On 11/20, Alexis Lothoré (eBPF Foundation) wrote:
> xdp_metadata test has a small helper computing ipv4 checksums to allow
> manually building packets.
> 
> Move this helper to network_helpers to share it with other tests.
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

