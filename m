Return-Path: <linux-kselftest+bounces-5856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F19B8870BE9
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 21:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9161C1F24517
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 20:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC957101FA;
	Mon,  4 Mar 2024 20:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WiB1WV2i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C60AF9C1
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Mar 2024 20:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585759; cv=none; b=IarNWSCjBYAcB+FjtSkH+66kM09moCJTvrH5ePSj5pozzd4ptSJRdnMHWQnbkNPUIbObnPkGOh0+sMkaCMiKljXfj4GaHDY/LY+nCjIGFlE7jlQf9krvFoB7cq/RBwssQ+WWtau6fJcdVUVk5LlCyLJL9/7RqQ+xG5t8trVG8eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585759; c=relaxed/simple;
	bh=Xlz2ZWcOWc8IDGysuXBIvluPifNHYRG/R4yvi08pKOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yr6Ak63+DRN9P3VGnLnuHsPPkkhRi9yA4EWAoFNRNt7AlrLPCNGY4vI4AKzYqWWWNlHBnKGOgcbV2uH06MVjT/BOFA/FEdLmvgXeriJyW7JPhJ70tX+jBNAJoKWWH1xGhpFdTnNsFqmcEsJ0Y54ykj6vjE58gU3GciO+8rn/HQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WiB1WV2i; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e59bbdd8c7so4081229b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Mar 2024 12:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709585757; x=1710190557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8VZP6eFRFm49p8drfTAJOKTfORAhladZw0uGB3+WSL8=;
        b=WiB1WV2i9C6GamF/xI8b46IAsf/wrYNJGrUHuHSazgVuj2hH6uJyLhb2yycmuutAdb
         8Cd4bopXxJbDprDmBqX01DRiNHhzQZ1OrKXoE5X1LVH4cJqZ2Wkk8dV+IgqA0WK7Fxl8
         Fsz4xt9nUxd85mhWv5Y11FH4BMuQfYbcQ2dtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709585757; x=1710190557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VZP6eFRFm49p8drfTAJOKTfORAhladZw0uGB3+WSL8=;
        b=nyAb8kl8xCSY8ZfhWoICugCBPaVUl90KSMZ5GyQaKCnISqpuCAFUNwEgSC4povWsQB
         8MHLNThW6XbwHJv76nMio/cXSl+fJrk5ziVQVXQCGXjlYk7Df1rdPkI2dWz4crLFSW+e
         oM9I2UsjUXQxZVBNpAg3Sr/ksh4RmMEGfl0NcJkpPCoQDfgCB4aNjF5/cn3oJ66bk8YX
         jNSP6YWtfOp/Weoh+tvTaWc4gIM//h/+JSPqmHss+J5OXG40yAvD4Jb3CE1TFVR9vi39
         1x31J4qiVsDob7NGF23jaK9PZQUmgEQ8/fZNHbx7fIP2MG7kucYERmB7auQ0pW8pc9w9
         tbqA==
X-Forwarded-Encrypted: i=1; AJvYcCWPanK4pTkf1JWCj10fbD0S1E0OjUEhddbHrqgPK4xH/SkrsgvYl8Qou6tIQtMWfx/4uavZ019MFaBa0w3j5B/0itaB+7hQnwqeSE1ivdFB
X-Gm-Message-State: AOJu0YykvoZOxwk2sC+oWoSmBCKtd++hXpycSsT7dD/87hWgI7TbIN0D
	wX4bb4PU1tQKVbf2OiiSuAL8ZGSbPXtgbiko3ooJ++DhC2pdoj8tlGpFukzBng==
X-Google-Smtp-Source: AGHT+IEk6XxeY4cdUe3b+NTvi17Gu57p9lo+D0aVZSXVbjaWNgo5OYjM6y6Rs9SMukETfLs4Bkx8yA==
X-Received: by 2002:a05:6a20:8424:b0:1a0:b05d:2d04 with SMTP id c36-20020a056a20842400b001a0b05d2d04mr12851206pzd.26.1709585757622;
        Mon, 04 Mar 2024 12:55:57 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e29-20020aa7981d000000b006e592a2d073sm7535861pfl.161.2024.03.04.12.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 12:55:57 -0800 (PST)
Date: Mon, 4 Mar 2024 12:55:56 -0800
From: Kees Cook <keescook@chromium.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
	kernel@collabora.com, kernel-janitors@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests/exec: Add the overall result line
 accourding to TAP
Message-ID: <202403041255.4964C19467@keescook>
References: <20240304155928.1818928-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304155928.1818928-1-usama.anjum@collabora.com>

On Mon, Mar 04, 2024 at 08:59:23PM +0500, Muhammad Usama Anjum wrote:
> The following line is missing from the test's execution. Add it to make
> it fully TAP conformant:
>   # Totals: pass:27 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Thanks, looks good.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

