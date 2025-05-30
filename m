Return-Path: <linux-kselftest+bounces-34043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A43AC8936
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 09:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317FA1BA6BFE
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 07:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC02220D506;
	Fri, 30 May 2025 07:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfRovX3e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AD01F5425;
	Fri, 30 May 2025 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748591128; cv=none; b=WJJkA+oe3j6tuyg7Fp5d/tlA5deOBwjY/gKcVKAInshR7FuqsH6QtYTlYwoAS862tvLh5C5vVwzdZSLl24uF8DQBPYF91NgeCCgr1CmBqliqEN+PgxzlxEAwveYUA5XY0C/o6fSALGh+nG6xmY2UUqGNv4hbFkszMlUksnj2Uxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748591128; c=relaxed/simple;
	bh=pzOa/UgrS9Umku7hdGQ7ovp+X/tJyw92DDjRJCHRzbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AS2XLBXnNWEjzq3vBhv9cYhYJ4ukt5h15Qb3BKNjAzwiNoNEDDYypykcNSwLdpD4i87unMOf9O0PB+EgdKQ6GOoo0dLB7sH0eKWZ3zOVqXLfRAoDgKESCFgEWW/u3akD8xFMnRa62IfdyY3EaEFs4JjVg0Bj39NXTvDr4XdQs0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfRovX3e; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso1382804b3a.2;
        Fri, 30 May 2025 00:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748591126; x=1749195926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pzOa/UgrS9Umku7hdGQ7ovp+X/tJyw92DDjRJCHRzbI=;
        b=dfRovX3eRH15CCuKXzCizPQsfv5XiNtB0ETr6VzZTVI8hKhyYMFG2IZ6QfnrTXl3CQ
         u8sCNMxTwKAVibz7yfchW3Q42BTOBQyg1s5KYKzGSEcGasRq5N41UX+F7dE5E4zuC977
         OphFsn2dSmnLn4rXZFMpfDSI/1jDRGtFatKtHkBaEEcMi3t18lnR/wA4v3DSex+M/2ka
         NbnbFy9KwAXBIRsoOT5LgYQDTlz4gJj3eRD+hJoZ09WpZWNkwpcHaTwRvsH42A+nc4HG
         tWGYaQbe4LGHZpHO9fW3lIPxlOKlFfR4kfBkxCl4sEJoW03+Tcf6gNixy2i1C0KAmv2w
         n5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748591126; x=1749195926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzOa/UgrS9Umku7hdGQ7ovp+X/tJyw92DDjRJCHRzbI=;
        b=vqIZmA5opWnKaftTNfzNEjtGFcWNcROjLnG5Jg/+LJRsje6EgOlz0UXErgIRjSp3PH
         Z4J68VPufHMObOI7Pauzvw8ni0BXNlC8dL8orOHfcv+hU8LJjkxtY3LTEQxydK1bZfvE
         jv5ups3GnYea4dmugeXPHy0obGMHzioXNG37CORJIbr7vkKWbw8HvcIXmJGg5gkF1694
         /N2LBdxXHiIHJ+g9ZyUm1R+8C8iv+Uvax6LScG+n1wLFgK9ZqD1za+aKJrSynDxjGLj7
         80dx6Xr2UnPCjn5glrhBYCK8xfg/9nEfkRIerABjyyC+u912CuvTWun6eJRe9WKTAX7a
         0byA==
X-Forwarded-Encrypted: i=1; AJvYcCVojGy/NP+ACg1Z5A8hSiM020wUpI5eRzMeuUJazCAzUmRvLTgDilOgLkcK3ThjSEiBM/9u4ABnQ11ibHk=@vger.kernel.org, AJvYcCWL8yuNZKun1HrApYtbD8NJMFY8Ia/cKyXp4qVpJTXoFr2kXvb4U51U9U2OWsBwKj/HOQQArcp6puRIx7EiAT58@vger.kernel.org
X-Gm-Message-State: AOJu0YyEhVjf3TB0kNjhM1uRRGT6efDdEIvRw5j50U//HhD4zIT0nsEA
	jpZs6hr0Ojjk9vQSkL5HCDNxxwCwEqvzg0I8PVqgYXCeIft5tg7zIqOwRnTCpeiUwGSwKSnYz4g
	lWI443LNr1t5yKDkwaJ8Xug0XUI4mcljcbtuPsQ==
X-Gm-Gg: ASbGncvqC820+JMqTiSO0aqSQqiLxLg5pyuWylQD6WwHA4fW+R07foT+Dql3aP1QPSp
	baJaBvdqUzTW7Rhg8Vof0SLeZNvvb3q0rApfiyahWJjLrjfTDX8uZGh9xSiQUVOAP24LKtVvNJ+
	tHPbF7iW5brcf7uAvC04mkC9SzEGr6Tq/EefwROjKlcW2uudNQzKtmvuvHpBftNhVFsZFtPujvP
	II=
X-Google-Smtp-Source: AGHT+IGjkyt+5maMLA3DqnIou9TTiHmTo5+xl6kXpbOGFBDFFRIUaD90grOdP2fLlk7ybBrIk+t94W9pQB2C97dcVy0=
X-Received: by 2002:a05:6a00:a29:b0:746:2a0b:3dc8 with SMTP id
 d2e1a72fcca58-747bd9ed7c6mr2995642b3a.17.1748591126498; Fri, 30 May 2025
 00:45:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501163827.2598-1-ujwal.kundur@gmail.com> <20250510160335.1898-1-ujwal.kundur@gmail.com>
 <D9V0UTL5BCLM.1WHR6F4UN14QQ@google.com> <CALkFLLLfxT1pQ_ySB1NU4KXOEGLd2wB8pbhpBG2HfK3_mLOYAQ@mail.gmail.com>
 <DA0VHZ6KE96B.XOYNEFMGWD58@google.com> <CALkFLLK19Uqr2veWCn79cbLLgde5f+otf9Qx0xSPGdhdnekGrw@mail.gmail.com>
 <DA5Z38N5WHO5.2FFOQZYC6WKMI@google.com>
In-Reply-To: <DA5Z38N5WHO5.2FFOQZYC6WKMI@google.com>
From: Ujwal Kundur <ujwal.kundur@gmail.com>
Date: Fri, 30 May 2025 13:15:14 +0530
X-Gm-Features: AX0GCFvl1t3aZ635dE3UAXR9Vmuz_M0u8DD3KfxntZ3wNAPx5Iro3jK1qTCBrQU
Message-ID: <CALkFLLKc30TGwsZ6Ntw9UwKthJ0cW9BMfrHRJjgT_y+zAu1Ftg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
To: Brendan Jackman <jackmanb@google.com>
Cc: akpm@linux-foundation.org, peterx@redhat.com, shuah@kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Sorry I don't have an opinion on which of these is the best (I can try
> to find some time to form an opionion on this later!), but:
>
> Fixing the flakiness sounds great, but I would suggest decoupling that
> from the refactoring. If it's practical, focus on removing the globals
> first, while leaving the fundamental logic the same, even if it's bad.
> Then as a separate series, fix the logic.

Thanks, much appreciated. I'll send a patch with the refactoring + a comment
regarding this variable left-in and follow-up with a fix.

