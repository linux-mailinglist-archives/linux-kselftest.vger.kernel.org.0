Return-Path: <linux-kselftest+bounces-12472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F9F912EB7
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 22:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7B41C20319
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 20:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B211917B42D;
	Fri, 21 Jun 2024 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="it5XP9qL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4BB16C6BE;
	Fri, 21 Jun 2024 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719002670; cv=none; b=EwJiK1v2FwvTxUQ5d/rlv7io72blRxC4fNWGrkWUaPaD0PbPHnQUwE4VJtizE4AM6GDhToCx1joUgeKj2IiDDCmQ/wAiWka2CZAgLX1eBjYV6jwnBn6lUN5QK6gjAl7eZJhi6NDlOvFX+N7PYpPuPa3awId/Q9YxfQbOuZmt9ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719002670; c=relaxed/simple;
	bh=oe2Oykyy7Nfn0/sNijkjrh+xIWVOKpgpi1uMblSeXLE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I6qQLmvfhoS/kib5XjJnpwM27wPYluO+Nw9LEc5uIf20xfF5aD+UKJNBA4qbnZix0hFJy3C+FZdFl1WanMGHurS+1zxTErp/4d7Zbm0URXtt5vxnHDqH+7+DPKIr1r8ZxUYBA4051lEsNUbSUlGwyZnFe75cIaj95pYNOTxNFoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=it5XP9qL; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7041053c0fdso1719693b3a.3;
        Fri, 21 Jun 2024 13:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719002668; x=1719607468; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oe2Oykyy7Nfn0/sNijkjrh+xIWVOKpgpi1uMblSeXLE=;
        b=it5XP9qLlE6i6NjlXjAjpedo2av2xyW5Ail2XnPhQ3AZxN5rDG+yh1FQ7Nr7SsXD4p
         umZ7Lkwu/CPBNi5TCQZW3sYdiPTzK/g62kUD0fkfyevUPSJiKPb8VTDbRKaVsCOGZAVh
         W8PJyE3WQiSlQD4PXzkv1R/nGIGgP6tbp9zv4Ipa32mE5DVmsYMsGYtRVFW0yjlDmLUR
         eCUUJoMQqv415GxwkBjFiDA0kwCErErVqBP9sDsTIpgYCG0mitqCmmigyVh7g1ZweGd+
         z5Kn/SGmC6uJ1sPUkPi1nlS0w1ag4YDiGnx5DkGvaZQkgDA9bBOI5q0JzI3Dkpk+WSRK
         dHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719002668; x=1719607468;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oe2Oykyy7Nfn0/sNijkjrh+xIWVOKpgpi1uMblSeXLE=;
        b=loX+Puk2I2xBK4DmtwaiHV8uTl8CN/8vSOdkeFUbbZbvJQUf+PrLlUTEd5NMvQbUXY
         Nwsl+Ldtl1s07jCS1stMnv08J9cNnoMFTeJMqrc1v00em0PI5PZ+Fo3b7LiGBSxO9BW1
         Wzo0g+JzqT2R8kxtvd2bhNHAZGFUctlczSKPbwPQ9RRpgaZeSDtmgziaft2KRCMY+8UM
         Znh3F2kW+zE8KPS0oSeEEBFuAHzdq0dRHP5HKxDaW8347UXK6A9Fk8gB3AepubJ2k/Py
         tGJka6cDI83l7cmm4wVCzLTnmSCZZ6BdmIfS1cjZXAHYgJ2xSOA48BV2gNKpVpBxEfI6
         sWsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOboGEsAPa18rkmcOyKwh6GDM+ACiGuPmvMGDqJvxsB3/J57l8zn48YeaYfFyA5kdVNcWDHeOhMw12yvTZLhHDmZFv2kMagPdnJNcRsXAEV6n1ONRvbkuj6Q0YMulffWWRBdZr
X-Gm-Message-State: AOJu0YyIXQSCwHLeiyoYUCjCsbd3+6GOHdt2aarx3h/JWMuNvnHNkZ1U
	4GPfSA9nyoNXExlLT/n0xcHjK9g78jPIOA4RxjM1nNEWdEJ30bUC
X-Google-Smtp-Source: AGHT+IH2eM1kH8xXIWgQh+JIfPo8ERDvcF1CZjjOdYxDiDMeKBj58kAlv0rGrHTjZO4ZRI3agN2Jfw==
X-Received: by 2002:a05:6a00:3b0d:b0:705:98e7:ce6b with SMTP id d2e1a72fcca58-70629c5cfc7mr9017181b3a.20.1719002668318;
        Fri, 21 Jun 2024 13:44:28 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716bb22dffesm1530538a12.83.2024.06.21.13.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 13:44:27 -0700 (PDT)
Message-ID: <ff9c2b617dc003b4c1f6a84c6283c51d85afbb62.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/6] selftests/bpf: Use connect_to_fd in
 sockmap_ktls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Fri, 21 Jun 2024 13:44:22 -0700
In-Reply-To: <86e6562a9bad3c44ce80c1c38ff27940f177651f.1718965270.git.tanggeliang@kylinos.cn>
References: <cover.1718965270.git.tanggeliang@kylinos.cn>
	 <86e6562a9bad3c44ce80c1c38ff27940f177651f.1718965270.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-21 at 18:35 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>=20
> Use public network helper connect_to_fd() instead of open-coding it in
> prog_tests/sockmap_ktls.c. This can avoid duplicate code.
>=20
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


