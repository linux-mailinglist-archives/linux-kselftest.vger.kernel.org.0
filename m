Return-Path: <linux-kselftest+bounces-34150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9C0ACBAFB
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 20:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73481883182
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 18:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E1D2236F8;
	Mon,  2 Jun 2025 18:14:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDF55D8F0;
	Mon,  2 Jun 2025 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748888065; cv=none; b=Zj3XIZitL1riOnQ43OJio62MeLDyGTpOJHrwJhjVy9zG0tVAJuNPHVhrzsD0gZlYYWR9RN81P9BIJ2wQSCMBLl78uAgL36II4RnE04f6yuAHGo6WEP1yO0BW/6afMY2y5nS/o1NxJKXSZcYHhTD8jJUb/Y4ohTktLr2xL8FTg6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748888065; c=relaxed/simple;
	bh=9jQ0U2gHRObiwUnXO9MXOQpk4vA5/JitVdacAj9Suiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8/GFOHB2PNi8HU/0GHGNEIvrfrXsSv5ifu6Djd2Gg77wrfMlRwMbnOsphY4zwIrAPzRe4XBEgCcACiDbFurJZdA3SLBdw63JopPn7OqgiNkk6tRpWsf6NmX9GhalsCMPkKvQjYodFvkWOp/J3UkVwnvkvZitKYllgBa+gt3ZlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-530807a8691so1198264e0c.0;
        Mon, 02 Jun 2025 11:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748888061; x=1749492861;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OfcaPVpyaX4xx974IzagCVdP/HZRVzw7PK6bWsNoyHI=;
        b=m04ojuKucGeeJhgQxSfWE0Orni9Ewg6WY2zL1ePfkVpHTJs/Typej+q5LvG3XFJUgw
         TXnL+6fHq0BKm+6hhG9TE7jsttqOW/uxoKVJsHwcwqtDZQOQ0nkeyCXkhhV49dvFsn72
         MFROZ4q8gnruqNbqdeUqpA2pPs3qa+jcFEjxzO9uyas1v8B3zvz2P5JK6ulfKcvNbTXw
         hIIKUu1LUNCXakn4xCCiOOFPwL2x8vPlnFSouZ3hnYv2dzYhMeqJaEmgwteMLUTQt1fP
         nO6LDjhugyMEC9D6Zz7w7OSuHp7ocFBkx8LSFWOlm/g3PJuQlXCnuy+ZQ9CTvHX7KJMt
         SXMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmTV+U6XJS3NX2RSUFbV4jav5CNm+YC78lTgm12yaYib/7iWqEV/EF8AIrq+Au9PFtOeJD7xkAd2mIjcmB7s0=@vger.kernel.org, AJvYcCWG13q3wIZJcaDcDY47frpBSXg5cfSRvohzF/nfbFvCTpW2hpKxbUj5ACShg2TdBBJJ4fn8l3SYgfyel86j@vger.kernel.org, AJvYcCWHnOZQdF17wDze4CbyDj+5GYKkcCyHiz08ky3ac7PXnMYluGH8KrQ6CDTZAl00XLvWkBX2BEof6ASug0E8aC29@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+zwBnAvi0DDcIP9dIKU53YbWVd4e5XB5papLK9iXtGeQacYWZ
	yT/n2zrA+tnhXVvNGliXo0pWwLUu2TnM8euS96+O7aqDgR6esrf3qJ2vMY1RNaUf
X-Gm-Gg: ASbGncsPat/CTNQFCX+QkHVBD8kClRFmnlOeLmAFY4FwF5p81e6dOu4ZoCNB7Siu7OT
	AsKWpMAEn8Ys/9adAIQfI8HTzUh+6E6nBCl1xl54v0jXyqYnv9sZP2WsS81W/34frJZD9dsD5Tt
	nz2WcADDhOINV36svdJKn+Y01iq9pvymi0DTfDugFyqKVavtYa3KqFtSq6wxK4zEFMMX3ttPwOd
	V5UIquWytR1F6e9PUyqgkV0J6jyWbinVpVLK1AiF7Sg5bosGJJSUwc3Iy3vWmmZHzLGjxxWk93q
	07cZeLDGNqc4vkz0pqXw5hxeHWfULQ4EPPHA9UoyLne9EwLQT9PywdRP8gNuF68smJlUx4g69cB
	4OgYPmB4zIVlyIQ==
X-Google-Smtp-Source: AGHT+IFxKwZOorger+hXumaGbX8E7ZDPgSJ4s/NSq5QgcaVYnsi/AJcKOrzx1cLUnVkYFWXgUTCj0A==
X-Received: by 2002:a05:6122:3c8d:b0:52f:4680:1c89 with SMTP id 71dfb90a1353d-5309377b27bmr6719224e0c.7.1748888061361;
        Mon, 02 Jun 2025 11:14:21 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53074b066b2sm8005151e0c.26.2025.06.02.11.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 11:14:20 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4dfa2aeec86so1983395137.1;
        Mon, 02 Jun 2025 11:14:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURwOIx7N5X7hk2oDpVWNk8Z2lTgE9UeQ6I9FrYav9gfD2mqLqLQflcTInvVbiualxPBQDaPXvbdamwElS4@vger.kernel.org, AJvYcCWmQSL/O2OikKfKvLNX4JlebTDgdQNCmyZBRpWPHPANTx7D7KEKVCY9M+axml6E85YluAKkJU+LaNLxpfYFNrk=@vger.kernel.org, AJvYcCXzI68+IWouuZNExKr6Nm51EP6X2dxPk6FGYYXhcFWT5b1gfKDAW6HtRFSaiyAickclRrbI5nXaQ9PSdlU+jusk@vger.kernel.org
X-Received: by 2002:a05:6102:5112:b0:4e6:df89:66c4 with SMTP id
 ada2fe7eead31-4e701c885c7mr7061879137.15.1748888060110; Mon, 02 Jun 2025
 11:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22d9c2fa9e751a9de3c599aa082be588ea82a7a0.1748875640.git.geert@linux-m68k.org>
 <202506021107.EA2F1CBDB8@keescook>
In-Reply-To: <202506021107.EA2F1CBDB8@keescook>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 2 Jun 2025 20:14:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXN_1zwWuTGYuv4aH57cynsNA8443dbRgp+UTMzdvyLNw@mail.gmail.com>
X-Gm-Features: AX0GCFtDu7rVYpa0wj_soUXZNLZi24EssDl7iT7tfOOyF2W8n_Ma87VlvY7UkI4
Message-ID: <CAMuHMdXN_1zwWuTGYuv4aH57cynsNA8443dbRgp+UTMzdvyLNw@mail.gmail.com>
Subject: Re: [PATCH] lib/tests: Make RANDSTRUCT_KUNIT_TEST depend on RANDSTRUCT
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, David Gow <davidgow@google.com>, 
	linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Kees,

On Mon, 2 Jun 2025 at 20:08, Kees Cook <kees@kernel.org> wrote:
> On Mon, Jun 02, 2025 at 04:49:51PM +0200, Geert Uytterhoeven wrote:
> > When CONFIG_RANDSTRUCT is not enabled, all randstruct tests are skipped.
> > Move this logic from run-time to config-time, to avoid people building
> > and running tests that do not do anything.
>
> I don't like doing this because it means that looking at CI output means
> I can't tell if the test was not built or if the config was not
> included. I want to always have the test available, but skip the test if
> the config is missing.

So should we drop all dependencies from tests?
Do you want Zorro bus, NuBus, ... tests (assumed we have them) to
be built on all platforms, and "run" on all CIs?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

