Return-Path: <linux-kselftest+bounces-13328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1270292A9AA
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 21:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3D7CB21960
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 19:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64C31474AF;
	Mon,  8 Jul 2024 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzsWfJja"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED592746D;
	Mon,  8 Jul 2024 19:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720466132; cv=none; b=KkoFC823XYV+QHW45i56nLSMiSkqXUD64360Hcf1jLPGCmHqLbR6V0VbTpjMHysqlaGT61jbZsZUVcTdreXBMoO457P3VwEVLLzx4/H0yg1HLFBDJqO8oFbhF4t+Pev66R+21TMNUqF5l552o1vjr9zX3oLwcLTKyScGEddVYBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720466132; c=relaxed/simple;
	bh=fn0U/l2dQ/PfMel/szZ9lgzw2lv/XzlCi1aThG6yYc4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sp0N3G1OlPBKoYJPpgfd6mdZnVfksRvC3flfEVG/hqcx0j9OyoNuCzAXguR1veGeyguMHPgI44OBhn8+8qITlTvf8QtbzUi/saXvINSQG/OSYoUNYVGyyLLXbQ99QzZU/8f3PVvgxrWTapk5yF8Qagv7qrS/PadmNasiiogdus4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzsWfJja; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-75c5bdab7faso2330032a12.1;
        Mon, 08 Jul 2024 12:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720466130; x=1721070930; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ANaO/6LtermgjT3FpT+Oe/hJ5QqBspkDVOh9FkiPDW8=;
        b=BzsWfJjaplonOzYGDBhu/XZQZgID/TRUjDUa0ILR4r9JbpdlE0EaGvdm7dXTpqP7h1
         r4wyhSTUlZuc6wtpJAQM4S5OzkidwHv0NnYkLtIDvUgqO6xTbHFJ/9/OQXgCNSooqiYA
         +rmefi/7aqVJmkddzYhvjQjFEyzHx4h/P7WFM+PPBTpa5ARma+zCmbSJDqG3O1y6vkbH
         dNHon5ILSESKY4T8XAZR6rndADb+qZoO/3vfMzc2/NbMk9fXCQVPym8jWV5icZpu74bV
         hjY8jkqjCt4vapgHLDyOviJLpIe4fXVqLDKpbg33EpDo5tCb47/u5UswqBx7uYPr+I2K
         ENFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720466130; x=1721070930;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ANaO/6LtermgjT3FpT+Oe/hJ5QqBspkDVOh9FkiPDW8=;
        b=bP/gEO4aiUA2e1InMRxRELsRzcWq4uLnCM7Mqg5W/TJO43hbIhjRnRhO+/uJOA6GzE
         C36gmgAhgl4Pfqz/SnU2nBW18oBRm/mnS7rsrOzmTEaGU89+okpiGdqITNw3S5qy5jam
         F329YtnZMQdapiBK/FqUgvhr3SXgqmbMcKoefcnFWK6mf54IMLwZJO4URkTctA0iQ0xb
         Zn3KPah24R3x4H14By/vG35XZEwG5+aLr84yYVSdn3vscA05bfaOwKyKb+Euzi0cwGUx
         0E1BSPopoLnZsIvAGiTDZoHsdWahgDjEuMEc4s5bN3AGRk1TiRC/3VIuG2y3ZSbXQ7+O
         4O1A==
X-Forwarded-Encrypted: i=1; AJvYcCWPC69CPhXk8IHR+0TxK5/YP54EQA9/j9nPzsX+hul1soiKgyQvlzWdNVDFtm4rxlVMmAx5t6THZBRsMvDvRMn5B7dX/X2I+fSvHfGANOwqKlJSFPXrR1tWOzXiVUhba/aAjXJY
X-Gm-Message-State: AOJu0YznVktOVf8txwLVUi0/JHtC7Dpe2IFBtbSlLirG8DfyCRZLHC4F
	0CvMjuCjIc1xAgUn9cKNmWlZzqYh34LS8GwqtHq65CGofZO/JrCzTDfJNkEE
X-Google-Smtp-Source: AGHT+IEQN9dKrH4/E9nTXVTQ4O/IXKED8INYAT8ChAKD7RTJmLwga24osHvWEoHXwPhFG/M7Q6F1VA==
X-Received: by 2002:a05:6a21:9993:b0:1c2:8d72:67ce with SMTP id adf61e73a8af0-1c29821e0dfmr381826637.15.1720466130523;
        Mon, 08 Jul 2024 12:15:30 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aa9277csm8547669a91.53.2024.07.08.12.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 12:15:30 -0700 (PDT)
Message-ID: <5bbb91e1270a0d9d51e403847e74912aab95d484.camel@gmail.com>
Subject: Re: [PATCH bpf-next v10 06/12] selftests/bpf: Add expect_errno for
 network_helper_opts
From: Eduard Zingerman <eddyz87@gmail.com>
To: Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Mon, 08 Jul 2024 12:15:25 -0700
In-Reply-To: <35ab4f6f094e3c700aa9ec20ee6d6d1a91284b5a.1720405046.git.tanggeliang@kylinos.cn>
References: <cover.1720405046.git.tanggeliang@kylinos.cn>
	 <35ab4f6f094e3c700aa9ec20ee6d6d1a91284b5a.1720405046.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-08 at 10:29 +0800, Geliang Tang wrote:

[...]

> diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testin=
g/selftests/bpf/network_helpers.h
> index fcda6b2333ad..14d161d35248 100644
> --- a/tools/testing/selftests/bpf/network_helpers.h
> +++ b/tools/testing/selftests/bpf/network_helpers.h
> @@ -24,6 +24,7 @@ typedef __u16 __sum16;
>  struct network_helper_opts {
>  	int timeout_ms;
>  	bool must_fail;
> +	int expect_errno;

I think this option obfuscates actual test cases.
Each helper that accepts network_helper_opts as a parameter, does
multiple system calls. It is not obvious which of these calls is
expected to fail.

>  	int proto;
>  	/* The backlog argument for listen(), defines the maximum length to whi=
ch
>  	 * the queue of pending connections for sockfd may grow.

[...]

