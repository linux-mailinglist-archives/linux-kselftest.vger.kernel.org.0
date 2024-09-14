Return-Path: <linux-kselftest+bounces-17979-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F29978F5B
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 11:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A6C1C20C95
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 09:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465751CCED0;
	Sat, 14 Sep 2024 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvNNYbnZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38D76EB4A;
	Sat, 14 Sep 2024 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726304920; cv=none; b=ueE8ju26LsnZ+2GFoU3n+dSuIaTv/eqDyRM51V9RMNDzW7PNk3etoORsnPpqTpzeeS1r6BAHn0v5hjFu5VVdNaxmn0lbAH2ci9KETRWDCqedUei3fjSe2ZgOIFWT/dCqWcejIcGDji9L/BTH0rbsonMIZcWKgjCBYiB1CxsgV1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726304920; c=relaxed/simple;
	bh=//XKPDwJkx7558uUbKSoPZwhWdJk6RG2bYnXSmqspMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ER+C9m4MRQpFp9tKysd4jIVYhA4AdjnTCgbw+lIndJvQlnsNTFQdmzPzhLd9vuW9FNtvPTNFY9RfUmn1Zewj9cjk4Ij2hHO+cid8zB4LMMetd11+F3Q2OWPfCrQMCpBVWo4JZqsjNCz2BbqffdqNmi3P1nN7aaE9takTOLjMlqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvNNYbnZ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8a7b1c2f2bso463789666b.0;
        Sat, 14 Sep 2024 02:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726304917; x=1726909717; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zHi4FPzinOFrHUEhjpR1lWqNuYcHEgDVupU8EZ5qZH0=;
        b=GvNNYbnZZobqBbUzMyjdnW0k95IOjryIbENGZhioP2AmmfbC1jOI5GkJNp+46x5h/F
         s0X1IxulSs4EPmbnLRQYMflzrt9h1hhhUI9u+TsyY5engNwihjhBgPQd85LP8fxvoo2D
         sjoz4FNZHnHiA1AtLOKzN/CbEqjqFPcyZdeFJzMsqhLscN/JML9TB+fG8FFvnJirosTt
         wLgPr3vo3urJRxIY1LpVpEj0pPHVKPQrSTY0BjNCXq5HhBzm/nuD4426SjTyrcqajr1k
         mx6aDAkc4fwWJGGOvOMBzR/KG0TDM94dIhvtDot2Aitin2Ebp4ARjoj8IDpXZTgk2OIZ
         X0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726304917; x=1726909717;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHi4FPzinOFrHUEhjpR1lWqNuYcHEgDVupU8EZ5qZH0=;
        b=I+JKwLDfyiNWTCc5QM07dbmfAewXgZ/Nzy6pORtg16gAg7Lo6KdUltH2DjXe21VxbQ
         lxMlhPehH50hCYWxL69758VvK/JpK641eRavJgGuAtj6Fq+R8NGiYkmIcBIdNl/b+Qck
         RPeI7daZlO9yCZDbvPqEkqtyZr1ip9n2/1Fd6rg/LyL4mLGVEpoJx246jDQtpiT7PbCP
         A154p0BZpuOqC9GAUcT0mGjN42t1A6qma4/RjZGFgNrUD04IVxkBwjMsW9rY5aS5aEiY
         XFf08V9xYp0hlfMJbX3yd/hhOa12PA9qr9elhDJKO15U3yLBcHPFdwNNu+7nKi6vBUdC
         VrVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCFZbVYyOOpB15AGlNFYT0baiHqs52sJ/pdCdE0m9YZbqiKgZVk7DP0fouB7ZyRVSWTnV6LeXh@vger.kernel.org, AJvYcCVL8MGKrjSTkLHH1cNnu83NLvxp8iKaqCSruDId6w95GYU6dB5UjEWUqQWIibNH5WH+9hNfa6fu3dEDH6c=@vger.kernel.org, AJvYcCVybEMtYv0djb9Zyi107EYTiTdV5bpJGIUK2/yxe9ITQRxBSxj3DO2vYaRfgjRqyQBxHBLwbRmwXIA8Qc/1xhSx@vger.kernel.org
X-Gm-Message-State: AOJu0YygLcc3VpTfPbp/P+qtYl+dMBhQq4rxHH4b16/5so3IsDNyL7bR
	STvooPzfeyv5h09gDkCvnkX9aC2XRE7XpY6rlugT8mWclcbliWqdTN40B171qGBBU2m17OrAAZo
	zM/i47i4TD/a3rQ8M7ivOeZbCEQ8=
X-Google-Smtp-Source: AGHT+IH9ntPY9TFBzaU2iJX3U3KxHgW4NYvBwYVsMlt/qjFhv6IDs3xYGOpRGBqK4bRMC0xEG+APFi3qpuV2Wsmvgco=
X-Received: by 2002:a17:906:f5a9:b0:a8c:d6a3:d049 with SMTP id
 a640c23a62f3a-a90294fea6cmr959797366b.19.1726304916391; Sat, 14 Sep 2024
 02:08:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b77ab871df2475df37aa29672c9bbcc33d03e90f.1726220359.git.jamie.bainbridge@gmail.com>
 <20240913075657.6062ad40@kernel.org>
In-Reply-To: <20240913075657.6062ad40@kernel.org>
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Date: Sat, 14 Sep 2024 19:08:24 +1000
Message-ID: <CAAvyFNhgWYH2fa6t1mi8VbQPRxLfTvteq9WBrkE7=UN-8VjDrQ@mail.gmail.com>
Subject: Re: [PATCH net] selftests: forwarding: Avoid false MDB delete/flush failures
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Sept 2024 at 00:56, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 13 Sep 2024 19:40:04 +1000 Jamie Bainbridge wrote:
> > Running this test on a small system produces different failures every
> > test checking deletions, and some flushes. From different test runs:
>
> This increases the runtime of the test 1m 25s -> 1m 35s sec which may
> be fine. But unfortunately it also makes it reliably fail with:
>
> # TEST: Flush tests                                                   [FAIL]
> # Managed to flush by destination VNI
>
> on x86 VMs.

Thanks, I see why that could be.

Will re-test and re-send.

