Return-Path: <linux-kselftest+bounces-48193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2430CF30C2
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 11:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EA4A30191B4
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 10:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B23316198;
	Mon,  5 Jan 2026 10:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYF5YiNx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AqIJNU23"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF5D314D05
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Jan 2026 10:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610018; cv=none; b=SXcXLCbQJN43JO5GUCKU/RBYvEhEuPu4+/ziYkZ8vdwzW7yeUCLezIL+rw1FP+QnFfHQ31KheKE7P0uq81BDz6QbxTcQjye5vdVvZJONZZ+PXG3Hsl1U1e196Dchw6CmuKdvN9OVqZeRNVMc8p42w3zdPTjkKpQnHRubjXg9fDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610018; c=relaxed/simple;
	bh=R92sfuFN6VXvFyeKVBFJ2uVf3HN5zZU1eiBvYWPC9Mc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LlF0zqRH6saz22kfMfsSiBGenQLMM+yEVCMvYIcJZorFO3fOcl3m2gryNqtLTVsbavFh3yOIQCP2ywpj/f9gu3+ZeO1b/qUvQAVVqWowIyoNXUBgGOPeHX0ooWIWeYFvWTz0llR6YRgzKGnuaIB+/fX0jT54w4XgVTzl3HxkZkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BYF5YiNx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AqIJNU23; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767610015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R92sfuFN6VXvFyeKVBFJ2uVf3HN5zZU1eiBvYWPC9Mc=;
	b=BYF5YiNxj1IFt2k4vS6FjU+hJAPTJi/Qz8ADE0PpYHyU3kpQ7rQT4Or/Gers6b94KTH5TD
	oOiuvdaD82H70oo74Z5XK197rckCM6VqqLqGpijKmBd1969IC+rZRaiufs8mND5KpJgl6K
	ddbsJJpdcDgaMheJeWZmYF58kTy3XAg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-yhN0_E_OMHWHHi0Isd_4Nw-1; Mon, 05 Jan 2026 05:46:53 -0500
X-MC-Unique: yhN0_E_OMHWHHi0Isd_4Nw-1
X-Mimecast-MFC-AGG-ID: yhN0_E_OMHWHHi0Isd_4Nw_1767610013
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b801784f406so1423157566b.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 02:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767610012; x=1768214812; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=R92sfuFN6VXvFyeKVBFJ2uVf3HN5zZU1eiBvYWPC9Mc=;
        b=AqIJNU23+cyvHoACgS/1MqPnLi3XCNDBs3HjzrHQy0oHyrfMla3/tyDkuwtPEnWzqB
         l5LcQ1ITM2SZecvKD3bGR63m7z/nzyoc6mEskdEMjb12G22RljestrxmVZdKPqW5OcTw
         Sg6AH91AbmaUT/vT9MooPLTqifFfWyeH+Z9TKqlKSHGnwjTH1Eca5BUz9R+qYB+w0ruf
         DwKe0LyRatFFjoKKY2GxrVTCCU18tp78Jtzecssp3uhQQX1BrN8QSKGqCnxPP6rTSQTe
         +kXeWTVc9cR+LmvLxL/+6vzMYF9ECRGk64qBMD3DzUaSXOXEX4yWgy9yJd7BqBRRxkGM
         XtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767610012; x=1768214812;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R92sfuFN6VXvFyeKVBFJ2uVf3HN5zZU1eiBvYWPC9Mc=;
        b=eh1BZyh9DGCaDl+eJhcYRF2/owifxN3/pyEw+2ix0FkKq1Si84VkkOJlDBVAwM5tUI
         M8OaJOa4jefKxKB79CTovOxJcspUTcwXt5dUp/kHD6Tg8cUcnbe4iCiUJOdzF3AGIwjJ
         yiOuP/iDjXEU6FO2/s0eiJbFfLcPt3REIXRmx6XH/fyljbiST8QKNiSDNCdWvYtoJzF7
         xPvFPFMCLYQVC7ol2hT3Jemy/42/g7VaGOhCSOgrtpAPjVkknDyJyiP4+UZrzgdebplB
         K4BtrNfIfl9YV6TdZ+C2u0w6urnINWB3qzn1ZvUFR+19S8H5EhOVmyNdQLL8PPboVA+V
         zi8w==
