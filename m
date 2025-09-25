Return-Path: <linux-kselftest+bounces-42289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01855B9E80C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 11:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF231BC0EC7
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 09:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4E928489A;
	Thu, 25 Sep 2025 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LU6oAXxM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BE2279DC9
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793870; cv=none; b=F0jmlaDORvmxX2YZ9qi/+wQnIxj2aODhbwDJMNmFm1k6cO9QKvQoIWOtoUYldQWxPTLmDVUQK/rXbgqbRg5kBNxSqmmYZpL7FKEJTB2Z46awBbfhmaROwBbV0mZXD7qPke+xu+6yeiZkoQ0T98nGjmmGNtIbrJhhEgQyO4hGpnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793870; c=relaxed/simple;
	bh=ZmkFbEfQivCqBMVs45gL6yXtOiKwXDMn9AvVAlKM2NA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cAGDmZYuuQm5J35JEQWvpyGAA0gLS+zVkDV0bzzck6RY8J1oWyGLNcm8BgFuGnr4p6MKe73byDIA8JICQrQOTjeapbF/hSEFcXOAGBRWF8PLEIdBeoCoaSrdWuVAQn6XjsSTAxfIO4kM+jB+xlkLQ7TzT8CzkeKxrfE7piPqiRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LU6oAXxM; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b2e0513433bso129586866b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 02:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758793867; x=1759398667; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmkFbEfQivCqBMVs45gL6yXtOiKwXDMn9AvVAlKM2NA=;
        b=LU6oAXxM646knKdDRetHDdvY5uXOb4M4EZgpP8OGwWE5C5MTxEB/SMWkDEpO1K4WXU
         peE6mvythlUU1n6naOwG9r0orSbpuEn5pM7wOOIdJYTM9IxUNWeS+E7Bx2LVA6CwQ+Uv
         ZC00HEdLuz90PmjEf0YdItWdhcNXN6xpANEXnChhMndyO1JJiAZEfPUymK/GBIiPvObO
         7YaYlZFrC4zBQTEfcv2fuNk1UcsyE3+9GQApNA+/ual1fCWG8fsGOHMNbvGLjVFhY5F+
         5Fg5ToleSGmSB6IyYPql3RFwYnondio1r6BuuHmuPVoTPZJ6P/TX/a8MkD9wRz+KFCZo
         agaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758793867; x=1759398667;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmkFbEfQivCqBMVs45gL6yXtOiKwXDMn9AvVAlKM2NA=;
        b=v6Qqj17lLq+dRVVtBtxE00TuiSGIL1Z1YeVbPtG6vNjlCKhs3N8/tI6kHN8x+6nDzN
         oj5gV0VL4w9cgiynG3vK2XS74AOsaIZVZ4DsEqTWvHGkXZUleJtgPX/AqrJBLd4iqKXl
         tVEiHgpaJJKu3ItMNLp235ReCwd/5SQaYkImSdgtxhGgGgki2+AuobQvFMhbZgSnozmc
         C5wfZLT0/HO5+rSEBBrnx6tB+/RHGzGXDVnUi2I8VM9S6DwWL0GbdmvaqCAxsX1jr+l/
         B1HPVjhLa/vIqoSIsuqxb/D5cbpwy4862sAMX5z/GvUqvmggZ+LaJ9uKHWx0ZKDE+rsD
         /ioQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaEeXSRXEyoEh8f5lEZ4VwwlphMUgrP9hCkbhp0Y6z3dJ1Y8tr4VidVDYn+Wwtn0Crf/0d0QYRzYOMIyjVvxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx7VgTesCQ/eykzepiUic1O2Ux7Q0gG65ZHyVQrn60sdlAcNwG
	UeUPtlnp0AGttQ3OXyhfZWyszryraSC47KkjWRKhFzSoXuhmoPIMr44wzhyT+q89Fss=
X-Gm-Gg: ASbGncsM4qlbvZVwyXuVi24hcxTnLe4RkjU1JM5Ere6TZDGyWFy0Vlrkj29qmP7XH7X
	KE5nwOgcl+nrX3y6yidj3yOExHh4+A5dEKG7FOYzfeNsfHk4RWAKY+gTl34CM9jz2IRSpFuDvpM
	IVnHlZKGEI+tJEylsJ5heC+x954lFCEa5zUQDV2DYeeXkSuk8873ibnys8I8mZWWQeMrVTogW5n
	o1o8JJ9vU9+IXsZs9Z+V/TyS28if5XswsBM/9aagJ8hiz2d7UhYZOyVVYs/zleRw5QotVKiIi1X
	3el6dJRikQ3yaFqPGi8cdlgYi4x2iO3+WwL0y0IocdJTb74pSvEIPddvIF2Y4hfGlzEWUpsPXaS
	txH01R4hvzuAWdMQ=
X-Google-Smtp-Source: AGHT+IGEVGUv7B9GwkQ2/AJ6K1sBRZgNTUuhBCswgHVtL42XXaKHIxqK5bg7kju7asdvwIL8eCRs8w==
X-Received: by 2002:a17:907:1c8d:b0:b33:671:8a58 with SMTP id a640c23a62f3a-b34bd440633mr294373466b.37.1758793866605;
        Thu, 25 Sep 2025 02:51:06 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:295f::41f:5e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353f8686e6sm131994066b.38.2025.09.25.02.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 02:51:05 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,  Jakub Kicinski
 <kuba@kernel.org>,  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Simon Horman
 <horms@kernel.org>,  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Jesper Dangaard Brouer <hawk@kernel.org>,  John
 Fastabend <john.fastabend@gmail.com>,  Stanislav Fomichev
 <sdf@fomichev.me>,  Andrew Lunn <andrew+netdev@lunn.ch>,  Tony Nguyen
 <anthony.l.nguyen@intel.com>,  Przemek Kitszel
 <przemyslaw.kitszel@intel.com>,  Alexander Lobakin
 <aleksander.lobakin@intel.com>,  Andrii Nakryiko <andrii@kernel.org>,
  Martin KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  intel-wired-lan@lists.osuosl.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v2 0/5] Add the the capability to load HW
 RX checsum in eBPF programs
In-Reply-To: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
	(Lorenzo Bianconi's message of "Thu, 25 Sep 2025 11:30:32 +0200")
References: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
Date: Thu, 25 Sep 2025 11:51:04 +0200
Message-ID: <87bjmy508n.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 25, 2025 at 11:30 AM +02, Lorenzo Bianconi wrote:
> Introduce bpf_xdp_metadata_rx_checksum() kfunc in order to load the HW
> RX cheksum results in the eBPF program binded to the NIC.
> Implement xmo_rx_checksum callback for veth and ice drivers.

What are going to do with HW RX checksum once XDP prog can access it?

