Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425E71F6E0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jun 2020 21:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgFKTjL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Jun 2020 15:39:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38098 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726134AbgFKTjL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Jun 2020 15:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591904350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=u8/OdraxV9Bf+mXB4Fs4dcRV8raf0sIOF0iql8UflHo=;
        b=BeAqUNIEZBaRHj8/b9uIS1f+wHRzjiuosnZY0+I5E3GB9GpXfJ7RN5pcaoFYbO6s1ycpa7
        3c6Qj3+fXuuX/tMxTmatj8sYhIUVCHvfHDgchjtlupdaInFUizg5wFQIR/Ze+O8LmWvh5H
        jDYRpVd1ewvs23PrmwftNS6j+qal+Mk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-vlezEvJgM_6V9R-mFP0KAQ-1; Thu, 11 Jun 2020 15:38:35 -0400
X-MC-Unique: vlezEvJgM_6V9R-mFP0KAQ-1
Received: by mail-qv1-f71.google.com with SMTP id z7so5183714qve.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jun 2020 12:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u8/OdraxV9Bf+mXB4Fs4dcRV8raf0sIOF0iql8UflHo=;
        b=VUXs+jqx9lpCW579ReHaLfzZS3/2MpvaJqJ2k6LGTEjH53w6NdTNh15GCBL/v5fgB/
         sWluudqBtCcUHqdqiqCg7LD0jliggwduNbit70kI6hCJaQWYYt7zAqpS7ThWSJ89D69T
         ga159dsrv4hCSRblZJY4spL007ID9OpxNK2zDbggrbmBV6cP8zgzDuDR3A2gPbQbh0d8
         rAMA3EjEhAE7Svg0WK44XRwMtibSdNRUQqWMNpSpmqMwaPMOj1Y3SEaJIYe/h2dSWaCp
         +6faba36KJbLIzlcpw1t4mrY45AKqPmprVf46G8BCrC+N7zAfCh5io0pzt23PnIRMVuR
         yTIA==
X-Gm-Message-State: AOAM530ZSzH/pl5/76DgTJ9A6/86SY3gm2+ze9kKPIWSUQjwGWM+Fbkp
        ArMl+WHWEMBaXP9jB0q7QVJXywcLmF8649VmLCnft/P/0uEUQlr0lhmhEiGwOGfDPuehClaEepB
        yeU5M8OhRlZm9KcP80mkAS28mQLSc
X-Received: by 2002:a37:9a4c:: with SMTP id c73mr10196335qke.450.1591904314732;
        Thu, 11 Jun 2020 12:38:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQtwswsTGgRQ9rrZiZRxCAHbWdA8cWacLl6m7dxpVA5zy7jW4IXrGz/yV8yRp3gYQa1DE2tg==
X-Received: by 2002:a37:9a4c:: with SMTP id c73mr10196317qke.450.1591904314480;
        Thu, 11 Jun 2020 12:38:34 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j22sm3020783qke.117.2020.06.11.12.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 12:38:33 -0700 (PDT)
From:   trix@redhat.com
To:     shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-fpga@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 0/1]  selftests: fpga: dfl: A test for afu interrupt support
Date:   Thu, 11 Jun 2020 12:38:26 -0700
Message-Id: <20200611193827.8302-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Tom Rix <trix@redhat.com>

repo: linux-next
tag: next-20200611

Start applying selftests to drivers/fpga.

While testing out this upcoming change on linux-fpga
'Add interrupt support to FPGA DFL drivers'

I did not see any existing fpga tests.
So I added one.

Change from v1
Use ksft_* functions for reporting

Tom Rix (1):
  selftests: fpga: dfl: A test for afu interrupt support

 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/drivers/fpga/Makefile |  9 +++++
 .../testing/selftests/drivers/fpga/afu_intr.c | 33 +++++++++++++++++++
 tools/testing/selftests/drivers/fpga/config   |  1 +
 4 files changed, 44 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/fpga/Makefile
 create mode 100644 tools/testing/selftests/drivers/fpga/afu_intr.c
 create mode 100644 tools/testing/selftests/drivers/fpga/config

-- 
2.18.1

