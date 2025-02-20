Return-Path: <linux-kselftest+bounces-27100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA940A3E3AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 19:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E997009BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 18:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44090212D83;
	Thu, 20 Feb 2025 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vKDtO5iI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4D51D8A14
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 18:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075489; cv=none; b=u14lJnOHy4Av2gVkEeMIcIlgcWmHcU2JB3iKve9H+8jsNJGWZSNTrCszjUdAfnPZZOzt9HbYpASviufOXLDkLPmVEUVxK3OwqMk93Iyc09cfV+5vi8+PSvenI1P7Vh4o5J9D8IbfWJLCjzleZow6MSdYrEotztcMAQhDPonH10Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075489; c=relaxed/simple;
	bh=Ykt3z+cEEEUsIKeg+bYmHLyQJ1eX8o9zkXfDLy9xi4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=StlvZoRULpmkFNsakY90BQqKtnT2pmAajt/vPargzkLUHKnHUkKXQ0TLmR+M/FfdCHxWSBt0C2iMfGY8+qgXLfYShQc8ve35uZehJyMsJWXmZeHAgxxcN40JiAv2xEYcdEe+mtcmugcaLBfpxiL5prWTvKtZoWX2Ui3jkTm6Lr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vKDtO5iI; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-471fbfe8b89so30801cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 10:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740075486; x=1740680286; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n+KcVTRVHEtJrwbwtXf+hP2qsL5SaK8Xz4Fd7FX9DX0=;
        b=vKDtO5iIEDqEua/50Q5GW2TzxWgo2XPVIH3akJ9buohxfqof9HF9Hd6xissUgTa26O
         YSKtTZBtMhiRckUWGVb91ws7yx7uQnguPaMjsweJbfkjGkyD+QjCQbPH1hl3kHs/Fr5j
         MKvZuh5W0HHDVB9HpEURoUz6KaSWnHNxHtKIbYB/AcJhXS98zEzyKWemexu/LoQvn+ih
         3dw2V5mq4YO9LBlIhobipDM/Z8N5WROzIpZ1AR1HGMSo/CxoDkdNWGyYS9JC1/33gxjh
         GzM3+3Q1bzkHipiPhFBNTWQ6m37jiJT+/ne4cyAkZi1QSg4gppnuF2TZLLxC5VW/F5Xx
         2i8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740075486; x=1740680286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+KcVTRVHEtJrwbwtXf+hP2qsL5SaK8Xz4Fd7FX9DX0=;
        b=lEqIDaQj1QdSK96zmCxIVreD6xtT9rSgsfrg67Szhv1T+kUWaTlm0TwNHyOTPhyxUX
         MR9VIRNlI1mB2TJGftgerFHSWa9Lvssc0RuJTHGn0SX5U9X4/aCHz6XM7dQtmvGMceTM
         C1SQhzgnIYkItCDTiWPFT/XZpQ/ZilY4tnIYIv2yNOBee5JdNBYIBtAE5KUlEfJxG31d
         HbKQWaEaB74JvPM8adh4lstlFA22/kdoB5lWyXlDwdykJyk70MsPPU5zCyzxTIeT45lQ
         tG5xpGoN4NWrQbcUqIFdsYXLYg3+LZNMnsIziote/HgRGGwYKhmWXEGL0Ab2DdrJ10vX
         i+bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh58tqqIfl2grg1b0PLPKDTNLl0vaNmdYJCjrgutuse6rrKfb1G9fBdhcd1Tyd4HYfxSMFJ17RTFRQ+y7ttHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnaXp8d6Ad+b2K9xHoIO0xh+2PrTHQ4qpDIKzZBJcU5LnBZFv6
	dui04Px7I/qwB4kkjmZmW+qAjxkwVnVnlJy8CX/AhUE8zq39FImmy9LsSRmbwxeUoADXueGJldy
	dC8MqTpAE8FAJ0HX1StuCFaBbJMvhV6cl2zNT
X-Gm-Gg: ASbGncsLnBEasRKxbjuImmFOz/sobXc2kincNdeYk/7x3GLn7aAR5ZpNG69AYYUK2sH
	NdsgQ62jwoD7zU5qA3ZJPmtrstDj/SACSLezpcK3v4Af6R+X4BptRMHhBt+mqm2KICXLULMYDLZ
	x8R6/GGTvR8nFN6Do6ur0GlTmTZVk=
X-Google-Smtp-Source: AGHT+IEL5k884q3yjOFoRKHquFIJ4dYata9abh/OY1fVwIJ12uqEUW4ipXq+lx2nxS/e/ao3pYhy5FD44BVggxqW2v0=
X-Received: by 2002:a05:622a:190a:b0:471:fefc:f002 with SMTP id
 d75a77b69052e-4721710d98fmr3752251cf.9.1740075486265; Thu, 20 Feb 2025
 10:18:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
 <20250220-mm-selftests-v1-3-9bbf57d64463@google.com> <d22b6cec-0688-49a6-a42a-decb2632aa79@arm.com>
In-Reply-To: <d22b6cec-0688-49a6-a42a-decb2632aa79@arm.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Thu, 20 Feb 2025 19:17:54 +0100
X-Gm-Features: AWEUYZkLdjTDwhb1samESg0X1fNOHZohuSJyO6aDmg8HFaVJn5HoSpK5AKDxKuE
Message-ID: <CA+i-1C0terC2xjZBfzT+T7yFEp5LodZXWFhoP=Q+=+=urp6fGg@mail.gmail.com>
Subject: Re: [PATCH 3/6] selftests/mm: Skip uffd-stress if userfaultfd not available
To: Dev Jain <dev.jain@arm.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 19:06, Dev Jain <dev.jain@arm.com> wrote:
> > -     if (uffd_get_features(&features))
> > -             err("failed to get available features");
> > +     if (uffd_get_features(&features) && errno == ENOENT)
> > +             ksft_exit_skip("failed to get avialable features (%d)\n", errno);
> >
>
> s/avialable/available

Oh thanks. I thought I had codespell running automatically on my
diffs, I'll have to look at why that wasn't caught.

