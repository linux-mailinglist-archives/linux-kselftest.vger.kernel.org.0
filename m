Return-Path: <linux-kselftest+bounces-20254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3A29A6561
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 12:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B391F21E05
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 10:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED231F8917;
	Mon, 21 Oct 2024 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbs32x30"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC42C1EF08A;
	Mon, 21 Oct 2024 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507825; cv=none; b=GxHGcqh67yeF2ERMGffapuVwPho3cgYo16FyWs5n7NUjTAsb/0rm+TN32N3HN+W9R5hk09/dH5zeNEAD3IzznpDeBt571KIO0ysrJzAZvKlHXlqK66e4oWrntgnp+4Tp65mcYXhBLfabdeMLnm5n9JthNgAnsU5wwBO52k1zgns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507825; c=relaxed/simple;
	bh=vSCLM1dgE4FoLJgLpmiDGuIFX1GeGg58CNsp9kSq4do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erRP0i9wFuLt8Eb752E48l3WnMMx8DM8hosbwlAUOoX7t/KBKViKMUu3NCTbqnzLmSLW5cllX7w4zBZYR8UfF+51PzCd/1wCYrEhhBXagu8SUVGBaAOEEExhY7ScuxtLyOCP5d8hAosXqYu+8tG+mjTly6kBw9lfTGuSNUcQjjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbs32x30; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a3b98d8a7eso14894395ab.3;
        Mon, 21 Oct 2024 03:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729507823; x=1730112623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIy528uVWJw1YoGmJDAMqtAvzfKpjfBt3Eg1UXyhTUo=;
        b=hbs32x30riG50B2O/QQduQw63Uzt3X+LGsxQ0fru8p3SET+x0IcE0NYzUutp34rMC9
         iDUyRIp9uwk+e/qG0nc1+bC1ArIMf0mxfZsYmPUel6GOu81o032h2r/D41UqoQNF9wGe
         7ZI5sPu8p9BA1gwPgui5LeW1YNLeSM0rqgbIVdJd3JvLuRL3ItZETt8Ow0KwaTC0lwzy
         YGXec7lr4ACau/l+ukKXsficDDeg/2NdrDj0C6rv1rmWnAmz0xwMLEHsqtO7xaY+aCyz
         SQRLHe7zk8V9D9iQinUWKzUd3tUB7tddTEkP6qwygAVyZQG1R7M61dg7n4Od1Vo4BRmv
         uOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507823; x=1730112623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIy528uVWJw1YoGmJDAMqtAvzfKpjfBt3Eg1UXyhTUo=;
        b=Nr/cFg8IMfidXbGlA1HvjcTXz+2cls5pqxYlnuoPoeUw1hIszbe/V2k+BvVzyZ7hjZ
         rn0/OsN5kHAhUas2ZXFUQQ9KDPvpD43R50pPKhehcQluumpOYg6RT6ldrkr7r2gvY6AB
         CIGl9EOs5kIuVaD4H6kJ86d6bbzJ9aqGsqPYkKn4mZwEJQvzYV2eS1dJA7spE0FKV63O
         Qp0NJs5NoSyXg6H4WuaO/tkdb7iSvseGTTPLDmO9VX96paFqM9WLPhT/YXBnnuJaYQvH
         tDITxN2pa16USFJrCCci/z1fdka1F3Ss3BHR4KtFejlyALCeuaAKkm5wHp8wNTVLAF6U
         0EvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcF4OpEz1Ylax5oHm/G05x19b7dGlxoyc4shJIVNS8VghRoSHIB3yCtDw2cYwdPKElRTg=@vger.kernel.org, AJvYcCWq0ZL24lgnYW6KaWEUBAZttfBIB33twAly5EqElfGEKmOUBoUEIc0lPnfQgwY2+XXsDC0N5nhFcFvRRBJw02U7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4NOo81HjfDfHhoGhzwRoBgdL7TvCk4EyCvBQE8mIh2aIntWqn
	izS57nbYmlBUuPRdzokmocp1DwgtXoq9NpX6LaYEeyZGqjUHZpaC2gqTed2IJmDcrc7EXdLoSh0
	rSEgiSXe50f1F9Wuf9sQWRBnNWgc=
