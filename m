Return-Path: <linux-kselftest+bounces-14123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 387A893AA19
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 02:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10CE1F220BA
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 00:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE3B10F4;
	Wed, 24 Jul 2024 00:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfQxfIlo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABABF819;
	Wed, 24 Jul 2024 00:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721779487; cv=none; b=qkgjXUSY3fg0z/U7f0KCxd5sTqFqd65c1dYNDcSrRif2COBcTXcghBt87R+qYVwsBmEk17uazyeUmhicwe9wGBwBphZfSc5qL6C0GCKqUPjfR3DsWhVbuSK6boS30TpkcKrkejkUnUcxzaEpEERMCfwnaWS/C1GjKUZaE6jjD4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721779487; c=relaxed/simple;
	bh=v6ilo0WIPTlp/UI4aV9SdTlhPgySGNgRL8cdM6coDtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gh2BvC77Ov7d7NfUlVg0R3/uyRGqakhTW8FfTNFQEkr2rwBmej4L3xKmirimp8hi+XDeb/Jm1IQVJBnB6xZewN93wmEwI8wDNT2F+a0FC8Mh6DT37eBSA/J1UvlCyIjxCuwa2FpLhVMkKc3qsYt9pd6GADyNtdZ/rAYbbA60anM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfQxfIlo; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3683f56b9bdso3263593f8f.1;
        Tue, 23 Jul 2024 17:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721779484; x=1722384284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6ilo0WIPTlp/UI4aV9SdTlhPgySGNgRL8cdM6coDtY=;
        b=gfQxfIlo5FTVmMsPk2hhEpAV8hmwDE7EOjBwuD53aRqAJI77qMkKmUjtRL5V9hVKz6
         ce1+vIPXg+Yy9fl/vU1OPpqA/jPnoJQS4e+xodo2SpnHWkIyBKuxTHZLQQlcG6chQ/Rj
         tvtOJuimQdzBoAXvxoe+RT9tP99KQXnHYYFxAqn+wa6npZfKpOF1/wenJTz12rBB0l0Q
         kRqe2Sd82WUQVGdxZUXegD3036RxZ8qphflDY6kR9jRAq+U2xiNAxAcbvFNYqTEuqtS7
         WD+6rBvkdt4vPzLl4bhue17kAVQOzALV0pZX/AYyTBmt79QHz10bg/HxVPW2f/8KLqyd
         PGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721779484; x=1722384284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6ilo0WIPTlp/UI4aV9SdTlhPgySGNgRL8cdM6coDtY=;
        b=izScZxcXn1vjCpcPqJuQ15sJlc/gX0f2E6oelRrgIJxVLJhl9PITE2D4biEskcZL+c
         32xAMqUQyePQ57HMMJ2H74vbaqot3oJeOspDvuEpd/22crpqfT6s5/48PHVTjcY73BF5
         fW+H52H0o/HsXTIxvvFUNC7WYOGCyCKeDgwvtVcPPdQ+lFl3OpEcE4GFUEJMVpfxdDDT
         DjMs+FcQIbz9aRUVBXevn4hBtr2MdRFgJF6F4fEkkgF4Fcz4uG67hhNVlRu+8fxK3OQ4
         7H//Ou+fu/8mKwMb6Rm8M0wpYf1jIjz4vXHuIA6UjTur+/y/KOG1lW2mWKkBXi5eb4Yl
         WvaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFmsvOG0cNY5nXzoJIdTjTLcxfzVLdw3XrmNz+pN80qvuBsknpcsbOS+N8676GnPOvbOxvo3nwflmmqG0Qgi3T/rK/7hHqvpmAzbg+sn1/djBZ4ZQ8g2yUjzqu8K6tyltBxYNw
X-Gm-Message-State: AOJu0YwFjqNhMEF4mvGqrpjrlkp4zYK33vITq4xNX8gV6oUHf22gmDkM
	jKXvRyPBbVt1RQoOSXDtw02x1J52n7GLmnxe6RbaN3VkocTVOQ9+h9ewImnlmacqmJhaVj0O70Z
	CfuXcb3PtzIub81SnijDfS3G71fU=
X-Google-Smtp-Source: AGHT+IFV/S+UxTfgYY4NRkRUi/MRClYeQFis4r/6/xWaffVmdP1CwGwHpEyxokjgeNjww+gRfQ9AZvH7E8hU+bAd7EI=
X-Received: by 2002:a5d:5982:0:b0:366:f041:935d with SMTP id
 ffacd0b85a97d-369f5bb4fcamr274173f8f.60.1721779483734; Tue, 23 Jul 2024
 17:04:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721771340.git.tanggeliang@kylinos.cn>
In-Reply-To: <cover.1721771340.git.tanggeliang@kylinos.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Jul 2024 17:04:32 -0700
Message-ID: <CAADnVQKHHy92a62vRue44asXqw=OoWwyzg0_g0sbgaK+xbP6Xg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/15] use network helpers, part 11
To: Geliang Tang <geliang@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 3:22=E2=80=AFPM Geliang Tang <geliang@kernel.org> w=
rote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> This set is part 11 of series "use network helpers" all BPF selftests
> wide.
>
> Finally something new in this set.

Geliang,

See "Top scores (negative):"
https://lore.kernel.org/bpf/ZqANgbFHX128IZYV@mini-arch/
you're the top spammer on this list.

I strongly suggest you invest just as much time
in reviewing other people's patches as sending yours
or they will all be automatically rejected.

