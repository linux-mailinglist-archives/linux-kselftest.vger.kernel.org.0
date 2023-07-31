Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82FA769948
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 16:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjGaOTC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 10:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjGaOS7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 10:18:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0086AC9
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jul 2023 07:18:55 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3159d5e409dso4023486f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jul 2023 07:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690813134; x=1691417934;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3DmtlbrQ/uP+rFUnlHj+F1l/KXqdbIaM7o5dYguiRzA=;
        b=fc+BePL5mKEhTeWF6Rtd1Be8nmQhFo2d+QAk/5pgvYURMTU1Em1muMe7PrEY0BiZ8q
         Zmse+RLSKRGEWn/ntshiHjmAeXQ//M1XMSCan2cQ9dwcYdGeMGTJ2iilM+2Ljkwp/ca3
         fH40JURxHZGfDlrSFFi0KVFkwJyqimR5qAKRMAMl8ScjEsBdVqCFuzsqVCbtuysGkXyC
         11XI5y4O9YQiVgwtYW2uMcutNWS6vH1Mz15pRNP3jdAhLOM4c4Tjh3+62wptl9W1g8KH
         UhYb+T2uymkTN//dmLPQeUhIONOI9AmL6aA9ecUreXuYlX7U4FzVW1HgDVz1lJZJKuoT
         wg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690813134; x=1691417934;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3DmtlbrQ/uP+rFUnlHj+F1l/KXqdbIaM7o5dYguiRzA=;
        b=Qxc6R+BAKJmwoke0m3U8QTw5H9cw6g7of9ol2accrEzi5slPaOdLbW96uNGGwh8VF0
         iIdK/FU4ycYodEYiJLE/kmlfMcCBY5ikD7GckfwGnYVAfn4J7lIOqxVQ6YVOw/AZWTKX
         rtVmwk/GfFqBne54GO6utqQyyVkMlwBwIWhOfguNg0gfuyQUAuxMoGi1MgKQsotjmolN
         WWRpZnscGtB6RZqWtsFP3ZijryHxSKppN0K3R1YjGXruiA4ZQuxeseHVHWTGHAB+vlWt
         ZKVOOyQ//QhhmTwt9Q5IrKV1Wfa2v5wa506x9f/caeoIThW6zLiv6x0BE1mXea20dC7i
         oTkw==
X-Gm-Message-State: ABy/qLZauAKyEKj/XgdZe+EDFM45taZVyVEPXXG4qa5vAReGtJBBqzW+
        aQji6hW537PzqKOEOPTLt0dfmA==
X-Google-Smtp-Source: APBJJlGwXHIYRfC6WHhh3fmKIEcIf6fmvelmNdc+fr7DvPud0TRacJZ1sTQ64jpNn84yfqlhse8BpA==
X-Received: by 2002:a05:6000:1205:b0:317:650d:f7ce with SMTP id e5-20020a056000120500b00317650df7cemr8829827wrx.29.1690813134496;
        Mon, 31 Jul 2023 07:18:54 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y18-20020adff152000000b0031784ac0babsm12089933wro.28.2023.07.31.07.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 07:18:54 -0700 (PDT)
Date:   Mon, 31 Jul 2023 17:18:51 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     cerasuolodomenico@gmail.com
Cc:     linux-kselftest@vger.kernel.org
Subject: [bug report] selftests: cgroup: add test_zswap with no kmem bypass
 test
Message-ID: <5f082f85-0256-4c48-9ae2-6440297317b8@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Domenico Cerasuolo,

The patch 7c967f267b1d: "selftests: cgroup: add test_zswap with no
kmem bypass test" from Jun 21, 2023 (linux-next), leads to the
following Smatch static checker warning:

	./tools/testing/selftests/cgroup/test_zswap.c:228 test_no_kmem_bypass()
	error: uninitialized symbol 'test_group'.

