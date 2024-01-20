Return-Path: <linux-kselftest+bounces-3271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43F483355F
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jan 2024 17:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E154283EDB
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jan 2024 16:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602A439C;
	Sat, 20 Jan 2024 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hGcVG6q1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5567B11727
	for <linux-kselftest@vger.kernel.org>; Sat, 20 Jan 2024 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705768833; cv=none; b=GHEyGSul5c1lYQo04VpM+Mwoj7b42G+Tgv6f5Cwa5xr4qC7UT1wT+6XUwSb4Q0KIo993Hn4lrZq1b0Agq6PpbmS6kA1hfhE3mjxEG/i2JImAcMlQpHPJ3GhhtgVZAyPkUTPHjb+lONe81t8MwHSC2QJhPw834XHBFfFXTlLj6Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705768833; c=relaxed/simple;
	bh=YB/JxYQ/pIR3ToqU03uuFdu3N6gqG3VeZ/Otmp/LweM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mkcr0gik5EQWokPnHWM+GsuHOUg+FTEUsiMGw0de1RIvZINWNUutSlMGWh2zLX/TPJtOzmCa9xO3San1FJ+ihm3x30BZ+DTzQlMbfL9lIczopONwMW97xIJ/oscmgKtAkAOJCTIPI0ueVyJF1BayZ+Ra916ZBN7udxuza+/7xvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hGcVG6q1; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e5a9bcec9so1923684e87.3
        for <linux-kselftest@vger.kernel.org>; Sat, 20 Jan 2024 08:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705768829; x=1706373629; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lKz6ORL5rgrlrEyJEOMpjmvWzW5nRmmd6FHj6yauGbM=;
        b=hGcVG6q1r51PDOrz4cAlCQIZsQKYg5ZnYl9PPX1g20/p3GTVkNevN4mFzJTV5vp1g8
         IWj2kPKvRyvtlyIt5w87kCp1xaC7uLPOYaivsGK8Gb4MTJoYeFq1XuOGOlFqbmFsG+4W
         //hdgy6Ydjqgi2PBmqwedwexwuVXbkn6it6Wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705768829; x=1706373629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lKz6ORL5rgrlrEyJEOMpjmvWzW5nRmmd6FHj6yauGbM=;
        b=tZQgDZ0vnJIYKDaWLtITPThHfcIwMa2EeRM5Cduk+nsyL8BRaV69opChPWtAdHCEU7
         5xrraZZrFk0vjXN8MCAlypA/xdtzuif9uErg4FjNjTt7s8D2QXkyVZ0RpMG/KVZljok+
         AJwHP5k8wyqFFZZNJauECpG3JGPHn90kRmQqH94Xm+Ll/7poLQJnLx38Q8kj3ngRWMOo
         lTIQj7bXOp0zBIFixO6XW7jj9p0pGOr1nTAVh/fUn4cfmD6DbEspkYnwhoL93sB3oXR+
         QtY8J0jeR+6JzCEgO/uDE7xNOiPvFQaeBwaYak5zwHk1mx+9uAHup+pcv3oIHKx48iNU
         oLXw==
X-Gm-Message-State: AOJu0YxT7mdNbF2UWn6lxgYkMM9GWdkx5cxc8Vls6fvwJX35qkPu8ReT
	VGwCX+EM2FlFRzNHklLgktz5VUWn40KDOnwcEgska0a9EfFgzf7igq8lpo4QaOYn9Z39xRcPo6d
	RFrS/ZA==
X-Google-Smtp-Source: AGHT+IG4rfBcZ7E1hp1G2oU5ErdYvk7dsdl8u3WKl5wVe5dRVwKH6l0EB0K69lnpXp/LqY2hD5P9hA==
X-Received: by 2002:a05:6512:3b90:b0:50e:d5e2:92cc with SMTP id g16-20020a0565123b9000b0050ed5e292ccmr949327lfv.81.1705768829265;
        Sat, 20 Jan 2024 08:40:29 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id y11-20020a170906524b00b00a233515c39esm11500933ejm.67.2024.01.20.08.40.27
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jan 2024 08:40:28 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5578485fc0eso1777368a12.1
        for <linux-kselftest@vger.kernel.org>; Sat, 20 Jan 2024 08:40:27 -0800 (PST)
X-Received: by 2002:a50:8d56:0:b0:558:d206:3bba with SMTP id
 t22-20020a508d56000000b00558d2063bbamr704311edt.20.1705768827089; Sat, 20 Jan
 2024 08:40:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212231706.2680890-1-jeffxu@chromium.org> <20231212231706.2680890-12-jeffxu@chromium.org>
 <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com>
 <CALmYWFu39nzHvBmRsA326GcmV9u=eM-2aCGOvLK31rrb2R9NEw@mail.gmail.com>
 <CAHk-=wh_VViVZxjiQ5jtB0q=p=JtJMj2R24UAmj-fL-RNLWxNw@mail.gmail.com>
 <CAEAAPHZpYXHNPdca+xfj77bwYaL6PY-c_oQ54r+=wtJa6_hmCA@mail.gmail.com>
 <CAHk-=wiVhHmnXviy1xqStLRozC4ziSugTk=1JOc8ORWd2_0h7g@mail.gmail.com>
 <CABi2SkUTdF6PHrudHTZZ0oWK-oU+T-5+7Eqnei4yCj2fsW2jHg@mail.gmail.com> <78111.1705764224@cvs.openbsd.org>
In-Reply-To: <78111.1705764224@cvs.openbsd.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 20 Jan 2024 08:40:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgdhbLeY=pEY27m4OQuDAn9xkzSLHwE9D8m1Dw8a++n=Q@mail.gmail.com>
Message-ID: <CAHk-=wgdhbLeY=pEY27m4OQuDAn9xkzSLHwE9D8m1Dw8a++n=Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 11/11] mseal:add documentation
To: Theo de Raadt <deraadt@openbsd.org>
Cc: Jeff Xu <jeffxu@chromium.org>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Jeff Xu <jeffxu@google.com>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Jan 2024 at 07:23, Theo de Raadt <deraadt@openbsd.org> wrote:
>
> There is an one large difference remainig between mimmutable() and mseal(),
> which is how other system calls behave.
>
> We return EPERM for failures in all the system calls that fail upon
> immutable memory (since Oct 2022).
>
> You are returning EACESS.
>
> Before it is too late, do you want to reconsider that return value, or
> do you have a justification for the choice?

I don't think there's any real reason for the difference.

Jeff - mind changing the EACESS to EPERM, and we'll have something
that is more-or-less compatible between Linux and OpenBSD?

             Linus

