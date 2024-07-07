Return-Path: <linux-kselftest+bounces-13289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 078AE929635
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jul 2024 02:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808CA1F21697
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jul 2024 00:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D2EEDC;
	Sun,  7 Jul 2024 00:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVMNLpGE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5365ED8;
	Sun,  7 Jul 2024 00:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720313647; cv=none; b=cuE8ZCMIXYMPabDNKGYB67s+NAJPFxdOni75aB85mdvFyuhcsBCM4Ijj5PbgbMuxFFZzfC8nRCj7R+wYSWdgYNQcn7iFj7yip3BxXg7gE/F7CiO6mvI/ktFR36bcqFB9wbQPO4vvCa3NKl9SMQqlyU5yDP9yOw2XwFhuopAiNvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720313647; c=relaxed/simple;
	bh=68t7j5WbxgggIpGYhnaJIazJdhDWpn8rFUfKqZ5kcGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CrOvav9dVxOKb3OpE9otfcQN2I8JAN8S1xluysOEUmAC37gWFU3GsODEa6MrI1iwFzeKHzY0gffxdJfbsMqRrjdcomtcZUVWxQFIEXHBPFZEdJfvHvJEn0dlUF/ureVcvw6klhAnJkpEXnJKGwcEWignaMEFPS4OIa4okMpHx8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVMNLpGE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4266381bdf1so2678905e9.0;
        Sat, 06 Jul 2024 17:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720313644; x=1720918444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDJtFHapH/1E9UkmstcWuKhjLNs8bIvltZfoE3Tvwmk=;
        b=lVMNLpGEZihPZAFH35LPtwR8zknsPAgDjdU9RAR6OiqRlkFEj6nSkzMk/Qhy9AnPYr
         rwdB2REGStt7Hmg2/z/8tFxCeLjERlgE2CrtK93ooFgw0CHR/KiR1Va+J1yXiq4MLc5k
         gQKGCnBlWncmCgYAVHZgGXc4KlmMEEuLj61Zu4x98jZsxR1ut6be/4DRapnV48xyQDl7
         cgKTgMAKpf438LAjp2X3FoPSetMn1/r75Fk1BbY+5uQR5stB+Rkvz0J6Nq3xjhGupN2H
         De7H4Q8gwN0vGQ9dGtOVwteUfzE1gvSAmE4+Ms00Q7mToBXIbZEPyoOuWY1Cd67Jgux4
         ft9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720313644; x=1720918444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDJtFHapH/1E9UkmstcWuKhjLNs8bIvltZfoE3Tvwmk=;
        b=t8zCr2OJEX/FC2ol6Qx7ZzdH3cpYDzuXJK3Yk1+mcnElDhEjYdX4MaEgWpVguZoi2B
         CKfLg2ZdbDtRWVHf/FH99K4E72ds9it/JPBbIrcUrf5xI63b36tf90/pXBYwrm0SHqBZ
         VCBTskQafAKov2rDJywXs+e91XZEs9v1N1LmmezokbPv5HRWCGeAWISFke4IsUDbrFmI
         8Mpp8pWTXAw6k+MaX7va6X0irv/I9NNwVKASL+3X9NV+ynf/qMvgvAgvXI575RXWXENr
         GljC4RaBpKc/+og9Uyr+wUy9HPu7lBFs5mJqjYBNLnUcWyYd8M9pnd9Vpl2iQIpD+2dn
         OGCA==
X-Forwarded-Encrypted: i=1; AJvYcCVdeZfNhB+ZorbOj5obsjpsiu7Z1V/+YpCfg0aaxZuKd0OAH8kUHvRKFtXspKOLhRh1Qh/3Pl8viA2ISBZ4XpBu9YeoAzK63KkoSKJzj1jZCvYfaifnyDC0+2kB1LhsgYr5qCX5nqe7jyv+Y/3nOzutoUdoLkW2jYPppGudc+lGrEF3
X-Gm-Message-State: AOJu0YzSN5xFG19Uh+ZSkbE3dqJ6KGxYN+2bMdBFoceOSYRYYHw/y8v5
	F99+cTBK38HqD1/DBk/ZWQyVMD4HNvmCsvQE2k/39pG18Yj/Fmz8nKZZA2FE8GOgdT9irzGEUdU
	tHJ9+CLXL+nCY6I94irM3lWn2tg8=
X-Google-Smtp-Source: AGHT+IGBhpbNl6WaFj6Ja2lfJux8OJftniSoXE15cLyCUsxKAQeKuu+3YnEkUzPAvrIzXjlxmMZ97J9AfnSdpTHTDDY=
X-Received: by 2002:a05:600c:3b8c:b0:426:5520:b835 with SMTP id
 5b1f17b1804b1-4265520ba19mr41126125e9.5.1720313644179; Sat, 06 Jul 2024
 17:54:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705-fix-wq-v1-0-91b4d82cd825@kernel.org> <20240705-fix-wq-v1-2-91b4d82cd825@kernel.org>
 <9742abda93ae2d90148f54b585adc825e55a1a38.camel@gmail.com>
In-Reply-To: <9742abda93ae2d90148f54b585adc825e55a1a38.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 6 Jul 2024 17:53:53 -0700
Message-ID: <CAADnVQLvWHd9i0tcTib5cO=AGJN2EG5cCrV02FsLu9JRe54_zg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: amend for wrong
 bpf_wq_set_callback_impl signature
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 1:54=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Fri, 2024-07-05 at 15:44 +0200, Benjamin Tissoires wrote:
> > See the previous patch: the API was wrong, we were provided the pointer
> > to the value, not the actual struct bpf_wq *.
> >
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > ---
>
> Would it make sense to update one of the tests, so that it checks the
> specific value put in the map?
> E.g. extend struct elem:
>
> struct elem {
>         int answer_to_the_ultimate_question;
>         struct bpf_wq w;
> };
>
> And put something in there?

+1
let's tweak the selftest.
pw-bot: cr

