Return-Path: <linux-kselftest+bounces-18975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B243798F721
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 21:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A3521F220B1
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 19:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C37E1ABEAD;
	Thu,  3 Oct 2024 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rqib2U3Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAB747F5F;
	Thu,  3 Oct 2024 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727984532; cv=none; b=p3T4vK8lOXjpF/RasWrYffT9MMoD5uvoXq2ovDCxHLvsKzzyhw4MbojhLCYunc70/i/Hqd7ljHqtpn+zHuZ94uo1Oaz6HcFazNOQMNve8IzElV4B9oi0NmyffmVauFEI0QAfgZ7Jdp5Hu6y28IjCnH3ebC5XmHTzNl7ikO77buA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727984532; c=relaxed/simple;
	bh=x4cLI0DYtyrosQCV2dvWSZkHQWzN08Fsn5mWIBtZM7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jA4IXdIbSjqZ+8dgE//sSlWW8hFa6zyoAMqi2o86iCj/IH2/L+vnzSjiU+dsc1cjApkkZAs7LBr+vHkL6WjCT3SkaF38euw6doH79Kmvle9lpiwomPFifbAwlPR4Y+KP19QMUKbM3fNc+5wVfhn9oAsFFpeIGqRKeD4a6H+Lj0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rqib2U3Z; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e078d28fe9so1027687a91.2;
        Thu, 03 Oct 2024 12:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727984529; x=1728589329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rtHZamaxEQwNp7xMVBavW0zFD7xAazS/NeXeVFm7bns=;
        b=Rqib2U3ZccSGZY+YxD8uCOVa2t57OD6c2srNCvGK/4MMGK/2xSZ0mgOmr2MgM2kcDa
         SKccDO+4ebXx/vG15z9hvDYMUF7BZWQDoHN2PiunXtxmswMr4oJX07cNlAFnbkd6msyY
         q5wpBtyhjEgBScP9z5hGWiJuZ/06TueHIqkTrhYyRq2i31SuUe9RHsMJrPUgrbDdnBz+
         CwGTBEqCdxvtoxeEK8cQYr/I42KYt2S40JgXonF8URcNiGac+94ZrzREgReNjGyHwh5A
         AR9diHIboRszbV+hwOUnkajR1eCRzoGMH3f0PrMSfQJGOYjfd8xzxYZnU02WsAeqYkwp
         82BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727984529; x=1728589329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtHZamaxEQwNp7xMVBavW0zFD7xAazS/NeXeVFm7bns=;
        b=S0zyc4JmndTlihaetR+ea6IE9OhzJ20VREq5/9uQSOFBIUP8ZgZrXj9SwOZPcrI1UT
         /sMTxLZfvGkTixbO14Ya+AiBJZ5LPfn2MRG1JQIVe6b5mYIvwmO1JK5cU7cGV8bZSlHr
         gveSzN6r58Zy6R+zErtGLEQ/MIbEXe7sTIP5n0kHIs45TqpIk142ySj7AKQC3rwh/5w4
         AiLiLXzgzRtGj+3TfitLLdD+oX29PE0cwpI4FIWj/E8xA4j+KVniKqVN1t5OQyyXUJi5
         WxY+GoCXvHz8PZ6+CZOe0sVGe5jaWgMlV2JveymoLFp1HOPaOA0zhOSmxCE9vku+/rBV
         Gitw==
X-Forwarded-Encrypted: i=1; AJvYcCU6MKe4P/fYCZ0VDz33eL1o6UQROqfbQMf9seDipk8CM4A+m51th/u+VD6MdmXJ3MWDzZ0UcFNIlVi/aMLh0wk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+sg8QvtG+qjugZj4Ig2yI28oAMTlAOY2zHeoBwpV0dxkKgAPb
	py8q3qTeJ/RosdgefFjR+W6QoZcnQQTPdXtxUpiy6X39sshF8X1N9affNA==
X-Google-Smtp-Source: AGHT+IEX1kcNhy9+Bm4ymhkSOcxs2O7884cGEcD7ePFHENrpuQfuhSjlxWhbPauR/TFHA/7kmxOh1w==
X-Received: by 2002:a17:90a:3ec3:b0:2d8:7a3b:730d with SMTP id 98e67ed59e1d1-2e1e6273537mr209865a91.21.1727984529098;
        Thu, 03 Oct 2024 12:42:09 -0700 (PDT)
Received: from hoboy.vegasvil.org (syn-024-043-104-232.biz.spectrum.com. [24.43.104.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f7734basm4247705a91.19.2024.10.03.12.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 12:42:08 -0700 (PDT)
Date: Thu, 3 Oct 2024 12:42:06 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Mahesh Bandewar <maheshb@google.com>
Cc: Netdev <netdev@vger.kernel.org>,
	Kselftest <linux-kselftest@vger.kernel.org>,
	Mahesh Bandewar <mahesh@bandewar.net>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next] selftest/ptp: update ptp selftest to exercise
 the gettimex options
Message-ID: <Zv7zjlp2BqJ7e7CB@hoboy.vegasvil.org>
References: <20241003101506.769418-1-maheshb@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003101506.769418-1-maheshb@google.com>

On Thu, Oct 03, 2024 at 03:15:06AM -0700, Mahesh Bandewar wrote:
> With the inclusion of commit c259acab839e ("ptp/ioctl: support
> MONOTONIC{,_RAW} timestamps for PTP_SYS_OFFSET_EXTENDED") clock_gettime()
> now allows retrieval of pre/post timestamps for CLOCK_MONOTONIC and
> CLOCK_MONOTONIC_RAW timebases along with the previously supported
> CLOCK_REALTIME.
> 
> This patch adds a command line option 'y' to the testptp program to
> choose one of the allowed timebases [realtime aka system, monotonic,
> and monotonic-raw).
> 
> Signed-off-by: Mahesh Bandewar <maheshb@google.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>

Acked-by: Richard Cochran <richardcochran@gmail.com>

