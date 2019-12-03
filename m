Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C78C1103FF
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 19:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfLCSIn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 13:08:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42865 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfLCSIn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 13:08:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so4867474wrf.9;
        Tue, 03 Dec 2019 10:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uu8SRKrCwA24B1HeVzX2ILStFDsA66BxYaIgBYTqV90=;
        b=eyYznx4VsrJPtQrB9sJx+FQ5Xljx5SfHqRyqFkBgU8LlAWKP74D9adySTqgzBA2SgA
         pVJ8FeYzI6jTmYZITQsW9zr+K3Fr+o3wNRayP2ovEYsPIiy5x+qpJDUCK7jxNewn+kKg
         jrNDO/oGwBzUunix7U8L+orZls9L43eZ4tMwnXrLDrGnXYdb5GHrw3PPtQnKzs5/5R55
         Y0Thi9P8SK9cT5X0zhYuO3bbp+A6txCLvUhE+hTzqy2gGFsvuQtMBnXWQTNd7K8c1Iq6
         W5jvYRw0eltMs6+ZRneKjneHHhcu/PzBTe1IsRqNKn+o+DePIqp6Rtcl/VXnFpja7tHu
         OJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uu8SRKrCwA24B1HeVzX2ILStFDsA66BxYaIgBYTqV90=;
        b=Lzd6OtrSpJEsKhLE1a44T8XCJjOjvyIr2lN9rij7tRgOv4hu+2RUdNmOpRJiJ28fvL
         /utG0dX5Y2CbbV2lGBQkwtCy7eNq9kOROlfJ1stFbY6fl55Yd8TuQ/FVjBx1v+EcdofN
         w+9B/Ws8lVT+1CJsyiZJ66tMg+L41xPAgbK+tub20jR3+Ux0BBuxHR+DgtsuoHA1oLLo
         V6E5X+Rj3NRZ36ytKvnm63HS5+IxP/5rYrKARnR5wxXd+xMUsyxVn46b18MrCdoMWJId
         aEw9faMDCyXn2GABVcAdbOC+1/M1B7L5Ypa9NMFReT7j/JCYJJjsllOvtxa4w5BX/pVa
         gfBQ==
X-Gm-Message-State: APjAAAVEntv2r9fcZAbOAQSj+iPzA7crMkYbPzNllXZHfev9DOh1BCKv
        m1xHOngzFeA8hIQgahOVhJI=
X-Google-Smtp-Source: APXvYqyrCLNsRKbhEYDvOewARsrR4PmOF3wR0OdXq0n+rw/li+8Ph4zsQxM2oTyl4b1XTTvIOJuSXQ==
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr6324080wrr.32.1575396520921;
        Tue, 03 Dec 2019 10:08:40 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-100-90.cust.telecolumbus.net. [86.56.100.90])
        by smtp.gmail.com with ESMTPSA id f11sm3847641wmc.25.2019.12.03.10.08.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Dec 2019 10:08:39 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     brendanhiggins@google.com
Cc:     corbet@lwn.net, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        sj38.park@gmail.com, sjpark@amazon.de
Subject: [PATCH v3 0/5] Fix nits in the kunit
Date:   Wed,  4 Dec 2019 03:08:23 +0900
Message-Id: <1575396508-21480-1-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patchset contains trivial fixes for the kunit documentations and the
wrapper python scripts.

Changes from v2 (https://lore.kernel.org/linux-kselftest/1575361141-6806-1-git-send-email-sj38.park@gmail.com/T/#t):
 - Make 'build_dir' if not exists (missed from v3 by mistake)

SeongJae Park (5):
  docs/kunit/start: Use in-tree 'kunit_defconfig'
  kunit: Remove duplicated defconfig creation
  kunit: Create default config in '--build_dir'
  kunit: Place 'test.log' under the 'build_dir'
  kunit: Rename 'kunitconfig' to '.kunitconfig'

 Documentation/dev-tools/kunit/start.rst | 13 +++++--------
 tools/testing/kunit/kunit.py            | 16 ++++++++++------
 tools/testing/kunit/kunit_kernel.py     |  8 ++++----
 3 files changed, 19 insertions(+), 18 deletions(-)

-- 
2.7.4

