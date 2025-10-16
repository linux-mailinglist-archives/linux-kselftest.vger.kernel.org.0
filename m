Return-Path: <linux-kselftest+bounces-43342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C929ABE49C1
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 18:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CBC64051B0
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 16:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B60531D750;
	Thu, 16 Oct 2025 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiOzHBmv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B38032D0CA
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632620; cv=none; b=bSQI8p1P4eMny1KIr163JWxXMMD6q3AwccUlU5zqZS/jhNXDy0Ty8YLX0JjQkAptXj2PXBLqToKrdOKBXSsUGLrUKbKZuHXNpfKhHc0pyVen1jyHJ9vMcDDeqrt9R256lAuVUrn7geFuO6VjkwZmzwjnzJ2xArTLBSSqs7X4CVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632620; c=relaxed/simple;
	bh=R+TmdbdFcByyR8U2OeOUMQReG8RavVd6Am6yeRrUOuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMeaSLrAe+WOtvg39vEe1Z7UJLKeyh3S6smeviLtWyQhAq5jkqp5QWkcKq8/Fts/BihuMHIXRHYVGbBHou496TnA93HnqRJxmXlZivjvkoI3ZGu2Pr/MkxAHZ9oTeNJSfxA4nIO76RJwdxxMRDKqY1WvjfcfsyzvaYuScXuYpzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiOzHBmv; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-78f3bfe3f69so929591b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 09:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760632618; x=1761237418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFn3CxIRAg7TBQF7TKjze6YhjZQwRMlhpuXzgCf3Zco=;
        b=XiOzHBmv3ecamlyqBoD9+qWdO+mDgw2tBi7+g6pTyX7KztyH9ndY1Dsu3Zh2J23YcE
         vmeLCuVFa9bdrXcSoNf+48Fsn5wQTckrTuGRCWLbRIIHbt+wA6f3Ny21L6nnAmy4q9Aa
         uCV7dOMjKZ9H507WyzJL3v55sUPQgb/80fu0jbPZtbyR5eSXYJ/300V/XtkTftRSCCXS
         cPzdFKYEypKPNnw2nV26S7hTcbhp+CN1ZcPflihSZkZFNZg2aMFrkyCwkU0FT7ukcwVg
         eVLtj6AD14Rtk+Ri+ChV2DPSsA1kLnFh7+Abz4AiaEV4dAl0yuDJcjEkHUKbwrgNkNdn
         0elA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760632618; x=1761237418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFn3CxIRAg7TBQF7TKjze6YhjZQwRMlhpuXzgCf3Zco=;
        b=h9f53c4hUAUPIddkQWLl4duxDH6PQVkA8Jw5LdjU4tF++OTv3GVmlAlC9ehxDCpUTt
         4ayJakL3eqQNQiIFjRdsycVGMp7mrqLKnvOCN3XrREuH5mCbbpjk6UXJFSedGC5C3bEm
         6kqYr7ynI63B0pR83P04FaMFmcWrsbc3WY8k+JWRG9FA4CpQMryq36QJ1oJnQRezO43P
         VKOFeOB2GEhMwhflydjpK7u56WSjUC4Tob0RIF05uwVYsaiS0vsuUpyTN/veLSP62qYt
         TWKafVpQAa+ilwAXXO/4/oeLuQsf15HRM4mpNpehMp0Dw/mDGrW8kYBqQ4X8wVObB8wO
         epgw==
X-Forwarded-Encrypted: i=1; AJvYcCUloDVnqoYcnHDNfHXiB0pe/VApAY8LGOg/PuKbofT05NVPwbFBjbXSykvWna+aeKVTRuNm/+28KizNednmNWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIR+ifIlSIFPr8xH0HfsZwzGVKg1jDzYFXlZhBU/jSDK9cCUBE
	wcFf6P6cd6V41nI0HYZy2F2njWi9gAoPFxW+68SxrjFP30PxwnKkEyohjft4C13M0NksgO4UAan
	xXY/w02SPERZI6OkemUcSQJA/OXnNWog=
