Return-Path: <linux-kselftest+bounces-9647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA5A8BEE62
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 22:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7421C21E59
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 20:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657A357887;
	Tue,  7 May 2024 20:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hivFTRQ1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAE6187353;
	Tue,  7 May 2024 20:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715115124; cv=none; b=T71EJlxTQ32EICOI4wQPRMrjQaV8JZOxT6Ol9INPan+PESGewiarOrQUdC95Hdi6GzYcMTxUXD4g9m4e/hxeVPLacq9giI14L2ZWnlwI+o43nDx3OF5ckvhWakuZ5FUBI1rRv7d5ShadMFlVXMRs3M7xHI0xrAA8y+xPgeVKzEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715115124; c=relaxed/simple;
	bh=b8UZ2RsJ1KvRwNE/4/qun7NqMNi9/Ak7SZwXxlqtD5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9pRjKyQiNn8dZmoasPGruBMpZlKQ5l9/Y9miIO3QCpTuF0v2y/N+VxxQrNi2OfX33dKUx1uSlyPEoreW1RUKTfBKtkJA3XI3JKhfMQRTpsOfeso6kc9E5zRI70XopSmQOn8tdAiqhqy8XoIUb06L4yY6S3rpWejjbETBsGIdRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hivFTRQ1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34f0e55787aso1973011f8f.2;
        Tue, 07 May 2024 13:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715115120; x=1715719920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdcR2a16esVT3UB13Wto/4zRmwQIrll7yYTlz1PQXa8=;
        b=hivFTRQ1huyE+NCd428B/jvRiaUVey7DtoY4duh1oTE/7nFH3Ke53YiZrFXCpeDLpo
         xwzhgDoPhnxA5OkXtVqFRyIZ6IZPoFGuMI73TpMzHxHRpcUxdVkrsX2fhTO9TY9YHVeB
         UI52nlJLt4vX5jCRL45dyHtyBaTkcidP3BKqYXcz4K+OTGK+VTRkpkAjRWihvJH7UdF7
         YSEeIS9m7/YG+1m+RH25SywwaCNovK+51E8IMhr0C8K+wXs9H42dp+ruDDb2zlsssr4u
         6OPBN2YR7Bf+Q83/cyS5qxO0u8gHMWdNE+7KN7blntCJ1nZ9iIfEtf4y+T7KYdzFcqYD
         21tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715115120; x=1715719920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdcR2a16esVT3UB13Wto/4zRmwQIrll7yYTlz1PQXa8=;
        b=J4beitXZdLy2O1OKoVaSZTWCadg+ncBVE4g0hIjbZjxDMP+jfEGGqL/oDHzCZC5AtA
         5aNWWfARRs6Q8olWkh3WdhX9eRCHDDZvvtMwRSQjp4pY47Y24ox6yVjcSi3SFQB4Fe8X
         ppOBXs2rGxl/w4QgNwACB6frtHWAqwWhMWUV6ds+R/OB5drohJ7RCrQ83B72/bZZk3Lv
         4h/npxjwDT6zPNDHhCCMBFuSrGaWMxtMjhG5jkSfYLEK9As4tKkk+BZ1rlZRxZrv1LDn
         HzeaSIF+w3ncufDcjP8HLs43hIqA2kS0rgaIsgEcNYWCp/ji/Gkb4anWqhhWl/6OzNMl
         q0dw==
X-Forwarded-Encrypted: i=1; AJvYcCWEAJjE1Igtb6yVqoA4DNawhh1E7OIMBldNEcaf7DF/oH4rY5lgA0NsdLBGkyEni29QbkF2kQ5NKugXT+palOJnB5n5hjCJNcleiLlVtWbl8zj/Yodh29+WzJ0zg9D9imlJkIBl7EIfJujAnFyUEgINS9ppNr+1qWk+UG8UkTb6MwsZlBO9ULB+UuTGqMUpliQpLkP2V/E8Md/l
X-Gm-Message-State: AOJu0YwomNR/mgfvLvQ3pX3Ad/R2DyWhjhsqBZ9OdGmVu93jfIhZO8la
	QEo6t7yPrYSV73rFwQsrnBUk6D4Dx7PSjCoEaJcI2dWgvIrKhfBMhd79WCZxM/rZLG6W0JO+6ZK
	FQSG1mJErpf3JCkN9GY3EHtkECJM=
