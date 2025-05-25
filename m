Return-Path: <linux-kselftest+bounces-33755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 726C4AC3639
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 May 2025 20:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4CF9188FCC8
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 May 2025 18:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A161F8BC6;
	Sun, 25 May 2025 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5S9Yz4A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A364523D2A4;
	Sun, 25 May 2025 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748197613; cv=none; b=lrwWaV248ZdFMPjXZxzCoqJ06sq8+5U2C3XA89CHOQTet+PXLl5J6My0ejfxNnw+8l//zvDxJG6fNUv2Xn9Qnv8gSvPdQ+Uu2HJldw0D2SlzcWsALMuM9iAGc/sv6O+nJOKF4a+l9HYz4SAqPpapUTXqUo9dXPhITLgRNqJcirc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748197613; c=relaxed/simple;
	bh=Lp4APZVxa0/0BiLlhBNI1ETmFXHx8UAVaUVMg6qM4oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loyKZ/IcyfKJ9pq46EtV/ovDskNNnQYB1AJaT19+bK70J3tRaLsS6AzQbXttq/NOqIbdQ1pHN9fuuffm6F8hzrHYioMcloHsk2S/4JDUk2fLoCxaTkjY5cGdMoHaOMI+jqJANUPKWQZquXq/khkveWk12EeelRhhYFbG2Q3ofpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5S9Yz4A; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6f8cf00d96fso14860306d6.0;
        Sun, 25 May 2025 11:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748197610; x=1748802410; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3iQDuus6tHDjaYlJVgQfU6K3sGxod1e20Y6UqFJQz8E=;
        b=Q5S9Yz4Av0gt9NCGGb8eSGJYCdXhyhAqcjImmqxFiDraTQc64AOvNv8Dys/HtVxN4f
         6TpzJKpUY4bxbPrSDy/zQ1gurpkGhojq7vr5erFU1WLQDHs9lluP2fJcYJyIIKay3Tqq
         qa3lX/HsvawCEsgkj3Qoa4JymKWge98ZZmCNf8LRuCx9uvEJDsAR+gJOP+v1AXkhEe2W
         Hzk/diZVK8HNZ5Zi7WU6OQqmQxi6oB4CAiIsCuiRSMa4oMq0mhIgmwaBpZdFeOz2dnUv
         T2I5jeVdDuYXXbrewvRdM32dM629KCUZm4+lqWma5pxXe7XnED/eYdsus1qq1MfYs+/+
         ePhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748197610; x=1748802410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3iQDuus6tHDjaYlJVgQfU6K3sGxod1e20Y6UqFJQz8E=;
        b=h8yif2TIXWMttGWuYm5sigT4NvK3db0HvzvsbOSD+zsXuFg9MuK5GAfvqk7xb0X65m
         QgDvQE3iXXnMB4E3pgM/5ujHFXtbh9Y8TbAz9swDCBcJsfQGVncNFnQNpSUxDxiy8GWn
         7dt3J1wyjYt+dBQLwaeqsmq94E9BUc/jU5wHOg9gcQDoi0naPHj9bgjzVHrZiNjjqGQU
         iuo+iwd2hUx4/rszlH1LkKeQff4eAnjdVLkkcbA9akZxWeZOHTfpPgy2cCVH1SaFZYFE
         Yzv3zpk9zYpF61qkJzxTIPXsFQ/xGLC+5+LkBcloP4PjU61Cp7awlkbqMZuApbahNHY2
         z1Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUvuQlKBkoB0horrxLex4G5P1MF8QA4ZeygNrzahPTzFlKNc9fPeRL+SvEPRgoRo0gg4Ub4uYzEQA1NI5dVTae1@vger.kernel.org, AJvYcCVI1ZLQNvqMW1LQQnkg77o8+vgdfJN+clojrX73XBypSepGjZisg8kRw1SzmxY2uOlHUVvJX046aNelofA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ6nZbzcEDy8RTuRDbILpVrgzeWLpBMHErIPP84C/oievlapQt
	kgnLZg/w55ZEs+NOQkwWXz/Tf8BAL25XX84AXZCOX7R5aGu7DeEUuSiRoiTDA6sm1W/R7G5zeOC
	tPi3H2QPF4mcqj9gpM/2kcYGcvztbfKs=
X-Gm-Gg: ASbGncufufaJLiO/RSRxy9ChpvH1elBKsDxXi+Ma3FzBSSrkVNkJhEBM8gOrFhhkt38
	3OoogL9+bKZqcK4IXeAHMcPfg17CcCilA/J3GlCSy+H2IvHhUTFCmKO0KnxMFHRHVuFvno2uM5n
	U9xi7WOAoPC3dLcHq2DbGrdTjB/t/sogGkbySjMIsOnVlBsU+z+rKrzjUfgxolzQkC
