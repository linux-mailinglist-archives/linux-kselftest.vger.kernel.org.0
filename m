Return-Path: <linux-kselftest+bounces-7297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 539D889A14A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 17:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06BD61F2233E
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 15:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164F9171082;
	Fri,  5 Apr 2024 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lmXj/IMF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0B016F911
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Apr 2024 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331178; cv=none; b=cKRABUWdk7Rrmh4gC6vYvSCvAPxq5TB2F4W1l5HddsvSj+wvQBqWTQ4A/oHNRvFDOMqWszfDGflYXq9ZHiKts68u3LJ/RsSsw7wBJcJIFwl2jyryA9nOsFBtI9vLFtPLw9Rp5isyGrscRq7OiCR+uWaahqJGkfm7bkv8KA0HItY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331178; c=relaxed/simple;
	bh=yBWl+5MwWbl7Q1sVXG/qocl0ZSbSVgqv15hiru/Tetw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+Y5Bl2s2J40wN7ivqDVl793ls5qY2hvY4oAivvq3mB8bhkBHotF23wZDL64RqrvMC+7DzXJXEHuchX1tuoV2KAGymf8CUyKyFVJGXcDhBabMTUHTUaROKMmeZUoxgXXwfHXBdvEg6AgAUyIgTE71LxGwwjgFPdwamebKnNbAvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lmXj/IMF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e3c3aa8938so4833645ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Apr 2024 08:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712331176; x=1712935976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SS6FB8GMGclDd7kSPRtPPPk4CddaIuDN7vp4ZcGd1Sc=;
        b=lmXj/IMFkTaL/ok6mwOwz7KP6xzDoulFL/kqNXDjSo9aR248uHu46l6Dqwmja+31on
         MGgjq4aPg9TO7OZTo46QcG2wtEq/EeQZ0u+I34nNJ6FmkRKQv3qLtIPuhDsWTPrrszaZ
         aF9ZAVdzXdNK8MsTsg7fX41t4eUQQObRV0rOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712331176; x=1712935976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SS6FB8GMGclDd7kSPRtPPPk4CddaIuDN7vp4ZcGd1Sc=;
        b=vnw5zjSvYOKUFah7lAGlCHf9qlHmF8bNfCl1by3CzRUjQo+6pY4F6q1QO2HmXIuXFp
         NTzkGdLa00dkO7r3jAJrSKWfAhWNgEL4eV1seYxm5WmHhHolyEWuKb8p/cTXEskPlIa/
         C5xwc+eY8PpaRTMkUoAjlDBMZE66+Y47ns4qy9SOFXE41dqrLUpVnfwGg8/ZKX1Xq5sb
         HZ6PoF3ujIY4gKm7OeGS1/+rWwID+Dx+d7+SkOnvs1b0CKJ6fRLHbyS3uU347IRChH9V
         G/Jf8lFKRVShslNGVvApyob/DDrzVF2ci3DXMYuIzkhMZSU8ptGmQ7Fktc2iUliG+ESA
         vLkw==
X-Forwarded-Encrypted: i=1; AJvYcCU5MysDtE/Rp+iikKt4GNaTe4lNhjkzXbgsg2lcbRSTBGPeI9rqid73NfWkTOzvf4ipaWALx9ejHiGiPduk9iBajG/PsvngYPPrCJqSHihh
X-Gm-Message-State: AOJu0YxKnW4S9FMf77E5idZQVE9rxIwYqv8Jjm4gjNwdScyI8774+ohh
	FWc8B5y5tBuaC/1jzKPHuCwjpFy1stGr57ctDivoWegHLu5+bYsg9pzWAZMLwQ==
X-Google-Smtp-Source: AGHT+IFjfaWn4WDeCb/ACnVGExCKrHZllNuvtdBAbn2V0PYaZoLURGRgHj60A1D8IRxS1YdRgkOCsQ==
X-Received: by 2002:a17:902:ef51:b0:1dd:dde1:31dc with SMTP id e17-20020a170902ef5100b001dddde131dcmr2469998plx.26.1712331176080;
        Fri, 05 Apr 2024 08:32:56 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kl11-20020a170903074b00b001e223c7d8absm1722935plb.174.2024.04.05.08.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:32:55 -0700 (PDT)
Date: Fri, 5 Apr 2024 08:32:55 -0700
From: Kees Cook <keescook@chromium.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH 2/2] selftests: Remove Error/Failed prefix from
 ksft_exit_fail*() usages
Message-ID: <202404050832.EA0C9D5E@keescook>
References: <20240405131748.1582646-1-usama.anjum@collabora.com>
 <20240405131748.1582646-3-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405131748.1582646-3-usama.anjum@collabora.com>

On Fri, Apr 05, 2024 at 06:17:48PM +0500, Muhammad Usama Anjum wrote:
> Remove Error/Failed prefix from ksft_exit_fail*() usages as prefix is
> already present in the ksft_exit_fail*().
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

