Return-Path: <linux-kselftest+bounces-10214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F6B8C5EB6
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 03:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0315E1C21037
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 01:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0046E803;
	Wed, 15 May 2024 01:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A0U200sa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDC06FBF
	for <linux-kselftest@vger.kernel.org>; Wed, 15 May 2024 01:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715736044; cv=none; b=dqV69+2SC/e+nPo1w6tsHWB/QqF24TWwdVoOb4hsFKMGFOrgdkPVaBr/CRkotquXi4aLtc3h0SmisuTHiEUtGvNr9pEe8XRyEwPpJk+RgA/b41JQ0H2y9zAs7TQ7qw2l3hyW8yfl6+1Y89Exasowl1nGCz5aMnIlsiICDnzGVJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715736044; c=relaxed/simple;
	bh=RWL2uQhi8Ed+uiGVKCNPstf3I/C9ZgqT5ZURnuftkQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJbbDyL+a4yU+16Yf+xe3EMFYmcJiMsdpHkCaKYqfs4AdBg0OzBH6b8mERBCd/6rZXznEhDsDbYiK+JuOz7Yoq870fa/5bxGF5AZnoM6kfFtMq/nh+snQwhp/mp5oBCfSArwQ7gMh/qrNEzPqVyaH4E+R/Ti93cNnLw5aIwnU3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=A0U200sa; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-572e8028e0cso842768a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2024 18:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715736041; x=1716340841; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nr8iJJBMAoKbZhUVSQrEstzktHb70Vrcza52uLAmnxg=;
        b=A0U200saubb6uDbNvXlt6+RUVdLaiiqyhlJmh4RGOzqSOBm0HgObIuU/secG/WSFwr
         4e6mwdluiACushBFTIb5yBaOaqTfLCQ1J8R4IR7kLg7ggORNqqR4Z7oe/gorzBN4uydv
         mH31hCrQxOl/CacEFdnjVY1H42DtGnYoeGyeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715736041; x=1716340841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nr8iJJBMAoKbZhUVSQrEstzktHb70Vrcza52uLAmnxg=;
        b=mAK/WbvrEIIDQ7qc7cv2adze2nKZ8anzQE5fJ8p6sFWtunPa44DLOEy9XUb1twwNQF
         tHV03gR5OoZok4+UhGSppJioFHRAHXeW5Om075p6CShl3zeAAdZa7a3CJXjtJd+jhOeQ
         lfm62RryWaNngIlceA3W6bhZT7s+sEW7uaA6Hqln3Gi8a0rYfGny9ko5Urde9gLlLEKb
         O8oT486DnjXKhwSNp2l0o/mKqQ4XbpApQUx2WKOhyoexIih02o3VCMLwP14oEJsQ8hEb
         jnfqTWkD2sZwYBoye1a+FHjrKlyH5DJU9vtOavwekaXaXotGyGR1pUGUOtvfAAmChOGm
         pKbA==
X-Forwarded-Encrypted: i=1; AJvYcCVxW7M1jslGHfTrZfMQMgmJIcipkyAx8Kr4JCKVQjpQybdwisPqcu3u8Ac0ju5l9jrcYZN0Mvs3izUV6GxG1b7stEs0zsfnB4Vkcylh2kbd
X-Gm-Message-State: AOJu0Yzke7RoJgWkm+8/Zbz89daEEACFuc7m//L0iR7zBU6cjQEafznS
	JwNBv3h6CZ8R0AG0BGHz1ggNMWpZxngv6ft+IfSRq2Ri4KNeR/tC/+WuQG3iwarChZOCpzwat2X
	qOWL5gA==
X-Google-Smtp-Source: AGHT+IHKPSvI3tmEUWflW54eOHiTuuuxovt0Wm9E0q+nIDNzOWAA9jzJLSuKx0LAnHn+5E29Np/E3w==
X-Received: by 2002:a50:d650:0:b0:572:6dd4:2ff8 with SMTP id 4fb4d7f45d1cf-5734d5c0fd7mr8459229a12.17.1715736041206;
        Tue, 14 May 2024 18:20:41 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574ec273185sm857584a12.42.2024.05.14.18.20.40
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 18:20:41 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a5a5cce2ce6so84759766b.3
        for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2024 18:20:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW9hJtpHQwAzk6mL5LjQoso/DrSutJ8JWbEXsBip+/h9qLSU/uzgBvv8WWoiVI2vKVL3eIeAdAiOPlxc1e77AKZxneUxVaVyahoWLHnEIdx
X-Received: by 2002:a17:907:9625:b0:a59:db0f:6bdd with SMTP id
 a640c23a62f3a-a5a2d5d56b7mr1123543366b.44.1715736040490; Tue, 14 May 2024
 18:20:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <871q646rea.fsf@meer.lwn.net> <ZkPXcT_JuQeZCAv0@casper.infradead.org>
 <56001.1715726927@cvs.openbsd.org> <CAHk-=wgsGCKvN0Db6ZRZqJwXQrmhZyWB6RmABaOp4DiZbXgNew@mail.gmail.com>
 <16982.1715734632@cvs.openbsd.org>
In-Reply-To: <16982.1715734632@cvs.openbsd.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 May 2024 18:20:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi04ZCm3vTtkcVnAUdiOpX3a0hBZ-aQWONwCubOJQEdXw@mail.gmail.com>
Message-ID: <CAHk-=wi04ZCm3vTtkcVnAUdiOpX3a0hBZ-aQWONwCubOJQEdXw@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: Theo de Raadt <deraadt@openbsd.org>
Cc: Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, jeffxu@chromium.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, gregkh@linuxfoundation.org, 
	usama.anjum@collabora.com, Liam.Howlett@oracle.com, surenb@google.com, 
	merimus@google.com, rdunlap@infradead.org, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 17:57, Theo de Raadt <deraadt@openbsd.org> wrote:
>
> Let's wait and see.

You may not be aware, but the Open Group literally endorses the Linux model:

  "When mprotect() fails for reasons other than [EINVAL], the
protections on some of the pages in the range [addr,addr+len) may have
been changed"

at least according to this:

    https://pubs.opengroup.org/onlinepubs/9699919799/functions/mprotect.html

so I think your atomicity arguments have always been misleading. At
least for mprotect, POSIX is very explicit about this not being
atomic.

I find very similar wording in mmap:

  "If mmap() fails for reasons other than [EBADF], [EINVAL], or
[ENOTSUP], some of the mappings in the address range starting at addr
and continuing for len bytes may have been unmapped"

Maybe some atomicity rules have always been true for BSD, but they've
never been true for Linux, and while I don't know how authoritative
that opengroup thing is, it's what google found.

> (Linus, don't be a jerk)

I'm not the one who makes unsubstantiated statements and uses scare
tactics to try to make said arguments sound more valid than they are.

So keep your arguments real, please.

               Linus

