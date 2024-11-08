Return-Path: <linux-kselftest+bounces-21650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB889C1384
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 02:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05A10B21BDE
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 01:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34875DDCD;
	Fri,  8 Nov 2024 01:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wji7j22u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE701BD9FF;
	Fri,  8 Nov 2024 01:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731028704; cv=none; b=XVOTG+ePOJ9p/hJGm/qs5CvtoraEOHHRDkRLAkunQazsZow80rqbWICToqF1DOKbdIM17Gsmim6wPS4U2ysBaHz8APB5MLc1csvLGKapUpi1va7WXofDlu7aM7pSE92nAH8MEu6aeBdAKgDAtiV6sJlYfdftEPOD9blrdW2zUlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731028704; c=relaxed/simple;
	bh=Y+qOi9StNDWrNCeLn6mxKT2CuseUsVMBOWwSx1S6bs8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWkGNy90QqzEdi++ANYRoPaXZJTy5Vg6CoPSYk7Ufe7E8S6x7z3LHA46lNoDzEDNYE5oZNTeLQRsI+iCivhC3Ft9b2zdKFHX47sxfzX5OJSXrnjlbaW0zMLwFPgIkCexbtvXc543qvrV2rHG2nKMo5yzMQokuBb368QGu7+Eo9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wji7j22u; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-720b2d8bb8dso1156105b3a.1;
        Thu, 07 Nov 2024 17:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731028702; x=1731633502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8cDuOa1WBcvgUICgbCuiS6lfsoFcTeZpS0w3TbLXnF0=;
        b=Wji7j22uKUxV2LXV3L63lIAewOsNLKdPazzNFxRxPDzdIM7xFjJi+PXLDX/DKV+qFB
         NGZxKfq/5VMHiojekAj14yFL61O5x/o+9b6thyXGmHiKq5ihplbn28PBX8+mifrWesPM
         e3vwYfoAVWPHWxyvBWx3JoGaCT9OBQfSuGG7obhoPQg89vJ2INleNOGN3tCjO7I+d9Gs
         Xz3GHWB542Pnzjbi/eG8DCd8CAIY0pzPjiKdnh090k3lr/0ca3b2Z1DdxphPzZ22tpZ9
         c+qNI8bmC6/81YevQay681Z2kfiCK0llH2g2fQQl+wcVe20lVr/bTbPyDAdwuI7Syhkb
         OmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731028702; x=1731633502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cDuOa1WBcvgUICgbCuiS6lfsoFcTeZpS0w3TbLXnF0=;
        b=og4vRuQOawvQFXKutK08L08frdPvS2ZbuWoHVQFyptpZb1GBFEgf9Hb7ngENSwI4r8
         7Khn5sBVfcqRJNxNcJ/6GWy4bAjg6DCGYV+Afhd5LCV/wvaPCvusRL2GLTNEPX/LxgFZ
         gxxXU8ITbycDxXdclgO7k6lQnlkNlKeJKN9Ia7K3B/d5fRzFgpV/EVtadTRXqOHYbkbq
         TRpW9T+JKud2nqTyuHwioor80ilW9DjmN64aRgSnoXZcaTv44nCKS4hiqIuzNex50OkY
         1ijLnUHJSHjSHorPD9YS8OYag3uvhFgwU5Bm+7DfqkHPAjue9v4RimPCqq2Fc90WPXsR
         6SFw==
X-Forwarded-Encrypted: i=1; AJvYcCUvAAZimtzgbJtd4PZ+S2yDUrwQhJ61eo2l5scjYy3sSrfq+9SdtkEj7rJ8Mc5BfVMYIqySsNMv@vger.kernel.org, AJvYcCV5MEkRJhNMxvxZsz/JB2sENLyrir0bVb9kvSEzHKcn/TiMCb8UCUDJsOOAR0XxKWbCngNdmQshWT+vV14=@vger.kernel.org, AJvYcCX8FoSO5Bk5CdlhD3oj2CHCyDl+p/V0yhDfJs1S0zG6IAimlnYFdmGUSXb9ttSckfRDC6l+eInAfkm9FI6ZeUWE@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4eXIBnliUg325daG1L2oYpmWpvuvi6W5fjsaxkaUeaB3k9Ozo
	YTW3pa0Aw1RwXnVU8k0ZyIS2GWzlSi+Zcl+p5qQe7scs4FPJTLU=
X-Google-Smtp-Source: AGHT+IHic32rr0VTC89z6fvxpMe1QpENN9vrJsJO1uP+O3orkP9CZjTgg7oBIQf7xYD2errL+vUyKQ==
X-Received: by 2002:a05:6a00:1909:b0:710:5848:8ae1 with SMTP id d2e1a72fcca58-7241327d7aamr1580271b3a.4.1731028701814;
        Thu, 07 Nov 2024 17:18:21 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a17ed3sm2459264b3a.142.2024.11.07.17.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 17:18:21 -0800 (PST)
Date: Thu, 7 Nov 2024 17:18:20 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Joe Damato <jdamato@fastly.com>, Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v8 00/12] selftests: ncdevmem: Add ncdevmem to
 ksft
Message-ID: <Zy1m3IkTR6GKObKE@mini-arch>
References: <20241107181211.3934153-1-sdf@fomichev.me>
 <Zy0J1_3P76EACrBG@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zy0J1_3P76EACrBG@LQ3V64L9R2>

On 11/07, Joe Damato wrote:
> On Thu, Nov 07, 2024 at 10:11:59AM -0800, Stanislav Fomichev wrote:
> > The goal of the series is to simplify and make it possible to use
> > ncdevmem in an automated way from the ksft python wrapper.
> > 
> > ncdevmem is slowly mutated into a state where it uses stdout
> > to print the payload and the python wrapper is added to
> > make sure the arrived payload matches the expected one.
> > 
> > v8:
> > - move error() calls into enable_reuseaddr() (Joe)
> > - bail out when number of queues is 1 (Joe)
> 
> Thanks for all the work on the refactor; sorry for the nit-picking
> on the queue counts. I just thought of it because in my test for
> busy poll stuff, netdevsim uses 1 queue.
> 
> Having tests like this factored nicely really helps when people
> (like me) go to try to write a test for the first time and have a
> good example like this to follow :)

No worries, thanks for taking the time to review! nit-picks are fine
as wells since they are usually the easiest ones to address :-D

