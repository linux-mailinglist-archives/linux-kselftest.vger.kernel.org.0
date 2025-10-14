Return-Path: <linux-kselftest+bounces-43141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58784BDB54F
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 22:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC724545F07
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 20:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EC0306D3D;
	Tue, 14 Oct 2025 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbWvl/km"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859DD2C17A3
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760475219; cv=none; b=HRAX4H7pYr/JyXVSchh+fofy8XqO4caheuq9iOdFxiscrHFDqk/OgVVX2URiWSdqVGDyLHybrbWwC+uu9KS0eBixNgKmXIY1F7cyFXsBczbVcu9mTBukyDVXxFjMKoSaUH61k70dQjfo1fSwFjlCPNEquIF3McudXzXHQwHNiOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760475219; c=relaxed/simple;
	bh=dv837vrFVMogKBGtHGCRm0l35AW5zlTrG2uNByHQlzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDKAVLHa0A9mxN0d0JZmjGXbM0CocJJRl5zpPO/dTT1dDSlHXAxVmjQXgi44Psats5PHQV43HpmoyrjSZ7WuISPXsPF4rGRbjiZGEdr0NUPEAd/39877triRtJ1gP9jfc89GH/tJp8TrWsZdJzCbOZe96MB6S2zGP8p2G6Y5nX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbWvl/km; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-26e68904f0eso60093515ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 13:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760475217; x=1761080017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiiBvqiVbmOprNrTHNzxR8EqrmW3MfBA/DWJoiFqf3U=;
        b=nbWvl/kmLsLqn2fIJuvqZbVJEAjqL6sys65w/izDzvnXQiZQzuFpsanuEU2tDpMnLz
         NyccADafCz9rJYvimX8jQL/Dr5D/RejMnyTBpVFIy1xbNLPRh1BQNHtzOdUT1HBFIxxA
         qwYHeb1inFuTRsn3nLx9ND7iX1MMrP2Y/Yun74mXIFWk+WpXOICmKSpK+7vO2mdu6CPn
         WPvxcDmzoS90bIw++SVIwnxddZLNO4DePAVMzd6oBelES/2Duz/WAShO1rvmLhSM2Cqt
         P3TWkwQQjZ9KYbEfxi84MxQRBPTAt6otaPiMj9cUwr+aMfJGhRPNuaMuulaZEvup+QYA
         aCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760475217; x=1761080017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiiBvqiVbmOprNrTHNzxR8EqrmW3MfBA/DWJoiFqf3U=;
        b=UaN0SEfDeDmnmfp+gZix5RvaKvere/7u+e8F3jS102VM50TAh9v3FpX2DY9us4qDRK
         JVPVUBZ5B6CQdOVgGsOiGLLvDJNY9zzI8jZHukB7NEOhGZTsobcHv8GOfbkNBDI0hHde
         HbSlsBuJ29Zs+AXkgbUUKh0FwzJ72LMAql6MBbyd7F1seP2bWsAHD6pCW1ohgm+oYDAc
         zx0tZQBCLg/CNvUwNjASXH/gT4E3ZRMd8zhbzRRasmff/y7vMAv4KoSH+pcAHLfhro82
         pYugWecza3iYxrU1OWBd0BldcjNkJZ8yMV6msuVmndhtliXtXfhSEGPxJlKfO1mDLYyx
         /jsg==
X-Forwarded-Encrypted: i=1; AJvYcCVahFCWRTdBElrY+6hlpXGvQ7gceFZcfM1Km5F/eN48qO6ZMxQ7TKFGRE4D59ljh9QcZ1kaGeyO9O0mleNT9Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKcXJwiN9Dt3N9p4KWrrdjNrKSIQysIK+fz4r1Q7WSAdWzquPX
	snYhfSBUQI77ln5VDJrn5CHGSMS+2AftPCgCCRQINcBennmzOc33JHyCeSKuNPN+hQBsooSFl5k
	v02gklhh+ymIHuX4TbuVKjLiKv986icA=
