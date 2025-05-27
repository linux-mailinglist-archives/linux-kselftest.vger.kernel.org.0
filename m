Return-Path: <linux-kselftest+bounces-33873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 865BEAC5226
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 17:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8573017FAC1
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 15:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF3927C856;
	Tue, 27 May 2025 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mb4o1GKQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC4127A471;
	Tue, 27 May 2025 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748360032; cv=none; b=t0r3i6wVDU2dl7KOER7WDwPZQtzMEiXH/gI6VQ8Bo8s65YcKXd90oIPQRw6upl1kFUXQlwYjmT2bPvu3V5lr83xg/iJUV9MH7V8mqmGadcRS6vZbv07/WA00vnqXkoIOF5m924yEUcYgzNuRI6QS1zGE8oLX0MzRkpB59Q0cCCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748360032; c=relaxed/simple;
	bh=9pYhPiFORSyVCFdE4im4u7nvqON6TKB9NoQSdgrDq/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUpHMoB+0+7QfNdtjVfdNzS5iTcAwn7F/iaNPrS+FEZrQNO+ZAIsH8PWNNK3wqpMXa+6Y2FAI7Dn1qxbDiY7TzVm1yVf/FFtQo0pxtGMstQ1PJhTcRXuK9k31SUnsHKEL/UsDytfe3YfLQSWh5Kqsd6YtZfV3DtW5SIi3MqEWE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mb4o1GKQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-74019695377so2215972b3a.3;
        Tue, 27 May 2025 08:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748360030; x=1748964830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNOjCwIIDMPJ37Skg+fzTi4Z+j+PI+sWpPRKVo1Zjv8=;
        b=mb4o1GKQBNB8XqTuzKX9FpjnRGQDMnR2M/mkHq4bcOqN7SyEjMEBk5RKpJapvMCyPS
         9AA/FsLq+ruQG7LFJE8Y/IRTdvmLYVyPxEecOoGggpVupynCobhuWApuhdv4mgkSEIW9
         e91UYAyVFMHF0hgVd/NCkofj+fm0YJkPYvo6GniWnbgi8MKGIznOQtZZMFsFq24YdTAV
         hRmPBOuNY/IBW59L+ce9mnJgP/cnt0nah+tr1COetkAVIzhnj+dgOI9RvhB0PZ0Fq+8E
         nqdr/q734IyapwIS+XfxyK3p2cMT/DFNJHvIY2/JptFBFx9QTqWjqTg0U+KtJjXzUUMp
         8YEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748360030; x=1748964830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNOjCwIIDMPJ37Skg+fzTi4Z+j+PI+sWpPRKVo1Zjv8=;
        b=h9uc/VLZ8mCBjHPtE7yHDzdV2LgR+ya8F8r4KW72reA/Of8S5aYiBetyKJ57zymdJN
         qHnVnNhdPOUo3FqDdZafB/XW92gl1AHZgodBWnlT+e8EaC/dqPRID7qs+J60tindOwI6
         i5mAL3KL0C8MhewKcflAgNlSb/SG+kKHg5Up/XqQU7hp/mPPsG30orQBCI94Ce83o060
         DusP1enTEWxz985mP3UoxWeWBhZe5/rC9xPtsICDlOzuTKENNXvhlkI0cVYq0iJRHu0S
         NTxvE2FQlLcgnAFjDV4IXgaPP/xzZNFgq38CxMIXRG48t3/J5FpJlVwq9WIAE6ky6GEu
         ESdw==
X-Forwarded-Encrypted: i=1; AJvYcCUN7CKE5hSJUN7wxtHBSFNUQPO+xEzW6dWzgukthxJ+aT8GQHFC6JCC89HeFsVCCz+fNQhGTsIsKb2eKs6eD7ag@vger.kernel.org, AJvYcCWAjZQxmOhzcyruCWhEPyf6Ni/7coHBiXIz97KlCMmY12wJ3G1/RyqXniggq3Rd+xQtyNTmjtoJMd2+aZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh2J8c8BJf91dg6brrPy8x+SYQlkDW8bLiKFiu9DyraDT7gJ1c
	FIMCMu4Ww4xhzpdcCEoYXiSrVf1pxFuOVcDv8Inj92u0V9vl/hA6JbI=
X-Gm-Gg: ASbGncva1yLXVIlouv3oc/UsrWge4jxCz6KKlYtODaHeYAiGCNbgFIap3MX8GbbINCG
	wN9vG6297JIMzgm9ewWT7lFjgWBovWPjdfAS2jw0ew3WnKL9DbSMoLxvtLcyS/5nBZspJhJMloa
	QIgrfbDXJUQO33c96mAg5a5873dAJBGMSh+3qW6FhZu2F+bHEO+iLpK9sl5w9qriCTNKpOa4W/6
	+Wu+vey3LuLwH8BQg6huLCMQuapyhEgX4OtLkWZFHZ2DO2wFdhpbcj4rmHGTxbgLRPWAqWr/I5L
	BTCbKp1eUh8ELonGZa/hiqrR5frxbbPqxCIkedi5Jesxw47QDNHcrj8EyiTfqoIan1GyUvgIB6f
	Ups10EWQ5zRlI
X-Google-Smtp-Source: AGHT+IFmb+t/ZQWUXaKoQuOL6pPISTk63XzzO8/sxcmNm59w3nmEzYNAmF2I/1SV2YuC/zGEykJTNA==
X-Received: by 2002:a05:6a00:3c82:b0:740:b5f8:ac15 with SMTP id d2e1a72fcca58-745fdfcc559mr18108785b3a.10.1748360030206;
        Tue, 27 May 2025 08:33:50 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7462686d95bsm1544164b3a.32.2025.05.27.08.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 08:33:49 -0700 (PDT)
Date: Tue, 27 May 2025 08:33:49 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	sdf@fomichev.me, ap420073@gmail.com, praan@google.com,
	shivajikant@google.com
Subject: Re: [PATCH net-next v2 4/8] net: devmem: ksft: add ipv4 support
Message-ID: <aDXbXbqsVkMZF7V9@mini-arch>
References: <20250523230524.1107879-1-almasrymina@google.com>
 <20250523230524.1107879-5-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250523230524.1107879-5-almasrymina@google.com>

On 05/23, Mina Almasry wrote:
> ncdevmem supports both ipv4 and ipv6, but the ksft is currently
> ipv6-only. Propagate the ipv4 support to the ksft, so that folks that
> are limited to these networks can also test.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

