Return-Path: <linux-kselftest+bounces-16916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD13E967D33
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 03:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886F1281892
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 01:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F9DDF71;
	Mon,  2 Sep 2024 01:07:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F4B1388;
	Mon,  2 Sep 2024 01:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725239232; cv=none; b=Tnk7J8QFZuV5VsIyfHRxaN9gcur4CTX+C0RNlaXelNJe/x/KeTWIGzp68bYuG+P9yA4ns5uRYPca/f72waGeDbDgUXxhh1svcRXJn0aJXphAJfV1y3qCQ6wZmeR7gx6QLk5BojQ50gD1Jf/sKwntEy8jUgUudLI+WzdtpRqPlj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725239232; c=relaxed/simple;
	bh=fXbjit2TjYQpe7jXfh1oBjIMIzlcrlm1aMC1OOUm+Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foc3t2qIkFO6Wn81LnFhXqIUA3P4nF8Mc40rKogor7+i5LybjM9zvavMLkeV1/JDfdaNbnGIADE3BQHio9tq6Sa6Deyiz/NHsq7QmOjtQHI8Y8yh3MKL/h3m2jh65rofJ0gZYBTj8LrwR4hjZMd16+KTRhZqRoaHZf3/PkiitAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-204d391f53bso24893505ad.2;
        Sun, 01 Sep 2024 18:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725239229; x=1725844029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3u2+qLetnJ68urYAzX26gltE44oP6De8D1CJbEpX6HU=;
        b=qGYFwWDOGf2rIPG/EVA86OBvp5Yi44Pwb/5uYszN7HwlmG7e+5Kv2xXp2QdRRBmALk
         7/olXsc+HRPkDLTF8uuzbkUZc493HW2/ReeMvu3PNbfLTZoLm9KRH2sg/UMZDZvxQ2RG
         /h1RMPM58FxkLWGnUfFmc84w2sfHQ5YWoeIdTPq6DjT2Fbda6D9zp1sCzAEfddICiftM
         bzgPgx7qoOXZPCeO8ziEIr02lvTS5NOSjQ/fznhottdNN2zokRfYaK81Nzz0MwTvV9dl
         6u/ZdI7/I5/+H1shTdp9gJwcwDcJK0TuPjWRSQ3g9dotXX1ujH0z48LBOP/wJKlXkdTr
         7N3g==
X-Forwarded-Encrypted: i=1; AJvYcCU2lOdoiRPMo9FEsLxoqZ4lnMLzrvMOWAfOAkwSW3/IdNkSH0aG2l+UAX93KJLJA9bHHY3OuEFJmvp7qRm6QXA=@vger.kernel.org, AJvYcCVcOFsWpDu49CVfffZ3MiCyvdh3buEbTU6Qqg8KRo1YvYgMNAmkFDd5xunZsWCpouCAmzBk3zQv@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy/oB7l7oNbNRn0LdJYWkujuuoSa6ICo7ipZk/X0r+mrwpQz3V
	CmOzTcN2eJFf2AVyLTAqo+5m3Z9X1aA+ZJD+wiw0Qtv1lyTw+Ng=
X-Google-Smtp-Source: AGHT+IHusLnqjEq1uBEMU1NLcj20Qq5xBgznO8lmV+K9CvBHSBk0lEyl9jQwi3w50AB4WtshFMQX+g==
X-Received: by 2002:a17:902:f54f:b0:202:48a6:c882 with SMTP id d9443c01a7336-20547642846mr50292275ad.52.1725239228898;
        Sun, 01 Sep 2024 18:07:08 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20563b7189csm13386165ad.178.2024.09.01.18.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 18:07:08 -0700 (PDT)
Date: Sun, 1 Sep 2024 18:07:07 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, jmaloy@redhat.com,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next] selftests: add selftest for UDP SO_PEEK_OFF
 support
Message-ID: <ZtUPu4OYHbitqYtn@mini-arch>
References: <20240901051821.94956-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240901051821.94956-1-kerneljasonxing@gmail.com>

On 09/01, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Add the SO_PEEK_OFF selftest for UDP. In this patch, I mainly do
> three things:
> 1. rename tcp_so_peek_off.c
> 2. adjust for UDP protocol
> 3. add selftests into it
> 
> Suggested-by: Jon Maloy <jmaloy@redhat.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> Link: https://lore.kernel.org/all/9f4dd14d-fbe3-4c61-b04c-f0e6b8096d7b@redhat.com/
> ---
>  tools/testing/selftests/net/Makefile          |  2 +-
>  .../{tcp_so_peek_off.c => sk_so_peek_off.c}   | 91 +++++++++++--------
>  2 files changed, 56 insertions(+), 37 deletions(-)
>  rename tools/testing/selftests/net/{tcp_so_peek_off.c => sk_so_peek_off.c} (58%)
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 1179e3261bef..d5029f978aa9 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -80,7 +80,7 @@ TEST_PROGS += io_uring_zerocopy_tx.sh
>  TEST_GEN_FILES += bind_bhash
>  TEST_GEN_PROGS += sk_bind_sendto_listen
>  TEST_GEN_PROGS += sk_connect_zero_addr
> -TEST_GEN_PROGS += tcp_so_peek_off
> +TEST_GEN_PROGS += sk_so_peek_off

Should we also add sk_so_peek_off to gitignore?

