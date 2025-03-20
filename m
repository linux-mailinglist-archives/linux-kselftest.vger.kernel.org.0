Return-Path: <linux-kselftest+bounces-29490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1328A6A46D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 12:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA9817FCB0
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 11:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D362144DD;
	Thu, 20 Mar 2025 11:06:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9281581F0;
	Thu, 20 Mar 2025 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742468773; cv=none; b=Y707RUvTdi3Ai9Qd3Wk5FbVSOw6OsUj0ZAVo+DCoUpu0xYprBQ+Qs9stJ/EiKNb2lKOVsFM/AJTct8Tg5IyMGP1vDZ09oxC1nR1O8aGExe/UEjkerFtZecPH4RiIpUTZryqfO0vV6KQJxn3ad6a8szxLcT4zSAhCfOlFF8MQdkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742468773; c=relaxed/simple;
	bh=rMmzATW4tVDymDKE0vN8VJAOMhhj/PfsjKpdbIcqksA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCWfHw7jQmrpaduGd0fqnGeABmr1IgZyh2Y56g950G6m+a2vcSuzpnJ81mvUg+D2wiL8l51hrc+PfukDmwGZZWmVeVWYweBKDGc3bHGg22AW5HPsBUlKnmTKPtdqcSGwqXESzPFg/+epJwFv17BbseFQGaJA8d6ccbmHvdfgBPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-523f19d39d3so325694e0c.2;
        Thu, 20 Mar 2025 04:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742468770; x=1743073570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ImC1ilYz8csQQTiElE4dlkIdMJPrZ9ZDKJ+eUaDLaJ4=;
        b=RkfyzX6LFpYTLxnmG4Kk1o9qsbpy6kFYVMAN5AizWLObdaR10CI7P2Qihg3RK5t/96
         W3xjOiqDvfecVPXqMUr26s8PK8NJ9wQVXHBhmsxbFknhcCLBPTfkzZUy7QZWTOTk/CFM
         ztcTp+jWjSQqT4c/5QtQwZpPoMNgn0PDidmEmYhwjzWGliucCKaDlOtsJBjN9kao0Uqq
         39idrU2Fr1WRliEa6Ss0mHbZRkrFEWEYJHvmYwYKGSrD1ajZkgMGfdWp3KbGWE0M1FWB
         xhJklEt3a+5y4HObm5r4AJTwsiW1hFFyOKVPNFWx3x8Sv5GiHmdxEIRMU67Jc9HrlEue
         U4fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkfTUjXPifpcahhdu8C+jYQdG/YwlyzVaO2/g4CxCSEz307ty+DK/Q9/EYlrHB2d12jb65EPrq2NXu@vger.kernel.org, AJvYcCUy2aoWvO1gjuHVMzGnLtkKaIT7CnpqZPHh+E/1GMJZgN8tc/cxEBtkGACPf5Qi8Jsfs1aesUbvINxckYOmIAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPRNw9DfP8HuA6sYn+OdLuxnofYvciz8K5so1ykw/bGvjPnQxs
	j6joT0O9o3H/jBYdhUq2a9+69QpMtkAtuaBBr6840Hilm8Ejttfkm13Zf04P
X-Gm-Gg: ASbGncsl2gBkvnu9i5Ca90UBheFsdoOTFVNNkVwAaO3l72Vn6YqAuh8ZFbbA5PJ/Khm
	RLctS7lRinvdMPddFm0N3UPyuXDEQwB0QL7rd3cL84UYuINiqaMM/v+pqAvezdrCNE+kST89IiF
	Kau3JLjyLYxZmFrlvh0g2ImemKYPPBWgjJWwd4HsId3csRhY7YCXE0NmIhT1Nao5wA4/y0m3zbX
	nyj+pat5bs5C0le5VV8mAFCVJiVFyeEyAne1rQbiDf1+c/6V3jFnuz6DQqxWMyzsQsK4/p6lxNg
	SYS//HNdaZvnEesU+YeleGFt1EgtHvvKkZaLwXplAhwhSt3Xldp4lz45syfMgSK4PDjccTjE7wW
	s9DcoxmQ=
X-Google-Smtp-Source: AGHT+IHpeyAIBciyN6hG5GaIshuXsPpPeXkTfMhui4TH3A6/Ih7pwSvXGVoIiy5GlLkmN17dlS0b7w==
X-Received: by 2002:a05:6122:2391:b0:523:763b:3649 with SMTP id 71dfb90a1353d-525963663f6mr1784530e0c.6.1742468769606;
        Thu, 20 Mar 2025 04:06:09 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5243a5a5432sm2849504e0c.16.2025.03.20.04.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 04:06:08 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86b31db3c3bso214779241.3;
        Thu, 20 Mar 2025 04:06:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/uzJwQGmYukFggCPtMDKiZ0WEIDd+PATorKVF/R726BkzIv99afVGIWTLQ+2uBaK02roz9D/CoH/7/cOAF7I=@vger.kernel.org, AJvYcCXOP5z5vOP53dHAzhMwGGMphT25SPZX8oQ6pqgXUG2VZBL48tUOtIX5gI0dxbg4drixuECeq+WXjRdY@vger.kernel.org
X-Received: by 2002:a05:6102:9d8:b0:4c3:9b0:9e6b with SMTP id
 ada2fe7eead31-4c4fcd4bbbemr2027562137.10.1742468768441; Thu, 20 Mar 2025
 04:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320103433.11673-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20250320103433.11673-1-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Mar 2025 12:05:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVwVyyZWfgFi12ujvSj8bVtDZyZvj+QMZ_iQbPbRDNHQQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jq_NsWp8NroIamQ-3N7pN5F3RiFVMT8Kt1Ob7GBfjLIVVkhLWqv1erTxtQ
Message-ID: <CAMuHMdVwVyyZWfgFi12ujvSj8bVtDZyZvj+QMZ_iQbPbRDNHQQ@mail.gmail.com>
Subject: Re: [RFC PATCH] rtc: remove 'setdate' test program
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Shuah Khan <shuah@kernel.org>, 
	linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Wolfram,

Thanks for your patch!

On Thu, 20 Mar 2025 at 11:36, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> The tool is not embedded in the testing framework. 'rtc' from rtc-tools
> serves as a much better programming example. No need to carry this tool
> in the kernel tree.

Where can I find these "rtc-tools"? They don't seem to be carried
by e.g. Ubuntu or Debian.  Google Search gives lots of results for
something that looks completely unrelated.

Ubuntu also suggest:

    $ rtc
    Command 'rtc' not found, but can be installed with:
    sudo apt install nvram-wakeup

Is that the same rtc tool?

>  tools/testing/selftests/rtc/.gitignore |  1 -
>  tools/testing/selftests/rtc/Makefile   |  2 -
>  tools/testing/selftests/rtc/setdate.c  | 77 --------------------------

Iff this can be cross-compiled easily, it might be a better option
than the rtc-tools I couldn't find...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

