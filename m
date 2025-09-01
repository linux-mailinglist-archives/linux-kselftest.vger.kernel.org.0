Return-Path: <linux-kselftest+bounces-40413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 195DAB3DD8E
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 11:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A561A8061E
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 09:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4035E3009ED;
	Mon,  1 Sep 2025 09:04:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E022FF150;
	Mon,  1 Sep 2025 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756717455; cv=none; b=NqHDomKs854i4IJhH4cx5cwk69hibqdaWBUP5lgX8UD1FBSYE+VgLxzp1HoaYu7+IFaz/i9hw2yXaP1h12ONV30zbRa3ClCaJ+wL+iZQ9gAPyaU+y1qr+rWXYl3ZC5i9ftpqd8IgPG0SHqLAZWfoCSqEvl0M2H321lvwXKYkDFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756717455; c=relaxed/simple;
	bh=2W+7mm/VSilBfGoga1u6ewXwGdh2UWJlTe5+uryB7CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ck4Dm1H4r3VWRNNyHd0O1vPjK7kItrFvKdpM1zwQ2UShfoFg5lwxMeOyFB0zIpiyYUO1cDeSOgA6vFIpHiBzDMG/7EkUsPiobrLfpAA2EeCpCgmgDoorqml+9vc2fVQ20qgfUJKOGHO/8VB8FkBRy7dVDaerom8lfImZWrOAGrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afebb6d4093so681888666b.1;
        Mon, 01 Sep 2025 02:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756717452; x=1757322252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8ZvQxvRV3M0eWb4K4PQVTbbFlH1TfEn3EqssD8X/qw=;
        b=lFteycj5ijuZ8k86mGIJMs0enpa3wiusZvzDydJ1VT6cfS3L7/LeZMj5GeKRXMCitv
         9B13hI8CYgHhiU1pHdWjv0IyWAOawtxwNqC1UNjy49bJnuVcINrkbSPJywmFWWcazcms
         Wk47mnYzEpRzlW/hhz4EEjZ7M12kqvvIg1LZCJ6NeWtiLlbBMO191gqSnLRWaORficqr
         X4xAH4Lt94PvRqUtDmqIRY9sN1urIMpWaxiYTIfjiyeyZnJzKkmMBpkrnNFOBFWKsdG/
         qmB6/DwLT+3U9a7YPE1pBzPOa4X2YFGjdiHyx2/ssCyvhiGUg3x/juIWqkmu16R+9WLF
         y93g==
X-Forwarded-Encrypted: i=1; AJvYcCUk9CA9xqKDxGZjbp0ZxRNl5cr8t+sNwIXZqwN158j7qT9EwOmh1gs2TiYc7WYAnlpSaUvoB6Rc@vger.kernel.org, AJvYcCXvWqoDsPReKBi3BoBOlAATySDISX5FbD3IDR1j6DHFJupiTOwMu7nnRCM78Wg+aie/fv2mPJh+XNK3SqRpsY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Q/PfDoBjNzz5E/UzDNy1XlYOHWm5/hQtcnsR7aLdi1nb/jdb
	ETRsJ0epHS3l/FOUOCUSyT2INbOQ+mUtnRUG77N/WEIPGugb4qWB1BUj
X-Gm-Gg: ASbGncu5mJBVeb4vfVKlh5aKENZqsDEb2PhW8BNozvSk69KM+fiW5ThzPgh/3nNQdTa
	v3+3iQwA1atHGuoQSQe9+4HPy2DuMUhqtnShC+EMBfug7zeqJce+BA58/GO6OYAi4Dmi2qjMQ3G
	o2jvvl+7vSjjwhS/5CcPA2iEj6vAyhU3UeKZfI8F6hSKiwFp/hxBEmxYwlCprV1ub/nRzK+4FAB
	9YDUeQ+2tgSHQYrMjcEL0o5HSHi9lXdDWambHFhb82NivpH3xnWT/OUd1l26J6J0GbMQb08SP86
	UoTEKkkx8hkKGSyzd6i9nvOTxq7IHZwLxP3cmXq9vMIxsnRAldFstdIvdB4OLK2TRB6BSRfOdMB
	C0PGzo1vPC7cFXw==
X-Google-Smtp-Source: AGHT+IFhDMkphQ8qgNN3rE5HRQSbVnCJIc7eX1Rdt2R96T7j5N8dAqlVYlygpHZvKswyKpg8oXgaTw==
X-Received: by 2002:a17:907:6091:b0:afd:d994:7d1b with SMTP id a640c23a62f3a-b01f211c5b8mr666648166b.64.1756717451460;
        Mon, 01 Sep 2025 02:04:11 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b03fa921a32sm477321166b.31.2025.09.01.02.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:04:11 -0700 (PDT)
Date: Mon, 1 Sep 2025 02:04:05 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, joe@dama.to, 
	sdf@fomichev.me, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] selftests: drv-net: adjust tests before
 defaulting to shell=False
Message-ID: <kul22n6x56rlzo6q6nm4boq575jzaur2lbqy4nnvkifsxpbdqb@xr2cn2fd52bm>
References: <20250830184317.696121-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830184317.696121-1-kuba@kernel.org>

On Sat, Aug 30, 2025 at 11:43:16AM -0700, Jakub Kicinski wrote:
> Clean up tests which expect shell=True without explicitly passing
> that param to cmd(). There seems to be only one such case, and
> in fact it's better converted to a direct write.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>

