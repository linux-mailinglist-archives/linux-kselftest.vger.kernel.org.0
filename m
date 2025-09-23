Return-Path: <linux-kselftest+bounces-42159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 47301B97D5A
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 01:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DFDA4E01FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 23:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EAE30C0FD;
	Tue, 23 Sep 2025 23:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjItgS9h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410A92773EF
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 23:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758671934; cv=none; b=uASYLsowNBtSu6EziOt31KvZoUyxjfhIGO72UJBHxd9EnLfUSQlL+ilxZ+Z10foGsE9jaNx4QpjHS/0Ou1tGcord2NuAH9g2186r7/0ASM5EwOkNvqy2iVjM6hi5kvG9HXLxjur4FVp4fOjAPr8sw7TCH+0w6wEvRjBHOYcKv4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758671934; c=relaxed/simple;
	bh=ViWzqm5ZUPur6Te/os8CDuyEH1yaJzl+faXbprZEmcM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbtMdRM7IfqdAJ9QK8Wm7lQqRqGPPULms1gjDhDL6nPniQDY8y6o6D/L21/7Uru6aQ0JeCj6ga5Hon0wzN2l/DntXW9oblSmXqSUpxMV19/hDLaW9Nn3sQDLXSwBTwcDFncYJ2uG2X9YTlksOor2Cs08Fw0S0j2pNuMeyA1puXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjItgS9h; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77f454c57dbso2151302b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 16:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758671932; x=1759276732; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gWOszAue/Nmd8O/Dpr4OL3qdoKFLGIalj3bb3gHaSE0=;
        b=IjItgS9hAat/dUnO2GUCIBDgv4obfKbaGiPFvf59X9tFSCvIeRyvlcg5fBTy1hGd6Y
         kkx7oM91cucDVdM4tKhnlAmyjk1sqVO6ogvF36Mm7TwWhDVAimGdTnIz6ACe2i/tiQ4f
         z+BXyKNY/I3jAgZnhxElPi+fHfqCtmf8lByaUMqB8JWWYXKKiCfYSnXvnZBPeBnBnqo9
         s2zdvtCWbq0dMeNMOUFQl3amR4hzx/o0JIMmb15HB4Hx39qxhFArusboPH3lVuWlG50f
         P5y5PvWHBxyu0kEsBG+HV63udWGbcY3uST8BNGXwygi5H4sy/kSGFtKAJoozCbCbE+u2
         u+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758671932; x=1759276732;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWOszAue/Nmd8O/Dpr4OL3qdoKFLGIalj3bb3gHaSE0=;
        b=LEJn0u9Xyf0apYiYYxkg9OEvypUhAnaGkZD9oKHSgg/Bb/NoMEQvw/oesJKT160J62
         Wt2LLANtYRdzvwZQhZN0Q3Wf4HMOm1pcagw/5HcpkRZZx2ZUye6tyZLy27vEeIr9/W8O
         0vv2Ng7AxdXisGEqtTku5655wNIKrDFT2VO/ZCygmRuohex/F3g6Pz6vxpjaELzpFtV3
         wY5Px4233eYq6zjL3DGWtwWjls4tDGJUSqGxlkA44R5LLX+1mNWGPx/rZF972rOfBJTP
         Fl7OP1exo4ej5aTmFC5v0vlDqkC/jXndXxrbixpOb4sdJbKbFdFNOiF5XUKxNJOf8KSX
         J1oQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7lblCxo3lyuCxVYRaAOWIjUm5q+EnLN88a8yu75wZQ+mRKCc03CwY79Cl2qrM7ViKoR2t5UZ8p/fICU2xuvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr9C2+ogR9+RiV8xgEr2EJNGrXdPuFfpHGWJ7YknTc5X8xAfi+
	a//MAfW6U8FrhCbTOeriUhUpS/JcRkOi4bP/QqDiSydIkXCR7HaOlRrr
