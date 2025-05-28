Return-Path: <linux-kselftest+bounces-33967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7197BAC738C
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 00:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4107D4E65C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 22:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0D8221562;
	Wed, 28 May 2025 21:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aoloa0i6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE1421FF32;
	Wed, 28 May 2025 21:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748469533; cv=none; b=dOYMRjPH2k6y231tevEzb2wRwvAeHwag5bZWiOPIR5+sjY1JykTiq2cEgJQTCSPaUYmtzv8oCTJRUH8LMnKPr6n3OlS8TdbHrjK3OF72Muwde4OFMQyYHUEMfAVISaWI/loUlUiU3rLXImdaP/IuGeDH/yULLyVE7slblQn2ed8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748469533; c=relaxed/simple;
	bh=LLUztYHjAFJ3efU9EaxF8l2rLkaP+mwM/RroEOD3eeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgq2UsVvWzaxEy8PyeiwCyqlnVGqQZEoAdVQzWBFHEbFDAq8V8uJxsHbd9NCrjtuo5Oay6/vBXieIsbzwsweZcOo4H/o+/B6NrJujjm8LoVd0bynyMMiHU0gefx07rFkLMq8ErqlNLbSGcfZuNBKHJjOrLcCEVBE1Ep0MdzwiEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aoloa0i6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23461842024so3299215ad.0;
        Wed, 28 May 2025 14:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748469531; x=1749074331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ttAJzmfW9+GQa0rRyczMv5l8LbO1UT5+77cAySADNRQ=;
        b=Aoloa0i65HznO+dOigx/oBxBElcNoeeKzYMfMavYHGOq22NK1LZ+iM8PEPKiq5oZ46
         rXmcbdvUxoXAVKpEjQXI2KAB3r8nOH7H51jXVuOsqXkPq9F2ens/6qfkrcCe4hb9qdhP
         hVUhLILIJUxkjOlioOTOYb6mXvLQ5tKv0Vzh3/dDG8QmKUtkLBYmWfKlFxgbTAz7acVN
         76ZpsON2b5k1/E9JDw0BB1etqvgc1VgJhJLQrZqYFfXm1SdBpS6ieXCLWeZuT0VVLaEf
         YRgPLMI0YNs0pXQj0OJONtHs9If0IPBGuUgmPYTE0T+YVU1l7arbB6CdaduX5SvC8uR+
         Q7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748469531; x=1749074331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttAJzmfW9+GQa0rRyczMv5l8LbO1UT5+77cAySADNRQ=;
        b=aWrmqn+Cy6gdZkF1NthmhmcEfq73/V70dSaNnrmNtocYOuJw09+QMplTvZkn0704JO
         Bj14LgjGRhVDfEvVI1+0Ei6+5AiMNKSejs4SGUsJw2vd8Wgx0K+CH+4tzYrbgG4rS319
         HWjm5hQrj8kwPz2xUt4fgMCu2UXDn8XYgNEGQ/ywPTGgkSjFC1JLmbLYcWLDyEPZGGAb
         FmK96PTPa5WlgdEMYyJpD2wVYQGeIDh7aOr0WIUqyvd+brsxCRfE/eav8HLWkNndAP2V
         AgW4xHIh0gqFnBbK4dqrysrbQQlFnTT+QgD3NN56KQeT8BK11ZKGAKxc7RIiXO75nl/B
         Cymw==
X-Forwarded-Encrypted: i=1; AJvYcCU6jrN+qEV09dZJ3F0ZLi/M//8dU1Q83ZX2pWl9nOzODzwsbez4LaQN/UTYyQ9pOX4oTvaJwRTpgm+xw5w=@vger.kernel.org, AJvYcCUhUNYEzuwYl+ukn8pYvOJ/yyEOGhrLWhukfY/ESmYTcXP424yWz0GwTH5ejr9YisNRXUH6zQzShYOzB1KQtQ9z@vger.kernel.org, AJvYcCXSjEyPus8TJL0Viq04fC2Q2mVbv/VMBakgTNhET0F/EZ35XnEScNq4npiguvRBdkKgfZCzCPBf@vger.kernel.org
X-Gm-Message-State: AOJu0YwogOh5/SrdFcKrQQ0ozrsSyDdEHASmceT3lFvTOaUcWCNMb6Wu
	8zUbkTWe9FoHKEjD3p7URkqm4LUdaPFoOEnAN4jFjEPXXszefNJq0Igb
X-Gm-Gg: ASbGncsFp2Xsvxvbks/ZxVVdaii8L+6Vluvsdi+IBtAkNYet9qAEfhx1yCR7L9BuTDd
	j+Os3xrpstnCIAeWtbKowWOd8sg3PjHDeCkM4Ga0y/+bbTmtt9e79Ccb7o/DGKR7gXyhfgA4sEb
	DHwzO2hjvg/HsEXeBYYBNK9WCnBM4wxwTOSVywfXeO5Jxh5eAwSobK8YDA6l/UgSSQAemPCtK2Q
	FzY57Kk9mximkWXWGfS1G/DW3nJD4Pwe75iB5HtY8P57pi/XaZwHqJc32t/9rQP2q2N/1AJ43xw
	JGAuSVUtgkCqZWgn9V1WXZ0J1dFjNGorycSyIwqLa2aoP8PSKOXLd4KB3SwFqt0=
X-Google-Smtp-Source: AGHT+IFAAfBzpsKcvV0vuav8DmCGmUI4Eo+o2HOPct7NcdnaFE8CpWx5nme7qzYPJ47hd1mO67Ib/Q==
X-Received: by 2002:a17:903:228c:b0:22d:b305:e097 with SMTP id d9443c01a7336-23414fd3e53mr259186315ad.50.1748469531018;
        Wed, 28 May 2025 14:58:51 -0700 (PDT)
Received: from gmail.com ([98.97.34.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cfa37fsm581965ad.197.2025.05.28.14.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 14:58:50 -0700 (PDT)
Date: Wed, 28 May 2025 14:58:46 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Boris Pismenny <borisp@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Ihor Solodrai <isolodrai@meta.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Add test to cover ktls
 with bpf_msg_pop_data
Message-ID: <20250528215846.iqx6ea7f2bb4m7wj@gmail.com>
References: <20250523131915.19349-1-jiayuan.chen@linux.dev>
 <20250523131915.19349-3-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523131915.19349-3-jiayuan.chen@linux.dev>

On 2025-05-23 21:18:59, Jiayuan Chen wrote:
> The selftest can reproduce an issue where using bpf_msg_pop_data() in
> ktls causes errors on the receiving end.
> 
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---

Yep LGTM thanks.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

