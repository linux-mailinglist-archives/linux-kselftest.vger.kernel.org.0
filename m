Return-Path: <linux-kselftest+bounces-10220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCAD8C5F6F
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 05:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3E201F22F8B
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 03:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C408C39855;
	Wed, 15 May 2024 03:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OeXzdptl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C421B3770D
	for <linux-kselftest@vger.kernel.org>; Wed, 15 May 2024 03:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715744242; cv=none; b=TUDpMhzWhQIaE5zfnR30vADGMoZC5H5gg2IgvP/vIRitOurHfLIKLK7YBriTIVOHaEAk914CqxtyXg9lwf+WyZb1Rribe/23RC13AmU62dHA5JkfrsGEXGWE+0eta1+kugkRqpX1Uxrh2FAoWnQV2hCvAYrbyOlmJzL6bYEibdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715744242; c=relaxed/simple;
	bh=EfdUCHrSrcD/J7rjef0Mhq6ZfzJmqLp0Wf8LNr0IwnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjondrVFf50+st0KiEu4YGuxPIE158oAeNeUHNkakdChNNdMc6S7EPBkTgItyBjX0qmJzhZF3CPF28Y2HRQoAxHYu6vO6OsKEARi8Pb5DA7JQ+wYGqjr+c9RAb+8FUbJneYnL+xFkXxh1J2egLGgkkF1QHG6LgUX/Lxf0y5Igbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OeXzdptl; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51f4d2676d1so7017782e87.3
        for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2024 20:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715744239; x=1716349039; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s05R5WbZKAqPwH8O5MN7TtiDlbeN3dQ+l+K+4TPNREM=;
        b=OeXzdptlYHRHotHfr8L3hIYRCYxZeEGSVu7eXm+9Fkj/WFSMKwA8GXwg1cXx8mLO3U
         a7Nvo5Kjc/IkTVByQylCxc3j7t4060erNXomYEJIJVEa76vFUIYUNR9Cb2Tnm1GvioNG
         l81JhS2VMtWC4wI/d0uLZKS7pKJYXSpg2OYag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715744239; x=1716349039;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s05R5WbZKAqPwH8O5MN7TtiDlbeN3dQ+l+K+4TPNREM=;
        b=UOZfGGEx0Vre/nMlQV8mwRjSNhj/D0N3ThOERrz1QfVRUneuzNcidp3Juh38DcMQic
         rFJxKpRCH6KPWW+n/bNDTukDfp5TuTZCX6ZLY9w4iFRXrXwYBItKlgYCgvOFBw+tGHZ2
         ubmBPTPSnEB223sj54m9R3wDeMoTIpAJpfEMRWdy6yzzGqDH3mglyM8OxCqDvLtyC2rn
         HVrS6VcZ6qZBKitwwQ//2MNF1ts3OsYh+MVsJafIxGAfyTsEmMghgl/eGdl7dWzJsrzH
         0DK9LtXygoLKAEUF2zwCskzfeDQO0Rd39i4REbaGWiZutvOTzbJDoRE/SwjjSHNMNG3P
         A82A==
X-Forwarded-Encrypted: i=1; AJvYcCW5CcF7yjPIXlcLk6BHL+kNX+Su1cS3yoVuS4YrEmc8c0o2x/MlzOhU6yWQ6GZc2JqprlNmbwTfhtjiff6JMuIIO4GGYyW7fN+gD2925FBu
X-Gm-Message-State: AOJu0YypA3Zx28SpmcBui+SYHijuuRy+fg6AdJLcHcYq84GETOsu+jHw
	74hBEK8kYH4x4N8roLcKVgXYBrLSPkrUJ0Z8Oqxg1bFLkR8BSZaPzxAaMY+xmf22ZZ9EVfoHkNz
	yBoQGrg==
X-Google-Smtp-Source: AGHT+IF/NdxwITWW/oko5HxnChDxOzARvFwVs0kq9C/8VA5nLFCYK0zRaH9dPJVP+MOEck1Y9MvlpA==
X-Received: by 2002:a05:6512:314c:b0:523:8cd3:42cb with SMTP id 2adb3069b0e04-5238cd343f3mr638094e87.7.1715744237819;
        Tue, 14 May 2024 20:37:17 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7d92sm806958466b.98.2024.05.14.20.37.16
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 20:37:17 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59a387fbc9so138483366b.1
        for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2024 20:37:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXxEzIe6SgILYYGGTPa8Mvvwx9o61K5u+smSqolOeKGq+JBhfcsjd3lbr1O6TJi6feypSUJrNcTaEX4/6cE5jy4ET2RhsD53kebYbwcF0wA
X-Received: by 2002:a17:906:3d6:b0:a5a:7ce8:f52c with SMTP id
 a640c23a62f3a-a5a7ce8f6e1mr298659166b.16.1715744236120; Tue, 14 May 2024
 20:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <871q646rea.fsf@meer.lwn.net> <ZkPXcT_JuQeZCAv0@casper.infradead.org>
 <56001.1715726927@cvs.openbsd.org> <20240514160150.3ed0fda8af5cbd2f17c625e6@linux-foundation.org>
 <92453.1715730450@cvs.openbsd.org> <20240515025811.GA1232@1wt.eu>
In-Reply-To: <20240515025811.GA1232@1wt.eu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 May 2024 20:36:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiW4V5HRQ5Jm_MnSMVTeivS_4kdm1dnc08d03UKzmyp+A@mail.gmail.com>
Message-ID: <CAHk-=wiW4V5HRQ5Jm_MnSMVTeivS_4kdm1dnc08d03UKzmyp+A@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: Willy Tarreau <w@1wt.eu>
Cc: Theo de Raadt <deraadt@openbsd.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>, jeffxu@chromium.org, 
	keescook@chromium.org, jannh@google.com, sroettger@google.com, 
	gregkh@linuxfoundation.org, usama.anjum@collabora.com, 
	Liam.Howlett@oracle.com, surenb@google.com, merimus@google.com, 
	rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 20:13, Willy Tarreau <w@1wt.eu> wrote:
>
> Wouldn't it be more effective to have a non-resettable prctl() allowing
> the application to prefer to be killed upon such an munmap() failure in
> order to stay consistent and more robust against such class of attacks?

This whole argument is based on a castle of sand, and some notion that
this is a problem in the first place.

Guys, if you let untrusted code execute random system calls, the whole
"look, now unmap() acts oddly" IS THE LEAST OF YOUR ISSUES.

This whole "problem" is made-up. It's not real. Theo is literally
upset about something that Linux has done forever, and that has never
been an issue.

Stop inventing make-believe problems - there are enough *real* bugs
people can look at that you really don't need to.

                 Linus

