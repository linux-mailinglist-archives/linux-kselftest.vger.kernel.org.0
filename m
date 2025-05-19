Return-Path: <linux-kselftest+bounces-33333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EA2ABC29C
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 17:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8770A17D0FD
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 15:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181102857EC;
	Mon, 19 May 2025 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiUfjQEI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D969286406;
	Mon, 19 May 2025 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747669053; cv=none; b=n4M6Sq5lhPLVZXNmm/JABoocHk1boJAjHph93AbPVg63leW6MkO/tSFN+yuYXtvv9tGBS+SBxgoKvDmfh/Cp867FROEImLAYhg7xYZ3nVUHYYvoMhEVRFRmV2gzz7pTvKmo10LhFEN4s7i+V+SLxmcusa4JAQNJE2ExvPytZFM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747669053; c=relaxed/simple;
	bh=7omBkPkQgGdXpecw12b4s0A9STdtWX+5vCfHMssAcyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aW20G8LYWT2yqWiXWlSqai5MugOondT4diCMrKjDVvaH951nS9Bf58w+S5UgFcWCuh13GDfrAaAp63nssLz5Z+bzJLeRhS3XjFpOe5Zbcbl9sB6fcGvidZrR56UY2IOAwZ6t3KlnS0Wcv1rLvj9EedoVNj8EbdwHcJDpjM+mYV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiUfjQEI; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-73c17c770a7so4917422b3a.2;
        Mon, 19 May 2025 08:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747669050; x=1748273850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CScvBBuvwALVhyh4CrbSsCrTT2RNkE//FLCsrcm/RX0=;
        b=jiUfjQEI224tn/T3DqfgvuDfKnu+3p2afrYxMNVUdg2cIL1RBpbeq9xL4okJIacMmj
         FdqB9ysfuDOlTl0qHYk6DDbkX3Im0tE4PZ7Wnr4vf0rKD0AVfeJsZaXQx54KO73HbepG
         M5pox65yhtwgwR0HkAd353OT81JbPk97puyZDJ1+e4euWiU7fUPUUO1S/U+uIKvCi6od
         8c87ISV5t4mklXJG+8qhgERzwLYBQM8UtsMRIdxJK04CluR9WBrnjKes/Ss1h7OwY1WJ
         X4A0Bwx1xHGIcNuqwqSLYrk0+l294doNo+PWHf44cJ4+dB0IUAh9y0BkHPkukQ0pY4n4
         L4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747669050; x=1748273850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CScvBBuvwALVhyh4CrbSsCrTT2RNkE//FLCsrcm/RX0=;
        b=pEKOkm/Tn1SL6jYfr6qlnbleGN49tzBTC82nTSa2WeBGSHRe2WxR14fXMFVa+Bd9W4
         i7AMcAXBUZAoL69YhFFIkOyoNedpNxHTuR+2lh9hDVVg/GkhEynKH+JdBv5sABrrbj4s
         j70K+E20OuixVsFImjdtu+ZYkz/0BnywjmE/ttNdjnutRQ4/GAETNjBJQbiVKgpwvYfT
         fS1hbreDYy6LfCU4vWgMnz7XkS88SMjqOYd5mIBX1EN2GUDS0hKuh9izfKFifXiG1mjX
         yCeDhjfJYXXErSMw+8DECb+SWu7uXwzpLSr4qssdy1bjVKFsC5n9xIrXXyGmi9YEmx9P
         fuSw==
X-Forwarded-Encrypted: i=1; AJvYcCVHzcNA+PvJ1nD41jxZBLKKhXRF77qZrr0yHmBW8oIce6fBUQtTtaUpgrZupQrX7Dk2Plhlbwva0zWqrdT04EnE@vger.kernel.org, AJvYcCX01r33HhnDKZQeEWlbr839ozlIKoEFO92kJ/K5sav24ReKoO+gOZjsr+TUECmaCzdl+zaEDQGgXiqU7+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXu/5t6bNRwdJtOZUGEHgOx0ypiGMQySm2cFTEcrHQMC0C+fYw
	KVtT148LNBAZ6bWXkSc/+xezylquMg+QuoaJ5obrePbDgeY9Rx+6L5w=
X-Gm-Gg: ASbGncuGYSEHzZORPvo85flt0+VP2ZytKmyxg467oD2Vn0Qd7jgOS7+1QViCRun8oqx
	6tVowGYDbGMY7an0wOZj0aWgKBr49uDN2gnoVl4Samcx5HF51RkgMU23EoYiZuB85uZtHmMa39X
	AiM1QlNU5S3/U3p0Ks6bBW1vfVoUEWPesZig3Nbwj4PL2TGVuUx/hNP0BY5UR4PFWFjdSxgY49N
	5LEDeYHeFGTht88QyKAmI1tEqo8hzWjlbTKxLYTIT9r8cYGQvuF5nIPViAnqzRuEj4qL4Xp3LEq
	1EIjttYyzTwWsrsQ2GvAW1fShHqpOB4olINcCRHTXVmQbjSfM2+I4B76MSo/NzU9kdlX+7kV34d
	1lX4otF3rfQdukzDbPPNgFa4=
X-Google-Smtp-Source: AGHT+IHUUFV2rAoCWRpejJrfje3Wh7Tby/dZLBSeiYx+l5Wnk2nGbwMkgxesT6XnT0sk34aMMlrEuQ==
X-Received: by 2002:a05:6a00:4606:b0:73e:5aa:4f64 with SMTP id d2e1a72fcca58-742a98004abmr17675317b3a.10.1747669050606;
        Mon, 19 May 2025 08:37:30 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-742a9871500sm6496235b3a.131.2025.05.19.08.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 08:37:30 -0700 (PDT)
Date: Mon, 19 May 2025 08:37:29 -0700
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
Subject: Re: [PATCH net-next v1 8/9] net: devmem: ksft: upgrade rx test to
 send 1K data
Message-ID: <aCtQOek-wLqSh38g@mini-arch>
References: <20250519023517.4062941-1-almasrymina@google.com>
 <20250519023517.4062941-9-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250519023517.4062941-9-almasrymina@google.com>

On 05/19, Mina Almasry wrote:
> The current test just sends "hello\nworld" and verifies that is the
> string received on the RX side. That is fine, but improve the test a bit
> by sending 1K data. The test should be improved further to send more
> data, but for now this should be a welcome improvement.
> 
> The test will send a repeating pattern of 0x01, 0x02, ... 0x06. The
> ncdevmem `-v 7` flag will verify this pattern. ncdevmem will provide
> useful debugging info when the test fails, such as the frags received
> and verified fine, and which frag exactly failed, what was the expected
> byte pattern, and what is the actual byte pattern received. All this
> debug information will be useful when the test fails.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

