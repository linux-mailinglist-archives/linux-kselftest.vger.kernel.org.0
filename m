Return-Path: <linux-kselftest+bounces-10222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4489A8C5FA6
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 06:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9CB31F228E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 04:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A42A383AE;
	Wed, 15 May 2024 04:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gV5pUV/4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAEF38394
	for <linux-kselftest@vger.kernel.org>; Wed, 15 May 2024 04:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715746498; cv=none; b=A//hAf2bJTc7jZ0Q2NqQ07mryJIHapCMOZ5WSqZQ/6vgZoDLS1VBDyfY+UkMfm2KgJg2xRKZ6CO0I1cNAhRP3rvnh3vAaxIGmvIRLJD7MAnIo6MINUGLG9rFOYemegDKAmLI0VEVCgRuB4xa0TFOcHpV9MNH1Z8VPbsFVBtRUZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715746498; c=relaxed/simple;
	bh=XhCwhjcGydXDxiHtSK4BdYzcSeAyPu3k1yt7vJg0K8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAOuxDUr0OSw+YLTJQ5wVqmfygwP1Yoxnd2Vw0snZxA6Qhk+R8ll9HNu1q5yi/cSgBonjUj5RsnU6JYtq1CDxrFNcTx6NDtNBakQz42NqMUMdE4lKo1URawy5WEzd2krDeTXvs/saL4golvDLCnDzrKCtc15eUXH3jXkuxemBzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gV5pUV/4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59a0e4b773so123479666b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2024 21:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715746495; x=1716351295; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r4cKs65r0Vn5NjWdK37SwLqUt+S38IkvifOxEI5Gn60=;
        b=gV5pUV/4Zn/CzTn19xiPM+LIF6WBNxT9Z7ABR/s41VpeH8MpHFVE5KcnoD+k8zAAlb
         KkIDoJfnqRoaUhskV+rLL39C38ua2HZLTKFUPE0KMCu8kUk2gfU4W0+WUt+gCLPx1sAn
         IvUjccMKK2XUMPD6+R6K+4W0Q89jOs4SNSWS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715746495; x=1716351295;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r4cKs65r0Vn5NjWdK37SwLqUt+S38IkvifOxEI5Gn60=;
        b=ELt6/3u/OFyNKpfX+hRViF7gcV9nJN+5xOjWcDvP6LY/7IykmyrXIi3VMGT2akNCpq
         Q2s2AgBMjxA2m5ydwpMwQGd/fefJJfzoMg2p9FfyNCOZyLoFtmR6/MgxcQ3UVknLtB0R
         5x4GxnDjxxyJIUUhtYxHOhIOCfg1ByPzv3UkwQ3TwHCh+Eq4i9PAVbf8oW+4qOYfIjGV
         S6y8iLGIJmvp7ERIro9IGmOlsjUQOdmx67iev8UG2Mt9TXUDO/pnIYdCUhv2V8Ence/U
         J7DdGbh4y9NEOUSCQr5fc1iOW6xU+WrGOoazTWNB7nak3i5xX+7ifMyVApgw7DsvGjHF
         IaQg==
X-Forwarded-Encrypted: i=1; AJvYcCWFo3rYz3QnSYPI43C7UK7a+cA/Ol8BNfWPsoGnHiVlrA4650TahSwbVBCH67FxC67dG+ZTcLDZpCW5Ifs2nVU7nIJb//DYcB6E701mi2vb
X-Gm-Message-State: AOJu0Yz367sDy0cejAEgEgZ71nNi5K520nP3/2gJFh14fvPBceE2HqmJ
	VcB028ywnByYTN1zw2qf4wfWoIwJV+/EHIOHock/mUgKxyvCWMvtaXnM8XIjiZ7QwFhv7ZhbaxC
	1ckorBQ==
X-Google-Smtp-Source: AGHT+IENlNXX8pzS4mN1Rlk9fPPvUU0SJ5VNolNQHB8I0BgvZVbVv2j8MeGrJAO4XWE0hofnCFNC3w==
X-Received: by 2002:a17:907:10d7:b0:a5a:1b81:627d with SMTP id a640c23a62f3a-a5a2d5cb84amr872975666b.41.1715746494703;
        Tue, 14 May 2024 21:14:54 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a29d5f14bsm745648866b.213.2024.05.14.21.14.54
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 21:14:54 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59cc765c29so105035566b.3
        for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2024 21:14:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyahblKl9rClzFVWX8nkcGt6WIUt0RdDYDb9zBFJrkZ9kt9SI+EW8fiSxkXXo+krPoGF7D5dY4E+o4nBJcr0A9WoxH8uU7bihrT9T32qk8
X-Received: by 2002:a17:906:dac3:b0:a59:b6a8:4d74 with SMTP id
 a640c23a62f3a-a5a2d3bebeemr1157374666b.0.1715746493951; Tue, 14 May 2024
 21:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <871q646rea.fsf@meer.lwn.net> <ZkPXcT_JuQeZCAv0@casper.infradead.org>
 <56001.1715726927@cvs.openbsd.org> <20240514160150.3ed0fda8af5cbd2f17c625e6@linux-foundation.org>
 <92453.1715730450@cvs.openbsd.org> <20240515025811.GA1232@1wt.eu> <CAHk-=wiW4V5HRQ5Jm_MnSMVTeivS_4kdm1dnc08d03UKzmyp+A@mail.gmail.com>
In-Reply-To: <CAHk-=wiW4V5HRQ5Jm_MnSMVTeivS_4kdm1dnc08d03UKzmyp+A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 May 2024 21:14:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_GHCwCiC-ZR=idjNEb0xZq20=fQnQxnjGkiq-ba5DLg@mail.gmail.com>
Message-ID: <CAHk-=wh_GHCwCiC-ZR=idjNEb0xZq20=fQnQxnjGkiq-ba5DLg@mail.gmail.com>
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

On Tue, 14 May 2024 at 20:36, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Guys, if you let untrusted code execute random system calls, the whole
> "look, now unmap() acts oddly" IS THE LEAST OF YOUR ISSUES.

Side note: it doesn't even help to make things "atomic". munmap() acts
oddly whether it fals completely or whether it fails partially, and if
the user doesn't check the result, neither case is great.

If you want to have some "hardened mseal()", you make any attempt to
change a mseal'ed memory area be a fatal error. The whole "atomic or
not" is a complete red herring.

I'd certainly be ok with that. If the point of mseal is "you can't
change this mapping", then anybody who tries to change it is obviously
untrustworthy, and killing the whole thing sounds perfectly sane to
me.

Maybe that's a first valid use-case for the flags argument.

            Linus

