Return-Path: <linux-kselftest+bounces-35083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEAEADB41D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84BF7172474
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 14:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD388213E94;
	Mon, 16 Jun 2025 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEmCG4xv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A954210F59;
	Mon, 16 Jun 2025 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084804; cv=none; b=VCTy/4kKduNHB5K1wy1RBJpfODdOl1OFTHjQkWispd2OCMudS80wFOZXGNCfkLfUAFL5Rjt60suchcw5aclr4kJGWbE26LMyHizQ6BV9x7lnNfXfxe/FMPWLQWEXTKDgxUJm87Tywd9QIK4tOYZZRHbJ9Xcg0gltHZkefMA0zoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084804; c=relaxed/simple;
	bh=IblUft6XqEqcAeXLIhkIdld2QNPHS8b4FDyOAmEOg4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoDqb75QPN2S2Gf+jniGGh1mr16JVDNEOl0aUZ2UxIqaurUK//X+LfjIMGUs2buJZXz9XgYzw8Z3m6UdwUXpdduL5KgRT/nirlZ6ZtkqQrFZ+Y7HrnzRw8JoTVeRnWfY0KJ/gReut4O9pePhC/RcpxfSz3HhjAAWYYv1AFGlMBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEmCG4xv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-236470b2dceso38229195ad.0;
        Mon, 16 Jun 2025 07:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750084802; x=1750689602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p2XHsXnJ86Tj2lkJgnpp6y7ug5GTMJCheywFmpki5M0=;
        b=ZEmCG4xvPXg9JqZ1hMzUzeY/60HgP5MUB6gXyIbnCujx3bZPiQmlgLonIi57Ya2Ajx
         DxAg9mAEkN19l/Y5867SUyNAiQik6ZDoQYxSGmLHzB2DqZ+E37qgiT/PuxuhN3nucwcZ
         zkjg+70rDM5zPf0I/UFjy4o1xcb93wZWAXicYmFyCoVUwFQx3wtyHQ4vZ70B5tzsgWnS
         EXy4EordQSWmL3SYb7Jejl1xYQ85A9nGTQbQ+so93YXy0dEkVI2RSsqTwZa29qaubfvk
         7JTCpBTVIWcw1M0AetI9gfzPjOyywHNzqGyALia1FxML2gZW/cltN6fLVEls3ZT49Mzk
         RIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750084802; x=1750689602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2XHsXnJ86Tj2lkJgnpp6y7ug5GTMJCheywFmpki5M0=;
        b=QwKA5kpJMeKTP93xVPyXvS2+0rBTY8UsOa9h6EXjcj5kMe6+Mw2bkOJ1M+3bp6mCx+
         xJ4z4kWMt+xphry97JZV1yYpwb0XPpIK3w6MmD30gZZiSRB0hn4vctoQS2K9Gp9XUAG4
         Xez3bdk1EVOo7cku8jYltXJuFh/RrBDc8BrnG5bWSJYPh0kTsxc9cqY4Yq6KVGufxdpl
         wYYhnHpY0MFrlMDPquw8pWK75JTSxLBojJXcMlUNJ0NhVnvvCp11iom/yWJ06VKm02X3
         GiS19fJmxrESaMkZi1pw98MttqzLnM2uyw4sefoexIK+kO1Nn04AwADEIutmX2IT0aDH
         xuhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+3Vw7a7J9tvDVh8UmwMBe5kFVcpT2Ozrv1WYUkbWDHtv+RVp3GzsaUvccXzlw6W7AXlk+0sIUTXXLbvo=@vger.kernel.org, AJvYcCVshtFOvCyDts48cSMOj4czEw9f9Zk4aFBU8mGuz2AY/ziYMgPgSbOXtxvvW+lhVcAvIq8e2u2/cA2qQoxfgIHE@vger.kernel.org
X-Gm-Message-State: AOJu0YzauxB8nLj48bxw5zLG3RYx3KMGFjlRE2BwfiXcnydnJ3SqoKFE
	I+kh25xmosZAXEYsBl9xfrkFF9ULG5WEVWxvx+K3LUw5dfbj7pfyIrM=
X-Gm-Gg: ASbGnctZJNmvIznyR8aLDcGQuEm6ZyTTCl/p6bwj8xrGj0U0E8vtj9lAgXskYtBS91F
	PMbPUNJlyFTVm3iuxm1LhkEcP8ocb2TthIjbq7szF/gJX5dPO5JPkUM0EMDdLLcAIay08NdRzYw
	MLsLFSC/lfRD2lcxY9Sv3BQJjNEI3nnLH6Kpxb/fj21M8Ztpru/4jpij8YwpoOKKK9seavJ1NKW
	9iTEKwUAAJ+8R00aENS5aCAbDSWGwSauOhG1BtnPt6aSMKk8A+s2cQNbiN8iyPpDZELK9SeAGJk
	NEtcvZDxhynI/cpsk12SgStNg7AvyPTTZ9Ewpa/dgr9iCBCwVrZIwEuiOnSA/VFiA5TBCJg6CTm
	pEbg2ffejLTrZQ0kU5suIiOE=
X-Google-Smtp-Source: AGHT+IFOqpLCXI3YMmdCNbxKT93iWeUpB1+eCZcVg9Y77hs+T3AONcZoSujivL7ye/soLpvxQkP0uQ==
X-Received: by 2002:a17:902:c404:b0:234:a139:1215 with SMTP id d9443c01a7336-2366b3c2d99mr149349845ad.35.1750084802305;
        Mon, 16 Jun 2025 07:40:02 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2365de78361sm61641165ad.98.2025.06.16.07.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 07:40:01 -0700 (PDT)
Date: Mon, 16 Jun 2025 07:40:01 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joe Damato <jdamato@fastly.com>
Subject: Re: [PATCH net-next v2 3/3] selftests: devmem: add ipv4 support to
 chunks test
Message-ID: <aFAswcxQOvpX2750@mini-arch>
References: <20250615203511.591438-1-almasrymina@google.com>
 <20250615203511.591438-3-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250615203511.591438-3-almasrymina@google.com>

On 06/15, Mina Almasry wrote:
> Add ipv4 support to the recently added chunks tests, which was added as
> ipv6 only.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

