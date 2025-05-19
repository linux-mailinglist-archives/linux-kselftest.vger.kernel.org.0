Return-Path: <linux-kselftest+bounces-33331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4E8ABC284
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 17:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7B83B8978
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 15:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3018328540A;
	Mon, 19 May 2025 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTLICkH8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACCE2853F7;
	Mon, 19 May 2025 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747668776; cv=none; b=hkb2oMJeFVVMzfTlMNpSe2Hcu6z7RQBxpfriaxRLhtN/84RO7BUHMZZVINnqj/rQouUSx9ALNuKCSzUak+Odsnbr5AjirayDBnfnKrK7W5PRnxBwZ80HFuUgbZR62x1ge0RWYZwLFcrMotAD3a93k6YoLFrzh6DeTlCzKgal8gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747668776; c=relaxed/simple;
	bh=6LB6fKy6X4iDBJPSwzcIes2X82pRrwmyCJrME2gqACs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMjgZpjaRxVlwU9gvfbYl00OkKFR55Q1HGk4Roeduf46qLa0jl8AqJlxV4A9FM9fUq6W7t/3vrMATq+GlGu06aKqFVNiGoxtaAcbpa1mt6CNJEMZkC7GmAXKdT1yc3m3bshVKo/VbuG9Y5wXgMtFGOxlHJo7j2XK8IS9WUNZYJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTLICkH8; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so4161735b3a.1;
        Mon, 19 May 2025 08:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747668774; x=1748273574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=imVnNe0Ao3PNo2owMiZneMdfxmiJLaO/Rs/E1Pmt0Bk=;
        b=FTLICkH8/Agfe+aY/QepzRfecb0q7Q8bDlbMH1PDjROLk6LVYM9+5LYLAgPo50fkuQ
         kBQ2AxAXeKNRqSyUMsrxkIL0udnfSrq3tQUkhnX1hweRflZreWF8MRe2R8mXgW5q+yve
         jLUsVHG1JOKlWxGptzeObfpwfSjtAOermK6kajpLu+Tf6E0qSrVfmWpDFGhdtYKh1hHq
         O4S1/rsDQ+eDp93WQUBjqQ+dPxe35jGYnIQ53tCQtDSCfs7sWCidPpgX7aZ3vjbeLqlZ
         +wsMSOmQHL8/BHjuSVkv6+tZNYxlI2drkPgMMKxXtJU9IcLzVs832DygjtpAFmP4FvC0
         0szw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747668774; x=1748273574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imVnNe0Ao3PNo2owMiZneMdfxmiJLaO/Rs/E1Pmt0Bk=;
        b=U8K3ZVG9CKTN9d5B5fbwLm5xKtnfVzqjVmvpl+h+qaYWR3Th9Ox4dEaFKCld+ABTgA
         R22GZV7w6zps7s1+33xVm2LfgPYIyMr7ayXJR8S4ImOKMKGnczEama7PfabZRueVx0wI
         z1cuafbwokc7PD7YHI7r7QsaKSfuDppEMIKyZBSlCPI/h3VEjWPn/ckoWO84eSGTc3M8
         54gHH+GP2IzZ73rVjFUBiqVOQDvoPPXS5GR1fa1lnv4iJj4GXIzjQlzkmijasL7b3iwi
         ZfbFDfmvcfk5RkVWUDwnqhQoHQi0a6d/aFQiITNMYnVwAZmONpo6m+0AafjJSRP/IVqs
         +b+g==
X-Forwarded-Encrypted: i=1; AJvYcCWjeBbJQIP+WTTSqb4G/oJ5Owx05zQ1ebLs49OutuoZRJikf43VAYFUvgmwP37+SvS7IuxwuwbTtBSrRXw=@vger.kernel.org, AJvYcCX9rjvjfWVvGu65WBmXz0i8tQnH1DrjZXokZA5oJtBHwlZE7MX+xcgoHMM9CrZEtcQWkmx7IjyLYGJy7Agoi7QR@vger.kernel.org
X-Gm-Message-State: AOJu0YyKAyRa5c8pUiaPGrKdP12B9YDpXE1zVraZfh8hw6rulwwwiTlY
	YWsRxLUO4WdgvoQh4VgnVZlbW52rSUkaqtFfW7BgUsS29PKkMcUjQnU=
X-Gm-Gg: ASbGnctuqsBekW4AlnN3R2QyGYfAtxGgDCdSQr24E1Uz39YBHJsS1K4Wm62NL9pIUEu
	WQEYGOONu97sVNNfoUa2IMEhXTaW5SIcaODB1vS7upYLVy4/5pjk2gV3NtzAND1GKFPTMqImhGn
	v7tof1fFG5HMd2UyHT+nlE/BuE9rp1QKPh2EfL8s255+Y9jnQrloHVGNxiK6JHP38oCnjK+Dnb+
	bz7K5cI3v5iNpk9yMh/G+vlUMSUL1qqLzJQMdDYJKuFV6ya2qzdg1YLEmfftNvgyUqPyPEp4myX
	9bxgyZuZkfhdv2SeBExxybUrmnNAlnnK5lPtpuqzWyb8aExzIdgpPPZ36YWuhWsHjO4KQLyI5TF
	nH9mbJAnhRytL
X-Google-Smtp-Source: AGHT+IHdpxsil8cpcKAqZYkF3H11zUKw0NDCglJa6q1TxadBWDGdulAtLTA/x6axk5MrN0c86oGkJA==
X-Received: by 2002:a17:90a:d604:b0:30a:9316:75a2 with SMTP id 98e67ed59e1d1-30e7d52adcfmr22198060a91.10.1747668773697;
        Mon, 19 May 2025 08:32:53 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30e33436fa0sm10503036a91.18.2025.05.19.08.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 08:32:53 -0700 (PDT)
Date: Mon, 19 May 2025 08:32:52 -0700
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
Subject: Re: [PATCH net-next v1 6/9] net: devmem: ksft: add exit_wait to make
 rx test pass
Message-ID: <aCtPJA4fgvAVW0D7@mini-arch>
References: <20250519023517.4062941-1-almasrymina@google.com>
 <20250519023517.4062941-7-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250519023517.4062941-7-almasrymina@google.com>

On 05/19, Mina Almasry wrote:
> This exit_wait seems necessary to make the rx side test pass for me.
> I think this is just missed from the original test add patch. Add it now.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

