Return-Path: <linux-kselftest+bounces-5305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9814286038F
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 21:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7171C22926
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 20:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2B26E5F1;
	Thu, 22 Feb 2024 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHG2k6ji"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2106AFA9;
	Thu, 22 Feb 2024 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708633058; cv=none; b=Vk0mnio0YJYRbfKY21hlHQrtMzb7+vmQ2MtxAf3mlsEVBjPt9YR3djQlUDILozuKa5ik3b/GZE9tV+t7CaVXmpO5mdFPLVQnbI15y+ysu9rawlj9En5Ld5M0UQICXxvmjGVIU2zt5mE3lZT44CcvlyG1gNr+4kmJD/QmOyNw2+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708633058; c=relaxed/simple;
	bh=WQ3SpxljGD8htKIpUBHT/rzsOAuo3PcPLumU/xVxU+0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vCLFYRuXfM9TQ8VGyW7LVFjnHUC58DxJNwa+CRk1ugAgOIK2J5jwBcgM5n+vntLmxyng7J3MoCCynrYGzMz22uMaKUwjhsxCR5fOqgVn5M8lmW8SZzTFvfdqABOelSoWz5fTnNdDatTSXu0r8P2g4J/iBc34v7TaVQ7ERmgkXXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHG2k6ji; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5655c7dd3b1so492959a12.0;
        Thu, 22 Feb 2024 12:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708633054; x=1709237854; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=obxmoIolkt9nvzu4fkp0dIeP0qUQPenbvHm4Va8/O5Q=;
        b=ZHG2k6jii77+UKqfpgt2GBaGyWQEImKoPZ5Z4CDx+NhPten8MgFpLgGJdU0F/Rp68A
         L2JdciQo+Knu7fK2mZMH13jfYU7fTZQXhLBJ7llnQTc5VC6XOnSLTYvEMbIiFb1w9y6f
         cY3j9OFjTgBPJFfFTYzGbPaK5lAh3yRcfIQdA6ADL2HuqxuLw6RHh0i7PVnFPyYXUUce
         srPeb/RsZ4FqGb3Sp91ozFfxv9oQsFtlJcF3sa1IAfTSEwsR3K2i2En1zkZlyVBHtd/y
         gnVTHJjCrgBPI1K4JqzK1FqMGfhgGMIT9Rq70LT0t6kqI2f1THntW1qC6ttbDYc4aM/Z
         DZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708633054; x=1709237854;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obxmoIolkt9nvzu4fkp0dIeP0qUQPenbvHm4Va8/O5Q=;
        b=RVVXw2I3QJiYr7YMUkQxHWv05J92trPcJCWzHixh5qYC0SoM9cJKbd4TUddSufdpsj
         oDCE2NVgSrtpmh7xaFONveQy4CrwZ+ZLYa5MVec3G3wCYEq4L/xlQ0B1budlTlkP2FGo
         ExKAtM6PnnbuFe7/Qmkr9XGah9x73Da+28c9LPaEYZh6tmAYkjfp2BF2tts53rgLkZpe
         CibNpMQRPfkk15g2Ck1Z5ox5k7RZgup54rKzQoJFneTe7CFY0Tjd77Hr99Zpcwe9P2y0
         p3d92cC4mFRECTqpdDkvDwd7ty0GR3yMQNisY4uPmWQg6e+hmuPC1UplgtbYcmWC3tuQ
         uArw==
X-Forwarded-Encrypted: i=1; AJvYcCWoxPml8ePrjCa+7K888xJ27YUEvS+L2ClHCsT/mqduxF3+bmW7CEFt7HeYHmnFaUUGAlEFZx8I8DXNlDP78sh8tgAc3jwBsUJrYmPSuwDl4gQ7TqrTtDeHqzytbK6tD1pMK0lyKS+wA3kKPo1lSJvnjpGQbsLYWQyFCstafo5OLnDwGc3P8q1d0HMW9ljmJ5WjbALw/WBXxXAQn4WUds8zUNWHxdo=
X-Gm-Message-State: AOJu0YyGbqTHAVQs2wvyqMC1CICsBFseqA//dQHts1OmCfhPc4yxxDGu
	3JFziaoqJwg2SQtpRbYT8XYbzIs0U76kpqX1mws3XUgmdSV253s2
X-Google-Smtp-Source: AGHT+IFfCJl0pCwyoGoaD0qdUuKtdDF0us0QzLlM+mBaxde4dSAnMHAI+eXlRmw5XQVK5NvoQQrNXw==
X-Received: by 2002:aa7:d747:0:b0:563:c951:838c with SMTP id a7-20020aa7d747000000b00563c951838cmr79814eds.18.1708633054391;
        Thu, 22 Feb 2024 12:17:34 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id fd5-20020a056402388500b00564bd1724cesm2877653edb.65.2024.02.22.12.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 12:17:33 -0800 (PST)
Message-ID: <962a182f514e96ce258e7173608c282a6183775a.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v3 09/16] HID: bpf/dispatch: regroup kfuncs
 definitions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>,  Benjamin Tissoires
 <benjamin.tissoires@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Thu, 22 Feb 2024 22:17:31 +0200
In-Reply-To: <20240221-hid-bpf-sleepable-v3-9-1fb378ca6301@kernel.org>
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
	 <20240221-hid-bpf-sleepable-v3-9-1fb378ca6301@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-21 at 17:25 +0100, Benjamin Tissoires wrote:

[...]

> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf=
_dispatch.c
> index e630caf644e8..52abb27426f4 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -143,48 +143,6 @@ u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev=
, u8 *rdesc, unsigned int *s
>  }
>  EXPORT_SYMBOL_GPL(call_hid_bpf_rdesc_fixup);
> =20
> -/* Disables missing prototype warnings */
> -__bpf_kfunc_start_defs();

Note:
this patch does not apply on top of current bpf-next [0] because
__bpf_kfunc_start_defs and __bpf_kfunc are not present in [0].

[0] commit 58fd62e0aa50 ("bpf: Clarify batch lookup/lookup_and_delete seman=
tics")

> -
> -/**
> - * hid_bpf_get_data - Get the kernel memory pointer associated with the =
context @ctx
> - *
> - * @ctx: The HID-BPF context
> - * @offset: The offset within the memory
> - * @rdwr_buf_size: the const size of the buffer
> - *
> - * @returns %NULL on error, an %__u8 memory pointer on success
> - */
> -__bpf_kfunc __u8 *
> -hid_bpf_get_data(struct hid_bpf_ctx *ctx, unsigned int offset, const siz=
e_t rdwr_buf_size)
> -{
> -	struct hid_bpf_ctx_kern *ctx_kern;
> -
> -	if (!ctx)
> -		return NULL;

[...]

