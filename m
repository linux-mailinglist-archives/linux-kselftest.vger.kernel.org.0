Return-Path: <linux-kselftest+bounces-40416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80805B3DEA6
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 11:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C32E3A38AD
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 09:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C2530C34B;
	Mon,  1 Sep 2025 09:34:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305E630BF60;
	Mon,  1 Sep 2025 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719252; cv=none; b=U1pIilyNoSj5/v5GhZSlSFozcRaE+NcmKyYfF0moAFeQQL+cX9xxoptFVFkRDbKXP2WTiZM55cFtAOneLsKYSI+ZgVNFGr+dOacUyfrYHG6vYuX6zdhaGiev6nCeVbvGJKpbKzUBorlTfdnddw2SURtaDKiqldGjqdO0pZHR6ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719252; c=relaxed/simple;
	bh=WbqxiFHCxmv+1TEW2LU18yc8nc+qUvmPIvWqJNM3IY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwlX8WGad8m7GM40LcK8du/j472jaXiDkOfLk0gcyBW1lf5kYbCf1TIND8GFrmn3Uxyk1GMOZ6oV06PV29y9dNdUUDnpa806dAkjLk5yaPeEg33bCTy9dGeJjW0u/qzj9ZzNBrZf2nBKFF/s7M91TlA0M3MmOl28KMG2d/iTdPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61e3b74672cso1942550a12.0;
        Mon, 01 Sep 2025 02:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756719248; x=1757324048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlA9cuj151JAIiFxWe6cpardQLhaD6SM9myw3V7mMQ4=;
        b=rK2AOXM8s4aKsAF5kn1IUxbzqI0ETHAvyNe118Ef/r78rT6/0QJS8Lq1q9qjAiDzVO
         wdDUMI75wOlFe4eerm2/sY16o4jkWo1rGhxv0C6leSc4GCNIVNvy+GCI6Y9xz8jQYadB
         oUIX55JCYDMWK6XAYiBjapyV0SpKeqjWQpTY6Dr3YBvs1e12d8inShgIond1juLqnD0v
         legxkMJpNDrjZR5w7kDWDjpJyDhxG5Ee4FQ9MiffYRRhYaM7VeL8Dvm+9HqXZ7OOTpOJ
         ViE46vfixrsiNrYcTyfPGlp0V/KWoUuYJQAVpgoB2eWDdxoNukApizDC0nOfTWyCYPZc
         Qt9w==
X-Forwarded-Encrypted: i=1; AJvYcCUGXZ1xuW9aQgm1ORNCR2BTJngE991Te8lcWTPZgnscp1rA/6UxXen2i9Ke0C0pDMFfKj55uHkN@vger.kernel.org, AJvYcCWxoQ6e3HVq88+XpctVk3wnEvVEn13KIa4Xc5QNZRI2YnCq3mRHHyu6FtlpqjrI9XLdgbJ51QKwNV4MQhNW9eM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRbYWLObkNyel6o4cnKtjHaVzb8pOhSMSvEu8j4hbyMEFSs2yF
	Ffm7OiJcdgO6be2isbW30JJazHpY4brIr8dMNDLY5GhTR1M+5Vdvx7Qc
X-Gm-Gg: ASbGncvx4RaljT73jitACrzziEcpFBTlra2SzSbv4oZsic0TGLXNyW0qGLrM/LYTe1P
	1QtEN6T4lDKWSsSN9ZmWV/CrJzRvn4LdK2H8h7Qhey9L5FF+165waCJh08vNE79GdAbKkLZatT1
	1VGCIjRHf1J62CFRxlHX4PXNpfUPmnb7TgBvdA82H3i7H4gsmMjLeCpcXAuY+7njv69Eptbl+NL
	unoEVH26KUjsq16P8Z8OneYrhvLBqS1xe4VpVsEgrRfqmr/YREUYXiNINIyGxyXWxoyv48nnaHG
	dfkPEtz40bvMQgtzhjiuf2zqFrmOkqnbKpfbx58RfyHjcVAA535Y2nIgCYauqIVpFNwpDBquWMq
	vQ9yCEZpIE7tgRw==
X-Google-Smtp-Source: AGHT+IGd3sku2p9xh1a3YxEGe7t3cwa24VOvn/OQfxB9g1GYI4HSlTIZrOhiAqiX9HPakg6rGRNcFQ==
X-Received: by 2002:a50:cd17:0:b0:61c:4222:4856 with SMTP id 4fb4d7f45d1cf-61d22dc77eemr5006499a12.3.1756719248372;
        Mon, 01 Sep 2025 02:34:08 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc5575dcsm6867632a12.49.2025.09.01.02.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:34:07 -0700 (PDT)
Date: Mon, 1 Sep 2025 02:34:05 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, joe@dama.to, 
	sdf@fomichev.me, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] selftests: net: py: don't default to
 shell=True
Message-ID: <va6ympcdo4jxfcqnr6uels4hg62sxgzeabdxjkdr7nkufjktk7@4fishek5fpgo>
References: <20250830184317.696121-1-kuba@kernel.org>
 <20250830184317.696121-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830184317.696121-2-kuba@kernel.org>

On Sat, Aug 30, 2025 at 11:43:17AM -0700, Jakub Kicinski wrote:
> @@ -45,6 +48,10 @@ import time
>          if host:
>              self.proc = host.cmd(comm)
>          else:
> +            # If user doesn't explicitly request shell try to avoid it.
> +            if shell is None and isinstance(comm, str) and ' ' in comm:
> +                comm = comm.split()

I am wondering if you can always split the string, independently if
shell is True or now. Passing comm as a list is usually recommend, even
when shell is enabled. Also, if there is no space, split() will return
the same string.

What about something as?

	if isinstance(comm, str):
		comm = comm.split()

