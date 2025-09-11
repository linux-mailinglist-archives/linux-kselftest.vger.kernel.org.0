Return-Path: <linux-kselftest+bounces-41227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FF0B52EBC
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 12:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E650A1889ECD
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 10:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF45A258CD9;
	Thu, 11 Sep 2025 10:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G/vy/uXH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA1F2E7BAD
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Sep 2025 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587169; cv=none; b=IoExDayddmqq00je832CSPdnDVSbOkFXahZn6C7ptVjuuvp9kyj7qAC0OKriI/AyvEF9jo/RdDd1tYSQ7SAeSTdw7oKD2sLyUT96Da6owz6TYvKvSV7tQS/Jgr9Y3sH/yXXyNdVQoU++B2tWCGXzu6/DnjL+90oODhuuxI5kg1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587169; c=relaxed/simple;
	bh=i3K4Fxf7hfpTZXUakuir9VBvWZAWa30Q3SjDrMBWzpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m2lveYK23RHfjlo6HGPAUGMWJDKl6PR+GycJ9q+YXCrc3pj73co7mRMD4FerOLhLDuxni1AtgyvCtRhVqlZ/HWHRFKjPr5DlDwh9yFObv4U3g4WF0swjR3Gmst6NGTWquf4Do/U9D3OgtuS6jGP/e7J2tNwjh5PdL7VdLixQz3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G/vy/uXH; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-80a6937c99bso51730585a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Sep 2025 03:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757587167; x=1758191967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/5NZRakXMPSefxzoUTWOFF7jXrb0Qk67PQkNmcLMfM=;
        b=G/vy/uXH4hHaInZrUtcu+gbfF2UZyccQx4XnA3wTYLPdasbltn7qXFSemjaE8ktMAa
         TeWwTnYowdTL3bHAjQ8IlQJmJl8R+4HKZgVnQNCl4VBz0j7FAdZtNkMYOTFZyagPJmII
         mxzM4xeJ/OA8vH4kq6taAJaboA08DoDCA09qxRFP4/WpS/ibDfDYKtrC1MZLWVeTLajV
         1YMRyBRe1TIUYzz3mReZALnmrUdiWDCX/zcZbK87z2J/exJDSOGk9ouZSux9etq21L9K
         pwKow4u2vwEgcuB697KarH8VZcWnv8LVW0WqRkYv4W0wSkUKGd3dvQPC0m1NSHNZdETo
         JY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757587167; x=1758191967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/5NZRakXMPSefxzoUTWOFF7jXrb0Qk67PQkNmcLMfM=;
        b=R7GuoT8kmlQAUJ5b4g5ho4G1T1r+rs2WhkxqJH9dfDVNiCX2iDZbJiS2c463CuvORV
         VSuUTRf0yGOEOklUJxcnXbXIS/Rqv24sD7gLIG7IXjpAb9dg8sbGb2eDmwq3z6X2ReKX
         sIeJYYNI97W3iBnoQ5wLjeIUfksRupR86rs6jy+71XlKxZ6isUjqEpqwyJfeHtD87//P
         2FGgCEG+JAweUJWKx/XcgtSS3wNQQM6cHVNlTdeoWHqROq84wwsNL5ADIDwXdTJo4z2P
         /+jgZ7FnjMgCqVR5L7N6PQavwfqJQWgfkOgPwAdvJjr4SEtNGwpMkY4kAv+YPmU3lu0G
         lMeg==
X-Forwarded-Encrypted: i=1; AJvYcCX2b4/256xQxrnqnWq1mpqQKBkgAdrecmIErpwI750405PuYZ8lzkLJvcdBH9RxuE8PBDqg1klvy7QXHTmmOKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNe0rCNSFDOAMB2IKR7XI+pSh4krmsds8I56OCuNxOCNvNTC9g
	7q1vkF1MzZJMRB7B1cS6ZG/+3HcApQpzF3RkdldSuVFBOADs/s3qQLfA6aIVeykvTA6CGRo6U0z
	WGMgwJw8Ze4XXvEpC3JI2Spevw6Vckscx3mmKLc5N
