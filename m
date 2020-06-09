Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11EA1F3B4D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jun 2020 15:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgFINCe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Jun 2020 09:02:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52867 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728052AbgFINC3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Jun 2020 09:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591707748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=QvkO2PPp+zFnnylyA9/RHaMuHI9iwBcF6vd6fIsDp3k=;
        b=WYfBGgHzsqtxyTC8UdzAGnLjs9R2Ks3cLNfOePNO+HzcT5ChmVRh+fIXA/8SL7h0uSh3B1
        ezCBhkgFnfynZUP2Wo0osSouPw6X3bTavkDqOZDOapID/t3PoJkahH778gWKxKyv1WJa9M
        ygphGqRgJYVinmyYjYu7LcNo3HOlbDo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-7dKXdsHHPyytMzcrjRXsbg-1; Tue, 09 Jun 2020 09:02:27 -0400
X-MC-Unique: 7dKXdsHHPyytMzcrjRXsbg-1
Received: by mail-qt1-f199.google.com with SMTP id k23so18352060qtb.2
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jun 2020 06:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QvkO2PPp+zFnnylyA9/RHaMuHI9iwBcF6vd6fIsDp3k=;
        b=ecAQLaTQRQm+nHYoEBTwTjAoE9FSpdvoZ9Na/UXPPRG3i+iFgXedyh9RsLYlQxLhlz
         sU4/pOcTE0DM9m9+VMuPVpNGQTRB2je23Zi7tr4GQyKy1oZ+55jey729A8o0M5pKCYBW
         yNeWM+4mMoUKRrvJ2e+t8NTBYqlOlk/J4+ASjcJmaAjgiK7aq/6/YxSp/lGNj1t6CYdQ
         hgpdjMusOXbvuyf0v+rtm0HBvgIcOXohto53Sb1HEvB5CG40pqDmX0yQnMSWmUI5n3iI
         duwOu27qbwaypxgkVDVKkw02sAVSCRTMBLsZr5A/wEq8b3o3MTpd5LOonlY9LXx4fFPI
         OafA==
X-Gm-Message-State: AOAM5303XABkvUyqSkO3bhQMFq4aIxJIjPJCoJ3MC27QRSbPfUbBjELw
        1S82rtN/z/dPJdJSQzSrw52r2N7tetTZsXaz58KNUV6rb3cX5Ss0OY5OGVld6rtJekzFYZtcubd
        HPqVSi++6NcjDPLdHb32Y4iGtmow2
X-Received: by 2002:a37:9e10:: with SMTP id h16mr27676977qke.381.1591707746704;
        Tue, 09 Jun 2020 06:02:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeetGPEU0xF9HLprMg4MvSdl54Lp4Jsvbf7QFI0FFyJ0mJJTghbDKHUiCqj2qRDoXcVNxScQ==
X-Received: by 2002:a37:9e10:: with SMTP id h16mr27676931qke.381.1591707746339;
        Tue, 09 Jun 2020 06:02:26 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m7sm9635939qti.6.2020.06.09.06.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:02:25 -0700 (PDT)
From:   trix@redhat.com
To:     linux-fpga@vger.kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 0/1] selftests for drivers/fpga
Date:   Tue,  9 Jun 2020 06:02:07 -0700
Message-Id: <20200609130208.27390-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Tom Rix <trix@redhat.com>

repo : linux-next
tag : next-20200608

Start applying selftests to drivers/fpga.

While testing out this upcoming change on linux-fpga
'Add interrupt support to FPGA DFL drivers'

I did not see any existing fpga tests.
So I added one.


Tom Rix (1):
  selftests: fpga: dfl: A test for afu interrupt support

 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/drivers/fpga/Makefile |  9 +++++
 .../testing/selftests/drivers/fpga/afu_intr.c | 38 +++++++++++++++++++
 tools/testing/selftests/drivers/fpga/config   |  1 +
 4 files changed, 49 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/fpga/Makefile
 create mode 100644 tools/testing/selftests/drivers/fpga/afu_intr.c
 create mode 100644 tools/testing/selftests/drivers/fpga/config

-- 
2.18.1

