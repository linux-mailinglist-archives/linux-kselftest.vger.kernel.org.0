Return-Path: <linux-kselftest+bounces-4567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB7885391E
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 18:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C08F28CB31
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 17:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1230605BB;
	Tue, 13 Feb 2024 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TfaecKkZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6905060ECA
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Feb 2024 17:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846891; cv=none; b=TkPBzjC8Pnb2yZ0iuYw4YQdKPIabNtUxw53RE/4h6shtjhYlCx1pNTaokuJKz6hMesHW6P2BX9+RB8dtMVJH/qMbdE4yCDVcqzYaalnhFiExp5OhvP83RDt1rAQvCdmT/43BKEDsSbh6GeiiliFuzqPIsT2i99IlEwWSzjdvY/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846891; c=relaxed/simple;
	bh=ltk1jYeKwRUauD0F89EDsQOKWDQ5iIs7WuWPDIBxPEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyPSQnc0jpWlJ3iEvDXIKtC90p/Idr8wopZORSfOL9iqRhUcDYu22XtSBnl/8bG3YrnA2NIGrHcfqnWDzQMMldIDA0VUGiJNFz5oToZd2RMwpn9FOuaNOrOnbn230EYDG6QuovKka1nfYgf3A5VWj3BQHcivPbS0C8hBDg19uJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TfaecKkZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d7232dcb3eso34328985ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Feb 2024 09:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707846889; x=1708451689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LVxF0kPBBK4a5u/pCNXJRf9fK1X9kNc5Ul9aamHPDYM=;
        b=TfaecKkZ3hMdh2yYAEX0i24XSqQCMYgaKVXZaKRZXyedpr0PlXiCEUKBqMcc+IXM01
         7lFiGPHvFDEl21WmXk7KH2Z98kxoPDh88ekNLTinf2DxNN1cxTVSgvqJ5k/iTAZnixjr
         wv9B9hXXnRZcZqa08gv/7fFLEzyTR1pHzZOao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707846889; x=1708451689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVxF0kPBBK4a5u/pCNXJRf9fK1X9kNc5Ul9aamHPDYM=;
        b=Rev5yw8RB5QKgLqvQWEYEV7ZenAER+9dx6q6KkhQXfZHCA9n5kQGYne5QvT+XlsWzu
         0XJ4HS8oC/+PRD6w4WzYf3+usjg39oz0I0cN4ebWXpveGGIeOeeXM6df/vYjDQyuN8ts
         5/lIqO7P3QnwwY6s6tBWoISdNA5r9/enUP7+IoiucKA0vp6/Ycz0bA0eG80Ctjk8wWsu
         mSuk0sP9IxdsfSXQaMQSfjY6w5W71ZdS0bjR2aK/P3OVCcYHptyiyOTmfc8dh+MyeoSE
         wucIg1MUlaXO/E+ZG1D0sIND+t1L6NVcUlXKycXCymmcuuRtL0V80f7rQhBtLlS8W3xu
         9y9w==
X-Forwarded-Encrypted: i=1; AJvYcCVN0EUeTbmy89AP8V3i40T/uYCmU7ovW8lwobfNRF777cSVKWXDd3wEy2Be73o3/mooF6xNvENhbchinDjyFdhvJjjvPF7ZpQXBuYfJohbY
X-Gm-Message-State: AOJu0YyrRRU3C7i8b/bEniOhAC3+pVWxLzbGr/IF8o2yhgHNzttL3oIm
	YtJ+EWKv43J4njsVs+rJcIkOAWKi2Vw+FH+c4O8uL+Dnwh2c11B+c8HdRtv1MQ==
X-Google-Smtp-Source: AGHT+IHbSSe09lc2goe7Zz2nMO0NQD3yTUJSyzKOLScRX9ZNW7ki3TOsn4UQUDiuRXXoGz2jGzoH6Q==
X-Received: by 2002:a17:902:e5d1:b0:1da:2128:eb16 with SMTP id u17-20020a170902e5d100b001da2128eb16mr336068plf.3.1707846889662;
        Tue, 13 Feb 2024 09:54:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUEqoqd7vHyvsliRvzqnInF2fkakT543gYVgWUreedEgCy2opQ3LnqtU3XM231EKtLGAS4GjEBVHBBWKUpkkKeoB3ld9eAmLGFOoJ0H1w2EwNRZJJJU1akbWHCoeK1fWfu2jtJ75YPciLJis9A7dN+4YL6PcJ0fPfZiLx0zlg==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mp13-20020a170902fd0d00b001db3bffd1a8sm1371545plb.42.2024.02.13.09.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 09:54:49 -0800 (PST)
Date: Tue, 13 Feb 2024 09:54:48 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, jakub@cloudflare.com
Subject: Re: [PATCH net-next 1/4] selftests: kselftest_harness: pass step via
 shared memory
Message-ID: <202402130954.108CC0FD52@keescook>
References: <20240213154416.422739-1-kuba@kernel.org>
 <20240213154416.422739-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213154416.422739-2-kuba@kernel.org>

On Tue, Feb 13, 2024 at 07:44:13AM -0800, Jakub Kicinski wrote:
> Commit 0ef67a888375 ("selftests/harness: Report skip reason")
> added shared memory to communicate between harness and test.
> Use that instead of exit codes to send the failing step back
> to the harness. The exit codes are limited and because of
> the step passing we can't use the full range of KSFT_* exit
> codes.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Ah, very nice! Good idea.

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

