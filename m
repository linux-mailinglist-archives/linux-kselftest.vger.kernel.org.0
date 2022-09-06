Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A055AE7B5
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 14:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239695AbiIFMTv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 08:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240200AbiIFMTQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 08:19:16 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F227CA80;
        Tue,  6 Sep 2022 05:16:57 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4MMPNV6Zymz9v7Z8;
        Tue,  6 Sep 2022 20:10:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwDn3pLcORdjV_onAA--.39374S2;
        Tue, 06 Sep 2022 13:15:39 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     jarkko@kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, deso@posteo.net, dhowells@redhat.com,
        haoluo@google.com, jmorris@namei.org, john.fastabend@gmail.com,
        jolsa@kernel.org, keyrings@vger.kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, mingo@redhat.com, mykolal@fb.com,
        paul@paul-moore.com, roberto.sassu@huawei.com,
        roberto.sassu@huaweicloud.com, rostedt@goodmis.org, sdf@google.com,
        serge@hallyn.com, shuah@kernel.org, song@kernel.org, yhs@fb.com
Subject: [PATCH v17 05/12] KEYS: Move KEY_LOOKUP_ to include/linux/key.h and define KEY_LOOKUP_ALL
Date:   Tue,  6 Sep 2022 14:15:06 +0200
Message-Id: <20220906121506.165001-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YxcyeZBHGPNQB+qJ@kernel.org>
References: <YxcyeZBHGPNQB+qJ@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwDn3pLcORdjV_onAA--.39374S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urW3JFW3Xr43Gr17tFy5urg_yoW8CF15pF
        WDC3W8Kry8Cry2gwn5GwsFy3WSk39xGr17XF9IgwnYya1Sg3y8trn7GF47CF1YyrWUuw12
        qrW29a1Uur1DA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
        WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvj
        fUojjgUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAHBF1jj36rkwAAs2
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation for the patch that introduces the bpf_lookup_user_key() eBPF
kfunc, move KEY_LOOKUP_ definitions to include/linux/key.h, to be able to
validate the kfunc parameters. Add them to enum key_lookup_flag, so that
all the current ones and the ones defined in the future are automatically
exported through BTF and available to eBPF programs.

Also, add KEY_LOOKUP_ALL to the enum, with the logical OR of currently
defined flags as value, to facilitate checking whether a variable contains
only those flags.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/key.h      | 6 ++++++
 security/keys/internal.h | 2 --
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index 7febc4881363..d27477faf00d 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -88,6 +88,12 @@ enum key_need_perm {
 	KEY_DEFER_PERM_CHECK,	/* Special: permission check is deferred */
 };
 
+enum key_lookup_flag {
+	KEY_LOOKUP_CREATE = 0x01,
+	KEY_LOOKUP_PARTIAL = 0x02,
+	KEY_LOOKUP_ALL = (KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL),
+};
+
 struct seq_file;
 struct user_struct;
 struct signal_struct;
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 9b9cf3b6fcbb..3c1e7122076b 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -165,8 +165,6 @@ extern struct key *request_key_and_link(struct key_type *type,
 
 extern bool lookup_user_key_possessed(const struct key *key,
 				      const struct key_match_data *match_data);
-#define KEY_LOOKUP_CREATE	0x01
-#define KEY_LOOKUP_PARTIAL	0x02
 
 extern long join_session_keyring(const char *name);
 extern void key_change_session_keyring(struct callback_head *twork);
-- 
2.25.1

