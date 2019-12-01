Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1FE10E3E7
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2019 00:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfLAXZq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 1 Dec 2019 18:25:46 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:38618 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfLAXZp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 1 Dec 2019 18:25:45 -0500
Received: by mail-wm1-f54.google.com with SMTP id p17so8261897wmi.3;
        Sun, 01 Dec 2019 15:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Nuine0dlwsDQb9vcAljbjPYMQNC3YRYMqCbVc0zfEfo=;
        b=jvxkMi5Kn4oGzit1SjsXgIDBxGmAVjJbbDnAthzS3xLLr74s46jPUI8/PzOdq8iXo3
         7ALDzp3JXWLhdaoY2Nht6T9HElNYGSllyYUlwvLsy3On+SqGenz4fW0j5pcMv3Ed1FbI
         5igThj61ZbJ6TulNcFnk8xoS0i1jKHt9jAeABjcrjLiuW/4AkR3XJB1DE8zZLUlUIWYl
         R8N0hfTrtgRjfFJUM7JU7XnYqEGJlscKaQQIufYZI9AHV1cC5YGsMkUK6FZK9/PZp4wW
         ZqaSQyjuF4Oi0XssAs4JCXF/NuZrgbXRg/nTSNTMA/NNhrSOfOWLm8IWwIvbmu6IuDAS
         Qi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Nuine0dlwsDQb9vcAljbjPYMQNC3YRYMqCbVc0zfEfo=;
        b=aBCzUcMgk3T71aMiU+1I7mYyFoKHJGRsAW1hLKtqjWzbjHI0Q2ax8YlEyqJPDAnXvG
         xQk7hROJsOU0Jzp1MFYZ9jLl82wyzovS8qrxombMDnQJN7OIflWAB9/wiJw35dbTEMV4
         O1+fPgIHCJENN+2IigZJq8HDxQxn0sWwooW73tl+GIMdm20dZSecQgAvjnsswvr8WhYl
         n065kuF7SGvMCTbQ+nltsb1GaFhR+/oLZW/DLwNOAQo1Tfu1Sb6wu258StxthopgtQzt
         1rBUgeMBQQ1BlzQBaqDcdmIw8qlCxX5nISDCXj5U6oRoPLJmVI0F90j/T1/wZaNBJ5PU
         tK7w==
X-Gm-Message-State: APjAAAV9yEs+ldo9GgBCoSb3bNobv5eIMd9D+Q5HBjYhstH5wS+3ChTn
        Pxh0b8+LGj+KVPyiXDRpiR8=
X-Google-Smtp-Source: APXvYqwiRSldoFbS1BRUYFG/Ss97kQu4OFo0/z31SQvh9IRKY72Mt9G86SXcMG6D1EQoXjJLDlfFCg==
X-Received: by 2002:a1c:f610:: with SMTP id w16mr7218543wmc.34.1575242741560;
        Sun, 01 Dec 2019 15:25:41 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-100-90.cust.telecolumbus.net. [86.56.100.90])
        by smtp.gmail.com with ESMTPSA id y6sm37450454wrl.17.2019.12.01.15.25.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Dec 2019 15:25:40 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     brendanhiggins@google.com, shuah@kernel.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 0/6] Fix nits in the kunit
Date:   Mon,  2 Dec 2019 08:25:18 +0900
Message-Id: <1575242724-4937-1-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This patchset contains trivial fixes for the kunit documentations and the
wrapper python scripts.

SeongJae Park (6):
  docs/kunit/start: Use in-tree 'kunit_defconfig'
  docs/kunit/start: Skip wrapper run command
  kunit: Remove duplicated defconfig creation
  kunit: Create default config in 'build_dir'
  kunit: Place 'test.log' under the 'build_dir'
  kunit: Rename 'kunitconfig' to '.kunitconfig'

 Documentation/dev-tools/kunit/start.rst | 19 +++++--------------
 tools/testing/kunit/kunit.py            | 10 ++++++----
 tools/testing/kunit/kunit_kernel.py     |  6 +++---
 3 files changed, 14 insertions(+), 21 deletions(-)

-- 
2.7.4