X-Forwarded-Encrypted: i=1; AJvYcCXYSriXg9P6nVSMtLaMqas1SlGS0f+7kUNyJuhCGkFA5ESD4GQAwmpyQ/pl9M8CF9ZS1vNnUEgrw/GDmR4RTok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDn5aK8JptA6PpkeIgY8r/wzCgyvJII5okQ6H71LUNMK2n+ouS
	Wdja+TkvnafAx7qEttVGOei2SolZvf30RNpdmtm82plj8orDSIGg50oeC2e9lFNnRh+tkRotRb3
	GAu6AGWqah6LJd17QO5cK9Tj3dzs6/Ylta3YeLKrZMv4tlX0SKoN34NlKLPwUaUOYBV57IQ==
X-Gm-Gg: AY/fxX6lySplAMH8gQtoSgvBq5/lbxSwh3/WVYslXW/ce+mhDT9Xlgs7Zl8RS3HU1Ke
	plw7H8rSL38xi3HFMoa+1xr9vXW3aNaaJBu6EvoJQGTbyl/HdD8o4Q/DBHd0kkZF8LCbP/qtxZA
	LX0NjP/WrPZfQsRBB8Z6Fa+owMCNQ0HLktnt0+B0F1b8hS1I+Vv2mwPHToOPnCfZDUz0KJ0b5l5
	dMMJByGDVlLaRvorKxCvGCumtYpO/Du/PBM0C+ZLdWVfbL1SMKxJh0rtSVCKNDipzOeR1j4Fq4h
	w1rgYJqgaXFAS7v4cxhGDBVKV8tT7YdehPxB97VN5J7mHR/6Ikd2EZlUMtDggooFkBSAbGJKf/d
	NPKT3TjZ8AxSWWnzgNN0dj9HHYHhEXSrRqqiS
X-Received: by 2002:a17:907:7fa8:b0:b73:572d:3b07 with SMTP id a640c23a62f3a-b8036fac50amr5432252166b.28.1767610012538;
        Mon, 05 Jan 2026 02:46:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxo3GoSY0pg7482wScLoSxSpKHDG2VZ6RLjUNgrk7dLDD62D65GmPP+NwI+HG9Zc8LUzQ0vg==
X-Received: by 2002:a17:907:7fa8:b0:b73:572d:3b07 with SMTP id a640c23a62f3a-b8036fac50amr5432246466b.28.1767610012006;
        Mon, 05 Jan 2026 02:46:52 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f0b12dsm5538526566b.48.2026.01.05.02.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 02:46:51 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 56B2D407E63; Mon, 05 Jan 2026 11:46:50 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, hawk@kernel.org, shuah@kernel.org,
 aleksander.lobakin@intel.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: KaFai Wan <kafai.wan@linux.dev>, Yinhao Hu <dddddd@hust.edu.cn>, Kaiyan
 Mei <M202472210@hust.edu.cn>, Dongliang Mu <dzm91@hust.edu.cn>
Subject: Re: [PATCH bpf-next 1/2] bpf, test_run: Fix user-memory-access
 vulnerability for LIVE_FRAMES
In-Reply-To: <20260104162350.347403-2-kafai.wan@linux.dev>
References: <fa2be179-bad7-4ee3-8668-4903d1853461@hust.edu.cn>
 <20260104162350.347403-1-kafai.wan@linux.dev>
 <20260104162350.347403-2-kafai.wan@linux.dev>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 05 Jan 2026 11:46:50 +0100
Message-ID: <87y0mc5obp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

KaFai Wan <kafai.wan@linux.dev> writes:

> This fix reverts to the original version and ensures data_hard_start
> correctly points to the xdp_frame structure, eliminating the security
> risk.

This is wrong. We should just be checking the meta_len on input to
account for the size of xdp_frame. I'll send a patch.

-Toke


