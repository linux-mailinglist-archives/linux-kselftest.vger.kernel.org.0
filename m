Return-Path: <linux-kselftest+bounces-41932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F94B8945B
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 13:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4982F1C884EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 11:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B151030DD2E;
	Fri, 19 Sep 2025 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cH28JY7Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA712FBDF1
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758281302; cv=none; b=FRWfMLRmV0avkQF3K6BK/Pgj7i6T/OGe40U0YifLpWBZes0fgbmWlSZyLrWAiMz66YhTjMYBnIz1Yn7vEUnZ9eutyzgylT7/M9pj6Ajhh27uid2gN9AkZgJhd1IQo8JjOUAc9B7iwDkjQGGbGrvO6aRLVEWdYqlxAxBNDuD48DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758281302; c=relaxed/simple;
	bh=1DjitIdbNIx+396uLnHjHFUU8A0D1BjI4tRa/AeOXro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kEOYFh14bYG6CxfsnBI0na+ihU4gmLLqPwDhMJsgujHzm/1rfOiXspZqjEKBfn8xXJMtqFl2bqsEpFIv+KcvZKcxM444/a4ySgc3V3CuYp9WHVZ5ALwv4FNdRZS0GXRQRPTjs+TlxUjKZKAunasE3lUKHQ+EP88926cTVukUKtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cH28JY7Y; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-63497c2a27dso531845d50.1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 04:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758281299; x=1758886099; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1DjitIdbNIx+396uLnHjHFUU8A0D1BjI4tRa/AeOXro=;
        b=cH28JY7Y1HKiYUVzcZaRuPvKMaKJfqn3fYwNzQg0bDX34f4d+N1e2FzB/ndOjx5b3m
         Q7DjM9oJMy57tcVfQyUGkb2nkXFW6xAWVxS/v/2ZebOy9PVPOHRmoRiG0IxMuOTuG2QJ
         h1tI0jJXBEJquwFN0g5dqwcBQ4QTqKSeaiO4uL++3Yl0hwdyS06ky33eLsLe0sSaUUcp
         +FulWOjw7jPOE+IgU+z0Bxa1L/01XGR3lk92e7qYvMEswj98Z6BjoiGGlsaC3KVbrtzf
         4EgPsouIaMPEdO7QR3qfDYSYcwzrIA29UsyHWpXdkKlqHrp460AwKkHFYODuRM4LQem6
         IMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758281299; x=1758886099;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1DjitIdbNIx+396uLnHjHFUU8A0D1BjI4tRa/AeOXro=;
        b=WFDBPbek5rDoR7ZaWlj+YPQnfmzzWJQ3bwMgpO56XnsJjvR9L+1REt1P0i8e8BopF0
         Y3P7ciwlNB1jPQAAKS9bu5a4nGNx0MjF5bdEvBZVtpFMev/5ijSASAKVAwDMoZrh1aPp
         4Sw916X1SAPLj0Bb2r8XRYgR5DwVecA/nalwZPhAfO5Y/qn4PJrVq8YNi7z/EHqs7mS2
         rLQ/FZSbeeFqVvj16UdtW2EO6Lvj22ksX9h9s5DzEoGeNEfCbcCqbR7WqJyk43VnS3fe
         I4UbaleDOvtJvnYN1Mt1LEaJEa/A4hPFsTxV+c7N1ibdMmvHLDhQL85MMw5K17T+blNj
         7urA==
X-Forwarded-Encrypted: i=1; AJvYcCWhJeLF6u7Pm0fQMg2j1SWrtNYPuX8z35Kl4efPexzWbL0UgXhfec/XrDD8pW7DKCF7+c+Rjx0UC6nNQ8nU3lU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+B1s/uvahuOtnWC+LOWQoZnu3S0uLwzmjjGSgRMAkgbCpnd97
	agQSgdG6EUHHjbFOxPNxy9YkG1wYHfnSLkjrhMOWiarn+75DS5OFTVaqepLmI0tf6vM=
X-Gm-Gg: ASbGnct5elfQAvyE+RNE+4X4PoexBC2l1AAR9DRIFcKBce+R48wpDTZ+rkwfsPxD9w5
	YCHBWZYB6lYbDZkOuZeQk46hNNzdDlk620Oh+4IELivlpn0QpYb7zZjyDbfVvKegPQ2z3l2iS4w
	u1dvQRZR64HHN7NPZO0YNFO9HLgfhxaog0609l8pHnwAZxc/ztM6nunIwg1VPKQ1gepZFwJv1C3
	mOi1CAF6c3E4UDs4W4oTgEdssMQ8ynY2Q4n5TgSiVEgHCwDQk1rEtWx+hTW1DjZy5f2KVkGXrat
	q33IyfBjsFRfIcyV/O6JN727F7l6DeW+7RG0C+DUbswHSHyCsfGnRB9DTm6tdpRc9AE6T1IdovD
	6yTSPqpMzSkEywnuq6YQ7aIw/4g==
X-Google-Smtp-Source: AGHT+IGzit9Xl09pvF/y8vcEFtgKSFANQAuy7aNdn4IaGhXGUoBDbxyhkZegsmgt/FbqMid9KfiZtQ==
X-Received: by 2002:a05:690c:9c0d:b0:723:be82:c78a with SMTP id 00721157ae682-73d39d75d6emr24479897b3.31.1758281298949;
        Fri, 19 Sep 2025 04:28:18 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:2432::39b:31])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-739718ba1d7sm13612217b3.65.2025.09.19.04.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 04:28:18 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,
  John Fastabend <john.fastabend@gmail.com>,  KP Singh
 <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Mykola Lysenko
 <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org,  Jiayuan
 Chen <mrpre@163.com>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: sockmap_redir: Support
 no-redirect SK_DROP/SK_PASS
In-Reply-To: <20250905-redir-test-pass-drop-v1-5-9d9e43ff40df@rbox.co> (Michal
	Luczaj's message of "Fri, 05 Sep 2025 13:11:45 +0200")
References: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
	<20250905-redir-test-pass-drop-v1-5-9d9e43ff40df@rbox.co>
Date: Fri, 19 Sep 2025 13:28:16 +0200
Message-ID: <877bxuu1f3.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 05, 2025 at 01:11 PM +02, Michal Luczaj wrote:
> Add tests that make the BPF programs skip the actual redirect and
> immediately return SK_DROP/SK_PASS.
>
> Suggested-by: Jiayuan Chen <mrpre@163.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