X-Google-Smtp-Source: AGHT+IGHQAffYAx/1Nrnq+6hV1gb4eXlkNHZ1tq9NP5aTTK2koX9Rqp4XOTVYzxfmLGzjVpdmlqpMw0LMUFZSH1tduc=
X-Received: by 2002:a05:6e02:1487:b0:3a0:92e5:af68 with SMTP id
 e9e14a558f8ab-3a3f4073be5mr109626685ab.15.1729507822810; Mon, 21 Oct 2024
 03:50:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021050706.29403-1-kerneljasonxing@gmail.com>
 <ZxYFn7fko5C9BnHe@krava> <CAL+tcoB-tHf5kW6Hq0TtsnqFLU3nWZEuZ+L7roDyJ0q_qW=WxA@mail.gmail.com>
 <CAL+tcoAw1WGnJs2DQjEyzsh_rNXKA44oYX5RvQi8nCvt4+ynLQ@mail.gmail.com> <ZxYgM_YDoSJO1TxL@krava>
In-Reply-To: <ZxYgM_YDoSJO1TxL@krava>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 21 Oct 2024 18:49:46 +0800
Message-ID: <CAL+tcoAu1jO5geB1B8ECDW=AJ0j4Tzy52z29uZ74tEzu39PbHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: handle MADV_PAGEOUT error in uprobe_multi.c
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, shuah@kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 5:34=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Oct 21, 2024 at 04:07:15PM +0800, Jason Xing wrote:
> > On Mon, Oct 21, 2024 at 3:51=E2=80=AFPM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > On Mon, Oct 21, 2024 at 3:41=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com=
> wrote:
> > > >
> > > > On Mon, Oct 21, 2024 at 01:07:06PM +0800, Jason Xing wrote:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > When I compiled the tools/testing/selftests/bpf, the following er=
ror
> > > > > pops out:
> > > > > uprobe_multi.c: In function =E2=80=98trigger_uprobe=E2=80=99:
> > > > > uprobe_multi.c:109:26: error: =E2=80=98MADV_PAGEOUT=E2=80=99 unde=
clared (first use in this function); did you mean =E2=80=98MADV_RANDOM=E2=
=80=99?
> > > > >    madvise(addr, page_sz, MADV_PAGEOUT);
> > > > >                           ^~~~~~~~~~~~
> > > > >                           MADV_RANDOM
> > > > >
> > > > > Including the <linux/linux/mman.h> header file solves this compil=
ation error.
> > > >
> > > > hi,
> > > > strange, uprobe_multi.c even has:
> > > >
> > > > #ifndef MADV_PAGEOUT
> > > > #define MADV_PAGEOUT 21
> > > > #endif
> > > >
> > > > and '#include <sys/mman.h>' should be all that's needed
> > > >
> > > > could you please share more details (extra flags) on how you compil=
e?
> > >
> > > OMG, thanks for reminding me. The net-next branch that I compiled
> > > doesn't have those three lines. Now I can see them in bpf-next. So I
> > > think the issue has been fixed already :)
> >
> > Link is https://lore.kernel.org/bpf/d9846ceb-b758-4c17-82d1-e5504122a50=
a@oracle.com/
> >
> > The previous comment is not that right. Making sure to include
> > <sys/mman.h> first solves the issue so there are no complaints when
> > compiling. No need to define MADV_PAGEOUT, I think.
>
> right, but looks like it was not enough on Alan's setup [1]

I know what happened in his environment. If he wrote the following
code in this order, he would see the redefinition error:
 #include <sys/mman.h>
+#include <linux/mman.h>

The key is to reorder those two lines like this:
+#include <linux/mman.h>
 #include <sys/mman.h>

Then everything goes fine :) That's why I said his comment is not that righ=
t.

>
> jirka
>
>
> [1] c27d8235ba97 selftests/bpf: Fix uprobe_multi compilation error