X-Google-Smtp-Source: AGHT+IH/ciCbn34OAJnjEtsVPXlZMxHLOCNYfrbDPIJVqMMgLW3oTWLp5LliA1ycngh+GRJSBBjNNa948wlOeUzbXBU=
X-Received: by 2002:a05:6214:c27:b0:6fa:980d:528 with SMTP id
 6a1803df08f44-6fa9d15983dmr111569806d6.23.1748197610414; Sun, 25 May 2025
 11:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516153955.111815-1-embedkari167@gmail.com> <73a4b1c9-44b4-4f06-a766-ea7ed391c578@linuxfoundation.org>
In-Reply-To: <73a4b1c9-44b4-4f06-a766-ea7ed391c578@linuxfoundation.org>
From: Harshal Wadhwa <embedkari167@gmail.com>
Date: Sun, 25 May 2025 23:56:48 +0530
X-Gm-Features: AX0GCFvYMuOMlqQOBQdvGQ_5hOiN-rfQdg0Zgzfo8_JP-XwbcWnufmY5l3adJvQ
Message-ID: <CAPCCTVOXHUh7j6Vb=dmnY4wi37f4NMo+Pumuho-sA7jq1iH_fQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: firmware: Add details in error logging
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 May 2025 at 03:49, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 5/16/25 09:39, Harshal wrote:
> > Specify details in logs of failed cases
> >
> > Use die() instead of exit() when write to
> > sys_path fails
>
> Please explain why this change is needed?
>
> >
> > Signed-off-by: Harshal <embedkari167@gmail.com>
> > ---
> >   tools/testing/selftests/firmware/fw_namespace.c | 17 +++++++++--------
> >   1 file changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/testing/selftests/firmware/fw_namespace.c b/tools/testing/selftests/firmware/fw_namespace.c
> > index 04757dc7e546..deff7f57b694 100644
> > --- a/tools/testing/selftests/firmware/fw_namespace.c
> > +++ b/tools/testing/selftests/firmware/fw_namespace.c
> > @@ -38,10 +38,11 @@ static void trigger_fw(const char *fw_name, const char *sys_path)
> >
> >       fd = open(sys_path, O_WRONLY);
> >       if (fd < 0)
> > -             die("open failed: %s\n",
> > +             die("open of sys_path failed: %s\n",
> >                   strerror(errno));
> >       if (write(fd, fw_name, strlen(fw_name)) != strlen(fw_name))
> > -             exit(EXIT_FAILURE);
> > +             die("write to sys_path failed: %s\n",
> > +                 strerror(errno));
>
> Hmm. Wrapper scripts key off of the EXIT_FAILURE - how does
> the output change with this change?

In the whole test file, all fail cases uses die() with the specified
error log and error code, so just wanted to add a error log for this
fault condition and maintain consistency.
> >       close(fd);
> >   }
> >
> > @@ -52,10 +53,10 @@ static void setup_fw(const char *fw_path)
> >
> >       fd = open(fw_path, O_WRONLY | O_CREAT, 0600);
> >       if (fd < 0)
> > -             die("open failed: %s\n",
> > +             die("open of firmware file failed: %s\n",
> >                   strerror(errno));
> >       if (write(fd, fw, sizeof(fw) -1) != sizeof(fw) -1)
> > -             die("write failed: %s\n",
> > +             die("write to firmware file failed: %s\n",
> >                   strerror(errno));
> >       close(fd);
> >   }
> > @@ -66,7 +67,7 @@ static bool test_fw_in_ns(const char *fw_name, const char *sys_path, bool block_
> >
> >       if (block_fw_in_parent_ns)
> >               if (mount("test", "/lib/firmware", "tmpfs", MS_RDONLY, NULL) == -1)
> > -                     die("blocking firmware in parent ns failed\n");
> > +                     die("blocking firmware in parent namespace failed\n");
> >
> >       child = fork();
> >       if (child == -1) {
> > @@ -99,11 +100,11 @@ static bool test_fw_in_ns(const char *fw_name, const char *sys_path, bool block_
> >                       strerror(errno));
> >       }
> >       if (mount(NULL, "/", NULL, MS_SLAVE|MS_REC, NULL) == -1)
> > -             die("remount root in child ns failed\n");
> > +             die("remount root in child namespace failed\n");
> >
> >       if (!block_fw_in_parent_ns) {
> >               if (mount("test", "/lib/firmware", "tmpfs", MS_RDONLY, NULL) == -1)
> > -                     die("blocking firmware in child ns failed\n");
> > +                     die("blocking firmware in child namespace failed\n");
> >       } else
> >               umount("/lib/firmware");
> >
> > @@ -129,8 +130,8 @@ int main(int argc, char **argv)
> >               die("error: failed to build full fw_path\n");
> >
> >       setup_fw(fw_path);
> > -
> >       setvbuf(stdout, NULL, _IONBF, 0);
> > +
> >       /* Positive case: firmware in PID1 mount namespace */
> >       printf("Testing with firmware in parent namespace (assumed to be same file system as PID1)\n");
> >       if (!test_fw_in_ns(fw_name, sys_path, false))
>
> The rest look fine.
>
> thanks,
> -- Shuah
>

