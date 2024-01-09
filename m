Return-Path: <linux-kselftest+bounces-2766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AB9828E24
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 20:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5022D1C24B34
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 19:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E7E3D55C;
	Tue,  9 Jan 2024 19:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WmFMijfi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCBD3D554
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Jan 2024 19:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7bc332d3a8cso232440739f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jan 2024 11:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704829634; x=1705434434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jp3sPNgDn5/w+4+SQ1Qzo5FCSJIVAu5zu+xhNcaS+RE=;
        b=WmFMijfiyoN4iXHXnNTgp9SZ3FGgajoebCBzBn2+XT8eXw9KYXXP8u8n8RWp5u3U8S
         diK0rc0TIrU/3540+ag3pm3B4Vzkz0c6ZWHcpVKmtvKbWKCAdU+2fvc8beCJ+M5g07Aa
         ZutY43ahCZPDU7Wt/qgCxAGFrx9ACN6CryvJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704829634; x=1705434434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jp3sPNgDn5/w+4+SQ1Qzo5FCSJIVAu5zu+xhNcaS+RE=;
        b=X4IZ6WaUzkvnraLoT0+julhi8lJEkHfN7t1s4ZDww0PA0W9MSW9+XpqF+l8uUTeDlw
         +xMGF/3BOGwXNPb4hX5kdLWBfJdWEb26bt2BL2l3CsG2Aaby7g61plQzc3XA331pz42/
         xJXJf5VtE9fUzxz+4XlrQweHnipEeZ1DwK9ubwiCcLzWXq5ucdWqnomhq4GxfnvFq5Sr
         Ji4qMkCovcKEYPxmANO4Otj1McjaxJUFJ9ZY1ydU/D0gy8CjoigJHLiIpv8qml5LxmQY
         EtA2D/QelhPq6x7zMUkzRbZzPtLM8lfY191jFbUO9Q5qgsGTLjFj/rtVPvkAUVActI78
         5hPA==
X-Gm-Message-State: AOJu0YyPKv8G0QePK1TWJvNRXThnDolaVGVVCRSRJJilzkJUJem6xiUb
	OEApADYwkrv3s9ifhfjwKCgwrMDLXfag
X-Google-Smtp-Source: AGHT+IF2+p52+a/uGcKh/I7JeXkJJoDrdwxg8dNkuNsj9eVicHWq61t6V8lQJDA2Rjq6uoJanlNaeg==
X-Received: by 2002:a05:6e02:1989:b0:360:637:f64d with SMTP id g9-20020a056e02198900b003600637f64dmr9062346ilf.6.1704829634495;
        Tue, 09 Jan 2024 11:47:14 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n68-20020a632747000000b005cd8044c6fesm2019222pgn.23.2024.01.09.11.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 11:47:14 -0800 (PST)
Date: Tue, 9 Jan 2024 11:47:13 -0800
From: Kees Cook <keescook@chromium.org>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, jannh@google.com, sroettger@google.com,
	willy@infradead.org, gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org, usama.anjum@collabora.com,
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [RFC PATCH v5 0/4] Introduce mseal()
Message-ID: <202401091144.2C203AA7@keescook>
References: <20240109154547.1839886-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109154547.1839886-1-jeffxu@chromium.org>

On Tue, Jan 09, 2024 at 03:45:38PM +0000, jeffxu@chromium.org wrote:
> This patchset proposes a new mseal() syscall for the Linux kernel.

Thanks for continuing to work on this! Given Linus's general approval
on the v4, I think this series can also drop the "RFC" part -- this code
is looking to land. :)

Since we're in the merge window right now, it'll likely be a couple
weeks before akpm will consider putting this in -next. But given timing,
this means it'll have a long time to bake in -next, which is good.

-Kees

-- 
Kees Cook