X-Google-Smtp-Source: AGHT+IEupALi3YmwRAFNO89hfoLq5x2UZOxByq4dlLEg5tUq6l7C9/2mHmwsQr3MawIVxEWxb4cV0A1MmIur9qWOZgc=
X-Received: by 2002:a5d:6e55:0:b0:34a:3f3d:bb14 with SMTP id
 ffacd0b85a97d-34fca242709mr600329f8f.27.1715115119939; Tue, 07 May 2024
 13:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-0-e2bcbdf49857@kernel.org>
 <20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-2-e2bcbdf49857@kernel.org>
 <CAADnVQJ5-APFxMeGsUDSWBsiAbhJGivs=fBUapgYEFNHgnEVeA@mail.gmail.com> <d28dec16-9029-42f5-b979-a0f11656a991@kernel.org>
In-Reply-To: <d28dec16-9029-42f5-b979-a0f11656a991@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 May 2024 13:51:48 -0700
Message-ID: <CAADnVQJM73g9gTq3GxR-RMmpJPK3DGgzUTQiJXjz_B1G_4JAAw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: Add RUN_MPTCP_TEST macro
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 9:02=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> Hi Alexei,
>
> Thank you for the review!
>
> On 07/05/2024 16:44, Alexei Starovoitov wrote:
> > On Tue, May 7, 2024 at 3:53=E2=80=AFAM Matthieu Baerts (NGI0)
> > <matttbe@kernel.org> wrote:
> >>
> >> From: Geliang Tang <tanggeliang@kylinos.cn>
> >>
> >> Each MPTCP subtest tests test__start_subtest(suffix), then invokes
> >> test_suffix(). It makes sense to add a new macro RUN_MPTCP_TEST to
> >> simpolify the code.
> >>
> >> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> >> Reviewed-by: Mat Martineau <martineau@kernel.org>
> >> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >> ---
> >>  tools/testing/selftests/bpf/prog_tests/mptcp.c | 12 ++++++++----
> >>  1 file changed, 8 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/te=
sting/selftests/bpf/prog_tests/mptcp.c
> >> index baf976a7a1dd..9d1b255bb654 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> >> @@ -347,10 +347,14 @@ static void test_mptcpify(void)
> >>         close(cgroup_fd);
> >>  }
> >>
> >> +#define RUN_MPTCP_TEST(suffix)                                 \
> >> +do {                                                           \
> >> +       if (test__start_subtest(#suffix))                       \
> >> +               test_##suffix();                                \
> >> +} while (0)
> >
> > Please no.
> > Don't hide it behind macros.
>
> I understand, I'm personally not a big fan of hiding code being a macro
> too. This one saves only one line. Geliang added a few more tests in our
> tree [1], for a total of 9, so that's only saving 9 lines.
>
> Related to that, if you don't mind, Geliang also added another macro --
> MPTCP_SCHED_TEST -- for tests that are currently only in our tree [2]
> (not ready yet). We asked him to reduce the size of this macro to the
> minimum. We accepted it because it removed quite a lot of similar code
> with very small differences [3]. Do you think we should revert this
> modification too?

Yeah. Pls don't hide such things in macros.
Refactor into helper function in normal C.

But, what do you mean "in your tree" ?
That's your development tree and you plan to send all that
properly as patches to bpf-next someday?

>
> [1]
> https://github.com/multipath-tcp/mptcp_net-next/blob/4369d9cbd752e166961a=
c0db7f85886111606301/tools/testing/selftests/bpf/prog_tests/mptcp.c#L578-L5=
95
>
> [2]
> https://github.com/multipath-tcp/mptcp_net-next/blob/4369d9cbd752e166961a=
c0db7f85886111606301/tools/testing/selftests/bpf/prog_tests/mptcp.c#L559-L5=
76
>
> [3]
> https://lore.kernel.org/mptcp/cover.1713321357.git.tanggeliang@kylinos.cn=
/T/#m0b9c14f1cbae8653c6fd119f6b71d1797961d6ba
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>

