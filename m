Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B9A1B1F74
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Apr 2020 09:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgDUHFU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Apr 2020 03:05:20 -0400
Received: from mail.loongson.cn ([114.242.206.163]:41448 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726563AbgDUHFU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Apr 2020 03:05:20 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxf2ogm55esnIqAA--.25S2;
        Tue, 21 Apr 2020 15:05:05 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH v4 0/4] Fix some issues about kmod
Date:   Tue, 21 Apr 2020 15:05:00 +0800
Message-Id: <1587452704-1299-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxf2ogm55esnIqAA--.25S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr18tF4rWr4kZF1rJryDAwb_yoWxZrb_CF
        srt3yfAayUKFWDAa17urs8Z393Ga18Zr15JrW8Jayakr98X398u3WvqrykX34fWrW5t392
        gryDZFn7Arn7ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4x
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
        WxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjE1v3UUUU
        U==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

v4:
  - update the commit message with application of patch 3/4

v3:
  - use the quotes with correct format in the commit message of patch 4/4,
    sorry for that

v2:
  - update the commit message to explain the detailed reason of patch 3/4
  - add this cover letter

Tiezhu Yang (4):
  selftests: kmod: Use variable NAME in kmod_test_0001()
  kmod: Remove redundant "be an" in the comment
  kmod: Return directly if module name is empty in request_module()
  test_kmod: Avoid potential double free in trigger_config_run_type()

 kernel/kmod.c                        | 10 +++++++---
 lib/test_kmod.c                      |  2 +-
 tools/testing/selftests/kmod/kmod.sh |  4 ++--
 3 files changed, 10 insertions(+), 6 deletions(-)

-- 
2.1.0

