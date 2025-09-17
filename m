Return-Path: <linux-kselftest+bounces-41645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 849C8B7DE62
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF9E325EC1
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 02:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165E82F5303;
	Wed, 17 Sep 2025 02:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ci6fAv7+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EEB2F4A01
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 02:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758074423; cv=none; b=jRUn1bkK+XBFBsUQUrpTdGwj3tdmJuklS4GLroneDO+XU+mZ5OrhNl2NtACjYXtQm4qTszsoHl5WxJ3Ivh68PQg2Y7n8GI7MRAI0KeqcqRJw0xBTRkpg/XhWqTvBsG8o6YE2fTFkhoBnrIRiE8cWC4E9PUEzqPXIRxZDsal44qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758074423; c=relaxed/simple;
	bh=KCwC/Tils8G1zj8VfjodPAGBvj3LA75XORNG9eGxiR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBf9CpWuIJiqO0vOI6aHEs+AO6Dnq5PhVWNaiVhBmH/hcVp2gj4RZEL4hh2VWx86ZXiUWZisQH+WNSIdZedMDaPfWjgF8S9Kc0A0vh5yE9mIv1LjrsTY1/av6uOavHafsCZVhkcR4wetHCY6M8AcINKre+oYseLHVpcgEtL4i9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ci6fAv7+; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-62347d880feso1684319eaf.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 19:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758074420; x=1758679220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0OXwPxdIT48vjOXlf0w33hJy3bKFcwuyJwXmlOX6pI=;
        b=ci6fAv7+57M+sUmU9F22SuIAFqwIkGC9slQJMC8IN1j4A5ruSrWn6giqi2rjwHfI+U
         OCh0mnUIC/KNa7G/rfrXpeF5OHaetqd4uk+h7zrqLxdJMRXXw5jq24Xv8xlwuEI6qDZv
         cubuDwxGYN8gMh4+YvrfIPE5bSllyNVoJUMLP7niHJaPdYrKeHttI5ruKno7msvSNRCT
         rvu9SncM1SVLr8C0h25nVRipunr1a0nNmJe5ZlbnV11c/dj5x5FtfrEiNCYTIj2c3hLk
         Z+5OHxSayULPYiXXGkhLyuUbKWt83I4gQtr4FapvLdhoHyqofOrluDLggX6BN9VfkoTz
         g2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758074420; x=1758679220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0OXwPxdIT48vjOXlf0w33hJy3bKFcwuyJwXmlOX6pI=;
        b=hO4GFOhR6kBOrzbE+6R8R58QV+mi47EdA4JzyDndnLyiVVMgqZ4E4NSFAg2eH2SwIr
         m85cqz1Lwjk8lJQHjX2/DZ6PbHLzABlLCXQCNBZMd+QUAyg1QOyYoe4TiTgozti6nMJZ
         e0rZotTrQraoDJLpAeUDb2fko6fQVs703z1LA6WNyTrNHDDfIuvtYXUQgph7x+MpISKy
         ZzSuWg3kGuqJcYw/B64Wmeqteap2y4+PNM7B8pTwrO6c+bG6SXfV7CNVK88oOOJ1jzZR
         Qk0FtQ9gS4BAmwvon+6Pr1tQ6cAoF21YvNJm1QgdxxeQ05hMg6znWtbKgL+YyNBFxpZk
         x6Lw==
X-Forwarded-Encrypted: i=1; AJvYcCW6A2yKwYkN9RTrgL3VZ+GGFfLsGpK481Fgpm/FXlPQNORdRWuXwCt4ZW39dTiVOTtqBPkYC0aHW4E2uMsLh6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVcT54NWxHmoB/u4eTxVAMF4/Ds+I4jICaF/0DKqIlvO8SqkeW
	vfHeFVNhtv8NcbezdDgsgLDKnoiRD323w3hG8LVUE+iGe82lI3gbYa0QMe4FMz5hbaW0SDHcNlA
	pAjkjqUJkR86DT7OB6R6+WerzQhbgDI8=
X-Gm-Gg: ASbGnctmWzyXfvkAD0PCd5DDwCFuoLdpjxk9KugVCtN9eku/Tkc65KlOtHbT5Pj+K/3
	lnjIqSLbb0ITuHnqwPr7Jt3dwYZeP9OPQhBL6bhpTb6HuBLxRe529AcmngVWorLsgHeWsMW4xOI
	ev9VhShxosJ48rFN/onn8lQ9jfbX/hSJfuZgehuIQSOV0cbQGh8HGpx6DtqcCwRr3PcKe3TqBpC
	KYkS+2tBZYy/Cv97Q==
X-Google-Smtp-Source: AGHT+IEvQPffb0A49dnuVx7i/YljAiKqmt2JDujS9nYAKj8zvldXslNByuFRawd2w3gpKptjllm4V0Fh0j98yevJ6jE=
X-Received: by 2002:a05:6808:1706:b0:438:407e:4a2 with SMTP id
 5614622812f47-43d50ca6e10mr204635b6e.23.1758074420479; Tue, 16 Sep 2025
 19:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916155649.54991-1-higuoxing@gmail.com> <3f2353b9-055d-4332-8abe-5af20e9d55fd@linux.dev>
In-Reply-To: <3f2353b9-055d-4332-8abe-5af20e9d55fd@linux.dev>
From: Xing Guo <higuoxing@gmail.com>
Date: Wed, 17 Sep 2025 10:00:08 +0800
X-Gm-Features: AS18NWBdAeIFFQuw4_4TBuAjN3tAD7V__JxtSQD87SyNVvLVbyQ638uoAGMDOmM
Message-ID: <CACpMh+DhTYfhDom3XywEYECCk50g=c+KZy1L9tuHuu=Y334syA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Add back removed kfuncs declarations
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, ameryhung@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 12:17=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 9/16/25 8:56 AM, Xing Guo wrote:
> > These kfuncs are removed in commit 2f9838e25790
> > ("selftests/bpf: Cleanup bpf qdisc selftests"), but they are still
> > referenced by multiple tests.  Otherwise, we will get the following err=
ors.
>
> They are declared in vmlinux.h which depends on a ~1 year old pahole. The=
re are
> other selftests also depends on the kfunc declared in vmlinux.h alone. Up=
date
> your pahole. There is nothing to fix.

Ah, silly me. I forgot to enable CONFIG_NET_SCH_BPF in my kernel
build. Thanks for the information!

