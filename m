Return-Path: <linux-kselftest+bounces-9710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5428C0004
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 16:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4261C227AD
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 14:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3432E86254;
	Wed,  8 May 2024 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyrWLuyS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899CA6A8A6;
	Wed,  8 May 2024 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178773; cv=none; b=nQD/JbvfLRs0H6W18R6q8K/nnpWqDfoqkWc/2kCj2unjYgN7atz76teVcr9l24Xy37SSgK/Lyy4Zt2LifuSqPyy7/UJUREN+aYWwF1RfW1IHt0rwgwpNcQJ7HRtcC9XrAD7+iBr9c3oCnTW04vsJXHMHj1XV6hkR3VProzJavOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178773; c=relaxed/simple;
	bh=HVuSNV30ElxcT1+wSpbmK0uLVc4u+3qE7HNXqWCBkzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+zI+FONMuxB1y2bN2+OCLI087zFW8yT7UOxK2+UUH5VBXlpWfBMpib4yY5dgeal7ZsMqwOBC56kDA+OCNl+aoSDChNStU4wEb/ZAhjDBCmKZwCU+Jw1258CLiHmii9xLPWelU5yLmxKQ8SaFyMoMldrzAL9aMOmHlaAdbYL03M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyrWLuyS; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34e7a35d5d4so3343275f8f.2;
        Wed, 08 May 2024 07:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715178770; x=1715783570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVuSNV30ElxcT1+wSpbmK0uLVc4u+3qE7HNXqWCBkzE=;
        b=jyrWLuyS+0Uh2cVas1SRi3AehA+KS6zKFIJh17vFLQ9i8Vvg7r2fRuhS6p7k/Zqo6W
         1PsvwQi+EpiXM6t0s+blUU93OAFyGIdo8EuiBHYD4R+VC0bBjlELHV7vLn2H5ccYB/gL
         aRZps0b8RNWmPmxYjtWef0CZGMuNCWwqxUcqqXSTS1mQdxJ67YY0kDVv1jF8/sGWquPi
         y29CWpOjaDFOUSoqYo/urHlMwUV+jSkt7PZWHwSkYvx2rAWK25VZ1pQ5//BERTj0SY2X
         zlBTsiyHWcTi6GUoC1mjJ4xIX8+lM8NiYXcSSiHkDaI/dZl1J/8MFvbwjqkhTLw8C45H
         xX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715178770; x=1715783570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVuSNV30ElxcT1+wSpbmK0uLVc4u+3qE7HNXqWCBkzE=;
        b=sCLvNUCpN7VdyZw/sQVcWIXtVmNnoosRPZ6auNO4HXR53+LE7SiDJODnysdxZRzlQ8
         KTilEgk9A54UqqcD00hy/h/lE6VbywY67qHkKuH5jd1z7/fkNaqBKMLSAhGqn7L4TeeX
         xeHrz+SdJJOJ8LaiE06UMEzsRpgPGj3f0PD1C5eoL+fWeKj7wxZY+WJaaccFOA78z7e3
         PH3D7+iO9MTOon4s37W0qx00NNZ1QfUZxGwpXvKrXihiYTsevuj5BpAEJuHTSMeT9N3n
         oD6sQuNW5L4nJGeIWjpeC2s3oD/mDCBOrOXN3IUYJWNok7wFGN/0d8U2Yr+IMmBMDssN
         +C2A==
X-Forwarded-Encrypted: i=1; AJvYcCWlsSw+p1PTW7NhnqpZh+cQfxzY87vOadsOF2p3pbt2l60zFbctMiFS4tKRmBAvEkLdUUDsQ6XnD/BGBGa8LM+IYCyzJCujdRLoJd1yntTQehmGEqnTBA6Rcw9uxrh2d/X4ViF9NfnqcGMGqBJsGckelbGQvyZwNk5tBZlEMr27qLW9qWSdyaz3BxPNBXVVPdaZHkAGcY8a1YPt
X-Gm-Message-State: AOJu0YwaPemS8nWJmH0SBHAIa6+YD74nEbPyLyfmNRWkMpR+YxcZpLEg
	ge07bpDtO82uVe9CDZvcjPSHkkCHcmnCScLtsecxgT6ISz1FRZxXcpY2x2z9qlJif92yLMSMPw7
	InMxqFaCx+3ZufpsB0qqIIAUeDSA=
X-Google-Smtp-Source: AGHT+IGIQzT0RrKC7x0GqEWEZhRSqTUdJnPjGul2tjjJI1pgCNj6AAR9flqehUHmkOSFJCiYE/2NxHIW09V4wGkEHx0=
X-Received: by 2002:adf:b1d1:0:b0:34e:21cd:dbed with SMTP id
 ffacd0b85a97d-34fca14b28fmr2461061f8f.14.1715178769627; Wed, 08 May 2024
 07:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-0-e2bcbdf49857@kernel.org>
 <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-3-e2bcbdf49857@kernel.org>
 <CAADnVQ+ADQRrZmZ_M9LLGj9u_HOo7Aeup+kid62xZfLCvSxUOQ@mail.gmail.com>
 <843ea6eb-a28d-437c-9c98-0b8c8816c518@kernel.org> <CAADnVQLA+2uoJJAJNFoK-EnUjLAwxJjxOXAizLWhcx4mf+C2Vg@mail.gmail.com>
 <42d0718f-296d-48ca-a21a-b4708e9bd6e9@kernel.org>
In-Reply-To: <42d0718f-296d-48ca-a21a-b4708e9bd6e9@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 8 May 2024 07:32:38 -0700
Message-ID: <CAADnVQL4z=LcJW7iD246Tc+TB-Ast-eYHA9DaN9q6dgQ_Z97Wg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: Add mptcp subflow example
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 12:36=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> >
> > The concern with picking reno is extra deps to CI and every developer.
> > Currently in selftests/bpf/config we do:
> > CONFIG_TCP_CONG_DCTCP=3Dy
> > CONFIG_TCP_CONG_BBR=3Dy
> >
> > I'd like to avoid adding reno there as well.
> > Will bpf_setsockopt("dctcp") work?
>
> We picked Reno because this is an inlined kernel module that is always
> built: there is no kernel config to set, no extra deps. Also, it is
> usually not used as default, mostly used as fallback, so the
> verification should not be an issue.

Ahh. didn't realize that it's builtin. Then sure. keep it as reno.

