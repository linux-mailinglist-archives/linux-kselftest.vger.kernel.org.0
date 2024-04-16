Return-Path: <linux-kselftest+bounces-8173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFE58A6FAF
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 17:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A461F226DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 15:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBCE130E35;
	Tue, 16 Apr 2024 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PK+gwsCx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CFD12B154
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280984; cv=none; b=GI36DnAXBeqrkd8LhpivgoalnH/G/K7uvpiFHxWypRw7AD8+bPKJP2ogPm8ntWfT8bQF9M65sKdv2D38rRcvef+jrKJWEoe96adgyuomR9NZKCGoO5j2MuUJTjdofIyDpU2MRYfy05gM7jcUfpQ13GB3DP7McmieCxG6es+Q6q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280984; c=relaxed/simple;
	bh=VgjJ1sQnYJM7vPGFLgOyl5MiheSdj8kCxc/E8B7aS+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lyBdryUr8sHNdDujVfJSYWKO2Zv5hSFgE8otFBb1gLV7bjwl7dXoljqz4BCJHFG2rSxE2V3Wc1U9cFb9M9A+7M2+n2da7ZtTFna0JdmPxu8K1Tz/odwftkxJoIkI2b9p4Mh5WK7ApIcUl35BTF1549NLxM6i0D2fY2pPVZoKolE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PK+gwsCx; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e2b1b90148so36580585ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 08:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713280982; x=1713885782; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zno1kdsfWaJ1DeTq0hPq9ZAZ6Z0lEil6bV0PacUdpzY=;
        b=PK+gwsCxbzcZ7SjqnIbKPtxi2Gy4YpxFYZ0jffwDBF9DuhqpY/QieWu2AlgHnPE0iu
         ko1RUCAFixMAs+Bdsc+/28tauPNfxaOCvMPdAAosYGjHBfeC83KzWEljkyrwmLgtC5Yg
         wOY41jq5I+dKb3tSroPOZIJVaunsAmfVQ2eIF/B86lv4ac2Bw1f41JiCrU0b9aR37WTU
         z7Eq9nbt3wqy66rvvXMbhQazynTxWanLQvADnEhJuFVD0NGd4dFtk5MwfJshRVaG6HJc
         8ooyPDmxDd+QSyfMVohuGUDjgnwooWmk/iS78Km1ZuKGRbwXQIf1XB723fqkA8LOb0WT
         djmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713280982; x=1713885782;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zno1kdsfWaJ1DeTq0hPq9ZAZ6Z0lEil6bV0PacUdpzY=;
        b=v1DmMSq6XDP5pgV4LhXB/rBw2AXvCNgwubjRv0B/VncNi/d//808qBhuBFUKaj1s0b
         0dNwvcH13sXOsmZ/O7scNEjWo7L5hkF+RPieuH5BTpV35zDm89Z6T7piYxVhgOHwqlyT
         h9aaATuMSIpENqc4Fy0lmIRTqrHUPTdEQ8KIshUI02KDVYczrqz1qZdX8qHEV3cF77w8
         VYjw5gJRl0wEipmT35y3dJfdI55cs3SAH3bdTn900IT5rvuT47TDTxi6MlkL/cXTsLYu
         LoewaEAo1t56DMknLo+FDRL2gKE39gWwPTtlkSF21SgLUm96xpwPJYic751/uPaHdhaQ
         aV4w==
X-Forwarded-Encrypted: i=1; AJvYcCX5a8eazudRYiOxwtmTBb+HbVh7jMcbkG04ppuiG+jWFPODQJnfVB/JspCpU9NSKx0bV/3s2mpAmBXGuXlSJ2tuJ4yN1+5taTF1QZXMhHRv
X-Gm-Message-State: AOJu0Yys1pufJaF8LBt7vGleOBWxlcIvPPOSaBEW8hid1c3pYNE1PKYW
	RVXa44QoIMlQdhJx3v1h/Epx0o+/0w3unV+Qnk/qDPeG/giK25e5saDIlE/1A0L6a8ZK434yQ67
	qEw==
X-Google-Smtp-Source: AGHT+IHT1pC5s1cugeqIXTNqxkxUA1cuAiRf5voHQMAwSwbg8G3jOgahsrnw3GT8HRend6+dNGkM2RXcehg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:1d2:b0:1e4:5896:55fe with SMTP id
 e18-20020a17090301d200b001e4589655femr374739plh.4.1713280981894; Tue, 16 Apr
 2024 08:23:01 -0700 (PDT)
Date: Tue, 16 Apr 2024 08:23:00 -0700
In-Reply-To: <20240416151048.1682352-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416151048.1682352-1-kuba@kernel.org>
Message-ID: <Zh6X1NkQJd6ETTo7@google.com>
Subject: Re: [PATCH net] selftests: kselftest_harness: fix Clang warning about
 zero-length format
From: Sean Christopherson <seanjc@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, shuah@kernel.org, keescook@chromium.org, 
	usama.anjum@collabora.com, linux-kselftest@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 16, 2024, Jakub Kicinski wrote:
> Apparently it's more legal to pass the format as NULL, than
> it is to use an empty string. Clang complains about empty
> formats:
> 
> ./../kselftest_harness.h:1207:30: warning: format string is empty
> [-Wformat-zero-length]
>  1207 |            diagnostic ? "%s" : "", diagnostic);
>       |                                 ^~
> 1 warning generated.
> 
> Reported-by: Sean Christopherson <seanjc@google.com>
> Link: https://lore.kernel.org/all/20240409224256.1581292-1-seanjc@google.com
> Fixes: 378193eff339 ("selftests: kselftest_harness: let PASS / FAIL provide diagnostic")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks Jakub!

Tested-by: Sean Christopherson <seanjc@google.com>

