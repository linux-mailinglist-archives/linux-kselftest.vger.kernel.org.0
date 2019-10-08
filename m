Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 105ADCF8CB
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2019 13:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbfJHLrG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Oct 2019 07:47:06 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:42478 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730439AbfJHLrG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Oct 2019 07:47:06 -0400
Received: by mail-qk1-f181.google.com with SMTP id f16so16341041qkl.9
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2019 04:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=NvRHLOVp0smdQL8FBhKJRetnTSiAtrAwlN7HqTN/Iyw=;
        b=qF1cF+Qs39HgLCNxFdwBTsDCtJ9r2N8g4069fYmOlQCzYRHtX91X/jfSIqNyTt0miZ
         EHaZq2G4dZI2KvtlXo0aJrsHqaoNAUHYWBhtbHh17F4u3lCYvRwklZ0peCBU9Vf/JaXw
         UQP3hfYFUWtRR1E6JqeZ1UjiGwbkKEVVqyEsZFj5pGo0STeFRME4sk9FCiRavSU8DIKe
         licBNlauj3AvIiqHjLrA1QfC3sTTnegymQ3iwf4lj9HuFzk9CAZuV+KMlaM5FDN6ij94
         bCOawL5rR/c/0QQkvszQYYdeFiMetQ+SS1KQMZ5OQDdvvLNOYlapElmsnf90XLBEs8RF
         hxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=NvRHLOVp0smdQL8FBhKJRetnTSiAtrAwlN7HqTN/Iyw=;
        b=KeT6SE62tsrtnaCc2bfkNAWH1WQ2t/1UdLV1b0enhd/f7y6abXSYFdmj4iCPQFGzlc
         YCMU6PqRDVsk1dKHxFWksO8mlfDvFMNkrL2jK35X2rfRmtc8yehEnbLwkkoX7B4ffEV2
         olB3MJuwQme4lg0AUKGrS4xnNIEkG8V0mxlwYPJUcJWwWVc0cpibsPCJSdLu4+pfccXO
         H3ZVGMqKLtE0XEfjjHGCCoeWrn0OPE6hb8FtA3XZPQocElW6zeu5z4CggRc2ElDBCA65
         MuNqjKpzKlXhLdx1KJ21f8H9RgytrtygfzPgJX0Uz4DudUSFOtZyCz8AkqTZ5V3XsAHc
         rGXA==
X-Gm-Message-State: APjAAAX9boSFnP0J57l5DtP5/HoCr5ZgMwyXnr5g26+zBgRABh8z4pX3
        WFPbAPplIvFfQyOEqTwqWi4yenaTFtIkb89hYnfUzVwt/S4=
X-Google-Smtp-Source: APXvYqxwU7ph3dwPWRJcPbMyQDJ6bEGFze1TP4w/+5LLqv5aPqSxVQumAGqCkxW7csQPRbn6MeV7tpgOdIKkEC1hyoQ=
X-Received: by 2002:a37:9c57:: with SMTP id f84mr29351181qke.250.1570535224574;
 Tue, 08 Oct 2019 04:47:04 -0700 (PDT)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 8 Oct 2019 13:46:52 +0200
Message-ID: <CACT4Y+YjOxmOzzPt_xaYE44QNZfq9haNfbnVBrTnPXe7zuSEfA@mail.gmail.com>
Subject: syzkaller reproducers
To:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        automated-testing@yoctoproject.org, kernelci@groups.io
Cc:     syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

We discussed collecting and uploading all syzkaller reproducers
somewhere. You wanted to see how they look. I've uploaded all current
reproducers here:
https://github.com/dvyukov/syzkaller-repros
Minimalistic build/run scripts are included.
+some testing mailing lists too as this can be used as a test suite
If you have any potential uses for this, you are welcome to use it.
But then we probably need to find some more official and shared place
for them than my private github.
The test programs can also be bulk updated if necessary, because all
of this is auto-generated.

Thanks
