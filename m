Return-Path: <linux-kselftest+bounces-28296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0D1A4F940
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 09:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEAD8189109C
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 08:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E421FDE05;
	Wed,  5 Mar 2025 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aRhsMa91"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A7B191F75
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741164941; cv=none; b=qV3156LE9csEFkzkMq4Y8pl80HWlBv+P4hbNeNeVEAOJ+R+UUewidSV+FYe8Xn0fQL3MGxSmTaVT8BdAh5Ia6bf9Oej1MEbEuwYiEL3jvr3eS1VK2kPM90BdZGIFkZ2xMfIi5RqfNERUKCNp6KG1+Z+Jjly+mUqbl7gNmTHqn4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741164941; c=relaxed/simple;
	bh=1tt5ib69iMzXY4LA74Vkmxm0BW7B+0tgn09acyb+eME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kP3xby5ZEt7Sz672LsKewGqqD3lPcj/elyl2nY6BTo6bU06sYEdkir7GLykL1BJZf2Njf6kjtApNa12QrT0gIprHxsjJYT1yvfz+H61GtbaOhHK7dgGemcif3cfDHZpB5Ccnrh90b4iqu92ZAGCrY+TA3r2oOFyIuRqPbbNiIXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aRhsMa91; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-390e3b3d3bcso7538501f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Mar 2025 00:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741164937; x=1741769737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YLtjA+wzwLnIjfOlPYyCZCKUn7sRpgky3D8g389O2dg=;
        b=aRhsMa91PlBsjSkESsdzsPB/p7pXyAa+5KY9l/zHgBVDWKTrapQjxvc/DQWDPNoWbg
         AjqfEOHPYGawTeZpMz8fVf+cDK4GtNh1uU7/HgDf2xWN1zNsct/DLfkdUR7HKIo3XiFq
         hGUZIHepalt61kV0M2+Sw5uojL/zN4jP5klFtcTkRDnC3O+V3MNdtviwa2uwx7kMRhsu
         hhjS6MqRbw6SZdUUsL+dxYBBh4SEBVYcpAS71G45h/5nwOozQ0hRsmix4EKi6cALSAiK
         Jxvn0N1q+6AABRpWMPRyToDFYhjmwSqrGYQ3XQcY1Deaq+WmgGNvTg1lgTFs9EM8xAFr
         DJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741164937; x=1741769737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLtjA+wzwLnIjfOlPYyCZCKUn7sRpgky3D8g389O2dg=;
        b=wQtKaYpov3Ryof0WyXJmgGIezVeOdI1mE/tZzVv18leI1Z//T+Ng7MaMUVRYmg5kYN
         dGFcL5tNM3rCElGVSZ/Vxfq4PLwdKIA7Jp14grE4gtlOFIRmDUOLd98YwKY/6H96uvhQ
         O8jLoCbigtlwahY2PWGkgEiztyP0U6RxqfN1pgVFFLlOLZIpepzWhgvHcSZnPP419joA
         wyWSELeHa0BNMrYoYmxB9N754G4lYCStw7IAqvRQrm9qGmezf8Jq7HswtOG82R0xdCRD
         U6hsKLxzM9W6B7g/VtLN64HTR69SaLaZ322+MAgpbM34TC5d8rKBjGEQTzc9DohR62aA
         SkRg==
X-Forwarded-Encrypted: i=1; AJvYcCXx9f2ub0rwI/qEuVYp+Ynt2hdRyOAQiymu6dda4OieHgBvsAQ9Bseww8nQVZp0esKfVwDu+DSE4wMF7xR0vnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG4kUVW5WNveTu9Xe+5o9Sn6NcSwvmesdmelOkI0yW0n+Omgff
	wylWzOtMSdTcZaMRAj6lJ5gGr6Acb2/1LD5ksynaPJ1HthDJ1Zo/VhXPsHy2SOQ=
X-Gm-Gg: ASbGncvFEaoZHPapKQRRAFjTX8gPDrSRPbh/Lv36CkOxoEspdlOyGc0b4KxrcZz5U8k
	QvXCNYU+y67MUCSSdB/RzxtrrTW6lSdwBNN6Kek08mOb7qvyEJaf+JM2df4iQFYt6yicJhPuKm0
	xaG8x/prRLerOoopHbpOlu/97JAzpSz70k3Ug14DbXNvAoLctdfz5Xg7yMcVpQQzLLvx8Wm0y9r
	Bb2SN0iOPLJz6lgqeYI63414i1v4np9lj924eMk49X2mvn9nDm9Poj6rRIXvmWg9Uw3VWx3aEA8
	NyKIMF30iYv21ZHy8tsFtM2Fz962WAHVd3ZPYih4FlUVzuk=
X-Google-Smtp-Source: AGHT+IEOjRqlCNucxZnWpFSu0mZSzPF3tEADkDKCagU2Hig2+iE7cTPN1i5PvOoBL6qL6HQEoP6zng==
X-Received: by 2002:a05:6000:186b:b0:390:e1e0:1300 with SMTP id ffacd0b85a97d-3911f75a93emr1731801f8f.33.1741164937517;
        Wed, 05 Mar 2025 00:55:37 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d17sm20007131f8f.28.2025.03.05.00.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 00:55:36 -0800 (PST)
Date: Wed, 5 Mar 2025 09:55:35 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 1/4] scanf: implicate test line in failure messages
Message-ID: <Z8gRh5wtzbpiV8JM@pathway.suse.cz>
References: <20250214-scanf-kunit-convert-v8-0-5ea50f95f83c@gmail.com>
 <20250214-scanf-kunit-convert-v8-1-5ea50f95f83c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-scanf-kunit-convert-v8-1-5ea50f95f83c@gmail.com>

On Fri 2025-02-14 11:19:58, Tamir Duberstein wrote:
> This improves the failure output by pointing to the failing line at the
> top level of the test.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

I like it. It helps a lot to locate the failing test.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

