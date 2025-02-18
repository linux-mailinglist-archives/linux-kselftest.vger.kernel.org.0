Return-Path: <linux-kselftest+bounces-26823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D481A3909C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 02:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9CB3B27EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 01:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FF313BC0C;
	Tue, 18 Feb 2025 01:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCJx1oVm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF4E182BD;
	Tue, 18 Feb 2025 01:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739843439; cv=none; b=YBvfW6+Anx8trfvewaXcQV2XZjvvvgdhMwzkhwYLfpbZM7suhXGhS3qnVInx9h7AhKCjf38vzJlriSsgBUnh979HPNVvRkGPlF6rq19fjVG6fuMd+jCYJ7qIiU+6tFMjk1vztVtueGQbra4TRr+IJLaWkhyNIseBqHlwajdWWgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739843439; c=relaxed/simple;
	bh=l6ZQJ6z++uOuRLVfZci/jNHlZxwZwwajaI0P/D1lkvY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WSQVJ74HAn8ILPUIXxM/6g2hgR/eqcVLsv1I0hHiP82e3l9nzFw8DVpIYQ9SmT+/96Ek7OJ2chkYi9UkrfwmmDK+vuQ0I30TjfUfe7uwIlnmhLKQfmlXtIAJKRx4Ly8AMfxYYSpouGG+U2bDFPFemvBRHcFSBqrh2tDbmpCbUdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCJx1oVm; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e67f377236so13241446d6.1;
        Mon, 17 Feb 2025 17:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739843437; x=1740448237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weJhfUXcHldRk10NE9FkWe8JXq5XCSHR1Oi1+4jyWyI=;
        b=DCJx1oVm3DGlqBMNML+SyjCeWe+s9rnnnMjxKFCp1eqAKnnuKItx7rGuT2Tu4Ultb+
         P8owDk21VUK1b3EmbToDgovJRu0fonzqOQCptSnpnIY3BG1tRulLiKMqxY0OPzYlxsI/
         nJbzIgq4fDQcsghGlZ0IaHWaWq1KhmdkLIEIC6rMogYCsPuZ7VU2Ilxex5BpoAlqc7le
         7CVOtV2yyfRilAeeCA7UoSti5GDKH8gKxuYv/UCFNXPkB/NC4xSsuORdF1SLEEImc5ql
         kh/1NL1xWDJGuK0HjC1uwEka0WK29D4dhHMRXGnajjSDsj5NcbDlztbH6eOxLL5Xc5Vn
         LO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739843437; x=1740448237;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=weJhfUXcHldRk10NE9FkWe8JXq5XCSHR1Oi1+4jyWyI=;
        b=EfJfEJAb0u76Y+FgVb/XORCUVciaLJF7lgLTrplY2mCcfTl90AoJCCXyQDiwetfOvg
         fqCuhf8jRg1PcuVEyG43s2mjO9Xyi6JjQ4ge41a5FtCy/vCCwgYUvRWs41o0+m9J1FCD
         KQAq7bC3aDzmh+Z2nNNKiuhipSFzVhhjP2yyPw70NA8HMHt/K92VV1Q0MjPCMESEtoui
         bgwd4KUALFkoeGkEs4N0qz6bOnRZ4X2nZLsBiUCsGqS54xtIXK6S8nC6VOuPWIB365VJ
         gNaT9shn0E+H3mc7/sNahyU5wIg7b8xfF0w/JVVDsWhJ5naVcqiSan0YHNrnMW9WiVGT
         ougw==
X-Forwarded-Encrypted: i=1; AJvYcCUOFd73KnU2xgqJ3iMqvfQlMcER5YGUjvLktPpn0azcFnRjVlA7LWHb2bG197pNmxvzzoF8JCri8CV8XT/SNcqF@vger.kernel.org, AJvYcCVZLLjMBo/zTHph1S+U8/O/gvXSH+eQkF/PusAo08UxMSpareOKGlIIi0u2582DL5+cOtM=@vger.kernel.org, AJvYcCWAc+6/f4lUW5OZDkV/DsUh9THx/RT2y7WZwaHNTw4FP4MZ9zKhfkXQO4DuA/KTwR4vfzPD2pLE@vger.kernel.org, AJvYcCXygoEkr5FRX7PvtYy/oEiTB3wPmQj4xL7GXRRjii1bjQwdSOxaeoGSQVgeIMZNfK+4y94971lZjer4lK2m@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf8i9fbuSQgqokKz9jaBLfiXFs7e+awpjzF8XmME0d2gsXiXWE
	+8t5fK7/scNlMa4xxfNTxNYLS9eq6If4sG2s0B2wasvRSYgyuTNw
X-Gm-Gg: ASbGncv6dVpt2X/WL2lbSi9JYi5P0NkjPUoGXcZGtW4bnqdMFLP6NR7+1vbrDIR30q4
	lmaV8aZ6Q5ZHGUW4XnDyOm7dT2fAEkS7fT2llbUuC4BAG72FNnXZP6VnEtadCvXnhuDAHkyRfy/
	2L7pDiQazry6ZXowrQCDq5klCpOnTEnvZyFjzfZ1LN6TpWn0ZqLzMrquf22kOWvc+ilJy3IAzIS
	6n9pUZld+MwYolipa9Hq834x2sV90F+8JsGO6mjIZisWfdIhrSyQ45kgiKH2Uw1lv88b6xMW3ea
	vJeUvfgTCD7tjJvonQvoRoN8qrQUZT3vX6Dkh8/6rH222Mo4jJdgkltF4qnN/NM=
X-Google-Smtp-Source: AGHT+IFfoPLbf5s/N7R2g9lkmO6xNtLhJQ9NoPNUEyPaHPgW8K+dhPbkci1ob3XtTRXjQAfWw4cu/g==
X-Received: by 2002:a05:6214:29cb:b0:6e4:2e5f:c03b with SMTP id 6a1803df08f44-6e66ccce1femr180711246d6.22.1739843437085;
        Mon, 17 Feb 2025 17:50:37 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d9f31b0sm58293606d6.90.2025.02.17.17.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 17:50:36 -0800 (PST)
Date: Mon, 17 Feb 2025 20:50:36 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 mykolal@fb.com, 
 shuah@kernel.org, 
 hawk@kernel.org, 
 marcus.wichelmann@hetzner-cloud.de
Message-ID: <67b3e76c57313_c6df029486@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250217172308.3291739-4-marcus.wichelmann@hetzner-cloud.de>
References: <20250217172308.3291739-1-marcus.wichelmann@hetzner-cloud.de>
 <20250217172308.3291739-4-marcus.wichelmann@hetzner-cloud.de>
Subject: Re: [PATCH bpf-next v2 3/6] selftests/bpf: move open_tuntap to
 network helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Marcus Wichelmann wrote:
> To test the XDP metadata functionality of the tun driver, it's necessary
> to create a new tap device first. A helper function for this already
> exists in lwt_helpers.h. Move it to the common network helpers header,
> so it can be reused in other tests.
> 
> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Both tests that include lwt_helpers.h also include network_helpers.h,
so the linking with network_helpers.o is already addressed. This was
not entirely obvious from just reading the code.

