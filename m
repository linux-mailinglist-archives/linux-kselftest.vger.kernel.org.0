Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EACD4818E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Dec 2021 04:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbhL3DRl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 22:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhL3DRl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 22:17:41 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7F5C061574;
        Wed, 29 Dec 2021 19:17:40 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id f8so10248773pgf.8;
        Wed, 29 Dec 2021 19:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:date:subject:from:to:cc:message-id:thread-topic
         :mime-version:content-transfer-encoding;
        bh=yOFcKMpzFKYV8ow6uynQBpneJs946DwS3CxEhat1srI=;
        b=KCextQtmP9jf+dmPVKbGumPFp+YI+1QtDobXEJGFPetpC8oQ1VzdGyd8aVrIEEHONv
         6RTfLOaG9gAJHTi/rW4HtH0Rw3m9SBhl/nDWQqxP7Lu8h9Mh7gRi6L5W6Zv8At1VLmKH
         vhNw/gfjAcFgNGYC5K71O4nkh0AV0Ddj++TVUz/UQYzdtpC+av9Dk6gFdN+TwyaADDdP
         OA+u1tBFmcJ2KcD8Y1+reESBcsaBQiAT3zlW5YcuX+1XceFrN7+syX//K5mErcqtfKs+
         GQ6MRU0sw1NSgoqSRGmDET8GXELGMRyOrv0CY56+vxbFwMjkPTmRcEF99HsbB3+Y6urJ
         Gq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:user-agent:date:subject:from:to:cc:message-id
         :thread-topic:mime-version:content-transfer-encoding;
        bh=yOFcKMpzFKYV8ow6uynQBpneJs946DwS3CxEhat1srI=;
        b=YXFCN0veJkqQWuqov5YNxujZ7mVhFHe6VLCT3HKxxq9Kw4azOotFlWPVlioXqDNpd6
         8u1JctPE1xiWZDjg4dImoSS0xZUQHBOAVJZNpQW1u28VYE978PnXJwqYZBUmW47NBA0F
         /OPmwd7bK801CXcg8rlgz+6VaGhCwucGD2bGiFNwu8Tzh4ExeY+cqJPUs3ipGygh3He6
         08ZjUfryilYgzoKybWTuMp9s8cyFb2iSMxUWDykazMTtasGqw0iNzOOitKJ460qdgASc
         LhWnqjx5A3mhaa7ZIXDzd5Q0qcDqt13gLPye+ZpnkbZZ5HoBxIh69ZuVdepbGHZh4hOn
         WHlA==
X-Gm-Message-State: AOAM532ShmkP5TJUjNLxJ6ZwxpC+05pdkYnReT5uPK4kfspD0AGT2Wy7
        JS+xJLaoq1QF1oIfrwZWmOk=
X-Google-Smtp-Source: ABdhPJyNl1CnGusUZMczGZt17LFE3oRAQITnUMAD5b92zTmqRUqYl6xOdO6t1GxElBSfA/o8HThzUg==
X-Received: by 2002:a05:6a00:a84:b0:4ba:557e:12cb with SMTP id b4-20020a056a000a8400b004ba557e12cbmr29367836pfl.85.1640834260383;
        Wed, 29 Dec 2021 19:17:40 -0800 (PST)
Received: from [30.135.82.251] ([23.98.35.75])
        by smtp.gmail.com with ESMTPSA id g9sm26114890pfc.203.2021.12.29.19.17.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Dec 2021 19:17:40 -0800 (PST)
User-Agent: Microsoft-MacOutlook/16.56.21121100
Date:   Thu, 30 Dec 2021 11:17:37 +0800
Subject: [Resource Leak] Missing closing files in testing/selftests/vm/mlock2
From:   Ryan Cai <ycaibb@gmail.com>
To:     <shuah@kernel.org>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Message-ID: <C8980E43-5BED-45C6-B3F8-7BC3D58DF21A@gmail.com>
Thread-Topic: [Resource Leak] Missing closing files in
 testing/selftests/vm/mlock2
Mime-version: 1.0
Content-type: text/plain;
        charset="UTF-8"
Content-transfer-encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Dear Kernel maintainers,
             =C2=A01. In testing/selftests/vm/mlock2, the file opened at Line 3=
9 may not closed when going to Line 65.
              Location: https://github.com/torvalds/linux/blob/5bfc75d92efd=
494db37f5c4c173d3639d4772966/tools/testing/selftests/vm/mlock2.h#L37-L49

              Can I send I a patch?

Best,
Ryan




