Return-Path: <linux-kselftest+bounces-10126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D88598C39B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 02:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D8A1C20C8A
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 00:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FE3A935;
	Mon, 13 May 2024 00:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnjbzmA0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9CDA92E;
	Mon, 13 May 2024 00:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715561074; cv=none; b=HWAEhwphAdFhwdeP6A32gyjwoHT6pDKM/QT+d7DpdFmMQ3pw/2qbP9JNQJ4bW0A0keqkF6wfoucpms8kDJzOTPSY9x8gyXtNreOGHbm/JccWxReVe9uLTtgXHmrFglrqa5FuPrlX5mzL1S3bDYui1VJ/EW3gTY/MLTIkCrcvGAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715561074; c=relaxed/simple;
	bh=7RTQAxOE4gseDbvj5xELr4U8bjt2F0qAxOTnHFFWk1o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mJ0DVlcUuwHmFEyo88O/dLxLVn1KRE0wzVgzqjFa4bmDfgC1/pC4HYvANuYt7w3j3ljXNMcxNDY09n3miuojChh1xc32jjpALmSUQuldcSULJa/fiszT5k98P7Av2hM7kkp57BUPwzgk8BzHfY1bYfF/T8a8c/NYgmg88WWH0MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnjbzmA0; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-792b8d98a56so373915685a.2;
        Sun, 12 May 2024 17:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715561072; x=1716165872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEj05y7zwAgF01ZJe2G4wS354kgEmuo/anN2IwQpPxM=;
        b=NnjbzmA0CaDs+5iMKQBkzvezArHn1cva+rsO7al8m0/hNR57YYTrrNaRqNzDozAZHd
         uM0JDANS6Wnb6/MrlCMjGfShe+Z76SmrhnQYis+hWPlKIQQjhQvKk71jXAMUvp6KWhFQ
         fK6B3PXEpk/rtjADax3NJwPDdr5pSWHZahj5i28X2onXvYIHDmhSagZ7KFXaooRg00u5
         GJkezzhn2rhql9YR7PfcuIgmuGXfBS1D1JjHmRsYbq5vqT/7MTC2sctvLof1o28kWiRb
         uemU+8RYW7VY7U4LEwLPE2N7PomzDg7r++OfiZCcAV75aF8i8ATB7T7sgrYI47nuCrzI
         28xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715561072; x=1716165872;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SEj05y7zwAgF01ZJe2G4wS354kgEmuo/anN2IwQpPxM=;
        b=CHSvyTozA2Pq54rkVWwTmKfP8v6BN2fBO7U+crNPnHqsMHI64+Lw/7hRkkjUzDKodQ
         JjvpaXtA2Ldh2nbxRzaCmITTjdywABGKGUMOhqVBiQ7RgNAqyfNhqy+nh43+IEOr9URX
         omtJbfflYlOcBpFo7tqcb7+lgmY1/tZJk1DxL4W6RXNJ05eDOoJydb7ME5colDlPqAae
         rRrXkx+DYrJD8seXGvv8hr8zHjjogwC44+N3hEzxOb5kU+Fc3muhiGlwUwk7AFXaHgbO
         uqIua//iqcTyYSXjZYbBTBAl6uxOijaXsYKtpBaZby6TKlWQN4041TWVWVRu2KOzQCg8
         KTQA==
X-Forwarded-Encrypted: i=1; AJvYcCVaF5gBvqjThXK668dgGFG55qmw39W9rETnb90Z5MwwzAfbmbucnUSDTZFJrBS0+qoA3tgHCQ4ZMHqg+Aj0NMKXaxX+kJ/KO27mK/jaVQzGVRVcABUOm6oOdK3Q5GSJrLYZ5i4CO9VE5B0a2dj5oMRMnS23JMTSElGLCVliut3mZxk/6nZI
X-Gm-Message-State: AOJu0YyCgOwFQSH+dYJjkYlwM9ynROxDALFzrQmj59P+t+7MlPmYrPWu
	3kSaT7/i+4z1rJvHze3cDrzJlIl4F+e1+MSJWb2sKkIxgZ/R0iNFHp4EpQ==
X-Google-Smtp-Source: AGHT+IEc/lCy3lDKBxXLFFBUH7wh9dTLPrI22KVj42Fqg6glJzLwJbH306KZW6hOvqW456qYAb0H7g==
X-Received: by 2002:a05:622a:1301:b0:43b:aa3:2b41 with SMTP id d75a77b69052e-43dfdbb48e1mr74671531cf.67.1715561071756;
        Sun, 12 May 2024 17:44:31 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df56bfcf5sm49483451cf.79.2024.05.12.17.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 17:44:31 -0700 (PDT)
Date: Sun, 12 May 2024 20:44:31 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 dsahern@kernel.org, 
 alexander.duyck@gmail.com, 
 shuah@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Message-ID: <6641626f4a7cb_1d6c67294ee@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240509190819.2985-4-richardbgobert@gmail.com>
References: <20240509190819.2985-1-richardbgobert@gmail.com>
 <20240509190819.2985-4-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v10 3/3] selftests/net: add flush id selftests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Added flush id selftests to test different cases where DF flag is set or
> unset and id value changes in the following packets. All cases where the
> packets should coalesce or should not coalesce are tested.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

