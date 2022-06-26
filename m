Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5587255AE5A
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jun 2022 05:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbiFZC4t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Jun 2022 22:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbiFZC4t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Jun 2022 22:56:49 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D2913E97;
        Sat, 25 Jun 2022 19:56:48 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id m2so5359828plx.3;
        Sat, 25 Jun 2022 19:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UaUCLQ3nS9Up5cEY9+LaU4BO2fMeHRxRDTuwdcMT7iw=;
        b=BOCsaX3+zhpo2CXDBCzzEiUhtT+fYHh1eGWUiqX1eEsWXMJCFUvDKc8O7dtm1l13nf
         ubPWwBB8gvFggWiyBbMTZEFchmLyd6htqDjNtboFxjdAfclcNHbpDDR3LmPm/gGXVf+8
         a0x18BM5eblWWrRHW/7eTsl9d4VZc/esaKp9vJtSJYgJ23oFiljjDqPplzVlXw9My6t+
         9NxLyh2LdLGd90cGOEPEfRxSasd68jPQI0kgkPy7gTPf4d8FawV4ZFtp4Yu9bBUdiv7v
         Ynwky+HReFT6nnoLaqSLjhPBZ1s9eGODeOhpSMEN8OyqXaq3By4ah7cGqjYeQRXR72SZ
         uQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UaUCLQ3nS9Up5cEY9+LaU4BO2fMeHRxRDTuwdcMT7iw=;
        b=uAj+otElGE7orEKk9ZURtsROGLa3xPzrRZaqsG6wIeWEUh8WQUALC3zGfNtcezsEtn
         UNMORADlqVsk2anq0k0GEMn5g32Fzs1psoRmURNxfHtVuOpjsD9m/xODoQDGrfYUiRpB
         T5Bildwm2hTrIsDNOmSGuz4CCRyuLxMy57JuWyScxH9k/ylWbXNu8kYuLLnfFA00WFZy
         DuhOxUXHEKVBbPZtPhrA0DfX9kMIcyTjpgEPLoDj+8r0DXMjKE6pZcL2rG+6f/Ttw1RC
         CdPGEdD/SCX4Dw9WaUFzmFQ4960ZGi5k+xV5acwlFinG/l31COyIytOeW1Zb0evyP4yW
         e89g==
X-Gm-Message-State: AJIora/fOarKyyWsuLRRj/cVxL2SDSARViWAdyuxRhffT6Dclgfe4Lh7
        jIb68Mt9ri3d5YSTiMvSmFc=
X-Google-Smtp-Source: AGRyM1vV0I+gt2YVOXOLuC5ALl5F1MzWlDWKcH3JQRha2Ba68tRONGAQ+IeO4Y1UK74foUZpplN6+Q==
X-Received: by 2002:a17:90b:1c01:b0:1ed:4b98:2499 with SMTP id oc1-20020a17090b1c0100b001ed4b982499mr4235711pjb.90.1656212207394;
        Sat, 25 Jun 2022 19:56:47 -0700 (PDT)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id d15-20020a056a0024cf00b005258df7615bsm1607061pfv.0.2022.06.25.19.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 19:56:46 -0700 (PDT)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net,
        chensong_2000@189.cn, Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH v13 0/4] trace: Introduce objtrace trigger to trace the kernel object
Date:   Sun, 26 Jun 2022 10:56:00 +0800
Message-Id: <20220626025604.277413-1-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce a method based on function tracer to trace any object and get
the value of the object dynamically. the object can be obtained from the
dynamic event (kprobe_event/uprobe_event) or the static event(tracepoint).

Usage:
When using the kprobe event, only need to set the objtrace(a new trigger),
we can get the value of the object. The object is from the setting of the 
kprobe event.

For example:
For the function bio_add_page():

int bio_add_page(struct bio *bio, struct page *page,
	unsigned int len, unsigned int offset)

Firstly, we can set the base of the object, thus the first string "arg1"
stands for the value of the first parameter of this function bio_add_gage(),

# echo 'p bio_add_page arg1=$arg1' > ./kprobe_events

Secondly, we can get the value dynamically based on above object. 

find the offset of the bi_size in struct bio:
$ gdb vmlinux
(gdb) p &(((struct bio *)0)->bi_iter.bi_size)
$1 = (unsigned int *) 0x28

# echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
	p_bio_add_page_0/trigger

# cd /sys/kernel/debug/tracing/
# echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
# echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger

# du -sh /test.txt
12.0K   /test.txt

