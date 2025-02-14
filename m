Return-Path: <linux-kselftest+bounces-26699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF0AA36940
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 00:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD8347A2DE6
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 23:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149F91FDA62;
	Fri, 14 Feb 2025 23:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kajmdMsV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770F11922DE
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Feb 2025 23:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577554; cv=none; b=iddDVeh10d1/dt5vy1m5rEsqgsxk/OCWwjC87VmVXlc+PguDiPiETS2JZqyldMI5/5Rx/oewb7pMcHG8EbRTmebstxeoHsnK3cyTT01EhfPSIYy7QaP7bKJT7Xpx6VIHxgwvKkBHf0j3lwsXlSjNd6CiJL/gcrkdFJNhp1d84k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577554; c=relaxed/simple;
	bh=IKcfaSOrlMa6rik07ZTuSV19i8nzB/MkDugkDm7vSQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WED5liTSvpTHglzlCRWJObRmEswULsXjnB9esXg9p0GMF/lHDfVTbTvvZxSsLL5jhRx9vs2zWuYwKu3OHoDDoEAuhDoCJvyKCnnU2LfuP6UoqvY0/+9xweF5JYofarJjhuKNeU5DdwCZ9Z5AUURzB2+WBQLN5KTKNj5lKOZn4wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kajmdMsV; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5fc13355a5bso1238681eaf.3
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Feb 2025 15:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577551; x=1740182351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsZMzchGA3QydeH+K1fYzv4GOzw024lMC2SpfQz9ljU=;
        b=kajmdMsVIGuuNymJUuP72J28RuqvR1gIvMoz0RWaYXVSrcjvDesmx8prENnbTdvQh/
         f0bQ3z4/ONVr7SizswV6BM6shcW/ZWmH1dr2bJ3BTxkydIaCSZW3bm6JVGRHD8pwDhuQ
         20vS8n4na/ZqW+58cUB/4SIcsR6GlGFnQXMnKXEIc+vkhrrgklJ1v/DMiWcqecSNGIG1
         vZcVM91CMJqFNbn/xhMK7lR8FOjYqY6tcI7bv5kfOu4IIZ3UXkFjt6wvmsgoymrZaPKj
         N8I6j/HJAem7RwMMUh9kFIlndzaiAffwBCOvcs14cEs917ndUKXTOnYJe5sbXzA8Pm3J
         yI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577551; x=1740182351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsZMzchGA3QydeH+K1fYzv4GOzw024lMC2SpfQz9ljU=;
        b=hmSiNCExzQtzC6yg4OiAM7qvCagZG+S5Px2JhA+S41uWrjsf4rAI0g85BQ6aGLJkVa
         9E4+vPTnpAmn2mO6NHeXNb+ZEVK6v8hVOic+QOvnFwB6VlOSswTSiyFjpUqTnZ63qjrM
         TlcuH+Uk09YkocdK7qzxqrA+rDa4r4a3fo6IGGMIeSw+UaqP9eg4OgBaaFtDpC+jzjs/
         eHvRUo0LQw99V7bN8VUQ1ugR1ZRI59vrVV8tjncU5m5gsNZhtcU0vjAtnDR+a5f1Mk/S
         rMfyNvd3Np84KTllmeykLzqj+3976cQquyvwrBnT7WmgEO/uIVn8+L9+KcDsBjFxwj3C
         mDEw==
X-Forwarded-Encrypted: i=1; AJvYcCV2KcuHfWH35L4Hp77FcxM7/zZMmy0FDy1pkW6BVP0jp/5uNH978fXUaERiVi0k89hbfdsfJBUATmFaYYmnlzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuEGb/YD/sr5lrfcd7SI/y1muTfDwy0EQTdM+kglRXrd6v50cD
	lGmK5EcI3zacG7nImIazM0HHsssOF4E4Z+Q07GpfEo819F8oklevH1NOMdYmqdFl5BltfTQTytZ
	pXDr+8Wb4J71wud53YLsnrwoH4Tip+bI1
