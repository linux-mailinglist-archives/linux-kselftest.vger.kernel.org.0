Return-Path: <linux-kselftest+bounces-40316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A448B3BF34
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 17:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2E761C880F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 15:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64567321F23;
	Fri, 29 Aug 2025 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrLPXn0S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59D12765D7;
	Fri, 29 Aug 2025 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756481361; cv=none; b=k4HL8Un2vjMOqPhXfDV3v8C/0vV7YFt/ds2l7IEv9FMeKqYWrdvOLcrA6bb/6X0zybXCbyE8R4JMukdiqQiU93yd9ZguhBIlTtXpqIL1kbuXDNkOuqz7HGK01dSYwUeo+6vPL+TMNaU9lPn8T0P88vKYeqsFYuMRsLbRjmmshu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756481361; c=relaxed/simple;
	bh=KlfJx14k7QlMvuUJz30QqkKUEpNc1n24HaeGoHG6X0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C89vsSFnxkt+B3bz8+YYlfXPqs5ezmsz85xMJ2zRU9eRqKKr78tXTUsDf9YgRwl6gzZSKZttBXGQmF5q4mQ2vdkYD5SvJxkXwlbUEgKYDiZ4XI2SNkA6Dp7cljQpJnqYFRYnwmVpMfN9z/ltJbjjtO9SueUv6AU4h05SafLISqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrLPXn0S; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61cdab7eee8so3082796a12.0;
        Fri, 29 Aug 2025 08:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756481358; x=1757086158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KlfJx14k7QlMvuUJz30QqkKUEpNc1n24HaeGoHG6X0s=;
        b=mrLPXn0SS4hKOoOB5wdanohzmQI3K9Pn4P1aYc54L3SrTmCNTHUDkLQrFmEbxgoP0Q
         7+51jpfsNi0DH7628mZ+Fc+vV/UpErhMn/fMA3Bm04KqB6s7UjBPoZ2FYSyUU0bcUXfy
         J41ii4ekcMIZTeM/JYh6ySbdjU3VkPt+6AgmpfxbkS8V6SiaJIFVh6yz7jQM1Dfk/DdB
         56xuBbx9GR+Ajn93E42mq++G67oqyPV28MKNr8vd/XYyghdxMsNS19hxZbi/SBYMzlcq
         3+MKLz5RjEOIfRdIEc1V7KpFEyYJCHMlXfxujS7BBYzIaUZYTLJjpM+UfGgfLNKGVNp3
         iGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756481358; x=1757086158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlfJx14k7QlMvuUJz30QqkKUEpNc1n24HaeGoHG6X0s=;
        b=OjAppjcZmdepr9hznsx5+glP0XQypNMw6Z5CaNad+1tyHR4CJSgFmsPrUug/Js7/sO
         8vMGx93X8gABH13CD3rVFpYET8B/GL5u9m73LojnY4FUena6q0pI7tz54TwScUdFVrN6
         FX90fWWB9QjmknFju2MXtL92lIzBAlsTzOq70cb9Qqu1yd7ropg+BXGXmgADhsHeFkvx
         JxRwSpcsLTUnpGzSy2pEbENwmZBk+WZNO03GRfHGimuhBO2DDZOI/KYc0gLWTwg2FHcv
         yzdQtcpa5bKn+e+BDTrbCzHcLO1LBfZfLXfJiEskU7CIyuAijPZ6ByuCSXDEUopCI7xK
         JhCw==
X-Forwarded-Encrypted: i=1; AJvYcCUhVIpgO7dxKaxGNLFLcgeUmL5hEX/90sJZjtqp3EV+AmIXy24AL2OD29I5k03ZoA65pzUQ5XXHxkKlYzv4EBua@vger.kernel.org, AJvYcCWGQs0OmOIA1TMml6alxfQgr374YxzgGllq+Tt4E0YkQwhHT0xYuTzfH+UPaqKhCyBFz3T2F637O/pGodo=@vger.kernel.org
X-Gm-Message-State: AOJu0YycobI7ayg81L4OhexcXZ9Rn6BtwAjfBSK/11eMTQRAfj+iOw+G
	8TwdJHIEIEpnhRHuzfHfDKXC0f8ON7nkZ29FPM9VG6Cv/14REs4EYf9nvHuHGjNEmPVPr6PaG06
	0hmXePVLM7nfV3bAcBZJBgwgL0x7NuA==
X-Gm-Gg: ASbGnct4B2wMNSryEtBbRMV93PMYldXry1s1pJin9Bomdon41tQmKswuWGtXSNM/ba+
	33waYE+ERByjV6sw3DoTUYv/tBMbB/5ln3Iw4pZvIRD2kqEMP4zDc2T6xGY40CRaB7YAu4DFnRk
	yMD+iLYajHRrjNCP7H7FwWtj5WmNlWpUmw1RUa3+zXTNslRZWYNjBXNGGwRyDMjZ0Nw1n3oM+dl
	DOXJExdyN527NTlzDs=
X-Google-Smtp-Source: AGHT+IHlHjhamRkb1CeBLH5wF8zysbU6WBxW0Ef3Z7tCNHy6zj5SYyx/5kZg7x6UB1gpfXZ3/DkrY2NuRSk1nOt3ZKY=
X-Received: by 2002:a05:6402:5208:b0:61c:9193:a4c with SMTP id
 4fb4d7f45d1cf-61c91931336mr10638815a12.1.1756481357704; Fri, 29 Aug 2025
 08:29:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250817065211.855-1-ujwal.kundur@gmail.com> <DCE2EJ3KWX3K.1Y198FHBV8UG7@google.com>
 <kd6uteyd4vzlnbdwzjydwd7hoqyxewc5fx24z5sq7svmtoa3oo@n57xyeu3vtyy>
 <20250828155412.2b1b2095125428af24896af5@linux-foundation.org> <DCERAA0PTPE2.1Y0KLQS6IO5O9@google.com>
In-Reply-To: <DCERAA0PTPE2.1Y0KLQS6IO5O9@google.com>
From: Ujwal Kundur <ujwal.kundur@gmail.com>
Date: Fri, 29 Aug 2025 20:59:05 +0530
X-Gm-Features: Ac12FXzVrwOupCSurf3cQGAZfJ2_KlEiScP3MFCFXTGKsdhk4k2-7zwHh-WJdT0
Message-ID: <CALkFLLJW+rt7Wefb_GXNHNT_Wos--qusNP3fbH9CQN5WqfD5dw@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	peterx@redhat.com, david@redhat.com, lorenzo.stoakes@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	shuah@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

I see v6 (which did not rebase over the "unused" params) no longer
applies after e29ae64d65353472d4bdb965f256dae9181aba44 was added to
mm-new.
Will send out a v8 rebasing over mm-new's tip. Should be no functional
difference, therefore I'll carry-forward the Acked-by and Reviewed-by
tags, please let me know if that is not desirable.

Thanks,
Ujwal

