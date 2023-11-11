Return-Path: <linux-kselftest+bounces-29-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADEA7E8C54
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Nov 2023 20:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E93F5B20A55
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Nov 2023 19:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD0E1CF90;
	Sat, 11 Nov 2023 19:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXAbuRlf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB291BDED
	for <linux-kselftest@vger.kernel.org>; Sat, 11 Nov 2023 19:23:39 +0000 (UTC)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843E73A85;
	Sat, 11 Nov 2023 11:23:38 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5c08c47c055so14899297b3.1;
        Sat, 11 Nov 2023 11:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699730617; x=1700335417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ag4SMwD5LPw+0jcsV3qgUuDPqlOWxdNIlowPaBbcuVo=;
        b=kXAbuRlfsfgIIy6rsS3QjBi1EoQDBOCialnW9lR5V4jlMKexTpBo6KZrRKUj3Ickbc
         JU9BvIMt5PvmgiX0McmkYh6HkwD5qHg+bjDRbqC7I/3dfpR8EAWMl9YcecTHRFUCFE42
         gadh163zpZxqKF1nPgU6uYMmBWUOs++B+trp+aZot/4uex/X7hjhs0DKlCKl16ZrJ6fu
         mWHF+t/9rd6Sc+Bfej2EsJQE0Q/LFJO/+MnKQvp799g9w61XR0SKUZSjb/CLLqMb+pSH
         pFpVrcx8X5j4WSydhcPdvLI8mlRLmGdVeBWj9n4qBMduyKZG2/ZrCEPNgQdh2qginlpI
         AXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699730617; x=1700335417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ag4SMwD5LPw+0jcsV3qgUuDPqlOWxdNIlowPaBbcuVo=;
        b=oHT/Z8hmG235aNGs1EJA98DiGfrfJplFrhf9bB49C1vcVIJIzGq7xEHUscBifCOxrK
         kvqjbOa5+uypDhctnKM0m75MMkEPHdEN2Z5er/smNxNC17o6lhz42Rh/W9ttsOc04ugd
         DTis1Fm9BXE98Xk4YxOdDXhjpwpZvC3GkIFmVnnAUnjlpVgRlF/nwrl+LbUDnPOVNXc6
         phZhUml1JZGzQVcMCNaCKjDR3IsV1yW7BVmfKFby4M60yrQIfFbZwOjeRHlua+WzTWKO
         hffWX4FmlPfUCy2jp+me5VJX+04NxBlqt6QJnGNMgictGXpmBDAc+iXICxQvoAsnwvvN
         +6wg==
X-Gm-Message-State: AOJu0Yyrmw8JxTz9R1yPoPe6gA4jTtOn6B9meHjGd8hRdcR8XiDWC+CC
	Ce8Zkg6iIyncYYdfAQvtZdmpR7KydCZeEjE29+u+kagVHME=
X-Google-Smtp-Source: AGHT+IGMWVLXhpBgAiSiPsJTx4nUCy4nqUL8/YMrfd1oVqT6RrSFrsQ3NogG4u5endsOynqU4DUelokF0fZ6kEQf7lo=
X-Received: by 2002:a81:d550:0:b0:5a7:e5de:79a4 with SMTP id
 l16-20020a81d550000000b005a7e5de79a4mr2769792ywj.17.1699730617220; Sat, 11
 Nov 2023 11:23:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230820141354.29687-1-osmtendev@gmail.com> <CAK6rUAO2hyt0tcXif=kbZj=vd4+O9h3o1quWSF2R6FMm70u_hA@mail.gmail.com>
In-Reply-To: <CAK6rUAO2hyt0tcXif=kbZj=vd4+O9h3o1quWSF2R6FMm70u_hA@mail.gmail.com>
From: Osama Muhammad <osmtendev@gmail.com>
Date: Sun, 12 Nov 2023 00:23:24 +0500
Message-ID: <CAK6rUANdzA9JNP-Aah+1LbPAdJwBn9Z2_ogDi5i1jE6q6vmWSg@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: prctl: Add prctl test for PR_GET_NAME
To: shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Oct 2023 at 21:01, Osama Muhammad <osmtendev@gmail.com> wrote:
>
> On Sun, 20 Aug 2023 at 19:14, Osama Muhammad <osmtendev@gmail.com> wrote:
> >
> > This patch covers the testing of PR_GET_NAME by
> > reading it's value from proc/self/task/pid/comm
> > and matching it with the value returned by PR_GET_NAME.
> > If the values are matched then it's successful, otherwise
> > it fails.
Hi Shuah,
Any Feedback on this patch.

Thanks,
Osama
>

> Any Feedback on this patch?
>
> >
> > changes since v1:
> >         - Handled fscanf,fopen error checking.
> >         - Defined MAX_PATH_LEN.
> >
> > Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
> > ---
> >  .../selftests/prctl/set-process-name.c        | 32 +++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/tools/testing/selftests/prctl/set-process-name.c b/tools/testing/selftests/prctl/set-process-name.c
> > index 3bc5e0e09..562f707ba 100644
> > --- a/tools/testing/selftests/prctl/set-process-name.c
> > +++ b/tools/testing/selftests/prctl/set-process-name.c
> > @@ -12,6 +12,7 @@
> >  #define CHANGE_NAME "changename"
> >  #define EMPTY_NAME ""
> >  #define TASK_COMM_LEN 16
> > +#define MAX_PATH_LEN 50
> >
> >  int set_name(char *name)
> >  {
> > @@ -47,6 +48,35 @@ int check_null_pointer(char *check_name)
> >         return res;
> >  }
> >
> > +int check_name(void)
> > +{
> > +
> > +       int pid;
> > +
> > +       pid = getpid();
> > +       FILE *fptr = NULL;
> > +       char path[MAX_PATH_LEN] = {};
> > +       char name[TASK_COMM_LEN] = {};
> > +       char output[TASK_COMM_LEN] = {};
> > +       int j;
> > +
> > +       j = snprintf(path, MAX_PATH_LEN, "/proc/self/task/%d/comm", pid);
> > +       fptr = fopen(path, "r");
> > +       if (!fptr)
> > +               return -EIO;
> > +
> > +       fscanf(fptr, "%s", output);
> > +       if (ferror(fptr))
> > +               return -EIO;
> > +
> > +       int res = prctl(PR_GET_NAME, name, NULL, NULL, NULL);
> > +
> > +       if (res < 0)
> > +               return -errno;
> > +
> > +       return !strcmp(output, name);
> > +}
> > +
> >  TEST(rename_process) {
> >
> >         EXPECT_GE(set_name(CHANGE_NAME), 0);
> > @@ -57,6 +87,8 @@ TEST(rename_process) {
> >
> >         EXPECT_GE(set_name(CHANGE_NAME), 0);
> >         EXPECT_LT(check_null_pointer(CHANGE_NAME), 0);
> > +
> > +       EXPECT_TRUE(check_name());
> >  }
> >
> >  TEST_HARNESS_MAIN
> > --
> > 2.34.1
> >

