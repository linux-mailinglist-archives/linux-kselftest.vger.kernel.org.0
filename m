Return-Path: <linux-kselftest+bounces-14129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C08E93AB54
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 04:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2AD2852E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 02:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5926817C68;
	Wed, 24 Jul 2024 02:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hl5Wr2Q9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9589F4FB;
	Wed, 24 Jul 2024 02:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721789031; cv=none; b=MxDQxgK9Kcwaid0dLLq+d2kUkqSkpY/ntBidVZ/CYju9pzWvG746MHHcluIyUgtO5+80Id8ICQZSJKRQgIIbpkRDmWrB4DKtDmmB5JFoitKj9yCHiyuP1pq5LVQkGHM84XiTd7bZdWbYWK2sJLC0lyEDuRnU5jcLxGL6T+9DPYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721789031; c=relaxed/simple;
	bh=qyJzyZchd7YUsRNJ9k+THpo3Jk3meNlv29tj+7Riu0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGfUSmwNfXNTjP2/EQZSGJANfSlATKk3rwayaaO/StjMsVwHj5WAfjU0QiF185DKXKUEYiAcwviHe2Bz4SDoVdHHXpNeiqTAfMZJrkwgdcaC0t4XfgWP/fxgCjcWlaalF6IuCEDdicLJyn+4n3uz2EwXCs89pTQxjiLz1yfh1u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hl5Wr2Q9; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-368440b073bso235393f8f.0;
        Tue, 23 Jul 2024 19:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721789028; x=1722393828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyJzyZchd7YUsRNJ9k+THpo3Jk3meNlv29tj+7Riu0g=;
        b=hl5Wr2Q9sammnyPvvwuVX0RIfDnNkEbneSyb1r4uGO/n/oqQdLDVccfrc0fCR1Kj3J
         VO21xh7BPTNerAtcQn89R2Mk7kHkKLyrdBDR0t4kjAU6IKIuDV/TOQnNpZiqdklt1Jga
         3HVywzVus9Vq8ZNuPSi1FDJVYdA4K4wecN/2yJFC5Sue/MDozsYUw972Dc5rYy3aHSg6
         Y0BwBKejaW+yBmzd8+L/e1X0/A5IoDTX42hWgxDMPPvFoBOUbhkP3ZUGav6q+ZelBTJy
         SFa44LdOZLO55rOFEfVlaE65BOkYrjjpmJCRvOTAdJQeeBwTofVzfuh5W5AVUD9DG37T
         5M9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721789028; x=1722393828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyJzyZchd7YUsRNJ9k+THpo3Jk3meNlv29tj+7Riu0g=;
        b=AAQovlC0Ydm9yisaJix6WA9+G1GAXcNaVTAlspuhzip2gmeO/AFXTk7rC6wuxp9YlY
         tiBQjkDcDBx6lJ2OTqmmqntPxsVlDtD6eOWnsPaFxioD4XN+ROiGZb6GBCWm5iEyf1Zw
         YgWoBCJ2evgV3gOwIIK5ZOwbjCR5JnsByJbc4RSb5JJj4tPmTB0TQnx6yaEy0fA3Z694
         UGuEGgylcJ8Xhu2me5nCggkwfu4pBwY+2ZRYTkWVxjX4UnDmLeTU0Fvg/YUX5rcGSiGb
         4LtAXq54jDYpHCNhGU/fHNVj8WmWNBKL1TK5qqjGeMHozvd1d/O8CiNRv0JfU0ImBiYk
         6Csw==
X-Forwarded-Encrypted: i=1; AJvYcCU/YdxZHcFRlHrRI2DBqfkGTOwOspfNKDcRatVeoyPXeI/IFQkpJZgcT+B1IN/O3Wi4U0MrEpu35ytiiDN5vsvRsYC9oqRNgm5KuNfL3+LvcXsngUwtWnU7YWH50IjBl5JTUBNb
X-Gm-Message-State: AOJu0YwoORAcowPT+nqL9M2rTWpjMh1jh5t0oK9kHBYFnqnYp4vny1+w
	UB0H/SBYgknlZrTDNSlPqB8vIrLnFH+3IHuczOtaYC6L/RXkxrykKikzdtcpjFaGZyY99tKADEo
	annCboKZlYCGeHGH7AstbqrJyRQg=
X-Google-Smtp-Source: AGHT+IHSwVaZost4SGW+Dk2AWvzI7Fq07xQgH7CuZQn2KpGVvfoGKALlpNNvhP3sHwRQb9sTE5dnuT0W3dZHpHxKG4U=
X-Received: by 2002:adf:e401:0:b0:367:89ae:c204 with SMTP id
 ffacd0b85a97d-369f66b780bmr229433f8f.12.1721789027787; Tue, 23 Jul 2024
 19:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721771340.git.tanggeliang@kylinos.cn> <CAADnVQKHHy92a62vRue44asXqw=OoWwyzg0_g0sbgaK+xbP6Xg@mail.gmail.com>
 <4b1aace7d5dcc0dbc348df568f12d6aba1fa9ddb.camel@kernel.org>
In-Reply-To: <4b1aace7d5dcc0dbc348df568f12d6aba1fa9ddb.camel@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Jul 2024 19:43:36 -0700
Message-ID: <CAADnVQ+22+nWeVK0no2xgX0mmY7eFnZrfW6xFv+6oqKx-e83sw@mail.gmail.com>
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

On Tue, Jul 23, 2024 at 7:07=E2=80=AFPM Geliang Tang <geliang@kernel.org> w=
rote:
>
> Hi Alexei,
>
> On Tue, 2024-07-23 at 17:04 -0700, Alexei Starovoitov wrote:
> > I strongly suggest you invest just as much time
> > in reviewing other people's patches as sending yours
> > or they will all be automatically rejected.
>
> Thanks for your reminder. I didn't know that our community has such a
> rule. I will try to reduce the number of iterations of my patches and
> the number of my emails sent to our community.

Every patch submission has a cost. A reviewer and/or maintainer
has to process it. You're sending way more than average,
hence depleting the time reviewer/maintainers can spend on other
submissions. This is not ok.

> I am very willing to review other people's patches, but I am only
> familiar with "BPF [SELFTESTS]" module. If possible, I would like to
> add myself (Geliang Tang <geliang@kernel.org>) as a reviewer of this
> module in MAINTAINERS so that I can receive emails of new patches for
> reviewing. Or please add this for me.

That's not how it works. Anyone can subscribe to bpf@vger and
start reviewing patches.
After some time when developers and maintainers see that
a person commenting on the patches actually adding value
then they will get recognized with R: or M: in the MAINTAINERS file.