X-Gm-Gg: ASbGncsp7mvhwH+oSrClr5zNRFHjqrK3fQX6TfJxl1QCjKFp6R9a+vdwkchft2Cvkh3
	ZL1Jm0VDr86WSmf2RtS3oOWKEeqwUxiU9SnmWFYhoVjTVt8v6dFCdqOxUc0qJjkCnVt3IogQ2Ib
	r4Oqzv80DrHj70FgpRRCS740GUU24hRE+wFGW2IaLd3HRB+C+w4l8h9w29FPrw3JYpI1UVFTGcX
	4jRw+77hb0rH8EpGto/jyBq2HLaJly3k7hL2vuK9fDR7ccygdU7t5Ok+vW4aBQQfLVnoQpmaNyX
	xTROyFOb/9ZbwEaQKd4kwWFWa3gnMw3fqnze5d7i0eDdK8Hq6XrsaICHjMpB7zdr5RknLbzgsZl
	uJf/AulNDfpwWE6yTs3KWyM2sgM3/SNw8Bjp8g0haU8HnB+/+3dckv3z8o7lo/hiDFnLvkxhjUb
	ua+/zytnEb
X-Google-Smtp-Source: AGHT+IHfgNxvq5qCprtDBrZ2VNj7itGZH/QNHmXUVetkRVxp714PAaGhNh9xYeZI8JvzviTCjhbang==
X-Received: by 2002:a05:6a20:6a0c:b0:2ce:1b57:3701 with SMTP id adf61e73a8af0-2cff71fe6camr6132609637.28.1758671932351;
        Tue, 23 Sep 2025 16:58:52 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f613dbc5csm1372022b3a.59.2025.09.23.16.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 16:58:51 -0700 (PDT)
Date: Wed, 24 Sep 2025 08:58:47 +0900
Message-ID: <m2y0q47mbs.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: hch@infradead.org,
	benjamin@sipsolutions.net,
	linux-um@lists.infradead.org,
	w@1wt.eu,
	linux@weissschuh.net,
	linux-kselftest@vger.kernel.org,
	acme@redhat.com,
	linux-kernel@vger.kernel.org,
	benjamin.berg@intel.com
Subject: Re: [PATCH v2 00/11] Start porting UML to nolibc
In-Reply-To: <4354d88c2ff7a57a7324cc39b4ce5ed4ebe5277d.camel@sipsolutions.net>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
	<aM15eChUObXfxLzs@infradead.org>
	<4354d88c2ff7a57a7324cc39b4ce5ed4ebe5277d.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII


Hello Benjamin, Johannes,

On Mon, 22 Sep 2025 16:41:36 +0900,
Johannes Berg wrote:
> 
> On Fri, 2025-09-19 at 08:40 -0700, Christoph Hellwig wrote:
> > On Fri, Sep 19, 2025 at 05:34:09PM +0200, Benjamin Berg wrote:
> > > From: Benjamin Berg <benjamin.berg@intel.com>
> > > 
> > > This patchset is an attempt to start a nolibc port of UML.
> > 
> > It would be useful to explain why that is desirable.
> 
> Agree, it should be here, but FWIW it's been discussed elsewhere on the
> linux-um list in the past and basically there are various issues around
> it. Off the top of my head:
>  - glibc enabling new features such as rseq that interact badly with how
>    UML manages memory (there were fixes for this, it worked sometimes
>    and sometimes not)
>  - allocation placement for TLS is problematic (see the SMP series)
>  - it's (too) easy to accidentally call glibc functions that require
>    huge amounts of stack space
> 
> There are probably other reasons, but the mixed nature of UML being both
> kernel and "hypervisor" code in a single place doesn't mix well with
> glibc.

just curious

- are those issues not happening in other libc implementation ? (e.g.,
  musl-libc)
- same question to nolibc: is there any possibility that nolibc will
  evolve as glibc does, and this evolution introduces the UML issues ?

-- Hajime

