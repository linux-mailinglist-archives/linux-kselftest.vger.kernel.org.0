Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910D858628A
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Aug 2022 04:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbiHACYa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 31 Jul 2022 22:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiHACY3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 31 Jul 2022 22:24:29 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE4C12ABB;
        Sun, 31 Jul 2022 19:24:28 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id x23so575599pll.7;
        Sun, 31 Jul 2022 19:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=QQg9n4iyqRsWHQ+m6ss1Y5XUExmk7+SaxCNgTzy74SE=;
        b=e1/FViIuQL19CFbdWanwstmwLT3f/j1Xo14cc2IsmqEiz2gpGLHn1WeWKVsEYBw8w/
         1ebgXTpZ6T5IWWGhNwVucIjG4830q2WZDBpxmS7gQ4F1zqon4cTVEKaDdMk6oU/yLTsO
         BUJ3h36mbRQ1mBUQkQcXVGVtBwZ/CVnHSFXrW6yt3orcSi4ugsN7DSP9FF+2gNtl4dhZ
         BvSMM+vAvX90h1Jo47Ti9KCLDw0ojmmBP8KxTmPEXIj1zxAMdSdqCePgsb7JreGB01Z0
         BLs/Q+0N5PViPBzbvTuLLrWoHK3h6QqJCjzwNxAwz2QB2bfvi+o/0g1gTMt3hs08tgEN
         aU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=QQg9n4iyqRsWHQ+m6ss1Y5XUExmk7+SaxCNgTzy74SE=;
        b=ZhgO79Yf4JXNeV1dk6Na7JCQAfQzdhNCWU2/kio8NRiHUMLiSMsXI6BYxU+J+z9qiv
         JIq38RB8Yab5OzClA5gEWT85weIC7fwHjSNBFGTDq1s4Euo4TLWgExIQjqDR0kmK9PZM
         N2/80JXgdBzWxRoAVehT93dBw7OfUJGyEAcyyNVujrqb1jHWWGQXuOhoRe82ln3qP8dF
         KeqYhcxEnl5dVSo0muXBWwWBjuhzpQ0AeGbELL6HF7Cssa5aZdkMd/ln8ITByElhlq0k
         03OeMlQJH4nOQZuFYwmyPrFRf252gSC5eROrMUxexh30C8pdPNDphMuXxjoILZze5qIr
         SQiw==
X-Gm-Message-State: ACgBeo3AcorWOmzlw1WGQtr5Zsns8Y7SvNUVv3xhS13kjkjlTlaCyBzW
        tOhfN8Z9shWlBaGmGxjVSXkrscfw098=
X-Google-Smtp-Source: AA6agR5S5/B8h6aW8BoTBDAWfczVfX+7Dk/Ygn3+l5BvPbYbskIGF/UC1sHdwk3M7ugfuAIrohOaGw==
X-Received: by 2002:a17:902:8505:b0:16c:cf05:dc59 with SMTP id bj5-20020a170902850500b0016ccf05dc59mr14811871plb.125.1659320668338;
        Sun, 31 Jul 2022 19:24:28 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z9-20020a170903018900b0016d987d7f76sm8291769plg.11.2022.07.31.19.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 19:24:28 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] selftests:bpf:use the !E in conditional statements