X-Gm-Gg: ASbGncuus9t/vls/48aVUgURYuinqIH13W/sCfFCD/tQ6Wu+iICgm9PklmIvOFYwIIC
	TfvsfvExcESqcrZ60ehXNHIJsrSn+QVqwWDdsoEV4RInayPI77TZuydzo9pqL3Ywu80uWbtsxhP
	g8NN7ud7Xm5GLVP74dAZ6EKgstAZSmWeEzVnBDwl8exsNrz7I2DOeLqPfY6Mdc6ajUf50gBOTRA
	jQik/KEKjN3inCe8ZG9ZpwNpxWzCnrpc+hZ25Yt+6sEaeaFCTbx
X-Google-Smtp-Source: AGHT+IElp/Dce+4CkY/m4dgJgfQpak6Q4BoFnRaoqVrBtzLR+SfjDpp1xNpd8+d0U5VYoDB8EzKrdCqtWQ/1GZkdxtA=
X-Received: by 2002:a17:903:1b4b:b0:267:da75:e0f with SMTP id
 d9443c01a7336-2902721334bmr320217585ad.11.1760475216691; Tue, 14 Oct 2025
 13:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014080323.1660391-1-higuoxing@gmail.com> <aO5EhTBn9Oq_MP2C@krava>
In-Reply-To: <aO5EhTBn9Oq_MP2C@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 14 Oct 2025 13:53:22 -0700
X-Gm-Features: AS18NWCEchD1LcVMiMBW40DEQAATVttOCLHSD1jk2iXukdiY0miP_PgMrAKg_Qs
Message-ID: <CAEf4BzZw_YJKdb4D6Vaj7Vg1koMGuKwcYuEbDvTn35i5tDYEug@mail.gmail.com>
Subject: Re: [PATCH] selftests: arg_parsing: Ensure data is flushed to disk
 before reading.
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Xing Guo <higuoxing@gmail.com>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, ast@kernel.org, sveiss@meta.com, 
	andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 5:39=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, Oct 14, 2025 at 04:03:23PM +0800, Xing Guo wrote:
> > Recently, I noticed a selftest failure in my local environment. The
> > test_parse_test_list_file writes some data to
> > /tmp/bpf_arg_parsing_test.XXXXXX and parse_test_list_file() will read
> > the data back.  However, after writing data to that file, we forget to
> > call fsync() and it's causing testing failure in my laptop.  This patch
> > helps fix it by adding the missing fsync() call.
> >
> > Signed-off-by: Xing Guo <higuoxing@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/arg_parsing.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/too=
ls/testing/selftests/bpf/prog_tests/arg_parsing.c
> > index bb143de68875..4f071943ffb0 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> > @@ -140,6 +140,7 @@ static void test_parse_test_list_file(void)
> >       fprintf(fp, "testA/subtest2\n");
> >       fprintf(fp, "testC_no_eof_newline");
> >       fflush(fp);
> > +     fsync(fd);
>
>
> could we just close the fp stream instead flushing it twice?
>
> maybe something like below, but not sure ferror will work
> after the fclose call
>
> jirka
>
>
> ---
> diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools=
/testing/selftests/bpf/prog_tests/arg_parsing.c
> index bb143de68875..5a4c1bca2a1e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> +++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> @@ -139,10 +139,10 @@ static void test_parse_test_list_file(void)
>         fprintf(fp, "testA/subtest # subtest duplicate\n");
>         fprintf(fp, "testA/subtest2\n");
>         fprintf(fp, "testC_no_eof_newline");
> -       fflush(fp);
> +       fclose(fp);

we should probably fclose() after ferror().

but the original fix works, though I think we should do fsync(fp)
instead to say within FILE-based APIs.

pw-bot: cr


>
>         if (!ASSERT_OK(ferror(fp), "prepare tmp"))
> -               goto out_fclose;
> +               goto out_remove;
>
>         init_test_filter_set(&set);
>
> @@ -160,8 +160,6 @@ static void test_parse_test_list_file(void)
>
>         free_test_filter_set(&set);
>
> -out_fclose:
> -       fclose(fp);
>  out_remove:
>         remove(tmpfile);
>  }