./tools/testing/selftests/cgroup/test_zswap.c
    148 static int test_no_kmem_bypass(const char *root)
    149 {
    150         size_t min_free_kb_high, min_free_kb_low, min_free_kb_original;
    151         struct no_kmem_bypass_child_args *values;
    152         size_t trigger_allocation_size;
    153         int wait_child_iteration = 0;
    154         long stored_pages_threshold;
    155         struct sysinfo sys_info;
    156         int ret = KSFT_FAIL;
    157         int child_status;
    158         char *test_group;
    159         pid_t child_pid;
    160 
    161         /* Read sys info and compute test values accordingly */
    162         if (sysinfo(&sys_info) != 0)
    163                 return KSFT_FAIL;
    164         if (sys_info.totalram > 5000000000)
    165                 return KSFT_SKIP;
    166         values = mmap(0, sizeof(struct no_kmem_bypass_child_args), PROT_READ |
    167                         PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
    168         if (values == MAP_FAILED)
    169                 return KSFT_FAIL;
    170         if (read_min_free_kb(&min_free_kb_original))
    171                 return KSFT_FAIL;
    172         min_free_kb_high = sys_info.totalram / 2000;
    173         min_free_kb_low = sys_info.totalram / 500000;
    174         values->target_alloc_bytes = (sys_info.totalram - min_free_kb_high * 1000) +
    175                 sys_info.totalram * 5 / 100;
    176         stored_pages_threshold = sys_info.totalram / 5 / 4096;
    177         trigger_allocation_size = sys_info.totalram / 20;
    178 
    179         /* Set up test memcg */
    180         if (cg_write(root, "cgroup.subtree_control", "+memory"))
    181                 goto out;

test_group is not initialized here.  Undoing stuff which hasn't been
done is the canonical bug with "goto out;" labels.

    182         test_group = cg_name(root, "kmem_bypass_test");
    183         if (!test_group)
    184                 goto out;
    185 
    186         /* Spawn memcg child and wait for it to allocate */
    187         set_min_free_kb(min_free_kb_low);
    188         if (cg_create(test_group))

test_group is allocated but not created.  Is it okay to call
destroy on this path?

    189                 goto out;
    190         values->child_allocated = false;
    191         child_pid = cg_run_nowait(test_group, no_kmem_bypass_child, values);
    192         if (child_pid < 0)
    193                 goto out;
    194         while (!values->child_allocated && wait_child_iteration++ < 10000)
    195                 usleep(1000);
    196 
    197         /* Try to wakeup kswapd and let it push child memory to zswap */
    198         set_min_free_kb(min_free_kb_high);
    199         for (int i = 0; i < 20; i++) {
    200                 size_t stored_pages;
    201                 char *trigger_allocation = malloc(trigger_allocation_size);
    202 
    203                 if (!trigger_allocation)
    204                         break;
    205                 for (int i = 0; i < trigger_allocation_size; i += 4095)
    206                         trigger_allocation[i] = 'b';
    207                 usleep(100000);
    208                 free(trigger_allocation);
    209                 if (get_zswap_stored_pages(&stored_pages))
    210                         break;
    211                 if (stored_pages < 0)
    212                         break;
    213                 /* If memory was pushed to zswap, verify it belongs to memcg */
    214                 if (stored_pages > stored_pages_threshold) {
    215                         int zswapped = cg_read_key_long(test_group, "memory.stat", "zswapped ");
    216                         int delta = stored_pages * 4096 - zswapped;
    217                         int result_ok = delta < stored_pages * 4096 / 4;
    218 
    219                         ret = result_ok ? KSFT_PASS : KSFT_FAIL;
    220                         break;
    221                 }
    222         }
    223 
    224         kill(child_pid, SIGTERM);
    225         waitpid(child_pid, &child_status, 0);
    226 out:
    227         set_min_free_kb(min_free_kb_original);
--> 228         cg_destroy(test_group);
    229         free(test_group);
    230         return ret;
    231 }

regards,
dan carpenter
