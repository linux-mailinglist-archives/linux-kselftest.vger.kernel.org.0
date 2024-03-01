Return-Path: <linux-kselftest+bounces-5708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4C786DF6F
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 11:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259981F23413
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 10:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C9C6BB54;
	Fri,  1 Mar 2024 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="S7B+XxgQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9574969E0B
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Mar 2024 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709289725; cv=none; b=otDUNg8ZsHkuo1rheqXMmQFhaRzo/4IZryxjhT2BD2irep7fJp78PFQQiS2Qyyaf0qt5rhV1nKZ5DCRdKivQxzoSmtsPSzXPMKNLVTpxTouZvxnM1yqzrd5fAtao+N+/PL77CFsO93NaxuA3qj2I1ICodclOD/G1IojpLMTh0bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709289725; c=relaxed/simple;
	bh=MyzEAkBZuIpR892vDJgDwyTBmBXyBAiXWmQvk35TtYY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=jkpsUuY2XKNv+nyq53scVorP1u+2b9e3E21SgInB+TaZXL2B4/EfiwxPGiCQrAJB4uKJLptLCKOzAq1mqx9wXMgsyl6Ds4zoUvtqTZHwdLLLV5B+xK7z/4K14U7UciWyrrdZ2zXe4MfRuBJKxj7bUAWstvpZO9vE/UJVyICVBSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=S7B+XxgQ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-565d1656c12so3438238a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Mar 2024 02:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1709289721; x=1709894521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FUsAED/lmxCoWoKnQG3JtYsXIKOmckCJxzG1hZ6f9c=;
        b=S7B+XxgQr4MJMxukZ+TsmEkO0cEaU26VkSsgs6gy7pfebgwfScrzlT/13uHPYF1W6A
         Jmdgqgc5/1SzAdN20oSUPA2MeaRytnrjezOfODG/orN/dLJ3Q4vHDEC6TlpeXDZECdYu
         BqZArM7R4VVQZhhW4ylSSJqrGseGMImPgO4Ek3XAFTuRWNU8MkiWamVzAyRgFwisRmLy
         U5h5bioHIzjrphuXjX9DjK3yhGQl+z7Uf/hI6gVaRQl3Tk/9o+esnWPmT55OsSrq/28x
         Mm6Ws01btgOOes5LlRE9S17APyLrO04FwB9I0hmjPgWxEq3eeS3Ty5aTLmMQW7j7GnO0
         iYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709289721; x=1709894521;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3FUsAED/lmxCoWoKnQG3JtYsXIKOmckCJxzG1hZ6f9c=;
        b=NryFl3voFTnRCRgyYaIxYl0bLk7da9loEvEldyH0cV7gyefbD3hdDjyph3JBQUYmt+
         rcu3r3ZwQv+0e+qW+AocRs2HGuVeqOYeILWOQtel3S1DOJAn784AkVuU+7wLpoDY5Egm
         xI5K0uecctRd4DbLVkCFwR4Mrk22wXc9AdNukcx88zV66f/LP5qkw4pEBhHgxec0aW1M
         XLKcuQRs0e65JpkEBU8dXL6A71yKo1C4Ru0ooMkdAIDhv606mVeF5TaPnxeJ+mQxl+tI
         JS/3XoojULdXfJPsrJqCYjMfwiBfFNsd0WapP8sVIOt773tCagaPKhXaLe2MIJ7XSiSG
         ZcuA==
X-Forwarded-Encrypted: i=1; AJvYcCXIHIMgOkpNgJMnNy1RkvQPygJ24drGPmnbrZe+cLa8swCXjsWNukBs/rQXRbP2AWIYSG1kxXtCY7Kt98kLfG5FRBaDGxKJqok8oO+SlsYk
X-Gm-Message-State: AOJu0YyDyhDytNVPhFDV6kXjffy9MCsUgGwcQgXNl8eac+rMQJjxpfUb
	YpBqPS8tznj6kSwkuwTFETo+JwrGUiLoVvvF7BnxigBVTgOvqkRJSp6IfbbCsd4=
X-Google-Smtp-Source: AGHT+IFsNGzvNzeIMp+c2vln39bwQZyElm675FddMfJSSFuv8gtyc69SUsSkQMp66ZVqG55y2w4wkw==
X-Received: by 2002:a05:6402:28af:b0:566:6c13:82fd with SMTP id eg47-20020a05640228af00b005666c1382fdmr884994edb.21.1709289720923;
        Fri, 01 Mar 2024 02:42:00 -0800 (PST)
