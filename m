Return-Path: <linux-kselftest+bounces-47288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5FECAED10
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 04:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5091C3000B4D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 03:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8782EC092;
	Tue,  9 Dec 2025 03:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Gk/MRn5T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021AA12E1DC
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Dec 2025 03:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765251232; cv=none; b=L9GBcOffzdaKzHrN2yjKtJI26RqPmQYwFkPrL92FnfJsAqxqnmUkJRFM/Rey9hUjmJwLRBLAmXhuL2li73cB50Q0KL4cyhyAqQnYH5gZHruugUtrnAi1rea65Y9O9ffoVJYYKHbKSKeHuQ7VnuOTK4Qv/PV9C9+CF1m4ZsiC0go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765251232; c=relaxed/simple;
	bh=mArw2vAL0D2NHk8zLQ2Ijxxx1bFuIg9r7rH/hnyrq/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUFbGtMLryIyLWBmKCd3h2uv8vYxbRWlg+ASLMmhYid2O9Fk1blhFB2A8UpKCWIkyKKeHSN2u/3tzdjjTJ04613uNtf3vGeBXhAtFdztWZ8wMwUbnyxwS0elIQQB4NkHU7r4WaRow5Ia+O8cWSilCfKckCaHfGpvGTWGNNDwEYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Gk/MRn5T; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b735487129fso751492166b.0
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Dec 2025 19:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1765251228; x=1765856028; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ve41G5hMhFJfqXtFvhXu3GnjjOI5g5mevMdggrYlYVI=;
        b=Gk/MRn5T5ELIp2VhQELqZBKEEveCABYkDbKpDEM6xqN+USwCwzlYWtH2yLoReb7VTP
         RAIGbpON7sajRmM96yt0O6QsTQJ8J3rJf7VRuN5bA92UfVcy5W7zpP2AUlKCLUwJIoXo
         Qn+YhdeTqcIQUrrPqADpVr8iuLnUHMTm4UW3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765251228; x=1765856028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ve41G5hMhFJfqXtFvhXu3GnjjOI5g5mevMdggrYlYVI=;
        b=IWGk9b2F2n1AxVmPNWi7HAulkZYCScR8MRtMUVygVrl18kvkVMtlCkm+TfyJr508wG
         +scEPWvh+pSDPl/Rb0JNM4/+aCSVQINrTDjPDO0Y5mFW/n5AcWvq2LzpICSl6B5Ya86x
         WrX+u8KcB31N59URWfjLi2KMl6M9ye4cdFerbolvNSmy2EceXuMO8g9Q4rBMUw3+9pQa
         5dbYrcp1X9tmqs78xd9vzZ43ZzdA5LWimv+bSeNEOuvcEpQZjgveDYGsUewUr8BY5lok
         Kl0SfPfe2ViXHl8Xvr429MJUgeuPCc3rk7HgLamYqGS7ZDoxzkadsc8h1X+eHgFSlzTN
         yNNA==
X-Forwarded-Encrypted: i=1; AJvYcCXdWti+aGski8xd/SPKhrbZP7nAzZwEBz1kR2KJXtFcb42OhGWVN0RZSZrsdaFPVdCzNcIbp8grl0oN/mc1ssw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLEXbMChe/pKsYDyQajnFqvvOaHocE2cXfLcvCBInk225XUnH5
	5b6SH2xsTTOBRfruKyctqQWd/zVqnJrVAmXkXoi4xfEr3sAKz0zWLwA8Q2QsL9wSFdgMo639lWb
	xfjR1Xgyhfg==
X-Gm-Gg: ASbGncsTh5L89rBzILFWfX1vM6iSeJ+v5qpjeOA03OjpfIUxiaOZhxUpStR+EMaFQPW
	EDO1YVElupIcWrBsrhRMoQRt90aKN4ZGsIO0/vom5RmJ1m6o486J6wAAb+G1M/btyPDzBSpNlRL
	OifmoLSVqKx+uBdJvsfxYwRpL0w5v9pBQXen/Few3T3kIdPYSm/Ntx4xkgX2u0VF7cktMJkqBoM
	1ecizZ3KK3G1v4SCsAfVtg9zLPqJBmer1RIBwfLaAcfSYYlOBIz5dnH967jUxTlDL748/4xQK7c
	Jv1r2JRgXtO/XuYCICl/yCqg0ZbFPfKWhtk34OSTv3Dy2qyxtOHroC3ZZjqZX6TVzKILkDAto28
	C+ifI/K/cYSikGyArhKe6MeJsmYQQFpBb3coUGAKVUQsBYlAir3NftdD9+6/UkqLnm0xI5nssau
	zWqLBeovi/PTlQrGnx12JA8svuIebIldHoERHfnByM5tEr6mJ4Xwu6KKRiHQ62
X-Google-Smtp-Source: AGHT+IF7o421RYKnp4lnk6gDEpyGP0uMCv96cQZ3UUjLi71cXUO+jytTP7y/bWiQ1NkAbOWmwCYf0w==
X-Received: by 2002:a17:907:25ca:b0:b77:1a42:d5c0 with SMTP id a640c23a62f3a-b7a24827918mr1026855366b.43.1765251228124;
        Mon, 08 Dec 2025 19:33:48 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f49a97f1sm1222225066b.52.2025.12.08.19.33.42
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 19:33:45 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64149f78c0dso7556790a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Dec 2025 19:33:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXYCBxhzO/WyQpsWkd3E1efssMPcPMSFtRzONZZiUp626H0XNZY2HbaTxB7UrHGEt/FoORybMX+SjYtEtaYA8o=@vger.kernel.org
X-Received: by 2002:a05:6402:d0d:b0:647:5e6c:3220 with SMTP id
 4fb4d7f45d1cf-6491aded554mr6980906a12.21.1765251222388; Mon, 08 Dec 2025
 19:33:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208235528.3670800-1-hpa@zytor.com> <176523908321.3343091.17738363732550848005.pr-tracker-bot@kernel.org>
 <CAHk-=wi0RqQPHME0xgrAZBQijKuos97cQO05N4f176DkH7msbg@mail.gmail.com> <ee693efe-5b7b-4d38-a12c-3cea6681f610@zytor.com>
In-Reply-To: <ee693efe-5b7b-4d38-a12c-3cea6681f610@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Dec 2025 12:33:26 +0900
X-Gmail-Original-Message-ID: <CAHk-=wghm5NFZQcfObuNQHMMsNQ_Of+H7jpoMTZJDrFscxrSCw@mail.gmail.com>
X-Gm-Features: AQt7F2ofRIAXVmCzZb3EAMnphwigz_H3r18InwGDDrhalL1GL85PEFWZ4uBTknk
Message-ID: <CAHk-=wghm5NFZQcfObuNQHMMsNQ_Of+H7jpoMTZJDrFscxrSCw@mail.gmail.com>
Subject: Re: [GIT PULL] __auto_type conversion for v6.19-rc1
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: pr-tracker-bot@kernel.org, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
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

On Tue, 9 Dec 2025 at 09:24, H. Peter Anvin <hpa@zytor.com> wrote:
>
> Yeah, it commented on the master branch, which is of course ... yours.

Ahh. It's because you didn't use the standard pull request format, and
instead did the branch name elsewhere.

Which btw also messes with my "just cut and paste the address" thing,
because now I'll cut-and-paste two different things.

"Poor Linus - all the pain he has to go through".

          Linus "think of all those extra clicks" Torvalds