X-Gm-Gg: ASbGnctJNqxxFQ1rCZY7lYj+7VFQxvjgAHvjJMG2GdwD2QKqe1CMVWw52z0HTyNWBqE
	IHj6fAdURqrwmzsCQyH5PKOdy9Q0H0qkXFgcWfXlk59dHQ99u26sORLA+2C/KboFVD2BPuYF0dJ
	oC7XC0VaslsRXeh/wnSF0Br894oEcnhysdWDO90nJK9HdtFwGQm0Jm0ovDCXo6zfYYoWCmM7YAv
	4rd5fUlfRQ31t0Sx337morbZIuUSpl3i00scWSQtJUaFccexX+cEvp12AtJpL1DtukY8P/8jbx4
X-Google-Smtp-Source: AGHT+IG4Pi7+5kQaId3168O2QuS6sO1obTUjZYf1MfpJ7lJKxUT2dFX5euSiQERud9lKX8hESnvYvmCDV4ltJEyaoQ0=
X-Received: by 2002:a05:6a20:12c9:b0:2ea:41f1:d54a with SMTP id
 adf61e73a8af0-334a862e49cmr754323637.55.1760632618018; Thu, 16 Oct 2025
 09:36:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzaSPbsWGw9XiFq7qt7P0m0Yoquuxca39QrvorKFeS+LAg@mail.gmail.com>
 <20251016035330.3217145-1-higuoxing@gmail.com>
In-Reply-To: <20251016035330.3217145-1-higuoxing@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Oct 2025 09:36:44 -0700
X-Gm-Features: AS18NWCD1B8sBmTDmPEqjvwbEypUX3tay_n3fTnUJgZ8sEXeKcejJDl53myxC5c
Message-ID: <CAEf4Bza6ynjUHanEEqQZ_mke3oBCzSitxBt9Jb5tx8rxt8q4vg@mail.gmail.com>
Subject: Re: [PATCH bpf v6] selftests: arg_parsing: Ensure data is flushed to
 disk before reading.
To: Xing Guo <higuoxing@gmail.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, olsajiri@gmail.com, 
	sveiss@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 8:53=E2=80=AFPM Xing Guo <higuoxing@gmail.com> wrot=
e:
>
> test_parse_test_list_file writes some data to
> /tmp/bpf_arg_parsing_test.XXXXXX and parse_test_list_file() will read
> the data back.  However, after writing data to that file, we forget to
> call fsync() and it's causing testing failure in my laptop.  This patch
> helps fix it by adding the missing fsync() call.
>
> Fixes: 64276f01dce8 ("selftests/bpf: Test_progs can read test lists from =
file")
> Signed-off-by: Xing Guo <higuoxing@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/arg_parsing.c | 3 +++
>  1 file changed, 3 insertions(+)
>

applied to bpf, thanks!

Given you can reproduce this issue locally, do you mind capturing
strace log before the fix, with fsync fix, and also with fclose, which
you say also fixes the issue. But that makes little sense to me, so
I'd like to compare what's going on at syscall level to try to get
some idea. Thanks!

> diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools=
/testing/selftests/bpf/prog_tests/arg_parsing.c
> index fbf0d9c2f58b..e27d66b75fb1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> +++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> @@ -144,6 +144,9 @@ static void test_parse_test_list_file(void)
>         if (!ASSERT_OK(ferror(fp), "prepare tmp"))
>                 goto out_fclose;
>
> +       if (!ASSERT_OK(fsync(fileno(fp)), "fsync tmp"))
> +               goto out_fclose;
> +
>         init_test_filter_set(&set);
>
>         if (!ASSERT_OK(parse_test_list_file(tmpfile, &set, true), "parse =
file"))
> --
> 2.51.0
>