Received: from cloudflare.com (79.184.121.65.ipv4.supernova.orange.pl. [79.184.121.65])
        by smtp.gmail.com with ESMTPSA id w20-20020a50fa94000000b005668c6837ecsm1421669edr.32.2024.03.01.02.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 02:42:00 -0800 (PST)
References: <20240229005920.2407409-1-kuba@kernel.org>
 <20240229005920.2407409-13-kuba@kernel.org>
 <871q8vm2wj.fsf@cloudflare.com>
 <CADvbK_e+JCeM9cn0Qd7JG5UdSO_-s8w5r0v40E485JevkbH4XQ@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 29.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, mic@digikod.net,
 linux-security-module@vger.kernel.org, keescook@chromium.org, Marcelo
 Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [PATCH v4 12/12] selftests: ip_local_port_range: use XFAIL
 instead of SKIP
Date: Fri, 01 Mar 2024 11:40:45 +0100
In-reply-to: <CADvbK_e+JCeM9cn0Qd7JG5UdSO_-s8w5r0v40E485JevkbH4XQ@mail.gmail.com>
Message-ID: <87wmqmkzd4.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 06:25 PM -05, Xin Long wrote:
> On Thu, Feb 29, 2024 at 3:27=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.=
com> wrote:
>>
>> On Wed, Feb 28, 2024 at 04:59 PM -08, Jakub Kicinski wrote:
>> > SCTP does not support IP_LOCAL_PORT_RANGE and we know it,
>> > so use XFAIL instead of SKIP.
>> >
>> > Reviewed-by: Kees Cook <keescook@chromium.org>
>> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> > ---
>> >  tools/testing/selftests/net/ip_local_port_range.c | 6 +++---
>> >  1 file changed, 3 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/tools/testing/selftests/net/ip_local_port_range.c b/tools=
/testing/selftests/net/ip_local_port_range.c
>> > index 6ebd58869a63..193b82745fd8 100644
>> > --- a/tools/testing/selftests/net/ip_local_port_range.c
>> > +++ b/tools/testing/selftests/net/ip_local_port_range.c
>> > @@ -365,9 +365,6 @@ TEST_F(ip_local_port_range, late_bind)
>> >       __u32 range;
>> >       __u16 port;
>> >
>> > -     if (variant->so_protocol =3D=3D IPPROTO_SCTP)
>> > -             SKIP(return, "SCTP doesn't support IP_BIND_ADDRESS_NO_PO=
RT");
>> > -
>> >       fd =3D socket(variant->so_domain, variant->so_type, 0);
>> >       ASSERT_GE(fd, 0) TH_LOG("socket failed");
>> >
>> > @@ -414,6 +411,9 @@ TEST_F(ip_local_port_range, late_bind)
>> >       ASSERT_TRUE(!err) TH_LOG("close failed");
>> >  }
>> >
>> > +XFAIL_ADD(ip_local_port_range, ip4_stcp, late_bind);
>> > +XFAIL_ADD(ip_local_port_range, ip6_stcp, late_bind);
>> > +
>> >  TEST_F(ip_local_port_range, get_port_range)
>> >  {
>> >       __u16 lo, hi;
>>
>> [wrt our earlier discussion off-list]
>>
>> You were right, this test succeeds if I delete SKIP for SCTP.
>> Turns out IP_LOCAL_PORT_RANGE works for SCTP out of the box after all.
>>
>> What I didn't notice earlier is that sctp_setsockopt() delegates to
>> ip_setsockopt() when level !=3D SOL_SCTP.
>>
>> CC'ing Marcelo & Xin, to confirm that this isn't a problem.
> Yes, SCTP supports ip_local_port_range by calling
> inet_sk_get_local_port_range() in sctp_get_port(), similar to TCP/UDP.

Well, that's embarassing.

I see that I've updated sctp stack to use inet_sk_get_local_port_range()
in 91d0b78c5177 ("inet: Add IP_LOCAL_PORT_RANGE socket option").

Thanks for confirming, Xin.

It's clearly an overside on my side. That SKIP in tests should have
never been there. I will send a fixup.

