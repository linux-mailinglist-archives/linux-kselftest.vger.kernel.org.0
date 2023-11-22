Return-Path: <linux-kselftest+bounces-465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66017F5488
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 00:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07DB9B20C6D
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 23:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF53521347;
	Wed, 22 Nov 2023 23:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hc1wwOrG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6B71B5;
	Wed, 22 Nov 2023 15:28:29 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-332cc1f176bso182008f8f.2;
        Wed, 22 Nov 2023 15:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700695708; x=1701300508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfE1KTkgq6xLLiPqdRtfBaDM02CW7efViNW5ZFPiv6Y=;
        b=hc1wwOrGT+29COZc2S5ErMm8kicGbNGH0xm+6D2Z+Y5t9lligQOnixC/Roq69MXkym
         KeWbv7EUnNbZbLvhTU8y7gQDi0o7O3bh5TJIPsWjFY4RFkPOGpkUJmkr0Qa6bfS2Z9G6
         c/sLZJeo5BdfDEam8PGXKsnpiV5dFU8htuNh77JWtlZsNRCADghH1CIYZ1WESuhgXz3v
         7QuHZb02qIe8NqzN0kiwKRdU0CzIgkbTI2O6lvQQxIJoK5y70CKiQPuxg0rKU3lixTwY
         lkHTHT2LQ8AmUUlT9ExmjwldepdMacPyKS/tuvQsQ8abmWnVAGjr05HwYsEkVQDsTddu
         f5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700695708; x=1701300508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfE1KTkgq6xLLiPqdRtfBaDM02CW7efViNW5ZFPiv6Y=;
        b=VZHKwq/83gOoc5SfSFVJw+r7rL+aTGJxAxqmImPXwPjncPnhTdKXrkLpwL0OcE741M
         Qf4luHnRfAS+pHsfAhmUwrXmaZ1a5SQgFsJHrxhcDCu6Z4WY44LFqFGsDkwjsKqA6hlj
         qwyXQLj8rszhWobwXqzHxeCGRdhA6xa3FFAaoOEKcrurrQDWwGpSXoPuwfpF2h0nKnl+
         i+hMwMWnXHI8Ps9kBjrgUehv1e0LHQOqxzyRoOwydV6clGBve83iH4jVgc5l+FCYmEr7
         zYOIM86B3lhhs2ZnVLOH0O9sGEW+hA0K0BQ2wfyL2U6iCLKCsZu/Pyi64/cbyhEbZnn5
         YhwA==
X-Gm-Message-State: AOJu0YwfOYBhNoOXtud3eo7xEulrf8B8FFXnSGfJUs5D70Y/7Lhqm3Na
	VnkmDRm1W2HTHJZ2VnV83fexU4KWYRqZ5AgS0VtUzeIa
X-Google-Smtp-Source: AGHT+IEWa+pEGlUg+/D9JPP0S7XYTOdPQaLW3OpbJ4qWMzplMz4rJEDxjuTipm4leeAQKQZkXLmHQEzoc/18EMdp+/4=
X-Received: by 2002:a5d:5550:0:b0:332:e190:f8dd with SMTP id
 g16-20020a5d5550000000b00332e190f8ddmr13782wrw.37.1700695708128; Wed, 22 Nov
 2023 15:28:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700676682.git.dxu@dxuuu.xyz> <84111ba0ea652a7013df520c151d40d400401e9c.1700676682.git.dxu@dxuuu.xyz>
In-Reply-To: <84111ba0ea652a7013df520c151d40d400401e9c.1700676682.git.dxu@dxuuu.xyz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 Nov 2023 15:28:16 -0800
Message-ID: <CAADnVQKg7-T_g7CFRs62ZDFyR9z=FTxfyXyTe=3_ojGpnvxJ4w@mail.gmail.com>
Subject: Re: [PATCH ipsec-next v1 7/7] bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: John Fastabend <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	antony.antony@secunet.com, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, devel@linux-ipsec.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 10:21=E2=80=AFAM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> +
> +       bpf_printk("replay-window %d\n", x->replay_esn->replay_window);

Pls no printk in tests. Find a different way to validate.

