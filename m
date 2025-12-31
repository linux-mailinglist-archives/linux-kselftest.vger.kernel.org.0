Return-Path: <linux-kselftest+bounces-48039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84426CEC969
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 22:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FE5F3012C4C
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 21:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F183043BE;
	Wed, 31 Dec 2025 21:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="db9bex7p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4557305046
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 21:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767216898; cv=none; b=MkplHpJ6ZvcPn7+cqa7CUVMcGSHpRO7eMPvBVoRrBG0vIIpsYPdN2da8Yph81o7ipl4G4nM8c7fDEFLUER3gFyz2Dp7zjEDxyaGAApUG0CMXHzmo4YHvU4F0N18+TRa20WbIfak7uqRwIzr52rjRrtj5gGppkWgYXCR6/RF8hF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767216898; c=relaxed/simple;
	bh=NkpxC+v+IEZhsd9ska/BWRQFaVRrwDGbf3fuEbg07AU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6zEUvSuPxZHbRIkmCpzp4gJOHZkoEjsP6yET0arqA4BCCzaO0krjYSZRA1Czw1+LUwcncsz/Sg3qdG3NaUsrKVcAfNMQTih1qbYw1+gdGbbm8yboAuUEHO+ZfXTAlQGbdKsDxELfZrZHHh8UD0/Smx3nSvy7lagAKzbFWT8+aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=db9bex7p; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fed090e5fso5092367f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Dec 2025 13:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767216895; x=1767821695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GleHLxzrqhi5Hmxay6c41BI3irva7zlljp3uEYcnh1A=;
        b=db9bex7pjZ0YvBZsfrVw3EOv1a2ziWD2wq3hw/GigqvN6Dsr6R+HYmz26vo0SSbOtN
         rKC14Tl6+Hif1Zz/sj6r0/m6vexA++ZMpGapNdSdTlYRUf+zV8q4VOe0iaA2kFHk7Q75
         wYnk3gAzt0H7fQ8n8kAR2YtGGnT4Oa4SyeuT4Fh5eapjxmoAJ84p5VvNBJqVhdA+XEqr
         GIEsXjNgwjd/3QV2bptxDKrQeOjdxlM5Loj+ykKRRfU8opnD8GfwO8AUFOGdUX0imf5f
         5PuJf3UJYTJSGg/BXqP/WdcF6rPDse8KA62BHUnP6cEjngV/RBqdZwxBCXDlhWR88ZMp
         r7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767216895; x=1767821695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GleHLxzrqhi5Hmxay6c41BI3irva7zlljp3uEYcnh1A=;
        b=xN/eVZk1RNPVU7yOtEIXaTrT/B81Gc7ZmzMmbxbH0Z1ofGzdIfaEw3qPl3AAFAQtIb
         RaNLbizlDlhPL2u2KbFLBoteTZD80aWGDrYbrzFtQfAjKKY67Ihth4A0JfsHEkQoGSJ6
         iC3u9+6Ls5ipoZu7Qr+SLnRYddQImRP7SuNZ1slNj+vFFXNZxvj/fqJZJTvkX2v4bTxF
         q0C4wcmfMgksydh2RWk3IQDr1Re/LFZK8+4J7uOUSQSmiokYco6lxt7guuw+QK20uddm
         qtgJ3cXNVvi+XruXsTB0ESAp2swiZunDNkpaIJdNA9xfVth06hlv1xLNAO1VK79//STe
         RXkw==
X-Forwarded-Encrypted: i=1; AJvYcCUU/fNFjEDMbzEtcNK4cf+IQM2qo20DObSPTxNhhE7dKY5N+jdXM+AC6TIMtf5CuJ3VDtE515K6aj4gjLeKmTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP9AR5UIvAqDFkjK/4yg2Fs1n5l99phx/IgU6TMgmvrxdCNPn/
	cJNrEeJc8h4fIeK7BeIKaozX3yndg2CIl+QA6RcScWLi+tBEHQfAkZKjdZPYgGZXZYhM9NSooOl
	VAew7fG5VUOr2ygYQX8jxDa7nxvGUnKo=
