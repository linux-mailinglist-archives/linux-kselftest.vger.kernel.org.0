Return-Path: <linux-kselftest+bounces-29492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB581A6A4DD
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 12:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C283B0B87
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 11:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A8821C9F5;
	Thu, 20 Mar 2025 11:23:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A8779C4;
	Thu, 20 Mar 2025 11:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469801; cv=none; b=bM9LqwrQvFa7o8MWcLvEco4sZEcrTrk20AUbAA1V/OcxDfH+J7CTnvhkbO+7lqO8ebHq+xGKsIZh2RQsqhRpT8PmGv/Fr2QJH3gFcrkfa6XYdfNF4mSkL5+BUohpJmOie6hETsw2vFJxyDPcyEV+ZisP82Kg2T1QTRBRAYbLXeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469801; c=relaxed/simple;
	bh=Cc5Im1GZrOSepMAgA4KpfZX3w/vPNrG+WuhFGNIa+uE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4T9J4PjeUo56XKfPiUh4tikibA2pkKuFAJvM5aftG8RpKChGJG3b3mjFgM6J3vHmpJvfGnJXYBHSu9lWqdPXeMzQgxA2wM2NOwSX35Lx4JaTEVJimdvT1L5siYPKWSQRB74ft+YQzrQ06F6xTL/vp4Zw8Ua0+TTOY3649DRwRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-523dc190f95so354301e0c.1;
        Thu, 20 Mar 2025 04:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742469797; x=1743074597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKHB50tWqEUG4/5rlUerqvsi2f4QoqE8Qg2V5ETBtaM=;
        b=RDye+T/46igMoAaramdJWNWFaYQDexkR+wo7voNvo/loB9y55QwKGKrURojSBI4yaY
         9PTV/4KRlLtZeNo6nVAaw672JdOIloM3GIUr+A9SaLcLl2exsPdEQa6WJkVmfgzEnuLF
         alVfcpNoKXLDstdJCIRKYqmBVvsZu/yXyJSeH3xjhk2nXFugFn5KBRf5jtZ1FEnMaWl6
         ZYaSGY8LG63CgWrojV3rG1BUO5QLQ+BgkJIYO5xH/6PoKDP95aP2RsnNSgFo/pC6ZvFA
         YZWiWbF1eSPEvQibs4R93urdoEXwYtu3bAMkWYdaPKQKuw2is9wrqMEi2oyZhAPDjzCo
         WBww==
X-Forwarded-Encrypted: i=1; AJvYcCVkgjiP5NaL2uhDmk9Zl25zucP/5O7BvGyrUdlikYq8NJnl6L7gBnRw4jKXoHEbmX4n4hsnhUTi3burRxBV7b4=@vger.kernel.org, AJvYcCW/9s4Y0Uvmfdx4nhze62rVcLU+nssTQ5xuo6Q9cTrFlWdrJlQsnrfcAWsq1+Q8LFnZi+RoUK6ZYVVa@vger.kernel.org
X-Gm-Message-State: AOJu0YwmrjFlYxMnCrKSJpeJ96rfVclp9JnUiGb4M2f0zgxprckiylTC
	jmSAJxX5sxT4+odsP/M/P1U6F8ks+17XuB9bAkWbCgSr+ZbTsza0VCSm8+i5
X-Gm-Gg: ASbGncvkV0zItAhMtsu1ATuV9PerVekTqgzBpsPqNqlG91Rs1F38UxtYxakMaddDh3P
	PRwlDetEpipXlYJ/GUsxeJNC/6ycYVhqpshVaL7o77YN3pW4hlD7rfUjYzW10vuipKBCqv29qdM
	2Gb00pc3vfgMqaNP0cXdY7/GjIkpabhx4BWINojqlh74uSwvkuFotDYOU9j8d15pj3Kbkxc7kNV
	THj1ZhJ457bcLiedJ5eHOmH5Ca90dNkEw0pAcZE3PeNVoFxQojcoxDgmRtPwcfC0TPRJXgW7lXq
	8KcBmXMJ7AQHD/CiHxJtSqH46i9ziKuea56DX3o5DD/72BjK5X/hV7W3E8/psPTTuJ+GDz+JdkA
	orhmcu8Q=
X-Google-Smtp-Source: AGHT+IHs/D8HSYzRD0hCwabCBCI9q0lGeHq//gvGJ0OAnWY3k55IdAQTF7Nkh5tF7Yg0oR4ka9diwg==
X-Received: by 2002:a05:6122:6081:b0:520:4539:4b4c with SMTP id 71dfb90a1353d-5258921466emr4976818e0c.9.1742469797264;
        Thu, 20 Mar 2025 04:23:17 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5243a6e5ecdsm2852438e0c.29.2025.03.20.04.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 04:23:16 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86d377306ddso270905241.2;
        Thu, 20 Mar 2025 04:23:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCLY/GewP6zAwY/ESZ9y14ofIh45q7tO9Apv4EsIlZkPEHzPf417glyiT4mKozqpD4SbrGapWqpR6v@vger.kernel.org, AJvYcCWiDXaqTSpAQxdwSqrnLxHJBVfeVey1mbjTQaxHW8DWE7I09NwJVUvzMl4XiNl6rZNpFBF7Rny0yK54PFjP0Fc=@vger.kernel.org
X-Received: by 2002:a05:6102:3ed5:b0:4c1:a049:27c7 with SMTP id
 ada2fe7eead31-4c4ec690714mr4879033137.13.1742469796680; Thu, 20 Mar 2025
 04:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320103433.11673-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdVwVyyZWfgFi12ujvSj8bVtDZyZvj+QMZ_iQbPbRDNHQQ@mail.gmail.com> <Z9v550Kbt8tjYst3@shikoro>
In-Reply-To: <Z9v550Kbt8tjYst3@shikoro>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Mar 2025 12:23:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVwNE-o2_eq_Fu4FXiSnJn5rsg9P28PusYn3DKNdszOwA@mail.gmail.com>
X-Gm-Features: AQ5f1JpfMMqlrEw5gHZ8B3A03RG-RhXs5S59xboLirW3IVJg8-z1l-7JcoPwReM
Message-ID: <CAMuHMdVwNE-o2_eq_Fu4FXiSnJn5rsg9P28PusYn3DKNdszOwA@mail.gmail.com>
Subject: Re: [RFC PATCH] rtc: remove 'setdate' test program
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Shuah Khan <shuah@kernel.org>, 
	linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Wolfram,

On Thu, 20 Mar 2025 at 12:20, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > Where can I find these "rtc-tools"? They don't seem to be carried
>
> On your favourite git server :)
>
> https://web.git.kernel.org/pub/scm/linux/kernel/git/abelloni/rtc-tools.git/

Oh well...

> > Iff this can be cross-compiled easily, it might be a better option
> > than the rtc-tools I couldn't find...
>
> Did you find the 'setdate' utility? It is in 'testing/selftests/' not in
> 'tools/'.

I found it, because you provided a link in the diffstat ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

