Return-Path: <linux-kselftest+bounces-47284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC97CAE80D
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 01:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C39F306500D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 00:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E402FFDC2;
	Tue,  9 Dec 2025 00:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NpbGfNSu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3FD1F874C
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Dec 2025 00:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765240014; cv=none; b=t1znSMpgikuw62y2aCxZ2iiis9rVkrcTT8b1wMzVQSMKtcKoTviL2Feth5aiVf8ym7MQ2YxEVAObRqbgkP4RFuvReOOE7w8bn/8Zyve+OQZeO8G1yN9lXWOe7a9TaQ9dMENtZfD6rZwLNEub2vI5vY1atOMfkY40XXIAbUDrpSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765240014; c=relaxed/simple;
	bh=JEk3Jb3o2V3Ykrxdybm6wJkA8vNlfxfi4dCZ5w/NQfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atEredmTjNvnEnAoRdKlVNWBI5Qpx29Xu90/C6CU62wgjmqRQTpRlBOoaNMZwSNzBBJle4H1EjC2TP1a5DHy8NzPDsoahlVmCV8cuHJNkiM2YRt2+XUgOAp6gHpTp+S+elnw2+hmM1VePEZbinq1uXNr/6DsznXLvBhwwDL/+yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NpbGfNSu; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37a3d86b773so44317171fa.0
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Dec 2025 16:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1765240011; x=1765844811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FonhJLVNH15zuQuznSG0KVWWqOZ78Kr7QO87AtDDYSQ=;
        b=NpbGfNSu0UrxYuIyNrQVGmJJxuDQ/SE8POaGHSA/L5Cil8iItRip4khhcItglLoQPi
         a45VwhuRP5BLaQ968AJS0JmrV9FVzPtV6rsjZps/sX/iwpo/j6EMkCwLOPKemVO0sr09
         WXPoYsmKgdssF1yFGJ3Jl9Ixm9hu93C1WfaN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765240011; x=1765844811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FonhJLVNH15zuQuznSG0KVWWqOZ78Kr7QO87AtDDYSQ=;
        b=hHMbd0Qc5HYdVvVOPB3NY4Ui7SoF4HjSZS1h7lQ7J2sulxOjRpM9xdvYWVsMaiEfoo
         rukMPn4CPc1vSz8Z4FBS9WQxBmTT5f4cEjJub8ZuOnt2MrXpbcwErdksQQwdU9NPQmeB
         uSZSYPHxSOn6XbvrajjaozPLzJovBfFcsKdKfrIJiAcADXZTEmybFlEUJf1Jvw7bZ7kY
         n6DNZhqzC4YTYB0Kvjwdad7ZufSjBJb7mxPi5H511BPfFDJ4C45iT1rDJCwMYY7b7VPc
         zEZA9YRo2kr1ffRgujkfHWRuuLLEJMu5Kag54uRisGMoqxqtOeIW4n3QQDNjO/VyL7uc
         nMLw==
X-Forwarded-Encrypted: i=1; AJvYcCUcNnTsSeAsI35Xs7vYV4SWvstLqb7kTzCDpV31IqiFq0w6xIlS5T/xTEuxNzFXVGu8b1JGC/LGE+PMOBiQN54=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCDAxPHPTnatFLWQ6vIw3BWGsE0P1ulUXVA1JmBWskg4KqsYyc
	KAQFP/7E739a7bEVDMXX8kTrH2RTBST4rnYWm+RNIKtJQ+jOliptwfsU8L9USrFnc9Wsp3AbUrh
	yEy8Gdydg8A==
