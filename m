Return-Path: <linux-kselftest+bounces-19907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9739A1772
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 03:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C12E282CA8
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 01:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76149111AD;
	Thu, 17 Oct 2024 01:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DagClQuC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163EC14287;
	Thu, 17 Oct 2024 01:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729127073; cv=none; b=Y/8SuI/i4Iy/d4gFws8ji2TkqSjmviBRryA+QSsY/uUCvCIRhxlHffmf+qgvPnwk6OGJCbQb4uNFic0MeDC/+5tLked8KNSKuZ8XTtdXcdpUp/kwwq1KvyIhk3olpobCIXKOuDyFW0+wwcCmHB54+cuu4qCHFpX2Ow8MUblQd3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729127073; c=relaxed/simple;
	bh=TbLQf7CSlSZzGt+kzv8SANOQQcKWIB1TQsVyrZtb6Ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xh78HXl+FRF6rOoPV4jG+DIZDC9LlrtvfAXQMMZ5O4BSf0cuI3wvzXmm/GEyAUbPYlwmlFKke6ZbqVhBqVEX/4rElmGlRr02CacZc331gpDVNRj3KhPNFmpMyH3TgFjme4d4+4mU43a4ay4BwnEKG4R0RRfCoT58hN+fnv0Wtsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DagClQuC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c7edf2872so12215565ad.1;
        Wed, 16 Oct 2024 18:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729127071; x=1729731871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mw9X4Cnv9XyDq5Ozk5VQUjC9kvC7gYUadRA/A1iUmsY=;
        b=DagClQuCGn5VT+Qo7Fd2ddap7JyUqyZA1XuDIbITMByxyvAEX2VOo2z/nQpEkjpbs7
         Y20SoCMEH/LlYJ5wJQDwWe+TGbOleiKt+hqQYtNWQtIXt0EqSyveFZx/2IjyBrHGtx+U
         5fws7FrRjH0ex3qSpeTgLwb9BAkR1+Ei3+hl0bQ5oSQ3rlAgQZBidRcNTOIF3RuASxRe
         wrmxDLc/X3KxMzYikWvwu/35g7GbdkjM8UTyyEBea3ku1bNRk7IZaZ7QfF/Sys4iK8OU
         ivzOkFkZwc0+1PWRVJX9tVX13zzc8eT7nHITtphUL9SEamo/JjvJy2bnsHVO3jRiUuhm
         p8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729127071; x=1729731871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mw9X4Cnv9XyDq5Ozk5VQUjC9kvC7gYUadRA/A1iUmsY=;
        b=L6IDXKLgDORmz4PQI4qRCcpmRFR6LkHf7dyrj/jeomLERnFlcUC8XM188Baoj1H9Tm
         4HKCw+CXOOIkuCvNeJ3kXC8PqF2iPzq5DjORn4s00mp3rHdypYbaj/n0EWP3d3fZPo/J
         /10CUKRLCoxcfXIJ+erNxdRboHVfw3nT5DbXEQhAU+4c/RrM+i9yMToMgqtmtR5iVM3R
         3ViYnq73DIFBqE5dxO8soyobo+XzDpkxavuSa4N7X0KqrvnSIRE0enbyPtSr8gpambuE
         jlWCK9aBUykLXsbrcAGDm/QU35oXmWMEsqIbp6hV0Xedc2oGcJE1+AWViLjLhbDMntH8
         qsCA==
X-Forwarded-Encrypted: i=1; AJvYcCU991uiF3/A0lDNk/NMWGXRdF4vTJQOowSuKWyAbcCZPBjp9dbQ4lfptBRGu3cHrI25H/3y+s1UHhlB3kM1LERR@vger.kernel.org, AJvYcCUDISfa7C+E68ii2wkjyO9ERXRK6bpYTBNj/Hy+Yy1fDaQNOvyNtL10BmolfMxFNRSxF41F3X7c@vger.kernel.org, AJvYcCVnrtDv1ASUZXUsYX05HkOj/HbKxVHvAaMsyrmt5x/GTtRKYUcP2ERr96uK1xd22jL3giOv60T4LJA/4MM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1h/7mb1cqeDFDKxD6aIbRjDDT8lYF6YSPzSEybIG8X0Hu502U
	/RKwRlM1hZeN7bUTr+AowZoddC4gfO3gOWQv85NL+nC5ngZgWUxeLl70wLFU32ft+Hh7fhB7Xsg
	R5QdcRokV5DvXQyyhD3qYdYLJj60=
X-Google-Smtp-Source: AGHT+IFgXKpvr5EG6U69UyMZTkscTSL9KQXC9nJe2KZ3Jbc8IbNcSYnzF3O+/v4sRRazW4ZONf+6MCWrtYbIXSrq8pI=
X-Received: by 2002:a17:90b:305:b0:2c9:6abd:ca64 with SMTP id
 98e67ed59e1d1-2e3dc27805emr2220713a91.9.1729127071320; Wed, 16 Oct 2024
 18:04:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016055823.21299-1-leocstone@gmail.com>
In-Reply-To: <20241016055823.21299-1-leocstone@gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Thu, 17 Oct 2024 02:04:19 +0100
Message-ID: <CAJwJo6awAk0tG7RmorUBCTdnHx48Kdmztr=q_AgfhzBKox-zwA@mail.gmail.com>
Subject: Re: [PATCH v2] selftest/tcp-ao: Add filter tests
To: Leo Stone <leocstone@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, shuah@kernel.org, rdunlap@infradead.org, 
	mnassiri@ciena.com, jiapeng.chong@linux.alibaba.com, colin.i.king@gmail.com, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Oct 2024 at 06:59, Leo Stone <leocstone@gmail.com> wrote:
>
> Add tests that check if getsockopt(TCP_AO_GET_KEYS) returns the right
> keys when using different filters.
>
> Sample output:
>
> > # ok 114 filter keys: by sndid, rcvid, address
> > # ok 115 filter keys: by is_current
> > # ok 116 filter keys: by is_rnext
> > # ok 117 filter keys: by sndid, rcvid
> > # ok 118 filter keys: correct nkeys when in.nkeys < matched_keys
>
> Signed-off-by: Leo Stone <leocstone@gmail.com>

LGTM, thank you!

Acked-by: Dmitry Safonov <0x7f454c46@gmail.com>

> ---
> Changes in v2:
> - Changed 2 unnecessary test_error calls to test_fail
> - Added another test to make sure getsockopt returns the right nkeys
>   value when the input nkeys is smaller than the number of matching keys
> - Removed the TODO that this patch addresses
>
> Thank you for your feedback.
[..]

Thanks,
             Dmitry

