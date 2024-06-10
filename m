Return-Path: <linux-kselftest+bounces-11590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1749028BB
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 20:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B814F1F224BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 18:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3196814C584;
	Mon, 10 Jun 2024 18:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJOQ7Fem"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E58C26AF6;
	Mon, 10 Jun 2024 18:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718044493; cv=none; b=kUYPaSZ6YD4uZWSn7FggdYIZebHvesKrlIvHdTSi7U6yFitXM5svxdGpzPQFb4OB6Eu2rjj5swFDjFj5biQcuycswDmJewm72d7xhI7G0aR8eUgvRhue/wDKekYgFW0nW2KXNEAOlkvrUBddEQL6UAvmCBw+NXVa0mgP0Clz6iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718044493; c=relaxed/simple;
	bh=WPuFe8huwPGs/GSyM0zQKwNNQ8mwcgXUhLersMgj9X4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJHhrVRtdnbA1i43NkEuQ3AIfFvFYhnG5H9IWfpkns7R5fTeBdCpLzvDL5ovMV9kCFe94RHUbLR0fTADGmYMwoyoescfX3xL0ZG90ph78xwkJkytLwVIWoncp5Q2It9NzYgrBmzP+ApD464pPuflmOIm8e6ELdZLD1b5LjkizBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJOQ7Fem; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52bc035a7ccso292972e87.2;
        Mon, 10 Jun 2024 11:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718044490; x=1718649290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZaJ7Ax6XS9yjm2q4xEVEsYCrC5+rOLb/CKvNzm00rU=;
        b=LJOQ7FemVOylz19TpYxzE6DiBdHuM2Dnl4uV/Ae8PEBYfJE6ZoM0h2ml9ExwFRgqqE
         DUXw/ZLvsnId+sP9cofTwGIQCw1aq3RZl3WDhXlAVvxHmQGAvoofPjG/WfWn2kspRlkw
         5XF5Mrl1V+onhfpl1iKFU3u/lnut0lz8WgAwc6E0cFWRmwGgWkpY3IB2YSUUeYV9cvWm
         IcLCx1kgrX9gLCGt+hmKdcBSYGqT5Py3Ka3gkoFVoKlXb37VgScn6BOnIeP7tgI3JqYz
         O9vzASvi/7avCwRcxXiRh6Sq4Nmcp60k9pcVINWdiawYC6NmFBTYLsebGa1JlroF/pDt
         LvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718044490; x=1718649290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZaJ7Ax6XS9yjm2q4xEVEsYCrC5+rOLb/CKvNzm00rU=;
        b=uw81xWKbPVE3js9nZ0CNwhi7OG4lY8cYnarGpkOz5Itelht3Ia91ube7YYtm4ZkGcf
         VCvPiPmyqt6eXfKY3lRtW/nrRQmgjMhM3OX85VXo4wBy3mkDbHXMJQMPI45Ahe8s95Kc
         qct3T5LQ6GmzVdhImFMHWQ5s4tLFaLAKJ/BrorsoaD3GUL/qvxGsZnxK6Dx98fzYMhm4
         gLlh5yyNP99u/59m2rEe06JGh9IjisjZCEBuIbKmScIiPusCXoruFyVkNVfu4dfbuwV4
         /O2j6GLTO6yHN/zwMISDGCxWqRgwwXcZdDamG33ZOD98SkY4r1kK43PJL9gevfGGwrne
         k83A==
X-Forwarded-Encrypted: i=1; AJvYcCUpcxHwPVqDFdLk3q4La8QKMInJchFaaAn+lOswgBUchJxDpKRQ5Teh3PUx/xE0kZmhz+Rzld7iriqc3jrgJjiLEBcp5nnYW0MjnZ+a1DmRQ9DDBEFwsI/RlcICfpGb/tBCX8yXax0MG90i6Geh64tSt4lCm5hhxhR8IZz58TbE0AdBSInikmi+gz95I+YhbSrdLlgVkKYkTX6DSJaYZ0ArCV1T75WGHPnHZl5enReOjXext+9wuoReRsE=
X-Gm-Message-State: AOJu0YwAvuz1Ghr/7VjvwHAkDyTjxqz7mV2SMOD00jpfoKvaTDU4fejd
	rWg1pWPGvymnkmg/1DjiNPfM4kMf41Mk9x/egH9+Inj7oZ+OGwzRvgvg5lNguyGSPRVd/mHAIq5
	b02LNmunVOr1Cl3H9gjDRGvb19IUjeamO
X-Google-Smtp-Source: AGHT+IHbH8fMKiTXnmFjqlSUKOIDXxzjBI4mqmnkXgV0MOjcwHwDhL1oxLso/YlotpEoeGgLzuzEKDgynJdu0bxHjr0=
X-Received: by 2002:ac2:539c:0:b0:52c:7f9a:5053 with SMTP id
 2adb3069b0e04-52c7f9a513cmr4238127e87.23.1718044489271; Mon, 10 Jun 2024
 11:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608-hid_bpf_struct_ops-v3-0-6ac6ade58329@kernel.org> <20240608-hid_bpf_struct_ops-v3-3-6ac6ade58329@kernel.org>
In-Reply-To: <20240608-hid_bpf_struct_ops-v3-3-6ac6ade58329@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Jun 2024 11:34:37 -0700
Message-ID: <CAADnVQJDZju=QMiAH=TpYHr6KQh3-TT-jNtJ-O2u7JstY5486Q@mail.gmail.com>
Subject: Re: [PATCH HID v3 03/16] HID: bpf: implement HID-BPF through bpf_struct_ops
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Alexei Starovoitov <ast@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 2:01=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.o=
rg> wrote:
>
> +
> +static int hid_bpf_ops_init_member(const struct btf_type *t,
> +                                const struct btf_member *member,
> +                                void *kdata, const void *udata)
> +{
> +       u32 moff =3D __btf_member_bit_offset(t, member) / 8;
> +       u32 flags;
> +
> +       switch (moff) {
> +       case offsetof(struct hid_bpf_ops, hid_id):
> +               /* For hid_id and flags fields, this function has to copy=
 it
> +                * and return 1 to indicate that the data has been handle=
d by
> +                * the struct_ops type, or the verifier will reject the m=
ap if
> +                * the value of those fields is not zero.
> +                */
> +               ((struct hid_bpf_ops *)kdata)->hid_id =3D ((struct hid_bp=
f_ops *)udata)->hid_id;
> +               return 1;
> +       case offsetof(struct hid_bpf_ops, flags):
> +               flags =3D ((struct hid_bpf_ops *)udata)->flags;
> +               if (flags & ~BPF_F_BEFORE)
> +                       return -EINVAL;
> +               ((struct hid_bpf_ops *)kdata)->flags =3D flags;

minor nit: I'd cast kdata/udate in the beginning of
the function to make the lines shorter and less verbose.
Similar to how bpf_tcp_ca_init_member() does it.

Acked-by: Alexei Starovoitov <ast@kernel.org>

