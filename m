Return-Path: <linux-kselftest+bounces-36124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0662AEE67C
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 20:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A954D1BC1037
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 18:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5345A29ACDE;
	Mon, 30 Jun 2025 18:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wTywiyiJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9DE13774D
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Jun 2025 18:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306883; cv=none; b=dgZg1xZ58EileZJc78QYeX+PY9SuujOG7IYUmsMOg3PL/xx3Fe0QSsoqhMpCqvJIaWxz7hDliFE2nVX+Zw4FAw5jy4APonzBLOmV9tWS9gq4VntJ8K2yAMYUKS94By3H3a6QGSPU4sdPto9HiJHc9sFYbbIx4RfyxMsR8ZcDwCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306883; c=relaxed/simple;
	bh=qVtw/kDHiHkFv04qJA7qjJFyOqXjhJ6l7YGufGNTzVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7ccR0wIQ8wj5ZAkh8/+LaRN7IphJD66aoRcMW74s2Be3no5RmGYfsD4c0f7oBzOLHVPoSUN7yW9IMrSY8H3RHemRqGVVMhrq7PUL5OJiAprt2GcT6fnIJKn8SLVerMZSFiXTLgiV2txfxW/CAB50++AxukM5tNAvSxtxn0oMc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wTywiyiJ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a8244e8860so8153391cf.2
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jun 2025 11:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751306880; x=1751911680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVtw/kDHiHkFv04qJA7qjJFyOqXjhJ6l7YGufGNTzVw=;
        b=wTywiyiJTEQQWAGpzdokmoDHfCci+ZxQceChVI+X0uOVJSPwzBn8G1j/BNXcFrTSth
         qBmWC91AiyJUH4ot9tdnBRY3jIMY7IEDqrrFcQG9zHxQbhIQtTVajtn2owJ1zPu66ahH
         0InHGQadRvF2ae29Do3zSMeyFE0+FkfiXtU9S4jNKIu2jdXjo3Pu/A6iKv2dxUPhFukp
         SQXlAeFGFuVGzki8CZZlQa6WNBBuIiAKXuPoe7dlcPHQHfDSmI84wN7mLOYQgT6gMKMD
         e1L3Efx5i8VEFay3c4dmWZIjjzL7nhA9V10JWVZvm8+ovlX4Ea8VxvXKp1so6bRWJpbU
         xBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751306880; x=1751911680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVtw/kDHiHkFv04qJA7qjJFyOqXjhJ6l7YGufGNTzVw=;
        b=aKDRV2X0QgiELH3e/nlqYIkW5zQF1PeOwkYvp+aruECLxx1+o2ikf+Ukc/EGXWcCOd
         YT0QuSc5WceOnhEA+1hQHnH/D6ZRzaPxFPNdJeZj7NdMt8JrCjjmIt7tZviUqmPzP8Cw
         hxJcmgHUfWMRiWC4bbP9dH3/OFkScb/DgeCCaurcSOqZEtcEx23JgWeiomeQ2RTWPzXM
         bmrk4lR8ARHwWFCmdb2awZPhQNs4orNrmepXljdtx56rMWWLOzqK/WjwC8sVlx3vzpqz
         Zb4rxcU6aVCtwt1WTWKsfUqWvUnOYauDay3BASrYm/Fn7bmaF8PO9ziWFoNgpYtaDyIm
         xMlg==
X-Forwarded-Encrypted: i=1; AJvYcCXXCaH/WJ1B7zjqLiOsM8/6G9jHVZXkV2rtKP/quF8kkNE1FXTNU7GQAQnFFFgaBppyhT3CRjbYeG+t/9VLltM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFdJ+61uo177svKhtLt+Bods77Fz5/jEiwjWYdDeyA3756l97w
	VExTOfdRN2tWCIRZqzSUeUEao8TwiXFZQfK+qcgDGf1nHQsUtmC5oh+sZCoRXkdAahGqQKYiBmi
	bL6Nky2qguW6EqRMYT2oKKh3weQG6/NvSTwj57x5X
X-Gm-Gg: ASbGncs8ZY9l3Fq2N1qxSWjWVys/wjiRoLB07SW3JbEpeqNF7QjNkpdiG8GoR0zkOFB
	YvUwGn7HKHF5lcVdHwJxRJM7a2QvYfJj0d8OpoJvSeAqgmhxukvQ1Y9iUymshrWIZSCa8E6ZoV9
	kqXnss+gU90aI4jSXAsNrUB4ZB8uS+slHF/I7Cyv2GXt2+
X-Google-Smtp-Source: AGHT+IFZisuQr0XUMCY/TsPmXwCpvRIsc7yuC7ge4dGerQJstZ0mmexa2XR/n1CqsdanZlcKCX5a5a78//KhVZUXy0Q=
X-Received: by 2002:a05:622a:1a27:b0:494:993d:ec2f with SMTP id
 d75a77b69052e-4a7fcab93bcmr226452571cf.12.1751306880178; Mon, 30 Jun 2025
 11:08:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com>
 <20250621193737.16593-10-chia-yu.chang@nokia-bell-labs.com>
 <CANn89i+6o9sZMgEgP9ZxARVAw9f2KFVqTYPcM_8ZXRHw+-=esA@mail.gmail.com>
 <PAXPR07MB79849370D58D173C7FC3FB3BA37AA@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <PAXPR07MB7984466101FF3A5B5EEE1638A346A@PAXPR07MB7984.eurprd07.prod.outlook.com>
In-Reply-To: <PAXPR07MB7984466101FF3A5B5EEE1638A346A@PAXPR07MB7984.eurprd07.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 30 Jun 2025 11:07:46 -0700
X-Gm-Features: Ac12FXxKoE1lXTXBoA4A1s6rxCjheG7xASzXjbQdiAPnxiDiotSbIGAhM9k6RZM
Message-ID: <CANn89i+BH3aNfm9qBggWo4+GKeCNdU2rcVL_QOcJBrrYyZ3XCg@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 09/15] tcp: accecn: AccECN option
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: "pabeni@redhat.com" <pabeni@redhat.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, 
	"horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org" <dsahern@kernel.org>, 
	"kuniyu@amazon.com" <kuniyu@amazon.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>, 
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"stephen@networkplumber.org" <stephen@networkplumber.org>, 
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>, 
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>, 
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>, 
	"ncardwell@google.com" <ncardwell@google.com>, 
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
	"g.white@cablelabs.com" <g.white@cablelabs.com>, 
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>, 
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 11:05=E2=80=AFAM Chia-Yu Chang (Nokia)
<chia-yu.chang@nokia-bell-labs.com> wrote:

>
> On top of my previous reply, I will like to specify that the following EC=
N functions will also be included in new /include/net/tcp_ecn.h
>
> void tcp_ecn_queue_cwr(), void tcp_ecn_accept_cwr(), and void tcp_ecn_wit=
hdraw_cwr()

Sure !

>
> This is because these functions are also been modified due to the introdu=
ction of Accurate ECN.
>
> Does it make sense to you? Or only AccECN function shall be included in t=
he new header?

