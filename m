Return-Path: <linux-kselftest+bounces-40861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C63FB4601F
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 19:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C41FA162B34
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 17:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979093191C3;
	Fri,  5 Sep 2025 17:28:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90EA3191B1;
	Fri,  5 Sep 2025 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093310; cv=none; b=L1yTi3oZVf1bDd9oYG4kM/as5a74iJysm8EKBsg+KiBwoLzfTgo5c84/FPqUJyXaGAYHWNBvZiVpCY973yzYRuhS3ORvwcFyK1bXlq+PQ343WgJuSeQdKxd6foBd7YDSqmXclFEPSg3yAN65LPOEq1lrBscjzyuVg2EC2PeUyic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093310; c=relaxed/simple;
	bh=n8LTlK/QUILOghMRnynkpFTd9U6GJoTityV7CtqlzF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGgQpKT6Kr8DmBGvj+yA5iV5XxoZONJu3kJRSMqPG/kaES+fuSW9hc2u7+HAMU0He8EenyFYCQOa89NxyMv0fOxsIobeHNCUmngDN6MQN5M+siMicyNmSKK/2Lit9bTaFIANfkyom3g4nnlSCt5OuNOyxUn+hfl08TKAYY+NUDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b042eb09948so440924666b.3;
        Fri, 05 Sep 2025 10:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757093307; x=1757698107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIS0xj7/1wkbG7klBxWxd/p3ZEfpHI3pNd+rkKtoedg=;
        b=wNVbGCyBMR/53piC6nT8YdYre8nOeVc56nmbcwWmEg4fzzE3F5vYP3ZyAwn3W8VOPQ
         m/aOLorzst8cOCZHncefC+l/qNzEiC8etX2eaqidimU7hDfgLEMsjytp8bIHeHBDQuec
         i71fQ6EKpdqcN8HIXR+zxnKS9PKmr1mYQ6bfiPNFljhaPuHrp56H1mXgu6Z4uemhnCwW
         WZhXGCgeB6vmcmTDqP9YI+VdXOlmXpcoHbGPgO6LguDxKhz72RRwqbB4Ms/2t/AgWsdZ
         WC6626h2QJyOzmdDhPJ0yuibKOUANZq4q/2ti+ETtjWHF7IfVKhDVopjTejAgJdNf55j
         +JAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb6yP5wOQAtMtOZRM5t03lsod7Tm4AOKPcnjdup2sTV9W+nPacEAygkevICCYszOwFEIfc1Lnw7UQWXirXcLDf@vger.kernel.org, AJvYcCUe/uWPQLepA8B4WITd2hPTNhp5CkGH4kNPP9NSvF9hWokv/+c1DKmzLsIv9knmtpyqBx/5ldkClSOM7aY=@vger.kernel.org, AJvYcCWHMVjaQNaNPEAmcTLqrvHl07o2pYLLwah+XWPcLimAIbbu5V02P3kqEYdDiksiE6Ozu8B3Rj8v@vger.kernel.org
X-Gm-Message-State: AOJu0YyEXSlFom2fcWWPjQ/rwS+5uVJLJddwROEPPNNTKeYBi/W3h7z5
	qFfbtxMQSkASD5pGrsULZZ04W9GyzfS9KNiSNv3bI4Us3ZVBhSbcVLi3
X-Gm-Gg: ASbGncu5lUh2BC8pngy/tyO0lxFuPNbkAX08BO3IH74KuPzSt5DoGyE+0/NFxXdMat/
	SwbSLQ7U4JHGX36aigaCR3to6GIzAq2nQ25bY2HG2GoYhxjwIB1xiGF1TpTM8/DkzkDhZdCKH7w
	jZmB/+fEDAwun2bcNf2sBLlsbD/CgJt2TsqFIgpZI0qp9X1FBoGpkHodSQ1IBWzDrUGctKMDct9
	6JLBLcSCCJeG65yiVHj36PX0hCrJcv61WMGy281S8jckh49c9F7PINt56PVe+5woLYf5qU9xPg1
	3f8UGoIBr8gluRSCGSxUgDmAw6725AXj1j8q7RzXYD6FZDdfvtOV11c/8hBtz/dM/C5+l/tJ4f0
	K77QPZ5mot5qOTl9qolt3Uf/J
X-Google-Smtp-Source: AGHT+IGQu9KRWT87zu3zQXDe6q9Hj3PmpKvyr8QxNEXEY9pWpDlHawoSPeUoVh9C/rQHm+WkCDo2tg==
X-Received: by 2002:a17:907:c14:b0:afe:fbee:88a with SMTP id a640c23a62f3a-b01f20bc537mr2478492466b.59.1757093306932;
        Fri, 05 Sep 2025 10:28:26 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff0a591819sm1790884266b.41.2025.09.05.10.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:28:26 -0700 (PDT)
Date: Fri, 5 Sep 2025 10:27:51 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, asantostc@gmail.com, 
	efault@gmx.de, calvin@wbinvd.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 0/2] net: selftest: Introduce netconsole
 torture test
Message-ID: <4suklxl4t6ulo5ndlvw23rk6cgpza2b5qfrudszn4oothihyuv@zgelxgrgfe4k>
References: <20250904-netconsole_torture-v2-0-5775ed5dc366@debian.org>
 <20250904145925.101e2091@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904145925.101e2091@kernel.org>

On Thu, Sep 04, 2025 at 02:59:25PM -0700, Jakub Kicinski wrote:
> On Thu, 04 Sep 2025 11:00:39 -0700 Breno Leitao wrote:
> > Create a netconsole test that puts a lot of pressure on the netconsole
> > list manipulation. Do it by creating dynamic targets and deleting
> > targets while messages are being sent. Also put interface down while the
> > 
> > In order to do it, refactor create_dynamic_target(), so it can be used to
> > create random targets in the torture test.
> 
> You either have to post it in the same series as the fix, or wait for
> the fix to be present in net-next. Without your pending fix this will
> obviously not pass thru the CI :/

Ack! I've sent the netpoll fix and the selftest in the same patchset, as
you suggested.

https://lore.kernel.org/all/20250905-netconsole_torture-v3-0-875c7febd316@debian.org/

--breno

