Return-Path: <linux-kselftest+bounces-5302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BFB8601EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 19:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 077EC1C26587
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 18:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871546E5EE;
	Thu, 22 Feb 2024 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jZnn94kL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74B46E5E3
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Feb 2024 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627627; cv=none; b=OGrPo+LD+R2sft2nRWJDMKM7NNukU7XfECqJBCWPyvAvzUjNjR5JEfe/dr8agXWwdYBUl4dP3y9k5DQw7FUktq8A7kaXrIKN75GAN4h8gBAqMFHoLKX6Lr95NfRuH7DSylYD9rt0akk2bp/OZJIAPN/FqsdWTY/q4d3xLQ1QNUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627627; c=relaxed/simple;
	bh=NwoZ/s/YB6zInacwyEad3YhKFkgtInk+ILfXRdyVvto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDIHlzLh2k0COtwKvozwR7MhfLC9AXjOtSzT2YXvdppYcnj6yD4YuLxA3cEZPAQSy6s4M2OhvW5EiMM/4cuknc+2lgxPs6zFV6bwo4idcOplwKhqz+uJfD/eT65n0zrC9SAAc0ijBDmkGYou9BHMIhQxi6FsxqmjxLBSL26D3dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jZnn94kL; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e4560664b5so1934525b3a.1
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Feb 2024 10:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708627625; x=1709232425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4vpO/kuwhEAbu5lyhpp3cdM+wCLzEUK+hlVl6YVNB0=;
        b=jZnn94kLXyYka+9eXc6AizHVEys8TFY2OiJFG7PIg2WwOoOPGz/WnjIUBC7K1XuDyA
         N9WXbD4i43+FAb+UXraPUYghcAZtBZ9c/hsS++vfJPdXD4DWX6Tn2LFckfPHMQVQ39OA
         b5jXaD5DSRAvbP8DPkBMeXcy0mMxLq472fvQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708627625; x=1709232425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4vpO/kuwhEAbu5lyhpp3cdM+wCLzEUK+hlVl6YVNB0=;
        b=kAvPuayQ93IRIsLJZZ7KRhPfRDt68tltXZPqKomoc01vIt5O0uRsR1YHLSChABTyF/
         rB/qNlzgJSNlx+M75vFHJIvcCY8mAFcdb8iJ2gQOy+7tFq1FhH+SLHCk5Ky39l0XDdsl
         Jc4pwyLiqdBHv3CD5+k5MSkAPj27lr6AbYpqq4cgmUkrWWTPJSCOmBPv0cZbqsiJ/UUg
         Hiz1xz41jR+PYzNznKM6boYzixcJnOr+nFfZJoBZ3s3OiFaic4rf9hDgZWGlKjo0YRLA
         l9P70F5V+5bJ5PMjNou9uxIMhgHfvDXqcOwrCtnx5nqec51pIibXeS3sEq8ZCmLrwYql
         lN7g==
X-Forwarded-Encrypted: i=1; AJvYcCUFfxmTMuGqlSldc45DhuQHnUkN2Lb5ec7hKNCmF94XeOw6Kha1rGwKEln5mhjZCBNS82Q/4uyKBg86HV92l+OJDDfUfwE2cNrNP+N0BpYn
X-Gm-Message-State: AOJu0YwypNsdY6yT7gT7vng4PLBhGnclw+2unRs1HyXKW2SYpFVM8Ze0
	c3WVgqUZ7xOUURyUGY0zbt526FRBQMKZUnvfw1TtvrGg1vtdNykXVtxCn7wHvg==
X-Google-Smtp-Source: AGHT+IHgy3WwdGAsnQPmK2m2JDsitnCNDlW/VOsDIP4yBtdVhbhIse0VsuYogkkxJuuqsoNLgdNNGw==
X-Received: by 2002:a05:6a00:6c95:b0:6e4:6a3f:f065 with SMTP id jc21-20020a056a006c9500b006e46a3ff065mr12647864pfb.10.1708627625231;
        Thu, 22 Feb 2024 10:47:05 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s12-20020aa7828c000000b006e0651ec05csm11280323pfm.43.2024.02.22.10.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:47:04 -0800 (PST)
Date: Thu, 22 Feb 2024 10:47:04 -0800
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
Subject: Re: [PATCH v6] bpf: Replace bpf_lpm_trie_key 0-length array with
 flexible array
Message-ID: <202402221046.020C94D@keescook>
References: <20240222155612.it.533-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222155612.it.533-kees@kernel.org>

On Thu, Feb 22, 2024 at 07:56:15AM -0800, Kees Cook wrote:
> Replace deprecated 0-length array in struct bpf_lpm_trie_key with
> flexible array. Found with GCC 13:

Yay! This finally passes all of CI:
https://patchwork.kernel.org/project/netdevbpf/patch/20240222155612.it.533-kees@kernel.org/

-- 
Kees Cook

