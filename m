Return-Path: <linux-kselftest+bounces-39878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 162A7B34AB0
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 20:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212D61A87E3B
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 18:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A73127D77B;
	Mon, 25 Aug 2025 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5Ay2/CP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51B827A917
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756148190; cv=none; b=oR5YquBhEpCQIhw6C2OoE93gm6vjQ/0CFGoGJ2hmPThzT3+dL3tQ/QE+6ck33OLkF5XptZ2oNy8S9fBnuVqI5hJaNm3jipBhCnecdRvqNd46gjHsexwgY6d7O/WvxlXC/W+QskFEs0r+4VWlrorvz+6qooV/HMAZaHA9lXZE1Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756148190; c=relaxed/simple;
	bh=qgfuK9T6WO6oYvtAnz3WL3d2abHReRj3j9jMW3ZuF4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPbKuKscmD82r2ET3m6UtHDETnKvvgU0ViA5FwZ9LvD5H35yETu+1kh2cmJ87AzHJ0LaGKAo52om0abxAMPp56WSUTJWZCpPckSRAUXlcIMheJ2K9+EMzlOn23/Jv2tOnoTcR6KNIjIloYofkibaaMT/mMjnLfafEMg3v9a6etE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5Ay2/CP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2445824dc27so45665775ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 11:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756148188; x=1756752988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SzWvzuyxc8U4uvXldf0h89Ad3AGqK7qQxNBiVSgzwvI=;
        b=F5Ay2/CPwRtAwx4HbTPqAwmZf9mvw6q6X/5laTNypuoEJDuMBeX9LJyzBUQOFyv7O9
         0pnYHRJAf+eERWfwV8vHtbZwx5AL/iyr0orLJ5xPKFg7E8aYKuBpqLCssPcxZ1QGYW02
         6hQ4a2LyZ9QczBHdvKO1ycAJWaSlD5NgfYWrBmQB411yHYg7/vb/yf75SY4KrdvoaACz
         IwHfM8eCYijQCizpsr/6hb/g4TPm2WLqkWhE6CBNrWKB3KUSGgzAyKAvkmr5DXovAXqK
         A94E9OkR+z6q1yBex7IRdUstMk/HpUc5qEO1h4V4LrhKyMfhhspLRR+Hvm3eo4oMqhgt
         Wd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756148188; x=1756752988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzWvzuyxc8U4uvXldf0h89Ad3AGqK7qQxNBiVSgzwvI=;
        b=K4j1miXayY4EYim6AEkwl0qgYdxTRQQ7+Avr4T02FbWsDShOk58oPFmWLUBFqzBuc0
         27/zJPcQekEYLH1YfUWuSH7YF+4YLyjusxSFtPI6pl/aaFgDs2rnuNQWxlqchLB3uicu
         h0XB9v95aSFKXE0Y5MIJ18wbWYhvRjXGjEv6OqTCf5w9KUlhASf731vj+GTv+jGR/w1Y
         mKiD6oqm9b2Ez2N2FsluImP+PpqO8wbdUXkW0aS5S6CWU8PwwHUaQTB3JTssedE8ePlO
         i2kbVBW3PBqfM4omTUvom1GEGoxBXbINeuDnvPthENJ6WgA8wI28PayeWyUDWd7C16MJ
         vjAw==
X-Forwarded-Encrypted: i=1; AJvYcCWapJ4CBK/1Eghp090ufnMZs1sE89yp8P5ZmaebPSEnVz7G+jm4oFR/Tlzyk6zzC7MUwYc2UOQc7U+OYEPNQCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGteuRPlrJK3sPam3jOGwxhH8u6dxfqRWYzGSP3zRMGeYM/z1J
	pLUoTlSvgcZG9HKWtfciuaGZEIuhh1qPtaYhvnpj6wCKQ8VTGHGC5bxm
X-Gm-Gg: ASbGnctSPLZG6aDUIvhxbA/lI18NpPLjhp2H3d1qT+roOQxNojwCcyK90KJg0e69H1N
	wDGW7hBtW4ZICqFJ3qK1lI0kvPr3RP7WRM2zvh/P9TW72rj/VMLQxRaaKEXavTFeq9ADfdtAi7C
	YsY457be4u4txwUv39olwu8kejZ2n6qJYfUzd0huF/4ZLCUGWNOOWMIU7nrisy7k0bYa1LvQObg
	uHe90GgMbCZnpU1S8+g041xF+oZ6b1lmQ8O+XXg7ONWqpTi2n7/fn7Ytq8j+9p2T20oPg65L46Y
	69SI/j3rXntKosR/i5B2wOsIfWAQkXIEmfMkECWPdTqw2ziezLcwX226ha38D7Wj0i9P5lCuuuf
	HYR3b/4Y2gU2ZlgPE9oskg4ShjugsfDbn34Gq4lnCmPnBKTDeqxGb9g==
X-Google-Smtp-Source: AGHT+IEG4OBcUIgVaGYScnERea4gd27KbGi+YUxvReSc5dl9I62mBwZkPUyvO27QZ1ezponnV7Zs7g==
X-Received: by 2002:a17:902:ef0f:b0:244:214f:13b7 with SMTP id d9443c01a7336-2462efb04c7mr176883845ad.53.1756148188033;
        Mon, 25 Aug 2025 11:56:28 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466877a01fsm75637175ad.16.2025.08.25.11.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 11:56:27 -0700 (PDT)
Date: Mon, 25 Aug 2025 11:56:24 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: shuah@kernel.org, akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] selftests/mm: use calloc instead of malloc in
 pagemap_ioctl.c
Message-ID: <aKyx2IKTLpaxjZnV@fedora>
References: <20250825170643.63174-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825170643.63174-1-viswanathiyyappan@gmail.com>

On Mon, Aug 25, 2025 at 10:36:43PM +0530, I Viswanath wrote:
> As per Documentation/process/deprecated.rst, dynamic size calculations
> should not be performed in memory allocator arguments due to possible
> overflows.
> 
> Replaced malloc with calloc to avoid open-ended arithmetic
> and prevent possible overflows.
> 
> Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
> ---

LGTM.

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