X-Gm-Gg: ASbGnctQ9mn2HzUyAokTnuAeURv+wnYDn5FuMf4CJyWN1+/61Aooh/Rcvw/QC2VEvU3
	sEoXgfvg9Q3nq3quraxFOIrPpd8iv+T5w6OabMnyQ1exi0894PHCX25Wrh63W04WjKWz3iSsqS1
	sNsB8+mhm0
X-Google-Smtp-Source: AGHT+IFDXsqXU7nxemKQ8UIjtO9+R4SjmrFn6EBErejTxGhpg2uKqfKRuG7esuN5AHZPiwJLPxeD8KGNq9/4re5xzHM=
X-Received: by 2002:a05:6871:8792:b0:2b8:69:6016 with SMTP id
 586e51a60fabf-2bc99d3fd2bmr612329fac.28.1739577551458; Fri, 14 Feb 2025
 15:59:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213212858.710884-1-marcelomoreira1905@gmail.com> <MW5PR13MB56323A7DE07549AC6F7664AAFDFF2@MW5PR13MB5632.namprd13.prod.outlook.com>
In-Reply-To: <MW5PR13MB56323A7DE07549AC6F7664AAFDFF2@MW5PR13MB5632.namprd13.prod.outlook.com>
From: Marcelo Moreira <marcelomoreira1905@gmail.com>
Date: Fri, 14 Feb 2025 20:59:00 -0300
X-Gm-Features: AWEUYZkx1Vcgg2RvapSKHjauHh61L03etyMd--xgqDolH7S2Fg0OS24Srv-QYhM
Message-ID: <CAPZ3m_japqSAMG8svC4JWd8UAHRVnJ7ujCsSxZe0i+4b69c8mA@mail.gmail.com>
Subject: Re: [PATCH] Adds colors to kselftest output
To: "Bird, Tim" <Tim.Bird@sony.com>
Cc: "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, 
	"linux-kernel-mentees@lists.linux.dev" <linux-kernel-mentees@lists.linux.dev>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"martineau@kernel.org" <martineau@kernel.org>, 
	"~lkcamp/patches@lists.sr.ht" <~lkcamp/patches@lists.sr.ht>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Guys, sorry about that. For some reason when I run sudo make kselftest
the colors don't show up, but if I run the test alone, the colors do
show up, like this: sudo
tools/testing/selftests/net/mptcp/mptcp_join.sh

I've tried sudo TERM=3Dxterm-256color make kselftest ; sudo make kselftest =
| cat ;

but it didn't work.

Anyway, thanks a lot for the feedback, time and patience :D


Em qui., 13 de fev. de 2025 =C3=A0s 20:31, Bird, Tim <Tim.Bird@sony.com> es=
creveu:
>
> > -----Original Message-----
> > From: Marcelo Moreira <marcelomoreira1905@gmail.com>
> > This commit improves the readability of kselftest results by adding
> > ANSI color codes to the [ OK ] and FAIL messages.
> >
> > Signed-off-by: Marcelo Moreira <marcelomoreira1905@gmail.com>
> > ---
> >  tools/testing/selftests/net/mptcp/mptcp_lib.sh | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_lib.sh
> > index 051e289d7967..7b55855ff788 100644
> > --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > @@ -83,7 +83,7 @@ mptcp_lib_print_err() {
> >
> >  # shellcheck disable=3DSC2120 # parameters are optional
> >  mptcp_lib_pr_ok() {
> > -     mptcp_lib_print_ok "[ OK ]${1:+ ${*}}"
> > +     mptcp_lib_print_ok "\033[32m[ OK ]\033[0m${1:+ ${*}}"
> >  }
>
> This should not be done unconditionally, but based on the controlling
> and COLOR variables for this library.  You should also re-used the existi=
ng
> color print helper function.
>
> IOW, why is this not using MPTCP_LIB_COLOR_GREEN?
> or the helper function mptcp_lib_print_color()?
>
> >  mptcp_lib_pr_skip() {
> > @@ -97,7 +97,7 @@ mptcp_lib_pr_fail() {
> >               title=3D"IGNO"
> >               cmt=3D" (flaky)"
> >       else
> > -             title=3D"FAIL"
> > +             title=3D"\033[31mFAIL\033[0m"
>
> Why not use the helper function and the MPTCP_LIB_COLOR_RED here?
>
>  -- Tim
>

