Return-Path: <linux-kselftest+bounces-13319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0D792A5B2
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 17:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C94F1C21499
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 15:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E751E86F;
	Mon,  8 Jul 2024 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="33rP2dTW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2388F14372D
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Jul 2024 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720452686; cv=none; b=YDNKT+z+uosVrQ+zB0544mVTXZAqZS8f7IQdo2cyi4+h10rZ7kw95k/IjfyQFxP1e5se4X2zIL9SIJ3qocSm41HEnxKkQLUDrOKxL4THNtdkXivRkKY7qhdg5aj7fzPybzZh1Xq1v6Bcg5YfwJ9TYxSAT2ZavQKXjEjvaZU+Wow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720452686; c=relaxed/simple;
	bh=p1DucLGrLtc4ob0xfmnwDylIWxhy2LvdA3yEWGLZyaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMQy1Xe/E66dQXBzTtGk1/2IWJEWHCjqsILH/C7zqirhCRBCH0A93UsQVYQSHmCRq2s/T3tSb3gkhV86cHUOkPIiBjFTUY1Otl7YC1liSZFlhH4HNXcKTFwum5g02K0PUFDRDdkR6ZFY4KtnLfTiDW3P3nJby5e+AF/8qIzH2Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=33rP2dTW; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e035dc23a21so3589443276.0
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Jul 2024 08:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720452684; x=1721057484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1DucLGrLtc4ob0xfmnwDylIWxhy2LvdA3yEWGLZyaI=;
        b=33rP2dTWbKGgi0ayu3rgfppPea5WAxB8Up5h/CwZUAwrxVHkPndCygWfHMB4IIFTC7
         UsQn7itHjyDzOFH2jXSoEVC1OwiAqozzoZ7zXxndPwSI/ADVIst6Lb22LiZnBpCKA+4e
         Ok/Z1pZf4kwEt7Pf5fZnAbRazNVDVkbzFrDxD6KAVlFErktmpgJ33OnnymPAqudr367A
         Cc0IualDLd9rXrIC2i/ueanTx+2R20eulb/cgyYEsKL2qxlexNyiQCx9iqmgwpMSmEdA
         pqyqHmWrVk0OJc1REgaCKiEZ+H5Bm9x4pLm6ZkBRhNM4RUDxa3CPacJ7iugNe1fdgC8r
         9mAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720452684; x=1721057484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1DucLGrLtc4ob0xfmnwDylIWxhy2LvdA3yEWGLZyaI=;
        b=Xr0QrpvtZSG22O8x451c438nBSd2urQf9KfNPUZox1pkbDNd0qGd5gKxjiL5bJnWHa
         l0uSQeqtm80H4TC/IZOb0jJjju6Mg2EEOKCQRyVnxMbRi/GhXAHdUIzCjpMc68XtXpdC
         p4Dyq0qCZdtAvSDW9CKZGCYZ8Z8tOlKHYPr9qowRue3c6581kGjo/1Z3KPgEaZuTMXF8
         VetXvNHZnRbsVUcGb3UPPwI2CO/tJovWGo8N88D30yk/L28ptL8jCrtumyx/JMVLstEq
         fJH8i3Yr9BxGZYKcp1aak25VUGnVyj6AcV9Z+vH8d3mBYqxNyWHJ4Y+ECaGZxWEMEkIe
         vbyg==
X-Forwarded-Encrypted: i=1; AJvYcCX+HCzrAHCLMZYEn+Luj0MpsU3lSva2dr6Sn1yTZ6afLdScIVbz9PpCl9KBTmIvD1blnzCJWlCZx1ysj+jLE75C8dO+GZN/HmIywp+GrB7a
X-Gm-Message-State: AOJu0YzKjjX+blqCS4z65OeO8dgD3hlFUVLTPoutchOmA1xjvZORKEyE
	yG7V4MnoxGeA5bLmR5qRql8MV/1lSKXHLizma4Kfs/9cxO3NOoBv1B5cG6qaarnd2IBGHoVLNBM
	jmr98kCUhbFRoZgV6RbK3r/WDBq2lU0RoywfF
X-Google-Smtp-Source: AGHT+IHL3eGaC3oyRn1KmHvLOCxVtBWlgzQL9W64P1mHo+ZflvAwKn5TqkjOdI4abC1btmdDf4ENB4QCszzsedra1yU=
X-Received: by 2002:a25:ab43:0:b0:dff:4862:b0a with SMTP id
 3f1490d57ef6-e041b11d36bmr67498276.46.1720452683869; Mon, 08 Jul 2024
 08:31:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705145009.32340-1-puranjay@kernel.org> <c0ef7ecf-595b-375a-7785-d7bf50040c6b@iogearbox.net>
 <mb61pjzhwvshc.fsf@kernel.org> <CACYkzJ7d_u=aRzbubBypSVhnUSjBQnbZjPuGXhqnMzbp0tJm_g@mail.gmail.com>
 <224eeadb-fc5f-baeb-0808-a4f9916afa3c@iogearbox.net>
In-Reply-To: <224eeadb-fc5f-baeb-0808-a4f9916afa3c@iogearbox.net>
From: Florent Revest <revest@google.com>
Date: Mon, 8 Jul 2024 17:31:12 +0200
Message-ID: <CALGbS4VEceT3W8KvV+24XgTdFPmNzy=dCWM-xfcWhpwqq4f_CQ@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: KP Singh <kpsingh@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Manu Bretelle <chantra@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 5:29=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> On 7/8/24 5:26 PM, KP Singh wrote:
> > On Mon, Jul 8, 2024 at 5:00=E2=80=AFPM Puranjay Mohan <puranjay@kernel.=
org> wrote:
> >>
> >> Daniel Borkmann <daniel@iogearbox.net> writes:
> >>
> >>> On 7/5/24 4:50 PM, Puranjay Mohan wrote:
> >>>> fexit_sleep test runs successfully now on the CI so remove it from t=
he
> >>>> deny list.
> >>>
> >>> Do you happen to know which commit fixed it? If yes, might be nice to=
 have it
> >>> documented in the commit message.
> >>
> >> Actually, I never saw this test failing on my local setup and yesterda=
y
> >> I tried running it on the CI where it passed as well. So, I assumed th=
at
> >> this would be fixed by some commit. I am not sure which exact commit
> >> might have fixed this.
> >>
> >> Manu, Martin
> >>
> >> When this was added to the deny list was this failing every time and d=
id
> >> you have some reproducer for this. If there is a reproducer, I can try
> >> fixing it but when ran normally this test never fails for me.
> >
> > I think this never worked until
> > https://lore.kernel.org/lkml/20230405180250.2046566-1-revest@chromium.o=
rg/
> > was merged, FTrace direct calls was blocking tracing programs on ARM,
> > since then it has always worked.
>
> Awesome, thanks! I'll add this to the commit desc then when applying.


I originally removed that test from the denylist:
https://lore.kernel.org/lkml/20230405180250.2046566-6-revest@chromium.org/

But then it was re-introduced by Martin here:
https://lore.kernel.org/bpf/CABRcYmJZ2uUQ4S9rqm+H0N9otjDBv5v45tGjRGKfX2+GZ9=
gxbw@mail.gmail.com/T/#mc65a794a852bb8b6850cc98be09a90cdc8c76c06

I moved on to work on different things and never investigated it. I
don't know what would have broken it and what would have fixed it. I
don't remember having observed this "test never returns" problem
myself.

