Return-Path: <linux-kselftest+bounces-45022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CAEC3CC87
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 18:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C37D4EEE8F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 17:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305A72D8364;
	Thu,  6 Nov 2025 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eA/qHfi9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A22934E751
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449357; cv=none; b=a1ct95ulLWJzwkcZDReS9yYNEK8eN26fUtQ2oLaBnu9+1k1lHLDW5cvPsdRunFwSnxABEw7Rh13OgVJS4EwvoYYoJ49+kpMFW4fFD/lehzOKanaUEMMoocgv8m+pfue0YeuDzGybvMwvxbcHMXXrCOSH8evrn4U/P5eG+S3F564=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449357; c=relaxed/simple;
	bh=H2cS17IPARzauQUtP+qWzfi7eoIsYAbWRbTvkXZaQTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/A8vjherB2TA3RCO0W32O+3o+jzV3tBRIDw5AIlhZr7oi+fUKClTF8b4WW4C5eYnD/5Mtr6YhjHwYaFyHoRdGhvccRWnMGga+xjG/bzlt2SW/2wMwckqFHNBNQrVKd+lcU3VHxAhRm4X09DOW7fRXCCLOXU7YG8eB9bBoSwFv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eA/qHfi9; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-429b7ba208eso760295f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 09:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762449354; x=1763054154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blWgJL5IxiaRL16DgffEZwhTofGP5Amd3llZBVcR6wg=;
        b=eA/qHfi9Jq8NpptxUxpaAL7fU1dAuDBcsbsYZjsECV0pqx5Alx9HVq42E76RtZeRJQ
         OO59BPCfggs0+XIopTU2CYLQwj7gQLpbdUWBoIg4wwnAA7HfxFY6hoajg6hnU0BnEWoF
         FAqs1CRyqchrplgrrRg9SJ1/npAMxe8Ln9wYlH8ecZzhadjCXkpT+1hsCfcTT9JZPkYW
         piug8OOONU7UjG6Z2VoeWMeLMfrGjDDSg0f5C7oUU4XhwQ+lHLojTWSg7gaP07+JJ7My
         Z2uxjqUO6DT7dNC1bI4LyrXE2mmVAfnJ10V9vNcDJVJVJBmZHhTUznpC/en67AVtf7/i
         mWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762449354; x=1763054154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blWgJL5IxiaRL16DgffEZwhTofGP5Amd3llZBVcR6wg=;
        b=DIU+aeN8ZzEu1kJYKEkrGKNx4LVSoeZ2gqbt6Bqkke35A4czadXMmtav0l2jokJRL8
         pJCGUuXTEy42qGN93XvD2X/U7gZNi9ppBw7f0GYb8fhkje6XncKE+LU06LnnCDad0EBM
         YhFaQJZghB1/aD+3KFSzW+u8RWkc40rZ446wFbeyMzA0nCgpU2cz1sHR2++fx3Cf/jwW
         CXLOEa375ajtRVJMmXKJ3PkaDnuANdb6mobGop15WtWVXckDXmg6U9BBsD7zzJzlB6tF
         YSBkto/fZgLav0uF5yz6UeqFvyA5TTgSZYveDC3m+QeJN6k9ejTKu5CNP5LGlKcjv/vn
         2fXA==
X-Forwarded-Encrypted: i=1; AJvYcCXxvogqUJzk/JzdXLWiOxiaXydHBuxaURS3YzfsyLIvSsW6KMhtG9bj09PpatpB3cjOuJZO+W0lcePJ2H3nyzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5OQ1tSVIXoQ96KOUNsEOqTn2UEQsYbHu7WD2CfyK3kbqQlNKf
	/uEqY72B6EVwWQg94VzvRagJjjLE0woIY+YrWhsLCBCLbo0xdfBMkrl8gC45T+osyFpjdRrJogg
	c2vfv3SrADYSEjLAG/x2NM1Fdsf7GagE=
X-Gm-Gg: ASbGncvV/3MRygzOQmRdRCn6TmN1gtP7ydpoG7oI/rFClfppXeAZrxyZ0mK1hA/u58z
	m8s/GoTDRiV2L0HB58n7C1pphCj4VKjknCn+2Zj+89DJsm2/D48wpX9mUuypBELbfAfWdZ2s5l7
	UiDDLNgYXsHcWtVODSVQwOI3NdJRUdv/Fqy99W/WwUelEwendHtWmQGdV9GN9He18ZRRkIrEAL2
	azUv9fMQMbK28TEfIf1rsILnnvdz+Ixjp7HNFLU15F1h8YbcOlLfiowWDLz1KBc8MuOTmElP//q
	/VHIdoWYd9w=
X-Google-Smtp-Source: AGHT+IEkK0dq7MPy5gKtDs3GydYbk6HCGOnP+RQCC45EaWNnFendOZxIEe/PmbwzRNoV29lOxJ6e1gwjudaVlKrYwUg=
X-Received: by 2002:a05:6000:402b:b0:401:5ad1:682 with SMTP id
 ffacd0b85a97d-429e32e3662mr6502221f8f.14.1762449353513; Thu, 06 Nov 2025
 09:15:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106052628.349117-1-skb99@linux.ibm.com>
In-Reply-To: <20251106052628.349117-1-skb99@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 6 Nov 2025 09:15:39 -0800
X-Gm-Features: AWmQ_bmSdrU6gIkuTnrWchxD2V9GU7o86PagWBY2wUCtwzPV40XsTw0vi6aljfo
Message-ID: <CAADnVQL3njbb3ANFkDWYRC-EHqAqWSwYs4OSUeKiw4XOYa+UNQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix htab_update/reenter_update
 selftest failure
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Hari Bathini <hbathini@linux.ibm.com>, sachinpb@linux.ibm.com, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 9:26=E2=80=AFPM Saket Kumar Bhaskar <skb99@linux.ibm=
.com> wrote:
>
> Since commit 31158ad02ddb ("rqspinlock: Add deadlock detection and recove=
ry")
> the updated path on re-entrancy now reports deadlock via
> -EDEADLK instead of the previous -EBUSY.
>
> The selftest is updated to align with expected errno
> with the kernel=E2=80=99s current behavior.
>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/htab_update.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/htab_update.c b/tools=
/testing/selftests/bpf/prog_tests/htab_update.c
> index 2bc85f4814f4..98d52bb1446f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/htab_update.c
> +++ b/tools/testing/selftests/bpf/prog_tests/htab_update.c
> @@ -40,7 +40,7 @@ static void test_reenter_update(void)
>         if (!ASSERT_OK(err, "add element"))
>                 goto out;
>
> -       ASSERT_EQ(skel->bss->update_err, -EBUSY, "no reentrancy");
> +       ASSERT_EQ(skel->bss->update_err, -EDEADLK, "no reentrancy");

Makes sense, but looks like the test was broken for quite some time.
It fails with
        /* lookup_elem_raw() may be inlined and find_kernel_btf_id()
will return -ESRCH */
        bpf_program__set_autoload(skel->progs.lookup_elem_raw, true);
        err =3D htab_update__load(skel);
        if (!ASSERT_TRUE(!err || err =3D=3D -ESRCH, "htab_update__load") ||=
 err)

before reaching deadlk check.
Pls make it more robust.
__pcpu_freelist_pop() might be better alternative then lookup_elem_raw().

pw-bot: cr

