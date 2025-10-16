Return-Path: <linux-kselftest+bounces-43273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E8FBE1475
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 04:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD5DF350094
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 02:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEF41AB6F1;
	Thu, 16 Oct 2025 02:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLQ27IFJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14885946C
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 02:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760581987; cv=none; b=H6izp5SFI2tnfER/CeAAliWx/U6WLO4fnkveQacm0Y29mRFknJQK4OyiX++f/CZr94U7m+sHLS3Lxo/ncuaRT6vfAW/hHsSSuXiTTHEVtVIhOTfSY+ouzxBgOus3YyDJ+RL/r7CV5pZIhU54m1Jol3z/3WqquehxwpmJT6OaS6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760581987; c=relaxed/simple;
	bh=F+SPc5GavxXWGdSVhfhZs5HKHwDQJm27pTpkyxfbKIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QKemctBssEUdlRNq0z/Wvwz2KQPC5boN2e39f9bYXtABtabTB+YXzh75nfIvV2bGxiXax+DZDcQHt570/R5rx31pY1uQgtvPLDkLejrCzpX7TYv+v5sIovId750haBnVL/PZk7S6x+EgS0OFKKdiY23cRTS6TpQd4tXppFsQmIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLQ27IFJ; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-650304a9e4cso101950eaf.3
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 19:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760581985; x=1761186785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNWcTy4xR1JOOLpvPDs36WVrv9lERjF5a5A+G+lBCZA=;
        b=FLQ27IFJgHoRphD7K7yX1/hMC098zn5Y5cilxTLvXcvNo0riaQ2eBeCCeSqCOXpadW
         vfZYgh6uVFo3WzGHHW37qRA+3UM/cHG1kUgA0RvGFJ/ON8b3Qrr9ta/0k6MDya3Gbwmu
         aiEeemb9ag4650+Il8W/xT7KUTVwp48P8fN7xOMGUEitevC3MaES+wNIU8a4igkHzBVO
         8xEWsjmCvtMliP1H0FVQzZEckfE4Hlfh+MkKZPeEIIlle5WRqDSyacTYd8CCl7i1Ux5B
         QNMgj3EHmpLKqgQ5UFIDmU06ISNFH2hHDT3Fg+kc4RI+X0kdHk/Mr64vh22uenWIHj9I
         K1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760581985; x=1761186785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNWcTy4xR1JOOLpvPDs36WVrv9lERjF5a5A+G+lBCZA=;
        b=fADDUE5GPTr/K0KE46fchxTKbWwmwX7bavyFD03wRUj1PlUKOv9m1vQKSk96VZKX7u
         vdgUJyY1iUzsgYpo0wVOhiVto1KTDBCoUs3gBQbhq0pEzk7fYJr9h0eASKhD+Jwej4p5
         cRR6iWhGoUy9Rruq47k/OviaeObxITT90ZyFHsoP3DMAfluItKxdyMEyUWZ2tmjwNyZT
         DHBJX0HbQWIs9MllRMD59TctIpdAMxasXjLdaTBfUBNv/edoxu23NZpgBlOkYnnToGGO
         imm0AwNlVZTWLfMmh7iU4u9TKdrbJ+wLMmN/60UKUtkEKGaAj2W9YN27vqGzOPQSn3rq
         t1dA==
X-Forwarded-Encrypted: i=1; AJvYcCXK92pTv9R0yv0fopGFmSsUvCUrBofU3gzqkFz4Old++ok2f/7ghDHEneGmJfnfmGtHeBVZ3x2cDoZDHJ04jYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYSaBelfD3YZ0hGMTZbix1Gg8pmZEDNskT083OKgUmnDzLClwh
	KrYeo2CF538VxNyjYUz29vXlEMQ6saKyZPUnH1iQ59SAVwMUaZ9CNP1TKEt7YhjudwpQXkIYQNc
	HDyEXo/np+1DssGl7rPEdXNqQYP7dzrRDflRFgcd+LQ==
