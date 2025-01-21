Return-Path: <linux-kselftest+bounces-24880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC44A17FB6
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 15:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DDF43AA0B6
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 14:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A041F3D4A;
	Tue, 21 Jan 2025 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VzKJV7c5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701F61F37D1
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2025 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737469568; cv=none; b=uzE4oJ54OdZ7Dh7dmZnBjUvoQV2WRsoVCz+y+g9BWmbBVN+wLFAcjqw2L0PQIQi/GKBhljmAS+I+tD3sn0d1CayUuoBY9fSoUuyGnAj7QViwGykFaGlHiU7aF7Mtqx746Y/qtPd+sA6QyZdqnj61fVs8za72jpLp23Qv8hr9hMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737469568; c=relaxed/simple;
	bh=Rjp+hmWDO5OTfT2ysMv61UtgN9kBNntHkBGEm553axg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PNZK1ExlWiQ/GhG274e+0G1w/BrhmCnaWdVaTiKf43EhK2rsDgEr1Gktaont1Aa6Sw1mvb08Y0VwfcQ4Vh7rpNgDI7bHcrdp4qOs5OHY1fBQLNIhjvO9wat82QEPNn3TSfwihfzQUG6vOU/WKqU06l0bK5vYNxVngbMv6WLPzXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=VzKJV7c5; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab633d9582aso251046966b.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2025 06:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737469565; x=1738074365; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rjp+hmWDO5OTfT2ysMv61UtgN9kBNntHkBGEm553axg=;
        b=VzKJV7c5sszDBE+DajCUYyQthAweExG4XCb6BMSV9Evtb2gEIZbJog4hZjLVHWd1i6
         tzzSM+ZHes1R6Ip874NJNBmws8E9N/R6hxSUz2IG8bO3i1NvgEUHjglgcob5o8oCcUle
         gC3jz7PVEEhni6NQTY1YoyK6LuNK5cjlAfIXOeOYwts4J9iSYfI20TNrapTRW/wjbxRB
         1giGF2bjoV9eHj1oDwgjtEgJKxZPUL/Cj4QFjfSz46BNs+Z2J1ZuPfQuVXlKvXS3jD3C
         TXpIbSeRp/Uu1UPuWc8e9+E0EXCA/sFMpNYypQHGpejE83CcyvGCJZQ+gZX6PvxedoOG
         6ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737469565; x=1738074365;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rjp+hmWDO5OTfT2ysMv61UtgN9kBNntHkBGEm553axg=;
        b=RcdE/PHomvcIy3fbjB3tHv3d2YVNAujfyalkEEPzEBCl1xwIr9haFdiDV8W0KIwPuA
         y6QUd1AY3Q0GYLpjKgYvUVg2xYwqvJSwMLzmY4Z45GwDcuSNgPdEWyrgyveOHdTV6XdN
         nGYYwZbsP/oIGZt3jWeb11F3lDiFI39fu53eRTEM7cJ0A+Iq0UgkS/JduGHYMXMORXJ+
         O93TjQzqeuBezqqOwzvtqdk+LIKKP0UFV2N0OUz0jsHXbmdXz6ps/R4BNcb2vlQaMr6S
         N4voto9s4XVgCv41uNOtYVLMvSC56b0Ii/D7rOfRmZSKW3sYxhhWQcsmNI5boOVWkDjn
         yLjA==
X-Forwarded-Encrypted: i=1; AJvYcCXxgvdmMa/yzqM87ZH/hkop6G65Q7ZPRTz73wtTYl7xyadlY+St/9nTGddVhwCO2OFwD53TiF+PNXs3qb1zHIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHL+t5RI2aOw3exjaqHiwp199L6uSTpYgybvugTSdXirrXQ7Ey
	u4GrutULXrJ4jbUdiqKOpxWpMIS0E4uLa7lbBuqZyJltIpeW3O3hyJqa/EEp42g=
X-Gm-Gg: ASbGncvMpS2iLKyAgx3jph3CVn7TKBeN0zIXEVvoTLu2t00sXtjyLyBALN8YP7QcppX
	jJgnlWAbMlFtX0hj16gn3QMlcYGOWDNx6fKUyjKAMxQxiYmyFoND+XrF58Cw41+wGauXhPK4T4E
	VrSZTu2p/LCw73lMKThpj6dq1K5S/TKLgm+8TWLt1EZgF91ReTBuV5Pcw1MJOvj/oINQgx2zuYH
	FBpVagHFZpYPCNsxegO7AzY0LALnUgd0mpXRdWv43E7BMn1Rov+eR7J35ovoQ==
X-Google-Smtp-Source: AGHT+IHwlnK2zw9uivEKoPguTLSLMAAZPkuD0ILNy3EmWF7Ejd0QSjCd/rdjvIvH/M8AXJrGyDq9hg==
X-Received: by 2002:a17:907:9802:b0:aae:8491:bab5 with SMTP id a640c23a62f3a-ab38b30e1admr1420221266b.26.1737469564730;
        Tue, 21 Jan 2025 06:26:04 -0800 (PST)
Received: from cloudflare.com ([2a09:bac1:5b80:d60::38a:3e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce0172sm749653166b.44.2025.01.21.06.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 06:26:03 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  john.fastabend@gmail.com,  netdev@vger.kernel.org,
  martin.lau@linux.dev,  ast@kernel.org,  edumazet@google.com,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  linux-kernel@vger.kernel.org,  song@kernel.org,
  andrii@kernel.org,  mhal@rbox.co,  yonghong.song@linux.dev,
  daniel@iogearbox.net,  xiyou.wangcong@gmail.com,  horms@kernel.org,
  corbet@lwn.net,  eddyz87@gmail.com,  cong.wang@bytedance.com,
  shuah@kernel.org,  mykolal@fb.com,  jolsa@kernel.org,  haoluo@google.com,
  sdf@fomichev.me,  kpsingh@kernel.org,  linux-doc@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v8 4/5] selftests/bpf: fix invalid flag of recv()
In-Reply-To: <20250121050707.55523-5-mrpre@163.com> (Jiayuan Chen's message of
	"Tue, 21 Jan 2025 13:07:06 +0800")
References: <20250121050707.55523-1-mrpre@163.com>
	<20250121050707.55523-5-mrpre@163.com>
Date: Tue, 21 Jan 2025 15:26:02 +0100
Message-ID: <87sepcgs5h.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 21, 2025 at 01:07 PM +08, Jiayuan Chen wrote:
> SOCK_NONBLOCK flag is only effective during socket creation, not during
> recv. Use MSG_DONTWAIT instead.
>
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---

Good catch.

Fixes: 1fa1fe8ff161 ("bpf, sockmap: Test shutdown() correctly exits epoll and recv()=0")
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

