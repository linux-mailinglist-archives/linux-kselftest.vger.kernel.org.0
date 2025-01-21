Return-Path: <linux-kselftest+bounces-24876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1171A17F90
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 15:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEF427A2B95
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 14:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E911F3D32;
	Tue, 21 Jan 2025 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ACp7ShVY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CCA1F37D0
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2025 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737469168; cv=none; b=iTrFI6Xt0t57tS6qjCQR/gNwgTcTm51kP0yTb5Lgr6cFzMl/gqjpXy3RHS7xmdI2jw9EQGDjUP6GLbSV67AkFPuKJyIT7Don4MVYnA+bAzYmzlahSQ/xuA7VDaLBIWxL11lSO8qyAkPh5P77Qruj9ZsmoMYYEy607BjN1iTyE2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737469168; c=relaxed/simple;
	bh=RXaX/4JBPfJSpFcIrzvXn+zoEHs0Bl1F58nd9lsQb6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dt9kxfh+Er4ZGGwoBf1BnHH5PXuhLAqo0dyubzuP4NW/kFPKoSXgMK1H25+msP8yRadx7F7mgHRUNsOPFwXQZxvRQ/Iemzd/w/O9MPrHe2/ZB/OWF7xqpJ8DtVk8HouMs6OVphXq5w5L8CJXRQURo8GUIAO9oW+H1DWNkYGh+vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ACp7ShVY; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab2aea81cd8so957320066b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2025 06:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737469165; x=1738073965; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RXaX/4JBPfJSpFcIrzvXn+zoEHs0Bl1F58nd9lsQb6E=;
        b=ACp7ShVY8p6wbYZV1w/a9PNrHT4GNgkND/j6PYlNu/rMLaHPfd4IfBosLFdAn861NA
         f6R9shDB2p9bWdKh6jfIAOgPjukJsCoKn0dfAwlk1X8gic4hHPKfs+tXE81XwO8Z6kf+
         zJH29XSGdGveHAITM29sZ5G1xW+wAIeGFeAa+iXm6E6rItVWvP+kjYjveXhc1WYXohPL
         tQC8RfUNyODeJ2wWUuyc4rK1F0Gu3ZYonyLxCrgZKkeS6MZUqHnP9p8MOTNDJ8GVloOS
         m1uSXTPnyAVAYxPGZLx2g2RcQZs/mMjq8ifd62b1MNUQV21ngv0jg98uctqsgslwgZ9F
         aT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737469165; x=1738073965;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RXaX/4JBPfJSpFcIrzvXn+zoEHs0Bl1F58nd9lsQb6E=;
        b=Y0+LSLD2YX/X2pFmG5O5R22gfOopK2T27OprtyEdndJzeotTlaPBwSdzMnIVzGLovK
         YBOoQXaycyAHSz8LGo5xdn+PA0V0JXJzcf4GsnZ4/20ClFfod4IpdJMadvePNHhTCGW6
         Ee9yHfTFkoNP2IOtfQqhvW/r/+zaZHL0tOg2Ekgi3pamnM46hSewgkQzB8zOrYQQ4w+T
         8zSaRcl3ZqSscVaHhJpJlm3UMo8JAiKvzVK99BwtoEiQU7ceLbE4DnDVIRfuj4StbEEf
         En8duB5SPwl9GLoBnPwz1qEGr/9e9SOHlhyd4ErYqzmTi+3RnttQEVyzgA647RDJL5pE
         KaBg==
X-Forwarded-Encrypted: i=1; AJvYcCV6qJ8EcPm1PSMDtouuYz186lo6PKEMDGaueFAwTeOLxk6OTXyTuXLB52sL5JUKCqPdrZqU54oYMx5fzZxfJOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP9OfAl7mPPAT5zZnjheSxa8ZEFJiUWGwvqjQZJfbPoJ8qKd0S
	aHbnNMiU2gQAjgAMtmEWsTQyNAVD8IJXrDmZbNa6PZHZMq1oi+OxNvy7IjCCvJs=
X-Gm-Gg: ASbGncsD0jWRK5gkVxml9i1tO204hbqAV26EIpy9Cu05CH7Zo28grfXiFEl2uoGsmIe
	C/R7HSifvHIZ/pwEjFZjzrcS/Ia7diwxc/X1+4ngg5+BVrqIKGtPwYWXjKhlbaNYZAttzvtfSBX
	vkXcasAeu3Ct4jBfmN8dSog5yoeSYvM2KeiTy8zeMBy2UFk/rGh+vKgBUi+17o3YSlH0JPwnx/s
	dLi8ckXmVDdXYRaIXu2A8YufqXqNI7oZzx/mQx2md6vY2SFohqC1b6eJRwWyZk=
X-Google-Smtp-Source: AGHT+IHqoZlch0NckMiqj2j54cDxGsvFFhBkVOqSDvHro+EPMUw9uzJs74fAnODhJFiV9d7n5h2OUA==
X-Received: by 2002:a17:907:930b:b0:aab:c78c:a705 with SMTP id a640c23a62f3a-ab38b3d4253mr1645512766b.52.1737469165234;
        Tue, 21 Jan 2025 06:19:25 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506c:2387::38a:3e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384c61388sm753778666b.20.2025.01.21.06.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 06:19:24 -0800 (PST)
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
Subject: Re: [PATCH bpf v8 1/5] strparser: add read_sock callback
In-Reply-To: <20250121050707.55523-2-mrpre@163.com> (Jiayuan Chen's message of
	"Tue, 21 Jan 2025 13:07:03 +0800")
References: <20250121050707.55523-1-mrpre@163.com>
	<20250121050707.55523-2-mrpre@163.com>
Date: Tue, 21 Jan 2025 15:19:23 +0100
Message-ID: <871pwwi710.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 21, 2025 at 01:07 PM +08, Jiayuan Chen wrote:
> Added a new read_sock handler, allowing users to customize read operations
> instead of relying on the native socket's read_sock.
>
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