Date:   Mon,  1 Aug 2022 02:24:24 +0000
Message-Id: <20220801022424.1594399-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Use !E to replace the type of x == NULL. This change is just to simplify 
the code, no actual functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 .../selftests/bpf/progs/profiler.inc.h        | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/profiler.inc.h b/tools/testing/selftests/bpf/progs/profiler.inc.h
index 92331053dba3..7d522e8968b5 100644
--- a/tools/testing/selftests/bpf/progs/profiler.inc.h
+++ b/tools/testing/selftests/bpf/progs/profiler.inc.h
@@ -189,7 +189,7 @@ static INLINE void populate_ancestors(struct task_struct* task,
 #endif
 	for (num_ancestors = 0; num_ancestors < MAX_ANCESTORS; num_ancestors++) {
 		parent = BPF_CORE_READ(parent, real_parent);
-		if (parent == NULL)
+		if (!parent)
 			break;
 		ppid = BPF_CORE_READ(parent, tgid);
 		if (is_init_process(ppid))
@@ -361,7 +361,7 @@ get_var_kill_data(struct pt_regs* ctx, int spid, int tpid, int sig)
 	int zero = 0;
 	struct var_kill_data_t* kill_data = bpf_map_lookup_elem(&data_heap, &zero);
 
-	if (kill_data == NULL)
+	if (!kill_data)
 		return NULL;
 	struct task_struct* task = (struct task_struct*)bpf_get_current_task();
 
@@ -386,14 +386,14 @@ static INLINE int trace_var_sys_kill(void* ctx, int tpid, int sig)
 	u32 spid = get_userspace_pid();
 	struct var_kill_data_arr_t* arr_struct = bpf_map_lookup_elem(&var_tpid_to_data, &tpid);
 
-	if (arr_struct == NULL) {
+	if (!arr_struct) {
 		struct var_kill_data_t* kill_data = get_var_kill_data(ctx, spid, tpid, sig);
 		int zero = 0;
 
-		if (kill_data == NULL)
+		if (!kill_data)
 			return 0;
 		arr_struct = bpf_map_lookup_elem(&data_heap, &zero);
-		if (arr_struct == NULL)
+		if (!arr_struct)
 			return 0;
 		bpf_probe_read(&arr_struct->array[0], sizeof(arr_struct->array[0]), kill_data);
 	} else {
@@ -402,7 +402,7 @@ static INLINE int trace_var_sys_kill(void* ctx, int tpid, int sig)
 		if (index == -1) {
 			struct var_kill_data_t* kill_data =
 				get_var_kill_data(ctx, spid, tpid, sig);
-			if (kill_data == NULL)
+			if (!kill_data)
 				return 0;
 #ifdef UNROLL
 #pragma unroll
@@ -433,7 +433,7 @@ static INLINE int trace_var_sys_kill(void* ctx, int tpid, int sig)
 		} else {
 			struct var_kill_data_t* kill_data =
 				get_var_kill_data(ctx, spid, tpid, sig);
-			if (kill_data == NULL)
+			if (!kill_data)
 				return 0;
 			bpf_probe_read(&arr_struct->array[index],
 				       sizeof(arr_struct->array[index]),
@@ -534,14 +534,14 @@ static INLINE bool is_dentry_allowed_for_filemod(struct dentry* file_dentry,
 	*device_id = dev_id;
 	bool* allowed_device = bpf_map_lookup_elem(&allowed_devices, &dev_id);
 
-	if (allowed_device == NULL)
+	if (!allowed_device)
 		return false;
 
 	u64 ino = BPF_CORE_READ(file_dentry, d_inode, i_ino);
 	*file_ino = ino;
 	bool* allowed_file = bpf_map_lookup_elem(&allowed_file_inodes, &ino);
 
-	if (allowed_file == NULL)
+	if (!allowed_file)
 		if (!is_ancestor_in_allowed_inodes(BPF_CORE_READ(file_dentry, d_parent)))
 			return false;
 	return true;
@@ -625,7 +625,7 @@ int raw_tracepoint__sched_process_exit(void* ctx)
 	struct var_kill_data_arr_t* arr_struct = bpf_map_lookup_elem(&var_tpid_to_data, &tpid);
 	struct var_kill_data_t* kill_data = bpf_map_lookup_elem(&data_heap, &zero);
 
-	if (arr_struct == NULL || kill_data == NULL)
+	if (!arr_struct || !kill_data)
 		goto out;
 
 	struct task_struct* task = (struct task_struct*)bpf_get_current_task();
@@ -767,7 +767,7 @@ int kprobe_ret__do_filp_open(struct pt_regs* ctx)
 
 	struct file* filp = (struct file*)PT_REGS_RC_CORE(ctx);
 
-	if (filp == NULL || IS_ERR(filp))
+	if (!filp || IS_ERR(filp))
 		goto out;
 	unsigned int flags = BPF_CORE_READ(filp, f_flags);
 	if ((flags & (O_RDWR | O_WRONLY)) == 0)
-- 
2.25.1
