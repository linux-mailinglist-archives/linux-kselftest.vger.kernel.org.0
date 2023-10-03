Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AC97B6DE6
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Oct 2023 18:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240253AbjJCQB6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Oct 2023 12:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240272AbjJCQBy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Oct 2023 12:01:54 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B360BFF;
        Tue,  3 Oct 2023 09:01:43 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-65afd746330so6746866d6.3;
        Tue, 03 Oct 2023 09:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696348902; x=1696953702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Yn+mPkDWk8ukHdhjqSSwg4e6I5pgHCsv8e3oIaemCg=;
        b=UeuubfjOQDD7Twk7b21RnDZ3i8SAHZ7UHmUPVGiG31jxj5Gvcgis81YAkG5Es693kZ
         UC2tBnj6nmkaf18JMkqiPlL+8F+T15MyQj4e3wMhNm5FPbAaeCvxQnkvOIJJZJyGhEDG
         JpjO72HvSZqgV28CEgld8+AzKcuifds+XYRRiLnzQq/N7nxHpisTo4m4Qscjxvum5UA+
         6VvJKT26a+SVfS0Pw86oRe8PAVXsQ93MoetWV5Oei84iAEyELuwOTYJ6wyIfUynPjXTR
         tRVAOAWL8JkQFdHDbHptZJI6puIKmUhdaBQp9aVAWhxHZAibnwJSGJY1BaqWBcG1XmPY
         eK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696348902; x=1696953702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Yn+mPkDWk8ukHdhjqSSwg4e6I5pgHCsv8e3oIaemCg=;
        b=gHMxdRC3Q5WPC64iHkbx4pHnqD2aK7G2TPXnjdaBdGTdOWeeeBmchdMBhRL+6fT6qH
         r/+DbFV+ypor3zBV30HN9gGM4caVN/uKG+o5ZfpeVqcDOYR+UgK/QZNqzIPcD/n9n3w3
         9L0zI4B+otbE64RZD31f7b4MRoK8bA51GWnZXVi3fOF604usbrtb5GOgwGZMNGeTE8eH
         X8o7NRNXbVfeZx8WVBr86+gRNbbOhJAShtP+0SGg7wGuLuR8EFHL4OVGI82DWNgeN5aA
         /ILYg2xz0C3isfeWM2HBsEIO1vVVnSK38A2sJJi/Hya4m4R3e9qfhxgKvGHW+ObXcuZj
         T9HA==
X-Gm-Message-State: AOJu0YzSpcf45kGOiE3GiPqYt7cWiVDGNQgS03ZDcoxa6zJBJU7GFhBI
        ocr+qb/0pZBYdQQvXM7ZHfVNi1fNumrD247gIyU=
X-Google-Smtp-Source: AGHT+IE40Wp2mYMdsH3mhinRxqTHhWvxUVnr8uEjAb68JoUzKmcI9syXU2mK2Ygisr2EqbHDyE6+qDRX8OUcWKKC3GA=
X-Received: by 2002:a0c:db14:0:b0:656:3352:832f with SMTP id
 d20-20020a0cdb14000000b006563352832fmr14086949qvk.32.1696348902101; Tue, 03
 Oct 2023 09:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230820141354.29687-1-osmtendev@gmail.com>
In-Reply-To: <20230820141354.29687-1-osmtendev@gmail.com>
From:   Osama Muhammad <osmtendev@gmail.com>
Date:   Tue, 3 Oct 2023 21:01:31 +0500
Message-ID: <CAK6rUAO2hyt0tcXif=kbZj=vd4+O9h3o1quWSF2R6FMm70u_hA@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: prctl: Add prctl test for PR_GET_NAME
To:     shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, 20 Aug 2023 at 19:14, Osama Muhammad <osmtendev@gmail.com> wrote:
>
> This patch covers the testing of PR_GET_NAME by
> reading it's value from proc/self/task/pid/comm
> and matching it with the value returned by PR_GET_NAME.
> If the values are matched then it's successful, otherwise
> it fails.

Any Feedback on this patch?

>
> changes since v1:
>         - Handled fscanf,fopen error checking.
>         - Defined MAX_PATH_LEN.
>
> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
> ---
>  .../selftests/prctl/set-process-name.c        | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/tools/testing/selftests/prctl/set-process-name.c b/tools/testing/selftests/prctl/set-process-name.c
> index 3bc5e0e09..562f707ba 100644
> --- a/tools/testing/selftests/prctl/set-process-name.c
> +++ b/tools/testing/selftests/prctl/set-process-name.c
> @@ -12,6 +12,7 @@
>  #define CHANGE_NAME "changename"
>  #define EMPTY_NAME ""
>  #define TASK_COMM_LEN 16
> +#define MAX_PATH_LEN 50
>
>  int set_name(char *name)
>  {
> @@ -47,6 +48,35 @@ int check_null_pointer(char *check_name)
>         return res;
>  }
>
> +int check_name(void)
> +{
> +
> +       int pid;
> +
> +       pid = getpid();
> +       FILE *fptr = NULL;
> +       char path[MAX_PATH_LEN] = {};
> +       char name[TASK_COMM_LEN] = {};
> +       char output[TASK_COMM_LEN] = {};
> +       int j;
> +
> +       j = snprintf(path, MAX_PATH_LEN, "/proc/self/task/%d/comm", pid);
> +       fptr = fopen(path, "r");
> +       if (!fptr)
> +               return -EIO;
> +
> +       fscanf(fptr, "%s", output);
> +       if (ferror(fptr))
> +               return -EIO;
> +
> +       int res = prctl(PR_GET_NAME, name, NULL, NULL, NULL);
> +
> +       if (res < 0)
> +               return -errno;
> +
> +       return !strcmp(output, name);
> +}
> +
>  TEST(rename_process) {
>
>         EXPECT_GE(set_name(CHANGE_NAME), 0);
> @@ -57,6 +87,8 @@ TEST(rename_process) {
>
>         EXPECT_GE(set_name(CHANGE_NAME), 0);
>         EXPECT_LT(check_null_pointer(CHANGE_NAME), 0);
> +
> +       EXPECT_TRUE(check_name());
>  }
>
>  TEST_HARNESS_MAIN
> --
> 2.34.1
>
