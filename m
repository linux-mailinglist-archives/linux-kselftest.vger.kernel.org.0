Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAD3611F8B
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Oct 2022 05:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiJ2DEI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 23:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJ2DDw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 23:03:52 -0400
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F4833401
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Oct 2022 20:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1667012603;
        bh=yzgljApEq0qdIxlgB5hEgOKNze+VaVoW3rIffIgUM7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JUpLlz6+OMaZIQsJHXWTc4fJN9ONgH5/MmUvkRiplvrJ7rFg2GhVziZIuSI0PFjrx
         5qzA48psuL1sxxXZEfOvJQAr+CRwW5G6ilFAx6RHYmzfmcTXEOYdqUdEmvYMp7/REL
         LeLpKGCRCZ1hzbgGg4uv8484hxIQB2rxw/zGSbcI=
Received: from localhost.localdomain ([111.199.189.86])
        by newxmesmtplogicsvrszc1-0.qq.com (NewEsmtp) with SMTP
        id EF589CDA; Sat, 29 Oct 2022 10:59:53 +0800
X-QQ-mid: xmsmtpt1667012393tuia2uaof
Message-ID: <tencent_BA460110770C008560B21A2E3555405E9F09@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujuAp5mqx8XHGzuesj9Bu6ZPwpAViukBow+hzL2HWcPWqqa7gFMF
         TjhfQifJ/YvXVwrMpYQyf6ofAAzK/brsjY06p8SpPd5uVP6GMj6aaz6xZL8buLBLWB0RMG3gEo75
         OkdpKSRIHWtxIwsJdMjY3nZwLOAG/qMXjcIG5L8UJ2+LnsixUYEBogcjXAarsWns8kozvihdQpf0
         43wJLOgWCZYWekP8pcF26gnMhDIUfbOgQJZiAAcWDaqzwmOa21uXFTrcqgJaMibQo5voqFxdZvPP
         p6qX+NDPF3iUrZMJ88Zo1RCxgdaw5N81pwZpN+th/V/yr+0I+sGOhQc0JcrF7IdDld/vem2qhUUt
         +Y6u1SyPmQG2k0Wy0SBpGgv5GE58o+iPJwIYM0eAWHHgENdXPNM6c2ASU30Dzx2HHRfnA4sWC/9B
         hzHPLyLPpDddB2Z+Iu9GYZJvgfNfvtuzpVjE8oFXfn/W1umv2O9NJWBSegOZJPL9iEVp4vWMCXqa
         um6mu/C+ENQu6J9+WbtojzAugRwaonmwKq9q41lFkbs1WazAJvbEiC3b8I259pKjH/8jInKCFEpj
         1R7yjCIsXZoTlYjgFuYITYFpzuB2rdR5ZZlhyCdNoc7YYGP60KhxozLd6eHzGc8bHAU8s0EEUXU+
         3ZiM0iCJn8DSpLCrdPn+vPjyYWhjIqD+uiBHlBTf/WHc6D7ARlUZO58gJC1BS/mVAX6hWHfPQWV4
         KGEQfW1BA8IxxZBeDDHHxzss/uut7Zt5IhhVJfanPpeuvyX6Eyhgod2xv/IKr304uRVjcP2MQTfz
         PdyIakpKOYP8dVRLLP8ll5m/ily4Db7CwtzX8gPW/KxeRA+B7J38upFGowraPuq+0uRrydWkKw6A
         ma2c2Nfyxf1MluIkG4lU4Dg3vAUdclxPRaEmfPcJISemCf00fPC5Zlv/Lx63fP/uMrKWpH3tj/ML
         Vs301TZKX3YvlPMWDGCN+5QsXEPcERWc7IQIJ/a3TWiKILkrL3ELaaLzpBLHkl2ZE4a0ll93s=
From:   Rong Tao <rtoax@foxmail.com>
To:     andrii.nakryiko@gmail.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, martin.lau@linux.dev,
        mykolal@fb.com, rongtao@cestc.cn, rtoax@foxmail.com,
        sdf@google.com, shuah@kernel.org, song@kernel.org, yhs@fb.com
Subject: [PATCH bpf-next] selftests/bpf: Fix strncpy() fortify warning
Date:   Sat, 29 Oct 2022 10:59:52 +0800
X-OQ-MSGID: <20221029025952.22566-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <CAEf4BzazYVkVKrKzPD8a7tRZrcWDvvgoVksJHYk3+46V=8kZhw@mail.gmail.com>
References: <CAEf4BzazYVkVKrKzPD8a7tRZrcWDvvgoVksJHYk3+46V=8kZhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Replace strncpy() with strncat(), strncat() leaves the dst string zero
terminated. Compile samples/bpf warning:

$ cd samples/bpf
$ make
...
In function ‘__enable_controllers’:
samples/bpf/../../tools/testing/selftests/bpf/cgroup_helpers.c:80:17: warning: ‘strncpy’ specified bound 4097 equals destination size [-Wstringop-truncation]
   80 |                 strncpy(enable, controllers, sizeof(enable));
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index a70e873b267e..912e6522c7c5 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -77,7 +77,8 @@ static int __enable_controllers(const char *cgroup_path, const char *controllers
 		enable[len] = 0;
 		close(fd);
 	} else {
-		strncpy(enable, controllers, sizeof(enable) - 1);
+		enable[0] = '\0';
+		strncat(enable, controllers, sizeof(enable) - 1);
 	}
 
 	snprintf(path, sizeof(path), "%s/cgroup.subtree_control", cgroup_path);
-- 
2.31.1

