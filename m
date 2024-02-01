Return-Path: <linux-kselftest+bounces-3928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA9F84544D
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 10:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1501F23486
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 09:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ED1159566;
	Thu,  1 Feb 2024 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2IhjsPY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CED215D5A0;
	Thu,  1 Feb 2024 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780425; cv=none; b=d7S5UBjNCVEUf15PUMh3yPdeorjt3/SMn1J3zz0gwxiFMDv+k00Vuj5ynxvBtZ3UcTtcR3l5ALZNFT4J+gYorRow+PaLc84nYlwON1Tf34R2XTYqGg9RqpEjulHOHa6Pfuy0jHIDKrrqUU0ys56qSlShAQ6VrLVR33YKKrsUy/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780425; c=relaxed/simple;
	bh=R7a2rtRgwjmdB++q9hCI4UL5Bhb43h8syAga6lWfUeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oUewVGdXdybwfdwkJYX/6NFvWO5Q7RFLmbwOTGDdOrm0YAS/vyaj7E4pmhReutuXrokqOuTVTOzN9suS1umxovCvb0u2TIuFo3pm39apuWp8E3gkWCeeFLT3wO4eLsGT6z7icdH5xCEgQC6gX83t9W+nUdDP5mBTfDzamRicAtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2IhjsPY; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d932f6ccfaso5606465ad.1;
        Thu, 01 Feb 2024 01:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706780423; x=1707385223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=THHWbzFKYYomtfW2u7Qzzngr/S9BIn+vJuGso8/zw8c=;
        b=W2IhjsPYPRq1tXZWump5US7GAydEta/UwSc71ppLN6p6XbJTA5lUCeFSaLzAAvXtTA
         cRohWz9+U9yBT5uL/Cboc05/ZE9DmA0HdZSp6g1An0yYW4K/Zl1gpYp4+NEgriaqHrMk
         +KT/pf4UC1JBYty9l/bvJ+wb8TQw7TzalaEvN8IHwyk5CpKTccSYQzfQGv6vJhT4xKJy
         +osOkHwpMA4U41OqFLwi++Naqw/qAInzd5I6bJwyxd44liJjxjAuNutmBpMgIz/fNl/K
         m7mStssk/vd2PvylyJ1GLTSQo/cxUVKoMQaAUUhJcjf1RAKLoTk5G0+wL6Wo3WR4WeY1
         Rz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706780423; x=1707385223;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=THHWbzFKYYomtfW2u7Qzzngr/S9BIn+vJuGso8/zw8c=;
        b=j3jh8nqXjzLR00apvukBEwAqL0rSlV1U1+QdZD7kB9nMKHzQfSIaf5HuL3OD2Dfb3o
         dHqGKUgpIC3T1LdvISO7XxXmVws9cFgGE2R7FAqiYad3RDfeFFasifsrfW6vl8iBvVGg
         jB5MPLLvc17OMSL9LLtm0emJNhPLJLAoCI70TEzhfo79L1651M5qALMsXpSbSFPlGhlP
         nLAvHT3h/Bh3qQAFUvwdSoB8DQYhGOKffTjey3F6mWcjKqPEFdkkQY8x5VL9e+X7F7ea
         G0UJagLTQrIAAANWEW1FHZRoCDIqyhPsRdMmdPT4P2V089q70vUgYkpn6BJLdtsRIhr+
         jKCQ==
X-Gm-Message-State: AOJu0YyrrEbQo+5YAnDm0TH4z00HjUgF5zAb8OvlDJcSozswPS2RqbvH
	1d0ArFsux1Dl8tFOaU2rMn6iYgSFSN+GxldxgjPwcf+4iBGVTq8L
X-Google-Smtp-Source: AGHT+IGEb99hE/ET4Ps281WI1WE87V2ZqlX/Y+d1n7SZOGe/m9hONwB2sSdLJbiCdJi/rBeC1W+xKQ==
X-Received: by 2002:a17:902:a3c3:b0:1d9:42fa:c238 with SMTP id q3-20020a170902a3c300b001d942fac238mr2449373plb.14.1706780423464;
        Thu, 01 Feb 2024 01:40:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX3mcx9Z9iCoe7eyNMMtPVr+7GGMMq+KG4YllB1f65GHUGsWi2gtWSyNrQPoLENkHkOQkj8WwTLaiGVHSvMmrfQ5RarOGLCZ9Y9MIFliI3zQvTiXRMfmEIEl1wzfpxTPVczf2Elc29zFzgq9hH2+XkXBs9V
Received: from five231003 ([2405:201:c006:31fd:502a:f3bc:f4c6:bc66])
        by smtp.gmail.com with ESMTPSA id lc7-20020a170902fa8700b001d95a6983b0sm394927plb.87.2024.02.01.01.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 01:40:23 -0800 (PST)
Date: Thu, 1 Feb 2024 15:10:19 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Ali Zahraee <ahzahraee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: ftrace: fix typo in test report
Message-ID: <ZbtnA2Mz0nWGeetl@five231003>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240201082557.15965-1-ahzahraee@gmail.com>

Hi,

Ali Zahraee <ahzahraee@gmail.com> wrote:

> This is just another trivial typo fix. The typo shows up in the final
> report after tests are done.
> 
> Signed-off-by: Ali Zahraee <ahzahraee@gmail.com>

I sent a patch regarding this already which has been acked,

	https://lore.kernel.org/linux-trace-kernel/20240129162841.57979-1-five231003@gmail.com/

Thanks