X-Gm-Gg: ASbGncuMh5oXRIInPGsA66v/nM7lFTcIKCHE4HeIt8QHichuaM1ASwMrJwuDRg9lTP1
	be+POSSp+AFtzCZOsry1TYYP3Y/HKAksYjbwEhqXj3gbIMjr8EltD3LoiMHMmNu9/Wc3EqF1goc
	0SNJiNB/oG66iyO6VsGvLLd86gapKy81lo8eZuLAyRKw3d0l7CUNqhmfTh6qFzm14suD5TsB3b7
	9R4PqTG6gh5H/n3lHp+yH+m2ews7Qq0sbjO3JgqRx+5meXjlon9Ni1227UC8JLStO7Stds=
X-Google-Smtp-Source: AGHT+IF+O/5QL0QgiDjkhtOEpIr0iqku3f5Z/U6TAov0e076glnS2AzZo7UaiYoUn/cdNkI3kftKveHbzhf/uxcHARc=
X-Received: by 2002:a05:6870:264:b0:321:278a:1811 with SMTP id
 586e51a60fabf-3c0fac557b5mr15972017fac.45.1760581985044; Wed, 15 Oct 2025
 19:33:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQL8PWAqzfdaSYwn0JyX4_TBPWZmCunMn8ZRKJYwgb2KAQ@mail.gmail.com>
 <20251015025049.9492-1-higuoxing@gmail.com> <CAEf4BzaSPbsWGw9XiFq7qt7P0m0Yoquuxca39QrvorKFeS+LAg@mail.gmail.com>
In-Reply-To: <CAEf4BzaSPbsWGw9XiFq7qt7P0m0Yoquuxca39QrvorKFeS+LAg@mail.gmail.com>
From: Xing Guo <higuoxing@gmail.com>
Date: Thu, 16 Oct 2025 10:32:53 +0800
X-Gm-Features: AS18NWBYgEovx4J4h4xeHYM2TKTmjUsetKMmyFNty9V9DrZKsGgklcptteDqKUw
Message-ID: <CACpMh+B5bjbLKief_9-RtE-e_06WqKGuk-awoHHYfO_s3aYk0g@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: arg_parsing: Ensure data is flushed to disk
 before reading.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, olsajiri@gmail.com, 
	sveiss@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 12:20=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 14, 2025 at 7:50=E2=80=AFPM Xing Guo <higuoxing@gmail.com> wr=
ote:
> >
> > Recently, I noticed a selftest failure in my local environment. The
> > test_parse_test_list_file writes some data to
> > /tmp/bpf_arg_parsing_test.XXXXXX and parse_test_list_file() will read
> > the data back.  However, after writing data to that file, we forget to
> > call fsync() and it's causing testing failure in my laptop.  This patch
> > helps fix it by adding the missing fsync() call.
> >
> > Signed-off-by: Xing Guo <higuoxing@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/arg_parsing.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
>
> I accidentally applied it to bpf-next tree and had to drop it from there.
>
> It actually doesn't apply to bpf tree cleanly, so please rebase and resen=
d.
>
> But first, did you validate that fclose() actually fixes the issue for
> you? Because I don't think fclose() will call fsync(), will it?
> fclose() will basically do the same thing as should be done with
> fflush() anyways, so I have my doubts.

Thanks for pointing this out.  Adding fclose() resolves the issue on
my laptop too.
I prefer switching back to using fsync() according to your comment.

Best Regards,
Xing.

>
> Furthermore, your commit message doesn't correspond to your patch.
> There is no fsync() call here, please fix that as well.
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/too=
ls/testing/selftests/bpf/prog_tests/arg_parsing.c
> > index bb143de68875..0f99f06116ea 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> > @@ -140,9 +140,11 @@ static void test_parse_test_list_file(void)
> >         fprintf(fp, "testA/subtest2\n");
> >         fprintf(fp, "testC_no_eof_newline");
> >         fflush(fp);
> > -
> > -       if (!ASSERT_OK(ferror(fp), "prepare tmp"))
> > -               goto out_fclose;
> > +       if (!ASSERT_OK(ferror(fp), "prepare tmp")) {
> > +               fclose(fp);
> > +               goto out_remove;
> > +       }
> > +       fclose(fp);
> >
> >         init_test_filter_set(&set);
> >
> > @@ -160,8 +162,6 @@ static void test_parse_test_list_file(void)
> >
> >         free_test_filter_set(&set);
> >
> > -out_fclose:
> > -       fclose(fp);
> >  out_remove:
> >         remove(tmpfile);
> >  }
> > --
> > 2.51.0
> >