X-Gm-Gg: ASbGnctpwHGLthJSaI1yE7FTki6fytGMw9wrnB4yj/pkBPvTU9JXelnuFD1YVyTQqtE
	yzx62SzJMbxn0k79hd6SLkyx2nxdo/PehUNrDhTpNa66mxm0/SiGaj4L3p8CTEr8gN9lEL6xvw5
	H9hJfRGXp4HcHAkO1ZXJ/3Yv5Z1TuC8wBfLJ4vGDBCBqRwLj4i3rUnPrswS2MVt3BlMud4k/87N
	oXFZqotS9TDqFbT0PfpV6jH
X-Google-Smtp-Source: AGHT+IF13RHUxixDCnJaQJD5HYKG53fEjs1UREQfhmAQiVkkh3Z8KzpXFO+znykAoH6YQe4Wu+wBZD5IVHQdxauw0gI=
X-Received: by 2002:a05:620a:191a:b0:812:693c:bce4 with SMTP id
 af79cd13be357-813c596ff46mr2299523985a.39.1757587166519; Thu, 11 Sep 2025
 03:39:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com> <20250908173408.79715-15-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250908173408.79715-15-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Sep 2025 03:39:14 -0700
X-Gm-Features: Ac12FXwjNGPxnTzV9uOkde1KbfezAZ4pzyFGGkehM4wIScw1o9g0Jk-pKtQTlfw
Message-ID: <CANn89iJzdnwtJcEwdyAzNF206bYzmHKqNGoBF7G2pR101ZWS+Q@mail.gmail.com>
Subject: Re: [PATCH v17 net-next 14/14] tcp: accecn: try to fit AccECN option
 with SACK
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 10:34=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> As SACK blocks tend to eat all option space when there are
> many holes, it is useful to compromise on sending many SACK
> blocks in every ACK and attempt to fit the AccECN option
> there by reducing the number of SACK blocks. However, it will
> never go below two SACK blocks because of the AccECN option.
>
> As the AccECN option is often not put to every ACK, the space
> hijack is usually only temporary. Depending on the reuqired
> AccECN fields (can be either 3, 2, 1, or 0, cf. Table 5 in
> AccECN spec) and the NOPs used for alignment of other
> TCP options, up to two SACK blocks will be reduced. Please
> find below tables for more details:
>
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> | Number of | Required | Remaining |  Number of  |    Final    |
> |   SACK    |  AccECN  |  option   |  reduced    |  number of  |
> |  blocks   |  fields  |  spaces   | SACK blocks | SACK blocks |
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> |  x (<=3D2)  |  0 to 3  |    any    |      0      |      x      |
> +-----------+----------+-----------+-------------+-------------+
> |     3     |    0     |    any    |      0      |      3      |
> |     3     |    1     |    <4     |      1      |      2      |
> |     3     |    1     |    >=3D4    |      0      |      3      |
> |     3     |    2     |    <8     |      1      |      2      |
> |     3     |    2     |    >=3D8    |      0      |      3      |
> |     3     |    3     |    <12    |      1      |      2      |
> |     3     |    3     |    >=3D12   |      0      |      3      |
> +-----------+----------+-----------+-------------+-------------+
> |  y (>=3D4)  |    0     |    any    |      0      |      y      |
> |  y (>=3D4)  |    1     |    <4     |      1      |     y-1     |
> |  y (>=3D4)  |    1     |    >=3D4    |      0      |      y      |
> |  y (>=3D4)  |    2     |    <8     |      1      |     y-1     |
> |  y (>=3D4)  |    2     |    >=3D8    |      0      |      y      |
> |  y (>=3D4)  |    3     |    <4     |      2      |     y-2     |
> |  y (>=3D4)  |    3     |    <12    |      1      |     y-1     |
> |  y (>=3D4)  |    3     |    >=3D12   |      0      |      y      |
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