# cat  /test.txt > /dev/null
# cat ./trace
# tracer: nop
#
# entries-in-buffer/entries-written: 128/128   #P:4
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
             cat-117     [002] ...1.     1.602243: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x0
             cat-117     [002] ...1.     1.602244: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x0
             cat-117     [002] ...2.     1.602244: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x1000
             cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
             cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
             cat-117     [002] ...2.     1.602245: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x2000
             cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
             cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
             cat-117     [002] ...1.     1.602245: submit_bio <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
             cat-117     [002] ...1.     1.602245: submit_bio_noacct <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
             cat-117     [002] ...1.     1.602246: __submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
             cat-117     [002] ...1.     1.602246: submit_bio_checks <-__submit_bio object:0xffff88811bee4000 value:0x3000
             cat-117     [002] ...1.     1.602246: __cond_resched <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
             cat-117     [002] ...1.     1.602246: should_fail_bio <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
             cat-117     [002] ...1.     1.602246: blk_mq_submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
             cat-117     [002] ...1.     1.602246: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
             cat-117     [002] ...1.     1.602246: blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
             cat-117     [002] ...1.     1.602247: __rcu_read_lock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
             cat-117     [002] ...1.     1.602247: __rcu_read_unlock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
             cat-117     [002] ...1.     1.602247: __blk_mq_alloc_requests <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
          <idle>-0       [002] d..3.     1.602298: bio_endio <-blk_update_request object:0xffff88811bee4000 value:0x0
          <idle>-0       [002] d..3.     1.602298: mpage_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
          <idle>-0       [002] d..3.     1.602298: __read_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
          <idle>-0       [002] d..3.     1.602300: bio_put <-blk_update_request object:0xffff88811bee4000 value:0x0
          <idle>-0       [002] d..3.     1.602300: bio_free <-blk_update_request object:0xffff88811bee4000 value:0x0
          <idle>-0       [002] d..3.     1.602300: mempool_free <-blk_update_request object:0xffff88811bee4000 value:0x0
          <idle>-0       [002] d..3.     1.602300: mempool_free_slab <-blk_update_request object:0xffff88811bee4000 value:0x0
          <idle>-0       [002] d..3.     1.602300: kmem_cache_free <-blk_update_request object:0xffff88811bee4000 value:0x0
	  ...

Almost all changelogs were suggested by Masami(mhiramat@kernel.org)
and steve(rostedt@goodmis.org), thank you all so much.

v13:
- remove the 's' type, since the objtrace event doesn't show the value with sign
- change the [3/4] tag with 'selftests/ftrace' instead of 'trace/objtrace'
- add 'Documentation:' tag for [4/4]

v12:
- use the %zu to print the sizeof
  Reported-by: kernel test robot <lkp@intel.com>
  Suggested-by: Nathan Chancellor <nathan@kernel.org>

v11:
- remove useless atomic counting methods for num_traced_obj
- make array objtrace_fetch_types null terminated
- add raw_spin_lock_init for obj_data_lock

v10:
- support ftrace instances
- use trace_buffer_lock_reserve instead of trace_event_buffer_lock_reserve
- a lot of cleanup work has been done mainly for event_object_trigger_parse

v9:
- fix objtrace trigger output was incomplete
- fix the objtrace trigger was removed when using the existed parameter on
  event.
- add testcase for the second fix above.

v8:
- revert to use per-cpu recursion for the function trace_object_events_call
- recover the filter when getting the value of the object
- simplify the implementation for the function get_object_value
- fix the build error

v7:
- use fixed-size array for object pool instead of list structure
- use ftrace_test_recursion_trylock for function trace hook function
- fix trace_object_ref reference count in the init_trace_object
- invoke exit_trace_object no matter whether data->ops->free is null 
  in the unregister_object_trigger
- release private_data of event_trigger_data in the trace_object_trigger_free
- remove [RFC] tag

v6:
- change the objtrace trigger syntax.
- add patchset description
- add <tracefs>/README

v5:
- add testcasts
- add check the field->size
- add lockless to search object
- describe the object trace more clearly in Kconfig

v4:
- please ignore the v4 which is the same as v3

v3:
- change the objfilter to objtrace
- add a command to the objfilter syntax
- change to get the value of the object
- use trace_find_event_field to find the field instead of using argN
- get data from @rec in the event trigger callback funciton

v2:
- adding a "objfilter" trigger to update object

Jeff Xie (4):
  trace: Add trace any kernel object
  trace/objtrace: Get the value of the object
  selftests/ftrace: Add testcases for objtrace
  Documentation: trace/objtrace: Add documentation for objtrace

 Documentation/trace/events.rst                |  83 +++
 include/linux/trace_events.h                  |   1 +
 kernel/trace/Kconfig                          |  10 +
 kernel/trace/Makefile                         |   1 +
 kernel/trace/trace.c                          |  11 +
 kernel/trace/trace.h                          |  21 +
 kernel/trace/trace_entries.h                  |  18 +
 kernel/trace/trace_events_trigger.c           |   5 +-
 kernel/trace/trace_object.c                   | 611 ++++++++++++++++++
 kernel/trace/trace_output.c                   |  40 ++
 .../ftrace/test.d/trigger/trigger-objtrace.tc |  41 ++
 11 files changed, 840 insertions(+), 2 deletions(-)
 create mode 100644 kernel/trace/trace_object.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-objtrace.tc


base-commit: 408d26e261b089596c0837e71d2fb4a80ea04ef3
-- 
2.25.1

