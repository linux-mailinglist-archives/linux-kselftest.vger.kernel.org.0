Return-Path: <linux-kselftest+bounces-5294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F021985FD18
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 16:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2461C2503E
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 15:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BBF14F9D6;
	Thu, 22 Feb 2024 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bSXkMABR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD44A14E2DD
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Feb 2024 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617178; cv=none; b=CsU9fQfDli/DXKU2UjJbUHB7ejTlZodw/rQUcCdzaYR+3skG5lAxdkJVaqXg+60j7plUqh0PsEmPL9lWgybjysq80LefX6GBoKKKpty0Oc8MnGPZF8miKzc6fYiJzxq3H9p5ImLjm1v/DHvw1Evhga4274iXK/lMZq/0UmCgc2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617178; c=relaxed/simple;
	bh=Vd3UzDgmX7Ao1DnE+nzyieBLFnftQ/B8sJIJRrxRpco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ux/uMIoa/Bw3r10heIJV/f48T/XSu3siX/WEZxirgd4D+pe3wYP+eOg24JIiN8rqrV4rdDg37TVgTEDyVShN+1yWimr5u2++teYfEIwNdiwI5um8F7+CwIXi3CHm41eMu/Ga7X1vabsZI2xJ99g3Jy3QNp/IN6BLqBJnpoUuscc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bSXkMABR; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e4d869b019so148924b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Feb 2024 07:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708617176; x=1709221976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1gfwnWmu63cYswR0b/u7RtSKFeQyr0VL4Kut1suu2n8=;
        b=bSXkMABRd5Gy9iYQZn6+kg10M0jGKVqcKbqT6VPDcuAA7I4OwHLOV8WaS+y/iZyRAA
         ZXkOoGHpESpLUfIhI9+kzg2G+h3GF+ylw44PN5ekhfb4B0mYFV+jnIr21/MZ8Ub7Wnw1
         xJO9AxAD0f5W355FyYMKjxJ+6Hq2yKqAYPkWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708617176; x=1709221976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gfwnWmu63cYswR0b/u7RtSKFeQyr0VL4Kut1suu2n8=;
        b=rLFGWQP+6Iy8mxEheDBnx/bQpFSJr60Uu9jW66QLZpuY1ez8pdMaAi7+0cPQlB2fnh
         LHU/y4ZfxY8WvGLmDLl/BXyGztKVRVy9HIkfUTi62galeJD4NyLDdXUeWNTd+bUX2XjT
         NiRZmpxUfS/CYpt7NPKEJVASyHBrTysoAd1XP4qYsLqOjgl0QLQLHrf9q0cRUJwpBxV3
         i/QTUabXyhy2sEHnrImB2S6D/F8NxGSRFi0uS1pwsCry56m+uqL2BZKA5/yRZT3TsuCo
         VyvGr7JXjfKr7FhWgOsIFAKt3WTmKz3rzT0XpAqp9fXwXU+4YJi/mlEGsb/PFZNrGP/b
         qkig==
X-Forwarded-Encrypted: i=1; AJvYcCWMBzpRNJDzTrFeWGv+Jnyf1b7uk4CNmXKJo5GlTh6pJYbp5QD+VYOHzX7ZU5bf2RxoC3j2lI/IFcGqDrayOMbQHEA3oQ0VTdT7RAA3m9Jo
X-Gm-Message-State: AOJu0Ywy2fbqEmjqF3KSnLJJk6qr3v3i782+3axrnRBUasJwL8cepAYS
	lHiWqrjMYvd09WDtsXT3BGdEXpJoNlTQfBysy27Co8nLtuj8WvwTBKFkUQKlZg==
X-Google-Smtp-Source: AGHT+IGrtsHGeHfg7xJD4IpKzMvkDmfLWoRjY3MrY0wjNmBdDYmkUNv35SM8aT2MKwO5Lko2A1nlBA==
X-Received: by 2002:aa7:90c6:0:b0:6e1:44ec:8e9e with SMTP id k6-20020aa790c6000000b006e144ec8e9emr14895496pfk.21.1708617176218;
        Thu, 22 Feb 2024 07:52:56 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g19-20020a056a0023d300b006e469e8b634sm7589863pfc.3.2024.02.22.07.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 07:52:55 -0800 (PST)
Date: Thu, 22 Feb 2024 07:52:54 -0800
From: Kees Cook <keescook@chromium.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Haowen Bai <baihaowen@meizu.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yonghong Song <yonghong.song@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Yafang Shao <laoar.shao@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>,
	Anton Protopopov <aspsk@isovalent.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5] bpf: Replace bpf_lpm_trie_key 0-length array with
 flexible array
Message-ID: <202402220751.2370A263AD@keescook>
References: <20240221222613.do.428-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221222613.do.428-kees@kernel.org>

On Wed, Feb 21, 2024 at 02:26:20PM -0800, Kees Cook wrote:
> Replace deprecated 0-length array in struct bpf_lpm_trie_key with
> flexible array. Found with GCC 13:

Nope, still breaking CI. I will respin again...
https://github.com/kernel-patches/bpf/actions/runs/7996482005/job/21839056683?pr=6451

-Kees

-- 
Kees Cook

