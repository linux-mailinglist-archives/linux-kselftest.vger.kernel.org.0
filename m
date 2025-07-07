Return-Path: <linux-kselftest+bounces-36724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38638AFBB1F
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 20:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19FCD1897754
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 18:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61DC265606;
	Mon,  7 Jul 2025 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cRVaVt2m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546FF264FA9
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Jul 2025 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751914149; cv=none; b=Qr2M+hlxSP4HO1e9/j5Y3tJUQ383ww8vmiOJmmdQtl0wQxlr8zrKrIfDEXrNhGvTfDprTCmt9ryvqajGI/R7XkxrtFf/zqHZMSUy/HXWrRNxB+Px6lSf6YsTvQP+3koDk36W6vaI6WYGyaRJUMtUYIzEqYCKD6zgplr4GY2QA2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751914149; c=relaxed/simple;
	bh=aJnLvBEEZbnL+uu98DjTZaoxxjR8mifkHxn537M2Twc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OS15l9DEZn89K0SBe5VsnMsdw1Bb1aEkLGHvveDQNqXHCWRMDCPvoiNsext03RTumURbrXaIcRUlsK9PfJrvv6pABVpl3vH4myoC0BdORlTXPPIX8JRp6vGaCAcQgYDEfL8ZKq/hqaDPUfcl8q9Ofnu/fuD93lsMk0x5uafyX8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cRVaVt2m; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-237f270513bso34035ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Jul 2025 11:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751914148; x=1752518948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbLpetxYftBk9awSTLcJ9ED1ywf3jWFwfEbkZR89PpQ=;
        b=cRVaVt2mtZS67Sb+1SXw7wVM23eSVMmpd1fbshxBuGkAtfs9mzBcnZMLgL1hxip8Ci
         07jNpNiz7uRDwUu+50QA/tXh/oifDvZhZuvIwLXlUrpmsFfEyjAQ+BuCXaccqHo28a5/
         lcWae0ifFVtWruIZhKvp1wrNnChfhh1qFbf/7pl4/iQxvj4BVGSF3X/juPb6nDJNGbMa
         CmSvbuODSXbPk82Zm1+Gqc+9B/gqufNn+15zn1JhRrALl6cDRY577VPf+wngxOOA+uvN
         A3grnEf8rp1SeF86RG4gFo1WdphfFtI3HC0zbPgtE0EAFeIrz/c8gZX2UoiYJIisHIzX
         jaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751914148; x=1752518948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbLpetxYftBk9awSTLcJ9ED1ywf3jWFwfEbkZR89PpQ=;
        b=gzymCYPEdhuFulkNmWwpQ/QaYiKLt0xDsg84ZWzfwh/1HC+8WNausrCIzLOuBdCg6M
         na2V5YO+NcgdBcrRuoqAQy8vZxmRbA0wO5p2uhZZmIikZxnMl/4OwUADc52oDnwQE0MC
         mEgxcb7oy2oB+uCpUmWBgGFPgIaIBizg1zFmkUdozKdbKHpHlIvuw4YEfscGEM9+it8e
         5k0YRJiEzEKppsvLBsQnKZi+YUW+OIxzAUWa1Q8RBp+KxxMRnY8DKGPvzKc4X/jPBbY6
         oIbuRJud5puYnZR2iOulswpZVGhpDUghRCBkITdBVMoJs+M4bOMEhXXQWuU2i2cF5S4y
         IRxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbZyg+KRamAtY0sdGI12A2GiIL4sn7s9Y8vBlmLUVEZwAyFgOxLc0s2ArxHR8WZqSq0Rz/huHXhn+emwCvx0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YykEv/Q+GiwRMukIVzt3Cj+e3hY5gNnizR067bwsscenwHMFmOA
	FTA7+X8U5N+V9KXfaG9DmjWIgew6gq+YjSyQSKudqk7Wim33beni8Y8PbaJkpWAI1a209gHQrMe
	YAGg5jrIXq7cKKgZSojVTDPbc/sj9ydiSxoMVbOAT
X-Gm-Gg: ASbGncsRy9QVAZFJjFhCADRLze0mN8ZLt5eSB6CeYGXVLoOpdef++94elRgtq0l3Q/3
	t/Xsepaeg8j663NQOF5ZAumBfYmc3b9tAqviVnGN64P19ktGxatdAt3H1Xm4uhpq6XCH5ehvarm
	+/w+4sYZ55EaiafFfGqFXR2mCaIpRAmOaICmeaXTWJf9/3gc+rE5XZlIvusdv/FGJT3Ti88z//K
	g==
X-Google-Smtp-Source: AGHT+IEg5t8XG8BnF4k7T1v1Wy6xEwaxF7wvaK2JoECULiD6cDaaTfJJCXuVTAcYqSYGP/3p/C+ZTkTRDwsv1PB0RRw=
X-Received: by 2002:a17:902:e5ca:b0:234:b441:4d4c with SMTP id
 d9443c01a7336-23dd11d4882mr221445ad.5.1751914147250; Mon, 07 Jul 2025
 11:49:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702104249.1665034-1-ap420073@gmail.com> <20250702113930.79a9f060@kernel.org>
In-Reply-To: <20250702113930.79a9f060@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 7 Jul 2025 11:48:53 -0700
X-Gm-Features: Ac12FXyWIu3Y4yshjHkawSrnmMOadPMVVuaxwuq-UIS_rELDSzwub3bWQ56nAAY
Message-ID: <CAHS8izPug-bFu3Tqc_sanCO-gip_e-pPY2Xx7qTAUV0+cKySXg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] selftests: devmem: configure HDS threshold
To: Jakub Kicinski <kuba@kernel.org>
Cc: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, shuah@kernel.org, sdf@fomichev.me, 
	jdamato@fastly.com, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 11:39=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed,  2 Jul 2025 10:42:49 +0000 Taehee Yoo wrote:
> > The devmem TCP requires the hds-thresh value to be 0, but it doesn't
> > change it automatically.
> > Therefore, make configure_headersplit() sets hds-thresh value to 0.
>
> I don't see any undoing of the configuration :(
> The selftest should leave the system in the state that it started.
> We should either add some code to undo at shutdown or (preferably)
> move the logic to the Python script where we can handle this more
> cleanly with defer().

I'm sure you're aware but this test in general doesn't aim to undo any
of it's configuration AFAIR :( that includes ethtool tcp-data-split,
-X, -N and -L. Sorry about that.

I wonder if you want this series to clean that up completely such that
all configurations are cleaned up, or if you're asking Taehee to only
clean up the hds-thres configuration for now.

Also, sorry for the late reply, but FWIW, I prefer the configuration
cleanup to be in ncdevmem itself. We use it outside of the ksft to run
stress tests, and folks are going to copy-paste ncdevmem for their
applications, so having it be as nice as possible is a plus. But if
you feel strongly about doing this outside of ncdevmem.c itself I
don't mind that much.

--
Thanks,
Mina

