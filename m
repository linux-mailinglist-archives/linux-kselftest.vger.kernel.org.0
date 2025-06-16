Return-Path: <linux-kselftest+bounces-35084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FF9ADB426
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B4F16A0ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 14:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096BF1F7060;
	Mon, 16 Jun 2025 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgxXRBai"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738848488;
	Mon, 16 Jun 2025 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084851; cv=none; b=ByhIx89ErGGJn8rXmmmtEdKFGhu+Z28CiFJaJJ1F2OWGtx9vDVPzJhnulVkBbTlt/XvtlEVsozgdlCKowxtSIVtxQiADiGD9qYcEsKMFbifrUW6+26zlyoXlcTJOoYelOFoTygoUMFYTzQBFKbqzCNJ2Rrn4cUy6uVY8TYKtyQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084851; c=relaxed/simple;
	bh=tjVABvs/53udb9Ly6q0/NZPLo60UDCa1WMmO134tK+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTz34U0OLw5B9GgFMc8ErMAgl5WLWy3EnWwk4Qr+/5ZoSl2nalQTiFX/muOJfvBSkH2b1aVUE/tvW6+6uUQGYDtICDZZ+Ohf/Ab0f2X50L08MR7vPmSQdQOOl7Uss5DVPemDV5/tDJE7JZgBDfr+/O5iIUWXuId7fuIa86Jn/1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgxXRBai; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7489dfb7248so1262534b3a.1;
        Mon, 16 Jun 2025 07:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750084850; x=1750689650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hnae5rUVtyDgh6SEOqSQ4jfYOMDGzLF+HDM/mhp7wlc=;
        b=bgxXRBaiJ/BqmG2eTLRtQVa1qPpG1dwCEkkkGwdgfojh9I/YhCSUq1oY/0LYJrepdF
         uFObW84DtILMXnaxp7CriUzwZqvZjxfamT7/pM8PZyy9dz7sL9ZbkVjikJ6XGKbLvEpO
         3lWvqGxbC4eAQNGJ5M3GinRwEcq1HV4BFQ8/LoxGookjqI929TQfhrNDXXll11ehKdiv
         I+prjyEU8hkMZgEhPB3jorFv5DsfsUiPRpreDMEmVA/w6GcYtYzsQ0T7MA0JjDKpHICX
         kJsW1sXNyyKHxlxFFrrAWJbt0VDYP90Lxv4IxlVwICHH+cFREoKTDLWlK1+TYr21zZtx
         PZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750084850; x=1750689650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnae5rUVtyDgh6SEOqSQ4jfYOMDGzLF+HDM/mhp7wlc=;
        b=ellMpZEGNq5sWhMFhYioTjkk1pVh5mWx1MZaAOBQlmadZOF801mQEkFvYNk1rM2GNn
         SEhPzKGYjzwEbCeZrEB9U35w4L+c2g4EPnjw8B/Wa9l6w21vPHeM1DdrNpsreEvMTwGJ
         b23sD+6yL6+ylV0nSKOUOzWHRpfYI+WNnnSZ2zYNO9lZArcsHu+o6JZkJ4WHbAP2FlGU
         tpSjeDIAJPvomcZv1+ii2PjBlYTVpDrUFozz89u/Jk7acQlpGCGCQzLP7v3KkWmOSOqC
         IoDVSwQ8jzMzFiGakr+LPXdHR9WMFWTDKK3R42vldeEUP6uJbyruN0TDBws/xfN6SGV/
         Oarg==
X-Forwarded-Encrypted: i=1; AJvYcCVqcM2DGZhsdZFmXta6t7ZvP6MKhbo2t6ftgRyjjBmo5MmRf082L5ywnN/GvwBGtRNaWku8aEr44FHh2mM=@vger.kernel.org, AJvYcCXDcRdrTFWmBO7sGUb8S+edQiuXJPSJHgPQUau6ttPrB+V+Fi0KPAzkj0ZwzobhvUrUB0WtJ3alXVjGMxP4BGlD@vger.kernel.org
X-Gm-Message-State: AOJu0YxmGViiCoSbDsfDdOCNmqmZQNxXQX93h7aEH9VaRnhQeBlDTbJe
	Ah27s8BEPqNyLMm6I8qNDef2+tM4OZjrcjch0IILa6bXp2kCK9cUiu0=
X-Gm-Gg: ASbGncvDo0nek5pVeAcjq1AsnMsux79adwcu6fWur8Ld5qJ9qB3otZrQm1aMoZQl80s
	h1t5jF/znKDCsamOX1vv9Rq8gfxfJMHwjRAvEmlcryVOHa2ZBxsgEG7/SY7C++dnpjoYFAqCsxS
	W58hF54/jaOg7grrbPIqQq/WqKFR5X4AJg3LPolc1KVJ6KGi2dwUJbMA/uYI5d9MLI2ajTUG3tD
	6OwT/pCEVy7ySKmAj9skgHMIzoJ1ciWxOTP/GpQn0lgnmtW+qm0N+uUQSkU5bm4hUXHB81IKp+W
	t5Iond0fXm8LvOZVKlnydr9gB9Bu5foJHU+C7PmrWNE+EkbzydZrtxS+6DHLmdpVy9Zp7rLjWEl
	eYun9tQaG1jLnmEsNg6e9PC0=
X-Google-Smtp-Source: AGHT+IF34+XysAU/Jclqr5gWtDSkls/FsPUH4REbQqRdfSWADyPRk9zXf/OiZ0dLivAG8TXJT4Si9A==
X-Received: by 2002:a05:6a00:ccb:b0:746:cc71:cc0d with SMTP id d2e1a72fcca58-7489cf99fcdmr13979340b3a.12.1750084849654;
        Mon, 16 Jun 2025 07:40:49 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-748900b2c26sm7102977b3a.135.2025.06.16.07.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 07:40:49 -0700 (PDT)
Date: Mon, 16 Jun 2025 07:40:48 -0700
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
Subject: Re: [PATCH net-next v2 1/3] netmem: fix netmem comments
Message-ID: <aFAs8HIi8_IY8JOB@mini-arch>
References: <20250615203511.591438-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250615203511.591438-1-almasrymina@google.com>

On 06/15, Mina Almasry wrote:
> Trivial fix to a couple of outdated netmem comments. No code changes,
> just more accurately describing current code.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