X-Gm-Gg: AY/fxX6eDQorQmm+a9D6+WQ/Cn6reg3PErPi3CpHmghtyDqf9X7z7oIs5PsE0b8aQGp
	H2GJBZk7B6As5lxmb2Ct+PejZ1sjPLyVDqN6jM/8xDFKilYzB+BThrmNmPd8sjzQwg4kXo7ULCJ
	LFN59UKgWMvkf1Y8Z5JsmpuXRJSlY7KrzZ+xc6Cea5YKODeLWxNg+jWA8dvO7DZdP0pzua64Ezc
	2vsvMk3RENiuPRhik3hmyhuaV+wL3YFv78T+sj8Z60UaWif1CMdEIiv6n/6f/2ulLN4l+sdUitt
	Zt5DxfFvKLQcIc6hYd4fvMFkP8Dd
X-Google-Smtp-Source: AGHT+IHt+ldVyNL/+5ZYIaXtm4dZPxM9U/F2RXTc0isKzBzLrWGnTUAEyyc+PvTuMiqiJQmrxvIZRk9PjsPUty8TWTY=
X-Received: by 2002:a05:6000:2906:b0:430:fd84:3171 with SMTP id
 ffacd0b85a97d-4324e4c9e98mr46013240f8f.22.1767216894870; Wed, 31 Dec 2025
 13:34:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231184711.12163-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20251231184711.12163-1-sun.jian.kdev@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 31 Dec 2025 13:34:43 -0800
X-Gm-Features: AQt7F2r3FvMkanS_Kc02yR3b3z9fhG7p439EULDoQJrWc41KaD98QXyP6kRecGY
Message-ID: <CAADnVQLUzhEi=T3shodJ_9N-e+=epH52Ui=B=2eFXMRfZf8jTw@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: fix qdisc kfunc declarations
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 10:47=E2=80=AFAM Sun Jian <sun.jian.kdev@gmail.com>=
 wrote:
>
> The qdisc BPF selftests fail to build because qdisc-related kfuncs are
> used without proper declarations, and struct bpf_sk_buff_ptr is only
> introduced in a function prototype scope, triggering -Wvisibility and
> type mismatch errors under -Werror.
>
> Fix the build by:
>   - adding a file-scope forward declaration for struct bpf_sk_buff_ptr
>   - declaring qdisc kfuncs (bpf_qdisc_* and bpf_skb_get_hash/bpf_kfree_sk=
b)
>     as __ksym in the shared header
>   - including required BPF headers in qdisc test progs
>
> Tested: make -C tools/testing/selftests/bpf OUTPUT=3D/tmp/selftests-bpf \
> /tmp/selftests-bpf/bpf_qdisc_fifo.bpf.o \
> /tmp/selftests-bpf/bpf_qdisc_fq.bpf.o \
> /tmp/selftests-bpf/bpf_qdisc_fail__incompl_ops.bpf.o
>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  .../selftests/bpf/progs/bpf_qdisc_common.h      | 17 +++++++++++++++++
>  .../bpf/progs/bpf_qdisc_fail__incompl_ops.c     |  4 ++++
>  .../selftests/bpf/progs/bpf_qdisc_fifo.c        |  4 ++++
>  .../testing/selftests/bpf/progs/bpf_qdisc_fq.c  |  1 +
>  4 files changed, 26 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h b/tools=
/testing/selftests/bpf/progs/bpf_qdisc_common.h
> index 3754f581b328..bed2294c35f9 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
> @@ -3,6 +3,9 @@
>  #ifndef _BPF_QDISC_COMMON_H
>  #define _BPF_QDISC_COMMON_H
>
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +
>  #define NET_XMIT_SUCCESS        0x00
>  #define NET_XMIT_DROP           0x01    /* skb dropped                  =
*/
>  #define NET_XMIT_CN             0x02    /* congestion notification      =
*/
> @@ -14,6 +17,20 @@
>
>  struct bpf_sk_buff_ptr;
>
> +/* kfunc declarations provided via vmlinux BTF */
> +extern void bpf_qdisc_skb_drop(struct sk_buff *skb,
> +                              struct bpf_sk_buff_ptr *to_free) __ksym;
> +
> +extern void bpf_qdisc_bstats_update(struct Qdisc *sch,
> +                                   const struct sk_buff *skb) __ksym;
> +
> +extern void bpf_qdisc_watchdog_schedule(struct Qdisc *sch,
> +                                       u64 expire, u64 delta_ns) __ksym;
> +
> +extern __u32 bpf_skb_get_hash(struct sk_buff *skb) __ksym;
> +
> +extern void bpf_kfree_skb(struct sk_buff *skb) __ksym;

Stop this spam.
You keep ignoring earlier feedback.

pw-bot: cr

