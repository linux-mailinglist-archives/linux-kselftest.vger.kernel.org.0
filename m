Return-Path: <linux-kselftest+bounces-46398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC08C81FEF
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 19:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 388F94E6B02
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 18:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58113176E3;
	Mon, 24 Nov 2025 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHZhVOwe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA07314B84
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007210; cv=none; b=ISzWyFTZMMsfWIgzm1+t533Y/t5i9ivYuyOKC8Uun+7wsBX3nJyoJwfXUxmQShQxAJVQe3L2NOJkB2lcs+GF/p+YXJU+p5d/0kRmbZXUaFgX5KODXvLA6GmOjzNBqEzFBBYDI+QNWsbYMs+ouYSoy9qHDJIuCQwIIOmlxJuDV5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007210; c=relaxed/simple;
	bh=xeKarZkaklyd3gpxHsuk4C9/ZNiv+OwseAeiICkTRg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egjrOA/m/nxNFq7Ehngf3G5paTr8WD71JOMIDybYvDW2CoJpChZdbkkzm6zpc7UpQHR1d24N4A3hOsFyfkTyrDlQzUHA39K1mlYbJi9bbTQIrBX8YhrGmA2jBsvwv386a1zUg+9+4RAlZr/qF7qXY1Dka/2VhcC1p4Qtv2QWsFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHZhVOwe; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so5177553b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 10:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764007208; x=1764612008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mwc0wEErQjElnL7obMEURy2H0bzgY2YYjZc6h4X9QZE=;
        b=eHZhVOweU3FA/ObZnOxFSKw6bziTB5HuNNnBnnjN3ZUyjp6Dvymj+/Qy6C0UWmKCCb
         voPFInL0v0b7nqOxLl57SX6fXQM2qAczjb23um1E5//v2wBOjoJNNyyXqAlgwkiqd6Vt
         uXPmJd+pe/iSLxoVi2KPFrg1gD5Pbaqi9sVO5T81BTl6FM6KdA6eEcc0VXVFVo4Z5bSL
         UUPzvF16CdLFjl+6fajuBcxOhfJbbaM+9Ty1oX1Ez/An6nGXCX6I/p1ubvHVbogO0+gN
         UZHX/qsPlMqIH6exdPmsbmItNioUCFkFMu1XOJ5xuMsz/JMyYvIq/eGm0wS02pr9l+G3
         h1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764007208; x=1764612008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwc0wEErQjElnL7obMEURy2H0bzgY2YYjZc6h4X9QZE=;
        b=PfclT88TrUyC7v/Eh44tfDXW3znDskSTx8H8Z3CPo7x+b165vJtj+KUoOTYq2ViH/h
         KLiYxE6sEL6Yg5Hf/8r75EMV/xnCaKtvH3EX9pw+lsXQWK/kExdZAzmwdf044vCVRBzv
         8ew5zKhmXr+H1CgPO4pg1urKnUr5f96gS41aw9ETeudR69kiRuooYPI5fVSbfT2LnbZB
         jdmGgH2cHDk/vh5M7y/T4DuOf1CHOqYFULY9KGcRX9q6EIp0gAKqfyjWTQcY9gEprXr0
         MCUk8IJeAmr0KH4OS5/tUgy2qClGMW/6nsRt3IGEiAY/hgKxNF4wBM26vzSpiSPt/et6
         E5KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAj8gQ+J2PBV0M2XnwauLqZIM0XVcgl6XLtlDukMh4UyJM8HXwMeoIZaLtdpwudU/fsKlVtWKD4YgJQYTWcPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4vGoTxBVzeydI3K834jJlnvAcheut1vgssRKcmv4PCdJ9JLTx
	eFgWyesdMtozMBGUle+hfgsjC/u6X+LGnlkMlKiehog2kwEnAq3d6bOm
X-Gm-Gg: ASbGnctRt06Qyp+BqQF9jqQfvtbOzVveYlJoZZz0LgBPhtxAnZvzRhGf0uT53aljzb+
	abEkwK574V3n3OUcuy748/ZmevMUr0RYSK/H9RAK+fmENaclFf4/e4TSc0itaj7sUaGc2SnGD05
	HAk9U1MVNji252nNK5XjgklJGLGJJM6/h7Dzntg0bUOSQWFRrOvNXUakL4EkeUYVfWFZNUlEPj5
	nDqPfi5LrgldeaXr0vWAgdM87JYBidfei3b/+XvF27m2hW2EkcDRBZGeYCr4MinAz0sEO8qsCZf
	+U467RbBIGnANeWRT+a2tjPJyyrt5qM+x6W6W7yDn9/b2zZGYsQSx47zpvIG4LZrJAA9ikVkl3X
	X9sojdsU3Z0Wjhq6f6snxVjcwuu9yg44XtwxijyQvw0lphFV6lXuZopLimtz22Nlp0nm0tSYAwr
	ssattFX/qrpaEeY+mk3hO7BNLvoIwW/4PuHm3eYTuS
X-Google-Smtp-Source: AGHT+IER74fvOLSGEfGwFDnZuS4IVDFpU0C2s1EkdQfgEctIUUfm6XcENb38f8Cs/r28V+tnVr0Upw==
X-Received: by 2002:a05:6a20:748d:b0:34e:975:3bb9 with SMTP id adf61e73a8af0-3614edb433bmr13952748637.49.1764007207909;
        Mon, 24 Nov 2025 10:00:07 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0b63aefsm15313120b3a.52.2025.11.24.10.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 10:00:07 -0800 (PST)
Date: Mon, 24 Nov 2025 23:29:59 +0530
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jason Xing <kernelxing@tencent.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/net: initialize char variable to null
Message-ID: <aSSdH58ozNT-zWLM@fedora>
References: <20251124161324.16901-1-ankitkhushwaha.linux@gmail.com>
 <willemdebruijn.kernel.6edcbeb29a45@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.6edcbeb29a45@gmail.com>

On Mon, Nov 24, 2025 at 12:46:52PM -0500, Willem de Bruijn wrote:
> Ankit Khushwaha wrote:
> > char variable in 'so_txtime.c' & 'txtimestamp.c' left uninitilized
> > by when switch default case taken. raises following warning.
> > 
> > 	txtimestamp.c:240:2: warning: variable 'tsname' is used uninitialized
> > 	whenever switch default is taken [-Wsometimes-uninitialized]
> > 
> > 	so_txtime.c:210:3: warning: variable 'reason' is used uninitialized
> > 	whenever switch default is taken [-Wsometimes-uninitialized]
> > 
> > initialize these variables to NULL to fix this.
> > 
> > Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
> 
> These are false positives as the default branches in both cases exit
> the program with error(..).
> 
> Since we do not observe these in normal kernel compilations: are you
> enabling non-standard warnings?

Hi Willem,

this warning appeared while building the 'tools/testing/selftests/net'
multiple times. 
Cmd used to build
	make -C tools/testing/selftests/net  CC=clang V=1 -j8

while test building by "make -C tools/testing/selftests/ CC=clang V=1
-j8" doesn't raises these warning.

Thanks,
-- Ankit

