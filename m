Return-Path: <linux-kselftest+bounces-2166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF50817B82
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 20:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D611F238FD
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 19:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E436674097;
	Mon, 18 Dec 2023 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuFXviiD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A812372047;
	Mon, 18 Dec 2023 19:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CDEC433CA;
	Mon, 18 Dec 2023 19:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702929400;
	bh=grKlAQWV5xV5wJkfKbKrDwxqfLJY1vUR6WlZYNNuA/M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RuFXviiDAzvfM6oPPwKPeQxhxx0ROEeGABDBXhq8+EgQGsx84/SxCdxu6h2KyALeC
	 yS18QnDvUZ+3Aa7PQRbyli72gr8maRcPxAkZpL/O6f6wOMUooq3TsDjzodkp50+6iY
	 sdereDZp7Y5Kf2KTpOaVRw12M7DrO2RRGRO5PDJ1dxeRBZcB9UOCG77XZMA1ZdKQqk
	 vvIAWPG9koo53krWGRGspu4tFnL2m3PLxMDI9pGKROG1tAkxcXec51DyZZ22fly72U
	 RNtUB/YNiVzjqBx4cNhX3U/jpz5GKUQxa5WsCIvm7Ckru4YcNE+eNx1hcDTx96lOxx
	 kYN53AyvKi9dQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e384cd6ebso1758627e87.3;
        Mon, 18 Dec 2023 11:56:40 -0800 (PST)
X-Gm-Message-State: AOJu0YwAP8U83ZAT1OGBJ3UcXy7vRGMFbsj5JS8RATS3L6epacpwBtYN
	yKiOOHm9URsaTSeGPdL3SUPqhI38kt04mAugcNw=
X-Google-Smtp-Source: AGHT+IGRZ13EcavCOorqsgntfK6FaZoWyYwMzNZj5jKJnbQHE7+5oLKfwJj7KjKBJ+wssogvyt5tiMo+CYWeUoo1XBY=
X-Received: by 2002:a05:6512:96a:b0:50e:1ce0:b510 with SMTP id
 v10-20020a056512096a00b0050e1ce0b510mr1996591lft.97.1702929398315; Mon, 18
 Dec 2023 11:56:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2f33be45-fe11-4b69-8e89-4d2824a0bf01@daynix.com>
In-Reply-To: <2f33be45-fe11-4b69-8e89-4d2824a0bf01@daynix.com>
From: Song Liu <song@kernel.org>
Date: Mon, 18 Dec 2023 11:56:27 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6=-FK+ysh_Q1H7ana=A6v9d0Rsn+2hpJpm5n2dB_A1Qg@mail.gmail.com>
Message-ID: <CAPhsuW6=-FK+ysh_Q1H7ana=A6v9d0Rsn+2hpJpm5n2dB_A1Qg@mail.gmail.com>
Subject: Re: Should I add BPF kfuncs for userspace apps? And how?
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jason Wang <jasowang@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Benjamin Tissoires <bentiss@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, kvm@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Akihiko,

On Tue, Dec 12, 2023 at 12:05=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
[...]
> ---
>
> I'm working on a new feature that aids virtio-net implementations using
> tuntap virtual network device. You can see [1] for details, but
> basically it's to extend BPF_PROG_TYPE_SOCKET_FILTER to report four more
> bytes.

AFAICT, [1] adds a new program type, which is really hard to ship. However,
you mentioned it is basically "extend BPF_PROG_TYPE_SOCKET_FILTER to
report four more bytes", which confuses me.

Can we achieve the same goal by extending BPF_PROG_TYPE_SOCKET_FILTER
(without adding a new program type)? Does this require extending
__sk_buff, which
is also not an option any more?

Thanks,
Song

