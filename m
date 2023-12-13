Return-Path: <linux-kselftest+bounces-1771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFEA8106CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 01:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B9F1F2140B
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 00:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA17719C;
	Wed, 13 Dec 2023 00:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RS3q3rzJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229CE9F
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 16:39:52 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c0fc1cf3dso65195075e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 16:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702427990; x=1703032790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vbEQ0KJGdaL7UqnKRRl9MeOERVPcRtBuLGCRgVFRaFo=;
        b=RS3q3rzJCyhcnyzMr2m8Z4vXoplUUBN/ICrefzhXuaJp6FDaiOL/uTlKgewk5oEREv
         +4pQiXG+HKU9YWgngbBilth4FSldf+ONMNYie4PV7BVu0F2csyFrmIfhcHu5txYfhXp+
         NpxYk0WQbqCHHafh5YLSfjloQz0p07QlCh0Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702427990; x=1703032790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbEQ0KJGdaL7UqnKRRl9MeOERVPcRtBuLGCRgVFRaFo=;
        b=u8Qqt+6npM9UiliSq64tLpBGaKDT/ZqJPBqOpO2hVYELnlsyOwufZ316Rqo3crhPLe
         VeFj6tbtrSdh18uJsSCkv0r/NOI59Nw3lbLM6neT8zrcqxmjHZ4UbI8SsIvDjINM/PLl
         sWTsQnhYrisugqfbDsQZlN67hVnvZxLwHW6BYUsD5EstCwpaSxgBoMzSWT++HUoU+Y7P
         kXyupOnP9EzVAGBAweGL40SUDm+eAdRfFTdsQbCs6XZNL1Dq64Gi/6MldcSIiXGP0XTo
         +2pVyN/4zZhenRzEkHUH8TzYCs2lMIO2HSTPmvlCVDqmSgw6GxngAhfHTqS14s+LITY2
         RIYg==
X-Gm-Message-State: AOJu0Yy7Bg2DNKjajZBBZT+Eo/THQ+itSwskXra1MtF9rk5KSjYBL3PO
	scn9Kegb77xbjLR+3pAMBmOUm6CYhgZhuWa+BRQrOBTT
X-Google-Smtp-Source: AGHT+IGH6grOqDrrpvbXFpTlzlT69yNvxelOiJSG0EmdaqRkN4Qizh7yZ9rQviulfmjRk07U52IefA==
X-Received: by 2002:a05:600c:c3:b0:40c:591:59e1 with SMTP id u3-20020a05600c00c300b0040c059159e1mr3552530wmm.153.1702427990532;
        Tue, 12 Dec 2023 16:39:50 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id st6-20020a170907c08600b00a1ddf143020sm6922145ejc.54.2023.12.12.16.39.48
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 16:39:48 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a1d2f89ddabso761592966b.1
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 16:39:48 -0800 (PST)
X-Received: by 2002:a17:906:d8cd:b0:a19:a19b:78bb with SMTP id
 re13-20020a170906d8cd00b00a19a19b78bbmr3094683ejb.126.1702427988541; Tue, 12
 Dec 2023 16:39:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212231706.2680890-1-jeffxu@chromium.org> <20231212231706.2680890-12-jeffxu@chromium.org>
In-Reply-To: <20231212231706.2680890-12-jeffxu@chromium.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Dec 2023 16:39:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com>
Message-ID: <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 11/11] mseal:add documentation
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Dec 2023 at 15:17, <jeffxu@chromium.org> wrote:
> +
> +**types**: bit mask to specify the sealing types, they are:

I really want a real-life use-case for more than one bit of "don't modify".

IOW, when would you *ever* say "seal this area, but MADV_DONTNEED is ok"?

Or when would you *ever* say "seal this area, but mprotect()" is ok.

IOW, I want to know why we don't just do the BSD immutable thing, and
why we need this multi-level sealing thing.

               Linus