X-Gm-Gg: ASbGncslJsus9OVJ3VSpDq8YF+q02hTRYfK5Mr3wKHYKFy9++urqw5TnL9LuaFX7oW2
	kBRDog8K/W+Crrs+a+jlUF5/27uc9deqy8TCtx5i1KLpliLB8FE8rIWrBjt7iNei3b2ceetsuMK
	uTm9r+fJXQrgS6RXm+A1+f+hfzpIfE7DVef6F/AD5aKF7hOPB7KnZg2m2f0RnuFxwFwJVcjxYy0
	lyDtM6deDeUPEni7IL3pJ4Cp+zwtBun3pur5FHWyRRDpvW3kPLwIYHdBWyCHAcQAAX25eupb01D
	rrPm96Ud0UmudZnRviaKhSdUFWSAo7YtKtIEzdEzAIenPIswDhEjNqnnCZ4OjisW5OoBVO3DUr9
	+iDSr3eVlGQQhDD1KVJvMQoYC0NKaQpslFyupoJVDfcRNBqGrrxLJEC1BF9sixQWyzQiV6vFhNH
	3nqbtJ2DxNjHPC7Hlh2b+SvRgV2SFL8CYHnK76V4Y9n8S/mJrpPq3sChywOEK8/5hAcQI90HM=
X-Google-Smtp-Source: AGHT+IH7JgZr1eN2aDFfIWWeQiAr2FAxoyQQmo3SHlnqvTu3XsqItJPkHkOLEVCCatqLUGxk+YCqyA==
X-Received: by 2002:a05:6512:2520:b0:598:e4ca:817c with SMTP id 2adb3069b0e04-598e4ca8362mr1315053e87.4.1765240010905;
        Mon, 08 Dec 2025 16:26:50 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-597d7b24a06sm4627640e87.32.2025.12.08.16.26.50
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 16:26:50 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5959da48139so5130303e87.1
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Dec 2025 16:26:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXTD8Fb0TWIcrCR4ueio9KXce6bMlH2R2UJQ98W6VlMjRMKO3QeE1L73ZIGEvKW/8QCJ1m8lplYzCJJsuVQEcg=@vger.kernel.org
X-Received: by 2002:a05:6402:4403:b0:647:8538:fcf4 with SMTP id
 4fb4d7f45d1cf-64919c10408mr8423201a12.10.1765239641812; Mon, 08 Dec 2025
 16:20:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208235528.3670800-1-hpa@zytor.com> <176523908321.3343091.17738363732550848005.pr-tracker-bot@kernel.org>
In-Reply-To: <176523908321.3343091.17738363732550848005.pr-tracker-bot@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Dec 2025 09:20:25 +0900
X-Gmail-Original-Message-ID: <CAHk-=wi0RqQPHME0xgrAZBQijKuos97cQO05N4f176DkH7msbg@mail.gmail.com>
X-Gm-Features: AQt7F2roobmnBFxkxCTs46omVLlLQvijaEzayZmWK0Hwr8qZTgYHcUtxshIhuTk
Message-ID: <CAHk-=wi0RqQPHME0xgrAZBQijKuos97cQO05N4f176DkH7msbg@mail.gmail.com>
Subject: Re: [GIT PULL] __auto_type conversion for v6.19-rc1
To: pr-tracker-bot@kernel.org, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Laight <David.Laight@aculab.com>, David Lechner <dlechner@baylibre.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Gatlin Newhouse <gatlin.newhouse@gmail.com>, Hao Luo <haoluo@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, Jir i Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>, 
	Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>, NeilBrown <neil@brown.name>, 
	Peter Zijlstra <peterz@infradead.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Uros Bizjak <ubizjak@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Ye Bin <yebin10@huawei.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Yu feng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-sparse@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hmm. I think pr-tracker-bot is being confused. This one just came in,
and hasn't been merged yet.

That merge commit link is for the hwmon pull.

                 Linus

On Tue, 9 Dec 2025 at 09:14, <pr-tracker-bot@kernel.org> wrote:
>
> The pull request you sent on Mon,  8 Dec 2025 15:55:26 -0800:
>
> > git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-auto.git refs/heads/master
>
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/b88b2f82fab45521cb32c0b737266d90a66a748f

